Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A84C5BCBFE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiISMiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiISMh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:37:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9DB2CE30;
        Mon, 19 Sep 2022 05:37:58 -0700 (PDT)
Date:   Mon, 19 Sep 2022 12:37:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663591077;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OdNB/9ne6jzMkFElMvK/sDVGIlij9X8oecZ0k+FII9M=;
        b=NHzBKOgp6YdYbKukeavP0JhGxjt9j/fYIbySqphw08/f7Se92cImrXtzjeq3I2ajDTrwXB
        pmdoF005OrJfLbJf70xSS2CEsilQsEvGcIi3u2zvEx8C20OpBp5t6iv2ugHc3IZe3PyoVq
        f5eg4BjMZLirkG26KQf6PBIeFby6/G/BXpiX4sFBE7n0klYWUIw4T1m5mMZtj32PxK8OdE
        FFHcJIPNuJLgCOjB+8v+HRmR4La1qDklx1gZuDzG3Gi1T+o4Mljur9O3XgNseHmLaqAbmm
        BzTzXkzdqBpc888DudYhf4wrkWjtQfl22W+/eE+feniAtJ/RgL8koievc0DGBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663591077;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OdNB/9ne6jzMkFElMvK/sDVGIlij9X8oecZ0k+FII9M=;
        b=oyxmE9bOADkKlBBi3N+pRF+h5t5kYBfJlFYN8hYjN8RMcb2WXBHAHrNdjRYsmG8WdG7Reb
        RHJ7Jzwcxb6u01Cw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] mm/debug: Provide VM_WARN_ON_IRQS_ENABLED()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220825164131.402717-5-bigeasy@linutronix.de>
References: <20220825164131.402717-5-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <166359107579.401.13395290228719628356.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     a738e9bad6030d4fd33bfd7db3399a250b7e94d8
Gitweb:        https://git.kernel.org/tip/a738e9bad6030d4fd33bfd7db3399a250b7e94d8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 25 Aug 2022 18:41:27 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 19 Sep 2022 14:35:08 +02:00

mm/debug: Provide VM_WARN_ON_IRQS_ENABLED()

Some places in the VM code expect interrupts disabled, which is a valid
expectation on non-PREEMPT_RT kernels, but does not hold on RT kernels in
some places because the RT spinlock substitution does not disable
interrupts.

To avoid sprinkling CONFIG_PREEMPT_RT conditionals into those places,
provide VM_WARN_ON_IRQS_ENABLED() which is only enabled when VM_DEBUG=y and
PREEMPT_RT=n.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Link: https://lore.kernel.org/r/20220825164131.402717-5-bigeasy@linutronix.de

---
 include/linux/mmdebug.h | 6 ++++++
 lib/Kconfig.debug       | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/mmdebug.h b/include/linux/mmdebug.h
index 15ae78c..b8728d1 100644
--- a/include/linux/mmdebug.h
+++ b/include/linux/mmdebug.h
@@ -94,6 +94,12 @@ void dump_mm(const struct mm_struct *mm);
 #define VM_WARN(cond, format...) BUILD_BUG_ON_INVALID(cond)
 #endif
 
+#ifdef CONFIG_DEBUG_VM_IRQSOFF
+#define VM_WARN_ON_IRQS_ENABLED() WARN_ON_ONCE(!irqs_disabled())
+#else
+#define VM_WARN_ON_IRQS_ENABLED() do { } while (0)
+#endif
+
 #ifdef CONFIG_DEBUG_VIRTUAL
 #define VIRTUAL_BUG_ON(cond) BUG_ON(cond)
 #else
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index bcbe60d..cdb4b27 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -803,6 +803,9 @@ config ARCH_HAS_DEBUG_VM_PGTABLE
 	  An architecture should select this when it can successfully
 	  build and run DEBUG_VM_PGTABLE.
 
+config DEBUG_VM_IRQSOFF
+	def_bool DEBUG_VM && !PREEMPT_RT
+
 config DEBUG_VM
 	bool "Debug VM"
 	depends on DEBUG_KERNEL
