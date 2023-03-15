Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2556BBD6C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbjCOTji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbjCOTjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:39:25 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3CB61A96
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:39:16 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 97so4420129qvb.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678909155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZQhYsvSmWyuhycEwUPUuLVCJi5L/larxVRjodrPgYU=;
        b=WPzp7vzhgULJB2A4jk1YcDWNT1jobRT1Ako/o+cRiCARG56+shVqIoIt4PgSos4evO
         FIJjUyWumnqa5ztJqHnm/Bl0SN05mH5YBYPmo5nO/7nl+Dg4qzpD8ZJdUeQmDXg3a3l+
         07fArh0ALdM0jYUmpKU1a4ZPhZK8IyVKtz3LQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678909155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZQhYsvSmWyuhycEwUPUuLVCJi5L/larxVRjodrPgYU=;
        b=T4SLCTFWPtQewCizXKzCKbsTd5X3/nA5kNaSYYWD1krKWZCPP5q38T3tsz2yEp2W0K
         Ty060N5NUiiOvogNPDY61PNXxXMrl1vzPWAtPHtNBNoRZQxM1pogBNPl0rufTxJcsrbU
         7VSNFuDblnb0563f774ndLaHQq3jqgPGggozGBZFyB1OI+oz0Qva2bZ+Q6/8QRlxiilz
         hO9aL5i2i9yZMSmxyDR1ItPsI+KIzOPKesHcfslF6l0hmJzh9umUR6Xad3p/fQj3YTR6
         s2NEmvF7XefZkuBPjo7HahgK1vx2nn/r1xha/4z6ozlnzORMz1FFKYLRCCUrgbMtD1J8
         8QpA==
X-Gm-Message-State: AO0yUKVKWDVdGPZ4JWe3SlNIDrwGmHgSxw3xNPO+SidntKKz/Nhzypvy
        HCjh5/SF68yLOdJAwudAT9s2N2UvVW81vqIZiKU=
X-Google-Smtp-Source: AK7set/BS4KvAf22SZ3pUETcpzcy8qj4TfbnI/y1P1fLDLmHD7qK7T2GWim/udjQaYTGfP+pydeECw==
X-Received: by 2002:a05:6214:1d0b:b0:5ab:f46:e094 with SMTP id e11-20020a0562141d0b00b005ab0f46e094mr16549743qvd.49.1678909155498;
        Wed, 15 Mar 2023 12:39:15 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a254a00b00745af48838bsm4347227qko.5.2023.03.15.12.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 12:39:15 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        rcu@vger.kernel.org
Subject: [PATCH 4/6] Documentation: RCU: Correct spelling
Date:   Wed, 15 Mar 2023 19:38:49 +0000
Message-Id: <20230315193851.8598-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315193851.8598-1-joel@joelfernandes.org>
References: <20230315193851.8598-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Correct spelling problems for Documentation/RCU/ as reported
by codespell.

Note: in RTFP.txt, there are other misspellings that are left as is
since they were used that way in email Subject: lines or in LWN.net
articles. [preemptable, Preemptable, synchonisation]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: rcu@vger.kernel.org
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 .../Expedited-Grace-Periods.rst                        |  6 +++---
 .../Memory-Ordering/Tree-RCU-Memory-Ordering.rst       |  2 +-
 Documentation/RCU/RTFP.txt                             | 10 +++++-----
 Documentation/RCU/UP.rst                               |  4 ++--
 Documentation/RCU/lockdep.rst                          |  2 +-
 Documentation/RCU/torture.rst                          |  4 ++--
 6 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst
index c9c957c85bac..93d899d53258 100644
--- a/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst
+++ b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst
@@ -277,7 +277,7 @@ the following access functions:
 
 Again, only one request in a given batch need actually carry out a
 grace-period operation, which means there must be an efficient way to
-identify which of many concurrent reqeusts will initiate the grace
+identify which of many concurrent requests will initiate the grace
 period, and that there be an efficient way for the remaining requests to
 wait for that grace period to complete. However, that is the topic of
 the next section.
@@ -405,7 +405,7 @@ Use of Workqueues
 In earlier implementations, the task requesting the expedited grace
 period also drove it to completion. This straightforward approach had
 the disadvantage of needing to account for POSIX signals sent to user
-tasks, so more recent implemementations use the Linux kernel's
+tasks, so more recent implementations use the Linux kernel's
 workqueues (see Documentation/core-api/workqueue.rst).
 
 The requesting task still does counter snapshotting and funnel-lock
@@ -465,7 +465,7 @@ corresponding disadvantage that workqueues cannot be used until they are
 initialized, which does not happen until some time after the scheduler
 spawns the first task. Given that there are parts of the kernel that
 really do want to execute grace periods during this mid-boot “dead
-zone”, expedited grace periods must do something else during thie time.
+zone”, expedited grace periods must do something else during this time.
 
 What they do is to fall back to the old practice of requiring that the
 requesting task drive the expedited grace period, as was the case before
diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
index 7fdf151a8680..5750f125361b 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
@@ -168,7 +168,7 @@ an ``atomic_add_return()`` of zero) to detect idle CPUs.
 +-----------------------------------------------------------------------+
 
 The approach must be extended to handle one final case, that of waking a
-task blocked in ``synchronize_rcu()``. This task might be affinitied to
+task blocked in ``synchronize_rcu()``. This task might be affined to
 a CPU that is not yet aware that the grace period has ended, and thus
 might not yet be subject to the grace period's memory ordering.
 Therefore, there is an ``smp_mb()`` after the return from
diff --git a/Documentation/RCU/RTFP.txt b/Documentation/RCU/RTFP.txt
index 588d97366a46..db8f16b392aa 100644
--- a/Documentation/RCU/RTFP.txt
+++ b/Documentation/RCU/RTFP.txt
@@ -201,7 +201,7 @@ work looked at debugging uses of RCU [Seyster:2011:RFA:2075416.2075425].
 In 2012, Josh Triplett received his Ph.D. with his dissertation
 covering RCU-protected resizable hash tables and the relationship
 between memory barriers and read-side traversal order:  If the updater
-is making changes in the opposite direction from the read-side traveral
+is making changes in the opposite direction from the read-side traversal
 order, the updater need only execute a memory-barrier instruction,
 but if in the same direction, the updater needs to wait for a grace
 period between the individual updates [JoshTriplettPhD].  Also in 2012,
@@ -1245,7 +1245,7 @@ Oregon Health and Sciences University"
 [Viewed September 5, 2005]"
 ,annotation={
 	First posting showing how RCU can be safely adapted for
-	preemptable RCU read side critical sections.
+	preemptible RCU read side critical sections.
 }
 }
 
@@ -1888,7 +1888,7 @@ Revised:
 \url{https://lore.kernel.org/r/20070910183004.GA3299@linux.vnet.ibm.com}
 [Viewed October 25, 2007]"
 ,annotation={
-	Final patch for preemptable RCU to -rt.  (Later patches were
+	Final patch for preemptible RCU to -rt.  (Later patches were
 	to mainline, eventually incorporated.)
 }
 }
@@ -2275,7 +2275,7 @@ lot of {Linux} into your technology!!!"
 \url{https://lore.kernel.org/r/20090724001429.GA17374@linux.vnet.ibm.com}
 [Viewed August 15, 2009]"
 ,annotation={
-	First posting of simple and fast preemptable RCU.
+	First posting of simple and fast preemptible RCU.
 }
 }
 
@@ -2639,7 +2639,7 @@ lot of {Linux} into your technology!!!"
 	RCU-protected hash tables, barriers vs. read-side traversal order.
 	.
 	If the updater is making changes in the opposite direction from
-	the read-side traveral order, the updater need only execute a
+	the read-side traversal order, the updater need only execute a
 	memory-barrier instruction, but if in the same direction, the
 	updater needs to wait for a grace period between the individual
 	updates.
diff --git a/Documentation/RCU/UP.rst b/Documentation/RCU/UP.rst
index 8b20fd45f255..4060d7a2f62a 100644
--- a/Documentation/RCU/UP.rst
+++ b/Documentation/RCU/UP.rst
@@ -107,7 +107,7 @@ UP systems, including PREEMPT SMP builds running on UP systems.
 
 Quick Quiz #3:
 	Why can't synchronize_rcu() return immediately on UP systems running
-	preemptable RCU?
+	preemptible RCU?
 
 .. _answer_quick_quiz_up:
 
@@ -143,7 +143,7 @@ Answer to Quick Quiz #2:
 
 Answer to Quick Quiz #3:
 	Why can't synchronize_rcu() return immediately on UP systems
-	running preemptable RCU?
+	running preemptible RCU?
 
 	Because some other task might have been preempted in the middle
 	of an RCU read-side critical section.  If synchronize_rcu()
diff --git a/Documentation/RCU/lockdep.rst b/Documentation/RCU/lockdep.rst
index 2749f43ec1b0..69e73a39bd11 100644
--- a/Documentation/RCU/lockdep.rst
+++ b/Documentation/RCU/lockdep.rst
@@ -65,7 +65,7 @@ checking of rcu_dereference() primitives:
 	rcu_access_pointer(p):
 		Return the value of the pointer and omit all barriers,
 		but retain the compiler constraints that prevent duplicating
-		or coalescsing.  This is useful when testing the
+		or coalescing.  This is useful when testing the
 		value of the pointer itself, for example, against NULL.
 
 The rcu_dereference_check() check expression can be any boolean
diff --git a/Documentation/RCU/torture.rst b/Documentation/RCU/torture.rst
index 0316ba0c6922..b3b6dfa85248 100644
--- a/Documentation/RCU/torture.rst
+++ b/Documentation/RCU/torture.rst
@@ -216,7 +216,7 @@ Kernel boot arguments can also be supplied, for example, to control
 rcutorture's module parameters.  For example, to test a change to RCU's
 CPU stall-warning code, use "--bootargs 'rcutorture.stall_cpu=30'".
 This will of course result in the scripting reporting a failure, namely
-the resuling RCU CPU stall warning.  As noted above, reducing memory may
+the resulting RCU CPU stall warning.  As noted above, reducing memory may
 require disabling rcutorture's callback-flooding tests::
 
 	kvm.sh --cpus 448 --configs '56*TREE04' --memory 128M \
@@ -370,5 +370,5 @@ You can also re-run a previous remote run in a manner similar to kvm.sh:
 		tools/testing/selftests/rcutorture/res/2022.11.03-11.26.28-remote \
 		--duration 24h
 
-In this case, most of the kvm-again.sh parmeters may be supplied following
+In this case, most of the kvm-again.sh parameters may be supplied following
 the pathname of the old run-results directory.
-- 
2.40.0.rc1.284.g88254d51c5-goog

