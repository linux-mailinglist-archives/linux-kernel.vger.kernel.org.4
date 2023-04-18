Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12126E5DF9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjDRJzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjDRJzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:55:07 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F496E82
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 02:54:53 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-94a34a0b531so650881566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 02:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681811691; x=1684403691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQ8KevaU3QTxraZkfXWWkbBrnYMVguulcoi7GnzRXhI=;
        b=RPWTOocd+41sseJPEHA3IfI9DCZsYutqaxHBRwl1A6XNqRizzEsiS3XBM4oSfs28Fx
         zp3jXQscxLT9M2RbrTVwOuTrxQMYDyDX9f96fY/d72sqFtE2v0HyqeDmNLtRy49Qruj1
         pQgr50Y2nblqGHR96iDIL+a0quDDrVSPI7gZw577X7tgFZD+NJxStQ2KrKH8zc8n6250
         4erldJ7VJXMzt9vA+fR5s0Tr8r2lM7C+LTWYlQf4mDhdBFw2JItJx+P+rkzyswIJyQUN
         1x2fo67hg2v/S/SLs7C8zjKy5bfBM+CIQf3P14jbCMFR+28KcV90S62OO11lMszpAudO
         Ob6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681811691; x=1684403691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQ8KevaU3QTxraZkfXWWkbBrnYMVguulcoi7GnzRXhI=;
        b=YLoWSVc/C4pZYGMbqqE4R1FNH/DlX3ZyIKVOVbM6ZJCC5apGPa3gEHw7JYiwCxdr8G
         0avvfEgGjLPOL0w08JmltBeJoTD/tORLpmA0jPMpHld7sSoDb3NzhrCmYpZrkg68Ekf+
         +hL+rJ9WdNakIIh+paErVZxHX7thvotlkMjFdij6G71XHUbEE3/eiljPvP3pTzDzYZrA
         jMOtESlExFjLnuDwyAF2e6crQWP1wtKIUnt6+vG7daZw1DwiGtn94rkbnunKqaG4G9cS
         yCtopcv6Uc2B94pvz7hW1RqxYPXMchc9/WxkGt0EeWIbKtxB0jm5PILxl8VX6ZLGzAZF
         8rKA==
X-Gm-Message-State: AAQBX9d+0ryOFALfpepEQQ3pDHp0wqtfInSlIqvcjK+ByFkUnTymCVMx
        CM02PYIbem0KFi42SZYI5xrmOQ==
X-Google-Smtp-Source: AKy350ZJ2akv/lhLAIvrIXntFS6VWUAwO+3l1rJios+Izhwxd25Sw7+kk5nrVxaPll2aNsOcEwv3Zw==
X-Received: by 2002:aa7:c45a:0:b0:504:a2c8:ea60 with SMTP id n26-20020aa7c45a000000b00504a2c8ea60mr1740013edr.35.1681811691495;
        Tue, 18 Apr 2023 02:54:51 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id o4-20020a509b04000000b00504d04c939fsm7076578edi.59.2023.04.18.02.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 02:54:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/7] dt-bindings: soundwire: qcom: add Qualcomm Soundwire v2.0.0
Date:   Tue, 18 Apr 2023 11:54:41 +0200
Message-Id: <20230418095447.577001-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230418095447.577001-1-krzysztof.kozlowski@linaro.org>
References: <20230418095447.577001-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for Qualcomm Soundwire v2.0.0 controller, which comes
with several differences against v1.7.0 in register layout and more
ports (thus increase maxItems of each port-related property to 16).

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v2:
1. Add tags.

Changes since v1:
1. Increase maxItems to 16 for port-related properties.
---
 .../bindings/soundwire/qcom,soundwire.yaml    | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml b/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
index e4dba825ab11..98c7fc7e1189 100644
--- a/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
+++ b/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
@@ -21,6 +21,7 @@ properties:
       - qcom,soundwire-v1.5.1
       - qcom,soundwire-v1.6.0
       - qcom,soundwire-v1.7.0
+      - qcom,soundwire-v2.0.0
 
   reg:
     maxItems: 1
@@ -80,7 +81,7 @@ properties:
       or applicable for the respective data port.
       More info in MIPI Alliance SoundWire 1.0 Specifications.
     minItems: 3
-    maxItems: 8
+    maxItems: 16
 
   qcom,ports-sinterval-low:
     $ref: /schemas/types.yaml#/definitions/uint8-array
@@ -91,7 +92,7 @@ properties:
       or applicable for the respective data port.
       More info in MIPI Alliance SoundWire 1.0 Specifications.
     minItems: 3
-    maxItems: 8
+    maxItems: 16
 
   qcom,ports-offset1:
     $ref: /schemas/types.yaml#/definitions/uint8-array
@@ -102,7 +103,7 @@ properties:
       or applicable for the respective data port.
       More info in MIPI Alliance SoundWire 1.0 Specifications.
     minItems: 3
-    maxItems: 8
+    maxItems: 16
 
   qcom,ports-offset2:
     $ref: /schemas/types.yaml#/definitions/uint8-array
@@ -113,7 +114,7 @@ properties:
       or applicable for the respective data port.
       More info in MIPI Alliance SoundWire 1.0 Specifications.
     minItems: 3
-    maxItems: 8
+    maxItems: 16
 
   qcom,ports-lane-control:
     $ref: /schemas/types.yaml#/definitions/uint8-array
@@ -124,7 +125,7 @@ properties:
       or applicable for the respective data port.
       More info in MIPI Alliance SoundWire 1.0 Specifications.
     minItems: 3
-    maxItems: 8
+    maxItems: 16
 
   qcom,ports-block-pack-mode:
     $ref: /schemas/types.yaml#/definitions/uint8-array
@@ -137,7 +138,7 @@ properties:
       or applicable for the respective data port.
       More info in MIPI Alliance SoundWire 1.0 Specifications.
     minItems: 3
-    maxItems: 8
+    maxItems: 16
     items:
       oneOf:
         - minimum: 0
@@ -154,7 +155,7 @@ properties:
       or applicable for the respective data port.
       More info in MIPI Alliance SoundWire 1.0 Specifications.
     minItems: 3
-    maxItems: 8
+    maxItems: 16
     items:
       oneOf:
         - minimum: 0
@@ -171,7 +172,7 @@ properties:
       or applicable for the respective data port.
       More info in MIPI Alliance SoundWire 1.0 Specifications.
     minItems: 3
-    maxItems: 8
+    maxItems: 16
     items:
       oneOf:
         - minimum: 0
@@ -187,7 +188,7 @@ properties:
       or applicable for the respective data port.
       More info in MIPI Alliance SoundWire 1.0 Specifications.
     minItems: 3
-    maxItems: 8
+    maxItems: 16
     items:
       oneOf:
         - minimum: 0
-- 
2.34.1

