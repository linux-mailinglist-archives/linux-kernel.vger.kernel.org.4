Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4A3732DB0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343500AbjFPK1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344129AbjFPK00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:26:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361943A9E;
        Fri, 16 Jun 2023 03:25:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84E3762B57;
        Fri, 16 Jun 2023 10:25:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54C3C433BD;
        Fri, 16 Jun 2023 10:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686911147;
        bh=ExstxKPrGbziirkucB5PqIckFETFvkocrqw85/Grcv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VnTJ3de2zeV16ltBQyW4hUPjAz7PtnUC3L2sZD2/JuuIddWi3JspaPCmcKrzn8aWS
         g6EFtmKf0L1nEkC33Gv63ib/xMKF1uDFoGIFVPIGcVOwUvpizX1fd8j+FNb+hmecII
         y7fm+lSC6nRN6EMyDltq5DnsSI5jETufHhdmMHgb4MyC0Vpbc5/S9EZ3uXR+rCOhO4
         9igg3OAZWdgmMO+nyqBKCaG/ZvLE5dvV0r7YnQesTQdWsPHp0BV8cuw2HHfv01sM4Y
         aAHhocB7zmLE0AWgNuCo2YHCrnwK1XR7qa0/xOZZBDuZ5wQt/WVLbV3XdGqTGW6tC1
         XTKcZptHV0xfw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jammy Huang <jammy_huang@aspeedtech.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sasha Levin <sashal@kernel.org>, airlied@redhat.com,
        airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.3 13/30] drm/ast: Fix modeset failed on DisplayPort
Date:   Fri, 16 Jun 2023 06:25:01 -0400
Message-Id: <20230616102521.673087-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616102521.673087-1-sashal@kernel.org>
References: <20230616102521.673087-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jammy Huang <jammy_huang@aspeedtech.com>

[ Upstream commit 3692ababa322b4d9ffbd973865bc88018e896fcd ]

If we switch display and update cursor together, it could lead to
modeset failed because of concurrent access to IO registers.

Add lock protection in DP's edid access to avoid this problem.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20230601004847.1115-1-jammy_huang@aspeedtech.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/ast/ast_mode.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index 984ec590a7e7d..e267cf9f505b9 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -1635,6 +1635,8 @@ static int ast_dp501_output_init(struct ast_private *ast)
 static int ast_astdp_connector_helper_get_modes(struct drm_connector *connector)
 {
 	void *edid;
+	struct drm_device *dev = connector->dev;
+	struct ast_device *ast = to_ast_device(dev);
 
 	int succ;
 	int count;
@@ -1643,9 +1645,17 @@ static int ast_astdp_connector_helper_get_modes(struct drm_connector *connector)
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
@@ -1653,7 +1663,8 @@ static int ast_astdp_connector_helper_get_modes(struct drm_connector *connector)
 
 	return count;
 
-err_kfree:
+err_mutex_unlock:
+	mutex_unlock(&ast->ioregs_lock);
 	kfree(edid);
 err_drm_connector_update_edid_property:
 	drm_connector_update_edid_property(connector, NULL);
-- 
2.39.2

