Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740E76388AC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiKYLXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiKYLWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:22:41 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA69BC9A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:22:35 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id n1so130733ljg.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLVXxybtNiyFGJ+Nz3UuGNMoFvM7nVnYJXqnnVuMIUY=;
        b=kTQcctEqy04RiYULAfoZli6NZCo2E3yfc4g+r7idj7sz9C0f+1kPKAYnUeVDBpGsbq
         RZDGb/MUm6w7PNrxL7MetDAk1eIuVP1SAZ8FaODUv4BEmGrxpBAJTnpFe2jjv/JCVzf8
         W5jrvbIi58/BYAJ9IPGfUK83LNqAEDE1WLQAdbeA/DP9Q++H4vL6n+NXsV4gxv5fnKMB
         VMBK8kshN9NSHaAiaNMTRYdv0GaNmcZrfLOpstGqsUkAfYaVMVeTJ/21+KHbfKlQyyM3
         ofM2onODJYA68CxMxPcuMxyAVp2V03hy+y+UhOXN5ZPrrAjkM4SZQHm82bcI1rCBKRFF
         ah6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLVXxybtNiyFGJ+Nz3UuGNMoFvM7nVnYJXqnnVuMIUY=;
        b=QfGnIzFo5/9/3wErjtnc+1FSbF6xi2FHETLXlU4EhZd9VeNlfgFVrdHu1yuCN3uq6Q
         nkPumpjkhBJPCaNqwc8v96n7l5y/ndqYkEXajsMMOPaoblMW511IVSy4wggs8F8TJwGL
         HHvx45Je8SMlL6sl+UZqTVVBR74IBa0Cs7rUoFGypxMAYNziZRa6uL46znfDT9I+IyIu
         atxM3G0eU6KYn8gLw5S6NUnw5XKWXDBALaUGcIgiqUqpDZR0dWuom5nudB+AlAhKPI3t
         GbnvM/yKvBPdbTEblmj8kTwICRZkvlbgDonPZSsWaA7aRMuCk61BKpcoVGxdSgVhhII4
         86Lw==
X-Gm-Message-State: ANoB5pkMkfZ6W766wRb0bQLE9clqHGEzdwgb5JCO5fhNFL+SMyRrXd3b
        3wepkYGVOcS1yHOEh6NgEkRKfw==
X-Google-Smtp-Source: AA0mqf52XQnsMtNSNyT9oAKjDwYBCarO4P6JwM2lsm2jXhEu5i/tbHDz+3XvThs4aUJqVh0fDDwYfA==
X-Received: by 2002:a2e:bf17:0:b0:277:394:34e with SMTP id c23-20020a2ebf17000000b002770394034emr5484045ljr.18.1669375353630;
        Fri, 25 Nov 2022 03:22:33 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c1-20020a056512074100b004a478c2f4desm483904lfs.163.2022.11.25.03.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 03:22:33 -0800 (PST)
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
Subject: [PATCH 2/4] dt-bindings: soc: samsung: exynos-sysreg: split from syscon
Date:   Fri, 25 Nov 2022 12:21:59 +0100
Message-Id: <20221125112201.240178-2-krzysztof.kozlowski@linaro.org>
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

Split Samsung Exynos SoC SYSREG bindings to own file to narrow the
bindings and do not allow other parts of syscon.yaml.  This allows
further customization of Samsung SoC bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Sriranjani P <sriranjani.p@samsung.com>
Cc: Chanho Park <chanho61.park@samsung.com>
Cc: Sam Protsenko <semen.protsenko@linaro.org>
---
 .../devicetree/bindings/mfd/syscon.yaml       |  6 ---
 .../soc/samsung/samsung,exynos-sysreg.yaml    | 39 +++++++++++++++++++
 2 files changed, 39 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 1b01bd010431..b73ba1ea08f7 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -64,12 +64,6 @@ properties:
               - rockchip,rk3568-qos
               - rockchip,rk3588-qos
               - rockchip,rv1126-qos
-              - samsung,exynos3-sysreg
-              - samsung,exynos4-sysreg
-              - samsung,exynos5-sysreg
-              - samsung,exynos5433-sysreg
-              - samsung,exynos850-sysreg
-              - samsung,exynosautov9-sysreg
 
           - const: syscon
 
diff --git a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
new file mode 100644
index 000000000000..68064a5e339c
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/samsung/samsung,exynos-sysreg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos SoC series System Registers (SYSREG)
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - samsung,exynos3-sysreg
+              - samsung,exynos4-sysreg
+              - samsung,exynos5-sysreg
+              - samsung,exynos5433-sysreg
+              - samsung,exynos850-sysreg
+              - samsung,exynosautov9-sysreg
+          - const: syscon
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    system-controller@10010000 {
+        compatible = "samsung,exynos4-sysreg", "syscon";
+        reg = <0x10010000 0x400>;
+    };
-- 
2.34.1

