Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5575BA893
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 10:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiIPIvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 04:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiIPIva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 04:51:30 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB94FA894D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 01:51:28 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 28G8URNb082766;
        Fri, 16 Sep 2022 16:30:27 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from JammyHuang-PC.aspeed.com (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 16 Sep
 2022 16:50:59 +0800
From:   Jammy Huang <jammy_huang@aspeedtech.com>
To:     <airlied@redhat.com>, <tzimmermann@suse.de>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] drm/ast: Add resolution support for 1152x864@75
Date:   Fri, 16 Sep 2022 16:50:58 +0800
Message-ID: <20220916085058.3386-1-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 28G8URNb082766
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 1152x864 into support list.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
v2 changes:
 - add check in mode_valid
---
 drivers/gpu/drm/ast/ast_mode.c   | 9 +++++++++
 drivers/gpu/drm/ast/ast_tables.h | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index 214b10178454..d327dcbaf032 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -114,6 +114,9 @@ static bool ast_get_vbios_mode_info(const struct drm_format_info *format,
 	case 1024:
 		vbios_mode->enh_table = &res_1024x768[refresh_rate_index];
 		break;
+	case 1152:
+		vbios_mode->enh_table = &res_1152x864[refresh_rate_index];
+		break;
 	case 1280:
 		if (mode->crtc_vdisplay == 800)
 			vbios_mode->enh_table = &res_1280x800[refresh_rate_index];
@@ -1058,6 +1061,8 @@ ast_crtc_helper_mode_valid(struct drm_crtc *crtc, const struct drm_display_mode
 			return MODE_OK;
 		if ((mode->hdisplay == 1600) && (mode->vdisplay == 900))
 			return MODE_OK;
+		if ((mode->hdisplay == 1152) && (mode->vdisplay == 864))
+			return MODE_OK;
 
 		if ((ast->chip == AST2100) || (ast->chip == AST2200) ||
 		    (ast->chip == AST2300) || (ast->chip == AST2400) ||
@@ -1090,6 +1095,10 @@ ast_crtc_helper_mode_valid(struct drm_crtc *crtc, const struct drm_display_mode
 		if (mode->vdisplay == 768)
 			status = MODE_OK;
 		break;
+	case 1152:
+		if (mode->vdisplay == 864)
+			status = MODE_OK;
+		break;
 	case 1280:
 		if (mode->vdisplay == 1024)
 			status = MODE_OK;
diff --git a/drivers/gpu/drm/ast/ast_tables.h b/drivers/gpu/drm/ast/ast_tables.h
index dbe1cc620f6e..0378c9bc079b 100644
--- a/drivers/gpu/drm/ast/ast_tables.h
+++ b/drivers/gpu/drm/ast/ast_tables.h
@@ -272,6 +272,13 @@ static const struct ast_vbios_enhtable res_1600x1200[] = {
 	 (SyncPP | Charx8Dot), 0xFF, 1, 0x33 },
 };
 
+static const struct ast_vbios_enhtable res_1152x864[] = {
+	{1600, 1152, 64, 128,  900,  864, 1, 3, VCLK108,	/* 75Hz */
+	 (SyncPP | Charx8Dot | NewModeInfo), 75, 1, 0x3B },
+	{1600, 1152, 64, 128,  900,  864, 1, 3, VCLK108,	/* end */
+	 (SyncPP | Charx8Dot | NewModeInfo), 0xFF, 1, 0x3B },
+};
+
 /* 16:9 */
 static const struct ast_vbios_enhtable res_1360x768[] = {
 	{1792, 1360, 64, 112, 795, 768, 3, 6, VCLK85_5,		/* 60Hz */
-- 
2.25.1

