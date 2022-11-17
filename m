Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D38662E3DB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239350AbiKQSMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239841AbiKQSLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:11:48 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828E77FF09
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 10:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2W2RQ5ZZfCx76P2x7T/o4aj30W6KtTTp8DplwjS4Bew=; b=MhVEmOCaLQfkdmJTCgJFwo67Uc
        MnLqH+G0NicDJ9JJNQHzbHLv1/+xRs8755Xr8aI13KLCVWteRYYsn3XLf5aFvA8Lqh5fHl3m0L4CB
        7UL+PztHcr3GwcZ0EQpvHkz3f+RCec/Gi67x//wCBc1kNMw6mPPTff4OZS8rxm67II9N/qM0+gNOt
        WYDxXzOSuNFqT0lzddGfnZUqUg3uEUNJ5Eue4TvIY6pT0VS2Didu3x8LSZGdjtbjDyBjVJ4MN857h
        +oBMYHcsgACDCoEX3jhd2A+cG7SJIxRDVxtgeHwVvewm5VBNv2vXgS+9q2VlojudakE3CCxy0IAEG
        lVRkboEw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovjMR-001jnD-AY; Thu, 17 Nov 2022 18:11:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 422F130062A;
        Thu, 17 Nov 2022 19:11:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E41D72C12E8FA; Thu, 17 Nov 2022 19:11:37 +0100 (CET)
Date:   Thu, 17 Nov 2022 19:11:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     peter.zijlstra@intel.com, linux-kernel@vger.kernel.org,
        heng.su@intel.com, Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [Syzkaller & bisect] There is "__perf_event_overflow" WARNING in
 v6.1-rc5 kernel in guest
Message-ID: <Y3Z5WTk+cvHSt0lf@hirez.programming.kicks-ass.net>
References: <Y3RbiRmAKrDlVCxC@xpf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3RbiRmAKrDlVCxC@xpf.sh.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 11:39:53AM +0800, Pengfei Xu wrote:
> int main(void)
> {
>   syscall(__NR_mmap, 0x1ffff000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
>   syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 7ul, 0x32ul, -1, 0ul);
>   syscall(__NR_mmap, 0x21000000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
>   setup_sysctl();
> 
>   *(uint32_t*)0x20000200 = 0;
>   *(uint32_t*)0x20000204 = 0x80;
>   *(uint8_t*)0x20000208 = 0;
>   *(uint8_t*)0x20000209 = 0;
>   *(uint8_t*)0x2000020a = 0;
>   *(uint8_t*)0x2000020b = 0;
>   *(uint32_t*)0x2000020c = 0;
>   *(uint64_t*)0x20000210 = 8;
>   *(uint64_t*)0x20000218 = 0;
>   *(uint64_t*)0x20000220 = 0;
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 0, 1);
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 1, 1);
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 2, 1);
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 3, 1);
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 4, 1);
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 1, 5, 1);
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 6, 1);
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 7, 1);
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 8, 1);
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 9, 1);
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 1, 10, 1);
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 11, 1);
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 12, 1);
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 13, 1);
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 14, 1);
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 15, 2);
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 17, 1);
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 18, 1);
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 19, 1);
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 20, 1);
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 21, 1);
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 22, 1);
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 23, 1);
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 24, 1);
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 25, 1);
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 26, 1);
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 27, 1);
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 28, 1);
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 29, 1);
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 30, 1);
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 31, 1);
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 1, 32, 1);
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 1, 33, 1);
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 34, 1);
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 35, 1);
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 1, 36, 1);
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 1, 37, 1);
>   STORE_BY_BITMASK(uint64_t, , 0x20000228, 0, 38, 26);
>   *(uint32_t*)0x20000230 = 0;
>   *(uint32_t*)0x20000234 = 0;
>   *(uint64_t*)0x20000238 = 0;
>   *(uint64_t*)0x20000240 = 0;
>   *(uint64_t*)0x20000248 = 0;
>   *(uint64_t*)0x20000250 = 0;
>   *(uint32_t*)0x20000258 = 0;
>   *(uint32_t*)0x2000025c = 0;
>   *(uint64_t*)0x20000260 = 0;
>   *(uint32_t*)0x20000268 = 0;
>   *(uint16_t*)0x2000026c = 0;
>   *(uint16_t*)0x2000026e = 0;
>   *(uint32_t*)0x20000270 = 0;
>   *(uint32_t*)0x20000274 = 0;
>   *(uint64_t*)0x20000278 = 0xd62;
>   syscall(__NR_perf_event_open, 0x20000200ul, 0, 0ul, -1, 3ul);
>   return 0;
> }

Putting that next to 'pahole --hex -C perf_event_attr' seems to suggest
this is HW_CPU_CYCLES with a sampling on and exclude_kernel and sigtrap
set.

Now, for hardware events like this, you'd expect the PMU OS filter to
respect exclude_kernel (specifically not set ARCH_PERFMON_EVENTSEL_OS in
the relevant MSR), except there's a bunch of erratas and skid related
'funnies' that mean a user event can trigger across the kernel boundary.

Does the below patch help -- it should filter out those sort of things.

(still also including that previous patch)

---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4ec3717003d5..cc86bf25f0c3 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9273,6 +9273,21 @@ int perf_event_account_interrupt(struct perf_event *event)
 	return __perf_event_account_interrupt(event, 1);
 }
 
+static inline bool sample_is_allowed(struct perf_event *event, struct pt_regs *regs)
+{
+	/*
+	 * Due to interrupt latency (AKA "skid"), we may enter the
+	 * kernel before taking an overflow, even if the PMU is only
+	 * counting user events.
+	 * To avoid leaking information to userspace, we must always
+	 * reject kernel samples when exclude_kernel is set.
+	 */
+	if (event->attr.exclude_kernel && !user_mode(regs))
+		return false;
+
+	return true;
+}
+
 /*
  * Generic event overflow handling, sampling.
  */
@@ -9305,15 +9320,28 @@ static int __perf_event_overflow(struct perf_event *event,
 		perf_event_disable_inatomic(event);
 	}
 
-	if (event->attr.sigtrap) {
-		/*
-		 * Should not be able to return to user space without processing
-		 * pending_sigtrap (kernel events can overflow multiple times).
-		 */
-		WARN_ON_ONCE(event->pending_sigtrap && event->attr.exclude_kernel);
+	if (event->attr.sigtrap && sample_is_allowed(event, regs)) {
+		unsigned int pending_id = 1;
+
+		if (regs)
+			pending_id = hash32_ptr((void *)instruction_pointer(regs)) ?: 1;
 		if (!event->pending_sigtrap) {
-			event->pending_sigtrap = 1;
+			event->pending_sigtrap = pending_id;
 			local_inc(&event->ctx->nr_pending);
+		} else if (event->attr.exclude_kernel) {
+			/*
+			 * Should not be able to return to user space without
+			 * consuming pending_sigtrap; with exceptions:
+			 *
+			 *  1. Where !exclude_kernel, events can overflow again
+			 *     in the kernel without returning to user space.
+			 *
+			 *  2. Events that can overflow again before the IRQ-
+			 *     work without user space progress (e.g. hrtimer).
+			 *     To approximate progress (with false negatives),
+			 *     check 32-bit hash of the current IP.
+			 */
+			WARN_ON_ONCE(event->pending_sigtrap != pending_id);
 		}
 		event->pending_addr = data->addr;
 		irq_work_queue(&event->pending_irq);
