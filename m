Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870D960BC85
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 23:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiJXVvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 17:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiJXVvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:51:36 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F136DED0E;
        Mon, 24 Oct 2022 13:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=qzoRiBxsD+qzFWYFum3VpbABI9ghvm/TlfdcFLi9wIE=; b=XgLmtQFEMuH4e5ywrLhakYcA+R
        lhXWQKueSu0SjOkoyeNjsyfxNKngfjsVqxJteFN+nyuVn9VpGvHB7v9+KM5QE7j0GCFM8dt3nRFzE
        nA8sPxhlIY2Coc4Ps66zewhg5QiWV0txxO0I83fbCjpJ21WJWSjVFmydXkXAts5weVEGGUk7dm4ac
        nRjqtO6kJ07oKi6QvFnkTr8CGzbXdASpASG1qaEBlALecWZBRQZcsz7FCLMy5zgoGcweDRIPEVgyp
        lOnbvBCTDf6Hoe+iy0ycEU74ZbCWcoiZa7sfKHKg3EOG+gAKXZj0xxkTm8Y4ZxOgTU3yDHCKo1pcJ
        obT2NTFA==;
Received: from [177.95.16.195] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1on3fC-004pcT-3U; Mon, 24 Oct 2022 22:03:10 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org, bagasdotme@gmail.com,
        kernel-dev@igalia.com, kernel@gpiccoli.net,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Joshua Ashton <joshua@froggi.es>,
        Melissa Wen <mwen@igalia.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Pavel Machek <pavel@denx.de>,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
        Tony Luck <tony.luck@intel.com>,
        Zebediah Figura <zfigura@codeweavers.com>,
        Andre Almeida <andrealmeid@igalia.com>
Subject: [PATCH V3] x86/split_lock: Add sysctl to control the misery mode
Date:   Mon, 24 Oct 2022 17:02:54 -0300
Message-Id: <20221024200254.635256-1-gpiccoli@igalia.com>
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
While it is understandable that a malicious application could DoS
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
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Joshua Ashton <joshua@froggi.es>
Cc: Melissa Wen <mwen@igalia.com>
Cc: Paul Gofman <pgofman@codeweavers.com>
Cc: Pavel Machek <pavel@denx.de>
Cc: Pierre-Loup Griffais <pgriffais@valvesoftware.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Zebediah Figura <zfigura@codeweavers.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Andre Almeida <andrealmeid@igalia.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---


V3:
- Reworked with the suggestions from Bagas and Dave - thanks!
- Rebased to v6.1-rc2.

Dave, in the end I kept the 2 delayed workers, seems easier than
encompass the worker in a new struct and have a bool embedded there
(we can't use data directly in the work struct, since it keeps the
workqueue state). Lemme know if you (or others) really prefer the
other approach and I can rework if required.

Thanks again for comments/reviews!
Cheers,

Guilherme


 Documentation/admin-guide/sysctl/kernel.rst | 23 ++++++++
 arch/x86/kernel/cpu/intel.c                 | 63 +++++++++++++++++----
 2 files changed, 76 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 98d1b198b2b4..c2c64c1b706f 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1314,6 +1314,29 @@ watchdog work to be queued by the watchdog timer function, otherwise the NMI
 watchdog — if enabled — can detect a hard lockup condition.
 
 
+split_lock_mitigate (x86 only)
+==============================
+
+On x86, each "split lock" imposes a system-wide performance penalty. On larger
+systems, large numbers of split locks from unprivileged users can result in
+denials of service to well-behaved and potentially more important users.
+
+The kernel mitigates these bad users by detecting split locks and imposing
+penalties: forcing them to wait and only allowing one core to execute split
+locks at a time.
+
+These mitigations can make those bad applications unbearably slow. Setting
+split_lock_mitigate=0 may restore some application performance, but will also
+increase system exposure to denial of service attacks from split lock users.
+
+= ===================================================================
+0 Disable the mitigation mode - just warns the split lock on kernel log
+  and exposes the system to denials of service from the split lockers.
+1 Enable the mitigation mode (this is the default) - penalizes the split
+  lockers with intentional performance degradation.
+= ===================================================================
+
+
 stack_erasing
 =============
 
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 2d7ea5480ec3..427899650483 100644
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
@@ -1146,12 +1170,20 @@ static void split_lock_init(void)
 		split_lock_verify_msr(sld_state != sld_off);
 }
 
-static void __split_lock_reenable(struct work_struct *work)
+static void __split_lock_reenable_unlock(struct work_struct *work)
 {
 	sld_update_msr(true);
 	up(&buslock_sem);
 }
 
+static DECLARE_DELAYED_WORK(sl_reenable_unlock, __split_lock_reenable_unlock);
+
+static void __split_lock_reenable(struct work_struct *work)
+{
+	sld_update_msr(true);
+}
+static DECLARE_DELAYED_WORK(sl_reenable, __split_lock_reenable);
+
 /*
  * If a CPU goes offline with pending delayed work to re-enable split lock
  * detection then the delayed work will be executed on some other CPU. That
@@ -1169,10 +1201,9 @@ static int splitlock_cpu_offline(unsigned int cpu)
 	return 0;
 }
 
-static DECLARE_DELAYED_WORK(split_lock_reenable, __split_lock_reenable);
-
 static void split_lock_warn(unsigned long ip)
 {
+	struct delayed_work *work;
 	int cpu;
 
 	if (!current->reported_split_lock)
@@ -1180,14 +1211,26 @@ static void split_lock_warn(unsigned long ip)
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
+		if (down_interruptible(&buslock_sem) == -EINTR)
+			return;
+		work = &sl_reenable_unlock;
+	} else {
+		work = &sl_reenable;
+	}
+
 	cpu = get_cpu();
-	schedule_delayed_work_on(cpu, &split_lock_reenable, 2);
+	schedule_delayed_work_on(cpu, work, 2);
 
 	/* Disable split lock detection on this CPU to make progress */
 	sld_update_msr(false);
-- 
2.38.0

