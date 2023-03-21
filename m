Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A726C2ED3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjCUK2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjCUK2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:28:04 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A88A20A1C;
        Tue, 21 Mar 2023 03:27:53 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id t5so20821627edd.7;
        Tue, 21 Mar 2023 03:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679394472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l8z6fJ+etiYuoIrK6H9DrJVryu63/YoV8p7ynBQ749A=;
        b=H22sCAqufPjUUv/3ovdN/wZzOhlD1t2BnFw9KSgih8mAseKfD6RqN+P3ZEVPJ1yQU/
         9NwMfNmcDp1j9vdhajPyOOw11jdnCnG0PThLQypQrB1xqpcXG6iXsH55LqLDyTVws+uO
         iugJbB1g+YHsl0AWMqr6rky02lKItVfB7TF12+VTZc/uKlNCNZdVvXNOgT4IzxMpPtAu
         mJH1VkS+5rjwTpfgxHliq1dTBTC0KZ7L8PkkHqyemGS0OZiuokE9+5iyLo7Lr9YXTDHg
         5t+CM+TuQABAg/VM3yPp44LIMkKoKAjjmCbvtXQvuZ09h/7QoHzFSWDPgNre/Yw+vrMr
         Pt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679394472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l8z6fJ+etiYuoIrK6H9DrJVryu63/YoV8p7ynBQ749A=;
        b=t6hQOE/hZ5S3nJ9+cHTZS7zhbyr3nMYpqexk3kTFPNfugsCOOgKPI+CdfQn90WPFNM
         Yj95tNuRE73ES4wwfmkLrvmZVD3IL9LzOLAGhdwKLX/TucZdzbZLhdNlnD012MwbfnNc
         5bzaKnQDIKFAF48i9ujoHPtYbK0W2raCTKl5jtAZ6mFso0JedDtqpkiK338DnUFI4OtV
         JWDIQ1sNqeihftIKSdTlMnDrhrVe06o+BkOLs5WlWMIRRzhIVdI9kfbOAYW/cQdmycZS
         iHbPyvxbfgw7y30CArmXp25Q6MivoZF10U+or5PvFokG3Okl4F5Izxo1eMm5Gm73HpS3
         fiVg==
X-Gm-Message-State: AO0yUKWOQRRsZyxQdUSuuTygOJ6jxVluaS65ZzfxkznN9vwzammshWgj
        GR1gu/No4JJiszPEOQylboQ=
X-Google-Smtp-Source: AK7set9wSdfsuAxYOGuzA0a72kbhVxLwerXEHKfRrsNteK5BQ7tJ2MPX+BMHowLAsAcuJ9QUw4ZMTQ==
X-Received: by 2002:a17:906:5a8f:b0:878:5372:a34b with SMTP id l15-20020a1709065a8f00b008785372a34bmr2237944ejq.45.1679394471540;
        Tue, 21 Mar 2023 03:27:51 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id g17-20020a170906c19100b00921c608b737sm5571051ejz.126.2023.03.21.03.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 03:27:51 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     RCU <rcu@vger.kernel.org>, quic_neeraju@quicinc.com,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 1/1] Reduce synchronize_rcu() waiting time
Date:   Tue, 21 Mar 2023 11:27:48 +0100
Message-Id: <20230321102748.127923-1-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A call to a synchronize_rcu() can be expensive from time point of
view. Different workloads can be affected by this especially the
ones which use this API in its time critical sections.

For example in case of NOCB scenario the wakeme_after_rcu() callback
invocation depends on where in a nocb-list it is located. Below is an
example when it was the last out of ~3600 callbacks:

<snip>
  <...>-29      [001] d..1. 21950.145313: rcu_batch_start: rcu_preempt CBs=3613 bl=28
...
  <...>-29      [001] ..... 21950.152578: rcu_invoke_callback: rcu_preempt rhp=00000000b2d6dee8 func=__free_vm_area_struct.cfi_jt
  <...>-29      [001] ..... 21950.152579: rcu_invoke_callback: rcu_preempt rhp=00000000a446f607 func=__free_vm_area_struct.cfi_jt
  <...>-29      [001] ..... 21950.152580: rcu_invoke_callback: rcu_preempt rhp=00000000a5cab03b func=__free_vm_area_struct.cfi_jt
  <...>-29      [001] ..... 21950.152581: rcu_invoke_callback: rcu_preempt rhp=0000000013b7e5ee func=__free_vm_area_struct.cfi_jt
  <...>-29      [001] ..... 21950.152582: rcu_invoke_callback: rcu_preempt rhp=000000000a8ca6f9 func=__free_vm_area_struct.cfi_jt
  <...>-29      [001] ..... 21950.152583: rcu_invoke_callback: rcu_preempt rhp=000000008f162ca8 func=wakeme_after_rcu.cfi_jt
  <...>-29      [001] d..1. 21950.152625: rcu_batch_end: rcu_preempt CBs-invoked=3612 idle=....
<snip>

As performance results, i will provide it once we are ready with a
patch.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 104 +++++++++++++++++++++++++++++++++++++++++++++-
 kernel/rcu/tree.h |   9 ++++
 2 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ee27a03d7576..349200a058da 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1380,6 +1380,78 @@ static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
 
+static void rcu_sr_normal_add_req_this_cpu(struct list_head *list)
+{
+	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
+
+	raw_spin_lock(&rdp->sr_array_lock);
+	list_add(list, &rdp->sr_array[0]);
+	raw_spin_unlock(&rdp->sr_array_lock);
+}
+
+static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
+{
+	struct list_head gp_ready_list, *it, *next;
+	struct rcu_synchronize *rs;
+	struct rcu_data *rdp;
+	int i;
+
+	for_each_possible_cpu(i) {
+		rdp = per_cpu_ptr(&rcu_data, i);
+		if (list_empty(&rdp->sr_array[2]))
+			continue;
+
+		raw_spin_lock(&rdp->sr_array_lock);
+		list_replace_init(&rdp->sr_array[2], &gp_ready_list);
+		raw_spin_unlock(&rdp->sr_array_lock);
+
+		list_for_each_safe(it, next, &gp_ready_list) {
+			rs = container_of((struct rcu_head *) it, typeof(*rs), head);
+			complete(&rs->completion);
+		}
+	}
+}
+static DECLARE_WORK(sr_normal_gp_cleanup, rcu_sr_normal_gp_cleanup_work);
+
+static void rcu_sr_normal_gp_cleanup(void)
+{
+	bool need_sr_cleanup = false;
+	struct rcu_data *rdp;
+	int i;
+
+	for_each_possible_cpu(i) {
+		rdp = per_cpu_ptr(&rcu_data, i);
+		if (list_empty(&rdp->sr_array[1]))
+			continue;
+
+		raw_spin_lock(&rdp->sr_array_lock);
+		list_splice_init(&rdp->sr_array[1], &rdp->sr_array[2]);
+		raw_spin_unlock(&rdp->sr_array_lock);
+
+		/* OK, there are ready to go users. */
+		need_sr_cleanup = true;
+	}
+
+	if (need_sr_cleanup)
+		queue_work(system_highpri_wq, &sr_normal_gp_cleanup);
+}
+
+static void rcu_sr_normal_gp_init(void)
+{
+	struct rcu_data *rdp;
+	int i;
+
+	for_each_possible_cpu(i) {
+		rdp = per_cpu_ptr(&rcu_data, i);
+		if (list_empty(&rdp->sr_array[0]))
+			continue;
+
+		raw_spin_lock(&rdp->sr_array_lock);
+		list_splice_init(&rdp->sr_array[0], &rdp->sr_array[1]);
+		raw_spin_unlock(&rdp->sr_array_lock);
+	}
+}
+
 /*
  * Initialize a new grace period.  Return false if no grace period required.
  */
@@ -1477,6 +1549,8 @@ static noinline_for_stack bool rcu_gp_init(void)
 		arch_spin_unlock(&rcu_state.ofl_lock);
 		local_irq_restore(flags);
 	}
+
+	rcu_sr_normal_gp_init();		/* Prepare synchronize_rcu() users. */
 	rcu_gp_slow(gp_preinit_delay); /* Races with CPU hotplug. */
 
 	/*
@@ -1771,6 +1845,9 @@ static noinline void rcu_gp_cleanup(void)
 	}
 	raw_spin_unlock_irq_rcu_node(rnp);
 
+	// Make synchronize_rcu() users aware of the end of old grace period.
+	rcu_sr_normal_gp_cleanup();
+
 	// If strict, make all CPUs aware of the end of the old grace period.
 	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
 		on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
@@ -3434,6 +3511,25 @@ static int rcu_blocking_is_gp(void)
 	return true;
 }
 
+/*
+ * Helper function for the synchronize_rcu() API.
+ */
+static void synchronize_rcu_normal(void)
+{
+	struct rcu_synchronize rs;
+
+	init_rcu_head_on_stack(&rs.head);
+	init_completion(&rs.completion);
+	rcu_sr_normal_add_req_this_cpu((struct list_head *) &rs.head);
+
+	/* Kick a grace period if there is a need. */
+	(void) start_poll_synchronize_rcu();
+
+	/* Now we can wait. */
+	wait_for_completion(&rs.completion);
+	destroy_rcu_head_on_stack(&rs.head);
+}
+
 /**
  * synchronize_rcu - wait until a grace period has elapsed.
  *
@@ -3485,7 +3581,7 @@ void synchronize_rcu(void)
 		if (rcu_gp_is_expedited())
 			synchronize_rcu_expedited();
 		else
-			wait_rcu_gp(call_rcu_hurry);
+			synchronize_rcu_normal();
 		return;
 	}
 
@@ -4215,6 +4311,7 @@ rcu_boot_init_percpu_data(int cpu)
 {
 	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+	int i;
 
 	/* Set up local state, ensuring consistent view of global state. */
 	rdp->grpmask = leaf_node_cpu_bit(rdp->mynode, cpu);
@@ -4229,6 +4326,11 @@ rcu_boot_init_percpu_data(int cpu)
 	rdp->last_sched_clock = jiffies;
 	rdp->cpu = cpu;
 	rcu_boot_init_nocb_percpu_data(rdp);
+
+	for (i = 0; i < ARRAY_SIZE(rdp->sr_array); i++)
+		INIT_LIST_HEAD(&rdp->sr_array[i]);
+
+	raw_spin_lock_init(&rdp->sr_array_lock);
 }
 
 /*
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 192536916f9a..f09969bf7a8d 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -284,6 +284,15 @@ struct rcu_data {
 
 	long lazy_len;			/* Length of buffered lazy callbacks. */
 	int cpu;
+
+	/*
+	 * This array of lists is for handling synchronize_rcu() users.
+	 * An index 0 corresponds to new users, 1 for users which wait
+	 * for a grace period and last one is for which a grace period
+	 * is passed.
+	 */
+	struct list_head sr_array[3];
+	raw_spinlock_t sr_array_lock;
 };
 
 /* Values for nocb_defer_wakeup field in struct rcu_data. */
-- 
2.30.2

