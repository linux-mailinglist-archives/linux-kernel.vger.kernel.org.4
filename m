Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A275373CE47
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 05:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjFYDfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 23:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjFYDfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 23:35:05 -0400
Received: from mx6.didiglobal.com (mx6.didiglobal.com [111.202.70.123])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 7120DB5
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 20:35:03 -0700 (PDT)
Received: from mail.didiglobal.com (unknown [10.79.65.12])
        by mx6.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id 0F18A11002112F;
        Sun, 25 Jun 2023 11:35:01 +0800 (CST)
Received: from didi-ThinkCentre-M930t-N000 (10.79.64.101) by
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 25 Jun 2023 11:35:00 +0800
Date:   Sun, 25 Jun 2023 11:34:52 +0800
X-MD-Sfrom: tiozhang@didiglobal.com
X-MD-SrcIP: 10.79.65.12
From:   tiozhang <tiozhang@didiglobal.com>
To:     <joe@perches.com>
CC:     <akpm@linux-foundation.org>, <gregkh@linuxfoundation.org>,
        <keescook@chromium.org>, <mcgrof@kernel.org>,
        <senozhatsky@chromium.org>, <pc@cjr.nz>,
        <linux-kernel@vger.kernel.org>, <zyhtheonly@gmail.com>,
        <zyhtheonly@yeah.net>, <zwp10758@gmail.com>,
        <tiozhang@didiglobal.com>
Subject: [PATCH] cred: convert printks to pr_<level>
Message-ID: <20230625033452.GA22858@didi-ThinkCentre-M930t-N000>
Mail-Followup-To: joe@perches.com, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, keescook@chromium.org,
        mcgrof@kernel.org, senozhatsky@chromium.org, pc@cjr.nz,
        linux-kernel@vger.kernel.org, zyhtheonly@gmail.com,
        zyhtheonly@yeah.net, zwp10758@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.79.64.101]
X-ClientProxiedBy: ZJY01-PUBMBX-01.didichuxing.com (10.79.64.32) To
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use current logging style.

Signed-off-by: tiozhang <tiozhang@didiglobal.com>
---
 kernel/cred.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/kernel/cred.c b/kernel/cred.c
index e10c15f51c1f..918409af008b 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -4,6 +4,9 @@
  * Copyright (C) 2008 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  */
+
+#define pr_fmt(fmt) "CRED: " fmt
+
 #include <linux/export.h>
 #include <linux/cred.h>
 #include <linux/slab.h>
@@ -836,32 +839,32 @@ EXPORT_SYMBOL(creds_are_invalid);
 static void dump_invalid_creds(const struct cred *cred, const char *label,
 			       const struct task_struct *tsk)
 {
-	printk(KERN_ERR "CRED: %s credentials: %p %s%s%s\n",
+	pr_err("%s credentials: %p %s%s%s\n",
 	       label, cred,
 	       cred == &init_cred ? "[init]" : "",
 	       cred == tsk->real_cred ? "[real]" : "",
 	       cred == tsk->cred ? "[eff]" : "");
-	printk(KERN_ERR "CRED: ->magic=%x, put_addr=%p\n",
+	pr_err("->magic=%x, put_addr=%p\n",
 	       cred->magic, cred->put_addr);
-	printk(KERN_ERR "CRED: ->usage=%d, subscr=%d\n",
+	pr_err("->usage=%d, subscr=%d\n",
 	       atomic_read(&cred->usage),
 	       read_cred_subscribers(cred));
-	printk(KERN_ERR "CRED: ->*uid = { %d,%d,%d,%d }\n",
+	pr_err("->*uid = { %d,%d,%d,%d }\n",
 		from_kuid_munged(&init_user_ns, cred->uid),
 		from_kuid_munged(&init_user_ns, cred->euid),
 		from_kuid_munged(&init_user_ns, cred->suid),
 		from_kuid_munged(&init_user_ns, cred->fsuid));
-	printk(KERN_ERR "CRED: ->*gid = { %d,%d,%d,%d }\n",
+	pr_err("->*gid = { %d,%d,%d,%d }\n",
 		from_kgid_munged(&init_user_ns, cred->gid),
 		from_kgid_munged(&init_user_ns, cred->egid),
 		from_kgid_munged(&init_user_ns, cred->sgid),
 		from_kgid_munged(&init_user_ns, cred->fsgid));
 #ifdef CONFIG_SECURITY
-	printk(KERN_ERR "CRED: ->security is %p\n", cred->security);
+	pr_err("->security is %p\n", cred->security);
 	if ((unsigned long) cred->security >= PAGE_SIZE &&
 	    (((unsigned long) cred->security & 0xffffff00) !=
 	     (POISON_FREE << 24 | POISON_FREE << 16 | POISON_FREE << 8)))
-		printk(KERN_ERR "CRED: ->security {%x, %x}\n",
+		pr_err("->security {%x, %x}\n",
 		       ((u32*)cred->security)[0],
 		       ((u32*)cred->security)[1]);
 #endif
@@ -872,8 +875,8 @@ static void dump_invalid_creds(const struct cred *cred, const char *label,
  */
 void __noreturn __invalid_creds(const struct cred *cred, const char *file, unsigned line)
 {
-	printk(KERN_ERR "CRED: Invalid credentials\n");
-	printk(KERN_ERR "CRED: At %s:%u\n", file, line);
+	pr_err("Invalid credentials\n");
+	pr_err("At %s:%u\n", file, line);
 	dump_invalid_creds(cred, "Specified", current);
 	BUG();
 }
@@ -899,14 +902,14 @@ void __validate_process_creds(struct task_struct *tsk,
 	return;
 
 invalid_creds:
-	printk(KERN_ERR "CRED: Invalid process credentials\n");
-	printk(KERN_ERR "CRED: At %s:%u\n", file, line);
+	pr_err("Invalid process credentials\n");
+	pr_err("At %s:%u\n", file, line);
 
 	dump_invalid_creds(tsk->real_cred, "Real", tsk);
 	if (tsk->cred != tsk->real_cred)
 		dump_invalid_creds(tsk->cred, "Effective", tsk);
 	else
-		printk(KERN_ERR "CRED: Effective creds == Real creds\n");
+		pr_err("Effective creds == Real creds\n");
 	BUG();
 }
 EXPORT_SYMBOL(__validate_process_creds);
-- 
2.17.1

