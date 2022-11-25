Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052F36383FF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 07:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiKYGdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 01:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiKYGc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 01:32:58 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49EB27FF3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 22:32:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8491D1FD78;
        Fri, 25 Nov 2022 06:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669357976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ziIK+rCoFeI7eY+iutr/3xmiOnoDvSfijRGI/bUo88Y=;
        b=E3Fu0Kx3qoRkBQP7xpdpuPfIY0XXiBlnHN2HzddWNJ01CNIBeFOmXue54a24INdZsrAsiU
        ek/AWAyMzXpzM4tipyL9lbaO5ZvFSpy1VhRiokrYjoEsm71TE+OD/AcGjq3k+9iGnc7p0t
        XWLO2MwgkHNNWCpTfSFuTbJ3wLM9sFQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4120D13A08;
        Fri, 25 Nov 2022 06:32:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7omwDphhgGM2cgAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 25 Nov 2022 06:32:56 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org
Subject: [PATCH 1/2] x86/xen: don't let xen_pv_play_dead() return
Date:   Fri, 25 Nov 2022 07:32:47 +0100
Message-Id: <20221125063248.30256-2-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221125063248.30256-1-jgross@suse.com>
References: <20221125063248.30256-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 arch/x86/xen/smp.h      |  2 ++
 arch/x86/xen/smp_pv.c   | 13 ++-----------
 arch/x86/xen/xen-head.S |  7 +++++++
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/xen/smp.h b/arch/x86/xen/smp.h
index bd02f9d50107..6e90a312067b 100644
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
index 480be82e9b7b..b40b24382fe3 100644
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
index ffaa62167f6e..e36ea4268bd2 100644
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
-- 
2.35.3

