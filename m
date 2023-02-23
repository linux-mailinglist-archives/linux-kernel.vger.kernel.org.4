Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69556A0322
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 08:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjBWHFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 02:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjBWHFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 02:05:09 -0500
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C2410CE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 23:05:06 -0800 (PST)
X-QQ-mid: bizesmtp84t1677135853tqyp6rcl
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 23 Feb 2023 15:04:08 +0800 (CST)
X-QQ-SSF: 01400000002000I0Z000B00A0000000
X-QQ-FEAT: QityeSR92A2+ZDiL078F7dx9NzgCrHZf3hKY4jiHovEDkRbY5wSRSIpUcYd8e
        h9RJvN2p4uegxhSrC89atZeSSkHIpJxRFNcob+iNie78BnTsRYPNiuMi+c4dp/icfL1mta+
        OLjXgubLx90fyWUCsjue/SswG+D64XrLaS76WE+S6Jn5lUtxHmttJpn96K8nXixdEmO00ho
        aTjE0eH49/u7DKqoaG/4R50ChZinchhQpdw3E/LqDPbQ3evXhNpZ8VpLurso/5C7nfjAfLy
        yUjPoWk0AFdY8vn0CY5ZT+yBG658tRHvn4sJR1gJMFRY2KuXVj54kDYmSP3gJmiOHIoVmCY
        1Cl4dQn1T4LYpqAoRRweLHH97+Vn/J+kyds27ANTNQhuziGk4zk4/1wXw46av2xTtB+QFAB
        R3FB0iOfFqs=
X-QQ-GoodBg: 2
From:   Meng Tang <tangmeng@uniontech.com>
To:     zackr@vmware.com, linux-graphics-maintainer@vmware.com,
        airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH v2] drm/vmwgfx: Work around VMW_ALLOC_DMABUF
Date:   Thu, 23 Feb 2023 15:04:05 +0800
Message-Id: <20230223070405.20228-1-tangmeng@uniontech.com>
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
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index bd02cb0e6837..115787697957 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -1263,6 +1263,10 @@ static long vmw_generic_ioctl(struct file *filp, unsigned int cmd,
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

