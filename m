Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBCE6DBAC6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 14:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjDHMNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 08:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjDHMNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 08:13:21 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79794EFAD;
        Sat,  8 Apr 2023 05:13:18 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id qa44so2130388ejc.4;
        Sat, 08 Apr 2023 05:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680955997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJmx+f31axUvoi/dHkgurPuWKlYeJjKe0B/02y5c1hI=;
        b=a+IjEn62kIWwcZ1L/0L2xqhD74h6hRmUfo3qpuksXoLGNeOb3o0LNm5Rkuhy1ceoZj
         G2FqB3KjrcvLilfhlREqtlyPFpLTyIcWqGv3DbCi7nMiZzC0yAyQvD4eFDsMp2pGJCDd
         Iw3QZkste1SEC1xUqFgC+mySd6T8WPFhNtNzcqOKWigvWcWPFju0Rs+rnn1Ij3oP70v+
         UC5hlnB3eI+HSAYZYtkG2LFxQnrUbMox7Q4THkgLdbqrIVYTgbW7nzskqqQA0HQH7OOr
         fXmaenBIXmo4jZke7XPI9VH2iY63pKwDMnufg4g8yUbERhcUXDNbmnbzI8IApZ0NxGw6
         LYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680955997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJmx+f31axUvoi/dHkgurPuWKlYeJjKe0B/02y5c1hI=;
        b=cTtkdZnc3Ko13DcPgAmsdmpJaBCnI4Q/S8m5rlaBZmtkrC0e6JTyZHp8t2wdFqDwZG
         wjw66M/mniQRQuRoxocnd8zdTENqZsE0bzn+2pbQ0vLGhRGeWz5EpXDW/V6RBGI7rmuP
         S+HcNF4mcsFG2JuT3EicagdxZlPkNSEjSA2wJMiac1KdxNz51MQY9om1TzVM855/+N1U
         ivFU4qEpU09mIt8qj6eF2YyQZ0iLPQLz4BSWeDGB4gAsMJC29IUgsBlI3BZRiSQXMQfC
         +CSNQTtb2/Aiio82tT1xrNAPue6dBTZXJXaXfiGPkc9mYqKz5+uxUI/H6Ofb3nAHfrvQ
         IOjg==
X-Gm-Message-State: AAQBX9db6p+3Q4PE8yc0q2bf9ePJKptXcbxMy8ilgIwTgxLqM7Ss3sv6
        mqrVqEkZc7E7oaAcL8vcpFI=
X-Google-Smtp-Source: AKy350b94j/ZxQUi+lYQF+Fq1CVL4fCn0M+Vx7zcnJOgNusGmaSl0GNLXQqXyciV5Dpd1F/TZOyYoA==
X-Received: by 2002:a17:907:6d90:b0:8aa:c090:a9ef with SMTP id sb16-20020a1709076d9000b008aac090a9efmr2550022ejc.55.1680955996826;
        Sat, 08 Apr 2023 05:13:16 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090617c100b00930b13f6abdsm3108700eje.98.2023.04.08.05.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 05:13:16 -0700 (PDT)
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
Subject: Re: [PATCH v2 05/10] ARM: dts: sunxi: h3/h5: Switch dma-names order for
 snps,dw-apb-uart nodes
Date:   Sat, 08 Apr 2023 14:13:14 +0200
Message-ID: <1754521.VLH7GnMWUR@jernej-laptop>
In-Reply-To: <20230321215624.78383-6-cristian.ciocaltea@collabora.com>
References: <20230321215624.78383-1-cristian.ciocaltea@collabora.com>
 <20230321215624.78383-6-cristian.ciocaltea@collabora.com>
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

Dne torek, 21. marec 2023 ob 22:56:19 CEST je Cristian Ciocaltea napisal(a):
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

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> b/arch/arm/boot/dts/sunxi-h3-h5.dtsi index 686193bd6bd9..ade1cd50e445
> 100644
> --- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> +++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> @@ -710,7 +710,7 @@ uart0: serial@1c28000 {
>  			clocks = <&ccu CLK_BUS_UART0>;
>  			resets = <&ccu RST_BUS_UART0>;
>  			dmas = <&dma 6>, <&dma 6>;
> -			dma-names = "rx", "tx";
> +			dma-names = "tx", "rx";
>  			status = "disabled";
>  		};
> 
> @@ -723,7 +723,7 @@ uart1: serial@1c28400 {
>  			clocks = <&ccu CLK_BUS_UART1>;
>  			resets = <&ccu RST_BUS_UART1>;
>  			dmas = <&dma 7>, <&dma 7>;
> -			dma-names = "rx", "tx";
> +			dma-names = "tx", "rx";
>  			status = "disabled";
>  		};
> 
> @@ -736,7 +736,7 @@ uart2: serial@1c28800 {
>  			clocks = <&ccu CLK_BUS_UART2>;
>  			resets = <&ccu RST_BUS_UART2>;
>  			dmas = <&dma 8>, <&dma 8>;
> -			dma-names = "rx", "tx";
> +			dma-names = "tx", "rx";
>  			status = "disabled";
>  		};
> 
> @@ -749,7 +749,7 @@ uart3: serial@1c28c00 {
>  			clocks = <&ccu CLK_BUS_UART3>;
>  			resets = <&ccu RST_BUS_UART3>;
>  			dmas = <&dma 9>, <&dma 9>;
> -			dma-names = "rx", "tx";
> +			dma-names = "tx", "rx";
>  			status = "disabled";
>  		};




