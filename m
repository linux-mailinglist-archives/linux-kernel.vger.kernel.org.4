Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8316A0302
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 08:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbjBWHAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 02:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbjBWHAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 02:00:00 -0500
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5C449885
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 22:59:56 -0800 (PST)
X-QQ-mid: bizesmtp75t1677135567t3kjq54g
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 23 Feb 2023 14:59:20 +0800 (CST)
X-QQ-SSF: 01400000002000I0Z000B00A0000000
X-QQ-FEAT: +ynUkgUhZJkR9eQJ/nI+SMX4brfSTlyTxBOx61PeeOB0U47PjI8FKsWbVuDlL
        vFlTnbMWRIjBsweExC4iGsfJC6eo+WGMhnRo8uI/EZm/OaE2sv9b9rI9dUnPzo7A8+vkwHL
        EmSsV6p2O/MfIr8ZA4loWwHSenXZs//hvHKf8s1rIqS5Qqbqvg+M+fZlmVX1VvlrYSJoIZJ
        h+a2O0okQXoMTdrBtH6WoYrvGtLKiURV+eFxgvGkzp9/6nmuiFQt92vyhP/H7ug+6PdMKKq
        nWlF9ITVcWVOVyOryddPaO+YfHYqWFw5OFYXgSsXyHzyg4lRSNJMvLnaCfJgkrkOlhh/X8A
        Aj3SodCETO0iEucjHFHISIKisidiAYGFZL9NNtyb9CeEyB125cR+yKOr1gALG8CHTrHcHqd
X-QQ-GoodBg: 2
From:   Meng Tang <tangmeng@uniontech.com>
To:     zackr@vmware.com, linux-graphics-maintainer@vmware.com,
        airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH] drm/vmwgfx: Work around VMW_ALLOC_DMABUF
Date:   Thu, 23 Feb 2023 14:59:18 +0800
Message-Id: <20230223065918.19644-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A privilege escalation vulnerability was found in vmwgfx driver
in drivers/gpu/drm/vmwgfx/vmwgfx_drv.c in GPU component of Linux
kernel with device file '/dev/dri/renderD128 (or Dxxx)'. This flaw
allows a local attacker with a user account on the system to gain
privilege, causing a denial of service(DoS).

This vulnerability can be quickly verified by the following code
logic:
...
dri_fd = open("/dev/dri/renderD128", O_RDWR);
ret = ioctl(dri_fd, 0xC0186441, &arg);
if (ret == 0) {
	printf("[*] VMW_ALLOC_DMABUF Success!\n");
}
...

Submit this commit to fix it.

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index bd02cb0e6837..0166f98be9df 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -1244,6 +1244,7 @@ static long vmw_generic_ioctl(struct file *filp, unsigned int cmd,
 						 unsigned long))
 {
 	struct drm_file *file_priv = filp->private_data;
+
 	struct drm_device *dev = file_priv->minor->dev;
 	unsigned int nr = DRM_IOCTL_NR(cmd);
 	unsigned int flags;
@@ -1263,6 +1264,10 @@ static long vmw_generic_ioctl(struct file *filp, unsigned int cmd,
 			if (!drm_is_current_master(file_priv) &&
 			    !capable(CAP_SYS_ADMIN))
 				return -EACCES;
+		} else if (nr == DRM_COMMAND_BASE + DRM_VMW_ALLOC_DMABUF) {
+			if (!drm_is_current_master(file_priv) &&
+			    !capable(CAP_SYS_ADMIN))
+				return -EPERM;
 		}
 
 		if (unlikely(ioctl->cmd != cmd))
-- 
2.20.1

