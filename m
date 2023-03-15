Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5E96BAF83
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 12:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjCOLs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 07:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjCOLsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 07:48:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77DC55505;
        Wed, 15 Mar 2023 04:48:19 -0700 (PDT)
Received: from localhost (unknown [188.24.156.231])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 57B026603058;
        Wed, 15 Mar 2023 11:48:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678880898;
        bh=C+CkBCBIxEIFOAjzgyNm1268qn0Q1m0JZg82+SgLbSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X58SfGRMKG9NMnROtcQIsHKPqTiN3hEwxxvjMK1CBZAuNkvJZzsUYX46U7ZK9w6S6
         dF4cWgtlSfBpB8jUa/4djaWG13TVCtFcT45OS/83t3Yw6fakhmegMNTgKGABCsilX/
         wHS2lvwEUTbpSNOotY3XW9z1pVo7f5vlTrQWiLpSupOFiyAOoNrA8OYMPLMmr5TPyN
         JcBcMmqRoAFaPZMBUMUwP7t2IyoYiSr8EtaBYoSFn2xK3I5BULLPfOYbfOu6Wk2QXq
         wcRNhblusYn5BaeQW5QYIAVEuJsdJVOaqvBKDSUpfN1l8nBSghvjXURdUp51ZFH4+v
         PCS7fq1RtkfSA==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Drake <drake@endlessm.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, kernel@collabora.com
Subject: [PATCH 02/11] dt-bindings: serial: snps-dw-apb-uart: Relax dma-names order constraint
Date:   Wed, 15 Mar 2023 13:47:57 +0200
Message-Id: <20230315114806.3819515-3-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230315114806.3819515-1-cristian.ciocaltea@collabora.com>
References: <20230315114806.3819515-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 370f696e4474 ("dt-bindings: serial: snps-dw-apb-uart: add dma &
dma-names properties") documented dma-names property to handle Allwiner
D1 dtbs_check warnings, but relies on a strict rx->tx ordering, which is
the reverse of what a different board expects:

  rk3326-odroid-go2.dtb: serial@ff030000: dma-names:0: 'rx' was expected

A quick and incomplete check shows the inconsistency is present in many
other DT files:

$ git grep -A10 snps,dw-apb-uart | grep dma-names | sort -u
arch/arm64/boot/dts/rockchip/px30.dtsi-         dma-names = "tx", "rx";
arch/arm64/boot/dts/rockchip/rk3328.dtsi-       dma-names = "tx", "rx";
arch/arm64/boot/dts/rockchip/rk3588s.dtsi-      dma-names = "tx", "rx";
arch/arm/boot/dts/rk3066a.dtsi-                 dma-names = "tx", "rx";
arch/arm/boot/dts/rk3128.dtsi-                  dma-names = "tx", "rx";
arch/arm/boot/dts/rk3288.dtsi-                  dma-names = "tx", "rx";
arch/arm/boot/dts/rv1126.dtsi-                  dma-names = "tx", "rx";
arch/arm/boot/dts/socfpga.dtsi-                 dma-names = "tx", "rx";
arch/arm/boot/dts/sun6i-a31.dtsi-               dma-names = "rx", "tx";
arch/arm/boot/dts/sun8i-a23-a33.dtsi-           dma-names = "rx", "tx";
arch/arm/boot/dts/sun8i-v3s.dtsi-               dma-names = "rx", "tx";
arch/arm/boot/dts/sunxi-h3-h5.dtsi-             dma-names = "rx", "tx";
arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi-  dma-names = "rx", "tx";

Do not enforce the order of the dma-names items.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 .../devicetree/bindings/serial/snps-dw-apb-uart.yaml   | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 2becdfab4f15..d374844a61a5 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -71,9 +71,13 @@ properties:
     minItems: 2
 
   dma-names:
-    items:
-      - const: rx
-      - const: tx
+    oneOf:
+      - items:
+          - const: tx
+          - const: rx
+      - items:
+          - const: rx
+          - const: tx
 
   snps,uart-16550-compatible:
     description: reflects the value of UART_16550_COMPATIBLE configuration
-- 
2.39.1

