Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55315BC051
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 00:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiIRWM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 18:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiIRWMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 18:12:55 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82514175BC
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 15:12:54 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id c19so17519360qkm.7
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 15:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=HXkqJPz2Q1x1z42PuwNUDqWKa6qWWyjG1jcVGqv3b90=;
        b=wTa+93vShI3UntC4CmW573ddfkiAAfDavVF11MP7UPdIm34s395lHWE5Wg1BSZZqz5
         kNIWKVM/1ZLaZPD9v0rNcD7SrIN6tEPbQFUuM9H/RJTA3j90QYIgXDnTYzZEC1k9oBoE
         Efhqvc1q/T5EBcRKE1InxwwW5WKVZnPaQ74Q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=HXkqJPz2Q1x1z42PuwNUDqWKa6qWWyjG1jcVGqv3b90=;
        b=6Z22BhyfCEBhDndNJtuDiNpstifzFL73EtaXeztBRvbTLk4588lrG3p0nI2xj0TIC1
         TxSf/010M3LcC3Y7XPsKQ6VlYZ9Beus6MD9BZWJrmoyHTyrC5vsGARUuL0xAM9WF9htY
         7RdswpotBWimvo8k0XT1O/eoTvUAbU02rfZUG4ZdmEoTwkjnlMioffPTyAHRvxZ6CEM3
         O6Ql9nThIxwyCZgc0u068Yggyky7aLDEaJLQVuV10cuBhr+gZtZZUXshq9iz11MDoCD5
         l/gIqj/NUkrq/imV8hiTebvOrDqsHQojaoR/sWjWhUPyRBBAz5N4OkSweD55Yj9KNzeW
         Dgng==
X-Gm-Message-State: ACrzQf2Kca3Uk02iOAZBC6Rec6+t7nnAA1p0ztJWEp/yqDR3+0pNf3ER
        NSQILNmNDPO8TUS3Dv9VF+FbbQ==
X-Google-Smtp-Source: AMsMyM4r1fnipOlRyYdZkgTsOKxNLpX1Hl2npAzimHlen5gspgqtGVd4/DtA6MiJaEcVVdubAlsy8Q==
X-Received: by 2002:a05:620a:2456:b0:6ce:3cfe:dd62 with SMTP id h22-20020a05620a245600b006ce3cfedd62mr10806522qkn.380.1663539173631;
        Sun, 18 Sep 2022 15:12:53 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id t14-20020ac86a0e000000b0035cd6a4ba3csm4629047qtr.39.2022.09.18.15.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 15:12:53 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [RFC] rcu/nocb: Fix possible bugs in rcu_barrier()
Date:   Sun, 18 Sep 2022 22:12:31 +0000
Message-Id: <20220918221231.79143-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
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

When going through the lazy-rcu work, I noticed that
rcu_barrier_entrain() does not really wake up the rcuog GP thread in any
path after entraining. This means it is possible the GP thread is not
awakened soon (say there were no CBs in the cblist after entraining
time).

Further, nothing appears to be calling the rcu_barrier callback
directly in the case the ->cblist was empty which means if the IPI gets
delayed enough to make the ->cblist empty and it turns out to be the last
CPU holding, then nothing calls completes rcu_state.barrier_completion.

Fix both these issues.

A note on the wakeup, there are 3 cases AFAICS after the call to
rcu_nocb_flush_bypass():

1. The rdp->cblist has pending CBs.

2. The rdp->cblist has all done CBs.

3. The rdp->cblist has no CBs at all (say the IPI took a long time to
arrive and some other path dequeued them in the meanwhile).

For #3, entraining a CB is not needed and we should bail.  For #1 and
needed. But for #2 it is needed.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
I only build tested this and wanted to post it in advance for discussions. I
will test it more soon. Thanks.

 kernel/rcu/tree.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 18f07e167d5e..65d439286757 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3904,10 +3904,11 @@ static void rcu_barrier_callback(struct rcu_head *rhp)
 /*
  * If needed, entrain an rcu_barrier() callback on rdp->cblist.
  */
-static void rcu_barrier_entrain(struct rcu_data *rdp)
+static void rcu_barrier_entrain(struct rcu_data *rdp, unsigned long flags)
 {
 	unsigned long gseq = READ_ONCE(rcu_state.barrier_sequence);
 	unsigned long lseq = READ_ONCE(rdp->barrier_seq_snap);
+	bool was_alldone;
 
 	lockdep_assert_held(&rcu_state.barrier_lock);
 	if (rcu_seq_state(lseq) || !rcu_seq_state(gseq) || rcu_seq_ctr(lseq) != rcu_seq_ctr(gseq))
@@ -3916,14 +3917,20 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 	rdp->barrier_head.func = rcu_barrier_callback;
 	debug_rcu_head_queue(&rdp->barrier_head);
 	rcu_nocb_lock(rdp);
+	was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
 	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
+
 	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
 		atomic_inc(&rcu_state.barrier_cpu_count);
+		__call_rcu_nocb_wake(rdp, was_alldone, flags); /* unlocks */
 	} else {
+		/* rdp->cblist is empty so directly call the callback. */
+		atomic_inc(&rcu_state.barrier_cpu_count);
+		rcu_barrier_callback(&rdp->barrier_head);
 		debug_rcu_head_unqueue(&rdp->barrier_head);
 		rcu_barrier_trace(TPS("IRQNQ"), -1, rcu_state.barrier_sequence);
+		rcu_nocb_unlock(rdp);
 	}
-	rcu_nocb_unlock(rdp);
 	smp_store_release(&rdp->barrier_seq_snap, gseq);
 }
 
@@ -3932,15 +3939,16 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
  */
 static void rcu_barrier_handler(void *cpu_in)
 {
+	unsigned long flags;
 	uintptr_t cpu = (uintptr_t)cpu_in;
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 
 	lockdep_assert_irqs_disabled();
 	WARN_ON_ONCE(cpu != rdp->cpu);
 	WARN_ON_ONCE(cpu != smp_processor_id());
-	raw_spin_lock(&rcu_state.barrier_lock);
-	rcu_barrier_entrain(rdp);
-	raw_spin_unlock(&rcu_state.barrier_lock);
+	raw_spin_lock_irqsave(&rcu_state.barrier_lock, flags);
+	rcu_barrier_entrain(rdp, flags);
+	raw_spin_unlock_irqrestore(&rcu_state.barrier_lock, flags);
 }
 
 /**
@@ -4007,7 +4015,7 @@ void rcu_barrier(void)
 			continue;
 		}
 		if (!rcu_rdp_cpu_online(rdp)) {
-			rcu_barrier_entrain(rdp);
+			rcu_barrier_entrain(rdp, flags);
 			WARN_ON_ONCE(READ_ONCE(rdp->barrier_seq_snap) != gseq);
 			raw_spin_unlock_irqrestore(&rcu_state.barrier_lock, flags);
 			rcu_barrier_trace(TPS("OfflineNoCBQ"), cpu, rcu_state.barrier_sequence);
@@ -4333,7 +4341,7 @@ void rcutree_migrate_callbacks(int cpu)
 
 	raw_spin_lock_irqsave(&rcu_state.barrier_lock, flags);
 	WARN_ON_ONCE(rcu_rdp_cpu_online(rdp));
-	rcu_barrier_entrain(rdp);
+	rcu_barrier_entrain(rdp, flags);
 	my_rdp = this_cpu_ptr(&rcu_data);
 	my_rnp = my_rdp->mynode;
 	rcu_nocb_lock(my_rdp); /* irqs already disabled. */
-- 
2.37.3.968.ga6b4b080e4-goog

