Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436307094FD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjESKei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbjESKeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:34:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C6410E3;
        Fri, 19 May 2023 03:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=y/NZkFjA2o+5kqY9Uzuitbn0zBukaZRP/fG6yHo/Mzw=; b=rwT6emRs6FoOj5HRbZc4Lyv/mV
        RvdRsAQUnKcg46+OWrPIi2J2ej4an7WZerhQmJKXBJnDiGnvPiVCZYCyXzKb1IRoocJVVPVgQ+v16
        bumy1VcTdETnIj7T1KDg7rOr7sBYl1PbIEHG0nYMI7kW4mEZoUNgphgQbHVg0bZBBPzojJXsO8FCF
        fdQs2pM5MMmdiLLvNeHtDosmCMS+CAcMGQF+CqBy3XTevbzGxWWAmUTAxgrPVwGSgsSklrVnuG5d6
        2BSXnUmgiXpeUnzBvOH0Xx8L4pa+TUcWYnyI9AhMnrdcHk+r4uwWD6GowTtUYulQHH96Mt+iEjYUj
        Nwj/wofw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pzxPw-006UqY-0H; Fri, 19 May 2023 10:33:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DEC2C302D93;
        Fri, 19 May 2023 12:32:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B7170235EF094; Fri, 19 May 2023 12:32:55 +0200 (CEST)
Message-ID: <20230519102715.302350330@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 19 May 2023 12:21:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     bigeasy@linutronix.de
Cc:     mark.rutland@arm.com, maz@kernel.org, catalin.marinas@arm.com,
        will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        pbonzini@redhat.com, wanpengli@tencent.com, vkuznets@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        jgross@suse.com, boris.ostrovsky@oracle.com,
        daniel.lezcano@linaro.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        rafael@kernel.org, peterz@infradead.org, longman@redhat.com,
        boqun.feng@gmail.com, pmladek@suse.com, senozhatsky@chromium.org,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, jstultz@google.com,
        sboyd@kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 02/13] time/sched_clock: Provide sched_clock_noinstr()
References: <20230519102058.581557770@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the intent to provide local_clock_noinstr(), a variant of
local_clock() that's safe to be called from noinstr code (with the
assumption that any such code will already be non-preemptible),
prepare for things by providing a noinstr sched_clock_noinstr() function.

Specifically, preempt_enable_*() calls out to schedule(), which upsets
noinstr validation efforts.

As such, pull out the preempt_{dis,en}able_notrace() requirements from
the sched_clock_read() implementations by explicitly providing it in
the sched_clock() function.

This further requires said sched_clock_read() functions to be noinstr
themselves, for ARCH_WANTS_NO_INSTR users. See the next few patches.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/time/sched_clock.c |   22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -64,7 +64,7 @@ static struct clock_data cd ____cachelin
 	.actual_read_sched_clock = jiffy_sched_clock_read,
 };
 
-static inline u64 notrace cyc_to_ns(u64 cyc, u32 mult, u32 shift)
+static __always_inline u64 cyc_to_ns(u64 cyc, u32 mult, u32 shift)
 {
 	return (cyc * mult) >> shift;
 }
@@ -80,23 +80,33 @@ notrace int sched_clock_read_retry(unsig
 	return raw_read_seqcount_latch_retry(&cd.seq, seq);
 }
 
-unsigned long long notrace sched_clock(void)
+unsigned long long noinstr sched_clock_noinstr(void)
 {
-	u64 cyc, res;
-	unsigned int seq;
 	struct clock_read_data *rd;
+	unsigned int seq;
+	u64 cyc, res;
 
 	do {
-		rd = sched_clock_read_begin(&seq);
+		seq = raw_read_seqcount_latch(&cd.seq);
+		rd = cd.read_data + (seq & 1);
 
 		cyc = (rd->read_sched_clock() - rd->epoch_cyc) &
 		      rd->sched_clock_mask;
 		res = rd->epoch_ns + cyc_to_ns(cyc, rd->mult, rd->shift);
-	} while (sched_clock_read_retry(seq));
+	} while (raw_read_seqcount_latch_retry(&cd.seq, seq));
 
 	return res;
 }
 
+unsigned long long notrace sched_clock(void)
+{
+	unsigned long long ns;
+	preempt_disable_notrace();
+	ns = sched_clock_noinstr();
+	preempt_enable_notrace();
+	return ns;
+}
+
 /*
  * Updating the data required to read the clock.
  *


