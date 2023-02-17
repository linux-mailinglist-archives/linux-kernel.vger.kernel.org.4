Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61AA569B29E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 19:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjBQSxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 13:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjBQSxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 13:53:00 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0633DB47E;
        Fri, 17 Feb 2023 10:52:59 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m21-20020a05600c3b1500b003e1f5f2a29cso1669122wms.4;
        Fri, 17 Feb 2023 10:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNEF4fipdoHCuo0/Rmv+9N9jdN1WQtjB48jcLvFIJM0=;
        b=OOf1QpSOIHQet9Z855DB1KvVOZV7THJ0Rp4RGA7bYB63FSuZCk5geY2X2z3jZpOXvb
         TwYuhtKLKVxOFcIDFIKAUAurb0ExHImNkalYjmFY2Rt3a3iqX9Djl63phjmYt7mqo+l9
         n/LlON1GPytkE2pagZEKsrMSMM923YE+UJLVLIFRWIFe2IbvVMs/8D/ZQ+zy+FjBtVVr
         hZ35KKgzCWfOpB/50WA1g0W7igIHf+MblBJAWkTVTl7vEBWwTd+BAlEhsXDnr6NWH8+o
         IRji+5aiSNWCUD2AirGx70z4QG5mRLZkVD1dVW4c4w2Rd1Y9ja717zvnD8S+kQyRvotd
         g8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CNEF4fipdoHCuo0/Rmv+9N9jdN1WQtjB48jcLvFIJM0=;
        b=mT5leV/Ni0mOFa3sdn/RNj3H1+FOCWmRWloMGf/iJw44nxLg473IflrE/al7OPirrl
         86crI7brmIb/MOR6D4Gj5DW8v34qg4+9e2xXER2pOewQxRPa5qBKDOgFIyat4yxj5cvR
         RUZqAarWdXe2euG8dlO+pHzuZoJrcZ8OwUiNdUtP8xvSqLMzpkcq8J43Hnk2Sf1VHoJ9
         ZkTiG5+gG24sA5CamUbCp7uSZgxzcdpnGVpsRXTDcaGLIwmBBxLd0oISIdQKUVdAhexe
         CG9Me+1qDW1gxcEAsNUznNzrk/vgIE5YCqctXv0vP50TF/zGD9yEk7Kn92CN8jE8Swu/
         JwIA==
X-Gm-Message-State: AO0yUKWJc9SSA3w8N8TPVGD0fTxi846cLgiN7ZxzmcZiK75kH5ATGtCr
        q2HVtti+iDQ9cMnrgWkYJ/I=
X-Google-Smtp-Source: AK7set/HQOxX57eReSaexgzyj9+zEziOHOg6F2mkRMYC/iABeacCkHDexTxzBR/lDcupAVxTveVafQ==
X-Received: by 2002:a7b:ce0d:0:b0:3dc:576c:ab07 with SMTP id m13-20020a7bce0d000000b003dc576cab07mr1970177wmc.14.1676659977422;
        Fri, 17 Feb 2023 10:52:57 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:d8bd:e692:c27f:c09d])
        by smtp.gmail.com with ESMTPSA id l37-20020a05600c1d2500b003db0ad636d1sm2964514wms.28.2023.02.17.10.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 10:52:56 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/4] ASoC: dt-bindings: renesas,rz-ssi: Update interrupts and interrupt-names properties
Date:   Fri, 17 Feb 2023 18:52:22 +0000
Message-Id: <20230217185225.43310-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230217185225.43310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230217185225.43310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

From R01UH0914EJ0120 Rev.1.20 HW manual, for full duplex channels
(SSI0/1/3) dma_rt interrupt has now being marked as reserved and similarly
for half duplex channel (SSI2) dma_rx and dma_tx interrupts have now being
marked as reserved (this applies to RZ/G2L and alike SoC's). This patch
updates the binding doc to match the same.

While at it also updated the example node.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/sound/renesas,rz-ssi.yaml        | 21 +++++++++++--------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
index 196881d94396..3b5ae45eee4a 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
+++ b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
@@ -25,14 +25,18 @@ properties:
     maxItems: 1
 
   interrupts:
-    maxItems: 4
+    minItems: 2
+    maxItems: 3
 
   interrupt-names:
-    items:
-      - const: int_req
-      - const: dma_rx
-      - const: dma_tx
-      - const: dma_rt
+    oneOf:
+      - items:
+          - const: int_req
+          - const: dma_rx
+          - const: dma_tx
+      - items:
+          - const: int_req
+          - const: dma_rt
 
   clocks:
     maxItems: 4
@@ -106,9 +110,8 @@ examples:
             reg = <0x10049c00 0x400>;
             interrupts = <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 327 IRQ_TYPE_EDGE_RISING>,
-                         <GIC_SPI 328 IRQ_TYPE_EDGE_RISING>,
-                         <GIC_SPI 329 IRQ_TYPE_EDGE_RISING>;
-            interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
+                         <GIC_SPI 328 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "int_req", "dma_rx", "dma_tx";
             clocks = <&cpg CPG_MOD R9A07G044_SSI0_PCLK2>,
                      <&cpg CPG_MOD R9A07G044_SSI0_PCLK_SFR>,
                      <&audio_clk1>,
-- 
2.25.1

