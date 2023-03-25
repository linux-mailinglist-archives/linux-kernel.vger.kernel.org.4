Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243CD6C8FD3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 18:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjCYReh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 13:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjCYReK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 13:34:10 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E71DBE6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 10:34:04 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id hf2so4509967qtb.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 10:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1679765643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6C53sn27NuA32AX3ykr9qVTka3YNyXyLo2FHjcHAPk=;
        b=yhQE5JitzdBNkzY0TYfTzuvOS/VKmMwn5KP2dPiUdYcgdHLPrmvZZ6Np/lG32lNBAd
         lt9VxOLDD0Yxnj/P9thYO1M/R2JLG12ggb55LdZcQNrb8ZOv8E4OD9ybmGmBVQE7U7t4
         vwfVjwDCDMeJ7G6L/7UIbp5+MZFMuw6ebBtYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679765643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6C53sn27NuA32AX3ykr9qVTka3YNyXyLo2FHjcHAPk=;
        b=7WwpDyrLFOfMLgWrQAQlGTo1rw2TUDwi38VlDwa518KblppmfGfe89W7ADL0VrRlfn
         InKrXwjINnjLNfaIiujwGVu76Ghg9JREVZjKZL7kDnyVPPPs4evSLVTS2VW0PIpRu7YD
         DaiiKSe+7LAmYluh8PGehrpyonJ72bJz6uXRpfZlL5R5YSYic++RKZ682LKGqQzngoVp
         eVtH94aFfgqwFHLi3fABlvF4bTygDk5/hLVr2V/kmAovPGFqey/CO/uzfm5cAcK9c3gv
         EH0WLE/71ZUlPEZ0d5wctPQzE/7nCPENEsYNHkpqmZM07pg6y0T1IYKdi5E/zDuDBApA
         t03Q==
X-Gm-Message-State: AO0yUKUh42FFaj0pHOuF7KpBk2cUED/zde7f5MVvmFnJV/0xglbhhIR/
        mTyUKinMilASvDZQ/TXjuEiw9g/DtltplRi9TlI=
X-Google-Smtp-Source: AK7set/kBRoccFhabLv3Raii1q34w76PXtiC0I5XZu7Br5sHC8TyaR8GiL2D8zsuukPc+azN0dL7kw==
X-Received: by 2002:ac8:5787:0:b0:3e3:98af:5de9 with SMTP id v7-20020ac85787000000b003e398af5de9mr12140109qta.63.1679765643455;
        Sat, 25 Mar 2023 10:34:03 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id m4-20020ac84444000000b003e37ee54b5dsm6762764qtn.90.2023.03.25.10.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 10:34:03 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang1.zhang@intel.com>
Cc:     rcu@vger.kernel.org
Subject: [PATCH v2 10/13] rcu: Permit start_poll_synchronize_rcu_expedited() to be invoked early
Date:   Sat, 25 Mar 2023 17:33:13 +0000
Message-Id: <20230325173316.3118674-11-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230325173316.3118674-1-joel@joelfernandes.org>
References: <20230325173316.3118674-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang1.zhang@intel.com>

According to the commit log of the patch that added it to the kernel,
start_poll_synchronize_rcu_expedited() can be invoked very early, as
in long before rcu_init() has been invoked.  But before rcu_init(),
the rcu_data structure's ->mynode field has not yet been initialized.
This means that the start_poll_synchronize_rcu_expedited() function's
attempt to set the CPU's leaf rcu_node structure's ->exp_seq_poll_rq
field will result in a segmentation fault.

This commit therefore causes start_poll_synchronize_rcu_expedited() to
set ->exp_seq_poll_rq only after rcu_init() has initialized all CPUs'
rcu_data structures' ->mynode fields.  It also removes the check from
the rcu_init() function so that start_poll_synchronize_rcu_expedited(
is unconditionally invoked.  Yes, this might result in an unnecessary
boot-time grace period, but this is down in the noise.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c     | 5 ++---
 kernel/rcu/tree_exp.h | 5 +++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e80e8f128c57..90d54571126a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4942,9 +4942,8 @@ void __init rcu_init(void)
 	else
 		qovld_calc = qovld;
 
-	// Kick-start any polled grace periods that started early.
-	if (!(per_cpu_ptr(&rcu_data, cpu)->mynode->exp_seq_poll_rq & 0x1))
-		(void)start_poll_synchronize_rcu_expedited();
+	// Kick-start in case any polled grace periods started early.
+	(void)start_poll_synchronize_rcu_expedited();
 
 	rcu_test_sync_prims();
 }
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 7cc4856da081..5343f32e7d67 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -1066,9 +1066,10 @@ unsigned long start_poll_synchronize_rcu_expedited(void)
 	if (rcu_init_invoked())
 		raw_spin_lock_irqsave(&rnp->exp_poll_lock, flags);
 	if (!poll_state_synchronize_rcu(s)) {
-		rnp->exp_seq_poll_rq = s;
-		if (rcu_init_invoked())
+		if (rcu_init_invoked()) {
+			rnp->exp_seq_poll_rq = s;
 			queue_work(rcu_gp_wq, &rnp->exp_poll_wq);
+		}
 	}
 	if (rcu_init_invoked())
 		raw_spin_unlock_irqrestore(&rnp->exp_poll_lock, flags);
-- 
2.40.0.348.gf938b09366-goog

