Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7956664271E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 12:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiLELD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 06:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiLELDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 06:03:53 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B227223
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 03:03:51 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NQgdx22Mbz4y0vM;
        Mon,  5 Dec 2022 19:03:49 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2B5B3b3Y053222;
        Mon, 5 Dec 2022 19:03:37 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Mon, 5 Dec 2022 19:03:39 +0800 (CST)
Date:   Mon, 5 Dec 2022 19:03:39 +0800 (CST)
X-Zmail-TransId: 2af9638dd00b38ebad33
X-Mailer: Zmail v1.0
Message-ID: <202212051903396321367@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <hubcap@omnibond.com>
Cc:     <martin@omnibond.com>, <devel@lists.orangefs.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBvcmFuZ2VmczogdXNlIHN5c2ZzX2VtaXQoKSB0byBpbnN0ZWFkIG9mIHNjbnByaW50Zigp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B5B3b3Y053222
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 638DD015.001 by FangMail milter!
X-FangMail-Envelope: 1670238229/4NQgdx22Mbz4y0vM/638DD015.001/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 638DD015.001/4NQgdx22Mbz4y0vM
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
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
 fs/orangefs/orangefs-sysfs.c | 45 ++++++++----------------------------
 1 file changed, 10 insertions(+), 35 deletions(-)

diff --git a/fs/orangefs/orangefs-sysfs.c b/fs/orangefs/orangefs-sysfs.c
index de80b62553bb..c89f16052e92 100644
--- a/fs/orangefs/orangefs-sysfs.c
+++ b/fs/orangefs/orangefs-sysfs.c
@@ -217,38 +217,23 @@ static ssize_t sysfs_int_show(struct kobject *kobj,

 	if (!strcmp(kobj->name, ORANGEFS_KOBJ_ID)) {
 		if (!strcmp(attr->attr.name, "op_timeout_secs")) {
-			rc = scnprintf(buf,
-				       PAGE_SIZE,
-				       "%d\n",
-				       op_timeout_secs);
+			rc = sysfs_emit(buf, "%d\n", op_timeout_secs);
 			goto out;
 		} else if (!strcmp(attr->attr.name,
 				   "slot_timeout_secs")) {
-			rc = scnprintf(buf,
-				       PAGE_SIZE,
-				       "%d\n",
-				       slot_timeout_secs);
+			rc = sysfs_emit(buf, "%d\n", slot_timeout_secs);
 			goto out;
 		} else if (!strcmp(attr->attr.name,
 				   "cache_timeout_msecs")) {
-			rc = scnprintf(buf,
-				       PAGE_SIZE,
-				       "%d\n",
-				       orangefs_cache_timeout_msecs);
+			rc = sysfs_emit(buf, "%d\n", orangefs_cache_timeout_msecs);
 			goto out;
 		} else if (!strcmp(attr->attr.name,
 				   "dcache_timeout_msecs")) {
-			rc = scnprintf(buf,
-				       PAGE_SIZE,
-				       "%d\n",
-				       orangefs_dcache_timeout_msecs);
+			rc = sysfs_emit(buf, "%d\n", orangefs_dcache_timeout_msecs);
 			goto out;
 		} else if (!strcmp(attr->attr.name,
 				   "getattr_timeout_msecs")) {
-			rc = scnprintf(buf,
-				       PAGE_SIZE,
-				       "%d\n",
-				       orangefs_getattr_timeout_msecs);
+			rc = sysfs_emit(buf, "%d\n", orangefs_getattr_timeout_msecs);
 			goto out;
 		} else {
 			goto out;
@@ -256,16 +241,10 @@ static ssize_t sysfs_int_show(struct kobject *kobj,

 	} else if (!strcmp(kobj->name, STATS_KOBJ_ID)) {
 		if (!strcmp(attr->attr.name, "reads")) {
-			rc = scnprintf(buf,
-				       PAGE_SIZE,
-				       "%lu\n",
-				       orangefs_stats.reads);
+			rc = sysfs_emit(buf, "%lu\n", orangefs_stats.reads);
 			goto out;
 		} else if (!strcmp(attr->attr.name, "writes")) {
-			rc = scnprintf(buf,
-				       PAGE_SIZE,
-				       "%lu\n",
-				       orangefs_stats.writes);
+			rc = sysfs_emit(buf, "%lu\n", orangefs_stats.writes);
 			goto out;
 		} else {
 			goto out;
@@ -497,21 +476,17 @@ static ssize_t sysfs_service_op_show(struct kobject *kobj,
 		if (strcmp(kobj->name, PC_KOBJ_ID)) {
 			if (new_op->upcall.req.param.op ==
 			    ORANGEFS_PARAM_REQUEST_OP_READAHEAD_COUNT_SIZE) {
-				rc = scnprintf(buf, PAGE_SIZE, "%d %d\n",
+				rc = sysfs_emit(buf, "%d %d\n",
 				    (int)new_op->downcall.resp.param.u.
 				    value32[0],
 				    (int)new_op->downcall.resp.param.u.
 				    value32[1]);
 			} else {
-				rc = scnprintf(buf, PAGE_SIZE, "%d\n",
+				rc = sysfs_emit(buf, "%d\n",
 				    (int)new_op->downcall.resp.param.u.value64);
 			}
 		} else {
-			rc = scnprintf(
-				buf,
-				PAGE_SIZE,
-				"%s",
-				new_op->downcall.resp.perf_count.buffer);
+			rc = sysfs_emit(buf, "%s", new_op->downcall.resp.perf_count.buffer);
 		}
 	}

-- 
2.25.1
