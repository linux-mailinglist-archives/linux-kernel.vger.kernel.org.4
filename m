Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE4B5BB4A5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 01:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiIPXJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 19:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiIPXJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 19:09:02 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975A8BC82D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 16:09:01 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id h188so21638367pgc.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 16:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=xlhox9+SEzNhQzMlhegEPCRl8J0fqWhrXgeJnYiFe+8=;
        b=o/b2A6naP5/o4QFAkkM/ZRNU5cIyWLe+avbZKbUNb9LTqPzlyHvsge4dYWjV41/ywF
         7lNFoiGSfaxZY8D9Wqaecs4ESxRgGZhZ06+7MUEJuPntXRIDJ50hFOQJR4phajKInWTG
         NVT3paJPw+WzBVt5u5C1Gy2101r9r0iRaCDeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=xlhox9+SEzNhQzMlhegEPCRl8J0fqWhrXgeJnYiFe+8=;
        b=6zCYuQA7VS1O3maX7BPwq+Kx1QOxbQ0FskafxAmzeYVIMWRp4duYXAsip5p8JJJ/TX
         8R8ezxBQZ5JSg/+xTJuCDyBuyFwKBNbjcOQd49PgTYwRdLz0Elu3wKb9LweAKM/L3PCb
         0k/DyyuA8vCL30ruOUvH6aaNz0GCAoypl185AYv5ctqZi7K6KuySUZOsE7XRgIluHJz6
         MvOa2uNPY5nD0jAbG4q4IwdeTsELSKa85TYTPWZYsQDxFSBI/8SBNZGFpyHA7DRAKPj1
         Sqo6bYAqN0bn5XOGa/nnXQJN/kXVDTTaiQiLmzkbqZEJfk6U3k6cFWDs858haolmCb+d
         U9OA==
X-Gm-Message-State: ACrzQf1zbftEEMqB/EM2xDiq6uuUuIdowz5vvFk4y8nCgWPBCmaIg5Nc
        wO8vaEtBSledHc00y2AaEEOsSA==
X-Google-Smtp-Source: AMsMyM4RWRF7kSSnGREOR9De6Oqnyt4Gatv/oS6BUgl9INhAP2wuoctscRTAfQtH+LCrfVWxVNP6cg==
X-Received: by 2002:a63:8048:0:b0:438:8349:7c6c with SMTP id j69-20020a638048000000b0043883497c6cmr6415340pgd.172.1663369741001;
        Fri, 16 Sep 2022 16:09:01 -0700 (PDT)
Received: from localhost ([2601:644:200:2b2:d0a7:3a0b:548e:9cf4])
        by smtp.gmail.com with ESMTPSA id q5-20020a63e205000000b00434760ee36asm13789463pgh.16.2022.09.16.16.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 16:09:00 -0700 (PDT)
From:   Ivan Babrou <ivan@cloudflare.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Ivan Babrou <ivan@cloudflare.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: [RFC] proc: report open files as size in stat() for /proc/pid/fd
Date:   Fri, 16 Sep 2022 16:08:52 -0700
Message-Id: <20220916230853.49056-1-ivan@cloudflare.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many monitoring tools include open file count as a metric. Currently
the only way to get this number is to enumerate the files in /proc/pid/fd.

The problem with the current approach is that it does many things people
generally don't care about when they need one number for a metric.
In our tests for cadvisor, which reports open file counts per cgroup,
we observed that reading the number of open files is slow. Out of 35.23%
of CPU time spent in `proc_readfd_common`, we see 29.43% spent in
`proc_fill_cache`, which is responsible for filling dentry info.
Some of this extra time is spinlock contention, but it's a contention
for the lock we don't want to take to begin with.

We considered putting the number of open files in /proc/pid/stat.
Unfortunately, counting the number of fds involves iterating the fdtable,
which means that it might slow down /proc/pid/stat for processes
with many open files. Instead we opted to put this info in /proc/pid/fd
as a size member of the stat syscall result. Previously the reported
number was zero, so there's very little risk of breaking anything,
while still providing a somewhat logical way to count the open files.

Previously:

```
$ sudo stat /proc/1/fd | head -n2
  File: /proc/1/fd
  Size: 0         	Blocks: 0          IO Block: 1024   directory
```

With this patch:

```
$ sudo stat /proc/1/fd | head -n2
  File: /proc/1/fd
  Size: 65        	Blocks: 0          IO Block: 1024   directory
```

Correctness check:

```
$ sudo ls /proc/1/fd | wc -l
65
```

There are two alternatives to this approach that I can see:

* Expose /proc/pid/fd_count with a count there
* Make fd count acces O(1) and expose it in /proc/pid/status

I can probably figure out how to do the former, but the latter
will require somebody with more experience in file code than myself.

Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
---
 fs/proc/fd.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 913bef0d2a36..c7ac142500a8 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -279,6 +279,29 @@ static int proc_readfd_common(struct file *file, struct dir_context *ctx,
 	return 0;
 }
 
+static int proc_readfd_count(struct inode *inode)
+{
+	struct task_struct *p = get_proc_task(inode);
+	unsigned int fd = 0, count = 0;
+
+	if (!p)
+		return -ENOENT;
+
+	rcu_read_lock();
+	while (task_lookup_next_fd_rcu(p, &fd)) {
+		rcu_read_unlock();
+
+		count++;
+		fd++;
+
+		cond_resched();
+		rcu_read_lock();
+	}
+	rcu_read_unlock();
+	put_task_struct(p);
+	return count;
+}
+
 static int proc_readfd(struct file *file, struct dir_context *ctx)
 {
 	return proc_readfd_common(file, ctx, proc_fd_instantiate);
@@ -319,9 +342,33 @@ int proc_fd_permission(struct user_namespace *mnt_userns,
 	return rv;
 }
 
+int proc_fd_getattr(struct user_namespace *mnt_userns,
+			const struct path *path, struct kstat *stat,
+			u32 request_mask, unsigned int query_flags)
+{
+	struct inode *inode = d_inode(path->dentry);
+	struct proc_dir_entry *de = PDE(inode);
+
+	if (de) {
+		nlink_t nlink = READ_ONCE(de->nlink);
+
+		if (nlink > 0)
+			set_nlink(inode, nlink);
+	}
+
+	generic_fillattr(&init_user_ns, inode, stat);
+
+	/* If it's a directory, put the number of open fds there */
+	if (S_ISDIR(inode->i_mode))
+		stat->size = proc_readfd_count(inode);
+
+	return 0;
+}
+
 const struct inode_operations proc_fd_inode_operations = {
 	.lookup		= proc_lookupfd,
 	.permission	= proc_fd_permission,
+	.getattr	= proc_fd_getattr,
 	.setattr	= proc_setattr,
 };
 
-- 
2.37.2

