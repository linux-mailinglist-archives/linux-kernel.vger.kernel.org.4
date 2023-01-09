Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F0F662BC6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236946AbjAIQx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237165AbjAIQx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:53:28 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EED3E0ED;
        Mon,  9 Jan 2023 08:52:48 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id y18so5948158ljk.11;
        Mon, 09 Jan 2023 08:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u/YojMvQCgjgpVq2imF+mNJMgcvG5QTIR+KQBSabztA=;
        b=jqxs8APtMoqxBAsze64sbZIiObnKM5mcG4m+PYHo9Wbt2szmZicijlw986fvLX7UkE
         DQlOhTnCQmlm8PysQ7YuhNW3enHFuvIXMuqQc2wGpdqTTRUSwTbgljcuVw5EzDrg/fac
         uE5PvAP0onnTZ869icDtYJJ+LTMH2ldRt3C/+ox+BC3YkA89uGFytSbSQIGwXvllIF7H
         dphJ84b03YY2on+6cGTLLr79cme31F1x5JeVdhFe9C5/t+lK1fREcV1LGlwfotUaCFM2
         kaTHASMEUyF3SjhapFRpPWDN04xUsz5Zvk8ZE2OnEd/WRdhVhgKOhsB3gavsOt6nnINZ
         mXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/YojMvQCgjgpVq2imF+mNJMgcvG5QTIR+KQBSabztA=;
        b=WL4PYEV86okLqtTkFSesWZQLJyKzreuKDhh3xSEJ/GxIDHprALgDgqnkRveoPoglCY
         GbBLuJsxS0Do0Z+Uh6BNDbuOaRGdDrb78Tl7Crrn57wuZLR6K+A3Z5Kh1hFQERVI7+ny
         RlPbafIwSUaPE6EImm8z++1Jq9V5x8WnVmp5PUDyIOXylYqyZQIH/e6E86bvchZyt9Nq
         ydgWiMD95BNxyr1TjG+1PYtsiXPqcG0t73EHgUi4bXDhJaQYAP7TU/OjncIzPiKCcOwK
         2RqmgJRjCRsL4pDgd+/gUou6SZLyGTvii8DPXy+bWG0Xx3uKheQjpBsRaipVCKW5ke5m
         J05w==
X-Gm-Message-State: AFqh2kpra9n+GhlHJims3vIAuyJ0PJp+EJdBNW6dyn6Ej10OeyjEROfh
        JJENSYybp2AuSBPr2Wx29nMv28BZF7Y=
X-Google-Smtp-Source: AMrXdXt2g86Ftt4VLNWExC41rbwR4hQ4PfQKbWrM9wlrZYFbpjO+p+wF87xKRk29liFbHWLrf8FrUQ==
X-Received: by 2002:a05:651c:1992:b0:27f:b2cf:85a0 with SMTP id bx18-20020a05651c199200b0027fb2cf85a0mr18909499ljb.43.1673283167180;
        Mon, 09 Jan 2023 08:52:47 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id s29-20020a05651c201d00b0028000e909desm973923ljo.136.2023.01.09.08.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 08:52:46 -0800 (PST)
Date:   Mon, 9 Jan 2023 19:52:44 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        jude.onyenegecha@sifive.com, ben.dooks@sifive.com,
        jeegar.lakhani@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/15] spi: dw: update NDF while using enhanced spi
 mode
Message-ID: <20230109165244.yck7ik26xb4zwtil@mobilestation>
References: <20221212180732.79167-1-sudip.mukherjee@sifive.com>
 <20221212180732.79167-3-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212180732.79167-3-sudip.mukherjee@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 06:07:19PM +0000, Sudip Mukherjee wrote:
> If the transfer of Transmit only mode is using dual/quad/octal SPI then
> NDF needs to be updated with the number of data frames.
> If the Transmit FIFO goes empty in-between, DWC_ssi masks the serial
> clock and wait for rest of the data until the programmed amount of
> frames are transferred successfully.
> 
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
> ---
>  drivers/spi/spi-dw-core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index 77c23772bb3d9..8c47a4d14b666 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -346,7 +346,9 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
>  	dw_writel(dws, DW_SPI_CTRLR0, cr0);
>  
>  	if (cfg->tmode == DW_SPI_CTRLR0_TMOD_EPROMREAD ||

> -	    cfg->tmode == DW_SPI_CTRLR0_TMOD_RO)
> +	    cfg->tmode == DW_SPI_CTRLR0_TMOD_RO ||
> +	    (cfg->tmode == DW_SPI_CTRLR0_TMOD_TO &&
> +	     cfg->spi_frf != DW_SPI_CTRLR0_SPI_FRF_STD_SPI))

First CTRLR1.NDF is meaningful for the Tx-only mode if non-zero eSPI
mode is enabled and the clock-stretching feature is activated. Second
the conditional statement already looks too bulky. Adding new parts
will make it even harder to read. What about converting it to
something like:

< if (cfg->ndf)
< 	dw_writel(dws, DW_SPI_CTRLR1, cfg->ndf - 1);

What do you think?

-Serge(y)

>  		dw_writel(dws, DW_SPI_CTRLR1, cfg->ndf ? cfg->ndf - 1 : 0);
>  
>  	/* Note DW APB SSI clock divider doesn't support odd numbers */
> -- 
> 2.30.2
> 
