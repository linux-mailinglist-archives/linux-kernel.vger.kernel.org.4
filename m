Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273A26C9652
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 17:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjCZPyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 11:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjCZPyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 11:54:37 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2D244A2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 08:54:35 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ew6so26149484edb.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 08:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679846073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHf8Iv0NI1emcO/z/ewyqHnQEFOXmu7+0ljc1Q4ZcJI=;
        b=tE+yQdG1T2SqxcmRUDC4jgRpO3h7Oj3NGFQfvFEK8Rta9B5C16LDC0qSp7CL3kczar
         bl39yE1ZDZ9p3qAwBysPv7OZjSex/W12Yy4uNYL7k3aDmVQJZl/yAE672BmWGLl4Rz/k
         7xywNh3tkJCtL/5D0E787Sxg7zaxdLRghGEfN/a+dOkqPg0lXfRv0Hzu2oAHurJCcS6y
         Hps9EoPrUrAZHrJJ4L1yNpdRn5hTOYk18r/3mrClj6p7PEWAtQUxWUXk05CnBuB4qJmY
         mCt4dKIQX5nr/RdOBnLYFdW3YLEYxUKBE2DuZcU7+jmn3FLHm0gXTtNT05XCdjzcl3Vx
         hh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679846073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vHf8Iv0NI1emcO/z/ewyqHnQEFOXmu7+0ljc1Q4ZcJI=;
        b=dR3mfd76Gz6ShlJfaeuVmKr0XzF+dnMUj7KNs/yE4WWLs4InKjs35e/jwBYOVUJktH
         oR4qSTVsTdU0hdDVsV4sccfgxvWZMq2MZ6FrPIFAL/pqqpD2QGzm1JIAvsm6jDz95hKG
         Vr7iVXxBa2PHjDpcuindJpD6auWe4yv7MEirirrfhsJx/iLPiJsm9MrZjpc5qI5v9q9n
         wmdgjjKa/j0Y3ENFJrpbRPv0G6EWzESNR59dVjBox7SqjYZ5OqPPKs9CshB07Nu5NIRp
         2yo1FBuaHDwbdq3//nFMoqTyLP3iV7Exqb5jbl7tRj8Efn40H8mQaokvCVs+/766SI8w
         4DFA==
X-Gm-Message-State: AAQBX9ebOonUDL6m8ZINtz5J70u4j2p+qEBA0tYwLxWhGNcuuPv9tGkp
        iWq4U9ZFH4dmaUKAHAFXuV7BSg==
X-Google-Smtp-Source: AKy350Z9yW9do38i5Qti2/g6ZEwstDQ0vYhgJqnw6UnOMq56bflHZ5rivUZlOZlnskR73Qd+s7j7pg==
X-Received: by 2002:aa7:cc07:0:b0:4a2:5652:d8ba with SMTP id q7-20020aa7cc07000000b004a25652d8bamr8542357edt.18.1679846073737;
        Sun, 26 Mar 2023 08:54:33 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:eca3:3b8f:823b:2669])
        by smtp.gmail.com with ESMTPSA id l6-20020a50d6c6000000b004af62273b66sm13506742edj.18.2023.03.26.08.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 08:54:33 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michael Srba <Michael.Srba@seznam.cz>,
        Harigovindan P <harigovi@codeaurora.org>,
        Bjorn Andersson <andersson@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5/6] dt-bindings: display: visionox,rm69299: document reg
Date:   Sun, 26 Mar 2023 17:54:24 +0200
Message-Id: <20230326155425.91181-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230326155425.91181-1-krzysztof.kozlowski@linaro.org>
References: <20230326155425.91181-1-krzysztof.kozlowski@linaro.org>
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

Panels are supposed to have one reg.  This fixes dtbs_check warnings
like:

  sc7180-idp.dtb: panel@0: 'reg' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../display/panel/visionox,rm69299.yaml       | 25 +++++++++++++------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/visionox,rm69299.yaml b/Documentation/devicetree/bindings/display/panel/visionox,rm69299.yaml
index 481ef051df1e..444ac2a4772d 100644
--- a/Documentation/devicetree/bindings/display/panel/visionox,rm69299.yaml
+++ b/Documentation/devicetree/bindings/display/panel/visionox,rm69299.yaml
@@ -19,6 +19,8 @@ properties:
   compatible:
     const: visionox,rm69299-1080p-display
 
+  reg: true
+
   vdda-supply:
     description: |
       Phandle of the regulator that provides the vdda supply voltage.
@@ -34,6 +36,7 @@ additionalProperties: false
 
 required:
   - compatible
+  - reg
   - vdda-supply
   - vdd3p3-supply
   - reset-gpios
@@ -41,16 +44,22 @@ required:
 
 examples:
   - |
-    panel {
-        compatible = "visionox,rm69299-1080p-display";
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "visionox,rm69299-1080p-display";
+            reg = <0>;
 
-        vdda-supply = <&src_pp1800_l8c>;
-        vdd3p3-supply = <&src_pp2800_l18a>;
+            vdda-supply = <&src_pp1800_l8c>;
+            vdd3p3-supply = <&src_pp2800_l18a>;
 
-        reset-gpios = <&pm6150l_gpio 3 0>;
-        port {
-            panel0_in: endpoint {
-                remote-endpoint = <&dsi0_out>;
+            reset-gpios = <&pm6150l_gpio 3 0>;
+            port {
+                panel0_in: endpoint {
+                    remote-endpoint = <&dsi0_out>;
+                };
             };
         };
     };
-- 
2.34.1

