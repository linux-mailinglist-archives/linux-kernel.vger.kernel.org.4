Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23B46513F4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 21:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbiLSUa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 15:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbiLSUaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 15:30:03 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C989767F;
        Mon, 19 Dec 2022 12:29:58 -0800 (PST)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJJoue0011960;
        Mon, 19 Dec 2022 20:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=sM4Tumpims+OtpD2j4ymbG2RWDwxkOit/SUN90kBxjg=;
 b=TBtBjm9J4r239rCE2d4UwtxqNvr0bo5JjAMWCkE1jOJDPAp2NCP45L7TJDhpBav/Z+0f
 5f1xDFM9O6wY3HIDpgal3YZ1O8VFsW/r3OOw02Xg77qp9B7iwOSXpPlxj8EulsGC6xOO
 CzFM6WfIgG/tS3ujUCqxnNAZHo/mRAyaTvQ5BnbXUQXB3PZKVmkhqolWBVRVnkldjURw
 N1+NYQaxDixTMQMvodCizrU7+MZU2HHxZKn9tJ/9zKP70JYfzhn4x/ULUCiwNY7qlVlN
 atzmQWYyIxZQWZZHBASuWKbGvxB4f9eYa5zvzM2H5H8SHZiiDMKfj2gEZDHLwyvMwHlj dA== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3mjx3mrdjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 20:29:43 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 5C2E2800EC3;
        Mon, 19 Dec 2022 20:29:42 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id E05168064A8;
        Mon, 19 Dec 2022 20:29:41 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org
Cc:     linux-crypto@vger.kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: [PATCH 1/3] rcu: genericize RCU stall suppression functions
Date:   Mon, 19 Dec 2022 14:29:08 -0600
Message-Id: <20221219202910.3063036-2-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221219202910.3063036-1-elliott@hpe.com>
References: <20221219202910.3063036-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _DWClsvXR85ZUkNJB2RiHeq_UM1-A9eC
X-Proofpoint-ORIG-GUID: _DWClsvXR85ZUkNJB2RiHeq_UM1-A9eC
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212190180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the functions that temporarily suppress RCU CPU
stall reporting:
	rcu_sysrq_start()
	rcu_sysrq_end()

to more generic functions that may be called by functions
other than the SysRq handler:
	rcu_suppress_start()
	rcu_suppress_end()

Covert the underlying variable:
	rcu_cpu_stall_suppress

to an atomic variable so multiple threads can manipulate it at the
same time, incrementing it in start() and decrementing in end().

Expose that in sysfs in a read-only
	/sys/module/rcupdate/parameters/rcu_cpu_stall_suppress_dyn

Keep
	/sys/module/rcupdate/parameters/rcu_cpu_stall_suppress
as writeable by userspace, but OR that into the equations rather than
directly manipulate the atomic value.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 .../RCU/Design/Requirements/Requirements.rst  |  6 +++---
 Documentation/RCU/stallwarn.rst               | 19 +++++++++++++++----
 arch/parisc/kernel/process.c                  |  2 +-
 drivers/tty/sysrq.c                           |  4 ++--
 include/linux/rcupdate.h                      |  8 ++++----
 kernel/rcu/rcu.h                              | 11 ++++++-----
 kernel/rcu/tree_stall.h                       | 18 ++++++++++--------
 kernel/rcu/update.c                           | 11 ++++++++++-
 8 files changed, 51 insertions(+), 28 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 49387d823619..5083490bb6fc 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1639,9 +1639,9 @@ against mishaps and misuse:
    ``rcupdate.rcu_cpu_stall_suppress`` to suppress the splats. This
    kernel parameter may also be set via ``sysfs``. Furthermore, RCU CPU
    stall warnings are counter-productive during sysrq dumps and during
-   panics. RCU therefore supplies the rcu_sysrq_start() and
-   rcu_sysrq_end() API members to be called before and after long
-   sysrq dumps. RCU also supplies the rcu_panic() notifier that is
+   panics. RCU therefore supplies the rcu_suppress_start() and
+   rcu_suppress_end() API members to be called before and after long
+   CPU usage. RCU also supplies the rcu_panic() notifier that is
    automatically invoked at the beginning of a panic to suppress further
    RCU CPU stall warnings.
 
diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
index e38c587067fc..9e6fba72f56d 100644
--- a/Documentation/RCU/stallwarn.rst
+++ b/Documentation/RCU/stallwarn.rst
@@ -135,13 +135,24 @@ see include/trace/events/rcu.h.
 Fine-Tuning the RCU CPU Stall Detector
 ======================================
 
-The rcuupdate.rcu_cpu_stall_suppress module parameter disables RCU's
-CPU stall detector, which detects conditions that unduly delay RCU grace
-periods.  This module parameter enables CPU stall detection by default,
-but may be overridden via boot-time parameter or at runtime via sysfs.
+RCU's CPU stall detector detects conditions that unduly delay RCU grace
+periods.  CPU stall detection is enabled by default, but may be overridden
+via boot-time parameter or at runtime via sysfs (accessible via
+/sys/module/rcupdate/parameters).
+
+The rcupdate.rcu_cpu_stall_suppress module parameter disables RCU's
+CPU stall detector.
+
+/sys/module/rcu_cpu_stall_suppress_dyn reports an internal semaphore
+used by the RCU's CPU stall detector. Functions holding a CPU for a
+long time (e.g., sysrq printouts) increment this value before use
+and decrement it when done, so the value reports the number of
+functions currently disabling stalls.
+
 The stall detector's idea of what constitutes "unduly delayed" is
 controlled by a set of kernel configuration variables and cpp macros:
 
+
 CONFIG_RCU_CPU_STALL_TIMEOUT
 ----------------------------
 
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index c4f8374c7018..038378fe7bfa 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -126,7 +126,7 @@ void machine_power_off(void)
 	       "Please power this system off now.");
 
 	/* prevent soft lockup/stalled CPU messages for endless loop. */
-	rcu_sysrq_start();
+	rcu_suppress_start();
 	lockup_detector_soft_poweroff();
 	for (;;);
 }
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index d2b2720db6ca..81ab63a473a7 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -579,7 +579,7 @@ void __handle_sysrq(int key, bool check_mask)
 	orig_suppress_printk = suppress_printk;
 	suppress_printk = 0;
 
-	rcu_sysrq_start();
+	rcu_suppress_start();
 	rcu_read_lock();
 	/*
 	 * Raise the apparent loglevel to maximum so that the sysrq header
@@ -623,7 +623,7 @@ void __handle_sysrq(int key, bool check_mask)
 		console_loglevel = orig_log_level;
 	}
 	rcu_read_unlock();
-	rcu_sysrq_end();
+	rcu_suppress_end();
 
 	suppress_printk = orig_suppress_printk;
 }
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 03abf883a281..c0d8a4aae7ff 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -131,11 +131,11 @@ static inline void rcu_init_tasks_generic(void) { }
 #endif
 
 #ifdef CONFIG_RCU_STALL_COMMON
-void rcu_sysrq_start(void);
-void rcu_sysrq_end(void);
+void rcu_suppress_start(void);
+void rcu_suppress_end(void);
 #else /* #ifdef CONFIG_RCU_STALL_COMMON */
-static inline void rcu_sysrq_start(void) { }
-static inline void rcu_sysrq_end(void) { }
+static inline void rcu_suppress_start(void) { }
+static inline void rcu_suppress_end(void) { }
 #endif /* #else #ifdef CONFIG_RCU_STALL_COMMON */
 
 #if defined(CONFIG_NO_HZ_FULL) && (!defined(CONFIG_GENERIC_ENTRY) || !defined(CONFIG_KVM_XFER_TO_GUEST_WORK))
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index c5aa934de59b..a658955a1174 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -224,24 +224,25 @@ extern int rcu_cpu_stall_ftrace_dump;
 extern int rcu_cpu_stall_suppress;
 extern int rcu_cpu_stall_timeout;
 extern int rcu_exp_cpu_stall_timeout;
+extern atomic_t rcu_cpu_stall_suppress_dyn;
 int rcu_jiffies_till_stall_check(void);
 int rcu_exp_jiffies_till_stall_check(void);
 
 static inline bool rcu_stall_is_suppressed(void)
 {
-	return rcu_stall_is_suppressed_at_boot() || rcu_cpu_stall_suppress;
+	return rcu_stall_is_suppressed_at_boot() ||
+	       rcu_cpu_stall_suppress ||
+	       atomic_read(&rcu_cpu_stall_suppress_dyn);
 }
 
 #define rcu_ftrace_dump_stall_suppress() \
 do { \
-	if (!rcu_cpu_stall_suppress) \
-		rcu_cpu_stall_suppress = 3; \
+	atomic_inc(&rcu_cpu_stall_suppress_dyn); \
 } while (0)
 
 #define rcu_ftrace_dump_stall_unsuppress() \
 do { \
-	if (rcu_cpu_stall_suppress == 3) \
-		rcu_cpu_stall_suppress = 0; \
+	atomic_dec(&rcu_cpu_stall_suppress_dyn); \
 } while (0)
 
 #else /* #endif #ifdef CONFIG_RCU_STALL_COMMON */
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 5653560573e2..260748bc5bc8 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -103,23 +103,25 @@ bool rcu_gp_might_be_stalled(void)
 	return !time_before(j, READ_ONCE(rcu_state.gp_start) + d);
 }
 
-/* Don't do RCU CPU stall warnings during long sysrq printouts. */
-void rcu_sysrq_start(void)
+/* Don't do RCU CPU stall warnings during functions holding the CPU
+ * for a long period of time such as long sysrq printouts.
+ */
+void rcu_suppress_start(void)
 {
-	if (!rcu_cpu_stall_suppress)
-		rcu_cpu_stall_suppress = 2;
+	atomic_inc(&rcu_cpu_stall_suppress_dyn);
 }
+EXPORT_SYMBOL_GPL(rcu_suppress_start);
 
-void rcu_sysrq_end(void)
+void rcu_suppress_end(void)
 {
-	if (rcu_cpu_stall_suppress == 2)
-		rcu_cpu_stall_suppress = 0;
+	atomic_dec(&rcu_cpu_stall_suppress_dyn);
 }
+EXPORT_SYMBOL_GPL(rcu_suppress_end);
 
 /* Don't print RCU CPU stall warnings during a kernel panic. */
 static int rcu_panic(struct notifier_block *this, unsigned long ev, void *ptr)
 {
-	rcu_cpu_stall_suppress = 1;
+	atomic_inc(&rcu_cpu_stall_suppress_dyn);
 	return NOTIFY_DONE;
 }
 
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index f5e6a2f95a2a..ceee9d777384 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -501,11 +501,18 @@ EXPORT_SYMBOL_GPL(rcutorture_sched_setaffinity);
 #ifdef CONFIG_RCU_STALL_COMMON
 int rcu_cpu_stall_ftrace_dump __read_mostly;
 module_param(rcu_cpu_stall_ftrace_dump, int, 0644);
-int rcu_cpu_stall_suppress __read_mostly; // !0 = suppress stall warnings.
+
+int rcu_cpu_stall_suppress __read_mostly; // !0 = suppress stall warnings from sysfs
 EXPORT_SYMBOL_GPL(rcu_cpu_stall_suppress);
 module_param(rcu_cpu_stall_suppress, int, 0644);
+
+atomic_t rcu_cpu_stall_suppress_dyn __read_mostly; // !0 = suppress stall warnings from functions
+EXPORT_SYMBOL_GPL(rcu_cpu_stall_suppress_dyn);
+module_param_named(rcu_cpu_stall_suppress_dyn, rcu_cpu_stall_suppress_dyn.counter, int, 0444);
+
 int rcu_cpu_stall_timeout __read_mostly = CONFIG_RCU_CPU_STALL_TIMEOUT;
 module_param(rcu_cpu_stall_timeout, int, 0644);
+
 int rcu_exp_cpu_stall_timeout __read_mostly = CONFIG_RCU_EXP_CPU_STALL_TIMEOUT;
 module_param(rcu_exp_cpu_stall_timeout, int, 0644);
 #endif /* #ifdef CONFIG_RCU_STALL_COMMON */
@@ -616,6 +623,8 @@ void __init rcupdate_announce_bootup_oddness(void)
 		pr_info("\tAll grace periods are expedited (rcu_expedited).\n");
 	if (rcu_cpu_stall_suppress)
 		pr_info("\tRCU CPU stall warnings suppressed (rcu_cpu_stall_suppress).\n");
+	if (atomic_read(&rcu_cpu_stall_suppress_dyn))
+		pr_info("\tDynamic RCU CPU stall warnings suppressed (rcu_cpu_stall_suppress_dyn).\n");
 	if (rcu_cpu_stall_timeout != CONFIG_RCU_CPU_STALL_TIMEOUT)
 		pr_info("\tRCU CPU stall warnings timeout set to %d (rcu_cpu_stall_timeout).\n", rcu_cpu_stall_timeout);
 	rcu_tasks_bootup_oddness();
-- 
2.38.1

