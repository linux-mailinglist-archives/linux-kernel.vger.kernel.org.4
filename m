Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130F175014B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjGLIWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjGLIV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:21:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993AD420F;
        Wed, 12 Jul 2023 01:18:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B6F8616FD;
        Wed, 12 Jul 2023 08:18:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C566DC433C9;
        Wed, 12 Jul 2023 08:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689149903;
        bh=aPoElTgjGbSrd8e+m9++rB6wqYEsgyiFO1f3IrEJLOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vekh3P2DJbF1vAx4+/+h3UE5Op6AgqlZK+bi7K+AbyvmX1++OvWSqRj9dIaxqkKqt
         Wsz7lCu+A0276BBjlPsadfVJrKKws3P8y+AntJqKUbpOM3Ux+1n+p6gqP74kIojyvb
         YDkfaIuY7gVRpWBAHbf4A0kluifndW/d1IzhCWJqOlliw1hEMyNeG4Pv4cyacaIu/x
         DiQu9gAkaRWqhCwwkWiVDfSZ/WTnYlhj81XWQa/jFdLpecdeviCg7Uf+8d0aggzDo7
         6rsDG5G+qp/IHtk9o5qiYN7w2Qs6czld0MZ4KNaVWzZr2ZOjjgdOYqJCRdAMxiFuSF
         KzBptVXdt+Zyg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH 02/10] tty: sysrq: switch sysrq handlers from int to u8
Date:   Wed, 12 Jul 2023 10:18:03 +0200
Message-ID: <20230712081811.29004-3-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712081811.29004-1-jirislaby@kernel.org>
References: <20230712081811.29004-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The passed parameter to sysrq handlers is a key (a character). So change
the type from 'int' to 'u8'. Let it specifically be 'u8' for two
reasons:
* unsigned: unsigned values come from the upper layers (devices) and the
  tty layer assumes unsigned on most places, and
* 8-bit: as that what's supposed to be one day in all the layers built
  on the top of tty. (Currently, we use mostly 'unsigned char' and
  somewhere still only 'char'. (But that also translates to the former
  thanks to -funsigned-char.))

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Jason Wessel <jason.wessel@windriver.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Zqiang <qiang.zhang1211@gmail.com>
---
 arch/alpha/kernel/setup.c       |  2 +-
 arch/loongarch/kernel/sysrq.c   |  2 +-
 arch/mips/kernel/sysrq.c        |  2 +-
 arch/powerpc/xmon/xmon.c        |  2 +-
 arch/sparc/kernel/process_64.c  |  4 ++--
 drivers/gpu/drm/drm_fb_helper.c |  2 +-
 drivers/tty/sysrq.c             | 40 ++++++++++++++++-----------------
 include/linux/sysrq.h           |  2 +-
 kernel/debug/debug_core.c       |  2 +-
 kernel/power/poweroff.c         |  2 +-
 kernel/rcu/tree_stall.h         |  2 +-
 11 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index b650ff1cb022..91fb3714ebc2 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -422,7 +422,7 @@ register_cpus(void)
 arch_initcall(register_cpus);
 
 #ifdef CONFIG_MAGIC_SYSRQ
-static void sysrq_reboot_handler(int unused)
+static void sysrq_reboot_handler(u8 unused)
 {
 	machine_halt();
 }
diff --git a/arch/loongarch/kernel/sysrq.c b/arch/loongarch/kernel/sysrq.c
index 366baef72d29..e663c10fa39c 100644
--- a/arch/loongarch/kernel/sysrq.c
+++ b/arch/loongarch/kernel/sysrq.c
@@ -43,7 +43,7 @@ static void sysrq_tlbdump_othercpus(struct work_struct *dummy)
 static DECLARE_WORK(sysrq_tlbdump, sysrq_tlbdump_othercpus);
 #endif
 
-static void sysrq_handle_tlbdump(int key)
+static void sysrq_handle_tlbdump(u8 key)
 {
 	sysrq_tlbdump_single(NULL);
 #ifdef CONFIG_SMP
diff --git a/arch/mips/kernel/sysrq.c b/arch/mips/kernel/sysrq.c
index 9c1a2019113b..2e98049fe783 100644
--- a/arch/mips/kernel/sysrq.c
+++ b/arch/mips/kernel/sysrq.c
@@ -44,7 +44,7 @@ static void sysrq_tlbdump_othercpus(struct work_struct *dummy)
 static DECLARE_WORK(sysrq_tlbdump, sysrq_tlbdump_othercpus);
 #endif
 
-static void sysrq_handle_tlbdump(int key)
+static void sysrq_handle_tlbdump(u8 key)
 {
 	sysrq_tlbdump_single(NULL);
 #ifdef CONFIG_SMP
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index ee17270d35d0..3b6f524c790e 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -3991,7 +3991,7 @@ static void xmon_init(int enable)
 }
 
 #ifdef CONFIG_MAGIC_SYSRQ
-static void sysrq_handle_xmon(int key)
+static void sysrq_handle_xmon(u8 key)
 {
 	if (xmon_is_locked_down()) {
 		clear_all_bpt();
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index b51d8fb0ecdc..4dee88af403f 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -295,7 +295,7 @@ void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
 
 #ifdef CONFIG_MAGIC_SYSRQ
 
-static void sysrq_handle_globreg(int key)
+static void sysrq_handle_globreg(u8 key)
 {
 	trigger_all_cpu_backtrace();
 }
@@ -370,7 +370,7 @@ static void pmu_snapshot_all_cpus(void)
 	spin_unlock_irqrestore(&global_cpu_snapshot_lock, flags);
 }
 
-static void sysrq_handle_globpmu(int key)
+static void sysrq_handle_globpmu(u8 key)
 {
 	pmu_snapshot_all_cpus();
 }
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 61a5d450cc20..d612133e2cf7 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -301,7 +301,7 @@ static void drm_fb_helper_restore_work_fn(struct work_struct *ignored)
 
 static DECLARE_WORK(drm_fb_helper_restore_work, drm_fb_helper_restore_work_fn);
 
-static void drm_fb_helper_sysrq(int dummy1)
+static void drm_fb_helper_sysrq(u8 dummy1)
 {
 	schedule_work(&drm_fb_helper_restore_work);
 }
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 13465e4cca9b..1271a82c0887 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -98,7 +98,7 @@ static int __init sysrq_always_enabled_setup(char *str)
 __setup("sysrq_always_enabled", sysrq_always_enabled_setup);
 
 
-static void sysrq_handle_loglevel(int key)
+static void sysrq_handle_loglevel(u8 key)
 {
 	u8 loglevel = key - '0';
 
@@ -114,7 +114,7 @@ static const struct sysrq_key_op sysrq_loglevel_op = {
 };
 
 #ifdef CONFIG_VT
-static void sysrq_handle_SAK(int key)
+static void sysrq_handle_SAK(u8 key)
 {
 	struct work_struct *SAK_work = &vc_cons[fg_console].SAK_work;
 
@@ -131,7 +131,7 @@ static const struct sysrq_key_op sysrq_SAK_op = {
 #endif
 
 #ifdef CONFIG_VT
-static void sysrq_handle_unraw(int key)
+static void sysrq_handle_unraw(u8 key)
 {
 	vt_reset_unicode(fg_console);
 }
@@ -146,7 +146,7 @@ static const struct sysrq_key_op sysrq_unraw_op = {
 #define sysrq_unraw_op (*(const struct sysrq_key_op *)NULL)
 #endif /* CONFIG_VT */
 
-static void sysrq_handle_crash(int key)
+static void sysrq_handle_crash(u8 key)
 {
 	/* release the RCU read lock before crashing */
 	rcu_read_unlock();
@@ -160,7 +160,7 @@ static const struct sysrq_key_op sysrq_crash_op = {
 	.enable_mask	= SYSRQ_ENABLE_DUMP,
 };
 
-static void sysrq_handle_reboot(int key)
+static void sysrq_handle_reboot(u8 key)
 {
 	lockdep_off();
 	local_irq_enable();
@@ -175,7 +175,7 @@ static const struct sysrq_key_op sysrq_reboot_op = {
 
 const struct sysrq_key_op *__sysrq_reboot_op = &sysrq_reboot_op;
 
-static void sysrq_handle_sync(int key)
+static void sysrq_handle_sync(u8 key)
 {
 	emergency_sync();
 }
@@ -186,7 +186,7 @@ static const struct sysrq_key_op sysrq_sync_op = {
 	.enable_mask	= SYSRQ_ENABLE_SYNC,
 };
 
-static void sysrq_handle_show_timers(int key)
+static void sysrq_handle_show_timers(u8 key)
 {
 	sysrq_timer_list_show();
 }
@@ -197,7 +197,7 @@ static const struct sysrq_key_op sysrq_show_timers_op = {
 	.action_msg	= "Show clockevent devices & pending hrtimers (no others)",
 };
 
-static void sysrq_handle_mountro(int key)
+static void sysrq_handle_mountro(u8 key)
 {
 	emergency_remount();
 }
@@ -209,7 +209,7 @@ static const struct sysrq_key_op sysrq_mountro_op = {
 };
 
 #ifdef CONFIG_LOCKDEP
-static void sysrq_handle_showlocks(int key)
+static void sysrq_handle_showlocks(u8 key)
 {
 	debug_show_all_locks();
 }
@@ -249,7 +249,7 @@ static void sysrq_showregs_othercpus(struct work_struct *dummy)
 
 static DECLARE_WORK(sysrq_showallcpus, sysrq_showregs_othercpus);
 
-static void sysrq_handle_showallcpus(int key)
+static void sysrq_handle_showallcpus(u8 key)
 {
 	/*
 	 * Fall back to the workqueue based printing if the
@@ -282,7 +282,7 @@ static const struct sysrq_key_op sysrq_showallcpus_op = {
 #define sysrq_showallcpus_op (*(const struct sysrq_key_op *)NULL)
 #endif
 
-static void sysrq_handle_showregs(int key)
+static void sysrq_handle_showregs(u8 key)
 {
 	struct pt_regs *regs = NULL;
 
@@ -299,7 +299,7 @@ static const struct sysrq_key_op sysrq_showregs_op = {
 	.enable_mask	= SYSRQ_ENABLE_DUMP,
 };
 
-static void sysrq_handle_showstate(int key)
+static void sysrq_handle_showstate(u8 key)
 {
 	show_state();
 	show_all_workqueues();
@@ -311,7 +311,7 @@ static const struct sysrq_key_op sysrq_showstate_op = {
 	.enable_mask	= SYSRQ_ENABLE_DUMP,
 };
 
-static void sysrq_handle_showstate_blocked(int key)
+static void sysrq_handle_showstate_blocked(u8 key)
 {
 	show_state_filter(TASK_UNINTERRUPTIBLE);
 }
@@ -325,7 +325,7 @@ static const struct sysrq_key_op sysrq_showstate_blocked_op = {
 #ifdef CONFIG_TRACING
 #include <linux/ftrace.h>
 
-static void sysrq_ftrace_dump(int key)
+static void sysrq_ftrace_dump(u8 key)
 {
 	ftrace_dump(DUMP_ALL);
 }
@@ -339,7 +339,7 @@ static const struct sysrq_key_op sysrq_ftrace_dump_op = {
 #define sysrq_ftrace_dump_op (*(const struct sysrq_key_op *)NULL)
 #endif
 
-static void sysrq_handle_showmem(int key)
+static void sysrq_handle_showmem(u8 key)
 {
 	show_mem();
 }
@@ -369,7 +369,7 @@ static void send_sig_all(int sig)
 	read_unlock(&tasklist_lock);
 }
 
-static void sysrq_handle_term(int key)
+static void sysrq_handle_term(u8 key)
 {
 	send_sig_all(SIGTERM);
 	console_loglevel = CONSOLE_LOGLEVEL_DEBUG;
@@ -400,7 +400,7 @@ static void moom_callback(struct work_struct *ignored)
 
 static DECLARE_WORK(moom_work, moom_callback);
 
-static void sysrq_handle_moom(int key)
+static void sysrq_handle_moom(u8 key)
 {
 	schedule_work(&moom_work);
 }
@@ -412,7 +412,7 @@ static const struct sysrq_key_op sysrq_moom_op = {
 };
 
 #ifdef CONFIG_BLOCK
-static void sysrq_handle_thaw(int key)
+static void sysrq_handle_thaw(u8 key)
 {
 	emergency_thaw_all();
 }
@@ -426,7 +426,7 @@ static const struct sysrq_key_op sysrq_thaw_op = {
 #define sysrq_thaw_op (*(const struct sysrq_key_op *)NULL)
 #endif
 
-static void sysrq_handle_kill(int key)
+static void sysrq_handle_kill(u8 key)
 {
 	send_sig_all(SIGKILL);
 	console_loglevel = CONSOLE_LOGLEVEL_DEBUG;
@@ -438,7 +438,7 @@ static const struct sysrq_key_op sysrq_kill_op = {
 	.enable_mask	= SYSRQ_ENABLE_SIGNAL,
 };
 
-static void sysrq_handle_unrt(int key)
+static void sysrq_handle_unrt(u8 key)
 {
 	normalize_rt_tasks();
 }
diff --git a/include/linux/sysrq.h b/include/linux/sysrq.h
index 3a582ec7a2f1..bb8d07814b0e 100644
--- a/include/linux/sysrq.h
+++ b/include/linux/sysrq.h
@@ -30,7 +30,7 @@
 #define SYSRQ_ENABLE_RTNICE	0x0100
 
 struct sysrq_key_op {
-	void (* const handler)(int);
+	void (* const handler)(u8);
 	const char * const help_msg;
 	const char * const action_msg;
 	const int enable_mask;
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index d5e9ccde3ab8..621037a0aa87 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -968,7 +968,7 @@ static int __init opt_kgdb_con(char *str)
 early_param("kgdbcon", opt_kgdb_con);
 
 #ifdef CONFIG_MAGIC_SYSRQ
-static void sysrq_handle_dbg(int key)
+static void sysrq_handle_dbg(u8 key)
 {
 	if (!dbg_io_ops) {
 		pr_crit("ERROR: No KGDB I/O module available\n");
diff --git a/kernel/power/poweroff.c b/kernel/power/poweroff.c
index 562aa0e450ed..1f306f158696 100644
--- a/kernel/power/poweroff.c
+++ b/kernel/power/poweroff.c
@@ -23,7 +23,7 @@ static void do_poweroff(struct work_struct *dummy)
 
 static DECLARE_WORK(poweroff_work, do_poweroff);
 
-static void handle_poweroff(int key)
+static void handle_poweroff(u8 key)
 {
 	/* run sysrq poweroff on boot cpu */
 	schedule_work_on(cpumask_first(cpu_online_mask), &poweroff_work);
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index b10b8349bb2a..6f06dc12904a 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -1035,7 +1035,7 @@ static bool sysrq_rcu;
 module_param(sysrq_rcu, bool, 0444);
 
 /* Dump grace-period-request information due to commandeered sysrq. */
-static void sysrq_show_rcu(int key)
+static void sysrq_show_rcu(u8 key)
 {
 	show_rcu_gp_kthreads();
 }
-- 
2.41.0

