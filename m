Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110AD6362BA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237022AbiKWPFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237830AbiKWPFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:05:23 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD1261528
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=92QWhV7euUxdYQKCgOuX4IrDN7LfFWYK4MJIglV5ae4=; b=R/Vp4ZVBaNGFY+MfztQr1/qBAd
        /GC5uJCZYIK443u5xwaw8uw5/L50oJmVXxiXypdCbVaVMhsiJsuF7RQVrNTFNboW+eMrOIoROqTjb
        QtP1H1mB6TELoCz+u//ZbYstKzCxGwh9lXb6eAd0pL4er8VvD5V0qknz7ZbquMtiqzFobX3I5aD0t
        SyCYdkRzFedyIOxeLOZkcF6D2f5hEtPp96oVj6WNMtt/uA0I1GAIbirymmaaYGXzYt4IsApFGQIHz
        NH8uCz6TjD01hEuzHGHVU3Zn2skL52i312PWrLOmN3QxkaruNpYC3K129N9ivtQqJQKQwOmLruXsi
        b6urTkXA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxrJM-003p4t-D5; Wed, 23 Nov 2022 15:05:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ADF2B300244;
        Wed, 23 Nov 2022 16:05:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8847D20598379; Wed, 23 Nov 2022 16:05:14 +0100 (CET)
Date:   Wed, 23 Nov 2022 16:05:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     peter.zijlstra@intel.com, linux-kernel@vger.kernel.org,
        heng.su@intel.com, Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [Syzkaller & bisect] There is "__perf_event_overflow" WARNING in
 v6.1-rc5 kernel in guest
Message-ID: <Y342qkDw7yqA1VOD@hirez.programming.kicks-ass.net>
References: <Y3RbiRmAKrDlVCxC@xpf.sh.intel.com>
 <Y3Z5WTk+cvHSt0lf@hirez.programming.kicks-ass.net>
 <Y3hDYiXwRnJr8RYG@xpf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3hDYiXwRnJr8RYG@xpf.sh.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2022 at 10:45:54AM +0800, Pengfei Xu wrote:

> The result shows that your additional patch fixed this issue!
> If possible, could you add Reported-and-tested-by tag from me.

After talking with Marco for a bit the patch now looks like the below.
I've tentatively retained your tested-by, except of course, you haven't.

If I could bother you once more to test the branch:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/urgent

---
Subject: perf: Consider OS filter fail
From: Peter Zijlstra <peterz@infradead.org>
Date: Sat, 19 Nov 2022 10:45:54 +0800

Some PMUs (notably the traditional hardware kind) have boundary issues
with the OS filter. Specifically, it is possible for
perf_event_attr::exclude_kernel=1 events to trigger in-kernel due to
SKID or errata.

This can upset the sigtrap logic some and trigger the WARN.

However, if this invalid sample is the first we must not loose the
SIGTRAP, OTOH if it is the second, it must not override the
pending_addr with an invalid one.

Fixes: ca6c21327c6a ("perf: Fix missing SIGTRAPs")
Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Link: https://lkml.kernel.org/r/Y3hDYiXwRnJr8RYG@xpf.sh.intel.com
---
 kernel/events/core.c |   24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9273,6 +9273,19 @@ int perf_event_account_interrupt(struct
 	return __perf_event_account_interrupt(event, 1);
 }
 
+static inline bool sample_is_allowed(struct perf_event *event, struct pt_regs *regs)
+{
+	/*
+	 * Due to interrupt latency (AKA "skid"), we may enter the
+	 * kernel before taking an overflow, even if the PMU is only
+	 * counting user events.
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
@@ -9306,6 +9319,13 @@ static int __perf_event_overflow(struct
 	}
 
 	if (event->attr.sigtrap) {
+		/*
+		 * The desired behaviour of sigtrap vs invalid samples is a bit
+		 * tricky; on the one hand, one should not loose the SIGTRAP if
+		 * it is the first event, on the other hand, we should also not
+		 * trigger the WARN or override the data address.
+		 */
+		bool valid_sample = sample_is_allowed(event, regs);
 		unsigned int pending_id = 1;
 
 		if (regs)
@@ -9313,7 +9333,7 @@ static int __perf_event_overflow(struct
 		if (!event->pending_sigtrap) {
 			event->pending_sigtrap = pending_id;
 			local_inc(&event->ctx->nr_pending);
-		} else if (event->attr.exclude_kernel) {
+		} else if (event->attr.exclude_kernel && valid_sample) {
 			/*
 			 * Should not be able to return to user space without
 			 * consuming pending_sigtrap; with exceptions:
@@ -9330,7 +9350,7 @@ static int __perf_event_overflow(struct
 		}
 
 		event->pending_addr = 0;
-		if (data->sample_flags & PERF_SAMPLE_ADDR)
+		if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
 			event->pending_addr = data->addr;
 		irq_work_queue(&event->pending_irq);
 	}
