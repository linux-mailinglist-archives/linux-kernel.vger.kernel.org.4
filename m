Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C937441BC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 20:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjF3SEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 14:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbjF3SEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 14:04:31 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F663AB4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 11:04:27 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-262dc1ced40so1424802a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 11:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688148267; x=1690740267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7aFyIy30qjEB+ijXq13VGdLjPjIsUhe6qj32BYiSrvE=;
        b=MujPLfeQdYgf2XJ21vjbd1JYQ/LUFU0WUC7EEm+kDSVTwU71W3yDmmnvA6RNuGILg8
         p+Pgv9k/uLAmp6GDflNbEVFCiprJpCvnHxSbndOFE5w3JZ0cDZVBp+bEDbXS1OINCgTr
         t6XTXP3XEDm3bFOKrH8cc58wxmCLBT8e0D+bQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688148267; x=1690740267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7aFyIy30qjEB+ijXq13VGdLjPjIsUhe6qj32BYiSrvE=;
        b=es4wnE/p9yCrmV7YcZVb4uOqx357qGfi9z1StX7774f7G2fwoQXiY2C0lTiTxtyfD5
         yuE7Jx0Lz5OM3SsEM/2su4ZGGKvMI/PuVEru8nob/6I5oI1pMpgObb4z3KQXGuwyAUIc
         99bayWmmHvUwg7WXwxwrTvT/2DVJsJebcBb+38KmcBFDbqb4y4Kry8srzmJoepENTcFI
         URZkLEXLCX4f045hqQ4F0O6QEuinEFR33Sessun574iAFq3ORqR9mKimvHAvXZzA9Gj2
         lotr01MoaBDcLS/G1g3ezPBI4IHDnLTbLL9di1Hk37tJFWGpc73h8n+BbKG0S5wP+4zu
         fJzA==
X-Gm-Message-State: ABy/qLb5RVNKgXvNbHjyT7zZwufUzqzpAxxUGFiz9IrzBBgLwHvsUy+P
        KRuTMVC/54fMtIf9u5TZZ1LgDQ==
X-Google-Smtp-Source: APBJJlFQq0rf/w2pNSRl9JKjOQZkx7SWwbcQSxvBuI9EM/KOAZOv27hAXWJKp62xDxvZPG+cYiQNyw==
X-Received: by 2002:a17:90a:6605:b0:262:e0aa:bbc8 with SMTP id l5-20020a17090a660500b00262e0aabbc8mr3063802pjj.8.1688148267060;
        Fri, 30 Jun 2023 11:04:27 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q5-20020a631f45000000b0051b7d83ff22sm10807050pgm.80.2023.06.30.11.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 11:04:26 -0700 (PDT)
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
Subject: [PATCH v2] pid: Replace struct pid 1-element array with flex-array
Date:   Fri, 30 Jun 2023 11:04:22 -0700
Message-Id: <20230630180418.gonna.286-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3300; i=keescook@chromium.org;
 h=from:subject:message-id; bh=MagSs+PRfh/Kgz8NQm3FmzmJ1z+sWa88uteLAKWLid4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBknxklc/3X2AVavA3o7LUqjJp9Zl9UWIfvAUGOp
 vZQk32H6pGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZJ8ZJQAKCRCJcvTf3G3A
 JtW1EACwkxvYH1JUSSTQ4A5vFqIK0eBAt9R3jddnmb58Md7SeX06isfl5qXfjjARFOGDoiCKowU
 O1aF0w7bu9vvDOzk2PIRVbuTFwuVpEb/n09QaySp6ZO0Ig1BcFXoDObSVflvCzMFtwH1dI8YxRj
 S2aDqdHavcGLwXNMVLK9rBFm5Z1FMKB4hkbl6M/4j5eTXmJEGElZu3i81M9P/MGxVA0b4d2mzda
 zYVMFMa0Vyg3saNNaWteXc1xUlb42dnW2hiw4igJVwQu/hXWHBrzl4wlvV/hGvmUuwXB1o2bD1D
 oYzw41MPbahBXZ6QPlnFYHUqHtcf4t2DX8dMt1snXmItFM36VZUiq7T5xyJDE2qaCWsrZO0a7yV
 K0d7lBW2n8PGZzeEru6YsF5MupfiIUu78v9xzrvY4DgTHqo0ysxL+3fA4hqrUm6te3OsDB3b2g5
 iGhmAHvaVHmZuoCRDNdydEvTnsg/qaZR8e4FE77ePan4pTgOoYCtQpyk2yXfyjxWP/hKlfkQYBN
 4Hg7T+cjI/dRa+mWki5vlcZg4hTjFFTdz0/EqXrWjCxlWhgECLRCAtbf76C49d6MjGYJiUe55zh
 zCCN2wNuxmJJMxN1NldWHdFTFNDDu/H/Rbwg7PS2cEUvB4iA/48EqnEaTwOBqossj3yn3d5ns9N
 l/PTrmM ooAdmK4Q==
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
will trigger bounds checks when entering a pid namespace:
https://lore.kernel.org/lkml/20230517-bushaltestelle-super-e223978c1ba6@brauner

For example: unshare --fork --pid --mount-proc readlink /proc/self

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
Closes: https://lore.kernel.org/lkml/000000000000c6de2a05fbdecbbb@google.com/
Acked-by: Jeff Xu <jeffxu@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2:
 - drop pointer math to array index conversions (torvalds)
 - use struct_size_t now that it exists (torvalds)
 - updated commit log with reproducer example
v1: https://lore.kernel.org/lkml/20230517225838.never.965-kees@kernel.org/
---
 include/linux/pid.h    | 2 +-
 kernel/pid.c           | 7 +++++--
 kernel/pid_namespace.c | 2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)

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
index f93954a0384d..6a1d23a11026 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -656,8 +656,11 @@ void __init pid_idr_init(void)
 
 	idr_init(&init_pid_ns.idr);
 
-	init_pid_ns.pid_cachep = KMEM_CACHE(pid,
-			SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
+	init_pid_ns.pid_cachep = kmem_cache_create("pid",
+			struct_size_t(struct pid, numbers, 1),
+			__alignof__(struct pid),
+			SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT,
+			NULL);
 }
 
 static struct file *__pidfd_fget(struct task_struct *task, int fd)
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index b43eee07b00c..0bf44afe04dd 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -48,7 +48,7 @@ static struct kmem_cache *create_pid_cachep(unsigned int level)
 		return kc;
 
 	snprintf(name, sizeof(name), "pid_%u", level + 1);
-	len = sizeof(struct pid) + level * sizeof(struct upid);
+	len = struct_size_t(struct pid, numbers, level + 1);
 	mutex_lock(&pid_caches_mutex);
 	/* Name collision forces to do allocation under mutex. */
 	if (!*pkc)
-- 
2.34.1

