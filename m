Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802C374FBE1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 01:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjGKXie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 19:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGKXic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 19:38:32 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F7810DD
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 16:38:31 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-53450fa3a18so8770820a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 16:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689118711; x=1691710711;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VlZMY7B4OQtHfVwCl2fGa87UX0dm/HNDQvgsMerbs4E=;
        b=6Ki0rULefzkrV0uqZTDhEme49t7KY8Ddvh964y9JGpH0d7zaaMcI88h9tK+e2Ab0fT
         veY/0elFR+0TnQbsPGLKw4Jmp/EnYeFI/PSjM63/7WezRDGYWEvCUsGnyE0hYonrxZCh
         hKVd2xrVwmNoXCz5hL6oiCirMv1oj6iXffQR50NxR8dIj89owViyD6Cq1q+dG0hECTvQ
         Gn9H85LU56bBM8WIwaFDgjeirp8M6EJB2ZueqDx7tDCWYbtZHHg6+WL/fE6cziK/CLIM
         9MHIOD6Pg4vMMojX+pEwY1B5ucjdNhQVR3rlKMYkiAAdKcNXGpYWjVQ1oLZ+HiqDtv/m
         dEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689118711; x=1691710711;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VlZMY7B4OQtHfVwCl2fGa87UX0dm/HNDQvgsMerbs4E=;
        b=an/ix9cX611YRU1k7rrTI9MndKTcSz4CDOrHhJY5pgJP0TeFuHFA8Uw4IoDRizM7hy
         0YTwc9zYoJzoCHZqY/CE2Cy5/rhTqVlXdJ6XuDRRDksePEols5Mb+O8dftcdHGv3/ZgL
         +KeQecIs/S/CHfOv5XeiT4SniEnq4t2WVO1/nnH+AHYpJ96DhhQejuzxuFYQC8Lh+0CG
         NNiMUw4srqNJzylMqXKxi/LhaBhtsq+bII3rmxHp4uKc31LQ8duPjm4IFiBK7fNhZCFr
         J+ZxhEsg4Zj5nZjT6eb9hIY8OJ5vaaXkpaXDLoFEb38///3xSsepeJ5qbE5wfuZ++L7f
         /HTA==
X-Gm-Message-State: ABy/qLZg4HMA9UszWqGCky78QtPCR07PGG5HLyMXPhwJq/fKfu+IIs3X
        RMJSo+L2izxJOnI28G4vRqPTbDne1rn8
X-Google-Smtp-Source: APBJJlEh1KFYgX73qa7oSh36gSCXi/QGqv/5l19pZiBs2u+PQkzFrZtGOa0EdwtmAe2WF+om3uaJkkHyZ7t9
X-Received: from dhavale-ctop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:5e39])
 (user=dhavale job=sendgmr) by 2002:a63:9511:0:b0:55c:2f9f:e427 with SMTP id
 p17-20020a639511000000b0055c2f9fe427mr4581555pgd.5.1689118711049; Tue, 11 Jul
 2023 16:38:31 -0700 (PDT)
Date:   Tue, 11 Jul 2023 16:38:15 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230711233816.2187577-1-dhavale@google.com>
Subject: [PATCH v1] rcu: Fix and improve RCU read lock checks when !CONFIG_DEBUG_LOCK_ALLOC
From:   Sandeep Dhavale <dhavale@google.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-erofs@lists.ozlabs.org, xiang@kernel.org,
        Sandeep Dhavale <dhavale@google.com>,
        Will Shiu <Will.Shiu@mediatek.com>, kernel-team@android.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently if CONFIG_DEBUG_LOCK_ALLOC is not set

- rcu_read_lock_held() always returns 1
- rcu_read_lock_any_held() may return 0 with CONFIG_PREEMPT_RCU

This is inconsistent and it was discovered when trying a fix
for problem reported [1] with CONFIG_DEBUG_LOCK_ALLOC is not
set and CONFIG_PREEMPT_RCU is enabled. Gist of the problem is
that EROFS wants to detect atomic context so it can do inline
decompression whenever possible, this is important performance
optimization. It turns out that z_erofs_decompressqueue_endio()
can be called from blk_mq_flush_plug_list() with rcu lock held
and hence fix uses rcu_read_lock_any_held() to decide to use
sync/inline decompression vs async decompression.

As per documentation, we should return lock is held if we aren't
certain. But it seems we can improve the checks for if the lock
is held even if CONFIG_DEBUG_LOCK_ALLOC is not set instead of
hardcoding to always return true.

* rcu_read_lock_held()
- For CONFIG_PREEMPT_RCU using rcu_preempt_depth()
- using preemptible() (indirectly preempt_count())

* rcu_read_lock_bh_held()
- For CONFIG_PREEMPT_RT Using in_softirq() (indirectly softirq_cont())
- using preemptible() (indirectly preempt_count())

Lastly to fix the inconsistency, rcu_read_lock_any_held() is updated
to use other rcu_read_lock_*_held() checks.

Two of the improved checks are moved to kernel/rcu/update.c because
rcupdate.h is included from the very low level headers which do not know
what current (task_struct) is so the macro rcu_preempt_depth() cannot be
expanded in the rcupdate.h. See the original comment for
rcu_preempt_depth() in patch at [2] for more information.

[1]
https://lore.kernel.org/all/20230621220848.3379029-1-dhavale@google.com/
[2]
https://lore.kernel.org/all/1281392111-25060-8-git-send-email-paulmck@linux.vnet.ibm.com/

Reported-by: Will Shiu <Will.Shiu@mediatek.com>
Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
 include/linux/rcupdate.h | 12 +++---------
 kernel/rcu/update.c      | 21 ++++++++++++++++++++-
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 5e5f920ade90..0d1d1d8c2360 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -319,14 +319,11 @@ int rcu_read_lock_any_held(void);
 # define rcu_lock_acquire(a)		do { } while (0)
 # define rcu_lock_release(a)		do { } while (0)
 
-static inline int rcu_read_lock_held(void)
-{
-	return 1;
-}
+int rcu_read_lock_held(void);
 
 static inline int rcu_read_lock_bh_held(void)
 {
-	return 1;
+	return !preemptible() || in_softirq();
 }
 
 static inline int rcu_read_lock_sched_held(void)
@@ -334,10 +331,7 @@ static inline int rcu_read_lock_sched_held(void)
 	return !preemptible();
 }
 
-static inline int rcu_read_lock_any_held(void)
-{
-	return !preemptible();
-}
+int rcu_read_lock_any_held(void);
 
 static inline int debug_lockdep_rcu_enabled(void)
 {
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 19bf6fa3ee6a..b34fc5bb96cf 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -390,8 +390,27 @@ int rcu_read_lock_any_held(void)
 }
 EXPORT_SYMBOL_GPL(rcu_read_lock_any_held);
 
-#endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
+#else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
+int rcu_read_lock_held(void)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RCU))
+		return rcu_preempt_depth();
+	return !preemptible();
+}
+EXPORT_SYMBOL_GPL(rcu_read_lock_held);
+
+int rcu_read_lock_any_held(void)
+{
+	if (rcu_read_lock_held() ||
+	    rcu_read_lock_bh_held() ||
+	    rcu_read_lock_sched_held())
+		return 1;
+	return !preemptible();
+}
+EXPORT_SYMBOL_GPL(rcu_read_lock_any_held);
+
+#endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 /**
  * wakeme_after_rcu() - Callback function to awaken a task after grace period
  * @head: Pointer to rcu_head member within rcu_synchronize structure
-- 
2.41.0.255.g8b1d071c50-goog

