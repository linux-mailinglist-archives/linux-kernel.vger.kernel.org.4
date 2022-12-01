Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BADC63E80C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 03:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiLACxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 21:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiLACxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 21:53:38 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB8089AD1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 18:53:37 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NN0y76GV1z8QrkZ;
        Thu,  1 Dec 2022 10:53:35 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2B12rP0R030683;
        Thu, 1 Dec 2022 10:53:25 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 1 Dec 2022 10:53:26 +0800 (CST)
Date:   Thu, 1 Dec 2022 10:53:26 +0800 (CST)
X-Zmail-TransId: 2af9638817266e81791a
X-Mailer: Zmail v1.0
Message-ID: <202212011053265568903@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <joonas.lahtinen@linux.intel.com>
Cc:     <jani.nikula@linux.intel.com>, <rodrigo.vivi@intel.com>,
        <tvrtko.ursulin@linux.intel.com>, <airlied@gmail.com>,
        <daniel@ffwll.ch>, <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBkcm0vaTkxNTogdXNlIHN5c2ZzX2VtaXQoKSB0byBpbnN0ZWFkIG9mIHNjbnByaW50Zigp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B12rP0R030683
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 6388172F.000 by FangMail milter!
X-FangMail-Envelope: 1669863215/4NN0y76GV1z8QrkZ/6388172F.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6388172F.000/4NN0y76GV1z8QrkZ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Replace the open-code with sysfs_emit() to simplify the code.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/gpu/drm/i915/i915_mitigations.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_mitigations.c b/drivers/gpu/drm/i915/i915_mitigations.c
index def7302ef7fe..2b7aaaefb3a9 100644
--- a/drivers/gpu/drm/i915/i915_mitigations.c
+++ b/drivers/gpu/drm/i915/i915_mitigations.c
@@ -102,10 +102,10 @@ static int mitigations_get(char *buffer, const struct kernel_param *kp)
 	bool enable;

 	if (!local)
-		return scnprintf(buffer, PAGE_SIZE, "%s\n", "off");
+		return sysfs_emit(buffer, "%s\n", "off");

 	if (local & BIT(BITS_PER_LONG - 1)) {
-		count = scnprintf(buffer, PAGE_SIZE, "%s,", "auto");
+		count = sysfs_emit(buffer, "%s,", "auto");
 		enable = false;
 	} else {
 		enable = true;
-- 
2.25.1
