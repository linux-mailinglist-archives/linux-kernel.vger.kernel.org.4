Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B500713AA3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 18:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjE1Qmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 12:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjE1Qmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 12:42:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773A4AD;
        Sun, 28 May 2023 09:42:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 012DB61787;
        Sun, 28 May 2023 16:42:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD628C433D2;
        Sun, 28 May 2023 16:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685292170;
        bh=jCQNHbdQ4Cz8cuC1CEhZkxmhx+KQ0b9AeZ7vLEFBkR8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GDFHxeXvfJpRQTnaeWoOL5n7VPjVcz9HXrV26+n7awuZoUoJhC28TcA+r4gaAtr4Y
         Nmw4e88/3mc2FGny5mP8Gh9hUUp/kaBpdRtWkBxZ6kkXUEDZpzBgRL7X7NkMLfzFNh
         pU2nwCt5xm4iMydEFCn0HQy9IYbehDquwooqvskqSJ3L5PzvWRnTq30TAtIcUyV1Cy
         g5rqfVa5k3vx3mbECGX+7YqD83YDz8JIfpo/YxpNYpvKueG+lCGrrguBqu7Gebhvkv
         F7BugQosLXai5YZPS9pCJ7i9EqMUc0GYq9rNsT9vb+uS5gzPY/gnwVgf+8t+6cas+H
         Go0/XlBdcSOew==
Date:   Sun, 28 May 2023 17:59:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     mazziesaccount@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 7/7] iio: accel: Add support for Kionix/ROHM
 KX132-1211 accelerometer
Message-ID: <20230528175909.245d5bfc@jic23-huawei>
In-Reply-To: <d776c1dd5beef6ef812a4f7e4958eb6cb0f5e58e.1685111274.git.mehdi.djait.k@gmail.com>
References: <cover.1685111274.git.mehdi.djait.k@gmail.com>
        <d776c1dd5beef6ef812a4f7e4958eb6cb0f5e58e.1685111274.git.mehdi.djait.k@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 May 2023 16:30:48 +0200
Mehdi Djait <mehdi.djait.k@gmail.com> wrote:

> Kionix KX132-1211 is a tri-axis 16-bit accelerometer that can support
> ranges from =C2=B12G to =C2=B116G, digital output through I=C2=B2C/SPI.
> Add support for basic accelerometer features such as reading acceleration
> via IIO using raw reads, triggered buffer (data-ready), or the WMI IRQ.
>=20
> Datasheet: https://kionixfs.azureedge.net/en/document/KX132-1211-Technica=
l-Reference-Manual-Rev-5.0.pdf
> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>

Hi Mehdi,

Comment is a follow on from the earlier one about buf_smp_lvl_mask.

Jonathan

>  /*
>   * The sensor HW can support ODR up to 1600 Hz, which is beyond what mos=
t of the
>   * Linux CPUs can handle without dropping samples. Also, the low power m=
ode is
> @@ -613,6 +731,24 @@ static int kx022a_get_fifo_bytes(struct kx022a_data =
*data)
>  	return fifo_bytes;
>  }
> =20
> +static int kx132_get_fifo_bytes(struct kx022a_data *data)
> +{
> +	__le16 buf_status;
> +	int ret, fifo_bytes;
> +
> +	ret =3D regmap_bulk_read(data->regmap, data->chip_info->buf_status1,
> +			       &buf_status, sizeof(buf_status));
> +	if (ret) {
> +		dev_err(data->dev, "Error reading buffer status\n");
> +		return ret;
> +	}
> +
> +	fifo_bytes =3D le16_to_cpu(buf_status);
> +	fifo_bytes &=3D data->chip_info->buf_smp_lvl_mask;

See below.

> +
> +	return fifo_bytes;
> +}
> +
>  static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int sample=
s,
>  			       bool irq)
>  {
> @@ -1036,6 +1172,32 @@ const struct kx022a_chip_info kx022a_chip_info =3D=
 {
>  };
>  EXPORT_SYMBOL_NS_GPL(kx022a_chip_info, IIO_KX022A);
> =20
> +const struct kx022a_chip_info kx132_chip_info =3D {
> +	.name		  =3D "kx132-1211",
> +	.regmap_config	  =3D &kx132_regmap_config,
> +	.channels	  =3D kx132_channels,
> +	.num_channels	  =3D ARRAY_SIZE(kx132_channels),
> +	.fifo_length	  =3D KX132_FIFO_LENGTH,
> +	.who		  =3D KX132_REG_WHO,
> +	.id		  =3D KX132_ID,
> +	.cntl		  =3D KX132_REG_CNTL,
> +	.cntl2		  =3D KX132_REG_CNTL2,
> +	.odcntl		  =3D KX132_REG_ODCNTL,
> +	.buf_cntl1	  =3D KX132_REG_BUF_CNTL1,
> +	.buf_cntl2	  =3D KX132_REG_BUF_CNTL2,
> +	.buf_clear	  =3D KX132_REG_BUF_CLEAR,
> +	.buf_status1	  =3D KX132_REG_BUF_STATUS_1,
> +	.buf_smp_lvl_mask =3D KX132_MASK_BUF_SMP_LVL,
As per earlier comment I think this is only set for this device...
> +	.buf_read	  =3D KX132_REG_BUF_READ,
> +	.inc1		  =3D KX132_REG_INC1,
> +	.inc4		  =3D KX132_REG_INC4,
> +	.inc5		  =3D KX132_REG_INC5,
> +	.inc6		  =3D KX132_REG_INC6,
> +	.xout_l		  =3D KX132_REG_XOUT_L,
> +	.get_fifo_bytes	  =3D kx132_get_fifo_bytes,
and only used in this device specific callback.
Probably can just use it directly in the callback.
> +};
> +EXPORT_SYMBOL_NS_GPL(kx132_chip_info, IIO_KX022A);
> +

