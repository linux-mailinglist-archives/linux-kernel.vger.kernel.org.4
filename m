Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3D26E6E71
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjDRVj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbjDRVjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:39:53 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C047BBB5;
        Tue, 18 Apr 2023 14:39:37 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-38c6bbbeeb3so456173b6e.1;
        Tue, 18 Apr 2023 14:39:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681853976; x=1684445976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FTQgI3HTIujYCvmdGvbn1iYHKKTz5bkM55o7VU7wfs=;
        b=CNMQe6I34mx9dAFwKVO7dYtezQBYC4huJucPEzQI94ghKB0d5HVtLam+cyyj1Aysyp
         NGPVgN810QZ/zoX7iAlIvCC7p97LWM2nZDCUncIX8hXSDTiOBqEnm7wN9VynkMk60QaE
         Cc0K4FXXqCqQpOpuXF58c5Ov3Sx0GofevSsnWOPZAnUP8clm/Vq7+y5Ehr8erCrnyzc7
         jowc6n66hbLm4W83d1KiQmk3A2nK27YXL5Y3PxKsHq51tXLwrMgld8UFFfxgdAuVPEUn
         PZSuvZHnYZ8DLl/d4QL8tqK9c9JPjbGgyuewCdGV68S9kQQE3pAKncctaITENb3R0PAB
         IElw==
X-Gm-Message-State: AAQBX9eXSFPFhTqxD9gJ97ApUD/2ak8K3323OfQKkNfWE2WUwZWV2gO7
        GL4sTzSbG569law3fAUCqA==
X-Google-Smtp-Source: AKy350ad1gFJziMA7uFDXKgRYHOImiDLZc2+2kux8SA8FrsvhCP7QU7dcKoZR+twA7gAQFYNGfgJUA==
X-Received: by 2002:aca:644:0:b0:378:2df5:49f5 with SMTP id 65-20020aca0644000000b003782df549f5mr1944858oig.2.1681853974837;
        Tue, 18 Apr 2023 14:39:34 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n3-20020aca2403000000b0038bffe1332dsm3950756oic.57.2023.04.18.14.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 14:39:31 -0700 (PDT)
Received: (nullmailer pid 2376874 invoked by uid 1000);
        Tue, 18 Apr 2023 21:39:29 -0000
Date:   Tue, 18 Apr 2023 16:39:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Andy Gross <agross@kernel.org>, linux-watchdog@vger.kernel.org,
        Fu Wei <fu.wei@linaro.org>, Jamie Iles <jamie@jamieiles.com>,
        linux-renesas-soc@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Shawn Guo <shawnguo@kernel.org>,
        linux-amlogic@lists.infradead.org,
        =?UTF-8?B?77+9ZWNraQ==?= <rafal@milecki.pl>,
        Julius Werner <jwerner@chromium.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Christophe Roullier <christophe.roullier@foss.st.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Justin Chen <justinpopo6@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mediatek@lists.infradead.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Evan Benn <evanbenn@chromium.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Sander Vanheule <sander@svanheule.net>
Subject: Re: [PATCH 6/6] dt-bindings: watchdog: realtek,otto-wdt: simplify
 requiring interrupt-names
Message-ID: <168185396909.2376821.8732982905359058158.robh@kernel.org>
References: <20230415095112.51257-1-krzysztof.kozlowski@linaro.org>
 <20230415095112.51257-6-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230415095112.51257-6-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 15 Apr 2023 11:51:12 +0200, Krzysztof Kozlowski wrote:
> Required properties should be listed in "required:" block.  Since
> interrupts are already there, the dependency of interrupt-names on the
> interrupts can be simplified.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/watchdog/realtek,otto-wdt.yaml        | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

