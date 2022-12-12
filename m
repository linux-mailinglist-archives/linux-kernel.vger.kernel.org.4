Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FA9649BB2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 11:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbiLLKJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 05:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbiLLKJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 05:09:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9715A1A1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:09:04 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670839743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Oev/oZEXAEmZ441vqy0P/QF8AOAgVoGYcZ8P0z9Ldl8=;
        b=YKQzzjOI2k3oFS+V7ZnAjqSOvyJ/ycx0vRIX2naFgnRqs3iNhxeHKBwwN/b+K/UVNfEWm1
        LHkwnpX0jTZuH4srM4cS1HOI1JbSYncnY2DzGpTbo7jFGu1jPzwuZqSwLIOIjsUDRWjrbc
        6QgKi69pVnvI8w84f7A16909q/kUXTnYhYwYvJfaClp3aUwYJgIMNMv0w2C6JivOUKDGIQ
        THl4allguMiOZxgyEPIQnp2OLXrUvKzr8pleL29QxhlqV8her7c8H9jztQH6oOFXyyZqsN
        hnagi6Pv6zRsHLPXY0NX10ys5pgrW9azoD0pFLv61De61OXslHKzMrcLMhjqdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670839743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Oev/oZEXAEmZ441vqy0P/QF8AOAgVoGYcZ8P0z9Ldl8=;
        b=oy0gzo3D5944cV6c24nDVttY6yZ+bPZrlE0f5Y4lsGrIiOI3W7kMztnewqLAzYU0cglTdT
        VTRXlcEt6iKLQoDA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] smp/core for v6.2-rc1
References: <167083907785.564878.11381307641454805335.tglx@xen13.tec.linutronix.de>
Message-ID: <167083908161.564878.1790621826078402593.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 12 Dec 2022 11:09:02 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest smp/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2022-12=
-10

up to:  6f855b39e460: cpu/hotplug: Do not bail-out in DYING/STARTING sections

A small set of updates for CPU hotplug:

  - Prevent stale CPU hotplug state in the cpu_down() path which
    was detected by stress testing the sysfs interface

  - Ensure that the target CPU hotplug state for the boot CPU is
    CPUHP_ONLINE instead of the compile time init value CPUHP_OFFLINE.

  - Switch back to the original behaviour of warning when a CPU hotplug
    callback in the DYING/STARTING section returns an error code. Otherwise
    a buggy callback can leave the CPUs in an non recoverable state.

Thanks,

	tglx

------------------>
Phil Auld (2):
      cpu/hotplug: Make target_store() a nop when target =3D=3D state
      cpu/hotplug: Set cpuhp target for boot cpu

Vincent Donnefort (1):
      cpu/hotplug: Do not bail-out in DYING/STARTING sections


 kernel/cpu.c | 61 +++++++++++++++++++++++++++++++++++++++++++---------------=
--
 1 file changed, 44 insertions(+), 17 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index bbad5e375d3b..6c0a92ca6bb5 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -663,21 +663,51 @@ static bool cpuhp_next_state(bool bringup,
 	return true;
 }
=20
-static int cpuhp_invoke_callback_range(bool bringup,
-				       unsigned int cpu,
-				       struct cpuhp_cpu_state *st,
-				       enum cpuhp_state target)
+static int __cpuhp_invoke_callback_range(bool bringup,
+					 unsigned int cpu,
+					 struct cpuhp_cpu_state *st,
+					 enum cpuhp_state target,
+					 bool nofail)
 {
 	enum cpuhp_state state;
-	int err =3D 0;
+	int ret =3D 0;
=20
 	while (cpuhp_next_state(bringup, &state, st, target)) {
+		int err;
+
 		err =3D cpuhp_invoke_callback(cpu, state, bringup, NULL, NULL);
-		if (err)
+		if (!err)
+			continue;
+
+		if (nofail) {
+			pr_warn("CPU %u %s state %s (%d) failed (%d)\n",
+				cpu, bringup ? "UP" : "DOWN",
+				cpuhp_get_step(st->state)->name,
+				st->state, err);
+			ret =3D -1;
+		} else {
+			ret =3D err;
 			break;
+		}
 	}
=20
-	return err;
+	return ret;
+}
+
+static inline int cpuhp_invoke_callback_range(bool bringup,
+					      unsigned int cpu,
+					      struct cpuhp_cpu_state *st,
+					      enum cpuhp_state target)
+{
+	return __cpuhp_invoke_callback_range(bringup, cpu, st, target, false);
+}
+
+static inline void cpuhp_invoke_callback_range_nofail(bool bringup,
+						      unsigned int cpu,
+						      struct cpuhp_cpu_state *st,
+						      enum cpuhp_state target)
+{
+	__cpuhp_invoke_callback_range(bringup, cpu, st, target, true);
 }
=20
 static inline bool can_rollback_cpu(struct cpuhp_cpu_state *st)
@@ -999,7 +1029,6 @@ static int take_cpu_down(void *_param)
 	struct cpuhp_cpu_state *st =3D this_cpu_ptr(&cpuhp_state);
 	enum cpuhp_state target =3D max((int)st->target, CPUHP_AP_OFFLINE);
 	int err, cpu =3D smp_processor_id();
-	int ret;
=20
 	/* Ensure this CPU doesn't handle any more interrupts. */
 	err =3D __cpu_disable();
@@ -1012,13 +1041,10 @@ static int take_cpu_down(void *_param)
 	 */
 	WARN_ON(st->state !=3D (CPUHP_TEARDOWN_CPU - 1));
=20
-	/* Invoke the former CPU_DYING callbacks */
-	ret =3D cpuhp_invoke_callback_range(false, cpu, st, target);
-
 	/*
-	 * DYING must not fail!
+	 * Invoke the former CPU_DYING callbacks. DYING must not fail!
 	 */
-	WARN_ON_ONCE(ret);
+	cpuhp_invoke_callback_range_nofail(false, cpu, st, target);
=20
 	/* Give up timekeeping duties */
 	tick_handover_do_timer();
@@ -1296,16 +1322,14 @@ void notify_cpu_starting(unsigned int cpu)
 {
 	struct cpuhp_cpu_state *st =3D per_cpu_ptr(&cpuhp_state, cpu);
 	enum cpuhp_state target =3D min((int)st->target, CPUHP_AP_ONLINE);
-	int ret;
=20
 	rcu_cpu_starting(cpu);	/* Enables RCU usage on this CPU. */
 	cpumask_set_cpu(cpu, &cpus_booted_once_mask);
-	ret =3D cpuhp_invoke_callback_range(true, cpu, st, target);
=20
 	/*
 	 * STARTING must not fail!
 	 */
-	WARN_ON_ONCE(ret);
+	cpuhp_invoke_callback_range_nofail(true, cpu, st, target);
 }
=20
 /*
@@ -2326,8 +2350,10 @@ static ssize_t target_store(struct device *dev, struct=
 device_attribute *attr,
=20
 	if (st->state < target)
 		ret =3D cpu_up(dev->id, target);
-	else
+	else if (st->state > target)
 		ret =3D cpu_down(dev->id, target);
+	else if (WARN_ON(st->target !=3D target))
+		st->target =3D target;
 out:
 	unlock_device_hotplug();
 	return ret ? ret : count;
@@ -2688,6 +2714,7 @@ void __init boot_cpu_hotplug_init(void)
 	cpumask_set_cpu(smp_processor_id(), &cpus_booted_once_mask);
 #endif
 	this_cpu_write(cpuhp_state.state, CPUHP_ONLINE);
+	this_cpu_write(cpuhp_state.target, CPUHP_ONLINE);
 }
=20
 /*

