Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA57722F8C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbjFETQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFETQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:16:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5BD115;
        Mon,  5 Jun 2023 12:16:18 -0700 (PDT)
Date:   Mon, 05 Jun 2023 19:16:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685992577;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BSUJba/3OMHHFA7f0elDwG0YZzxrcX94s4XI3bmkqjc=;
        b=C3elcbx1zVfpZu/vhVo196nw+PIbtbFqjkTS2/tK9d1WCS9+c61LVdhhf2aa/1oEO7xGsk
        Jwn9MXXWLp9rSTab/TtYrzHMjaRZmNnXJryvnB8G9zWHjin9TQ3fMKjzsi43//L+7ioTh0
        uUwxLQYghmhBNFLcOiM+L0eZlBuSk6nGLyZpEf9ICmUrz9W4KsdIGD8tqh1zOv1ZI6mwPw
        mzin6Twt1UKGVDjgOSn7v+pYDbonX5oXOPvg5QPDdYCPkUhkBEFg8ZJmye1sbWNl+IHfAL
        hE8VLgP94KfkNeQtbIslPDExxNaSN62WtJsJ7lzpI5TRwRu+xrci2t1yEGy/4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685992577;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BSUJba/3OMHHFA7f0elDwG0YZzxrcX94s4XI3bmkqjc=;
        b=cJqNpD+7MxrfvNCc8W2Jq7zdyjf8rv3J10NlR5h3rHhw4stcAFfgm/ZYatC49LgCy5/kwp
        E4q1AsXqYofcHmDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] clocksource: hyper-v: Adjust hv_read_tsc_page_tsc()
 to avoid special casing U64_MAX
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230519102715.775630881@infradead.org>
References: <20230519102715.775630881@infradead.org>
MIME-Version: 1.0
Message-ID: <168599257684.404.16531675432812002461.tip-bot2@tip-bot2>
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

Commit-ID:     9397fa2ea3e7634f61da1ab76b9eb88ba04dfdfc
Gitweb:        https://git.kernel.org/tip/9397fa2ea3e7634f61da1ab76b9eb88ba04dfdfc
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 19 May 2023 12:21:07 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 21:11:07 +02:00

clocksource: hyper-v: Adjust hv_read_tsc_page_tsc() to avoid special casing U64_MAX

Currently hv_read_tsc_page_tsc() (ab)uses the (valid) time value of
U64_MAX as an error return. This breaks the clean wrap-around of the
clock.

Modify the function signature to return a boolean state and provide
another u64 pointer to store the actual time on success. This obviates
the need to steal one time value and restores the full counter width.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>  # Hyper-V
Link: https://lore.kernel.org/r/20230519102715.775630881@infradead.org
---
 arch/x86/include/asm/vdso/gettimeofday.h | 10 ++++++----
 arch/x86/kvm/x86.c                       |  7 +++----
 drivers/clocksource/hyperv_timer.c       | 16 ++++++++++-----
 include/clocksource/hyperv_timer.h       | 24 ++++++++---------------
 4 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index 0badf0a..c81858d 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -238,10 +238,12 @@ static u64 vread_pvclock(void)
 #ifdef CONFIG_HYPERV_TIMER
 static u64 vread_hvclock(void)
 {
-	u64 ret = hv_read_tsc_page(&hvclock_page);
-	if (likely(ret != U64_MAX))
-		ret &= S64_MAX;
-	return ret;
+	u64 tsc, time;
+
+	if (hv_read_tsc_page_tsc(&hvclock_page, &tsc, &time))
+		return time & S64_MAX;
+
+	return U64_MAX;
 }
 #endif
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ceb7c5e..99d97ba 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2799,14 +2799,13 @@ static u64 read_tsc(void)
 static inline u64 vgettsc(struct pvclock_clock *clock, u64 *tsc_timestamp,
 			  int *mode)
 {
-	long v;
 	u64 tsc_pg_val;
+	long v;
 
 	switch (clock->vclock_mode) {
 	case VDSO_CLOCKMODE_HVCLOCK:
-		tsc_pg_val = hv_read_tsc_page_tsc(hv_get_tsc_page(),
-						  tsc_timestamp);
-		if (tsc_pg_val != U64_MAX) {
+		if (hv_read_tsc_page_tsc(hv_get_tsc_page(),
+					 tsc_timestamp, &tsc_pg_val)) {
 			/* TSC page valid */
 			*mode = VDSO_CLOCKMODE_HVCLOCK;
 			v = (tsc_pg_val - clock->cycle_last) &
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index bcd9042..c643bfe 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -393,14 +393,20 @@ struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
 }
 EXPORT_SYMBOL_GPL(hv_get_tsc_page);
 
-static u64 notrace read_hv_clock_tsc(void)
+static notrace u64 read_hv_clock_tsc(void)
 {
-	u64 current_tick = hv_read_tsc_page(hv_get_tsc_page());
+	u64 cur_tsc, time;
 
-	if (current_tick == U64_MAX)
-		current_tick = hv_get_register(HV_REGISTER_TIME_REF_COUNT);
+	/*
+	 * The Hyper-V Top-Level Function Spec (TLFS), section Timers,
+	 * subsection Refererence Counter, guarantees that the TSC and MSR
+	 * times are in sync and monotonic. Therefore we can fall back
+	 * to the MSR in case the TSC page indicates unavailability.
+	 */
+	if (!hv_read_tsc_page_tsc(tsc_page, &cur_tsc, &time))
+		time = hv_get_register(HV_REGISTER_TIME_REF_COUNT);
 
-	return current_tick;
+	return time;
 }
 
 static u64 notrace read_hv_clock_tsc_cs(struct clocksource *arg)
diff --git a/include/clocksource/hyperv_timer.h b/include/clocksource/hyperv_timer.h
index 536f897..6cdc873 100644
--- a/include/clocksource/hyperv_timer.h
+++ b/include/clocksource/hyperv_timer.h
@@ -38,8 +38,9 @@ extern void hv_remap_tsc_clocksource(void);
 extern unsigned long hv_get_tsc_pfn(void);
 extern struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
 
-static inline notrace u64
-hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg, u64 *cur_tsc)
+static __always_inline bool
+hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
+		     u64 *cur_tsc, u64 *time)
 {
 	u64 scale, offset;
 	u32 sequence;
@@ -63,7 +64,7 @@ hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg, u64 *cur_tsc)
 	do {
 		sequence = READ_ONCE(tsc_pg->tsc_sequence);
 		if (!sequence)
-			return U64_MAX;
+			return false;
 		/*
 		 * Make sure we read sequence before we read other values from
 		 * TSC page.
@@ -82,15 +83,8 @@ hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg, u64 *cur_tsc)
 
 	} while (READ_ONCE(tsc_pg->tsc_sequence) != sequence);
 
-	return mul_u64_u64_shr(*cur_tsc, scale, 64) + offset;
-}
-
-static inline notrace u64
-hv_read_tsc_page(const struct ms_hyperv_tsc_page *tsc_pg)
-{
-	u64 cur_tsc;
-
-	return hv_read_tsc_page_tsc(tsc_pg, &cur_tsc);
+	*time = mul_u64_u64_shr(*cur_tsc, scale, 64) + offset;
+	return true;
 }
 
 #else /* CONFIG_HYPERV_TIMER */
@@ -104,10 +98,10 @@ static inline struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
 	return NULL;
 }
 
-static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
-				       u64 *cur_tsc)
+static __always_inline bool
+hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg, u64 *cur_tsc, u64 *time)
 {
-	return U64_MAX;
+	return false;
 }
 
 static inline int hv_stimer_cleanup(unsigned int cpu) { return 0; }
