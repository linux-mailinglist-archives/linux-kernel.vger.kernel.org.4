Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3241A64513B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 02:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiLGB3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 20:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiLGB3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 20:29:39 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852D351C27;
        Tue,  6 Dec 2022 17:29:38 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NRfpT0kVzz4y0tv;
        Wed,  7 Dec 2022 09:29:37 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.40.52])
        by mse-fl2.zte.com.cn with SMTP id 2B71TQFJ098106;
        Wed, 7 Dec 2022 09:29:27 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 7 Dec 2022 09:29:27 +0800 (CST)
Date:   Wed, 7 Dec 2022 09:29:27 +0800 (CST)
X-Zmail-TransId: 2af9638fec77427b43dc
X-Mailer: Zmail v1.0
Message-ID: <202212070929276734686@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <linkinjeon@kernel.org>
Cc:     <sfrench@samba.org>, <senozhatsky@chromium.org>, <tom@talpey.com>,
        <linux-cifs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBrc21iZDogQ29udmVydCB0byB1c2Ugc3lzZnNfZW1pdCgpL3N5c2ZzX2VtaXRfYXQoKSBBUElz?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B71TQFJ098106
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 638FEC81.000 by FangMail milter!
X-FangMail-Envelope: 1670376577/4NRfpT0kVzz4y0tv/638FEC81.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 638FEC81.000/4NRfpT0kVzz4y0tv
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
 fs/ksmbd/server.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/fs/ksmbd/server.c b/fs/ksmbd/server.c
index a0d635304754..394b6ceac431 100644
--- a/fs/ksmbd/server.c
+++ b/fs/ksmbd/server.c
@@ -432,11 +432,9 @@ static ssize_t stats_show(struct class *class, struct class_attribute *attr,
 		"reset",
 		"shutdown"
 	};
-
-	ssize_t sz = scnprintf(buf, PAGE_SIZE, "%d %s %d %lu\n", stats_version,
-			       state[server_conf.state], server_conf.tcp_port,
-			       server_conf.ipc_last_active / HZ);
-	return sz;
+	return sysfs_emit(buf, "%d %s %d %lu\n", stats_version,
+			  state[server_conf.state], server_conf.tcp_port,
+			  server_conf.ipc_last_active / HZ);
 }

 static ssize_t kill_server_store(struct class *class,
@@ -468,19 +466,13 @@ static ssize_t debug_show(struct class *class, struct class_attribute *attr,

 	for (i = 0; i < ARRAY_SIZE(debug_type_strings); i++) {
 		if ((ksmbd_debug_types >> i) & 1) {
-			pos = scnprintf(buf + sz,
-					PAGE_SIZE - sz,
-					"[%s] ",
-					debug_type_strings[i]);
+			pos = sysfs_emit_at(buf, sz, "[%s] ", debug_type_strings[i]);
 		} else {
-			pos = scnprintf(buf + sz,
-					PAGE_SIZE - sz,
-					"%s ",
-					debug_type_strings[i]);
+			pos = sysfs_emit_at(buf, sz, "%s ", debug_type_strings[i]);
 		}
 		sz += pos;
 	}
-	sz += scnprintf(buf + sz, PAGE_SIZE - sz, "\n");
+	sz += sysfs_emit_at(buf, sz, "\n");
 	return sz;
 }

-- 
2.25.1
