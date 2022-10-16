Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7184600339
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 22:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiJPUPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 16:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJPUPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 16:15:39 -0400
X-Greylist: delayed 682 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 16 Oct 2022 13:15:36 PDT
Received: from h5.fbrelay.privateemail.com (h5.fbrelay.privateemail.com [162.0.218.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54D92656D
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 13:15:36 -0700 (PDT)
Received: from MTA-13-3.privateemail.com (mta-13-1.privateemail.com [198.54.122.107])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by h5.fbrelay.privateemail.com (Postfix) with ESMTPS id D8863606D1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 20:04:11 +0000 (UTC)
Received: from mta-13.privateemail.com (localhost [127.0.0.1])
        by mta-13.privateemail.com (Postfix) with ESMTP id 33F5018000AB;
        Sun, 16 Oct 2022 16:04:10 -0400 (EDT)
Received: from hal-station.. (bras-base-toroon4321w-grc-73-76-67-77-249.dsl.bell.ca [76.67.77.249])
        by mta-13.privateemail.com (Postfix) with ESMTPA id 3754918000A7;
        Sun, 16 Oct 2022 16:04:02 -0400 (EDT)
From:   Hamza Mahfooz <someguy@effective-light.com>
To:     linux-kernel@vger.kernel.org
Cc:     Hamza Mahfooz <someguy@effective-light.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/framebuffer: break out of loop, if the requested element is found
Date:   Sun, 16 Oct 2022 16:03:23 -0400
Message-Id: <20221016200324.17930-1-someguy@effective-light.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can stop searching through the linked-list after we have found the
element we are looking for. So, break out of list_for_each_entry()
after we have found the element we are looking for in drm_mode_rmfb().

Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
---
 drivers/gpu/drm/drm_framebuffer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
index 2dd97473ca10..557177a4c5be 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -441,8 +441,11 @@ int drm_mode_rmfb(struct drm_device *dev, u32 fb_id,
 
 	mutex_lock(&file_priv->fbs_lock);
 	list_for_each_entry(fbl, &file_priv->fbs, filp_head)
-		if (fb == fbl)
+		if (fb == fbl) {
 			found = 1;
+			break;
+		}
+
 	if (!found) {
 		mutex_unlock(&file_priv->fbs_lock);
 		goto fail_unref;
-- 
2.37.3

