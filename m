Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9B46793E0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 10:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbjAXJTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 04:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbjAXJTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 04:19:47 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFCB3F2A6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 01:19:44 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so12366048wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 01:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nb5CwN4fN4XTwRx3Tj+I+Ommhby0lGr2iuTrQcxIb/0=;
        b=Erz+EhOmyjtVC8y8TD1tzEzfeEI+tUpI6auPlhOS+L8rFcrpspoGstb2EvkLgGuuAp
         DpKD+EnP0qVzHF5BpeHg6bzd83CFhVrmFGWodo0QhT85JTbjUDY9rlI2F2q9CqFUqE8H
         Mo/TmRVuwZRoWTTKcd5YrFHbXefcW6Vjg15ub+DUMbZ5/zXbGi+oynGVNw7VL8aiHpzk
         yRUkxDf57i6EJjuOmrAQh0V5XQ3cJSG/q6lOFE89YcI0jNM4Yd9chTApm8BS3Tp2Lz0c
         ytWEkYuRtJnN5GvA0nQYxCJPky8Tviyyop+mibt4vI/EKUDqf+YKvXMhb1EO2OGo3A4D
         EEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nb5CwN4fN4XTwRx3Tj+I+Ommhby0lGr2iuTrQcxIb/0=;
        b=eZ65uaZXG8lSHOR8d1O//0hXOZsqpH8G54mLm2p1q3KpR9dZGI3MAgyubk6k82BAcr
         bD8LvK+M6KU1KOKFDzB1LKshlDSZ1DpyGREtQO3EXVM3GEqlkBvkjL7tXAiAeI6vvhSm
         pL/vSasoW/DX+96+yL6lfAtvsj1yZUAI1Aw9x4fx/CR68cK7xe6+JNB/PsxOdd2JbNJZ
         FoXjJltruR9S4qLoN7zBSD7Og9bXvRk/oLJbxtsxuIrJJx0J+X/6jCsCiN0plf/JCLJz
         1AK4rhLrJxYC/FO3GAFBRA9kbozTM+ahNgxbbE5BMCUdZH39HtflTFJr/HxqVdgOm6Kl
         BKcQ==
X-Gm-Message-State: AFqh2krQ/FTVGVySWJKhV9EZPAPdw+pAF8cq2l83dymqAcRMUtszNqlP
        l4o+UhcbiXsLs9sMI3iXEE7iCw==
X-Google-Smtp-Source: AMrXdXtDAh7QFXNJKNHeXnVkYsOgnO5HNUP0pkqugffnYolM/QSylK27RP72alQg+Wi0pRiLhcw4xg==
X-Received: by 2002:a05:600c:4928:b0:3da:909f:1f6b with SMTP id f40-20020a05600c492800b003da909f1f6bmr27413613wmp.1.1674551983490;
        Tue, 24 Jan 2023 01:19:43 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i22-20020a05600c355600b003a84375d0d1sm13672242wmq.44.2023.01.24.01.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 01:19:42 -0800 (PST)
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
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Chester Lin <clin@suse.com>, Fugang Duan <fugang.duan@nxp.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        Le Ray <erwan.leray@foss.st.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Tomer Maimon <tmaimon77@gmail.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michal Simek <michal.simek@amd.com>
Subject: [PATCH v2 04/12] dt-bindings: serial: correct ref to serial.yaml
Date:   Tue, 24 Jan 2023 10:19:08 +0100
Message-Id: <20230124091916.45054-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230124091602.44027-1-krzysztof.kozlowski@linaro.org>
References: <20230124091602.44027-1-krzysztof.kozlowski@linaro.org>
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

The serial bindings should reference the local (in kernel) serial.yaml,
not the /schemas/serial.yaml.  The latter comes from dtschema package
and is a small subset of serial bindings.

Usage of the local serial.yaml allows typical properties and children:

  xilinx/avnet-ultra96-rev1.dtb: serial@ff000000: Unevaluated properties are not allowed ('bluetooth' were unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Michal Simek <michal.simek@amd.com>
---
 Documentation/devicetree/bindings/serial/cdns,uart.yaml         | 2 +-
 Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.yaml b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
index 876b8cf1cafb..0c118d5336cc 100644
--- a/Documentation/devicetree/bindings/serial/cdns,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Michal Simek <michal.simek@xilinx.com>
 
 allOf:
-  - $ref: /schemas/serial.yaml#
+  - $ref: serial.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml b/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
index 2f4390e8d4e8..6f65e9a81c29 100644
--- a/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
+++ b/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
@@ -63,7 +63,7 @@ required:
   - xlnx,use-parity
 
 allOf:
-  - $ref: /schemas/serial.yaml#
+  - $ref: serial.yaml#
   - if:
       properties:
         xlnx,use-parity:
-- 
2.34.1

