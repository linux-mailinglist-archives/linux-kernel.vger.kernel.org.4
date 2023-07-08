Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F64174BDE3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 16:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjGHOi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 10:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHOi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 10:38:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFFB170F;
        Sat,  8 Jul 2023 07:38:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F22460D2C;
        Sat,  8 Jul 2023 14:38:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF64C433C7;
        Sat,  8 Jul 2023 14:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688827105;
        bh=XWxlI5TmtkDOdykcrm2vSLkqKX0/uwuEG7qMHC5LHVQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YrTNfNxx+pEM2dD6FcKlzopZZjIqwNV2RVFIBDhUTcJ8zHCHQPTtoV9ZN83o8qT4H
         mo5ezXhODtUVez1kM78/aNBEpPBqT3Rjv0uUvlvAkuTyUSP8iytcqnGpFcT5aTSA9O
         F+1gNNN9YLPnUpV6+268tOnQlv4WUY+uzUN8knSswYFUZgj+19s+Hvvii/CfBG45Ao
         2+S4IMrCpzXty2X/dYPnBGFNEhKoVMuowCcvfDSEnxV8MH/KJhlU688ua0gtufPpSh
         WQA+bThBhxywu8uzHyiEM7zZip1NRFQvrS1RKamsPuKOfs9k2cJgHE57WoOnzCw5ON
         SonNIKQNd7ugA==
Date:   Sat, 8 Jul 2023 15:38:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Leonard =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>
Cc:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>,
        kernel@pengutronix.de, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: adc: add buffering support to the TI LMP92064
 ADC driver
Message-ID: <20230708153819.0c1d349d@jic23-huawei>
In-Reply-To: <20230707063635.1496437-1-l.goehrs@pengutronix.de>
References: <20230707063635.1496437-1-l.goehrs@pengutronix.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Jul 2023 08:36:35 +0200
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

Applied, with a tweaked commit message (to put the driver name after the ii=
o: adc:
as the driver already exists).

Applied to the togreg branch of iio.git but as we are mid merge window, I'l=
l wait
until I can rebase on rc1. For now just pushed out as testing to see if 0-d=
ay
can find any issues that we missed.

Thanks,

Jonathan

> ---
> Changes v1->v2:
>=20
>   - Remove superfluous .shift =3D 0 initialization in scan_type.
>   - Replace kmalloc buffer allocation for every read with a stack
>     allocated structure.
>     A struct is used to ensure correct alignment of the timestamp field.
>     See e.g. adc/rockchip_saradc.c for other users of the same pattern.
>   - Use available_scan_masks and always push both voltage and current
>     measurements to the buffer.
>=20
> Changes v2->v3:
>=20
>   - Handle errors returned by lmp92064_read_meas() out-of-line via
>     a goto err;
>=20
> Changes v3->v4:
>=20
>   - 8-Byte align the 64 bit timestamp in the buffer structure
>     and memset() the stack-allocated buffer to prevent leaking
>     kernel memory to userspace. (Thanks to Nuno S=C3=A1)
> ---
>  drivers/iio/adc/ti-lmp92064.c | 53 +++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ti-lmp92064.c b/drivers/iio/adc/ti-lmp92064.c
> index c30ed824924f3..84ba5c4a0eea7 100644
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
> @@ -91,6 +94,12 @@ static const struct iio_chan_spec lmp92064_adc_channel=
s[] =3D {
>  		.address =3D TI_LMP92064_CHAN_INC,
>  		.info_mask_separate =3D
>  			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index =3D TI_LMP92064_CHAN_INC,
> +		.scan_type =3D {
> +			.sign =3D 'u',
> +			.realbits =3D 12,
> +			.storagebits =3D 16,
> +		},
>  		.datasheet_name =3D "INC",
>  	},
>  	{
> @@ -98,8 +107,20 @@ static const struct iio_chan_spec lmp92064_adc_channe=
ls[] =3D {
>  		.address =3D TI_LMP92064_CHAN_INV,
>  		.info_mask_separate =3D
>  			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index =3D TI_LMP92064_CHAN_INV,
> +		.scan_type =3D {
> +			.sign =3D 'u',
> +			.realbits =3D 12,
> +			.storagebits =3D 16,
> +		},
>  		.datasheet_name =3D "INV",
>  	},
> +	IIO_CHAN_SOFT_TIMESTAMP(2),
> +};
> +
> +static const unsigned long lmp92064_scan_masks[] =3D {
> +	BIT(TI_LMP92064_CHAN_INC) | BIT(TI_LMP92064_CHAN_INV),
> +	0
>  };
> =20
>  static int lmp92064_read_meas(struct lmp92064_adc_priv *priv, u16 *res)
> @@ -171,6 +192,32 @@ static int lmp92064_read_raw(struct iio_dev *indio_d=
ev,
>  	}
>  }
> =20
> +static irqreturn_t lmp92064_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf =3D p;
> +	struct iio_dev *indio_dev =3D pf->indio_dev;
> +	struct lmp92064_adc_priv *priv =3D iio_priv(indio_dev);
> +	struct {
> +		u16 values[2];
> +		int64_t timestamp __aligned(8);
> +	} data;
> +	int ret;
> +
> +	memset(&data, 0, sizeof(data));
> +
> +	ret =3D lmp92064_read_meas(priv, data.values);
> +	if (ret)
> +		goto err;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data,
> +					   iio_get_time_ns(indio_dev));
> +
> +err:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int lmp92064_reset(struct lmp92064_adc_priv *priv,
>  			  struct gpio_desc *gpio_reset)
>  {
> @@ -301,6 +348,12 @@ static int lmp92064_adc_probe(struct spi_device *spi)
>  	indio_dev->channels =3D lmp92064_adc_channels;
>  	indio_dev->num_channels =3D ARRAY_SIZE(lmp92064_adc_channels);
>  	indio_dev->info =3D &lmp92064_adc_info;
> +	indio_dev->available_scan_masks =3D lmp92064_scan_masks;
> +
> +	ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> +					      lmp92064_trigger_handler, NULL);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to setup buffered read\n");
> =20
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>=20
> base-commit: 6995e2de6891c724bfeb2db33d7b87775f913ad1

