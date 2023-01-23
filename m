Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81FE677A4A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 12:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjAWLlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 06:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjAWLlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 06:41:50 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE761352C;
        Mon, 23 Jan 2023 03:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BElcCOJTdrcOanesXl7wLvueYCq0G60+MFFN+WYtDtA=; b=RpZeumbGz/v753aDcq7BZ8VMDW
        P0dHsJdfsj0mbkSUiEvB2/SWcM4WISJcrZRy/ogId6xwr6OTspMHOm349/cb8wmjxPp/kevZvrrYS
        AQzh0klcsOtjvuUwl7nnpVlGHe6QMd/rbVOmedF9v8+wiVlNz1hZQfRe28LuW8HzW+au8KXYm6Cl1
        jOF0As3eoNZ694+yAgp2bO+LLIDmcENAqEdf2teIMI8aaiNXaH/tyew1nxSAS+4krFssMGJE4dgml
        7DgqaSA+9McmVf4ap26m7GE3miawTrQbVAcx9sOaSTOo+fUw9AjgNW8ZBw6fLXIcOB4OUQDzQLQxw
        83azSlDQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pJvCA-001Woo-16;
        Mon, 23 Jan 2023 11:41:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C91F6300327;
        Mon, 23 Jan 2023 12:41:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9FE5821477E2D; Mon, 23 Jan 2023 12:41:29 +0100 (CET)
Date:   Mon, 23 Jan 2023 12:41:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [perf] lockdep warning between cpu_add_remove_lock and
 &dev->mutex.
Message-ID: <Y85yadQes4fSwCZm@hirez.programming.kicks-ass.net>
References: <8c3fc3d1-8fed-be22-e0e7-ef1e1ea723ce@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c3fc3d1-8fed-be22-e0e7-ef1e1ea723ce@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 07:39:24PM +0900, Tetsuo Handa wrote:
> Hello.
> 
> I tried to apply below patch, and hit lockdep warning during boot.
> Can you break this dependency?

  cpu_add_remove_lock
    cpu_hotplug_lock
      pmus_lock
        dev->mutex		(pmu_dev_alloc)

vs

  dev->mutex
    cpu_add_remove_lock		(pci_device_probe)


Possibly something like this might do -- I'm not entirely sure it's
fully correct, needs a bit of auditing.

---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index eacc3702654d..d6b2265a9982 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13570,9 +13570,9 @@ static void perf_event_exit_cpu_context(int cpu)
 {
 	struct perf_cpu_context *cpuctx;
 	struct perf_event_context *ctx;
+	int idx = srcu_read_lock(&pmus_srcu);
 
 	// XXX simplify cpuctx->online
-	mutex_lock(&pmus_lock);
 	cpuctx = per_cpu_ptr(&perf_cpu_context, cpu);
 	ctx = &cpuctx->ctx;
 
@@ -13581,7 +13581,7 @@ static void perf_event_exit_cpu_context(int cpu)
 	cpuctx->online = 0;
 	mutex_unlock(&ctx->mutex);
 	cpumask_clear_cpu(cpu, perf_online_mask);
-	mutex_unlock(&pmus_lock);
+	srcu_read_unlock(&pmus_srcu, idx);
 }
 #else
 
@@ -13593,10 +13594,11 @@ int perf_event_init_cpu(unsigned int cpu)
 {
 	struct perf_cpu_context *cpuctx;
 	struct perf_event_context *ctx;
+	int idx;
 
 	perf_swevent_init_cpu(cpu);
 
-	mutex_lock(&pmus_lock);
+	idx = srcu_read_lock(&pmus_srcu);
 	cpumask_set_cpu(cpu, perf_online_mask);
 	cpuctx = per_cpu_ptr(&perf_cpu_context, cpu);
 	ctx = &cpuctx->ctx;
@@ -13604,7 +13606,7 @@ int perf_event_init_cpu(unsigned int cpu)
 	mutex_lock(&ctx->mutex);
 	cpuctx->online = 1;
 	mutex_unlock(&ctx->mutex);
-	mutex_unlock(&pmus_lock);
+	srcu_read_unlock(&pmus_srcu, idx);
 
 	return 0;
 }
