Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692CE6388AD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiKYLXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiKYLWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:22:41 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B3EE0D2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:22:37 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id z4so4821851ljq.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQ/0iaidjrwAErPgZV7KfavzFSlKA7jOMFJg48+/n7s=;
        b=gwXpS+b3PHcPdSK1t8UGF3HSIoSW/ExTHv9RCn7Sh43VXek/50LHltfku32RBC50jb
         bRX0oTTXOgw0aqvEJJrDX+iuWbvvMfqwIi9im2noaNXDBvR2h8dBVR8IyBmQphs0Ld83
         8II4f3hW4AJjrTZlPYtqvgCbEKwxaWP4HB9Okb0xlSjnkdttTemNtIygmF7nl7Ap+0O0
         QE1Glo2j59ruRhKSPfz/8zJr0/KtgL4qFhORls20irZZFP3taG+8FeVLbqLRtReFnAIs
         ZDV3s6tGm7lOuyQCt0osKo1OfuXUZF3ogZPdTGUvPNX3nFx0inzcdnPuSYJu+9Ro9b8g
         97/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQ/0iaidjrwAErPgZV7KfavzFSlKA7jOMFJg48+/n7s=;
        b=FeR4zIIseBKbG1BjrmTK6tyaxvr1xTRKTvTCrL2QDWS/jh1i3ec+O5UDiYvKvg+DpN
         +8nQJZGQvFHHJ0frazMpyR8OWnn+3dqABZVkL0HM+F9PiigLUHxOi1dROw3TyjQQcqaB
         XcD8iUauD0mLgFGbby13vobLZB2g4BL5KeVVdh+SBbMZyqHvVrSpAI8nGFZiPoagS6IS
         zukDVjrVnSzF03aON/X9MBiSTFQ5Re3QSDWkxAARKWri39Iz9fcFECrOIQCaaGq94Cw2
         lylkW0QUUVovDAdMxcgvXXHPZa/288hb+IjD/Mc45Sa0velsWmSPjUoah4MOYcg7BEs4
         ve7g==
X-Gm-Message-State: ANoB5pl0kC8DPMidS2PpffFO+jj7QTYukSIefIAcXUP7jjYh4bQMtN4P
        aiP4ltPqt1saK8wGRXFuFPgVbg==
X-Google-Smtp-Source: AA0mqf4Hkwe4H/vLtfLCeT7OTu+xc2bljnqQr7M0x6kMg0rrOGjRTbYXrL43oxNfs0wQ40G6aEX8ow==
X-Received: by 2002:a2e:9789:0:b0:277:41d:6c1e with SMTP id y9-20020a2e9789000000b00277041d6c1emr11294977lji.330.1669375355712;
        Fri, 25 Nov 2022 03:22:35 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c1-20020a056512074100b004a478c2f4desm483904lfs.163.2022.11.25.03.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 03:22:35 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sriranjani P <sriranjani.p@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH 4/4] dt-bindings: soc: samsung: exynos-sysreg: add clocks for Exynos850
Date:   Fri, 25 Nov 2022 12:22:01 +0100
Message-Id: <20221125112201.240178-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221125112201.240178-1-krzysztof.kozlowski@linaro.org>
References: <20221125112201.240178-1-krzysztof.kozlowski@linaro.org>
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

Exynos850 has dedicated clock for accessing SYSREGs.  Allow it, even
though Linux currently does not enable them and relies on bootloader.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Sriranjani P <sriranjani.p@samsung.com>
Cc: Chanho Park <chanho61.park@samsung.com>
Cc: Sam Protsenko <semen.protsenko@linaro.org>
---
 .../soc/samsung/samsung,exynos-sysreg.yaml        | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
index 42357466005e..27cea934a286 100644
--- a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
@@ -36,10 +36,25 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+
 required:
   - compatible
   - reg
 
+allOf:
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - samsung,exynos850-sysreg
+    then:
+      properties:
+        clocks: false
+
 additionalProperties: false
 
 examples:
-- 
2.34.1

