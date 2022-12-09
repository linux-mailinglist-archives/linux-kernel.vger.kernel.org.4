Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB846481EE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 12:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiLILqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 06:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLILqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 06:46:31 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC466B98F;
        Fri,  9 Dec 2022 03:46:30 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id p36so6592561lfa.12;
        Fri, 09 Dec 2022 03:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BCE2CJXJ//Bhi3WHVvWunVUzVRxTKiJl8yn0gejQh+A=;
        b=CI+w2qobo9rbG0YF7JCVw1JfKqMQ15T3oW5PuUEOIbq+rK3GUyMjphlkbXAjulb60X
         dYy8IvDvs4Bk2qqfVBxRC16+K6xlko3+8jLPX16PJ5iTUGHzbNy2SohP+7cfigiaa+m5
         efJrAv6MtWbZFWAhSEvv1iqOc18PSUqXDRIvDE+QaY0CUDVGBKylea9AdfYCFvJQ+dSG
         bmpcnaxm0xN6iSEX9x7xPF5Osh69Btvn16ihgPp3eWfU7/MvAURbd/o3FLerVrzJLJ6O
         8zBJ4nfDI5/fmO98s9uD8i8lRY7jFxmBHgfa25H2cN1cHYvyJlQjgxpzMHcTOp2dPb+C
         Fb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCE2CJXJ//Bhi3WHVvWunVUzVRxTKiJl8yn0gejQh+A=;
        b=qgRHCTq98xCe+w4Vm4h+UpKustyAsKE8SXlRu4ipz0g9/XhU2pD5/Rnwzh3H9UXKMb
         oLXvYocDGpfrjUUJ7kfu0u0PZDOQqNErn2yQJNXwHzsHeK6hK5K7ezntv6VaXQ/iow42
         /EQ6tC7cyGteYjKTxaGbOyirU5ZCTnfhL2MNVyDl2++zJkkL80iQruQnThGgW3V58XtP
         k+2BnPB8aMSuSOtu1PiDm944kSp+ETdn9BLx9LVJx/J/MKQEs9SZpmUTsVrhnSsIG+sW
         g7j6iaLD1+4PriV+Ye7BM/q8HONr4CgVts6lPrCL0IM+ij3F5A6tVioOhjwi6UA9J7az
         vCCg==
X-Gm-Message-State: ANoB5pnXcr7hz/O+m1Sjq0HhisG8WsANjYO1qYhRIBUQfSVedi4ufDlg
        al1CbEUQFz3l7xSFQFEoHK7KNMpNB/E=
X-Google-Smtp-Source: AA0mqf5N3XtmU7KG34z5ptj3fbp4YOmyPSIEOK9kZQ1fnyd2n0eAlSa64Ogt/Ie4u48GYWAzQ53IAQ==
X-Received: by 2002:a05:6512:3092:b0:4b4:e4a3:4a23 with SMTP id z18-20020a056512309200b004b4e4a34a23mr2278630lfd.20.1670586388212;
        Fri, 09 Dec 2022 03:46:28 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id 12-20020ac25f0c000000b0049ad2619becsm226905lfq.131.2022.12.09.03.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 03:46:27 -0800 (PST)
Date:   Fri, 9 Dec 2022 14:46:25 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Edmund Berenson <edmund.berenson@emlix.com>
Cc:     Lukasz Zemla <Lukasz.Zemla@woodward.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] spi: dw: select SS0 when gpio cs is used
Message-ID: <20221209114625.32ww2laxfr72uqnb@mobilestation>
References: <20221202094859.7869-1-edmund.berenson@emlix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202094859.7869-1-edmund.berenson@emlix.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Edmund

On Fri, Dec 02, 2022 at 10:48:59AM +0100, Edmund Berenson wrote:
> SER register contains only 4-bit bit-field for enabling 4 SPI chip selects.
> If gpio cs are used the cs number may be >= 4. To ensure we do not write
> outside of the valid area, we choose SS0 in case of gpio cs to start
> spi transfer.

Next time please don't forget to add me to the whole series Cc-list. I
am missing the patch #2 in my inbox.

> 
> Co-developed-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
> Signed-off-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
> Signed-off-by: Edmund Berenson <edmund.berenson@emlix.com>
> ---
>  drivers/spi/spi-dw-core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index 99edddf9958b..57c9e384d6d4 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -94,6 +94,10 @@ void dw_spi_set_cs(struct spi_device *spi, bool enable)
>  {
>  	struct dw_spi *dws = spi_controller_get_devdata(spi->controller);
>  	bool cs_high = !!(spi->mode & SPI_CS_HIGH);
> +	u8 enable_cs = 0;
> +
> +	if (!spi->cs_gpiod)
> +		enable_cs = spi->chip_select;
>  
>  	/*
>  	 * DW SPI controller demands any native CS being set in order to
> @@ -103,7 +107,7 @@ void dw_spi_set_cs(struct spi_device *spi, bool enable)
>  	 * support active-high or active-low CS level.
>  	 */
>  	if (cs_high == enable)

> -		dw_writel(dws, DW_SPI_SER, BIT(spi->chip_select));
> +		dw_writel(dws, DW_SPI_SER, BIT(enable_cs));

No, it's not that easy. By applying this patch we'll get a regression
for the platforms which make use of both the GPIO-based and native
chip-selects. Consider the next platform setup:
 +--------------+
 | SoC X        |
 |              |    +-------------+
 |   DW SSI CS0-+----+ SPI-slave 0 |
 |              |    +-------------+
 |              |    +-------------+
 |        GPIOn-+----+ SPI-slave 1 |
 |              |    +-------------+
 +--------------+

If we apply this patch then the communications targeted to the
SPI-slave 1 will also reach the SPI-slave 0 device, which isn't what
we'd want.

That's why currently the DW SSI driver activates the native CS line
with the corresponding ID irrespective whether it is a GPIO-based
CS or a native one.

-Serge(y)

>  	else
>  		dw_writel(dws, DW_SPI_SER, 0);
>  }
> -- 
> 2.37.4
> 
