Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF52E71546D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 06:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjE3EMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 00:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjE3EMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 00:12:49 -0400
Received: from mail.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50571E3
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 21:12:45 -0700 (PDT)
Received: from JammyHuang-PC.aspeed.com (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 30 May
 2023 12:12:42 +0800
From:   Jammy Huang <jammy_huang@aspeedtech.com>
To:     <tzimmermann@suse.de>, <airlied@redhat.com>, <airlied@gmail.com>,
        <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <wendy.wang@intel.com>
Subject: [PATCH v3] drm/ast: Fix long time waiting on s3/s4 resume
Date:   Tue, 30 May 2023 12:12:40 +0800
Message-ID: <20230530041240.13427-1-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In resume, DP's launch function, ast_dp_launch, could wait at most 30
seconds before timeout to check if DP is enabled. It could lead to 'DPM
device timeout' and trigger unrecoverable kernel panic.

To avoid this problem, we check if DP enable or not at driver probe only.

Reported-and-tested-by: Wendy Wang <wendy.wang@intel.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217278
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 v3 changes:
  - Update comments
 v2 changes:
  - Fix build error.
---
 drivers/gpu/drm/ast/ast_dp.c   | 55 +++++++++++-----------------------
 drivers/gpu/drm/ast/ast_drv.h  |  5 +---
 drivers/gpu/drm/ast/ast_main.c | 11 +++++--
 drivers/gpu/drm/ast/ast_post.c |  3 +-
 4 files changed, 29 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
index fbb070f63e36..6dc1a09504e1 100644
--- a/drivers/gpu/drm/ast/ast_dp.c
+++ b/drivers/gpu/drm/ast/ast_dp.c
@@ -119,53 +119,32 @@ int ast_astdp_read_edid(struct drm_device *dev, u8 *ediddata)
 /*
  * Launch Aspeed DP
  */
-void ast_dp_launch(struct drm_device *dev, u8 bPower)
+void ast_dp_launch(struct drm_device *dev)
 {
-	u32 i = 0, j = 0, WaitCount = 1;
-	u8 bDPTX = 0;
+	u32 i = 0;
 	u8 bDPExecute = 1;
-
 	struct ast_device *ast = to_ast_device(dev);
-	// S3 come back, need more time to wait BMC ready.
-	if (bPower)
-		WaitCount = 300;
-
-
-	// Wait total count by different condition.
-	for (j = 0; j < WaitCount; j++) {
-		bDPTX = ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xD1, TX_TYPE_MASK);
-
-		if (bDPTX)
-			break;
 
+	// Wait one second then timeout.
+	while (ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xD1, ASTDP_MCU_FW_EXECUTING) !=
+		ASTDP_MCU_FW_EXECUTING) {
+		i++;
+		// wait 100 ms
 		msleep(100);
-	}
 
-	// 0xE : ASTDP with DPMCU FW handling
-	if (bDPTX == ASTDP_DPMCU_TX) {
-		// Wait one second then timeout.
-		i = 0;
-
-		while (ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xD1, COPROCESSOR_LAUNCH) !=
-			COPROCESSOR_LAUNCH) {
-			i++;
-			// wait 100 ms
-			msleep(100);
-
-			if (i >= 10) {
-				// DP would not be ready.
-				bDPExecute = 0;
-				break;
-			}
+		if (i >= 10) {
+			// DP would not be ready.
+			bDPExecute = 0;
+			break;
 		}
+	}
 
-		if (bDPExecute)
-			ast->tx_chip_types |= BIT(AST_TX_ASTDP);
+	if (!bDPExecute)
+		drm_err(dev, "Wait DPMCU executing timeout\n");
 
-		ast_set_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xE5,
-							(u8) ~ASTDP_HOST_EDID_READ_DONE_MASK,
-							ASTDP_HOST_EDID_READ_DONE);
-	}
+	ast_set_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xE5,
+			       (u8) ~ASTDP_HOST_EDID_READ_DONE_MASK,
+			       ASTDP_HOST_EDID_READ_DONE);
 }
 
 
diff --git a/drivers/gpu/drm/ast/ast_drv.h b/drivers/gpu/drm/ast/ast_drv.h
index a501169cddad..5498a6676f2e 100644
--- a/drivers/gpu/drm/ast/ast_drv.h
+++ b/drivers/gpu/drm/ast/ast_drv.h
@@ -350,9 +350,6 @@ int ast_mode_config_init(struct ast_device *ast);
 #define AST_DP501_LINKRATE	0xf014
 #define AST_DP501_EDID_DATA	0xf020
 
-/* Define for Soc scratched reg */
-#define COPROCESSOR_LAUNCH			BIT(5)
-
 /*
  * Display Transmitter Type:
  */
@@ -480,7 +477,7 @@ struct ast_i2c_chan *ast_i2c_create(struct drm_device *dev);
 
 /* aspeed DP */
 int ast_astdp_read_edid(struct drm_device *dev, u8 *ediddata);
-void ast_dp_launch(struct drm_device *dev, u8 bPower);
+void ast_dp_launch(struct drm_device *dev);
 void ast_dp_power_on_off(struct drm_device *dev, bool no);
 void ast_dp_set_on_off(struct drm_device *dev, bool no);
 void ast_dp_set_mode(struct drm_crtc *crtc, struct ast_vbios_mode_info *vbios_mode);
diff --git a/drivers/gpu/drm/ast/ast_main.c b/drivers/gpu/drm/ast/ast_main.c
index f32ce29edba7..1f35438f614a 100644
--- a/drivers/gpu/drm/ast/ast_main.c
+++ b/drivers/gpu/drm/ast/ast_main.c
@@ -254,8 +254,13 @@ static int ast_detect_chip(struct drm_device *dev, bool *need_post)
 		case 0x0c:
 			ast->tx_chip_types = AST_TX_DP501_BIT;
 		}
-	} else if (ast->chip == AST2600)
-		ast_dp_launch(&ast->base, 0);
+	} else if (ast->chip == AST2600) {
+		if (ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xD1, TX_TYPE_MASK) ==
+		    ASTDP_DPMCU_TX) {
+			ast->tx_chip_types = AST_TX_ASTDP_BIT;
+			ast_dp_launch(&ast->base);
+		}
+	}
 
 	/* Print stuff for diagnostic purposes */
 	if (ast->tx_chip_types & AST_TX_NONE_BIT)
@@ -264,6 +269,8 @@ static int ast_detect_chip(struct drm_device *dev, bool *need_post)
 		drm_info(dev, "Using Sil164 TMDS transmitter\n");
 	if (ast->tx_chip_types & AST_TX_DP501_BIT)
 		drm_info(dev, "Using DP501 DisplayPort transmitter\n");
+	if (ast->tx_chip_types & AST_TX_ASTDP_BIT)
+		drm_info(dev, "Using ASPEED DisplayPort transmitter\n");
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/ast/ast_post.c b/drivers/gpu/drm/ast/ast_post.c
index 71bb36b865fd..a005aec18a02 100644
--- a/drivers/gpu/drm/ast/ast_post.c
+++ b/drivers/gpu/drm/ast/ast_post.c
@@ -380,7 +380,8 @@ void ast_post_gpu(struct drm_device *dev)
 	ast_set_def_ext_reg(dev);
 
 	if (ast->chip == AST2600) {
-		ast_dp_launch(dev, 1);
+		if (ast->tx_chip_types & AST_TX_ASTDP_BIT)
+			ast_dp_launch(dev);
 	} else if (ast->config_mode == ast_use_p2a) {
 		if (ast->chip == AST2500)
 			ast_post_chip_2500(dev);

base-commit: 933174ae28ba72ab8de5b35cb7c98fc211235096
-- 
2.25.1

