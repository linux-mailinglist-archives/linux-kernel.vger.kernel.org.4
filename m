Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA98722F8F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbjFETQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235379AbjFETQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:16:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2712122;
        Mon,  5 Jun 2023 12:16:20 -0700 (PDT)
Date:   Mon, 05 Jun 2023 19:16:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685992578;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nefLx1ncunt24Z9x1hQOgvZ54e8uI2PhjSAmZ7CKnB4=;
        b=vIjOi4HXm2/HBdwlpRTecee/kB5/WB+X3aLLXYxM56/xwQiRZefbkz6WmDcsctafOW+ctN
        ktGuiKXHEapnQADkzO3m7+jHZ0z2umXZcZ+PNCNdMd7KYr+cn2c8DEiYEaglWD0szt6x/M
        avLM00LnoRUyO2A0un8YKaeji4cnwTe2gTdQP0SQAZJAVtGYKoAVoGjg+HCODpySPAoo/K
        HY48R4Mpb8ELLSYFBZzsCJogL+9mCGB/g1QjCDziyQd2UJL0KCG0gFFfUPDzG2QDMIHUG7
        PEn4yj93iC/NMpyO98cWwEPlLMoqFJDLmAMkEuA8m/hw6D13bCFf7pOtyY0Y6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685992578;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nefLx1ncunt24Z9x1hQOgvZ54e8uI2PhjSAmZ7CKnB4=;
        b=84ph86KnuremQ5Ymzwz5assjnYvAJ94dII6939vSjOTBgKrwg/O46vFOSBw5HAd8P7R/y9
        4H0IhdhJwqX06bDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] loongarch: Provide noinstr sched_clock_read()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230519102715.502547082@infradead.org>
References: <20230519102715.502547082@infradead.org>
MIME-Version: 1.0
Message-ID: <168599257836.404.16765871891993348111.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     6b10fef09f937433563822f4bb6a2f947176e5a0
Gitweb:        https://git.kernel.org/tip/6b10fef09f937433563822f4bb6a2f947176e5a0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 19 May 2023 12:21:03 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 21:11:05 +02:00

loongarch: Provide noinstr sched_clock_read()

With the intent to provide local_clock_noinstr(), a variant of
local_clock() that's safe to be called from noinstr code (with the
assumption that any such code will already be non-preemptible),
prepare for things by providing a noinstr sched_clock_read() function.

Specifically, preempt_enable_*() calls out to schedule(), which upsets
noinstr validation efforts.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>  # Hyper-V
Link: https://lore.kernel.org/r/20230519102715.502547082@infradead.org
---
 arch/loongarch/include/asm/loongarch.h | 2 +-
 arch/loongarch/kernel/time.c           | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
index b3323ab..357ef70 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -1167,7 +1167,7 @@ static __always_inline void iocsr_write64(u64 val, u32 reg)
 
 #ifndef __ASSEMBLY__
 
-static inline u64 drdtime(void)
+static __always_inline u64 drdtime(void)
 {
 	int rID = 0;
 	u64 val = 0;
diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
index f377e50..c189e03 100644
--- a/arch/loongarch/kernel/time.c
+++ b/arch/loongarch/kernel/time.c
@@ -190,9 +190,9 @@ static u64 read_const_counter(struct clocksource *clk)
 	return drdtime();
 }
 
-static u64 native_sched_clock(void)
+static noinstr u64 sched_clock_read(void)
 {
-	return read_const_counter(NULL);
+	return drdtime();
 }
 
 static struct clocksource clocksource_const = {
@@ -211,7 +211,7 @@ int __init constant_clocksource_init(void)
 
 	res = clocksource_register_hz(&clocksource_const, freq);
 
-	sched_clock_register(native_sched_clock, 64, freq);
+	sched_clock_register(sched_clock_read, 64, freq);
 
 	pr_info("Constant clock source device register\n");
 
