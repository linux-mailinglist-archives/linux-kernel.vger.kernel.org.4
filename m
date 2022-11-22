Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2169E633C08
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 13:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbiKVMII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 07:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiKVMIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:08:06 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387DE2790D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 04:08:03 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NGjh12Qybz5PkGj;
        Tue, 22 Nov 2022 20:08:01 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
        by mse-fl2.zte.com.cn with SMTP id 2AMC7uCC005801;
        Tue, 22 Nov 2022 20:07:56 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
        by mapi (Zmail) with MAPI id mid14;
        Tue, 22 Nov 2022 20:07:59 +0800 (CST)
Date:   Tue, 22 Nov 2022 20:07:59 +0800 (CST)
X-Zmail-TransId: 2b04637cbb9ffffffffffa0dfedf
X-Mailer: Zmail v1.0
Message-ID: <202211222007593082125@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <zhenyuw@linux.intel.com>
Cc:     <zhi.a.wang@intel.com>, <jani.nikula@linux.intel.com>,
        <joonas.lahtinen@linux.intel.com>, <rodrigo.vivi@intel.com>,
        <tvrtko.ursulin@linux.intel.com>, <airlied@gmail.com>,
        <daniel@ffwll.ch>, <intel-gvt-dev@lists.freedesktop.org>,
        <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <xu.panda@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGRybS9pOTE1L2d2dDogdXNlIHN5c2ZzX3N0cmVxKCkgaW5zdGVhZCBvZiBzdHJuY21wKCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2AMC7uCC005801
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 637CBBA1.000 by FangMail milter!
X-FangMail-Envelope: 1669118881/4NGjh12Qybz5PkGj/637CBBA1.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 637CBBA1.000/4NGjh12Qybz5PkGj
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

Replace the open-code with sysfs_streq().

Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com>
---
 drivers/gpu/drm/i915/gvt/cmd_parser.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/cmd_parser.c b/drivers/gpu/drm/i915/gvt/cmd_parser.c
index 0ebf5fbf0e39..7b9a5f7f5363 100644
--- a/drivers/gpu/drm/i915/gvt/cmd_parser.c
+++ b/drivers/gpu/drm/i915/gvt/cmd_parser.c
@@ -917,8 +917,8 @@ static int cmd_reg_handler(struct parser_exec_state *s,
 		return -EBADRQC;
 	}

-	if (!strncmp(cmd, "srm", 3) ||
-			!strncmp(cmd, "lrm", 3)) {
+	if (sysfs_streq(cmd, "srm") ||
+			sysfs_streq(cmd, "lrm")) {
 		if (offset == i915_mmio_reg_offset(GEN8_L3SQCREG4) ||
 		    offset == 0x21f0 ||
 		    (IS_BROADWELL(gvt->gt->i915) &&
@@ -931,8 +931,8 @@ static int cmd_reg_handler(struct parser_exec_state *s,
 		}
 	}

-	if (!strncmp(cmd, "lrr-src", 7) ||
-			!strncmp(cmd, "lrr-dst", 7)) {
+	if (sysfs_streq(cmd, "lrr-src") ||
+			sysfs_streq(cmd, "lrr-dst")) {
 		if (IS_BROADWELL(gvt->gt->i915) && offset == 0x215c)
 			return 0;
 		else {
@@ -941,12 +941,12 @@ static int cmd_reg_handler(struct parser_exec_state *s,
 		}
 	}

-	if (!strncmp(cmd, "pipe_ctrl", 9)) {
+	if (sysfs_streq(cmd, "pipe_ctrl")) {
 		/* TODO: add LRI POST logic here */
 		return 0;
 	}

-	if (strncmp(cmd, "lri", 3))
+	if (!sysfs_streq(cmd, "lri"))
 		return -EPERM;

 	/* below are all lri handlers */
@@ -1011,7 +1011,7 @@ static int cmd_reg_handler(struct parser_exec_state *s,
 	 */
 	if (GRAPHICS_VER(s->engine->i915) == 9 &&
 	    intel_gvt_mmio_is_sr_in_ctx(gvt, offset) &&
-	    !strncmp(cmd, "lri", 3)) {
+	    sysfs_streq(cmd, "lri")) {
 		intel_gvt_read_gpa(s->vgpu,
 			s->workload->ring_context_gpa + 12, &ctx_sr_ctl, 4);
 		/* check inhibit context */
-- 
2.15.2
