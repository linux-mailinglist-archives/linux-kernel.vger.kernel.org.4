Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DA6642786
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 12:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiLELcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 06:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiLELcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 06:32:18 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7148A10569;
        Mon,  5 Dec 2022 03:32:17 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NQhGm1R5fz8R03x;
        Mon,  5 Dec 2022 19:32:16 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2B5BW6mo072861;
        Mon, 5 Dec 2022 19:32:06 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Mon, 5 Dec 2022 19:32:08 +0800 (CST)
Date:   Mon, 5 Dec 2022 19:32:08 +0800 (CST)
X-Zmail-TransId: 2af9638dd6b8438dfdb8
X-Mailer: Zmail v1.0
Message-ID: <202212051932088061889@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <paul@paul-moore.com>
Cc:     <stephen.smalley.work@gmail.com>, <eparis@parisplace.org>,
        <selinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHNlY3VyaXR5LW5leHRdIHNlbGludXg6IHVzZSBzeXNmc19lbWl0KCkgdG8gaW5zdGVhZCBvZiBzY25wcmludGYoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B5BW6mo072861
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 638DD6C0.000 by FangMail milter!
X-FangMail-Envelope: 1670239936/4NQhGm1R5fz8R03x/638DD6C0.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 638DD6C0.000/4NQhGm1R5fz8R03x
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Follow the advice of the Documentation/filesystems/sysfs.rst and show()
should only use sysfs_emit() or sysfs_emit_at() when formatting the
value to be returned to user space.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 security/selinux/avc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 9a43af0ebd7d..517fe3454aec 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -174,7 +174,7 @@ int avc_get_hash_stats(struct selinux_avc *avc, char *page)

 	rcu_read_unlock();

-	return scnprintf(page, PAGE_SIZE, "entries: %d\nbuckets used: %d/%d\n"
+	return sysfs_emit(page, "entries: %d\nbuckets used: %d/%d\n"
 			 "longest chain: %d\n",
 			 atomic_read(&avc->avc_cache.active_nodes),
 			 slots_used, AVC_CACHE_SLOTS, max_chain_len);
-- 
2.25.1
