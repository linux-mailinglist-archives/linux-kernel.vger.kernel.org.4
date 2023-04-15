Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2A86E304B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 11:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjDOJ6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 05:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjDOJ6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 05:58:22 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E50561A5
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 02:58:21 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id jg21so51350493ejc.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 02:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681552701; x=1684144701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X++FhK1t/fMQBncyu3FeTc1IPRncKd5sGne3lbXD1HA=;
        b=ElHS0DixfV4Wx0/NRCOiZ3tsYfPcSyO/g1j7g/FJw5/YfXipUfJBvmFPzXl13E2Tvf
         SlSdK+EcP2/VLC4TtP1izTSZh2TYXhQwqrEHTP4zmLknPDHuF6W0Ez3oOwri2AO4Ln8J
         DKM/IsZIxge+Q36axXN56jyjNpGR6y1DekpVmrGRzkbCcPf8lzZTffR5fyyV3yf3kqgU
         XY3Jr5gNhHwtScMoax+woXvPJV+LbcS1d3mQ8aHbvrtS9cqK7eNuaskGH+C3p4x28hPk
         gE0r2qXpKKwQao2swDA6m552WDpf1EkvhZhgjtn7/+5P2CZIcSXmPfyymhrvI2osVwKR
         mSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681552701; x=1684144701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X++FhK1t/fMQBncyu3FeTc1IPRncKd5sGne3lbXD1HA=;
        b=i4MvEfTQC+Haf/PuRf7BlpaG+rzH9wE1y3NFoRJEsCdUfG6phuVbeUGR77ZWdholly
         RsxBNYMtLOyZPaFSj80ZkAoLfjS60SBt9SDdBD5EAAiEn111M5B03lSZukn8XwpTQciq
         QNMhjsl4BmWmn3ZoPXhITK6hsnOWJBCqnxI1n6GZRLjvC5BEH9zAbL1XUyTJpzzwnpps
         Gk8R6u+EBE8J/j9ZOFUvdzskHK5IixYIwPEDDvJ303c+2Wn87T1+o0/yLdTmss/BY52F
         2CcEcpm3Kd6MtPaBTVg9m8Lhn6lP9wdvSm4rezIiGVgCw8miofDZ6i1RA62j9OapHn35
         Al6w==
X-Gm-Message-State: AAQBX9fB8n1EiVG61mzAwpNqahR3WunskDuDj1EttUSro2NLUtEwsH+F
        IM5AT+2159yn+/vePNohuaJWyg==
X-Google-Smtp-Source: AKy350Yav0SQe0tEvR6ZtIMRzAj9K6H8406yqb7Hzclv9sLARZM1w9Vr1g/iMuC5RnPGGtv3bjO69Q==
X-Received: by 2002:a17:906:149b:b0:948:b9ea:3302 with SMTP id x27-20020a170906149b00b00948b9ea3302mr1901974ejc.1.1681552700850;
        Sat, 15 Apr 2023 02:58:20 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a3bf:4ed:6c53:2a36])
        by smtp.gmail.com with ESMTPSA id gn23-20020a1709070d1700b009373f1b5c4esm3594248ejc.161.2023.04.15.02.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 02:58:20 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
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
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sander Vanheule <sander@svanheule.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Fu Wei <fu.wei@linaro.org>, Viresh Kumar <vireshk@kernel.org>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Justin Chen <justinpopo6@gmail.com>,
        =?UTF-8?q?=82ecki?= <rafal@milecki.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jamie Iles <jamie@jamieiles.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Christophe Roullier <christophe.roullier@foss.st.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-renesas-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/6] dt-bindings: watchdog: fsl-imx7ulp-wdt: simplify with unevaluatedProperties
Date:   Sat, 15 Apr 2023 11:51:10 +0200
Message-Id: <20230415095112.51257-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230415095112.51257-1-krzysztof.kozlowski@linaro.org>
References: <20230415095112.51257-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow generic watchdog properties by using unevaluatedProperties: false.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml         | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml b/Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml
index d3790f1a96a2..4b7ed1355701 100644
--- a/Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml
@@ -30,15 +30,13 @@ properties:
   clocks:
     maxItems: 1
 
-  timeout-sec: true
-
 required:
   - compatible
   - interrupts
   - reg
   - clocks
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1

