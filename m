Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC05A5EDEAA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbiI1OV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbiI1OV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:21:57 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0426BD5C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 07:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=XEvER4Dj6WAB2dWKvMnit1Pc1koMKVwqLnQPNIQlq1E=; b=QHXtp3SAQIV83sIxU+KzGYIDOK
        PIiXrbm46TvIqUQ3OP3ppjtNfU936P9IWwesk92ahiSCc/6zCINWGV9+vt2049UlUN+2pFby3R+JF
        xalWEauJWP7rCN4wXTx/cIEjRsifhbkbwMVA8dXBcvv84+29dLy7kyWDtIzUOCagt7mjRrdKniTAu
        Qc3+rHMVuoZG+g7Gy59m0sQzwYFQNzs39VysOplKqZIszRbBLXyvtCAg4fxZptfZxzrq/Db/i4fBq
        tWBgbkJItUWNG7hQFFcUHKUt34QDjx7OIYYQ5wchN6vVGvEiyOGQPUnrs9TYhL2xIG1WlxEzSp25M
        qF7SlZXA==;
Received: from [179.232.144.59] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1odXwI-00Entz-WE; Wed, 28 Sep 2022 16:21:31 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     tony.luck@intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, luto@kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Joshua Ashton <joshua@froggi.es>,
        Paul Gofman <pgofman@codeweavers.com>,
        Pavel Machek <pavel@denx.de>,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
        Melissa Wen <mwen@igalia.com>
Subject: [PATCH] x86/split_lock: Restore warn mode (and add a new one) to avoid userspace regression
Date:   Wed, 28 Sep 2022 11:21:09 -0300
Message-Id: <20220928142109.150263-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
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
While it is understandable that a malicious application could try
a DoS by split locking, it seems unacceptable to regress old/proprietary
userspace programs through a default configuration that previously
worked. An example of such breakage was reported in [1].

So let's revamp the idea of having another option/mode for the split
lock detector, which is hereby called "seq" (based on the original
"sequential" naming in [0]). Also introduces a Kconfig option to give
the option of Linux vendors have a choice what mode should be their
default. While at it, fix/improve the documentation about bus locking.

[0] https://lore.kernel.org/lkml/20220217012721.9694-1-tony.luck@intel.com/

[1] https://github.com/doitsujin/dxvk/issues/2938

Fixes: b041b525dab9 ("x86/split_lock: Make life miserable for split lockers")
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Joshua Ashton <joshua@froggi.es>
Cc: Paul Gofman <pgofman@codeweavers.com>
Cc: Pavel Machek <pavel@denx.de>
Cc: Pierre-Loup Griffais <pgriffais@valvesoftware.com>
Cc: Tony Luck <tony.luck@intel.com>
Tested-by: Melissa Wen <mwen@igalia.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---


Hi Tony / Thomas, it was reported that some games cannot run anymore
due to the split lock detector change (as you can see above, in [1]).

This really "flirts" with userspace breakage / policy enforcement
from the kernel - I agree with the DoS point, but changing it to
have a new default behavior preventing the execution of these
applications with enough performance seems quite a hammer.

The proposal here is to get back to the old idea from Tony, having
another mode for the split lock detector, and a Kconfig to allow
distros choose the policy they wanna take by default. I've set
default in kernel to be the harmless old "warn" mode, we could
discuss of course what should be kernel default. But I think it's
important to give at least the choice for the distros that don't
want to opt-in this aggressive behavior.

Reviews / comments are very appreciated as usual!
Thanks in advance,

Guilherme


 .../admin-guide/kernel-parameters.txt         | 11 ++++++-
 Documentation/x86/buslock.rst                 | 19 +++++++++++
 arch/x86/Kconfig                              | 10 ++++++
 arch/x86/kernel/cpu/intel.c                   | 33 +++++++++++++------
 4 files changed, 62 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 426fa892d311..a00113629f8f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5790,7 +5790,9 @@
 			instructions that access data across cache line
 			boundaries will result in an alignment check exception
 			for split lock detection or a debug exception for
-			bus lock detection.
+			bus lock detection. The default is set by the kernel
+			config X86_SPLIT_LOCK_MODE; defconfig sets it to warn.
+
 
 			off	- not enabled
 
@@ -5802,6 +5804,13 @@
 				  behavior is by #AC if both features are
 				  enabled in hardware.
 
+			seq	- kernel will emit the same rate-limited warns
+				  than the "warn" mode, but will also introduce
+				  an intentional delay (through serialization
+				  and a small sleeping) in such processes, in
+				  order to call the attention of users/devs to
+				  properly fix their applications.
+
 			fatal	- the kernel will send SIGBUS to applications
 				  that trigger the #AC exception or the #DB
 				  exception. Default behavior is by #AC if
diff --git a/Documentation/x86/buslock.rst b/Documentation/x86/buslock.rst
index 7c051e714943..f3cf353d2028 100644
--- a/Documentation/x86/buslock.rst
+++ b/Documentation/x86/buslock.rst
@@ -58,6 +58,17 @@ parameter "split_lock_detect". Here is a summary of different options:
 |		   |When both features are	|			|
 |		   |supported, warn in #AC	|			|
 +------------------+----------------------------+-----------------------+
+|seq		   |Kernel OOPs			|Warn once per task and |
+|		   |Same output as the "warn"	|and continues to run.  |
+|		   |option above, but also	|			|
+|		   |intentionally introduce a	|			|
+|		   |delay by serializing and	|			|
+|		   |quickly sleeping - this	|			|
+|		   |greatly affects application	|			|
+|		   |performance but may improve	|			|
+|		   |overall system perf in the	|			|
+|		   |case of many split locks.	|			|
++------------------+----------------------------+-----------------------+
 |fatal		   |Kernel OOPs			|Send SIGBUS to user.	|
 |		   |Send SIGBUS to user		|			|
 |		   |When both features are	|			|
@@ -103,6 +114,14 @@ warn
 A warning is emitted when a bus lock is detected which allows to identify
 the offending application. This is the default behavior.
 
+seq
+----
+
+A warning is emitted when a bus lock is detected which allows to identify
+the offending application, but also introduces a delay by serializing and
+quickly sleeping - this greatly affects application performance but might
+improve overall system performance in case of many unligned accesses.
+
 fatal
 -----
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f9920f1341c8..e44779756461 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -398,6 +398,16 @@ config CC_HAS_SANE_STACKPROTECTOR
 	  the compiler produces broken code or if it does not let us control
 	  the segment on 32-bit kernels.
 
+config X86_SPLIT_LOCK_MODE
+	int "Default mode of split lock detector for supporting CPUs (0/off - 3/fatal)"
+	range 0 3
+	default 1
+	help
+	  Select the default mode for split lock detector on supporting CPUs.
+	  Possible modes are: 0 ("off"), 1 ("warn"), 2 ("seq") and 3 ("fatal");
+	  details are well described in the kernel parameters documentation.
+	  Users can always override this using the cmdline "split_lock_detect=".
+
 menu "Processor type and features"
 
 config SMP
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 2d7ea5480ec3..9f6157afbb56 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -44,6 +44,7 @@
 enum split_lock_detect_state {
 	sld_off = 0,
 	sld_warn,
+	sld_seq,
 	sld_fatal,
 	sld_ratelimit,
 };
@@ -1028,6 +1029,7 @@ static const struct {
 } sld_options[] __initconst = {
 	{ "off",	sld_off   },
 	{ "warn",	sld_warn  },
+	{ "seq",	sld_seq	},
 	{ "fatal",	sld_fatal },
 	{ "ratelimit:", sld_ratelimit },
 };
@@ -1075,7 +1077,7 @@ static bool split_lock_verify_msr(bool on)
 
 static void __init sld_state_setup(void)
 {
-	enum split_lock_detect_state state = sld_warn;
+	enum split_lock_detect_state state = CONFIG_X86_SPLIT_LOCK_MODE;
 	char arg[20];
 	int i, ret;
 
@@ -1149,7 +1151,9 @@ static void split_lock_init(void)
 static void __split_lock_reenable(struct work_struct *work)
 {
 	sld_update_msr(true);
-	up(&buslock_sem);
+
+	if (sld_state == sld_seq)
+		up(&buslock_sem);
 }
 
 /*
@@ -1180,12 +1184,15 @@ static void split_lock_warn(unsigned long ip)
 				    current->comm, current->pid, ip);
 	current->reported_split_lock = 1;
 
-	/* misery factor #1, sleep 10ms before trying to execute split lock */
-	if (msleep_interruptible(10) > 0)
-		return;
-	/* Misery factor #2, only allow one buslocked disabled core at a time */
-	if (down_interruptible(&buslock_sem) == -EINTR)
-		return;
+	if (sld_state == sld_seq) {
+		/* misery factor #1, sleep 10ms before trying to execute split lock */
+		if (msleep_interruptible(10) > 0)
+			return;
+		/* Misery factor #2, only allow one buslocked disabled core at a time */
+		if (down_interruptible(&buslock_sem) == -EINTR)
+			return;
+	}
+
 	cpu = get_cpu();
 	schedule_delayed_work_on(cpu, &split_lock_reenable, 2);
 
@@ -1196,7 +1203,7 @@ static void split_lock_warn(unsigned long ip)
 
 bool handle_guest_split_lock(unsigned long ip)
 {
-	if (sld_state == sld_warn) {
+	if (sld_state == sld_warn || sld_state == sld_seq) {
 		split_lock_warn(ip);
 		return true;
 	}
@@ -1256,6 +1263,7 @@ void handle_bus_lock(struct pt_regs *regs)
 		/* Warn on the bus lock. */
 		fallthrough;
 	case sld_warn:
+	case sld_seq:
 		pr_warn_ratelimited("#DB: %s/%d took a bus_lock trap at address: 0x%lx\n",
 				    current->comm, current->pid, regs->ip);
 		break;
@@ -1335,8 +1343,13 @@ static void sld_state_show(void)
 		pr_info("disabled\n");
 		break;
 	case sld_warn:
+	case sld_seq:
 		if (boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT)) {
-			pr_info("#AC: crashing the kernel on kernel split_locks and warning on user-space split_locks\n");
+			if (sld_state == sld_warn)
+				pr_info("#AC: crashing the kernel on kernel split_locks and warning on user-space split_locks\n");
+			else
+				pr_info("#AC: crashing the kernel on kernel split_locks and intentionally slowdown the task on user-space split_locks\n");
+
 			if (cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 					      "x86/splitlock", NULL, splitlock_cpu_offline) < 0)
 				pr_warn("No splitlock CPU offline handler\n");
-- 
2.37.3

