Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9196936CE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 11:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjBLKDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 05:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjBLKDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 05:03:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1EF13DC8;
        Sun, 12 Feb 2023 02:03:47 -0800 (PST)
Date:   Sun, 12 Feb 2023 10:03:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676196224;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K0LcZzYcjToImwOILwcJKE3q2zgmzgZW7esoI7i1FSQ=;
        b=w4EW4XMqBx08RcpCncZzN2URHSKQG54GXg3nxny8nwLkQR5DrhMYV705X16KV4gsceHY/S
        W88b/EIg3NwSAq1FjhOTxy503Oymhl2uHfz9GmJDHVoZ93cq/lv247E6fjSXBSWeqeuNJL
        1+WBYoxjXBjuzv7Upmpm5P6pW/cC3epxegP8dD1+HNy969f2CyQbW797ZZoqWU1rN3g13S
        SVP8h2L0MgZ130JSE3d/JK6LOXbt8TLuaRVvodKxn8dV6jcwonYsHWLDW58UZHJzycTCZX
        Y8DSzY6/ZTtuiItukV5ewiAHNIeHmFWjZCmg/3d0jYZNN/ksdL6ACTn3cnFN7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676196224;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K0LcZzYcjToImwOILwcJKE3q2zgmzgZW7esoI7i1FSQ=;
        b=DTBVaHuLdO7NRLuaMZ1RWAD23BJjEZnNWgo5MRsX3EdwZ2K0EawlMvUx6aOxR4idcRxNJY
        Io3z1hweS3HfyhBw==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/xen: don't let xen_pv_play_dead() return
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221125063248.30256-2-jgross@suse.com>
References: <20221125063248.30256-2-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <167619622430.4906.6094169648659727489.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     076cbf5d216377087e135a0ae81844f7835cdc15
Gitweb:        https://git.kernel.org/tip/076cbf5d216377087e135a0ae81844f7835cdc15
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Fri, 25 Nov 2022 07:32:47 +01:00
Committer:     Juergen Gross <jgross@suse.com>
CommitterDate: Tue, 17 Jan 2023 09:05:28 +01:00

x86/xen: don't let xen_pv_play_dead() return

A function called via the paravirt play_dead() hook should not return
to the caller.

xen_pv_play_dead() has a problem in this regard, as it currently will
return in case an offlined cpu is brought to life again. This can be
changed only by doing basically a longjmp() to cpu_bringup_and_idle(),
as the hypercall for bringing down the cpu will just return when the
cpu is coming up again. Just re-initializing the cpu isn't possible,
as the Xen hypervisor will deny that operation.

So introduce xen_cpu_bringup_again() resetting the stack and calling
cpu_bringup_and_idle(), which can be called after HYPERVISOR_vcpu_op()
in xen_pv_play_dead().

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20221125063248.30256-2-jgross@suse.com
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/smp.h      |  2 ++
 arch/x86/xen/smp_pv.c   | 13 ++-----------
 arch/x86/xen/xen-head.S |  7 +++++++
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/xen/smp.h b/arch/x86/xen/smp.h
index bd02f9d..6e90a31 100644
--- a/arch/x86/xen/smp.h
+++ b/arch/x86/xen/smp.h
@@ -21,6 +21,8 @@ void xen_smp_send_reschedule(int cpu);
 void xen_smp_send_call_function_ipi(const struct cpumask *mask);
 void xen_smp_send_call_function_single_ipi(int cpu);
 
+void xen_cpu_bringup_again(unsigned long stack);
+
 struct xen_common_irq {
 	int irq;
 	char *name;
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 6175f2c..a97b050 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -385,17 +385,8 @@ static void xen_pv_play_dead(void) /* used only with HOTPLUG_CPU */
 {
 	play_dead_common();
 	HYPERVISOR_vcpu_op(VCPUOP_down, xen_vcpu_nr(smp_processor_id()), NULL);
-	cpu_bringup();
-	/*
-	 * commit 4b0c0f294 (tick: Cleanup NOHZ per cpu data on cpu down)
-	 * clears certain data that the cpu_idle loop (which called us
-	 * and that we return from) expects. The only way to get that
-	 * data back is to call:
-	 */
-	tick_nohz_idle_enter();
-	tick_nohz_idle_stop_tick_protected();
-
-	cpuhp_online_idle(CPUHP_AP_ONLINE_IDLE);
+	xen_cpu_bringup_again((unsigned long)task_pt_regs(current));
+	BUG();
 }
 
 #else /* !CONFIG_HOTPLUG_CPU */
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index ffaa621..e36ea42 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -76,6 +76,13 @@ SYM_CODE_START(asm_cpu_bringup_and_idle)
 
 	call cpu_bringup_and_idle
 SYM_CODE_END(asm_cpu_bringup_and_idle)
+
+SYM_CODE_START(xen_cpu_bringup_again)
+	UNWIND_HINT_FUNC
+	mov	%rdi, %rsp
+	UNWIND_HINT_REGS
+	call	cpu_bringup_and_idle
+SYM_CODE_END(xen_cpu_bringup_again)
 .popsection
 #endif
 #endif
