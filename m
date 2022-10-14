Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCE45FF367
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 20:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiJNSFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 14:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiJNSFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 14:05:50 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71F8BDF;
        Fri, 14 Oct 2022 11:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=OolHboUoYatLDt1nCSapsrjbktDg/Duc9mI4hH+Y1qM=; b=LTYl6ujYQ5QBsyw2g/9srC4JSo
        3BeUtbdYMcIxehrx4hsvF4jmvoE0sHZiifRB1E1Tv6EH/X7qaawhSThn1Tgut59O9a3fF11uupSCz
        F61A4udFX+1Qdmkg36ptTLMnnNjk4PA0KIyJFg7nC65sVIOOF2g2e+cZOTRx79RrMkB8LbG7vboYv
        G8kEPVuI3cKtSUeFZXrOTe3Nd3hj1nHQzBstf/sWpBPvRhs6E+lA++gUdWbfsDlWOAwqArhZbX4Xb
        ryLqb4RG/1LYO5/tj9uEYfvws8aKBFVxOz9pOe6UCk01A7+GAS06Qvlwv5nZUsZBvvl0ptZ5koiiy
        8JNwRLdA==;
Received: from [179.113.159.85] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1ojP3q-001YP6-TM; Fri, 14 Oct 2022 20:05:31 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Andre Almeida <andrealmeid@igalia.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Joshua Ashton <joshua@froggi.es>,
        Melissa Wen <mwen@igalia.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Pavel Machek <pavel@denx.de>,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
        Tony Luck <tony.luck@intel.com>,
        Zebediah Figura <zfigura@codeweavers.com>
Subject: [PATCH V2] x86/split_lock: Add sysctl to control the misery mode
Date:   Fri, 14 Oct 2022 15:05:06 -0300
Message-Id: <20221014180506.211592-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b041b525dab9 ("x86/split_lock: Make life miserable for split lockers")
changed the way the split lock detector works when in "warn" mode;
basically, not only it shows the warn message, but also intentionally
introduces a slowdown (through sleeping plus serialization mechanism)
on such task. Based on discussions in [0], seems the warning alone
wasn't enough motivation for userspace developers to fix their
applications.

Happens that originally the proposal in [0] was to add a new mode
which would warns + slowdown the "split locking" task, keeping the
old warn mode untouched. In the end, that idea was discarded and
the regular/default "warn" mode now slowdowns the applications. This
is quite aggressive with regards proprietary/legacy programs that
basically are unable to properly run in kernel with this change.
While is understandable that a malicious application could try a DoS
by split locking, it seems unacceptable to regress old/proprietary
userspace programs through a default configuration that previously
worked. An example of such breakage was reported in [1].

So let's add a sysctl to allow controlling the "misery mode" behavior,
as per Thomas suggestion on [2]. This way, users running legacy and/or
proprietary software are allowed to still execute them with a decent
performance while still observe the warning messages on kernel log.

[0] https://lore.kernel.org/lkml/20220217012721.9694-1-tony.luck@intel.com/

[1] https://github.com/doitsujin/dxvk/issues/2938

[2] https://lore.kernel.org/lkml/87pmf4bter.ffs@tglx/

Fixes: b041b525dab9 ("x86/split_lock: Make life miserable for split lockers")
Cc: Andre Almeida <andrealmeid@igalia.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Joshua Ashton <joshua@froggi.es>
Cc: Melissa Wen <mwen@igalia.com>
Cc: Paul Gofman <pgofman@codeweavers.com>
Cc: Pavel Machek <pavel@denx.de>
Cc: Pierre-Loup Griffais <pgriffais@valvesoftware.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Zebediah Figura <zfigura@codeweavers.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---


V2:
- Switched to sysctl approach following Thomas' suggestion (thanks!).

Andre tested the patch and will comment in this thread - seems everything is
working as expected and we can enable/disable that, affecting the misery mode
as one expects.

I've tried to keep the semaphore's up()/down() calls in-sync/paired, hence
my approach of two delayed tasks, with and without misery.

Reviews / comments are greatly appreciated.
Thanks,


Guilherme


 Documentation/admin-guide/sysctl/kernel.rst | 18 ++++++
 arch/x86/kernel/cpu/intel.c                 | 61 +++++++++++++++++----
 2 files changed, 69 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index ee6572b1edad..508952e42914 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1298,6 +1298,24 @@ watchdog work to be queued by the watchdog timer function, otherwise the NMI
 watchdog — if enabled — can detect a hard lockup condition.
 
 
+split_lock_mitigate (x86 only)
+=============
+
+For x86 CPUs supporting the split lock detection mechanism, this parameter
+allows the users to turn off what is called "the misery mode", which
+introduces intentional delay in userspace applications that split locks.
+The goal of the misery mode is to prevent using such unaligned access to
+DoS the system dropping the performance overall, but some of these split
+locking programs are legacy and/or proprietary software that cannot be fixed,
+so using this sysctl is a way to allow them to run with a decent performance.
+
+= ===================================================================
+0 Disables the misery mode - just warns the split lock on kernel log.
+1 Enables the misery mode (this is the default) - penalizes the split
+  lockers with intentional performance degradation.
+= ===================================================================
+
+
 stack_erasing
 =============
 
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 2d7ea5480ec3..2aacf9d6c723 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1034,8 +1034,32 @@ static const struct {
 
 static struct ratelimit_state bld_ratelimit;
 
+static unsigned int sysctl_sld_mitigate = 1;
 static DEFINE_SEMAPHORE(buslock_sem);
 
+#ifdef CONFIG_PROC_SYSCTL
+static struct ctl_table sld_sysctls[] = {
+	{
+		.procname       = "split_lock_mitigate",
+		.data           = &sysctl_sld_mitigate,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler	= proc_douintvec_minmax,
+		.extra1         = SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE,
+	},
+	{}
+};
+
+static int __init sld_mitigate_sysctl_init(void)
+{
+	register_sysctl_init("kernel", sld_sysctls);
+	return 0;
+}
+
+late_initcall(sld_mitigate_sysctl_init);
+#endif
+
 static inline bool match_option(const char *arg, int arglen, const char *opt)
 {
 	int len = strlen(opt), ratelimit;
@@ -1146,11 +1170,18 @@ static void split_lock_init(void)
 		split_lock_verify_msr(sld_state != sld_off);
 }
 
-static void __split_lock_reenable(struct work_struct *work)
+static void __split_lock_reenable_sem(struct work_struct *work)
 {
 	sld_update_msr(true);
 	up(&buslock_sem);
 }
+static DECLARE_DELAYED_WORK(split_lock_reenable_sem, __split_lock_reenable_sem);
+
+static void __split_lock_reenable(struct work_struct *work)
+{
+	sld_update_msr(true);
+}
+static DECLARE_DELAYED_WORK(split_lock_reenable, __split_lock_reenable);
 
 /*
  * If a CPU goes offline with pending delayed work to re-enable split lock
@@ -1169,10 +1200,9 @@ static int splitlock_cpu_offline(unsigned int cpu)
 	return 0;
 }
 
-static DECLARE_DELAYED_WORK(split_lock_reenable, __split_lock_reenable);
-
 static void split_lock_warn(unsigned long ip)
 {
+	struct delayed_work *wk;
 	int cpu;
 
 	if (!current->reported_split_lock)
@@ -1180,14 +1210,25 @@ static void split_lock_warn(unsigned long ip)
 				    current->comm, current->pid, ip);
 	current->reported_split_lock = 1;
 
-	/* misery factor #1, sleep 10ms before trying to execute split lock */
-	if (msleep_interruptible(10) > 0)
-		return;
-	/* Misery factor #2, only allow one buslocked disabled core at a time */
-	if (down_interruptible(&buslock_sem) == -EINTR)
-		return;
+	if (sysctl_sld_mitigate) {
+		/*
+		 * misery factor #1:
+		 * sleep 10ms before trying to execute split lock.
+		 */
+		if (msleep_interruptible(10) > 0)
+			return;
+		/*
+		 * Misery factor #2:
+		 * only allow one buslocked disabled core at a time.
+		 */
+		wk = &split_lock_reenable_sem;
+		if (down_interruptible(&buslock_sem) == -EINTR)
+			return;
+	} else
+		wk = &split_lock_reenable;
+
 	cpu = get_cpu();
-	schedule_delayed_work_on(cpu, &split_lock_reenable, 2);
+	schedule_delayed_work_on(cpu, wk, 2);
 
 	/* Disable split lock detection on this CPU to make progress */
 	sld_update_msr(false);
-- 
2.38.0

