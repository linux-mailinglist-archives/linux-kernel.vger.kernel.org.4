Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7266BF899
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 08:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjCRH4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 03:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCRH4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 03:56:00 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CD4193E7;
        Sat, 18 Mar 2023 00:55:59 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z21so28615919edb.4;
        Sat, 18 Mar 2023 00:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679126158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3mb1pjia0IgyxNYtGaBW063L8X9ZIfqHcxc0T2DSoE=;
        b=fBX72+jPi22mNWR0n66lXXvwXHTQxcM41cjOKQOFBjpMqwvJXTQARhbixvvPdkkpyg
         iRz5F1olqpPnPEhjzGsE8uRjUIq0KObfvNgQ33aXB16Xe4mdr88HqTAATKyBFPncUXHN
         pAHvLgLybu/xG4qaqSDaGPMBl4snRJTmMwG7ZAjPV0ZmxqwZwUqiR0DLEKcbQ+k4MgFm
         uLv/UFLAxju66WskNVs6KYpSK7pn8sxPIhpX3kVxZGAwHr4Yi+Sx1ojZX8mCwCAtaHdg
         cFHHoFp3LRvH0s2K5dzSmzksNvnh5RF5z5TITUuf/CxXcgImrBy6REOAOt+P4G3p7ZrF
         qT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679126158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3mb1pjia0IgyxNYtGaBW063L8X9ZIfqHcxc0T2DSoE=;
        b=zNgtb57nb9AKg6UaJdd8SB6tq7+GDsYMpxG+CdBmDx9Czhdp527J4+ch11vvYXVYz4
         Q7i7U3IgIdI1eQg1NFGgsRiJRsaGt5hntAWRmhKp3yx3A90Eugrx5qAEc4Cx83IV2OWP
         5h2mz1/hsU8CY/tQvGyXAYKYsuAiPrSlY0/ay0kFQCqaGmeakoXTuQ4D+N2+gNgU1xUU
         rbjEh3k+KfbgiuUXQFDVSrVlx3bDwiubkCCchWAOCjV2oEjZAzyneWHGEZrUfoSExKg/
         p3M6CfN9pZiKkN8pQHhbIeP9PK9a2m1VtUNvNN3N4aM0YsjoRaS+Z6hGDT5XksN5+uYe
         86AQ==
X-Gm-Message-State: AO0yUKWxjZfB5OdoJWlwO5n4AG/rL8qm5kS3RdW9p/9AtxekJZA+oT7N
        t8cFMRZtPLj3S9U0t3n2BDaWZL0tyr4=
X-Google-Smtp-Source: AK7set+YGRH+NdfCv25lT4gzGUwF+d+mhdcmW8UIiZ6tl7LF/5aTRoQ3LntLinj37gw5RiBcrUdU9w==
X-Received: by 2002:a17:907:2bc8:b0:931:2306:f363 with SMTP id gv8-20020a1709072bc800b009312306f363mr2055699ejc.21.1679126157741;
        Sat, 18 Mar 2023 00:55:57 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id xo10-20020a170907bb8a00b008ec793ac3f4sm1850916ejc.192.2023.03.18.00.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 00:55:57 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Julius Werner <jwerner@chromium.org>,
        Evan Benn <evanbenn@chromium.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] dt-bindings: watchdog: Drop unneeded quotes
Date:   Sat, 18 Mar 2023 08:55:54 +0100
Message-ID: <2672483.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20230317233643.3969019-1-robh@kernel.org>
References: <20230317233643.3969019-1-robh@kernel.org>
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

Dne sobota, 18. marec 2023 ob 00:36:42 CET je Rob Herring napisal(a):
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml   | 2 +-

for allwinner:
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>  Documentation/devicetree/bindings/watchdog/apple,wdt.yaml       | 2 +-
>  Documentation/devicetree/bindings/watchdog/arm-smc-wdt.yaml     | 2 +-
>  .../devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml         | 2 +-
>  .../devicetree/bindings/watchdog/brcm,bcm7038-wdt.yaml          | 2 +-
>  .../devicetree/bindings/watchdog/faraday,ftwdt010.yaml          | 2 +-
>  Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml | 2 +-
>  Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml   | 2 +-
>  Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml     | 2 +-
>  Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml     | 2 +-
>  .../devicetree/bindings/watchdog/socionext,uniphier-wdt.yaml    | 2 +-
>  Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.yaml   | 2 +-
>  Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml      | 2 +-
>  13 files changed, 13 insertions(+), 13 deletions(-)



