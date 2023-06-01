Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5324718FB2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 02:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjFAAtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 20:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjFAAtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 20:49:04 -0400
Received: from mail.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015FA119
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 17:48:55 -0700 (PDT)
Received: from JammyHuang-PC.aspeed.com (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 1 Jun
 2023 08:48:51 +0800
From:   Jammy Huang <jammy_huang@aspeedtech.com>
To:     <tzimmermann@suse.de>, <airlied@redhat.com>, <airlied@gmail.com>,
        <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] drm/ast: Fix modeset failed on DisplayPort
Date:   Thu, 1 Jun 2023 08:48:47 +0800
Message-ID: <20230601004847.1115-1-jammy_huang@aspeedtech.com>
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

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 v3 changes:
  - Update label name after mutex added.
 v2 changes:
  - Fix build error since new struct ast_device is used.
---
 drivers/gpu/drm/ast/ast_mode.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index 36374828f6c8..b3c670af6ef2 100644
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
@@ -1655,9 +1657,17 @@ static int ast_astdp_connector_helper_get_modes(struct drm_connector *connector)
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
-		goto err_kfree;
+		goto err_mutex_unlock;
+
+	mutex_unlock(&ast->ioregs_lock);
 
 	drm_connector_update_edid_property(connector, edid);
 	count = drm_add_edid_modes(connector, edid);
@@ -1665,7 +1675,8 @@ static int ast_astdp_connector_helper_get_modes(struct drm_connector *connector)
 
 	return count;
 
-err_kfree:
+err_mutex_unlock:
+	mutex_unlock(&ast->ioregs_lock);
 	kfree(edid);
 err_drm_connector_update_edid_property:
 	drm_connector_update_edid_property(connector, NULL);

base-commit: e338142b39cf40155054f95daa28d210d2ee1b2d
-- 
2.25.1

