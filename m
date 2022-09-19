Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC575BD6A2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 23:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiISVu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 17:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiISVuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 17:50:19 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF65043E64;
        Mon, 19 Sep 2022 14:50:17 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y136so914801pfb.3;
        Mon, 19 Sep 2022 14:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=kk7J0kbmWOo0ElCJGaFd9+RljsQo/irob0nXHRUh9g4=;
        b=S5nLy3TPw7ILmHNMx1jaAOARf0AyNjNd2mXDIfB0S9mQVlHCa1B+dQxa3QQxTRKljE
         5IcUAjXgPyr1AzCH2r11GZBERiGm71sfcw9M96NJGoY/D1N58ftnabjaqkEchNUZp1ax
         YkNWr2B3x73QVIgDhkjptcFT7pw/MUspxnNzPysC3de7CAbK4TIKnKkQkjmJT8OOGd6r
         ILp7s4AegZ/w0ZY7uOel1bPwlBMSKElixjKtA+6WS8TDEz0h0/N/wPu6VSTfopRAtF2R
         LreLT/NcoyAeAy8ZrMGP3FsOVaMh79HiCK8n4isvbC+afGgXaYSXSSVanVBYk0uI4uHX
         Pj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kk7J0kbmWOo0ElCJGaFd9+RljsQo/irob0nXHRUh9g4=;
        b=Y9vcvljuhNxon6dgGLLrHUlHtUogbhtdcm9EhtmGpj5BRTYiNy6Nf1R5X8geqtonww
         KsvrpXJ7zAPa8ASnQ7SoEtTn4KNZmvYuDd2kRn+rfSzrldWW2aK1vtClG6PZuwoV4A1k
         q8Iy9LgKwEJYmWc7qdZyp72qwQD8R/E43MdhXfzdmFUWPwff43P7JbvjWZdiRrYNXdiY
         x7OTGFs/f0erfnewDoJ7aAtqZ1MDq239SFyyXTYUOkvWl/ca/T3jKjwapYQ1ZAyH2FdL
         h4PcRhrzb5I8A329VQa7FQze/yjwZWjG9fZH6E6u8Mapac50k+yEz8oUKXX7854qAiQ0
         N2iw==
X-Gm-Message-State: ACrzQf3g1z7GULEmaElNtOgKQEwcKIynZGf4Hf7XqwX3Ng9LfaXt766v
        i5MSf9iaLg52H0N/lx3VSoY=
X-Google-Smtp-Source: AMsMyM6iftGnRzY+31jrAofx44FXCGKCcoJx9qjkQXDrx/KzZF6TV12z7StjR9+X2ADJmT4QVhfY6A==
X-Received: by 2002:aa7:8607:0:b0:53b:13b5:2b6a with SMTP id p7-20020aa78607000000b0053b13b52b6amr21041435pfn.52.1663624217009;
        Mon, 19 Sep 2022 14:50:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e11-20020a17090301cb00b00172a670607asm20560809plh.300.2022.09.19.14.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 14:50:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 19 Sep 2022 14:50:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v8 09/23] ata: libahci_platform: Parse ports-implemented
 property in resources getter
Message-ID: <20220919215014.GA336081@roeck-us.net>
References: <20220909193621.17380-1-Sergey.Semin@baikalelectronics.ru>
 <20220909193621.17380-10-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909193621.17380-10-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 10:36:07PM +0300, Serge Semin wrote:
> The ports-implemented property is mainly used on the OF-based platforms
> with no ports mapping initialized by a bootloader/BIOS firmware. Seeing
> the same of_property_read_u32()-based pattern has already been implemented
> in the generic AHCI LLDD (glue) driver and in the Mediatek, St AHCI
> drivers let's move the property read procedure to the generic
> ahci_platform_get_resources() method. Thus we'll have the forced ports
> mapping feature supported for each OF-based platform which requires that,
> and stop re-implementing the same pattern in there a bit simplifying the
> code.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  drivers/ata/ahci_mtk.c         | 2 --
>  drivers/ata/ahci_platform.c    | 3 ---
>  drivers/ata/ahci_st.c          | 3 ---
>  drivers/ata/libahci_platform.c | 3 +++
>  4 files changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ata/ahci_mtk.c b/drivers/ata/ahci_mtk.c
> index 1f6c85fde983..c056378e3e72 100644
> --- a/drivers/ata/ahci_mtk.c
> +++ b/drivers/ata/ahci_mtk.c
> @@ -118,8 +118,6 @@ static int mtk_ahci_parse_property(struct ahci_host_priv *hpriv,
>  				   SYS_CFG_SATA_EN);
>  	}
>  
> -	of_property_read_u32(np, "ports-implemented", &hpriv->force_port_map);
> -
>  	return 0;
>  }
>  
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index 28a8de5b48b9..9b56490ecbc3 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -56,9 +56,6 @@ static int ahci_probe(struct platform_device *pdev)
>  	if (rc)
>  		return rc;
>  
> -	of_property_read_u32(dev->of_node,
> -			     "ports-implemented", &hpriv->force_port_map);
> -
>  	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
>  		hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;
>  
> diff --git a/drivers/ata/ahci_st.c b/drivers/ata/ahci_st.c
> index 7526653c843b..068621099c00 100644
> --- a/drivers/ata/ahci_st.c
> +++ b/drivers/ata/ahci_st.c
> @@ -168,9 +168,6 @@ static int st_ahci_probe(struct platform_device *pdev)
>  
>  	st_ahci_configure_oob(hpriv->mmio);
>  
> -	of_property_read_u32(dev->of_node,
> -			     "ports-implemented", &hpriv->force_port_map);
> -

With arm:allmodconfig, this results in:

  CC [M]  drivers/ata/ahci_st.o
drivers/ata/ahci_st.c: In function 'st_ahci_probe':
drivers/ata/ahci_st.c:147:24: error: unused variable 'dev' [-Werror=unused-variable]
  147 |         struct device *dev = &pdev->dev;

Guenter
