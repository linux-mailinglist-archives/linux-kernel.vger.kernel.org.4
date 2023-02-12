Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FE66936CC
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 11:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjBLKDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 05:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBLKDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 05:03:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F419813DCD;
        Sun, 12 Feb 2023 02:03:47 -0800 (PST)
Date:   Sun, 12 Feb 2023 10:03:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676196224;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ysHXBb1DcM5V0ddOscfbWUty0Zk2SK1CJCjvUWrO308=;
        b=zBkwI6PoKuPRl+fh83uc5ZF7qs+7xaOYWQcIAQ/MemIr5vrPcZyoTlkFWtgx8Udg78Urfg
        srnW7OFlUMXZkyJdqNFTLkz4OXUU1sQ2WBWX/BpsmFkOfmsTKFdSXt5vb+WwYriLxdrqFt
        uIG+5X6gN9wXdd/j0sY8GSHDaYm6rvIgi2ieZlP/rTaWNCaenRSS2xgZ11BqjxXS/CU8rL
        EyZdFEwZ+tFku1EilTcAl6kDUt+HpkDxZbmSO8RKT1ZY3qjMeKz6qKtgBFLt+VTUpy0lQZ
        1izALFCnUKvxAzBVyBhYFt7FiDTDptcsTwbFDP8c4Y3NHMlk0XeaZbQo5EP5ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676196224;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ysHXBb1DcM5V0ddOscfbWUty0Zk2SK1CJCjvUWrO308=;
        b=n8KaWnFyinIKpSIxGG0/xAP4WVBHZBRtHQ0LbUr61tj0pENaO/lrxmQlFteMgrAvkJOn/w
        EeP8p96FA4VOtnCw==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/xen: mark xen_pv_play_dead() as __noreturn
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221125063248.30256-3-jgross@suse.com>
References: <20221125063248.30256-3-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <167619622384.4906.15498256119270145523.tip-bot2@tip-bot2>
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

Commit-ID:     1aff0d2658e5a5217d3168e06a90fbb99fa63e80
Gitweb:        https://git.kernel.org/tip/1aff0d2658e5a5217d3168e06a90fbb99fa63e80
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Fri, 25 Nov 2022 07:32:48 +01:00
Committer:     Juergen Gross <jgross@suse.com>
CommitterDate: Tue, 17 Jan 2023 09:05:32 +01:00

x86/xen: mark xen_pv_play_dead() as __noreturn

Mark xen_pv_play_dead() and related to that xen_cpu_bringup_again()
as "__noreturn".

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20221125063248.30256-3-jgross@suse.com
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/smp.h    | 2 +-
 arch/x86/xen/smp_pv.c | 4 ++--
 tools/objtool/check.c | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/xen/smp.h b/arch/x86/xen/smp.h
index 6e90a31..22fb982 100644
--- a/arch/x86/xen/smp.h
+++ b/arch/x86/xen/smp.h
@@ -21,7 +21,7 @@ void xen_smp_send_reschedule(int cpu);
 void xen_smp_send_call_function_ipi(const struct cpumask *mask);
 void xen_smp_send_call_function_single_ipi(int cpu);
 
-void xen_cpu_bringup_again(unsigned long stack);
+void __noreturn xen_cpu_bringup_again(unsigned long stack);
 
 struct xen_common_irq {
 	int irq;
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index a97b050..a9cf8c8 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -381,7 +381,7 @@ static void xen_pv_cpu_die(unsigned int cpu)
 	}
 }
 
-static void xen_pv_play_dead(void) /* used only with HOTPLUG_CPU */
+static void __noreturn xen_pv_play_dead(void) /* used only with HOTPLUG_CPU */
 {
 	play_dead_common();
 	HYPERVISOR_vcpu_op(VCPUOP_down, xen_vcpu_nr(smp_processor_id()), NULL);
@@ -400,7 +400,7 @@ static void xen_pv_cpu_die(unsigned int cpu)
 	BUG();
 }
 
-static void xen_pv_play_dead(void)
+static void __noreturn xen_pv_play_dead(void)
 {
 	BUG();
 }
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4b7c8b3..68e87b4 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -186,6 +186,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"snp_abort",
 		"stop_this_cpu",
 		"usercopy_abort",
+		"xen_cpu_bringup_again",
 		"xen_start_kernel",
 	};
 
