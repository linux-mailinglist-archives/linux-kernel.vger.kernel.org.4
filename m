Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F2A6DBAC0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 14:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjDHMMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 08:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjDHMMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 08:12:45 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C00CEFAC;
        Sat,  8 Apr 2023 05:12:42 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id dm2so2544824ejc.8;
        Sat, 08 Apr 2023 05:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680955961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEjyigADndOdizLeD+7XPzcSBZVRCHIxciRjEv6kJxg=;
        b=dXHNue3tfQS7WytEgGHmZW8HJVXaXr6PVc3hV7N4G2roojWs2Ke8ZuvMD/67J/K1ML
         uaQzEWaSid873PrggNGX2FavoHdL3gTdvvK53X5uu3y+m7LI5HApCIgkSsiPiSwMfrra
         1gK7OX0I44vpnwiuj8La02MBIAc7nLBhWrwlldRxzUiZ3+S+9wmsXwoG8IYSpWnmufQq
         huu1TMjvTfi3cgC2apzUJDX0ONbAPH+XUqHbR2GxDy8k0n9zi/RLk/GD4mlY0vdz1SGG
         7kZv5SYLJXx86MenvfFTwWs99lKqiPmSPab0Xv/X64SddUKViG12OolSE8u7WgyXzZVm
         1MOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680955961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEjyigADndOdizLeD+7XPzcSBZVRCHIxciRjEv6kJxg=;
        b=sXOE98WR6tDeHmbLsWd2DlPSA016XudE92qdXkWhnM9sJ7d3jnWrTCEyVKsQ0CrxMR
         xxce8vvdR6qSKu4gSSyH/9Tl7Y5zGAzbXWpZ/kQ5hfN8gXteOf3WawzVshpvFW7wFy46
         RqwgOXVmA5EcTqHeAEMZxq2FGKYDKwnvVjKiD8vKvlw/beMpyA7RADmsCXFjQj/tstnr
         7y7utaqsc6PIkJi0kAwYCiQYY3tPw2ZPB/IOL4m/5i9F+LUySxxqGd+mSEgC6pXxtp/8
         UOzVnx/lPLkgNzZxUJiLBqct8AGJP1ucX7LOSa4MtJ437sBiaTzHsbUZzyzBPRahQPTm
         R43g==
X-Gm-Message-State: AAQBX9emKVknzJfhGu2Xopw7n1gxL3pUlm2DAQpz3tLyZsSIPirV9UI/
        4ge++x9PwuD7QsPdkACGnJo=
X-Google-Smtp-Source: AKy350ZKm612bONyntbJNhUcSmJqS/wij8yX9R0YK3mv05gal13Hkgd68SwJxMfJJzhR6AYahsrYbg==
X-Received: by 2002:a17:906:71c9:b0:930:123:8cc8 with SMTP id i9-20020a17090671c900b0093001238cc8mr2399797ejk.21.1680955960788;
        Sat, 08 Apr 2023 05:12:40 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id qb19-20020a1709077e9300b00948da767832sm3072503ejc.152.2023.04.08.05.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 05:12:40 -0700 (PDT)
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
Subject: Re: [PATCH v2 03/10] ARM: dts: sun8i: a23/a33: Switch dma-names order for
 snps,dw-apb-uart nodes
Date:   Sat, 08 Apr 2023 14:12:38 +0200
Message-ID: <3489160.iIbC2pHGDl@jernej-laptop>
In-Reply-To: <20230321215624.78383-4-cristian.ciocaltea@collabora.com>
References: <20230321215624.78383-1-cristian.ciocaltea@collabora.com>
 <20230321215624.78383-4-cristian.ciocaltea@collabora.com>
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

Dne torek, 21. marec 2023 ob 22:56:17 CEST je Cristian Ciocaltea napisal(a):
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

>  arch/arm/boot/dts/sun8i-a23-a33.dtsi | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> b/arch/arm/boot/dts/sun8i-a23-a33.dtsi index f630ab55bb6a..4aa9d88c9ea3
> 100644
> --- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> @@ -490,7 +490,7 @@ uart0: serial@1c28000 {
>  			clocks = <&ccu CLK_BUS_UART0>;
>  			resets = <&ccu RST_BUS_UART0>;
>  			dmas = <&dma 6>, <&dma 6>;
> -			dma-names = "rx", "tx";
> +			dma-names = "tx", "rx";
>  			status = "disabled";
>  		};
> 
> @@ -503,7 +503,7 @@ uart1: serial@1c28400 {
>  			clocks = <&ccu CLK_BUS_UART1>;
>  			resets = <&ccu RST_BUS_UART1>;
>  			dmas = <&dma 7>, <&dma 7>;
> -			dma-names = "rx", "tx";
> +			dma-names = "tx", "rx";
>  			status = "disabled";
>  		};
> 
> @@ -516,7 +516,7 @@ uart2: serial@1c28800 {
>  			clocks = <&ccu CLK_BUS_UART2>;
>  			resets = <&ccu RST_BUS_UART2>;
>  			dmas = <&dma 8>, <&dma 8>;
> -			dma-names = "rx", "tx";
> +			dma-names = "tx", "rx";
>  			status = "disabled";
>  		};
> 
> @@ -529,7 +529,7 @@ uart3: serial@1c28c00 {
>  			clocks = <&ccu CLK_BUS_UART3>;
>  			resets = <&ccu RST_BUS_UART3>;
>  			dmas = <&dma 9>, <&dma 9>;
> -			dma-names = "rx", "tx";
> +			dma-names = "tx", "rx";
>  			status = "disabled";
>  		};
> 
> @@ -542,7 +542,7 @@ uart4: serial@1c29000 {
>  			clocks = <&ccu CLK_BUS_UART4>;
>  			resets = <&ccu RST_BUS_UART4>;
>  			dmas = <&dma 10>, <&dma 10>;
> -			dma-names = "rx", "tx";
> +			dma-names = "tx", "rx";
>  			status = "disabled";
>  		};




