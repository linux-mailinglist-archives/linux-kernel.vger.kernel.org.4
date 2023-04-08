Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C586DBAC3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 14:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjDHMNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 08:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjDHMNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 08:13:05 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE315B8B;
        Sat,  8 Apr 2023 05:13:01 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id g17so2709088ejt.1;
        Sat, 08 Apr 2023 05:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680955979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fh1w6MZVvyVEsvytmtNdPF4PmTaTKXUM9E0VL+nzXOQ=;
        b=JU4P2piMvKh/GIkpuzP/xIQOOpn2ZnltJSPsX6ToqWYejNfSEHUMEQKkk2vxWQGqxu
         tkgCRmUgCOeXfcH4BM5JwHRqumBt3d0pmiOf2KtqOMYDBR9yE2jaAPWaetwNmD99cx22
         EX0jtsIAWeRKOnyFG4RMK7FsKSAq93I3V3U6vOrMoB/RDutlkjHOn6c4pL6tsUON8Nbj
         ier5+/rfjnH6s0UR7/G3T8RDb+Zrp0Ok1/bPgFik9dBl/OPTg8KVfrj1DXP4oE6TJrrH
         IzlKLM0oix3dFcesvzN8ljeA/JYXYEluRi9cIfdVcvZJN2yz7HpQiUu7wqtTQDozctY7
         soDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680955979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fh1w6MZVvyVEsvytmtNdPF4PmTaTKXUM9E0VL+nzXOQ=;
        b=ThbKtIjNr0IEdms7vJL4HyRLmOT9///3vlM4w6qLasySEzonK7Y7OYL6VY9QrLEMcP
         JzakH816ZUHiUGsMxcNFFUDUCMvmBcRDmZF6tBS9Ob4dfhro41zpl5oBnCNWfy0OREb4
         zUySBFEuHBtcelS6IQcs22KCVOj5sj+vCMTglC+bFshij+obZw+ZExb5XYWFfjYVejVj
         Gzb1tPsjLNf/59dt49z1FxLw4oBGXKKj6LWyBwyVKEa4fWy2TlnQd4ElaJf1AC50mZ8o
         dLyT8K7ZxaOaqJRclYVVJDWjHo23+t8GjunrEuHUmRAwW5uP57wWQoFVEWilftxq65ES
         2X7g==
X-Gm-Message-State: AAQBX9eaAu1vHkAuAzlO14lTugu6mGR5pYfgmMQScsx2EiMfGSjQI8NW
        +J74fhJpDr3/oRr/bzXj9j4=
X-Google-Smtp-Source: AKy350aE3T02AUVNWDyuHg0EPy6lYfeZjBOoMhh6F5J6LzBKmjJy7eJPSVbbRfKO/iq7X1XGLm39Tg==
X-Received: by 2002:a17:906:9484:b0:884:3174:119d with SMTP id t4-20020a170906948400b008843174119dmr2429409ejx.14.1680955979016;
        Sat, 08 Apr 2023 05:12:59 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id qk6-20020a1709077f8600b00948fd62a53asm3078363ejc.71.2023.04.08.05.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 05:12:58 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 04/10] ARM: dts: sun8i: v3s: Switch dma-names order for
 snps,dw-apb-uart nodes
Date:   Sat, 08 Apr 2023 14:12:57 +0200
Message-ID: <3155463.5fSG56mABF@jernej-laptop>
In-Reply-To: <20230321215624.78383-5-cristian.ciocaltea@collabora.com>
References: <20230321215624.78383-1-cristian.ciocaltea@collabora.com>
 <20230321215624.78383-5-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 21. marec 2023 ob 22:56:18 CEST je Cristian Ciocaltea napisal(a):
> Commit 370f696e4474 ("dt-bindings: serial: snps-dw-apb-uart: add dma &
> dma-names properties") documented dma-names property to handle Allwinner
> D1 dtbs_check warnings, but relies on the rx->tx ordering, which is the
> reverse of what a bunch of different boards expect.
> 
> The initial proposed solution was to allow a flexible dma-names order in
> the binding, due to potential ABI breakage concerns after fixing the DTS
> files. But luckily the Allwinner boards are not affected, since they are
> using a shared DMA channel for rx and tx.
> 
> Hence, the first step in fixing the inconsistency was to change
> dma-names order in the binding to tx->rx.
> 
> Do the same for the snps,dw-apb-uart nodes in the DTS file.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>  arch/arm/boot/dts/sun8i-v3s.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi
> b/arch/arm/boot/dts/sun8i-v3s.dtsi index db194c606fdc..b001251644f7 100644
> --- a/arch/arm/boot/dts/sun8i-v3s.dtsi
> +++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
> @@ -479,7 +479,7 @@ uart0: serial@1c28000 {
>  			reg-io-width = <4>;
>  			clocks = <&ccu CLK_BUS_UART0>;
>  			dmas = <&dma 6>, <&dma 6>;
> -			dma-names = "rx", "tx";
> +			dma-names = "tx", "rx";
>  			resets = <&ccu RST_BUS_UART0>;
>  			status = "disabled";
>  		};
> @@ -492,7 +492,7 @@ uart1: serial@1c28400 {
>  			reg-io-width = <4>;
>  			clocks = <&ccu CLK_BUS_UART1>;
>  			dmas = <&dma 7>, <&dma 7>;
> -			dma-names = "rx", "tx";
> +			dma-names = "tx", "rx";
>  			resets = <&ccu RST_BUS_UART1>;
>  			status = "disabled";
>  		};
> @@ -505,7 +505,7 @@ uart2: serial@1c28800 {
>  			reg-io-width = <4>;
>  			clocks = <&ccu CLK_BUS_UART2>;
>  			dmas = <&dma 8>, <&dma 8>;
> -			dma-names = "rx", "tx";
> +			dma-names = "tx", "rx";
>  			resets = <&ccu RST_BUS_UART2>;
>  			pinctrl-0 = <&uart2_pins>;
>  			pinctrl-names = "default";




