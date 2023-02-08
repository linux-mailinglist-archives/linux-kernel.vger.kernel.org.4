Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6F468EC99
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjBHKQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjBHKQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:16:03 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342DB4390B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 02:16:01 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so1052929wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 02:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adTl94APknDnu5iGaupYfmKo8FkuD8SwaKoEr2aG59Q=;
        b=bQ904evB0Dbvio9KDLzHttH4Ne823Yrwxb8Zk78lufyfvfmEeiynZzJGjjzzFm7IqL
         C0gx40OGU9YJjrJEI7XEa9eJrfdy+oCoRAjSktizRl4+OKNzDJV7eNaKOowkxOLXXqV9
         dPWSSvVGkln/uQdcZEow6mMmasTSgyXtpQEuj0I/7oKYyRkDbIUMg/v0bN21fChXk5iP
         htmZmk5fODi+N8QG4XHh1iWzmrFvvQ+TYQXCZ8JMbVEgaJc6kQtGEyqzi4ZU5LX+cV/A
         E5PbSA6d2Ps+QkkfBfjKp7UP1aq/mMiRlVtr1gUQUSuwGU+RLNn5BMny1lO4L0Hk2CfH
         WWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adTl94APknDnu5iGaupYfmKo8FkuD8SwaKoEr2aG59Q=;
        b=p8ldqzJ4oQcNPn065rXjn1Aa+XlqQGkBkAhHszzJuxmXQjTHPtGj+YSRxPQQBlxsL0
         LE9MJQSKQm6KtguVTwxzJKbv97dQ1WHHSZfUGCPIJ6mdpW+Z0mAND8OEBc7ZBzGrzWpf
         TWQltOBFfg1acZ5W4kD8aHku1cYnA6bh4j6l/sfa2opGd6CxhtN42CrrJU5tszg1Gf5/
         qaOYFRR2bK2HxIG3S9sZ4tSdDE1lPTLdiFSUAGtGHCRihJvSpuH6sb7f0sIKbxjNcyTF
         e4Rl+9d2RvDfphEN6vVjCpGHaXfRgDBfo3nflktDToUowLQoo0SI6rgGofrxWNYRRSqS
         Q1UA==
X-Gm-Message-State: AO0yUKWYk/VMi0p20aFID2f4p9BYSFNyyzyQK1LED44UYiklFH1iyi+6
        5HZzj0UOjmZWxQbYMcTZSBk2pQ==
X-Google-Smtp-Source: AK7set/szvmHKGrN7NwTRdzvBqRm7ePHGlF7HnajiFVr/G/36ChpjyTPO+VnAiBnTf0G91EFJwVfJQ==
X-Received: by 2002:a05:600c:990:b0:3dc:5abb:2f50 with SMTP id w16-20020a05600c099000b003dc5abb2f50mr5866654wmp.19.1675851359710;
        Wed, 08 Feb 2023 02:15:59 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c198e00b003dc4ecfc4d7sm1496328wmq.29.2023.02.08.02.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 02:15:59 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 6/7] dt-bindings: remoteproc: qcom,glink-rpm-edge: convert to DT schema
Date:   Wed,  8 Feb 2023 11:15:44 +0100
Message-Id: <20230208101545.45711-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230208101545.45711-1-krzysztof.kozlowski@linaro.org>
References: <20230208101545.45711-1-krzysztof.kozlowski@linaro.org>
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

Convert Qualcomm G-Link RPM edge binding to DT schema.  Move it to
remoteproc as it better suits the purpose - communication channel with
remote processor.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. :: -> :
2. Correct qcom,intents type.

There are no strict dependencies on other patches, but the previous
"qcom,apcs-kpss-global" should end up in the same cycle (or earlier) as
this one.
---
 .../remoteproc/qcom,glink-rpm-edge.yaml       | 99 +++++++++++++++++++
 .../bindings/soc/qcom/qcom,glink.txt          | 94 ------------------
 2 files changed, 99 insertions(+), 94 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,glink-rpm-edge.yaml
 delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,glink-rpm-edge.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,glink-rpm-edge.yaml
new file mode 100644
index 000000000000..f5a044e20c4e
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,glink-rpm-edge.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,glink-rpm-edge.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm G-Link RPM edge
+
+description: |
+  Qualcomm G-Link edge, a FIFO based mechanism for communication with Resource
+  Power Manager (RPM) on various Qualcomm platforms.
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+
+properties:
+  compatible:
+    const: qcom,glink-rpm
+
+  label:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Name of the edge, used for debugging and identification purposes. The
+      node name will be used if this is not present.
+
+  interrupts:
+    maxItems: 1
+
+  mboxes:
+    items:
+      - description: rpm_hlos mailbox in APCS
+
+  qcom,remote-pid:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The identifier for the remote processor as known by the rest of the
+      system.
+
+  qcom,rpm-msg-ram:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      RPM message memory resource (compatible: qcom,rpm-msg-ram).
+
+  rpm-requests:
+    type: object
+    $ref: /schemas/soc/qcom/qcom,smd-rpm.yaml#
+    unevaluatedProperties: false
+    description:
+      Qualcomm Resource Power Manager (RPM) over G-Link
+
+    properties:
+      qcom,intents:
+        $ref: /schemas/types.yaml#/definitions/uint32-matrix
+        minItems: 1
+        maxItems: 32
+        items:
+          items:
+            - description: size of each intent to preallocate
+            - description: amount of intents to preallocate
+              minimum: 1
+        description:
+          List of (size, amount) pairs describing what intents should be
+          preallocated for this virtual channel. This can be used to tweak the
+          default intents available for the channel to meet expectations of the
+          remote.
+
+    required:
+      - qcom,glink-channels
+
+required:
+  - compatible
+  - interrupts
+  - mboxes
+
+anyOf:
+  - required:
+      - qcom,remote-pid
+  - required:
+      - qcom,rpm-msg-ram
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    rpm-glink {
+        compatible = "qcom,glink-rpm";
+        interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+        mboxes = <&apcs_glb 0>;
+        qcom,rpm-msg-ram = <&rpm_msg_ram>;
+
+        rpm-requests {
+            compatible = "qcom,rpm-msm8996";
+            qcom,glink-channels = "rpm_requests";
+
+            /* ... */
+        };
+    };
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
deleted file mode 100644
index 1214192847ac..000000000000
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
+++ /dev/null
@@ -1,94 +0,0 @@
-Qualcomm GLINK edge binding
-
-This binding describes a Qualcomm GLINK edge, a fifo based mechanism for
-communication between subsystem-pairs on various Qualcomm platforms. Two types
-of edges can be described by the binding; the GLINK RPM edge and a SMEM based
-edge.
-
-- compatible:
-	Usage: required for glink-rpm
-	Value type: <stringlist>
-	Definition: must be "qcom,glink-rpm"
-
-- label:
-	Usage: optional
-	Value type: <string>
-	Definition: should specify the subsystem name this edge corresponds to.
-
-- interrupts:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: should specify the IRQ used by the remote processor to
-		    signal this processor about communication related events
-
-- qcom,remote-pid:
-	Usage: required for glink-smem
-	Value type: <u32>
-	Definition: specifies the identifier of the remote endpoint of this edge
-
-- qcom,rpm-msg-ram:
-	Usage: required for glink-rpm
-	Value type: <prop-encoded-array>
-	Definition: handle to RPM message memory resource
-
-- mboxes:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: reference to the "rpm_hlos" mailbox in APCS, as described
-		    in mailbox/mailbox.txt
-
-= GLINK DEVICES
-Each subnode of the GLINK node represent function tied to a virtual
-communication channel. The name of the nodes are not important. The properties
-of these nodes are defined by the individual bindings for the specific function
-- but must contain the following property:
-
-- qcom,glink-channels:
-	Usage: required
-	Value type: <stringlist>
-	Definition: a list of channels tied to this function, used for matching
-		    the function to a set of virtual channels
-
-- qcom,intents:
-	Usage: optional
-	Value type: <prop-encoded-array>
-	Definition: a list of size,amount pairs describing what intents should
-		    be preallocated for this virtual channel. This can be used
-		    to tweak the default intents available for the channel to
-		    meet expectations of the remote.
-
-= EXAMPLE
-The following example represents the GLINK RPM node on a MSM8996 device, with
-the function for the "rpm_request" channel defined, which is used for
-regulators and root clocks.
-
-	apcs_glb: mailbox@9820000 {
-		compatible = "qcom,msm8996-apcs-hmss-global";
-		reg = <0x9820000 0x1000>;
-
-		#mbox-cells = <1>;
-	};
-
-	rpm_msg_ram: memory@68000 {
-		compatible = "qcom,rpm-msg-ram";
-		reg = <0x68000 0x6000>;
-	};
-
-	rpm-glink {
-		compatible = "qcom,glink-rpm";
-
-		interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
-
-		qcom,rpm-msg-ram = <&rpm_msg_ram>;
-
-		mboxes = <&apcs_glb 0>;
-
-		rpm-requests {
-			compatible = "qcom,rpm-msm8996";
-			qcom,glink-channels = "rpm_requests";
-
-			qcom,intents = <0x400 5
-					0x800 1>;
-			...
-		};
-	};
-- 
2.34.1

