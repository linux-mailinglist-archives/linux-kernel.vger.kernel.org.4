Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBE1677EFF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjAWPNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbjAWPNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:13:23 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C84274AE
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:13:21 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id q5so6462985wrv.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcO0beBhJvY7L0pAz0ix6ZIFb3bQV/tZup2eSR9fEjE=;
        b=jcfa4hARo1HJwIehRkPDvzT0+j43uVWrJYFNzZFKJFnKpJiYnKY2DxtS+F/JYF6uV4
         KknhnLaVrHDF1aK+YU+We/6hYH28642w2VsAR2GhuxMYrMGdHZ4yvQdKZpcnOwkKtjNs
         9YeAeCXyUlV+RLV/5E6LYVH0K+wemk8/uI/1dcbZpOzNblLuvGNxrTnammNGXidPuI0r
         ESQrQEpLx/TKFTbBmG38BRF//5BuQ7VLC+rC4pjygLZu77HP7SzuoAViTIttym9i2g6+
         dyPK25KiunlTmQVEYImYPt0PSo2l+BBax4BFQZTf5+cfTrrzSHX9Ua9rb0bUiuClnAvS
         sn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcO0beBhJvY7L0pAz0ix6ZIFb3bQV/tZup2eSR9fEjE=;
        b=wIE5T0Yyb8V6CGYcfbh4MIELA8yGZ5AisMDdl2tqYX7PQFb7DBzpmB+EEssONCjuZ8
         ZNsXPW+UWpNtDYOcBaDhK3BP06d2a7P6sBShxceiTQj5SZLbMSIgt6JAYqGAUKolsOq7
         aE357w9FU6aCqUGcy4laF9GgBI1VYp/5r0Uhv1Kn79h882LfOXszbKCBZtfj5bG7CxFa
         ir5Fj6wdGkEV2hI2vCi9Unvl8eu6nB1mHCZ+EQn3/IApHhn0usryf9mYaHbXM+PKgCWv
         m7hhky9TboFjvtdPwXiYfXdmClk7S/9aZdk26JO4oo/qJVe2YAYnrb5MmqnYiISCnJhg
         hmlA==
X-Gm-Message-State: AFqh2kqeZIEyo9e71zgIChwroV0tcgodksJYgQyiNdv1pVtbxheu4jjl
        aLneVbtffQdjn8doYEaESu8TxQ==
X-Google-Smtp-Source: AMrXdXunaNSmvF24sA3mpkTnzyAxSSQqlgKz33L99W7wuvo753haLL+xzVFn6hjB2Li7pbF1fFW5Cg==
X-Received: by 2002:a5d:5954:0:b0:2bd:bdb5:baf1 with SMTP id e20-20020a5d5954000000b002bdbdb5baf1mr19905320wri.10.1674486800444;
        Mon, 23 Jan 2023 07:13:20 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d67c1000000b002bc7f64efa3sm34737922wrw.29.2023.01.23.07.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:13:20 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        - <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Chester Lin <clin@suse.com>, Fugang Duan <fugang.duan@nxp.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        Le Ray <erwan.leray@foss.st.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Tomer Maimon <tmaimon77@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 05/13] dt-bindings: serial: cdsn,uart: add power-domains
Date:   Mon, 23 Jan 2023 16:12:54 +0100
Message-Id: <20230123151302.368277-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123151302.368277-1-krzysztof.kozlowski@linaro.org>
References: <20230123151302.368277-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few Xilinx DTS have power domains in serial node:

  zynqmp-zc1232-revA.dtb: serial@ff000000: Unevaluated properties are not allowed ('power-domains' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/serial/cdns,uart.yaml   | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.yaml b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
index 0c118d5336cc..38925b79cb38 100644
--- a/Documentation/devicetree/bindings/serial/cdns,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
@@ -9,9 +9,6 @@ title: Cadence UART Controller
 maintainers:
   - Michal Simek <michal.simek@xilinx.com>
 
-allOf:
-  - $ref: serial.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -46,6 +43,9 @@ properties:
       port does not use this pin.
     type: boolean
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -53,6 +53,17 @@ required:
   - clocks
   - clock-names
 
+allOf:
+  - $ref: serial.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: cdns,uart-r1p8
+    then:
+      properties:
+        power-domains: false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1

