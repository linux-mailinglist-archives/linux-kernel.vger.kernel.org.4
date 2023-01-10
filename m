Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA425664D26
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 21:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjAJUUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 15:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjAJUUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 15:20:22 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36565A8AB
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 12:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673382014; bh=3IN9oMdJEqlNBIK1U/bjP9YXRSbJh4/m3TFLBgmJQjI=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=PkLGkBDZMDIMzc1ZUqgcyv2wtAU5J4WrlCj5Gt/uw9+WrxuWBhUiPXinVBOirqn4S
         5vXM3auhPPhwgflkNf0oWVy97405s1+2SSOUEZhb6w93CiFlhCRX2mmnUomEyuzb4V
         9ZtpT23PtPkFuM6QKRTLi1dPHuE+XeROjZ7lSecI=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue, 10 Jan 2023 21:20:14 +0100 (CET)
X-EA-Auth: KbkOyS25WULzAeG0UfhXEQVuLt1NKF3jwhnHNmxVSoeI5v0VIWxMywgam6RktIG0CCef3vfPkXKBPQpRHPbc2td67xmxw839
Date:   Wed, 11 Jan 2023 01:50:06 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Alain Volmat <alain.volmat@foss.st.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: [PATCH] drm/sti: Avoid full proxy f_ops for sti debug attributes
Message-ID: <Y73IdsbXhB5aUrkP@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using DEFINE_SIMPLE_ATTRIBUTE macro with the debugfs_create_file()
function adds the overhead of introducing a proxy file operation
functions to wrap the original read/write inside file removal protection
functions. This adds significant overhead in terms of introducing and
managing the proxy factory file operations structure and function
wrapping at runtime.
As a replacement, a combination of DEFINE_DEBUGFS_ATTRIBUTE macro paired
with debugfs_create_file_unsafe() is suggested to be used instead.  The
DEFINE_DEBUGFS_ATTRIBUTE utilises debugfs_file_get() and
debugfs_file_put() wrappers to protect the original read and write
function calls for the debug attributes. There is no need for any
runtime proxy file operations to be managed by the debugfs core.
Following coccicheck make command helped identify this change:

make coccicheck M=drivers/gpu/drm/i915/ MODE=patch COCCI=./scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Note: Change cross compile tested using stm32_defconfig for arm

 drivers/gpu/drm/sti/sti_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_drv.c b/drivers/gpu/drm/sti/sti_drv.c
index ef6a4e63198f..c9be82043638 100644
--- a/drivers/gpu/drm/sti/sti_drv.c
+++ b/drivers/gpu/drm/sti/sti_drv.c
@@ -67,8 +67,8 @@ static int sti_drm_fps_set(void *data, u64 val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(sti_drm_fps_fops,
-			sti_drm_fps_get, sti_drm_fps_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(sti_drm_fps_fops,
+			 sti_drm_fps_get, sti_drm_fps_set, "%llu\n");
 
 static int sti_drm_fps_dbg_show(struct seq_file *s, void *data)
 {
@@ -97,8 +97,8 @@ static void sti_drm_dbg_init(struct drm_minor *minor)
 				 ARRAY_SIZE(sti_drm_dbg_list),
 				 minor->debugfs_root, minor);
 
-	debugfs_create_file("fps_show", S_IRUGO | S_IWUSR, minor->debugfs_root,
-			    minor->dev, &sti_drm_fps_fops);
+	debugfs_create_file_unsafe("fps_show", S_IRUGO | S_IWUSR, minor->debugfs_root,
+				   minor->dev, &sti_drm_fps_fops);
 
 	DRM_INFO("%s: debugfs installed\n", DRIVER_NAME);
 }
-- 
2.34.1



