Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6986D2626
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 18:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjCaQsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 12:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjCaQrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 12:47:51 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CC824ADA
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:45:37 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id y15so29682688lfa.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680281136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Kmz3C998WVao4UkbIae7gw0Yw5Zh6htrgN/X3GXY8I=;
        b=tivHTCPqdm0bY2kwozGD/QKWMPIb4CuzLIrFj6DOOFKH+FS/YBDS6OLXylZ1y7gm+S
         tjKAFVIhipHhsmQfyAP5qbX38bWcEnP0af54QH9EV5cRmpJdI1572usURQpvu2RZ6IPO
         weos0BDITJkFYi1iXLYZHzpWPWA06UmK68B1zBfiuYu9DVNuS8Wwx4qEk9THlUNdwL7c
         MljcC60TCHbqqo41ZZboSTkLifNmYXc8a4DZ9OFM5CMId2ar+QCIzGmKKJqUGYLyoQG/
         jSaKGL/J4CLMrYhFODT+GksZTq88ceIkmFLaEr616/mHkmySapxTt18oUvsuBVTxT+xH
         gwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680281136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Kmz3C998WVao4UkbIae7gw0Yw5Zh6htrgN/X3GXY8I=;
        b=fMjW91VMlTG1zdZ1NNl1Ry1jxpf0fApXadrYUww63STOAOw3N3Oh9tS9Lktj50QyCv
         U6iLD71BRwL01dBuBPjwOEhKjm1pOQJU/tLgQGDL4efzoIsSrJRfXmdjiBrrCHdMTfny
         dGgmxWNQ406gx+rnGnZjddf3paxLj08/ldgQzMiAlsH3g6Es2Q3i+cz0i0mBAqVq3QwO
         49O0nJP4kVyShR30zpdoerk2/d63znLq8QePXqYF/jSfDtujL3ZV0JXrxu4K93HfNtFp
         I6//KKDvDcJwmZUlRP+OuyHVdKR/zQRYg8NfpEgKp2sFqU1zClpSK3uHC4X63/GfZkXB
         bByg==
X-Gm-Message-State: AAQBX9dmyeot1uW7OrVcWIgBXDQM3Fg2Osa+g2UaEaQZwdcE/MS2tcnu
        6bkrdgxVBdMjS48ai5ahS7mVrA==
X-Google-Smtp-Source: AKy350bA3F8gy4HD9rUqIR1YmyE+ZIZu7WvWnQcjUjVMMPVpvex7vCu0y68oxuXMTOpqpqKXChytIA==
X-Received: by 2002:a05:6512:961:b0:4eb:274b:a69 with SMTP id v1-20020a056512096100b004eb274b0a69mr1754798lft.26.1680281135816;
        Fri, 31 Mar 2023 09:45:35 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u26-20020ac2519a000000b004e8483bff82sm439872lfi.271.2023.03.31.09.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 09:45:35 -0700 (PDT)
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
Cc:     Patrick Lai <quic_plai@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/7] dt-bindings: soundwire: qcom: add 16-bit sample interval
Date:   Fri, 31 Mar 2023 18:45:24 +0200
Message-Id: <20230331164530.227302-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The port sample interval was always 16-bit, split into low and high
bytes.  This split was unnecessary, although harmless for older devices
because all of them used only lower byte (so values < 0xff).  With
support for Soundwire controller on Qualcomm SM8550 and its devices,
both bytes will be used, thus add a new 'qcom,ports-sinterval' property
to allow 16-bit sample intervals.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/soundwire/qcom,soundwire.yaml    | 22 +++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml b/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
index 3efdc192ab01..e2acfd09fb22 100644
--- a/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
+++ b/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
@@ -85,7 +85,7 @@ properties:
   qcom,ports-sinterval-low:
     $ref: /schemas/types.yaml#/definitions/uint8-array
     description:
-      Sample interval low of each data port.
+      Sample interval (only lowest byte) of each data port.
       Out ports followed by In ports. Used for Sample Interval calculation.
       Value of 0xff indicates that this option is not implemented
       or applicable for the respective data port.
@@ -93,6 +93,19 @@ properties:
     minItems: 3
     maxItems: 8
 
+  qcom,ports-sinterval:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      Sample interval of each data port.
+      Out ports followed by In ports. Used for Sample Interval calculation.
+      Value of 0xffff indicates that this option is not implemented
+      or applicable for the respective data port.
+      More info in MIPI Alliance SoundWire 1.0 Specifications.
+    minItems: 3
+    maxItems: 8
+    items:
+      maximum: 0xffff
+
   qcom,ports-offset1:
     $ref: /schemas/types.yaml#/definitions/uint8-array
     description:
@@ -218,10 +231,15 @@ required:
   - '#size-cells'
   - qcom,dout-ports
   - qcom,din-ports
-  - qcom,ports-sinterval-low
   - qcom,ports-offset1
   - qcom,ports-offset2
 
+oneOf:
+  - required:
+      - qcom,ports-sinterval
+  - required:
+      - qcom,ports-sinterval-low
+
 additionalProperties: false
 
 examples:
-- 
2.34.1

