Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38746249C4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiKJSnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiKJSnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:43:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DB219C0B;
        Thu, 10 Nov 2022 10:43:15 -0800 (PST)
Date:   Thu, 10 Nov 2022 18:43:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668105792;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=CN0QjurQxBCq6swfpq+Ep2vruZmfeCLtpDjqNO7tzvU=;
        b=N2plv8MdjhRY5UboBC6aT5sTlZJMSgt43ytSsWxVFvZ3fh/secfNRRKVzcJjBiJfuoRh7g
        nKOvvJem7vBknyNMifHcgZf1BPCMEi2EX9Ew0szPv2as4//bxY/AwjjZ6HSSDpzDS3PG1y
        PdAhmoDtaaY5rEH0Vio56n5FM8+rRiT6KgfGBLf7wDq29vp8ZPvcsO3OOt/tvltywbDuHW
        iOEx6RWFD4cAEbP5AcwRcN4rMIouUjcqf06ynRWUMIakEZhfykx/IGV3bEsQ7/JHgJuStK
        Pss8IcxKKMvqGLhcei4ujTZNcNLk3ovwy3Cc/eurFwnsVggzkBcRJIZq6r8l+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668105792;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=CN0QjurQxBCq6swfpq+Ep2vruZmfeCLtpDjqNO7tzvU=;
        b=FQ8eP9iVPVxuiPOEoRzZ1d8qQeXohrHpkdGb5teMVOG9LO85aayDz4BdwjXlR7JIXZ2SBb
        TkE53Ii8eFBSP/CQ==
From:   "tip-bot2 for Guilherme G. Piccoli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/splitlock] x86/split_lock: Add sysctl to control the misery mode
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andre Almeida <andrealmeid@igalia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166810579123.4906.13523276753053282918.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/splitlock branch of tip:

Commit-ID:     727209376f4998bc84db1d5d8af15afea846a92b
Gitweb:        https://git.kernel.org/tip/727209376f4998bc84db1d5d8af15afea84=
6a92b
Author:        Guilherme G. Piccoli <gpiccoli@igalia.com>
AuthorDate:    Mon, 24 Oct 2022 17:02:54 -03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 10 Nov 2022 10:14:22 -08:00

x86/split_lock: Add sysctl to control the misery mode

Commit b041b525dab9 ("x86/split_lock: Make life miserable for split lockers")
changed the way the split lock detector works when in "warn" mode;
basically, it not only shows the warn message, but also intentionally
introduces a slowdown through sleeping plus serialization mechanism
on such task. Based on discussions in [0], seems the warning alone
wasn't enough motivation for userspace developers to fix their
applications.

This slowdown is enough to totally break some proprietary (aka.
unfixable) userspace[1].

Happens that originally the proposal in [0] was to add a new mode
which would warns + slowdown the "split locking" task, keeping the
old warn mode untouched. In the end, that idea was discarded and
the regular/default "warn" mode now slows down the applications. This
is quite aggressive with regards proprietary/legacy programs that
basically are unable to properly run in kernel with this change.
While it is understandable that a malicious application could DoS
by split locking, it seems unacceptable to regress old/proprietary
userspace programs through a default configuration that previously
worked. An example of such breakage was reported in [1].

Add a sysctl to allow controlling the "misery mode" behavior, as per
Thomas suggestion on [2]. This way, users running legacy and/or
proprietary software are allowed to still execute them with a decent
performance while still observing the warning messages on kernel log.

[0] https://lore.kernel.org/lkml/20220217012721.9694-1-tony.luck@intel.com/
[1] https://github.com/doitsujin/dxvk/issues/2938
[2] https://lore.kernel.org/lkml/87pmf4bter.ffs@tglx/

[ dhansen: minor changelog tweaks, including clarifying the actual
  	   problem ]

Fixes: b041b525dab9 ("x86/split_lock: Make life miserable for split lockers")
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Andre Almeida <andrealmeid@igalia.com>
Link: https://lore.kernel.org/all/20221024200254.635256-1-gpiccoli%40igalia.c=
om
---
 Documentation/admin-guide/sysctl/kernel.rst | 23 +++++++-
 arch/x86/kernel/cpu/intel.c                 | 63 ++++++++++++++++----
 2 files changed, 76 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admi=
n-guide/sysctl/kernel.rst
index 98d1b19..c2c64c1 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1314,6 +1314,29 @@ watchdog work to be queued by the watchdog timer funct=
ion, otherwise the NMI
 watchdog =E2=80=94 if enabled =E2=80=94 can detect a hard lockup condition.
=20
=20
+split_lock_mitigate (x86 only)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
+
+On x86, each "split lock" imposes a system-wide performance penalty. On larg=
er
+systems, large numbers of split locks from unprivileged users can result in
+denials of service to well-behaved and potentially more important users.
+
+The kernel mitigates these bad users by detecting split locks and imposing
+penalties: forcing them to wait and only allowing one core to execute split
+locks at a time.
+
+These mitigations can make those bad applications unbearably slow. Setting
+split_lock_mitigate=3D0 may restore some application performance, but will a=
lso
+increase system exposure to denial of service attacks from split lock users.
+
+=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+0 Disable the mitigation mode - just warns the split lock on kernel log
+  and exposes the system to denials of service from the split lockers.
+1 Enable the mitigation mode (this is the default) - penalizes the split
+  lockers with intentional performance degradation.
+=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+
 stack_erasing
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 2d7ea54..4278996 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1034,8 +1034,32 @@ static const struct {
=20
 static struct ratelimit_state bld_ratelimit;
=20
+static unsigned int sysctl_sld_mitigate =3D 1;
 static DEFINE_SEMAPHORE(buslock_sem);
=20
+#ifdef CONFIG_PROC_SYSCTL
+static struct ctl_table sld_sysctls[] =3D {
+	{
+		.procname       =3D "split_lock_mitigate",
+		.data           =3D &sysctl_sld_mitigate,
+		.maxlen         =3D sizeof(unsigned int),
+		.mode           =3D 0644,
+		.proc_handler	=3D proc_douintvec_minmax,
+		.extra1         =3D SYSCTL_ZERO,
+		.extra2         =3D SYSCTL_ONE,
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
 	int len =3D strlen(opt), ratelimit;
@@ -1146,12 +1170,20 @@ static void split_lock_init(void)
 		split_lock_verify_msr(sld_state !=3D sld_off);
 }
=20
-static void __split_lock_reenable(struct work_struct *work)
+static void __split_lock_reenable_unlock(struct work_struct *work)
 {
 	sld_update_msr(true);
 	up(&buslock_sem);
 }
=20
+static DECLARE_DELAYED_WORK(sl_reenable_unlock, __split_lock_reenable_unlock=
);
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
=20
-static DECLARE_DELAYED_WORK(split_lock_reenable, __split_lock_reenable);
-
 static void split_lock_warn(unsigned long ip)
 {
+	struct delayed_work *work;
 	int cpu;
=20
 	if (!current->reported_split_lock)
@@ -1180,14 +1211,26 @@ static void split_lock_warn(unsigned long ip)
 				    current->comm, current->pid, ip);
 	current->reported_split_lock =3D 1;
=20
-	/* misery factor #1, sleep 10ms before trying to execute split lock */
-	if (msleep_interruptible(10) > 0)
-		return;
-	/* Misery factor #2, only allow one buslocked disabled core at a time */
-	if (down_interruptible(&buslock_sem) =3D=3D -EINTR)
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
+		if (down_interruptible(&buslock_sem) =3D=3D -EINTR)
+			return;
+		work =3D &sl_reenable_unlock;
+	} else {
+		work =3D &sl_reenable;
+	}
+
 	cpu =3D get_cpu();
-	schedule_delayed_work_on(cpu, &split_lock_reenable, 2);
+	schedule_delayed_work_on(cpu, work, 2);
=20
 	/* Disable split lock detection on this CPU to make progress */
 	sld_update_msr(false);
