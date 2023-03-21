Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E106C3D23
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 22:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjCUV4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 17:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjCUV4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 17:56:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978ED3FBAA;
        Tue, 21 Mar 2023 14:56:33 -0700 (PDT)
Received: from localhost (unknown [188.24.179.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E8FEC66030DE;
        Tue, 21 Mar 2023 21:56:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679435792;
        bh=xlJOx3+BWzJjnvbq3Qx6ToCI9eSAdqOI6uhZgvbAeZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l0AqkVN95YJGx/ASGaao9kh++1IZeZLcCcM4JgDq7PgYErL5x0ArdP7IInpQclbkj
         cspW85oZgxJst126hJdzYVTuwApoSXsPlPtk0y0EQK/Hbufitiu2g6Z+w2IWiHZLiA
         dZ9LAEGyqKlqxkQW6joE953xgBlVA4Nc1DrMCVAnS1Kv70Hhfux+iFcVHti7oki50M
         0dN6RtG8TTRFyfT1fV8ugic5scgfN95uBxkMT0ZwSM49l4ziz6qsAaPhd2eEikFd+2
         Ybxhi27SL4CDyeb2BZ8YsKxECSHvxfb5oCWfkCZTzFVSXXMpqinnLhpmguE7D3YCdo
         I6nLVsaA9cbKw==
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
Subject: [PATCH v2 01/10] dt-bindings: serial: snps-dw-apb-uart: Switch dma-names order
Date:   Tue, 21 Mar 2023 23:56:15 +0200
Message-Id: <20230321215624.78383-2-cristian.ciocaltea@collabora.com>
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
reverse of what a different board expects:

  rk3326-odroid-go2.dtb: serial@ff030000: dma-names:0: 'rx' was expected

A quick and incomplete check shows the inconsistency is present in many
other DTS files:

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

The initial proposed solution was to allow a flexible dma-names order in
the binding, due to potential ABI breakage concerns after fixing the DTS
files. But luckily the Allwinner boards are not really affected, since
all of them are using a shared DMA channel for rx and tx:

$ git grep -A10 snps,dw-apb-uart | grep 'sun.*dmas' | sort -u
arch/arm/boot/dts/sun6i-a31.dtsi-       dmas = <&dma 10>, <&dma 10>;
arch/arm/boot/dts/sun6i-a31.dtsi-       dmas = <&dma 22>, <&dma 22>;
arch/arm/boot/dts/sun6i-a31.dtsi-       dmas = <&dma 6>, <&dma 6>;
arch/arm/boot/dts/sun6i-a31.dtsi-       dmas = <&dma 7>, <&dma 7>;
arch/arm/boot/dts/sun6i-a31.dtsi-       dmas = <&dma 8>, <&dma 8>;
arch/arm/boot/dts/sun6i-a31.dtsi-       dmas = <&dma 9>, <&dma 9>;
arch/arm/boot/dts/sun8i-a23-a33.dtsi-   dmas = <&dma 10>, <&dma 10>;
arch/arm/boot/dts/sun8i-a23-a33.dtsi-   dmas = <&dma 6>, <&dma 6>;
arch/arm/boot/dts/sun8i-a23-a33.dtsi-   dmas = <&dma 7>, <&dma 7>;
arch/arm/boot/dts/sun8i-a23-a33.dtsi-   dmas = <&dma 8>, <&dma 8>;
arch/arm/boot/dts/sun8i-a23-a33.dtsi-   dmas = <&dma 9>, <&dma 9>;
arch/arm/boot/dts/sun8i-v3s.dtsi-       dmas = <&dma 6>, <&dma 6>;
arch/arm/boot/dts/sun8i-v3s.dtsi-       dmas = <&dma 7>, <&dma 7>;
arch/arm/boot/dts/sun8i-v3s.dtsi-       dmas = <&dma 8>, <&dma 8>;
arch/arm/boot/dts/sunxi-h3-h5.dtsi-     dmas = <&dma 6>, <&dma 6>;
arch/arm/boot/dts/sunxi-h3-h5.dtsi-     dmas = <&dma 7>, <&dma 7>;
arch/arm/boot/dts/sunxi-h3-h5.dtsi-     dmas = <&dma 8>, <&dma 8>;
arch/arm/boot/dts/sunxi-h3-h5.dtsi-     dmas = <&dma 9>, <&dma 9>;
arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi-  dmas = <&dma 14>, <&dma 14>;
arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi-  dmas = <&dma 15>, <&dma 15>;
arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi-  dmas = <&dma 16>, <&dma 16>;
arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi-  dmas = <&dma 17>, <&dma 17>;
arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi-  dmas = <&dma 18>, <&dma 18>;
arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi-  dmas = <&dma 19>, <&dma 19>;

Switch dma-names order to tx->rx as the first step in fixing the
inconsistency. The remaining DTS fixes will be handled by separate
patches.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 2becdfab4f15..d28cc96fa8e9 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -72,8 +72,8 @@ properties:
 
   dma-names:
     items:
-      - const: rx
       - const: tx
+      - const: rx
 
   snps,uart-16550-compatible:
     description: reflects the value of UART_16550_COMPATIBLE configuration
-- 
2.40.0

