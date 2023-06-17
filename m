Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31671734309
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 20:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346262AbjFQS1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 14:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjFQS1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 14:27:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA0C1999;
        Sat, 17 Jun 2023 11:27:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF20A61046;
        Sat, 17 Jun 2023 18:27:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32A5C433C0;
        Sat, 17 Jun 2023 18:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687026455;
        bh=90JukJGrlCr4SvlCWvf74JBJB6T1ikY1Pk9VUTnBiMw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CrZjhS/zGbsZhENk5tkD37NijSp5xkKJ1qaOGQg+bfqXKN2lmP7QP3p3/dJPFNiIt
         UsfbSAgIGnA7pZt0luIHvmhKkocBrBZPvE4TEsKGmrrUOUNhkk52g/IAKJBiAoHifo
         Yc7gFBXtGa+IyClarmweyIPJE5ZtutMsjDhXaTXNs3eb5te4+A/IoKisYw3r/rdsxt
         uCmchVcXlMbKff8vENkNuUfI5eC02WCz56h3Zt2iRoz9eEh2wNGietfjvDiFQUMV2t
         O65GqPodT6w0RKDRkvD8Sq8zB8rbemrnsr4ND5xjjyld748n3IThiEIUnuc6Yc236G
         YivujRyRtxKlg==
Date:   Sat, 17 Jun 2023 19:27:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Leonard =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>
Cc:     kernel@pengutronix.de, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] iio: adc: add buffering support to the TI LMP92064
 ADC driver
Message-ID: <20230617192729.4868d96f@jic23-huawei>
In-Reply-To: <20230614075537.3525194-1-l.goehrs@pengutronix.de>
References: <20230614075537.3525194-1-l.goehrs@pengutronix.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023 09:55:36 +0200
Leonard G=C3=B6hrs <l.goehrs@pengutronix.de> wrote:

> Enable buffered reading of samples from the LMP92064 ADC.
> The main benefit of this change is being able to read out current and
> voltage measurements in a single transfer, allowing instantaneous power
> measurements.
>=20
> Reads into the buffer can be triggered by any software triggers, e.g.
> the iio-trig-hrtimer:
>=20
>     $ mkdir /sys/kernel/config/iio/triggers/hrtimer/my-trigger
>     $ cat /sys/bus/iio/devices/iio\:device3/name
>     lmp92064
>     $ iio_readdev -t my-trigger -b 16 iio:device3 | hexdump
>     WARNING: High-speed mode not enabled
>     0000000 0000 0176 0101 0001 5507 abd5 7645 1768
>     0000010 0000 016d 0101 0001 ee1e ac6b 7645 1768
>     ...
>=20
> Signed-off-by: Leonard G=C3=B6hrs <l.goehrs@pengutronix.de>
> ---
>  drivers/iio/adc/ti-lmp92064.c | 54 +++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ti-lmp92064.c b/drivers/iio/adc/ti-lmp92064.c
> index c30ed824924f3..03765c4057dda 100644
> --- a/drivers/iio/adc/ti-lmp92064.c
> +++ b/drivers/iio/adc/ti-lmp92064.c
> @@ -16,7 +16,10 @@
>  #include <linux/spi/spi.h>
> =20
>  #include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/driver.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> =20
>  #define TI_LMP92064_REG_CONFIG_A 0x0000
>  #define TI_LMP92064_REG_CONFIG_B 0x0001
> @@ -91,6 +94,13 @@ static const struct iio_chan_spec lmp92064_adc_channel=
s[] =3D {
>  		.address =3D TI_LMP92064_CHAN_INC,
>  		.info_mask_separate =3D
>  			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index =3D 0,
> +		.scan_type =3D {
> +			.sign =3D 'u',
> +			.realbits =3D 12,
> +			.storagebits =3D 16,
> +			.shift =3D 0,

As zero is the 'obvious' default for shift (do nothing case) and c will set=
 it to 0 for
you anyway, no need to set it explicitly like this.

> +		},
>  		.datasheet_name =3D "INC",
>  	},
>  	{
> @@ -98,8 +108,16 @@ static const struct iio_chan_spec lmp92064_adc_channe=
ls[] =3D {
>  		.address =3D TI_LMP92064_CHAN_INV,
>  		.info_mask_separate =3D
>  			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index =3D 1,
> +		.scan_type =3D {
> +			.sign =3D 'u',
> +			.realbits =3D 12,
> +			.storagebits =3D 16,
> +			.shift =3D 0,

Same here. No need for this last line.

> +		},
>  		.datasheet_name =3D "INV",
>  	},
> +	IIO_CHAN_SOFT_TIMESTAMP(2),
>  };
> =20
>  static int lmp92064_read_meas(struct lmp92064_adc_priv *priv, u16 *res)
> @@ -171,6 +189,37 @@ static int lmp92064_read_raw(struct iio_dev *indio_d=
ev,
>  	}
>  }
> =20
> +static irqreturn_t lmp92064_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf =3D p;
> +	struct iio_dev *indio_dev =3D pf->indio_dev;
> +	struct lmp92064_adc_priv *priv =3D iio_priv(indio_dev);
> +	int i =3D 0, j, ret;
> +	u16 raw[2];
> +	u16 *data;
> +
> +	ret =3D lmp92064_read_meas(priv, raw);
> +	if (ret < 0)
> +		goto done;
> +
> +	data =3D kmalloc(indio_dev->scan_bytes, GFP_KERNEL);

A driver shouldn't be directly accessing scan_bytes.
You will see iio.h that it is marked [INTERN] to show it should only be acc=
essed
by the IIO core code.

The reasoning is closely related to Lars' point. This is almost always a sm=
all
structure with a known maximum size (across all possible channel configurat=
ions)
so allocate that space once not every scan (will be 16 bytes I think)


> +	if (!data)
> +		goto done;
> +
> +	for_each_set_bit(j, indio_dev->active_scan_mask, indio_dev->masklength)
> +		data[i++] =3D raw[j];
When a sensor 'always' reads the two channels, we can leave the necessary d=
ata
mangling up to the IIO core.

Provide available_scan_masks and then always push the lot every time.
Mostly people will want both channels anyway (as they paid for them ;)
so that core code that moves the data around will do nothing.  In the cases
where they only want one channel it will handle the complexity for you.

> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, data,
> +					   iio_get_time_ns(indio_dev));
> +
> +	kfree(data);
> +
> +done:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int lmp92064_reset(struct lmp92064_adc_priv *priv,
>  			  struct gpio_desc *gpio_reset)
>  {
> @@ -302,6 +351,11 @@ static int lmp92064_adc_probe(struct spi_device *spi)
>  	indio_dev->num_channels =3D ARRAY_SIZE(lmp92064_adc_channels);
>  	indio_dev->info =3D &lmp92064_adc_info;
> =20
> +	ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> +					      lmp92064_trigger_handler, NULL);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to setup buffered read\n");
> +
>  	return devm_iio_device_register(dev, indio_dev);
>  }
> =20
>=20
> base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7

