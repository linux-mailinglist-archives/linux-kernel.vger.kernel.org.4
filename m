Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229345F3B82
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 04:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiJDCmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 22:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiJDCmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 22:42:22 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BF9222B3
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 19:42:21 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 3so7700528qka.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 19:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=nwYFv1Y9ioR8AS0tEJbiXFzs03GcNWhWnMGa3lC4ElA=;
        b=rQm3RuKAtJ2svua5qye7vza3ywe9xPFi3+1dpPdAJTFeVW/bYL6zRsRdYOD6yx2lBh
         YzInXrNj5f1HmUXF4uoNK6Bilft/RDtbZram7bQjZsJYNvhyxz13RaEgHjc2HeVeCwLY
         tIKT9JTP52DnxA3kYIwXR66U/9lBcGTs2PkXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nwYFv1Y9ioR8AS0tEJbiXFzs03GcNWhWnMGa3lC4ElA=;
        b=rn7VpKC/x6GihF7hP9ZSi/7T5ZRGr9x8u2wSoT1tmIVNpQZ/DIafyLfdszAPLJ0x4x
         fT7UecQ0qJBiHOinTMXq7tLveLHjti+tc/z0sZ3IFpUGaubT+vTvz/eRcBA3+ZBw+gQ7
         ieGZqzoX1v6d0tsvCjEPYn9lOyCMjqLlePR7nC1vsE2CZwbFYTqvZCxJU/n4M1XG/lky
         KCdolMqtc5BHjWccwoKY68yT1oHkiYMaNzPo6F3EssSOOIlYdBnsZaGqnL1HzEjgkzHw
         wXUujW7oAPXMJPi32mAKV61ESAl/nXPSUkz6qcBhP7cAjuE3C9w1edAzfd+YHqhYZKFw
         RqRg==
X-Gm-Message-State: ACrzQf2iwTmYQZlPmn39NhIlRvLZ6VhKN0S2AS48fe06xrarWfpWq6eM
        BIj9jyyLJrAFjmdBnvUNswJJrw==
X-Google-Smtp-Source: AMsMyM4tZoBtQTmf9czcLJ1vXZO+peORIjORIZZZv1MvVlSJ+3y4QrJWH3fORLFg2NoRYLUyaRqS1Q==
X-Received: by 2002:a05:620a:40c9:b0:6ce:ce4c:d0b3 with SMTP id g9-20020a05620a40c900b006cece4cd0b3mr15701499qko.653.1664851340280;
        Mon, 03 Oct 2022 19:42:20 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id 1-20020ac85901000000b0035cf5edefa6sm11793875qty.56.2022.10.03.19.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 19:42:19 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com, Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v7 01/11] rcu: Wake up nocb gp thread on rcu_barrier_entrain()
Date:   Tue,  4 Oct 2022 02:41:47 +0000
Message-Id: <20221004024157.2470238-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221004024157.2470238-1-joel@joelfernandes.org>
References: <20221004024157.2470238-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

In preparation of RCU lazy changes, wake up the RCU nocb gp thread if
needed after an entrain. Otherwise, the RCU barrier callback can wait in
the queue for several seconds before the lazy callbacks in front of it
are serviced.

Reported-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c      | 11 +++++++++++
 kernel/rcu/tree_nocb.h |  4 ++++
 2 files changed, 15 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5ec97e3f7468..04f33191e5ed 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3894,6 +3894,8 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 {
 	unsigned long gseq = READ_ONCE(rcu_state.barrier_sequence);
 	unsigned long lseq = READ_ONCE(rdp->barrier_seq_snap);
+	bool wake_nocb = false;
+	bool was_done = false;
 
 	lockdep_assert_held(&rcu_state.barrier_lock);
 	if (rcu_seq_state(lseq) || !rcu_seq_state(gseq) || rcu_seq_ctr(lseq) != rcu_seq_ctr(gseq))
@@ -3902,6 +3904,7 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 	rdp->barrier_head.func = rcu_barrier_callback;
 	debug_rcu_head_queue(&rdp->barrier_head);
 	rcu_nocb_lock(rdp);
+	was_done = rcu_rdp_is_offloaded(rdp) && !rcu_segcblist_pend_cbs(&rdp->cblist);
 	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
 	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
 		atomic_inc(&rcu_state.barrier_cpu_count);
@@ -3909,7 +3912,15 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 		debug_rcu_head_unqueue(&rdp->barrier_head);
 		rcu_barrier_trace(TPS("IRQNQ"), -1, rcu_state.barrier_sequence);
 	}
+
+	/*
+	 * If bypass list was non-empty, wake up the nocb GP thread otherwise
+	 * bypass/lazy CBs may not be noticed, and can cause real long delays!
+	 */
+	wake_nocb = was_done && rcu_segcblist_pend_cbs(&rdp->cblist);
 	rcu_nocb_unlock(rdp);
+	if (wake_nocb)
+		wake_nocb_gp(rdp, false);
 	smp_store_release(&rdp->barrier_seq_snap, gseq);
 }
 
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index f77a6d7e1356..6caade0683dd 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1558,6 +1558,10 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
 {
 }
 
+static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
+{
+}
+
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				  unsigned long j)
 {
-- 
2.38.0.rc1.362.ged0d419d3c-goog

