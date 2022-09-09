Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70435B384A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbiIIMyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiIIMye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:54:34 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786AA110AAF
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 05:54:21 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id m15so2493278lfl.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 05:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=wCnjqrj2GGGlSBoOXRHfEq6CD5MpxnVT3q6Lv2UyXSE=;
        b=sD/KxWUkLvt9xM/WSj1l2STBGBNhn/w/JaR6SXt3MIcagvOaTQyfUkBNLJFkhzL1Nu
         zKCacYSWtaOQ2Y/7NjMbLACp9forkgYkEwfQGgg/usVeMCE0chFl2MMRQJhKCcXE8NSe
         R+FkvoHB1p4u7dgS4968T0YBj0goL9zDGLaQBiYtt9sOZQmHPpYdJq3kYvM6QcvpWAFf
         QYDLyc+D4X1zqC4HJbLclZzVvq+zO7yUhczMsVsRfzd9K1gCHABVh7CJelyznmCJVxdz
         HRMfMjeUrNFzpFTIboevWM3YE7eNbPY4KTvA6xfdlxENiBRpxo4mPQo2nOIE5qU7G+VP
         7WUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=wCnjqrj2GGGlSBoOXRHfEq6CD5MpxnVT3q6Lv2UyXSE=;
        b=XdN6cODMxc1+YPdZy1TlAFR0FvdkByh5JhWGVgVWdw8xBsQvJH8Q73l3xKUVeFsypG
         bi1OqNH7DSp5hQ7D5BIzXn5sND9ZVs/vdvOQYcbpMqG5iKDmTWantmZYTIU1mAQdqj6g
         ct8t6u4mkor5wfVxVhLH1spWC+7cN0ncIZ/V3eUSMpqMXIiE83S2tV2NrPqGk1Xc7dc5
         4Y/eRRYI7mO3sGjtXBQv0dSV69YvNkqbqFiS9O2Kfk9gZ4tUWZPDlqBvwCH95vPhjJfY
         AxJlDCqUWrSLzJszCwM+GCtPqirHotAXs6XQFb4qwhBA2dziooBTjzmkkM7lGKVA4po6
         Ji9Q==
X-Gm-Message-State: ACgBeo1MD+DBoSpqb49LQ4J2Cmh4pg7SuoItOh8NhUXf6nEI63fcKxVG
        fMpBfpAnMwymupgzPGruCsDvyLX8tcjk5Q==
X-Google-Smtp-Source: AA6agR5eO8XIwHgdRjjsK/q9mJ1Cv4/XqjJeCpXM8Cxg76ENkHUBMXuRcQGNpPd5DHZ5jQc6LqG8mQ==
X-Received: by 2002:a19:380e:0:b0:497:7968:e789 with SMTP id f14-20020a19380e000000b004977968e789mr4167167lfa.242.1662728058999;
        Fri, 09 Sep 2022 05:54:18 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g10-20020a2eb0ca000000b00263630ab29dsm64750ljl.118.2022.09.09.05.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 05:54:18 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        David Heidelberg <david@ixit.cz>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 7/7] dt-bindings: remoteproc: qcom,smd-edge: define children
Date:   Fri,  9 Sep 2022 14:54:03 +0200
Message-Id: <20220909125403.803158-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220909125403.803158-1-krzysztof.kozlowski@linaro.org>
References: <20220909125403.803158-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SMD edge contains subnodes representing devices related to the remote
processor.  With limietd number of remote processors, there is a limited
set of such devices.

List all of them in smd-edge bindings so schema can strictly check for
subnodes.

Additional benefit is requirement of "qcom,smd-channels" for such
subnodes, because their schema cannot enforce it (few devices like APR
or FastRPC can be part of either SMD or GLINK edge).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/remoteproc/qcom,smd-edge.yaml    | 34 ++++++++++++++++++-
 .../bindings/soc/qcom/qcom,smd.yaml           | 27 +--------------
 2 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,smd-edge.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,smd-edge.yaml
index 06eebf791e32..7ec8a6b6682c 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,smd-edge.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,smd-edge.yaml
@@ -13,12 +13,30 @@ description:
   Qualcomm SMD subnode represents a remote subsystem or a remote processor of
   some sort - or in SMD language an "edge". The name of the edges are not
   important.
+
+  In turn, subnodes of the "edges" represent devices tied to SMD channels on
+  that "edge". The names of the devices are not important. The properties of
+  these nodes are defined by the individual bindings for the SMD devices.
   See also Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml
 
 properties:
   $nodename:
     const: "smd-edge"
 
+  apr:
+    $ref: /schemas/soc/qcom/qcom,apr.yaml#
+    required:
+      - qcom,smd-channels
+    description:
+      Qualcomm APR/GPR (Asynchronous/Generic Packet Router)
+
+  fastrpc:
+    $ref: /schemas/misc/qcom,fastrpc.yaml#
+    required:
+      - qcom,smd-channels
+    description:
+      Qualcomm FastRPC
+
   interrupts:
     maxItems: 1
 
@@ -56,6 +74,20 @@ properties:
       The identifier for the remote processor as known by the rest of the
       system.
 
+  rpm-requests:
+    $ref: /schemas/soc/qcom/qcom,smd-rpm.yaml#
+    required:
+      - qcom,smd-channels
+    description:
+      Qualcomm Resource Power Manager (RPM) over SMD.
+
+  wcnss:
+    $ref: /schemas/soc/qcom/qcom,wcnss.yaml
+    required:
+      - qcom,smd-channels
+    description:
+      Qualcomm WCNSS for Bluetooth, WiFi and FM radio.
+
 required:
   - interrupts
   - qcom,smd-edge
@@ -66,7 +98,7 @@ oneOf:
   - required:
       - qcom,ipc
 
-additionalProperties: true
+additionalProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml
index 0e548234611e..063e595c12f7 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml
@@ -22,37 +22,12 @@ properties:
 patternProperties:
   "^smd-edge|rpm$":
     $ref: /schemas/remoteproc/qcom,smd-edge.yaml#
+    unevaluatedProperties: false
     description:
       Each subnode of the SMD node represents a remote subsystem or a remote
       processor of some sort - or in SMD language an "edge". The name of the
       edges are not important.
 
-    properties:
-      rpm-requests:
-        type: object
-        description:
-          In turn, subnodes of the "edges" represent devices tied to SMD
-          channels on that "edge". The names of the devices are not
-          important. The properties of these nodes are defined by the
-          individual bindings for the SMD devices.
-
-        properties:
-          qcom,smd-channels:
-            $ref: /schemas/types.yaml#/definitions/string-array
-            minItems: 1
-            maxItems: 32
-            description:
-              A list of channels tied to this device, used for matching the
-              device to channels.
-
-        required:
-          - compatible
-          - qcom,smd-channels
-
-        additionalProperties: true
-
-    unevaluatedProperties: false
-
 required:
   - compatible
 
-- 
2.34.1

