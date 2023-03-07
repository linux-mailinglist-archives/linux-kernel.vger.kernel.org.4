Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001E46AE3F4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjCGPIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjCGPIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:08:07 -0500
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68ADE4FF1C;
        Tue,  7 Mar 2023 07:01:54 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id EF347FDA7E;
        Tue,  7 Mar 2023 07:01:34 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kw7ysgBL9VYr; Tue,  7 Mar 2023 07:01:33 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1678201293; bh=jlx4mkYv8DWYEk8wvjS1oACmUl5j+kfP5YErl2ThcKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BQ+JaQmH+kCmbzeAvnKQ9GbiSzv1VOPFzi4IrjiRt/0+x+twMiYXWSoT4BZAiEZyW
         7v0BhUXXqbGjjSmwCGJ42+/2u19XXjQl6vmz5loLuNTQFLCKBKw+PZtXfrD0amZK74
         r5DHaAXxG+o0BzOYM/xqIb5HLD3K5/0thDY44VuStdOt4ho6OQ1WLR1v30IF3PwoCy
         1TGJ0eEh3ASMaWseGxO4rnq4/VXE8tykUlAN7m9hNDvj/pbUhypyQGdDcjcoB2uFGu
         M0TElc6F/SIMtXo62+T+SPK1qghqJXK0wefIKaqdDj2dyFfCruRD9nmynx5vuU/+FB
         LXb7G414LHPHg==
To:     laurent.pinchart@ideasonboard.com, slongerbeam@gmail.com,
        p.zabel@pengutronix.de, mchehab@kernel.org,
        gregkh@linuxfoundation.org, shawnguo@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm, Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v2 2/2] media: imx: imx8mq-mipi-csi2: remove unneeded state variable and function
Date:   Tue,  7 Mar 2023 16:00:47 +0100
Message-Id: <20230307150047.1486186-3-martin.kepplinger@puri.sm>
In-Reply-To: <20230307150047.1486186-1-martin.kepplinger@puri.sm>
References: <20230307150047.1486186-1-martin.kepplinger@puri.sm>
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

Clean up the driver a bit by inlining the imx8mq_mipi_csi_system_enable()
function to the callsites and removing the hs_settle variable from the
driver state.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 drivers/staging/media/imx/imx8mq-mipi-csi2.c | 41 ++++++++------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/media/imx/imx8mq-mipi-csi2.c b/drivers/staging/media/imx/imx8mq-mipi-csi2.c
index 1aa8622a3bae..f10b59b8f1c0 100644
--- a/drivers/staging/media/imx/imx8mq-mipi-csi2.c
+++ b/drivers/staging/media/imx/imx8mq-mipi-csi2.c
@@ -119,9 +119,8 @@ struct csi_state {
 
 	struct v4l2_mbus_config_mipi_csi2 bus;
 
-	struct mutex lock; /* Protect state and hs_settle */
+	struct mutex lock; /* Protect state */
 	u32 state;
-	u32 hs_settle;
 
 	struct regmap *phy_gpr;
 	u8 phy_gpr_reg;
@@ -264,23 +263,6 @@ static int imx8mq_mipi_csi_sw_reset(struct csi_state *state)
 	return 0;
 }
 
-static void imx8mq_mipi_csi_system_enable(struct csi_state *state, int on)
-{
-	if (!on) {
-		imx8mq_mipi_csi_write(state, CSI2RX_CFG_DISABLE_DATA_LANES, 0xf);
-		return;
-	}
-
-	regmap_update_bits(state->phy_gpr,
-			   state->phy_gpr_reg,
-			   0x3fff,
-			   GPR_CSI2_1_RX_ENABLE |
-			   GPR_CSI2_1_VID_INTFC_ENB |
-			   GPR_CSI2_1_HSEL |
-			   GPR_CSI2_1_CONT_CLK_MODE |
-			   GPR_CSI2_1_S_PRG_RXHS_SETTLE(state->hs_settle));
-}
-
 static void imx8mq_mipi_csi_set_params(struct csi_state *state)
 {
 	int lanes = state->bus.num_data_lanes;
@@ -321,7 +303,8 @@ static int imx8mq_mipi_csi_clk_get(struct csi_state *state)
 }
 
 static int imx8mq_mipi_csi_calc_hs_settle(struct csi_state *state,
-					  struct v4l2_subdev_state *sd_state)
+					  struct v4l2_subdev_state *sd_state,
+					  u32 *hs_settle)
 {
 	s64 link_freq;
 	u32 lane_rate;
@@ -377,10 +360,10 @@ static int imx8mq_mipi_csi_calc_hs_settle(struct csi_state *state,
 	max_ths_settle = 140 + 10 * 1000000 / (lane_rate / 1000);
 	ths_settle_ns = (min_ths_settle + max_ths_settle) / 2;
 
-	state->hs_settle = ths_settle_ns / esc_clk_period_ns - 1;
+	*hs_settle = ths_settle_ns / esc_clk_period_ns - 1;
 
 	dev_dbg(state->dev, "lane rate %u Ths_settle %u hs_settle %u\n",
-		lane_rate, ths_settle_ns, state->hs_settle);
+		lane_rate, ths_settle_ns, *hs_settle);
 
 	return 0;
 }
@@ -389,24 +372,32 @@ static int imx8mq_mipi_csi_start_stream(struct csi_state *state,
 					struct v4l2_subdev_state *sd_state)
 {
 	int ret;
+	u32 hs_settle;
 
 	ret = imx8mq_mipi_csi_sw_reset(state);
 	if (ret)
 		return ret;
 
 	imx8mq_mipi_csi_set_params(state);
-	ret = imx8mq_mipi_csi_calc_hs_settle(state, sd_state);
+	ret = imx8mq_mipi_csi_calc_hs_settle(state, sd_state, &hs_settle);
 	if (ret)
 		return ret;
 
-	imx8mq_mipi_csi_system_enable(state, true);
+	regmap_update_bits(state->phy_gpr,
+			   state->phy_gpr_reg,
+			   0x3fff,
+			   GPR_CSI2_1_RX_ENABLE |
+			   GPR_CSI2_1_VID_INTFC_ENB |
+			   GPR_CSI2_1_HSEL |
+			   GPR_CSI2_1_CONT_CLK_MODE |
+			   GPR_CSI2_1_S_PRG_RXHS_SETTLE(hs_settle));
 
 	return 0;
 }
 
 static void imx8mq_mipi_csi_stop_stream(struct csi_state *state)
 {
-	imx8mq_mipi_csi_system_enable(state, false);
+	imx8mq_mipi_csi_write(state, CSI2RX_CFG_DISABLE_DATA_LANES, 0xf);
 }
 
 /* -----------------------------------------------------------------------------
-- 
2.30.2

