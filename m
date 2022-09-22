Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7715E5EE6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 11:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbiIVJt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 05:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiIVJtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 05:49:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4095CD4AA4;
        Thu, 22 Sep 2022 02:49:17 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CF352660221E;
        Thu, 22 Sep 2022 10:49:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663840155;
        bh=fkgvOEpFveDqGiVfiz6Zm3QLw7vdRwQw9bnbQlnHoOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H+cBS6rhWgJGmzcx2x181scVLmXL0RRRCKb81jbR7XY+bxqAFOoe8fxZLJJNUjmaM
         W2u1BjDecDBjzsEGdlKBncc1kL6TBkts3u1L+3MXyRLTlhSX/zH3EzsJqSEieGvnTJ
         /QXRoxI836Z/1bLxlrjPRLF210jBZKCfl/RJ/GI2PdndpujTkHZe7XoRqNlTbhkuyD
         e6KZzvzFXPoXikVzvPSPxLArNjFQS/FJ9ghUFt98KzeJNS6RN3wyoleReKI9EM9FfR
         vFtoDj4w/hXtsPr3yP1UwoRr632syKWUcvIdAmbA/t1xYWMSgv3Xve/ai099UjiMIY
         ZVXY8j0XP4d3A==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wenst@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 2/4] arm64: dts: mediatek: cherry: Enable the Audio DSP for SOF
Date:   Thu, 22 Sep 2022 11:49:06 +0200
Message-Id: <20220922094908.41623-3-angelogioacchino.delregno@collabora.com>
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

This platform is able to use the Audio DSP embedded into the
MT8195 SoC: in preparation for adding audio support for Cherry,
add the ADSP related memory nodes and enable it.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index bc7890300a57..3bc624e6f499 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -118,14 +118,32 @@ scp_mem: memory@50000000 {
 			no-map;
 		};
 
+		adsp_mem: memory@60000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x60000000 0 0xd80000>;
+			no-map;
+		};
+
 		afe_mem: memory@60d80000 {
 			compatible = "shared-dma-pool";
 			reg = <0 0x60d80000 0 0x100000>;
 			no-map;
 		};
+
+		adsp_device_mem: memory@60e80000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x60e80000 0 0x280000>;
+			no-map;
+		};
 	};
 };
 
+&adsp {
+	status = "okay";
+
+	memory-region = <&adsp_device_mem>, <&adsp_mem>;
+};
+
 &afe {
 	status = "okay";
 
-- 
2.37.2

