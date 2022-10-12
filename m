Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD0E5FCD18
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 23:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiJLVYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 17:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiJLVYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 17:24:09 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5083511B2E0;
        Wed, 12 Oct 2022 14:24:08 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bj12so40559752ejb.13;
        Wed, 12 Oct 2022 14:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeJANbhYyBwy4ZbmnuIiUtzQb03C3ow/09NmLLrUl6A=;
        b=JPL4aQt1cmlonH9wzqkdGwGX4yiWzBYuoNUgmryEg9d/JOfQlDrmkcICVOC/33yqcl
         s0mTrzMYEWAgpf0uUa7YeZFD7CZ68ey2ehAGfeag4Z2kxjakghVUyBtUToFJmxKe+1wG
         yJTCP2EuO/e6a8snlf+yd6pfpqoYRtMGSRyL3dmp7H0rzxos9JYoRmle2O3h9lHUA/DC
         +K7hxS8Pn4f3tUSLLAPFIUxmVCpr/sSqr25uP6x3TlKVAwyzLB+POxUi2ZY8CECqmyKi
         2HKXnaZIbOLLDoX2ntROXy4GRbnHUyek0QBvzOilU9uZ2dpSccEDOhCzPMmlsvSxPiLM
         9ysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AeJANbhYyBwy4ZbmnuIiUtzQb03C3ow/09NmLLrUl6A=;
        b=cQ+oeY59uFcasnwQqvaqCJ70js7BjIaFm4a3oYmqVN5DPfgtfaq4tpRzXUwx1tsHN7
         8jeW0DRFUN5SA/cYcatesoBozozuRWGI9TJmfifr9LfQ5kvdIfbGUmsSFvk5IJ20MIGD
         1QT8xSbLZ4lIEI5jnjtp1sB3qXA6KXyse0Zm16aIjqw8woP5PJ1qVfcLRb7+H8Eixog+
         GWSidv+zSYpWMHMb8sTx7rWf4CJaDxuIeasdbqoHlKP57GRkKAw6fkvcw9drmV4KtqQC
         t/uMfY6AgY3tcjD2fWeuujAkL63Cd+u1/e51KYFV+W6aoI3e2W+00io3X7Jwb5apr8L1
         ToJQ==
X-Gm-Message-State: ACrzQf0CQCAVBnrk5XsTmU20rRnDQ02nD32Ad5C05XDYGX/cAFu9wlWB
        m4/qGVliPVXkUroMrGQRsv8=
X-Google-Smtp-Source: AMsMyM7BxsquvcB3WVD34NXGQwFZsJW43aw77Eq7EcPTf+1OXMK4gIIlb5g5xCn3wdhAQzLGAw7V7w==
X-Received: by 2002:a17:907:8688:b0:78b:eaa5:8a9d with SMTP id qa8-20020a170907868800b0078beaa58a9dmr24591147ejc.509.1665609846821;
        Wed, 12 Oct 2022 14:24:06 -0700 (PDT)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id kw24-20020a170907771800b0073d87068042sm1807772ejc.110.2022.10.12.14.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 14:24:06 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Icenowy Zheng <uwu@icenowy.me>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>
Subject: Re: [PATCH v2 05/10] musb: sunxi: add support for the F1C100s MUSB controller
Date:   Wed, 12 Oct 2022 23:24:04 +0200
Message-ID: <3515217.R56niFO833@kista>
In-Reply-To: <20221012055602.1544944-6-uwu@icenowy.me>
References: <20221012055602.1544944-1-uwu@icenowy.me> <20221012055602.1544944-6-uwu@icenowy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Icenowy,

Dne sreda, 12. oktober 2022 ob 07:55:57 CEST je Icenowy Zheng napisal(a):
> The suniv SoC has a MUSB controller like the one in A33, but with a SRAM
> region to be claimed.
> 
> Add support for it.
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
> No changes since v1.
> 
>  drivers/usb/musb/sunxi.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
> index 7f9a999cd5ff..4b368d16a73a 100644
> --- a/drivers/usb/musb/sunxi.c
> +++ b/drivers/usb/musb/sunxi.c
> @@ -722,14 +722,17 @@ static int sunxi_musb_probe(struct platform_device
> *pdev) INIT_WORK(&glue->work, sunxi_musb_work);
>  	glue->host_nb.notifier_call = sunxi_musb_host_notifier;
> 
> -	if (of_device_is_compatible(np, "allwinner,sun4i-a10-musb"))
> +	if (of_device_is_compatible(np, "allwinner,sun4i-a10-musb") ||
> +	    of_device_is_compatible(np, "allwinner,suniv-f1c100s-musb")) {
>  		set_bit(SUNXI_MUSB_FL_HAS_SRAM, &glue->flags);
> +	}
> 
>  	if (of_device_is_compatible(np, "allwinner,sun6i-a31-musb"))
>  		set_bit(SUNXI_MUSB_FL_HAS_RESET, &glue->flags);
> 
>  	if (of_device_is_compatible(np, "allwinner,sun8i-a33-musb") ||
> -	    of_device_is_compatible(np, "allwinner,sun8i-h3-musb")) {
> +	    of_device_is_compatible(np, "allwinner,sun8i-h3-musb") ||
> +	    of_device_is_compatible(np, "allwinner,suniv-f1c100s-musb")) {

All that should be eventually converted to quirks. But for now:
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>  		set_bit(SUNXI_MUSB_FL_HAS_RESET, &glue->flags);
>  		set_bit(SUNXI_MUSB_FL_NO_CONFIGDATA, &glue->flags);
>  	}
> @@ -815,6 +818,7 @@ static const struct of_device_id sunxi_musb_match[] = {
>  	{ .compatible = "allwinner,sun6i-a31-musb", },
>  	{ .compatible = "allwinner,sun8i-a33-musb", },
>  	{ .compatible = "allwinner,sun8i-h3-musb", },
> +	{ .compatible = "allwinner,suniv-f1c100s-musb", },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, sunxi_musb_match);
> --
> 2.37.1


