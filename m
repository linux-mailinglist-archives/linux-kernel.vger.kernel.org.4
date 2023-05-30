Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94F8716CF9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 21:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbjE3TAR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 30 May 2023 15:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbjE3TAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 15:00:11 -0400
Received: from mail-b.sr.ht (mail-b.sr.ht [173.195.146.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FB2107
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 12:00:02 -0700 (PDT)
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
        by mail-b.sr.ht (Postfix) with ESMTPSA id 8CE6311F060;
        Tue, 30 May 2023 18:50:50 +0000 (UTC)
From:   ~akihirosuda <akihirosuda@git.sr.ht>
Date:   Wed, 31 May 2023 02:31:11 +0900
Subject: [PATCH linux 2/3] group_range: allow GID from 2147483648 to 4294967294
Message-ID: <168547265011.24337.4306067683997517082-2@git.sr.ht>
X-Mailer: git.sr.ht
Reply-to: ~akihirosuda <suda.kyoto@gmail.com>
In-Reply-To: <168547265011.24337.4306067683997517082-0@git.sr.ht>
To:     linux-kernel@vger.kernel.org, containers@lists.linux.dev,
        serge@hallyn.com, brauner@kernel.org, paul@paul-moore.com,
        ebiederm@xmission.com
Cc:     suda.kyoto@gmail.com, akihiro.suda.cz@hco.ntt.co.jp
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_REPLYTO,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>

proc_dointvec_minmax is no longer used because it does not support GID
from 2147483648 to 4294967294.

proc_douintvec is not used either, because it does not support vectors,
despite its function name.

Signed-off-by: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
---
 include/linux/group_range.h |  6 -----
 kernel/group_range.c        | 52 ++++++++++++++++++++++++++++++-------
 2 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/include/linux/group_range.h b/include/linux/group_range.h
index 5bd837eced95..8f71dc956693 100644
--- a/include/linux/group_range.h
+++ b/include/linux/group_range.h
@@ -5,12 +5,6 @@
 #include <linux/seqlock.h>
 #include <linux/uidgid.h>
 
-/*
- * gid_t is either uint or ushort.  We want to pass it to
- * proc_dointvec_minmax(), so it must not be larger than MAX_INT
- */
-#define GROUP_RANGE_MAX (((gid_t)~0U) >> 1)
-
 struct group_range {
 	seqlock_t       lock;
 	kgid_t          range[2];
diff --git a/kernel/group_range.c b/kernel/group_range.c
index b5c7d35d680b..13db83b77832 100644
--- a/kernel/group_range.c
+++ b/kernel/group_range.c
@@ -4,6 +4,7 @@
 #include <linux/group_range.h>
 #include <linux/uidgid.h>
 #include <linux/seqlock.h>
+#include <linux/slab.h>
 #include <linux/sysctl.h>
 
 static void get_group_range(struct group_range *gr, kgid_t *low, kgid_t *high)
@@ -26,9 +27,6 @@ static void set_group_range(struct group_range *gr, kgid_t low, kgid_t high)
 	write_sequnlock(&gr->lock);
 }
 
-static int group_range_min[] = { 0, 0 };
-static int group_range_max[] = { GROUP_RANGE_MAX, GROUP_RANGE_MAX };
-
 int sysctl_group_range(sysctl_group_range_func_t fn, struct ctl_table *table,
 				 int write, void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -37,24 +35,56 @@ int sysctl_group_range(sysctl_group_range_func_t fn, struct ctl_table *table,
 	int ret;
 	gid_t urange[2];
 	kgid_t low, high;
+	size_t slen = 256; /* total bytes including '\0' */
+	char *s = kmalloc(slen, GFP_KERNEL); /* clobbered by strsep */
 	struct ctl_table tmp = {
-		.data = &urange,
-		.maxlen = sizeof(urange),
+		.data = s,
+		.maxlen = slen,
 		.mode = table->mode,
-		.extra1 = &group_range_min,
-		.extra2 = &group_range_max,
 	};
 
+	if (unlikely(!s))
+		return -ENOMEM;
+
+	/*
+	 * proc_dointvec_minmax is no longer used because it does not support
+	 * GID from 2147483648 to 4294967294.
+	 *
+	 * proc_douintvec is not used either, because it does not support
+	 * vectors, despite its function name.
+	 */
 	get_group_range(gr, &low, &high);
 	urange[0] = from_kgid_munged(user_ns, low);
 	urange[1] = from_kgid_munged(user_ns, high);
-	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
+	ret = snprintf(tmp.data, slen, "%u\t%u", urange[0], urange[1]);
+	if (ret < 0)
+		goto done;
+	ret = proc_dostring(&tmp, write, buffer, lenp, ppos);
+	if (*lenp >= slen - 1) /* truncated */
+		ret = -EINVAL;
 
 	if (write && ret == 0) {
+		char *tok[2];
+		int i;
+
+		s = strim(s);
+		tok[0] = strsep(&s, " \t");
+		tok[1] = s;
+		for (i = 0; i < 2; i++) {
+			if (!tok[i]) {
+				ret = -EINVAL;
+				goto done;
+			}
+			ret = kstrtouint(tok[i], 0, &urange[i]);
+			if (ret < 0)
+				goto done;
+		}
 		low = make_kgid(user_ns, urange[0]);
 		high = make_kgid(user_ns, urange[1]);
-		if (!gid_valid(low) || !gid_valid(high))
-			return -EINVAL;
+		if (!gid_valid(low) || !gid_valid(high)) {
+			ret = -EINVAL;
+			goto done;
+		}
 		if (urange[1] < urange[0] || gid_lt(high, low)) {
 			low = make_kgid(&init_user_ns, 1);
 			high = make_kgid(&init_user_ns, 0);
@@ -62,6 +92,8 @@ int sysctl_group_range(sysctl_group_range_func_t fn, struct ctl_table *table,
 		set_group_range(gr, low, high);
 	}
 
+done:
+	kfree(tmp.data);
 	return ret;
 }
 
-- 
2.38.4

