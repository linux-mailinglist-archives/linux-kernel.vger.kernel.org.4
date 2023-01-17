Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A25A66D9B9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbjAQJXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236398AbjAQJWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:22:40 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FFC1E2B6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 01:17:22 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id mg12so1491181ejc.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 01:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JP9sxT7wGO2BZzfscsHinXyak9VMs0A/Ar0sWXw3K1E=;
        b=XUMsOeAVPSGuaHU9t1fdMYMWUx+kHJRIECZ4INdhH2KHBg3nLu45BUeKlK9TqDM3C5
         Y7G2PQlVCiQDeg7s8hzffKnzBRLFpl7IGpmu71W8iN7Gh4YRtvliEWib3kwOlIFbNEMm
         xPvxl999b5+TVhUtiQui9j+gWqzBv37kJEZiJYGkHBrIFrQASbDD/21AJC/RiRlHykhC
         0ewnHGQsPUiAzLdZnCIWVdWIcUHAzNhiGuUy1SEkCAwF9zv9gowHEttynmHemlXfEI9r
         bkevCMGFoNX3q1/owXSc0oGYJTwso4J4bNHfJWPitwW5HFpB7Ldd7wy5rJjBLZv5XzD5
         TRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JP9sxT7wGO2BZzfscsHinXyak9VMs0A/Ar0sWXw3K1E=;
        b=ZfEr0oINFvNbN5rsExiN5xGAWXC9smbGVGtbxyqRIvXy/K2L3y637O3YzEX1H3WLYH
         Y5J08NAY+WWCX6cTP/B4q7xZo46m3dTJOTxyepZAM9g2igihyNCwuIhScnK+9cyGqMhV
         0tIXg3Jtvp2k0kRpASbLacXCP2b1JLFXdTUgfkg6WSuw5n4tzk5fz4OBtWy1qRxcf0Ho
         38gBe1CHMmQSdGCKvOgsFlZSDr9Gl6/m4ETC+khe09btp9f0a7VVANe8nuTBxMnJs+oV
         ZwwafbNRPz5pGgTdFUqHS9QuP7ue73OqyKmWYeiqxQf2BiDiQwpiU/tqp+KuNfFF/DA9
         00aA==
X-Gm-Message-State: AFqh2krdygl4twJNrWqKrJOtUQRxoPLctNw1pb892oHNrjo58oeisUUm
        FWiG5vmJDR3k+UdgNi+3a50sPHcsbS4=
X-Google-Smtp-Source: AMrXdXvUB3uO2y08J/kbhgbihh9C86NsG71bjLda4+IU15Zsqc+sT3108wV19uaBtAi0ltma/nM+vg==
X-Received: by 2002:a17:906:abc6:b0:86c:b710:dacf with SMTP id kq6-20020a170906abc600b0086cb710dacfmr2249224ejb.62.1673947041404;
        Tue, 17 Jan 2023 01:17:21 -0800 (PST)
Received: from gmail.com (1F2EF7EB.nat.pool.telekom.hu. [31.46.247.235])
        by smtp.gmail.com with ESMTPSA id b3-20020a17090630c300b007c0f90a9cc5sm12932119ejb.105.2023.01.17.01.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 01:17:20 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 17 Jan 2023 10:17:16 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] trace,hardirq: No moar _rcuidle() tracing
Message-ID: <Y8ZmeGlNPLvuARBB@gmail.com>
References: <20230112194314.845371875@infradead.org>
 <20230112195541.477416709@infradead.org>
 <20230117132446.02ec12e4c10718de27790900@kernel.org>
 <Y8ZiIMHyXX/yW1EI@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8ZiIMHyXX/yW1EI@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Jan 17, 2023 at 01:24:46PM +0900, Masami Hiramatsu wrote:
> > Hi Peter,
> > 
> > On Thu, 12 Jan 2023 20:43:49 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > Robot reported that trace_hardirqs_{on,off}() tickle the forbidden
> > > _rcuidle() tracepoint through local_irq_{en,dis}able().
> > > 
> > > For 'sane' configs, these calls will only happen with RCU enabled and
> > > as such can use the regular tracepoint. This also means it's possible
> > > to trace them from NMI context again.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > 
> > The code looks good to me. I just have a question about comment.
> > 
> > > ---
> > >  kernel/trace/trace_preemptirq.c |   21 +++++++++++++--------
> > >  1 file changed, 13 insertions(+), 8 deletions(-)
> > > 
> > > --- a/kernel/trace/trace_preemptirq.c
> > > +++ b/kernel/trace/trace_preemptirq.c
> > > @@ -20,6 +20,15 @@
> > >  static DEFINE_PER_CPU(int, tracing_irq_cpu);
> > >  
> > >  /*
> > > + * ...
> > 
> > Is this intended? Wouldn't you leave any comment here?
> 
> I indeed forgot to write the comment before posting, my bad :/ Ingo fixed
> it up when he applied.

For completeness, I've attached the final commit, which has this comment 
included:

+/*
+ * Use regular trace points on architectures that implement noinstr
+ * tooling: these calls will only happen with RCU enabled, which can
+ * use a regular tracepoint.
+ *
+ * On older architectures, use the rcuidle tracing methods (which
+ * aren't NMI-safe - so exclude NMI contexts):
+ */

Thanks,

	Ingo

================>
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 12 Jan 2023 20:43:49 +0100
Subject: [PATCH] tracing, hardirq: No moar _rcuidle() tracing

Robot reported that trace_hardirqs_{on,off}() tickle the forbidden
_rcuidle() tracepoint through local_irq_{en,dis}able().

For 'sane' configs, these calls will only happen with RCU enabled and
as such can use the regular tracepoint. This also means it's possible
to trace them from NMI context again.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230112195541.477416709@infradead.org
---
 kernel/trace/trace_preemptirq.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
index 629f2854e12b..f992444a0b1f 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -19,6 +19,20 @@
 /* Per-cpu variable to prevent redundant calls when IRQs already off */
 static DEFINE_PER_CPU(int, tracing_irq_cpu);
 
+/*
+ * Use regular trace points on architectures that implement noinstr
+ * tooling: these calls will only happen with RCU enabled, which can
+ * use a regular tracepoint.
+ *
+ * On older architectures, use the rcuidle tracing methods (which
+ * aren't NMI-safe - so exclude NMI contexts):
+ */
+#ifdef CONFIG_ARCH_WANTS_NO_INSTR
+#define trace(point)	trace_##point
+#else
+#define trace(point)	if (!in_nmi()) trace_##point##_rcuidle
+#endif
+
 /*
  * Like trace_hardirqs_on() but without the lockdep invocation. This is
  * used in the low level entry code where the ordering vs. RCU is important
@@ -28,8 +42,7 @@ static DEFINE_PER_CPU(int, tracing_irq_cpu);
 void trace_hardirqs_on_prepare(void)
 {
 	if (this_cpu_read(tracing_irq_cpu)) {
-		if (!in_nmi())
-			trace_irq_enable(CALLER_ADDR0, CALLER_ADDR1);
+		trace(irq_enable)(CALLER_ADDR0, CALLER_ADDR1);
 		tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
 		this_cpu_write(tracing_irq_cpu, 0);
 	}
@@ -40,8 +53,7 @@ NOKPROBE_SYMBOL(trace_hardirqs_on_prepare);
 void trace_hardirqs_on(void)
 {
 	if (this_cpu_read(tracing_irq_cpu)) {
-		if (!in_nmi())
-			trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
+		trace(irq_enable)(CALLER_ADDR0, CALLER_ADDR1);
 		tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
 		this_cpu_write(tracing_irq_cpu, 0);
 	}
@@ -63,8 +75,7 @@ void trace_hardirqs_off_finish(void)
 	if (!this_cpu_read(tracing_irq_cpu)) {
 		this_cpu_write(tracing_irq_cpu, 1);
 		tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
-		if (!in_nmi())
-			trace_irq_disable(CALLER_ADDR0, CALLER_ADDR1);
+		trace(irq_disable)(CALLER_ADDR0, CALLER_ADDR1);
 	}
 
 }
@@ -78,8 +89,7 @@ void trace_hardirqs_off(void)
 	if (!this_cpu_read(tracing_irq_cpu)) {
 		this_cpu_write(tracing_irq_cpu, 1);
 		tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
-		if (!in_nmi())
-			trace_irq_disable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
+		trace(irq_disable)(CALLER_ADDR0, CALLER_ADDR1);
 	}
 }
 EXPORT_SYMBOL(trace_hardirqs_off);
