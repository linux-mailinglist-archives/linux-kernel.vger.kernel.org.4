Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275B26E6E10
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjDRVXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjDRVXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:23:22 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A3F975D;
        Tue, 18 Apr 2023 14:23:13 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-18777914805so6246609fac.1;
        Tue, 18 Apr 2023 14:23:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681852993; x=1684444993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKdLQJ2WfynsAnQi4i43G4jU69vCcdQQMLvbvIaqAHQ=;
        b=Bc8CAtMCCN0AZEbfK6a92mOCH8/sWYSBNUEDMEJcUNpVW6zreSXfuiZqFn70c/CPcl
         Itp3vCYUlNvv18yesmOtmOZ3U+bz43E/MW2xzPSzeDTbpZBawup0zGNn39Xklnb3ixGh
         HTuISBi9f6JYe7zY7oVHuC6J2a8z0F4Xyi6ftIJsa+yDzpl3XoJratlCsFl4CdyKwEtN
         jV0WWWY7gaDKIerXJ321cV12/A/JVjnNqBx1q2CX980TR79P1NrTZL4Qzl/aiklszcyZ
         loTm0ng5cuLRvtSjlcGxi6AA+2WCatqmAuYHe97degxfYf6W9/361UNw33zze2RhvcAJ
         8iuA==
X-Gm-Message-State: AAQBX9eV3cxz5U/VM4XFnypHTLv7maJ0UrGG+VoI0aGTrudvvXNYQwxV
        eDmKiqL+nyXkfQeECIbg1Q==
X-Google-Smtp-Source: AKy350bdmvWWvs8e3IniLnnX6QWq/ARMeVjy2OYmobsGssJEfW0Lm1T3KwueQwpXlw4Lj4ZiKOdsBA==
X-Received: by 2002:aca:c256:0:b0:38e:3d5a:abb5 with SMTP id s83-20020acac256000000b0038e3d5aabb5mr114233oif.9.1681852991281;
        Tue, 18 Apr 2023 14:23:11 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e190-20020a4a55c7000000b0054542d3219asm3883392oob.11.2023.04.18.14.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 14:23:10 -0700 (PDT)
Received: (nullmailer pid 2358722 invoked by uid 1000);
        Tue, 18 Apr 2023 21:23:08 -0000
Date:   Tue, 18 Apr 2023 16:23:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     =?UTF-8?B?77+9ZWNraQ==?= <rafal@milecki.pl>,
        linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Marko <robert.marko@sartura.hr>,
        linux-renesas-soc@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Christophe Roullier <christophe.roullier@foss.st.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Julius Werner <jwerner@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Jamie Iles <jamie@jamieiles.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Evan Benn <evanbenn@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-amlogic@lists.infradead.org,
        Sander Vanheule <sander@svanheule.net>,
        Justin Chen <justinpopo6@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Shawn Guo <shawnguo@kernel.org>, Fu Wei <fu.wei@linaro.org>,
        linux-watchdog@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/6] dt-bindings: watchdog: drop duplicated GPIO watchdog
 bindings
Message-ID: <168185298846.2358657.13423905325582795303.robh@kernel.org>
References: <20230415095112.51257-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230415095112.51257-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 15 Apr 2023 11:51:07 +0200, Krzysztof Kozlowski wrote:
> Two conversions to DT schema of GPIO watchdog binding happened and came
> through different trees.  Merge them into one:
> 1. Combine maintainers,
> 2. Use more descriptive property descriptions and constraints from
>    gpio-wdt.yaml,
> 3. Switch to unevaluatedProperties:false, to allow generic watchdog
>    properties.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/watchdog/gpio-wdt.yaml           | 55 -------------------
>  .../bindings/watchdog/linux,wdt-gpio.yaml     | 17 +++++-
>  2 files changed, 15 insertions(+), 57 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/gpio-wdt.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

