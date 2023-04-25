Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852386EDC14
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 09:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbjDYHEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 03:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbjDYHEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 03:04:13 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086B34ED5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 00:04:10 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 33P6kpTP054710;
        Tue, 25 Apr 2023 14:46:51 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from JammyHuang-PC.aspeed.com (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 25 Apr
 2023 15:03:32 +0800
From:   Jammy Huang <jammy_huang@aspeedtech.com>
To:     <airlied@redhat.com>, <tzimmermann@suse.de>
CC:     <airlied@gmail.com>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/ast: Fix modeset failed on DisplayPort
Date:   Tue, 25 Apr 2023 15:03:30 +0800
Message-ID: <20230425070330.8520-1-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 33P6kpTP054710
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
 drivers/gpu/drm/ast/ast_mode.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index 984ec590a7e7..fe5f1fd61361 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -1635,6 +1635,8 @@ static int ast_dp501_output_init(struct ast_private *ast)
 static int ast_astdp_connector_helper_get_modes(struct drm_connector *connector)
 {
 	void *edid;
+	struct drm_device *dev = connector->dev;
+	struct ast_private *ast = to_ast_private(dev);
 
 	int succ;
 	int count;
@@ -1643,10 +1645,18 @@ static int ast_astdp_connector_helper_get_modes(struct drm_connector *connector)
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
@@ -1654,6 +1664,7 @@ static int ast_astdp_connector_helper_get_modes(struct drm_connector *connector)
 	return count;
 
 err_kfree:
+	mutex_unlock(&ast->ioregs_lock);
 	kfree(edid);
 err_drm_connector_update_edid_property:
 	drm_connector_update_edid_property(connector, NULL);

base-commit: 61d325dcbc05d8fef88110d35ef7776f3ac3f68b
-- 
2.25.1

