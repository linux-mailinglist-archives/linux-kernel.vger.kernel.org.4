Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E056E6E5A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjDRVhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjDRVhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:37:03 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526981BD8;
        Tue, 18 Apr 2023 14:37:02 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6a5dd070aa1so484517a34.3;
        Tue, 18 Apr 2023 14:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681853821; x=1684445821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbWVwRDoV9I2kcGoqtOHA4AoHy2tf9k4WaGcKcFo53w=;
        b=kILuMy4h7pXU6rK3LQn/hez+uvSzEtdrxbgxXi8O0xOd6UU3wlWclIdJFLmtZEZNB6
         GBI4PhpWDRraSkB1qGtAilxEq+XG3UpV9BWy8vWLep1Fa5/leK0xyFkemO2PKmzV2ZYZ
         vmYrBpcRr6/svpncB2FFcasbzRTgOB6k1k94vdTO4VQO01HtW8JLWXOnwIXIbydU5Ino
         N+FJYWdLYoOiNYfKSu9zK1qHSVlG6k+JJJWqButJX8TQOWK564Lvi8QXBgRme9S40abv
         SjyeibtQt/RgHj9BY1AZw2e9hfXBs2RR4qvpwRk5WD1JiTqG4TvW7FESV+wwrQS6Urhk
         iD2g==
X-Gm-Message-State: AAQBX9fC3H9i3MNdRIYyccp7fwh62k5Hsf0IxEVqS7OyI12WydacL7P6
        VdvDB+kxtWhL333pGqIVWA==
X-Google-Smtp-Source: AKy350ajzlK+Nfe2WjS2CiPYlhzjq0hQUI8vA59pqj48sqD1cxE9cnAHbFCnFTn8iDnot1Luwh/ZcQ==
X-Received: by 2002:a9d:69d3:0:b0:6a6:598:b915 with SMTP id v19-20020a9d69d3000000b006a60598b915mr833018oto.8.1681853821579;
        Tue, 18 Apr 2023 14:37:01 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b6-20020a9d7546000000b006a2ce5f3641sm6000241otl.8.2023.04.18.14.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 14:37:00 -0700 (PDT)
Received: (nullmailer pid 2374252 invoked by uid 1000);
        Tue, 18 Apr 2023 21:36:58 -0000
Date:   Tue, 18 Apr 2023 16:36:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Eugen Hristev <eugen.hristev@collabora.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-watchdog@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Jamie Iles <jamie@jamieiles.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Shawn Guo <shawnguo@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Julius Werner <jwerner@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Christophe Roullier <christophe.roullier@foss.st.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Justin Chen <justinpopo6@gmail.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        =?UTF-8?B?77+9ZWNraQ==?= <rafal@milecki.pl>,
        Kevin Hilman <khilman@baylibre.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-amlogic@lists.infradead.org,
        Evan Benn <evanbenn@chromium.org>,
        linux-mediatek@lists.infradead.org,
        Sander Vanheule <sander@svanheule.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Fu Wei <fu.wei@linaro.org>, Andy Gross <agross@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 5/6] dt-bindings: watchdog: toshiba,visconti-wdt:
 simplify with unevaluatedProperties
Message-ID: <168185381738.2374180.14119161072449587074.robh@kernel.org>
References: <20230415095112.51257-1-krzysztof.kozlowski@linaro.org>
 <20230415095112.51257-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230415095112.51257-5-krzysztof.kozlowski@linaro.org>
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


On Sat, 15 Apr 2023 11:51:11 +0200, Krzysztof Kozlowski wrote:
> Allow generic watchdog properties by using unevaluatedProperties: false.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/watchdog/toshiba,visconti-wdt.yaml    | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

