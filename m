Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630226C3D30
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 22:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjCUV57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 17:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjCUV5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 17:57:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEECF591F0;
        Tue, 21 Mar 2023 14:56:47 -0700 (PDT)
Received: from localhost (unknown [188.24.179.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5EEE266030E8;
        Tue, 21 Mar 2023 21:56:45 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679435805;
        bh=6Pn4h5hBqV5Mx/XTEaAivfDdSRY70HW5NEjSKaEvQGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HNds7UKN7y1p2cduDi0Vgr7IKmadoc+8Hc0tJb0c79MWm7R0s4opLuHs9TwoxtAmP
         HqXP7iL7BftmWxaT6TpsF9TD5ivwgydc8VfBkvEE1L/e81wA8KFCM/6F7Rw7h2Ogyd
         PmWhAgcID/M0MILvYzd0j9JZQ81qMxKzQqVUlaxm0QwLuEn/gTH1CrN99M8cui7guQ
         NP1Go7ZFsn8utZZDAY8qxLf+BnWkcod2hBexQwdQaRuZamQZYlCjFIKiGROw4Szqli
         hZO3afvFXq2q2vaQZqbd0Ywwg+hTRgQyi4jwsaonJ9e5KPwiRgwXVJASU3LxR9LThy
         977C6DdG5csAg==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, kernel@collabora.com
Subject: [PATCH v2 05/10] ARM: dts: sunxi: h3/h5: Switch dma-names order for snps,dw-apb-uart nodes
Date:   Tue, 21 Mar 2023 23:56:19 +0200
Message-Id: <20230321215624.78383-6-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230321215624.78383-1-cristian.ciocaltea@collabora.com>
References: <20230321215624.78383-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 370f696e4474 ("dt-bindings: serial: snps-dw-apb-uart: add dma &
dma-names properties") documented dma-names property to handle Allwinner
D1 dtbs_check warnings, but relies on the rx->tx ordering, which is the
reverse of what a bunch of different boards expect.

The initial proposed solution was to allow a flexible dma-names order in
the binding, due to potential ABI breakage concerns after fixing the DTS
files. But luckily the Allwinner boards are not affected, since they are
using a shared DMA channel for rx and tx.

Hence, the first step in fixing the inconsistency was to change
dma-names order in the binding to tx->rx.

Do the same for the snps,dw-apb-uart nodes in the DTS file.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 686193bd6bd9..ade1cd50e445 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -710,7 +710,7 @@ uart0: serial@1c28000 {
 			clocks = <&ccu CLK_BUS_UART0>;
 			resets = <&ccu RST_BUS_UART0>;
 			dmas = <&dma 6>, <&dma 6>;
-			dma-names = "rx", "tx";
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
@@ -723,7 +723,7 @@ uart1: serial@1c28400 {
 			clocks = <&ccu CLK_BUS_UART1>;
 			resets = <&ccu RST_BUS_UART1>;
 			dmas = <&dma 7>, <&dma 7>;
-			dma-names = "rx", "tx";
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
@@ -736,7 +736,7 @@ uart2: serial@1c28800 {
 			clocks = <&ccu CLK_BUS_UART2>;
 			resets = <&ccu RST_BUS_UART2>;
 			dmas = <&dma 8>, <&dma 8>;
-			dma-names = "rx", "tx";
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
@@ -749,7 +749,7 @@ uart3: serial@1c28c00 {
 			clocks = <&ccu CLK_BUS_UART3>;
 			resets = <&ccu RST_BUS_UART3>;
 			dmas = <&dma 9>, <&dma 9>;
-			dma-names = "rx", "tx";
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
-- 
2.40.0

