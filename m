Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FA862D85E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbiKQKsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbiKQKsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:48:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470866450;
        Thu, 17 Nov 2022 02:48:35 -0800 (PST)
Date:   Thu, 17 Nov 2022 10:48:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668682113;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NGMrXryM4O7/O3wJE9j6fSOZ5sPkDqtPXocsCfQsU8Y=;
        b=elTeZQPNX0LPLfpOx4o6v9vAsztSzR7XbEio5+FjL5bQPLN6zImcalXugpHiZrhHf2Fek3
        d7jlGFATWDwIfRXzVRmT8Xm1WhKPm7pOc9YtiCl8kgzsro7+0wZy2mQ3THliCoZEBMu2JR
        YGYOnip0Dlo60COH9xAHtEJKCasezxMX17fGiL/dd3bhh5IzDzcZYC3WlhtkB4AICSr3sb
        wKlI4ejwI5uh/gG6fr83xZVxGsBPAVTgVbqZU/85owWEp62nP79siko+schpaJsZhkreue
        lSsUNWsaDT7EL996CX2Y7koqvTV7vLZL7I1Jp88lHXZc36Pk8G9N15xmRpXyDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668682113;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NGMrXryM4O7/O3wJE9j6fSOZ5sPkDqtPXocsCfQsU8Y=;
        b=+UeVv0dgwJN3kOi69kdTcvcdmc069iNeVoRVWehH0QT1i6Zl8TK3r7L7PD6/XojrIxDgYL
        6MOZ9YYerotidwAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/hyper-v: Include
 asm/hyperv-tlfs.h not asm/mshyperv.h
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <87fsemtut0.ffs@tglx>
References: <87fsemtut0.ffs@tglx>
MIME-Version: 1.0
Message-ID: <166868211189.4906.13092844425377353975.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d3fe5c2f206148f86f85f56671109a3118bf0d2b
Gitweb:        https://git.kernel.org/tip/d3fe5c2f206148f86f85f56671109a3118bf0d2b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 13 Nov 2022 22:21:15 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 11:41:19 +01:00

clocksource/drivers/hyper-v: Include asm/hyperv-tlfs.h not asm/mshyperv.h

clocksource/hyperv_timer.h is included into the VDSO build. It includes
asm/mshyperv.h which in turn includes the world and some more. This worked
so far by chance, but any subtle change in the include chain results in a
build breakage because VDSO builds are building user space libraries.

Include asm/hyperv-tlfs.h instead which contains everything what the VDSO
build needs except the hv_get_raw_timer() define. Move this define into a
separate header file, which contains the prerequisites (msr.h) and is
included by clocksource/hyperv_timer.h.

Fixup drivers/hv/vmbus_drv.c which relies on the indirect include of
asm/mshyperv.h.

With that the VDSO build only pulls in the minimum requirements.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lore.kernel.org/r/87fsemtut0.ffs@tglx

---
 arch/x86/include/asm/hyperv_timer.h |  9 +++++++++
 arch/x86/include/asm/mshyperv.h     |  2 --
 drivers/hv/vmbus_drv.c              |  1 +
 include/clocksource/hyperv_timer.h  |  4 +++-
 4 files changed, 13 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/include/asm/hyperv_timer.h

diff --git a/arch/x86/include/asm/hyperv_timer.h b/arch/x86/include/asm/hyperv_timer.h
new file mode 100644
index 0000000..388fa81
--- /dev/null
+++ b/arch/x86/include/asm/hyperv_timer.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_HYPERV_TIMER_H
+#define _ASM_X86_HYPERV_TIMER_H
+
+#include <asm/msr.h>
+
+#define hv_get_raw_timer() rdtsc_ordered()
+
+#endif
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 61f0c20..6d502f3 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -19,8 +19,6 @@ typedef int (*hyperv_fill_flush_list_func)(
 		struct hv_guest_mapping_flush_list *flush,
 		void *data);
 
-#define hv_get_raw_timer() rdtsc_ordered()
-
 void hyperv_vector_handler(struct pt_regs *regs);
 
 #if IS_ENABLED(CONFIG_HYPERV)
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 8b2e413..1f5d37a 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -37,6 +37,7 @@
 #include <linux/dma-map-ops.h>
 #include <linux/pci.h>
 #include <clocksource/hyperv_timer.h>
+#include <asm/mshyperv.h>
 #include "hyperv_vmbus.h"
 
 struct vmbus_dynid {
diff --git a/include/clocksource/hyperv_timer.h b/include/clocksource/hyperv_timer.h
index b3f5d73..b4a3935 100644
--- a/include/clocksource/hyperv_timer.h
+++ b/include/clocksource/hyperv_timer.h
@@ -15,13 +15,15 @@
 
 #include <linux/clocksource.h>
 #include <linux/math64.h>
-#include <asm/mshyperv.h>
+#include <asm/hyperv-tlfs.h>
 
 #define HV_MAX_MAX_DELTA_TICKS 0xffffffff
 #define HV_MIN_DELTA_TICKS 1
 
 #ifdef CONFIG_HYPERV_TIMER
 
+#include <asm/hyperv_timer.h>
+
 /* Routines called by the VMbus driver */
 extern int hv_stimer_alloc(bool have_percpu_irqs);
 extern int hv_stimer_cleanup(unsigned int cpu);
