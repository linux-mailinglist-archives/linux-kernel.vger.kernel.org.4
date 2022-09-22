Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53FB95E5EE2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 11:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiIVJtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 05:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiIVJtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 05:49:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1827CD4A9D;
        Thu, 22 Sep 2022 02:49:15 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 31D1E660221D;
        Thu, 22 Sep 2022 10:49:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663840154;
        bh=HBq0403+8YpuivvuFKBBDzFD3nvqHpkf4SYdCxNYb+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LNCLBrgBKICqL6Zc2LWoquUWoO3DCOlq28tDIoj598l9jpRLe5F920EcaKFgA/jT5
         okrEDAY5AUDWJ02UsOTatrut6vF9uFkLsL+4gsrWT+Z8pieR2NaxieTGkIFaNKpUgg
         hvO0rpYiR7nfn9im4zz0Md5UA3TeRjxzjtj5SDQV8XPQPOwjDFJw7hj0v+XK1jqI7f
         657GcI2AGuscMNkCdTwKL9IhF875xgIIdZvglEPgzL7zmOMFSCzk3vyVttClTRcQih
         lIFpZFD8DWpgHX6PrMa22f2yM+uOVj8lqG97v0rwTq5+KOzZ1uhk2Wu4t4NZ5MvO+y
         l8AqpkCok77WQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wenst@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 1/4] arm64: dts: mediatek: cherry: Add Audio Front End (AFE) support
Date:   Thu, 22 Sep 2022 11:49:05 +0200
Message-Id: <20220922094908.41623-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220922094908.41623-1-angelogioacchino.delregno@collabora.com>
References: <20220922094908.41623-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding audio support, enable the AFE HW with
the appropriate eTDM configuration and memory region.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 9b62e161db26..bc7890300a57 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -117,9 +117,23 @@ scp_mem: memory@50000000 {
 			reg = <0 0x50000000 0 0x2900000>;
 			no-map;
 		};
+
+		afe_mem: memory@60d80000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x60d80000 0 0x100000>;
+			no-map;
+		};
 	};
 };
 
+&afe {
+	status = "okay";
+
+	mediatek,etdm-in2-cowork-source = <2>;
+	mediatek,etdm-out2-cowork-source = <0>;
+	memory-region = <&afe_mem>;
+};
+
 &i2c0 {
 	status = "okay";
 
-- 
2.37.2

