Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315E86A83FC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjCBONW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCBONS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:13:18 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE72811170;
        Thu,  2 Mar 2023 06:13:15 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id x3so5159365edb.10;
        Thu, 02 Mar 2023 06:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677766394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KXRZZ9kXU04u7Bxj+XZ/EaZpO1Qnn/PzRZQE3Lx8yKc=;
        b=UEWvyuUT8jP1cgSLW4xyNeZFUexsuWDFIsPCz6zSoC3LdaPuxbhil/zFc7arw7LPsd
         ra0rcTfOLsFsdIz+n2HHxyN3DJnPY2fCYgPVs3Y5mk8Y6WtC7Gmut/D90Sl73YJ1zdYg
         ZFlVF7iFhQODVdX+lIp/lnHZrQx63uOXXws1q9ejkKWXDP/amk7R/EWeVd2OzR94yB2M
         s9glmO0uPD41OcqyLZM+FWpPAATdUfD1EfeurRyvhg/6wN/6nf0yj7VC7X6ZrennUgYK
         Sp+tRvR40uTWVH74rAr1TqyOwPKVBWA1HBOXmIZw4VvAsZvqN5fxqU/ts95nCCkgKLxj
         vyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677766394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KXRZZ9kXU04u7Bxj+XZ/EaZpO1Qnn/PzRZQE3Lx8yKc=;
        b=ZkxLEIf7HV3Tx6ZIC8PzmQbFEJklUs74QKau3cYSjBEBZyfmZyeqqFv0fXRufKVfOa
         vmBTQ3QXNNaTYIl+ofl/4tgmo3pcC7n8+kAfa8YsHvDFw682ZdbQP4q7oobxyh728JAX
         AulU5XdE68l028PAQclagyX9Nk6CBSMd9X2CauSvW/Zd3AgpIzZ38FYdynS+hhxsNNtK
         ryfLv8vlc/BSI7kGPqVDDVwhkKydJRxVxZiOc3TS1uFchRn37e3SbxOIRQKLe3rCuWCb
         C4x260LyE0/i0BwQ4milD2Qp9LK+H8hoXZmH/5CD+A7MJc/hTlVrN8P8BYYTq5CgwdF8
         A12Q==
X-Gm-Message-State: AO0yUKXrRxqucYv+foYFeVowUeibTzOv1GVB7/osQ4dDUu32OxunSLHi
        nxtsZyJ9uq5txzumbQcAJ5E=
X-Google-Smtp-Source: AK7set+bSlty9E+/Pu8B1r/s5pc9qhxZWk9IhZG317kBb+n5NYDYWgXHVHHMCNxV3N58fLjvzBU5aA==
X-Received: by 2002:a17:906:1907:b0:8b1:304e:58a3 with SMTP id a7-20020a170906190700b008b1304e58a3mr10705968eje.52.1677766394441;
        Thu, 02 Mar 2023 06:13:14 -0800 (PST)
Received: from localhost.localdomain ([95.183.227.97])
        by smtp.gmail.com with ESMTPSA id m25-20020a509999000000b004bc2d1c0fadsm2128982edb.32.2023.03.02.06.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 06:13:14 -0800 (PST)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] dt-bindings: display: mediatek: Compatible list cleanup
Date:   Thu,  2 Mar 2023 17:12:34 +0300
Message-Id: <20230302141234.169985-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

Several DT bindings of MediaTek display blocks make unnecessary use of
"oneOf" and "items". Remove them and replace them with enums where
necessary.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
Changes since v1:
- Leave enums with 1 element as they are.

 .../bindings/display/mediatek/mediatek,ccorr.yaml   |  7 +++----
 .../bindings/display/mediatek/mediatek,color.yaml   | 10 ++++------
 .../bindings/display/mediatek/mediatek,dither.yaml  |  3 +--
 .../bindings/display/mediatek/mediatek,dsc.yaml     |  4 +---
 .../bindings/display/mediatek/mediatek,gamma.yaml   |  7 +++----
 .../bindings/display/mediatek/mediatek,merge.yaml   |  8 +++-----
 .../bindings/display/mediatek/mediatek,od.yaml      |  8 +++-----
 .../bindings/display/mediatek/mediatek,ovl-2l.yaml  |  7 +++----
 .../bindings/display/mediatek/mediatek,ovl.yaml     | 13 +++++--------
 .../display/mediatek/mediatek,postmask.yaml         |  3 +--
 .../bindings/display/mediatek/mediatek,rdma.yaml    | 13 +++++--------
 .../bindings/display/mediatek/mediatek,split.yaml   |  4 +---
 .../bindings/display/mediatek/mediatek,ufoe.yaml    |  4 +---
 .../bindings/display/mediatek/mediatek,wdma.yaml    |  4 +---
 14 files changed, 35 insertions(+), 60 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
index b04820c95b22..dc22bd522523 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
@@ -21,10 +21,9 @@ description: |
 properties:
   compatible:
     oneOf:
-      - items:
-          - const: mediatek,mt8183-disp-ccorr
-      - items:
-          - const: mediatek,mt8192-disp-ccorr
+      - enum:
+          - mediatek,mt8183-disp-ccorr
+          - mediatek,mt8192-disp-ccorr
       - items:
           - enum:
               - mediatek,mt8188-disp-ccorr
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
index 62306c88f485..d0ea77fc4b06 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
@@ -22,12 +22,10 @@ description: |
 properties:
   compatible:
     oneOf:
-      - items:
-          - const: mediatek,mt2701-disp-color
-      - items:
-          - const: mediatek,mt8167-disp-color
-      - items:
-          - const: mediatek,mt8173-disp-color
+      - enum:
+          - mediatek,mt2701-disp-color
+          - mediatek,mt8167-disp-color
+          - mediatek,mt8173-disp-color
       - items:
           - enum:
               - mediatek,mt7623-disp-color
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
index 5c7445c174e5..9d74de63fe63 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
@@ -22,8 +22,7 @@ description: |
 properties:
   compatible:
     oneOf:
-      - items:
-          - const: mediatek,mt8183-disp-dither
+      - const: mediatek,mt8183-disp-dither
       - items:
           - enum:
               - mediatek,mt8186-disp-dither
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsc.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsc.yaml
index 49248864514b..37bf6bf4a1ab 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsc.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsc.yaml
@@ -19,9 +19,7 @@ description: |
 
 properties:
   compatible:
-    oneOf:
-      - items:
-          - const: mediatek,mt8195-disp-dsc
+    const: mediatek,mt8195-disp-dsc
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
index a5c6a91fac71..6c2be9d6840b 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
@@ -21,10 +21,9 @@ description: |
 properties:
   compatible:
     oneOf:
-      - items:
-          - const: mediatek,mt8173-disp-gamma
-      - items:
-          - const: mediatek,mt8183-disp-gamma
+      - enum:
+          - mediatek,mt8173-disp-gamma
+          - mediatek,mt8183-disp-gamma
       - items:
           - enum:
               - mediatek,mt8186-disp-gamma
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.yaml
index 69ba75777dac..c474ee6fa05b 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.yaml
@@ -20,11 +20,9 @@ description: |
 
 properties:
   compatible:
-    oneOf:
-      - items:
-          - const: mediatek,mt8173-disp-merge
-      - items:
-          - const: mediatek,mt8195-disp-merge
+    enum:
+      - mediatek,mt8173-disp-merge
+      - mediatek,mt8195-disp-merge
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,od.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,od.yaml
index 853fcb9db2be..7e6bbf8b5c60 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,od.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,od.yaml
@@ -20,11 +20,9 @@ description: |
 
 properties:
   compatible:
-    oneOf:
-      - items:
-          - const: mediatek,mt2712-disp-od
-      - items:
-          - const: mediatek,mt8173-disp-od
+    enum:
+      - mediatek,mt2712-disp-od
+      - mediatek,mt8173-disp-od
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl-2l.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl-2l.yaml
index 4e94f4e947ad..c7dd0ef02dcf 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl-2l.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl-2l.yaml
@@ -21,10 +21,9 @@ description: |
 properties:
   compatible:
     oneOf:
-      - items:
-          - const: mediatek,mt8183-disp-ovl-2l
-      - items:
-          - const: mediatek,mt8192-disp-ovl-2l
+      - enum:
+          - mediatek,mt8183-disp-ovl-2l
+          - mediatek,mt8192-disp-ovl-2l
       - items:
           - enum:
               - mediatek,mt8186-disp-ovl-2l
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
index 065e526f950e..92e320d54ba2 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
@@ -21,14 +21,11 @@ description: |
 properties:
   compatible:
     oneOf:
-      - items:
-          - const: mediatek,mt2701-disp-ovl
-      - items:
-          - const: mediatek,mt8173-disp-ovl
-      - items:
-          - const: mediatek,mt8183-disp-ovl
-      - items:
-          - const: mediatek,mt8192-disp-ovl
+      - enum:
+          - mediatek,mt2701-disp-ovl
+          - mediatek,mt8173-disp-ovl
+          - mediatek,mt8183-disp-ovl
+          - mediatek,mt8192-disp-ovl
       - items:
           - enum:
               - mediatek,mt7623-disp-ovl
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,postmask.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,postmask.yaml
index 27de64495401..12ec410bb921 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,postmask.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,postmask.yaml
@@ -21,8 +21,7 @@ description: |
 properties:
   compatible:
     oneOf:
-      - items:
-          - const: mediatek,mt8192-disp-postmask
+      - const: mediatek,mt8192-disp-postmask
       - items:
           - enum:
               - mediatek,mt8186-disp-postmask
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
index 3ade2ece3fed..42059efad45d 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
@@ -23,14 +23,11 @@ description: |
 properties:
   compatible:
     oneOf:
-      - items:
-          - const: mediatek,mt2701-disp-rdma
-      - items:
-          - const: mediatek,mt8173-disp-rdma
-      - items:
-          - const: mediatek,mt8183-disp-rdma
-      - items:
-          - const: mediatek,mt8195-disp-rdma
+      - enum:
+          - mediatek,mt2701-disp-rdma
+          - mediatek,mt8173-disp-rdma
+          - mediatek,mt8183-disp-rdma
+          - mediatek,mt8195-disp-rdma
       - items:
           - enum:
               - mediatek,mt8188-disp-rdma
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,split.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,split.yaml
index 35ace1f322e8..54b7b0531144 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,split.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,split.yaml
@@ -20,9 +20,7 @@ description: |
 
 properties:
   compatible:
-    oneOf:
-      - items:
-          - const: mediatek,mt8173-disp-split
+    const: mediatek,mt8173-disp-split
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ufoe.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ufoe.yaml
index b8bb135fe96b..87523b45a210 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ufoe.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ufoe.yaml
@@ -21,9 +21,7 @@ description: |
 
 properties:
   compatible:
-    oneOf:
-      - items:
-          - const: mediatek,mt8173-disp-ufoe
+    const: mediatek,mt8173-disp-ufoe
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml
index 7d7cc1ab526b..52f233fe1c0f 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml
@@ -20,9 +20,7 @@ description: |
 
 properties:
   compatible:
-    oneOf:
-      - items:
-          - const: mediatek,mt8173-disp-wdma
+    const: mediatek,mt8173-disp-wdma
 
   reg:
     maxItems: 1
-- 
2.39.2

