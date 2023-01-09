Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC7E663563
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbjAIXgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbjAIXf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:35:58 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FCA6442
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 15:35:57 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id p17so7471181qvn.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 15:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWfOKCoKa6fVAUu6wQ1ieIdGSmrl8W8A2HgAxf0hwpE=;
        b=bvtIZBszxda3SApy+Vt245BDingr6VZTIE0uCE8ugMrSsv+pvqEUruYgswQfXSdXNC
         VAmuqsJCdrrXukhir+jfqy8l19M5PrfFk69mRqg9raoPIPug6x1o6cRVtZeAcf/lOLoW
         7Cgg+TicuwJrkCt5Sqy5P5530IM+waDzfGZ1yMxP1Bhq+TjdXyNkEBDiPUXqqJtq5za/
         5ax6j0+xghsb2p/NVTdAbJPQrBnzzSRRzhpfdWhVDR20+0j0LFf7xuI7fjcJsyYZBgAd
         stdkfOLeBElQnrxjBCk5Qbkot5Uojaw2N8f1rxRdMveNL9PTyrPQK8hy1aaRoLP9lGgp
         EuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWfOKCoKa6fVAUu6wQ1ieIdGSmrl8W8A2HgAxf0hwpE=;
        b=XisB/2FSjLlRiIjA30/Bo2FX8FwVVTU+tVlVfRqw2O4EEmBmDB8Zb5MBZ0H8y+95Hq
         rT2SJRFrsO2Cha4FK4qkD1BYZjREPsdhX5/agRj0mN7A8MY3ntPHxni4XKiB5MCh03Jj
         PtEHCIgeYdZv/b3RFvCCNHtxluBwUbPUQNxrRjbRFXScSwI+8kgjN2/XAN2oHxq5PwX8
         U8+JHL9vK7e0DePFfHPMAw6eL0PhDIf1w9MKiVK2QQTBe2zPzmcP68cYUXFsSUGqA91j
         z1X2A4sa7BI0NOpsK0v5IWLKuQl+mAOX3rjNeyMsrkSiAG9S/x2bFQA2go7myL7sldGo
         fxqg==
X-Gm-Message-State: AFqh2kpqCr5q0ZcTstF1dgWCUBOk5IcW7PSdcOZEL7LqFvnVm01LrRrN
        PAhmxnVC9eb5PeIQNa8OE6JaBA==
X-Google-Smtp-Source: AMrXdXs/rF2/7d4tbX4eiwWCEqNoi1JKKTU7hd5nGyVo6/fHYoOLbHXFadfBW4oZivtIGTPI+Nn6wQ==
X-Received: by 2002:a05:6214:c6c:b0:50e:48cc:a95a with SMTP id t12-20020a0562140c6c00b0050e48cca95amr123111751qvj.43.1673307356280;
        Mon, 09 Jan 2023 15:35:56 -0800 (PST)
Received: from jcormier-MS-7A93.syr.criticallink.com (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id t5-20020a05620a450500b006fa8299b4d5sm6294846qkp.100.2023.01.09.15.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 15:35:55 -0800 (PST)
From:   Jonathan Cormier <jcormier@criticallink.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Jonathan Cormier <jcormier@criticallink.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bob Duke <bduke@criticallink.com>,
        John Pruitt <jpruitt@criticallink.com>
Subject: [PATCH v3 1/5] dt-bindings: hwmon: adi,ltc2945: Add binding
Date:   Mon,  9 Jan 2023 18:35:30 -0500
Message-Id: <20230109233534.1932370-2-jcormier@criticallink.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230109233534.1932370-1-jcormier@criticallink.com>
References: <20221214220727.1350784-3-jcormier@criticallink.com>
 <20230109233534.1932370-1-jcormier@criticallink.com>
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

Create initial binding for the LTC2945 I2C power monitor.
Add shunt-resistor-micro-ohms parameter

Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
---
 .../bindings/hwmon/adi,ltc2945.yaml           | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml b/Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml
new file mode 100644
index 000000000000..5cb66e97e816
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/adi,ltc2945.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices LTC2945 wide range i2c power monitor
+
+maintainers:
+  - Guenter Roeck <linux@roeck-us.net>
+
+description: |
+  Analog Devices LTC2945 wide range i2c power monitor over I2C.
+
+  https://www.analog.com/media/en/technical-documentation/data-sheets/LTC2945.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ltc2945
+
+  reg:
+    maxItems: 1
+
+  shunt-resistor-micro-ohms:
+    description:
+      Shunt resistor value in micro-Ohms
+    default: 1000
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        power-monitor@6e {
+            compatible = "adi,ltc2945";
+            reg = <0x6e>;
+            /* 10 milli-Ohm shunt resistor */
+            shunt-resistor-micro-ohms = <10000>;
+        };
+    };
+...
-- 
2.25.1

