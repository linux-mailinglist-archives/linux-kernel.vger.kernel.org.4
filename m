Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0776F3234
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 16:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjEAOlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 10:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbjEAOlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 10:41:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFE797;
        Mon,  1 May 2023 07:41:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB20760A4B;
        Mon,  1 May 2023 14:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD1AC4339C;
        Mon,  1 May 2023 14:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682952061;
        bh=II96033K2OvsJfg6xZbEKR4CP+yge9pQUJpGu7RIYTM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MVSOKMkSr0HyJ2pQUdTklZ5WKpNFSK7m10EdN1yXA89uHepIap2tV5CLxxsWCiEon
         DdeDzbfUnRtA8OFQ44UjCIQuKUwT9QOhqJvgqScCfL2hBHTiDX8Ha3ObvVtS95eQpU
         ib2solvE5dCGZH5D5/9VtzeYSFbFGIrfj9V9gQxxMHzU7JIYkEYXyrnJ1oCxE6cep4
         2W1jHjFcF+p5e/Vwd0TsiR5EeH5y9LsYkEnnL73CvkHIcLDW+n0uQMKBuHmZDm8kWy
         5tnuZb32Lfe6eFJFIIc7+MNDzgkdv8XIcbCowPYGN2RUDnf6/gmE+isTPw0no9TTbD
         ViKymV+RBXWow==
Date:   Mon, 1 May 2023 15:56:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     mazziesaccount@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 7/7] iio: accel: Add support for Kionix/ROHM
 KX132-1211 accelerometer
Message-ID: <20230501155645.435242f0@jic23-huawei>
In-Reply-To: <593798a44c8ba45f969b86aa29e172d59065958c.1682373451.git.mehdi.djait.k@gmail.com>
References: <cover.1682373451.git.mehdi.djait.k@gmail.com>
        <593798a44c8ba45f969b86aa29e172d59065958c.1682373451.git.mehdi.djait.k@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2023 00:22:27 +0200
Mehdi Djait <mehdi.djait.k@gmail.com> wrote:

> Kionix KX132-1211 is a tri-axis 16-bit accelerometer that can support
> ranges from =C2=B12G to =C2=B116G, digital output through I=C2=B2C/SPI.
> Add support for basic accelerometer features such as reading acceleration
> via IIO using raw reads, triggered buffer (data-ready), or the WMI IRQ.
>=20
> Datasheet: https://kionixfs.azureedge.net/en/document/KX132-1211-Technica=
l-Reference-Manual-Rev-5.0.pdf
> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>

Two tiny things inline. =20

> +static int kx132_get_fifo_bytes(struct kx022a_data *data)
> +{
> +	struct device *dev =3D regmap_get_device(data->regmap);
> +	__le16 buf_status;
> +	int ret, fifo_bytes;
> +
> +	ret =3D regmap_bulk_read(data->regmap, data->chip_info->buf_status1,
> +			       &buf_status, sizeof(buf_status));
> +	if (ret) {
> +		dev_err(dev, "Error reading buffer status\n");
> +		return ret;
> +	}
> +
> +	fifo_bytes =3D le16_to_cpu(buf_status);
> +	fifo_bytes &=3D data->chip_info->buf_smp_lvl_mask;

Slight preference for FIELD_GET() as it saves me checking the mask includes
lowest bits.


> +
> +	return fifo_bytes;
> +}
> +
>  static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int sample=
s,
>  			       bool irq)
>  {
> @@ -1036,6 +1157,32 @@ const struct kx022a_chip_info kx022a_chip_info =3D=
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

There are some things in here (typically where the define isn't used
anywhere else) where I think it would be easier to follow if the
value was listed here.  Masks and IDs for example.=20

> +	.buf_read	  =3D KX132_REG_BUF_READ,
> +	.inc1		  =3D KX132_REG_INC1,
> +	.inc4		  =3D KX132_REG_INC4,
> +	.inc5		  =3D KX132_REG_INC5,
> +	.inc6		  =3D KX132_REG_INC6,
> +	.xout_l		  =3D KX132_REG_XOUT_L,
> +	.get_fifo_bytes	  =3D kx132_get_fifo_bytes,
> +};
> +EXPORT_SYMBOL_NS_GPL(kx132_chip_info, IIO_KX022A);
> +
>  int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_i=
nfo *chip_info)
>  {
>  	static const char * const regulator_names[] =3D {"io-vdd", "vdd"};

