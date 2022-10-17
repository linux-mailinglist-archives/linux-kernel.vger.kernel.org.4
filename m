Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD73B6011DF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiJQO4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiJQOyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:54:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A475E696C7;
        Mon, 17 Oct 2022 07:54:07 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:54:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018445;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jHQlVXUTl5Uvj2rpEUA7h6spp5oD8taVEACtfEok5pU=;
        b=w5ZmrZJf+o5YGab7xXK2VLL1RssGlF5f3+lyXeOslHawe2iw8narTVSnvjaQ12epdPgF0o
        4WrP2A3KbOJY6YSpmXFhLVSsyOX/8EvGiWKsAblBywe1ypwvPdmUYJMCUvL+EaMTf1hDw9
        s15JYHciKJdR8LbvlO9YIvFuAp18YZGNcRUTc79JGq/oYov5kwAsLDzWj2ICHKRaHWyVkq
        KgoAhwFVpIysZwthQ2E3Das7X20e/bLZgTcJnUzQrhQfi3aFIFRdzOlIlVzCXN+DjO9Lgn
        4MXZ7/vzuLvEVYdByvOfvrDo0Gfatrw4SPvdZCO6C75Gt9AxiJjjvZ3e0qlQ+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018445;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jHQlVXUTl5Uvj2rpEUA7h6spp5oD8taVEACtfEok5pU=;
        b=W1PuyEFT2sGDNdFmfqDimBYsGXnFgoG3n8W7PrG3I1RVSnN+VomGTwrAECkgT92aDROCUo
        rlb0Hboe9ABWloAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/softirq: Move softirq pending next to current task
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111145.702133710@infradead.org>
References: <20220915111145.702133710@infradead.org>
MIME-Version: 1.0
Message-ID: <166601844447.401.2279136685209842168.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     7fcecafebed90d03f35bec6e147fc0b5f6e1bc71
Gitweb:        https://git.kernel.org/tip/7fcecafebed90d03f35bec6e147fc0b5f6e1bc71
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:11:06 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:05 +02:00

x86/softirq: Move softirq pending next to current task

Another hot variable which is strict per CPU and benefits from
being in the same cache line.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111145.702133710@infradead.org
---
 arch/x86/include/asm/current.h | 1 +
 arch/x86/include/asm/hardirq.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index ac3090d..b89aba0 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -19,6 +19,7 @@ struct pcpu_hot {
 			int			cpu_number;
 			unsigned long		top_of_stack;
 			void			*hardirq_stack_ptr;
+			u16			softirq_pending;
 #ifdef CONFIG_X86_64
 			bool			hardirq_stack_inuse;
 #else
diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index 275e7fd..66837b8 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -3,9 +3,9 @@
 #define _ASM_X86_HARDIRQ_H
 
 #include <linux/threads.h>
+#include <asm/current.h>
 
 typedef struct {
-	u16	     __softirq_pending;
 #if IS_ENABLED(CONFIG_KVM_INTEL)
 	u8	     kvm_cpu_l1tf_flush_l1d;
 #endif
@@ -60,6 +60,7 @@ extern u64 arch_irq_stat_cpu(unsigned int cpu);
 extern u64 arch_irq_stat(void);
 #define arch_irq_stat		arch_irq_stat
 
+#define local_softirq_pending_ref       pcpu_hot.softirq_pending
 
 #if IS_ENABLED(CONFIG_KVM_INTEL)
 static inline void kvm_set_cpu_l1tf_flush_l1d(void)
