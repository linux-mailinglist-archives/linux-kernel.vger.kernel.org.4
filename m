Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0EF71025F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 03:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236194AbjEYB3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 21:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjEYB31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 21:29:27 -0400
Received: from mail.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679C4F5
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 18:29:24 -0700 (PDT)
Received: from JammyHuang-PC.aspeed.com (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 25 May
 2023 09:29:21 +0800
From:   Jammy Huang <jammy_huang@aspeedtech.com>
To:     <tzimmermann@suse.de>, <airlied@redhat.com>, <airlied@gmail.com>,
        <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] drm/ast: Fix modeset failed on DisplayPort
Date:   Thu, 25 May 2023 09:29:18 +0800
Message-ID: <20230525012918.11918-1-jammy_huang@aspeedtech.com>
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

If we switch display and update cursor together, it could lead to
modeset failed because of concurrent access to IO registers.

Add lock protection in DP's edid access to avoid this problem.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 v2 changes:
  - Fix build error since new struct ast_device is used.
---
 drivers/gpu/drm/ast/ast_mode.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index 36374828f6c8..9fcbf540d6fc 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -1647,6 +1647,8 @@ static int ast_dp501_output_init(struct ast_device *ast)
 static int ast_astdp_connector_helper_get_modes(struct drm_connector *connector)
 {
 	void *edid;
+	struct drm_device *dev = connector->dev;
+	struct ast_device *ast = to_ast_device(dev);
 
 	int succ;
 	int count;
@@ -1655,10 +1657,18 @@ static int ast_astdp_connector_helper_get_modes(struct drm_connector *connector)
 	if (!edid)
 		goto err_drm_connector_update_edid_property;
 
+	/*
+	 * Protect access to I/O registers from concurrent modesetting
+	 * by acquiring the I/O-register lock.
+	 */
+	mutex_lock(&ast->ioregs_lock);
+
 	succ = ast_astdp_read_edid(connector->dev, edid);
 	if (succ < 0)
 		goto err_kfree;
 
+	mutex_unlock(&ast->ioregs_lock);
+
 	drm_connector_update_edid_property(connector, edid);
 	count = drm_add_edid_modes(connector, edid);
 	kfree(edid);
@@ -1666,6 +1676,7 @@ static int ast_astdp_connector_helper_get_modes(struct drm_connector *connector)
 	return count;
 
 err_kfree:
+	mutex_unlock(&ast->ioregs_lock);
 	kfree(edid);
 err_drm_connector_update_edid_property:
 	drm_connector_update_edid_property(connector, NULL);

base-commit: 933174ae28ba72ab8de5b35cb7c98fc211235096
-- 
2.25.1

