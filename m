Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0CE7075AE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 00:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjEQW6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 18:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjEQW6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 18:58:47 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8260D5588
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 15:58:46 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-643a1fed360so978172b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 15:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684364326; x=1686956326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e2HrkykK6KYI+/dHSMkJ9CPc8h3CMNt34GiUjDW8pDA=;
        b=Ay+LZ4vkQsZApcOeFB3Xz9LWqhCfsbJS3txcngKa4t1aNZ3LLsZrE1cI0yUzD1D7os
         J7z+efPVG4WvUV01SUNSkLYruefAukJTPv4if5E0qgLyz0x4KE7re6AcYPrRMiZ5Ip0o
         8FOdrDrJ9DNy8IrgiOosPfq+i6T3GlEew7zsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684364326; x=1686956326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e2HrkykK6KYI+/dHSMkJ9CPc8h3CMNt34GiUjDW8pDA=;
        b=bnOgfnPHoVTLF2IjG+DYxy03zdHtvlkMbOanQGhFvo+qRQfpb7WgtvkXQoKwDveHlI
         JsqzfICMJDzHU13MAKxE81I/58kRluWh3xlkgqNqd4wWwZo39OpxEmCnP8ZzcMVAASZ8
         HaQ61yUUiw2FFYf+SQodcPtc8Nu0vP71ff/KOPlPySf0XeYvYf2t0MpCzJZw3eaMomv2
         Tmvh/4NY8mfSY7FaKnnLWvS9caBHMluO+MZEH9J3tv7Rdo8RkxXI7EXH0jf5LEkd1zXd
         kHz/WjQYzV3Bc2OHP5m9E59Nwc1bEi9wtaQ+Q+8goT2oT+OaP2xGbJOOXYJOmgi1F96Y
         xDuw==
X-Gm-Message-State: AC+VfDzRysEsbN3xACStbWA4Ml0ax2vJRSynCkNAciVHrp5d510qaIr7
        7vEQsqfjVvfONS2uctuRtm45hA==
X-Google-Smtp-Source: ACHHUZ6Dcv3fAcZzqJxQ12RNOc3hOpIXMDhPd8lJUsgOK2YNOxma3nv1fpa2jFqh6n8DLQutqALkzg==
X-Received: by 2002:a05:6a00:2291:b0:64b:43d8:a575 with SMTP id f17-20020a056a00229100b0064b43d8a575mr1739516pfe.25.1684364325950;
        Wed, 17 May 2023 15:58:45 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fe16-20020a056a002f1000b0063d6666ee4csm60165pfb.34.2023.05.17.15.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 15:58:45 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Jan Kara <jack@suse.cz>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jeff Xu <jeffxu@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        syzbot+ac3b41786a2d0565b6d5@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] pid: Replace struct pid 1-element array with flex-array
Date:   Wed, 17 May 2023 15:58:42 -0700
Message-Id: <20230517225838.never.965-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3762; h=from:subject:message-id; bh=3VIzDUhfVBdAPvNGcA/e9saxBOkZkK+WtkJ5LzKNWZA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkZVwi+zjxK1xfiObiQXf1FPTnZFGfAWWd4T4RQyUa PXEWeOCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZGVcIgAKCRCJcvTf3G3AJqyrEA CvteYy+49n7gSRsFTro4fVccGpHcRN/iGrbnn5vBk3RZ/nZr6tvvNCKV+vCDUj6XH1qkIKIGg4lKe3 0qbgGGC//Dr0Fj/iFSV/0WCgbeiuXH1bPtal/Ee2K9o9Gh+hggH459j/CijEDV/NxTemY5OAQSLPgA ibc+hJHMvn8zXGON5/E2l7TVmaycTExeRIRRPx/pM75xtiqez9so+Pa0AjBSrN5zkg32V5gzbbnrh1 sUsHy3SxFoVr0RplRzsoM71gkR4A2YXVpGVRv1m9tawuaGXMvtbV9T6arD989Xgormk13pxnFVztAp 91qpk2GYZ1hgGRQlBwBWDfNMdPRpptPoA1jSE4b1gwnvmCTPPUg703GFxDmspm1p96gf5qrp3bK3iz EQc94i0KrRDWZGL1FC1SpWn3F8mR6LLABhyNUetq0PjPX/NwtcJdeoQZ/4eCOQxLurC+k6Mc7SzK/K 4aKKSc0BRfUcnA/OeuIm34ZTCYaQfhMVZKc2ZzPSG7rWv647eoIqbqqYgO+FcT0gjQsTp8Gvo/hCEf iWQGZJRy7T28twW+zV1LyofKTUqPSB1o3NjyVn+y6kdGzQp67mFq59DrU/r77sGakJN+0oODtL1vc7 DnZcQtnRKAcS0FNpM/zMeldeAtrc5vPGrhMLIz8b4p6M0gPegStdTNGU80Og==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For pid namespaces, struct pid uses a dynamically sized array member,
"numbers". This was implemented using the ancient 1-element fake flexible
array, which has been deprecated for decades. Replace it with a C99
flexible array, refactor the array size calculations to use struct_size(),
and address elements via indexes. Note that the static initializer (which
defines a single element) works as-is, and requires no special handling.

Without this, CONFIG_UBSAN_BOUNDS (and potentially CONFIG_FORTIFY_SOURCE)
will trigger bounds checks:
https://lore.kernel.org/lkml/20230517-bushaltestelle-super-e223978c1ba6@brauner

Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Daniel Verkamp <dverkamp@chromium.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Jeff Xu <jeffxu@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Reported-by: syzbot+ac3b41786a2d0565b6d5@syzkaller.appspotmail.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/pid.h    |  2 +-
 kernel/pid.c           | 13 ++++++++-----
 kernel/pid_namespace.c |  2 +-
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index b75de288a8c2..653a527574c4 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -67,7 +67,7 @@ struct pid
 	/* wait queue for pidfd notifications */
 	wait_queue_head_t wait_pidfd;
 	struct rcu_head rcu;
-	struct upid numbers[1];
+	struct upid numbers[];
 };
 
 extern struct pid init_struct_pid;
diff --git a/kernel/pid.c b/kernel/pid.c
index f93954a0384d..f5008146e2e4 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -131,7 +131,7 @@ void free_pid(struct pid *pid)
 
 	spin_lock_irqsave(&pidmap_lock, flags);
 	for (i = 0; i <= pid->level; i++) {
-		struct upid *upid = pid->numbers + i;
+		struct upid *upid = &pid->numbers[i];
 		struct pid_namespace *ns = upid->ns;
 		switch (--ns->pid_allocated) {
 		case 2:
@@ -265,7 +265,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 	init_waitqueue_head(&pid->wait_pidfd);
 	INIT_HLIST_HEAD(&pid->inodes);
 
-	upid = pid->numbers + ns->level;
+	upid = &pid->numbers[ns->level];
 	spin_lock_irq(&pidmap_lock);
 	if (!(ns->pid_allocated & PIDNS_ADDING))
 		goto out_unlock;
@@ -285,7 +285,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 out_free:
 	spin_lock_irq(&pidmap_lock);
 	while (++i <= ns->level) {
-		upid = pid->numbers + i;
+		upid = &pid->numbers[i];
 		idr_remove(&upid->ns->idr, upid->nr);
 	}
 
@@ -656,8 +656,11 @@ void __init pid_idr_init(void)
 
 	idr_init(&init_pid_ns.idr);
 
-	init_pid_ns.pid_cachep = KMEM_CACHE(pid,
-			SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
+	init_pid_ns.pid_cachep = kmem_cache_create("pid",
+			struct_size((struct pid *)0, numbers, 1),
+			__alignof__(struct pid),
+			SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT,
+			NULL);
 }
 
 static struct file *__pidfd_fget(struct task_struct *task, int fd)
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index b43eee07b00c..ebb20091a9da 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -48,7 +48,7 @@ static struct kmem_cache *create_pid_cachep(unsigned int level)
 		return kc;
 
 	snprintf(name, sizeof(name), "pid_%u", level + 1);
-	len = sizeof(struct pid) + level * sizeof(struct upid);
+	len = struct_size((struct pid *)0, numbers, level + 1);
 	mutex_lock(&pid_caches_mutex);
 	/* Name collision forces to do allocation under mutex. */
 	if (!*pkc)
-- 
2.34.1

