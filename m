Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911D96D69EC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbjDDRKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbjDDRJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:09:57 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C61AE7D;
        Tue,  4 Apr 2023 10:09:56 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id r14so19041999oiw.12;
        Tue, 04 Apr 2023 10:09:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQfDPbeHzXvhNMP21e47HMs1Ss6VjJ3ppCcbbXGV5fo=;
        b=5mUBVjZRq5/qxt/GBFP1amypw6ebuzfXYq40Nlxh0ZXE084b0c1GQgFIWjr/Y/95AM
         D5dsXP2Ksy68BvAgGVHAIZ+DFJvQLWnnqO3KwNC4XWCf1/rNMYUeGiBnxARRWjWdmQDV
         2XMiXrqiCVClZOUHEZNEYhsqzfl5m9ZqwMnzqw2HIHPlR64ihxB0c2XpOyMHE2tO5ALO
         4FUpT2m4uFx4891W87pcQMA6RusGHFzA+9bhMGHSneyKFkXhlASHJVwasAnptpJlQEOS
         wdLzpT7x03tRSWmifkJq6Lzba1lNPTpKgPCV4c68eT8UFcPQb0AEMzIcczzGtz0KMZk2
         Wtpw==
X-Gm-Message-State: AAQBX9fj+BRzu3V88LCEAHyBgxQa6VMLk/eSOcScJakSXgjJnw80hvMn
        RjqeRj1k629+pbJPEyMnOg==
X-Google-Smtp-Source: AKy350ZZ7BG/vNzA7V0xxF/wFLGRBOLHnE+ociOtzhxPFF1JrYNXX4h2mrA1aYYKqBLL6ePOmatUBA==
X-Received: by 2002:a05:6808:3a99:b0:378:9c1:514e with SMTP id fb25-20020a0568083a9900b0037809c1514emr1312221oib.42.1680628194745;
        Tue, 04 Apr 2023 10:09:54 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o184-20020acabec1000000b003646062e83bsm5388522oif.29.2023.04.04.10.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:09:54 -0700 (PDT)
Received: (nullmailer pid 133735 invoked by uid 1000);
        Tue, 04 Apr 2023 17:09:52 -0000
Date:   Tue, 4 Apr 2023 12:09:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
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
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] dt-bindings: watchdog: Drop unneeded quotes
Message-ID: <20230404170952.GF49361-robh@kernel.org>
References: <20230317233643.3969019-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317233643.3969019-1-robh@kernel.org>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 06:36:42PM -0500, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml   | 2 +-
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

Applied, thanks.
