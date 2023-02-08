Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA91E68F7A5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 20:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjBHTCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 14:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjBHTCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 14:02:08 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29023521E3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:02:07 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id bg5-20020a05600c3c8500b003e00c739ce4so2244966wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 11:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhtvTc0wPw9laaTqlmODS/yBpdBNKxTbcXiqXHtjESY=;
        b=zT9GNWsi2Eh65XAFphieS0a8tZNQzjSKc4PCJfFPHIY33SjGnUfmWhSqzO3uBUuEwt
         lVxnR1rAo6CQXV2go0Sz91z4C1jB20za+7KIM3Okj4YopSpcZ/SxWAWgCmP3I1MRO4Py
         FiNJJLj1JyehKZaMs5xAyuzNPVGKz7QoqQhiBPotovIsNFHVZ/KUrOEjUUabgnMurPeB
         WWwUqgzhOJdmBAIHwhKIV63PBHdbs+hedPNuxmXG37v6DCczn6++QhJAyAKcNCo4J0xi
         zsoBuv1OXY2GRPcCIa9xf+axAtOOhPWmXsK2iiXqzYb4Sknltn/AjyBvTv+3xvOiW7jK
         inPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhtvTc0wPw9laaTqlmODS/yBpdBNKxTbcXiqXHtjESY=;
        b=xYQnhOa/O+uwc2k1jcGJaclw3wc5oOFMiPfd/rcClw7V9O5NtWFZ3eYLrhVfycbkKd
         /a8uBsO70gFkgJnYR8X76e9d4+KYwqu7vBTaMlGu0qVZnBOl8ISBjKrbmaJfXhWS2WLQ
         RF4G9bZPQAF348BOUEuWo/V71+sdfq4VacB+0mlmCvF3sCHtqSGrSpPCfh+VUf4fYYWL
         RweYI2fiH4SepX/yY1RGiH4Jwf1GklcOKDnUzzWKjo/vguu59kAXXJ4R7wYvszQ2KawD
         cb+m98/CfE2Cc1d4V5l61TdfYhJHsNJm4Z+VEdCFfFTP2JIiMW3mnCSY+MmPMs8eN6wv
         /rZw==
X-Gm-Message-State: AO0yUKWZMzYgHnqOhbIFsA4BlOZjIl8y/qv3kTRlNFoaeMNmQ1LdIbGu
        lsJSSoQHn65RtYrPj/SsfPgwfg==
X-Google-Smtp-Source: AK7set9aUTj24uA+NR/+P2LWDraZ1w/dDHyU0hwmFvER4RpzwAZoG/Q/4tFqRjtwQNJpfjWGiEuruQ==
X-Received: by 2002:a05:600c:3412:b0:3e0:481:c88f with SMTP id y18-20020a05600c341200b003e00481c88fmr10051103wmp.30.1675882925676;
        Wed, 08 Feb 2023 11:02:05 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id n16-20020a1c7210000000b003dc1d668866sm2650327wmc.10.2023.02.08.11.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 11:02:05 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/7] dt-bindings: phy: Add qcom,snps-eusb2-repeater schema file
Date:   Wed,  8 Feb 2023 21:01:54 +0200
Message-Id: <20230208190200.2966723-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230208190200.2966723-1-abel.vesa@linaro.org>
References: <20230208190200.2966723-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SM8550 SoC uses Synopsis eUSB2 repeater found in PM8550b.
Add a dt-binding schema for the new driver.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

The v4 is here:
https://lore.kernel.org/all/20230207135551.1418637-2-abel.vesa@linaro.org/

Changes since v4:
 * added Krzysztof R-b tag
 * added description about what the eUSB repeater does

Changes since v3:
 * made this patch the first one in the series to fix the binding check
   for the 2nd patch.
 * dropped the compatible for pmic in the example. This is due to the
   dependency between this patch and the next one.


 .../phy/qcom,snps-eusb2-repeater.yaml         | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml

diff --git a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
new file mode 100644
index 000000000000..083fda530b48
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/qcom,snps-eusb2-repeater.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Synopsis eUSB2 to USB 2.0 repeater
+
+maintainers:
+  - Abel Vesa <abel.vesa@linaro.org>
+
+description:
+  eUSB2 repeater converts between eUSB2 and USB 2.0 signaling levels and
+  allows a eUSB2 PHY to connect to legacy USB 2.0 products
+
+properties:
+  compatible:
+    const: qcom,pm8550b-eusb2-repeater
+
+  reg:
+    maxItems: 1
+
+  "#phy-cells":
+    const: 0
+
+  vdd18-supply: true
+
+  vdd3-supply: true
+
+required:
+  - compatible
+  - reg
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/spmi/spmi.h>
+
+    pmic@7 {
+      reg = <0x7 SPMI_USID>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      pm8550b_eusb2_repeater: phy@fd00 {
+        compatible = "qcom,pm8550b-eusb2-repeater";
+        reg = <0xfd00>;
+        #phy-cells = <0>;
+      };
+    };
+...
-- 
2.34.1

