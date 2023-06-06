Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35F172480A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238655AbjFFPlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238653AbjFFPkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:40:40 -0400
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0E510D4;
        Tue,  6 Jun 2023 08:40:39 -0700 (PDT)
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1q6YnR-0067qK-0T; Tue, 06 Jun 2023 15:40:33 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] arm64: dts: imx8mm-venice-gw7904: disable disp_blk_ctrl
Date:   Tue,  6 Jun 2023 08:40:30 -0700
Message-Id: <20230606154030.1449558-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GW7904 does not connect the VDD_MIPI power rails thus MIPI is
disabled. However we must also disable disp_blk_ctrl as it uses the
pgc_mipi power domain and without it being disabled imx8m-blk-ctrl will
fail to probe:
imx8m-blk-ctrl 32e28000.blk-ctrl: error -ETIMEDOUT: failed to attach
power domain "mipi-dsi"
imx8m-blk-ctrl: probe of 32e28000.blk-ctrl failed with error -110

Fixes: b999bdaf0597 ("arm64: dts: imx: Add i.mx8mm Gateworks gw7904 dts support")
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts
index c12e3f4f800f..6ca52a14a5ab 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts
@@ -628,6 +628,10 @@ &pcie0 {
 	status = "okay";
 };
 
+&disp_blk_ctrl {
+	status = "disabled";
+};
+
 &pgc_mipi {
 	status = "disabled";
 };
-- 
2.25.1

