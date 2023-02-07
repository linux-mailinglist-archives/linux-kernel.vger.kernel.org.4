Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3012B68D235
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjBGJJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjBGJJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:09:07 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4577738028
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 01:09:01 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id m14so12789987wrg.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 01:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+V0td+k3vRfEw8Bu9Jwul2CDS45uwWMuZ82IxvYQ6WQ=;
        b=OldwJ0dzfzAiJ/yq4f8d8hWeAhv6lFumKWcuUAgXu3zBot1pLn95KHNJqsV/FY9qRJ
         Ll4czwMLLuFhsCnwk+HbpwwjLdWwa7vZcRXwZ9zZpZ5UQhQZgJMUrojwPUhkYPCcLqm/
         R0B8Kv3WhRH7FRiUyK2OUiJwXBkGR3d6Zc7+PxkRnX25GQXTJ6c+cnvfYXLSGccO2HSU
         FidQj/xLlgnNFN8YSQiTUglTbOkMNouPa4BLBMn2FvL2mIIODj4i2Qa1YE7sPgyH7U53
         2iZloq/WpRiq3ypfiFbu9RubJjOpBMug1eFBifbM1IxiGieKXeYEJRZ0wx+XWqpO+zUe
         eZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+V0td+k3vRfEw8Bu9Jwul2CDS45uwWMuZ82IxvYQ6WQ=;
        b=AkGHQ89o2+7Lo/fALmf/jGyIn+LFYoPDdafSj2TBjY3USeO8UOiPeoCCv3cdBToriK
         U5Jn6K3mWGC2MQz2SpXB0/RGp6Mxqj9BNbN0bI4QxDRN1KG/VhcrldxOu7CIK6Fi+KbL
         Xjcm9P2mGzWipaOzPhBZ6Sktw/Sx4NgkNy7jT9f4p+dBdfaFv6TROEO/HeSbn41UsekC
         Pe37uz0idEjUTdSYiC0SakVO44xgoQ+AEAUYgy/2i+ImmKY0NPw4MST/JC0yipQNyZKn
         YNE/W7Ze/2DLCQUUPQ/mNIL+rmxE+KeA3gQ2DQz3bnWF5EaWTxSNUD6ralfhRh8vlQUw
         2jjw==
X-Gm-Message-State: AO0yUKVhA1sjOWH7jqQInlqcC+9Y98ZO5uSjCIIHmsdrNGhlYaoMdTcy
        YTmuRtuKxOP3Zoido72BIEdZVA==
X-Google-Smtp-Source: AK7set9IbF+NHMd5cv0T0d1PstlMEWms36q701YcY/vQfkxkhI+gakmbLfqxVDP+CJ9M9ei73BvmEA==
X-Received: by 2002:adf:f38e:0:b0:2c3:eaff:aaf0 with SMTP id m14-20020adff38e000000b002c3eaffaaf0mr1763722wro.16.1675760939794;
        Tue, 07 Feb 2023 01:08:59 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h3-20020a056000000300b002c3e5652744sm5081955wrx.46.2023.02.07.01.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 01:08:59 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/5] dt-bindings: remoteproc: qcom,glink-rpm-edge: convert to DT schema
Date:   Tue,  7 Feb 2023 10:08:51 +0100
Message-Id: <20230207090852.28421-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230207090852.28421-1-krzysztof.kozlowski@linaro.org>
References: <20230207090852.28421-1-krzysztof.kozlowski@linaro.org>
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
 .../remoteproc/qcom,glink-rpm-edge.yaml       | 92 ++++++++++++++++++
 .../bindings/soc/qcom/qcom,glink.txt          | 94 -------------------
 2 files changed, 92 insertions(+), 94 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,glink-rpm-edge.yaml
 delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,glink-rpm-edge.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,glink-rpm-edge.yaml
new file mode 100644
index 000000000000..07cd67ec97c1
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,glink-rpm-edge.yaml
@@ -0,0 +1,92 @@
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
+      RPM message memory resource (compatible:: qcom,rpm-msg-ram).
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
+        $ref: /schemas/types.yaml#/definitions/uint32-array
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

