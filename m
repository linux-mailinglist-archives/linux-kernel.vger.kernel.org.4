Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D436E38E7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 15:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjDPNgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 09:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjDPNgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 09:36:24 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C416D4239;
        Sun, 16 Apr 2023 06:36:00 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id fw30so4675975ejc.5;
        Sun, 16 Apr 2023 06:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681652159; x=1684244159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Deq7iuiEl1RFyBysVZfY7LGeNc11tLOLC+fdaC0CAMg=;
        b=qEtVp1Z9nM6S8XbiJoCplRphuYpTjtmHGzrpd3ybx9pO5OzPHfLtuiS13LO3vQ9s/Q
         qoGy9AGmRbHe2T+uJpbJ/XB0fxB1oGjkmtRpD4i96E5Rbo336OvHKjIXQzJEQrOFz7je
         CzTcaRxn5wNjZq1KcN3EJh7GyzU/hPTpuhu0T0zgHUQALHuTKhyq3BKeAHRhL4qrfd6J
         P0LYKAp3jaS7077nis0aCe2ogPsmY5wIW8o7nQ/a/1RoNjjwH5zBKw6wmXDxlGBBJghY
         pKHDr2rKHpXlHKuaBu7qSr0eECmm8EXndI3L+x9b/M+GTy1Dwmo83Q4jHFsQ8k7SbdfD
         Dodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681652159; x=1684244159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Deq7iuiEl1RFyBysVZfY7LGeNc11tLOLC+fdaC0CAMg=;
        b=VAVYf+ejl1/yaYilU40pickSGh5Sn7kHdy8VkYzdJE5K2oc/VhU1I8yW5POxlsluUl
         tnuC26yfhEx2KP8JS5qvf0TiGUbeXozPa0whMQjAHLsoWqUumUF8ybatHclU0Jo3rBbZ
         DRWPHrvDm5elKhIF1SCyH7AoxgEL0EyjevBhEc3ZjilS33WpKpURGuHrhPY+cKc++JTD
         MD6dvZZDb+hM4qxmlMiHWxdexztxGxdsbIqS7FljgnWg8WriOan+I0EPbMQZtMobDLgO
         0sRSczD1E2cCIygFODoeKSri2v9srJTq/jKEBWuv1eIe7W4kx7T8ynhmfXlvI1tsTF2b
         VGDA==
X-Gm-Message-State: AAQBX9f//aQZ3GM81XHgGO4sfRSSZLTTxn6Pm6CM+HstdfRMZJtcIVdR
        oCQ2kKKmHA+yP2oOVcsppg0FAn/42hlfIA==
X-Google-Smtp-Source: AKy350YadAm7tYLBr5BAsWXMhacr0mRYLnOX0Qe6f1ZBtmunodwY56V4KNqFq5dzyif3Jjvu2yo61Q==
X-Received: by 2002:a17:906:d1c3:b0:94f:26bd:e005 with SMTP id bs3-20020a170906d1c300b0094f26bde005mr3562160ejb.9.1681652158836;
        Sun, 16 Apr 2023 06:35:58 -0700 (PDT)
Received: from localhost.my.domain (83.8.121.70.ipv4.supernova.orange.pl. [83.8.121.70])
        by smtp.gmail.com with ESMTPSA id gn23-20020a1709070d1700b009373f1b5c4esm5122958ejc.161.2023.04.16.06.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 06:35:58 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        linux-phy@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH v2 11/12] dt-bindings: arm: samsung: Add Samsung Galaxy Tab3 family boards
Date:   Sun, 16 Apr 2023 15:34:21 +0200
Message-Id: <20230416133422.1949-12-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230416133422.1949-1-aweber.kernel@gmail.com>
References: <20230416133422.1949-1-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible strings for the Samsung Galaxy Tab 3 8.0 series
of tablets.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 .../bindings/arm/samsung/samsung-boards.yaml           | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
index deb2cf971871..4ee026e7f7ad 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
@@ -104,6 +104,16 @@ properties:
           - const: samsung,exynos4412
           - const: samsung,exynos4
 
+      - description: Samsung Tab3 family boards
+        items:
+          - enum:
+              - samsung,t310                    # Samsung Galaxy Tab 3 8.0 WiFi (SM-T310)
+              - samsung,t311                    # Samsung Galaxy Tab 3 8.0 3G (SM-T311)
+              - samsung,t315                    # Samsung Galaxy Tab 3 8.0 LTE (SM-T315)
+          - const: samsung,tab3
+          - const: samsung,exynos4212
+          - const: samsung,exynos4
+
       - description: Exynos5250 based boards
         items:
           - enum:
-- 
2.40.0

