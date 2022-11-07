Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F51620156
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbiKGVj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiKGVjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:39:54 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7509D1DDFF;
        Mon,  7 Nov 2022 13:39:53 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id f27so33753888eje.1;
        Mon, 07 Nov 2022 13:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWppGLhyRbk0twcMAe1fFy3XdHnUGasdqpAlH5c197I=;
        b=BY8RcMc9oenknF5UieWwhxCKspnvAyK4KI638WUeKiYt+pUT1gsmRNZHw3ahjNFKPu
         SIFxyprUdLaoluN5Amon3TdTLLfVDr8QNivMgNSq1kNKM08nba9X194a24McafGI6XQ4
         GdrjjoaPyr6+3W9V2fulejJCfmaenZTTmBOYcRsgoYa3dslyiK9YvGFRAjQCPD0BoGJS
         ZA3r14KVlBAOkDmOo+yM915L6g4rZjLGT2LvWUXQbmSsBbVsO7/J4YViDNh6WTcEVEBy
         uCDsOG+v+IKLHze7qN0q8PTQOSzgNGJGCR016ia3sZyrRkOTITnRCSYbYCLoD0gYtLws
         z8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWppGLhyRbk0twcMAe1fFy3XdHnUGasdqpAlH5c197I=;
        b=zIMYOu+7fEHH63d0fNNoJd5sx5k/g70VL6I0UmNDBL0GXVEX4h0nUSNmoIULgL4j9V
         kELmmRbaAvhA4aD6op3VR5nVW9XYelO7L3HAYyVYXOs/fdmkQ1UoxKg3w/E8IWNi6km2
         4HTGfZmgmzSdl0YAe+Mnzxyp4rwV5ChyUNu2BjQYBXOnLPvI74zBRpwWz5sYn/4oonH/
         zgHOs8onGWNIb7ybxssnh2dQZyKQVjtZaF1K6r++ojw+x4HNPIuGJl9mwC8ZwpfcGyz/
         5CfQzUiZrEmbZWlQm9lx1id295tWheTsg3gK+zA44SdJI8RR9lINXETBa/VZRe0bisD6
         gyVw==
X-Gm-Message-State: ACrzQf2HAHLWc+UN3NLOFKGm4E16UcZYn3r4/fQ/x0HgVStm9Ufcn7H0
        GXNEiyv4heMXCAXQjg+RvXuulhKdTqCWCg==
X-Google-Smtp-Source: AMsMyM4Kv6wnMGpf32QajhqCSVNKnlD7xXpfKe/1VaxQW5a3xhNU78Ryn3zVFVJbmdzmzD/0FnxyWg==
X-Received: by 2002:a17:907:3e01:b0:730:a690:a211 with SMTP id hp1-20020a1709073e0100b00730a690a211mr49594056ejc.596.1667857191997;
        Mon, 07 Nov 2022 13:39:51 -0800 (PST)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906310100b00773c60c2129sm3954556ejx.141.2022.11.07.13.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:39:51 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Renze Nicolai <renze@rnplus.nl>
Cc:     linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2] arm64: allwinner: a64: add device tree for SoPine with clusterboard
Date:   Mon, 07 Nov 2022 22:39:50 +0100
Message-ID: <3166097.AJdgDx1Vlc@kista>
In-Reply-To: <c2523181268451aa04a2474a2cf5bedb@rnplus.nl>
References: <b3b8320f0d2b54a0557331977582d05c@rnplus.nl> <334c5f69-2f25-aeb1-b87f-500cf2a6c205@linaro.org> <c2523181268451aa04a2474a2cf5bedb@rnplus.nl>
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

Dne ponedeljek, 07. november 2022 ob 21:55:04 CET je Renze Nicolai napisal(a):
> Hello Krzysztof,
> 
> Thank you for your feedback! I've fixed the indentation and I've added
> the compatible and model elements.

You didn't document compatible in bindings as instructed by Krzysztof. That 
should be in a patch preceding this one.

Comments like this, which are not part of commit message, should be either in 
cover letter or right below --- line, so they are ignored when patch is 
applied. While above comment can be considered as changelog of sort, it's 
preferred to write it as list, point by point, in area which is ignored when 
applying patch.

I guess you don't use "git send-email" to send your patches? New versions 
should not be send in reply to old ones.

> 
> Greetings,
> Renze Nicolai
> 
> 
> The Pine64 clusterboard needs a to have the tx delay changed to
> 500ps for ethernet to work. This solution was described by multiple
> people on the Pine64 forum years ago and nobody has submitted it.

When you're adding new board, commit message should describe new board either 
by stating features or telling which board is similar and what are the 
differences. Something like that clusterboard is almost the same as baseboard 
except ethernet TX delay, which is 500 ps. Omit second part of second 
statement, it's not relevant.

Best regards,
Jernej

> 
> Add a device tree for SoPine with the clusterboard.
> 
> Signed-off-by: Renze Nicolai <renze@rnplus.nl>
> ---
>   arch/arm64/boot/dts/allwinner/Makefile           |  1 +
>   .../allwinner/sun50i-a64-sopine-clusterboard.dts | 16 ++++++++++++++++
>   2 files changed, 17 insertions(+)
>   create mode 100644
> arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-clusterboard.dts
> 
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile
> b/arch/arm64/boot/dts/allwinner/Makefile
> index 6a96494a2e0a..15b011d1aaea 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -15,6 +15,7 @@ dtb-$(CONFIG_ARCH_SUNXI) +=
> sun50i-a64-pinephone-1.2.dtb
>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinetab.dtb
>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinetab-early-adopter.dtb
>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-sopine-baseboard.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-sopine-clusterboard.dtb
>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-teres-i.dtb
>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a100-allwinner-perf1.dtb
>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-bananapi-m2-plus.dtb
> diff --git
> a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-clusterboard.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-clusterboard.dts
> new file mode 100644
> index 000000000000..f75325d43d76
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-clusterboard.dts
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +// Copyright (c) 2022 Renze Nicolai <renze@rnplus.nl>
> +
> +/dts-v1/;
> +
> +#include "sun50i-a64-sopine-baseboard.dts"
> +
> +/ {
> +	model = "SoPine with clusterboard";
> +	compatible = "pine64,sopine-clusterboard", "pine64,sopine",
> +		     "allwinner,sun50i-a64";
> +};
> +
> +&emac {
> +	allwinner,tx-delay-ps = <500>;
> +};
> --
> 2.38.1


