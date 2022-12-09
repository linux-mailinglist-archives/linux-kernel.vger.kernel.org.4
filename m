Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CD8648221
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 13:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiLIMD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 07:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiLIMDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 07:03:17 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A261727904;
        Fri,  9 Dec 2022 04:03:15 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id a7so4684509ljq.12;
        Fri, 09 Dec 2022 04:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rmcbVnXwpY6XIxdrJ2zQuJVv4zvDXU+WCUuoNxUhbvM=;
        b=As/9/gVp2qljM7aIJTCiuGFLIiDSw5Qr1VlsX/Kmiq7vYFhF1ZA/sTYymwOK8HVHPN
         tmIxDRd9Wd8rNDRZF1EWA4ed6TEHuljpbaKQVjs4Gk7flnE521z1aDOL/5xot80QnQV1
         qtPq8cFmGV33Ja2WaFlDCnCCxpXvanMLNM9kPdAzRARCg1oHS56oqKhLimyf1PKCvTxt
         BUYF1rMx7HAwQiSLuMVlTwEYjXvu48xlRzONnv9cGUZD7M2R5+zmm+pKLoDfIWKAe+JZ
         SB81DWR5hII2m5Wi9nr+gFopdBKUVUbKVWeHt+jLifXVtk5O9+814JwtcXkOrL7pKbRU
         Z6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmcbVnXwpY6XIxdrJ2zQuJVv4zvDXU+WCUuoNxUhbvM=;
        b=e/MpzdHKSmO7HHga7441fvgRvp4NiWCjR/Cn0oZKqRtBCEh50JGE50bQSrGCZm71vY
         QCzPBkIdpDAaojrmiJIzmEyThisEn03yRHLAsyJ4fDZojZzK970pF9aOFUsPbkwXIoMX
         gTklVNhXm0pE7J7OIX6R9gyLFUwhy/Ocu3AZqzg6fm9RHZ0INRDPF6+cI3NLmpx6jluV
         /m3fJKBZCtylkPN9TBQ31MYi2F4EU7yfZoqUqOnmDHuMX2NzK6/1OJnGu3tCOpKTl4jl
         f6NNWqEJjZWlOmapLLmRPunxc9NX3+YcjwBoFOB5gI5vNkicJtxLXXO7AcgbLhx+/Vcc
         qORw==
X-Gm-Message-State: ANoB5plR+XLHS8ichYNEoC03NnQ8/HFmGXJrxUcuYsaCFZodHys6POBR
        rJAqj24ewg3nah+9/k5lRMc=
X-Google-Smtp-Source: AA0mqf4jkCiwkUjA75+pZvcOGhxPUS3vX4Dh1g5Li9jvBDwQL0rQKiYr8hSfPqWirJTy0H3AHsdMEA==
X-Received: by 2002:a2e:a594:0:b0:277:249:c1e9 with SMTP id m20-20020a2ea594000000b002770249c1e9mr1810142ljp.20.1670587393832;
        Fri, 09 Dec 2022 04:03:13 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id p11-20020a2ea40b000000b002797ea7c983sm185414ljn.105.2022.12.09.04.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 04:03:13 -0800 (PST)
Date:   Fri, 9 Dec 2022 15:03:11 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Edmund Berenson <edmund.berenson@emlix.com>
Cc:     Lukasz Zemla <Lukasz.Zemla@woodward.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] spi: dw: Write chip configuration before cs is set
Message-ID: <20221209120311.g6rmvgzykas7ieh7@mobilestation>
References: <20221202094934.9420-1-edmund.berenson@emlix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202094934.9420-1-edmund.berenson@emlix.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 10:49:34AM +0100, Edmund Berenson wrote:
> Using chips with different cpol, causes first communication
> to fail on cpol change.
> To avoid this issue write cr0 register before cs is set.

I need more details on the problem otherwise this patch seems more
like a hack than a fix. The dw_spi_update_config() method already
updates the mode before start to execute each SPI-transfer.  Basically
what you suggest here is the double CR0 register update before the
first transfer submission. This doesn't seem like a proper solution.
Moreover updating the device setting in the set_cs callback makes it
less coherent. So there must be a firm justification why the update is
supposed to be done in the dw_spi_set_cs method.

> 
> Suggested-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
> Signed-off-by: Edmund Berenson <edmund.berenson@emlix.com>
> ---
>  drivers/spi/spi-dw-core.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index 57c9e384d6d4..c3da4fe3e510 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -93,6 +93,7 @@ static inline void dw_spi_debugfs_remove(struct dw_spi *dws)
>  void dw_spi_set_cs(struct spi_device *spi, bool enable)
>  {
>  	struct dw_spi *dws = spi_controller_get_devdata(spi->controller);
> +	struct dw_spi_chip_data *chip = spi_get_ctldata(spi);
>  	bool cs_high = !!(spi->mode & SPI_CS_HIGH);
>  	u8 enable_cs = 0;
>  
> @@ -106,8 +107,13 @@ void dw_spi_set_cs(struct spi_device *spi, bool enable)
>  	 * Enable register no matter whether the SPI core is configured to
>  	 * support active-high or active-low CS level.
>  	 */
> -	if (cs_high == enable)
> +	if (cs_high == enable) {
> +		dw_spi_enable_chip(dws, 0);
> +		dw_writel(dws, DW_SPI_CTRLR0, chip->cr0);
> +		dw_spi_enable_chip(dws, 1);
> +
>  		dw_writel(dws, DW_SPI_SER, BIT(enable_cs));

> +	}
>  	else

Documentation/process/coding-style.rst: 3) Placing Braces and Spaces

-Sergey

>  		dw_writel(dws, DW_SPI_SER, 0);
>  }
> -- 
> 2.37.4
> 
