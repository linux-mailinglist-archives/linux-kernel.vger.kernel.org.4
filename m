Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A213682241
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 03:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjAaCgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 21:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjAaCgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 21:36:22 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5950432E7B
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 18:35:35 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id nm12-20020a17090b19cc00b0022c2155cc0bso13021997pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 18:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1u9t1H+HU2zMGcldkE0dm5tbD5OiqV0vr+NJule6bo4=;
        b=sv0Ug0Nx3GH7aSZw2rGsbY9445qEURy0pSDjIZzQNTwWE+2lGDsk4S4f9xH1Cm+qg5
         ohsdSe8vfsxko7NrbTAv8K6FoHu7lN0vMgd77MYzBEMCC/XDVWe67WvkKvGxibw7XzXm
         mcLTmxluoQ4i7UDR0W4pirKHaXXA50hThF55xMCaBtBaH2Tgyk1PJXTXnwE2me88JKzg
         HuWkNNJNCdvNAPlQGLP+NO6Y8BY+fRojljEzUp4QILvT18kxpzSI6vr+xef9lHPW8XM0
         Hv/1DM3bnMXEcVHxGYWnXIrUNvju5pULXOp6ztJmduFaBMc6/laLQtc7d+4Yp5cXSa5r
         tdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1u9t1H+HU2zMGcldkE0dm5tbD5OiqV0vr+NJule6bo4=;
        b=IXhkIt+I40PnVten23R8ytzwn10Sz7PB5HPNu+GzSWV52KAkckaKNrDxb3ye8gkFbY
         ENa952Sqdzy9dBkMPFl8S6Xshz9S/oZKEwbY1zf8VXPExdzGniwul8jlLX9ldm1GgnDc
         w+DUobEaghdu1kFQZ2n8FPazo5BQl8/pBlk1HuQ2olnslc2GQHtpb/uLFYl/2Kee66VT
         N3gfjAPWCATxMucjsslV2nflyOhuHwZ2xkq8s7hbN/qjaHO/CnnIiG0efIkrZgek4Rs1
         YDPsz+dDVL4ROxY1r8Lf1D66V1YQoFfH+uYo1gcKOeOSbPO/06umYBUnbOZzHf8eHVYv
         0WBw==
X-Gm-Message-State: AFqh2krsTR4U86OMM/JZi/MFOmP5GD8Y0pxd0DUkCDlh+dkWqBx7tAYf
        6Bf+aCmI+G37YiXa918n9akNiA==
X-Google-Smtp-Source: AMrXdXvZ7w2pgJoZao2G3m2UeAYyGOLEuTL+d74ltOyW34bdTVIXAjHHDS0QkESi+QheJv6okUlp8w==
X-Received: by 2002:a17:902:f789:b0:192:9550:339a with SMTP id q9-20020a170902f78900b001929550339amr55698184pln.52.1675132529308;
        Mon, 30 Jan 2023 18:35:29 -0800 (PST)
Received: from [10.85.115.102] ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id v3-20020a17090331c300b001869ba04c83sm8449593ple.245.2023.01.30.18.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 18:35:28 -0800 (PST)
Message-ID: <d99bae6c-ac53-d803-95d2-c2a7bcf0c89a@bytedance.com>
Date:   Tue, 31 Jan 2023 10:35:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [External] Re: [PATCH] sched/core: Avoid WARN_DOUBLE_CLOCK
 warning when CONFIG_SCHED_CORE
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
References: <20221206070550.31763-1-jiahao.os@bytedance.com>
 <Y8UyqnVRNTcBD/V7@hirez.programming.kicks-ass.net>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <Y8UyqnVRNTcBD/V7@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/1/16 Peter Zijlstra wrote:
> On Tue, Dec 06, 2022 at 03:05:50PM +0800, Hao Jia wrote:
>> When we need to call update_rq_clock() to update the rq clock of
>> other CPUs on the same core, before that we need to clear RQCF_UPDATED
>> of rq->clock_update_flags to avoid the WARN_DOUBLE_CLOCK warning.
>> Because at this time the rq->clock_update_flags of other CPUs
>> may be RQCF_UPDATED.
> 
> So you've found that the WARN_DOUBLE_CLOCK machinery doesn't work for
> core-sched -- but then instead of fixing that machinery, you put
> band-aids on it :/
> 
> 
Hi, Peter
Sorry for the late reply. I just finished my holiday.

I am trying to adapt WARN_DOUBLE_CLOCK machinery for core-sched.

If sched_core_enabled(), we will get a core wide rq->lock, so we can
safely clear RQCF_UPDATED of rq->clock_update_flags of all CPUs on this
core.
This avoids a WARN_DOUBLE_CLOCK warning when we call update_rq_clock()
to update the rq clock of other cpus on the same core.

We cannot clear rq->clock_update_flags of other cpus on the same core in
rq_pin_lock(). Because in some functions, we will temporarily give up
core wide rq->lock, and then use raw_spin_rq_lock() to obtain core wide
rq->lock, such as newidle_balance() and _double_lock_balance().


Thanks,
Hao

---

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e838feb6adc5..f279912e30b3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -435,6 +435,21 @@ sched_core_dequeue(struct rq *rq, struct 
task_struct *p, int flags) { }

  #endif /* CONFIG_SCHED_CORE */

+static inline void sched_core_rq_clock_clear_update(struct rq *rq)
+{
+#ifdef CONFIG_SCHED_DEBUG
+       const struct cpumask *smt_mask;
+       int i;
+       if (rq->core_enabled) {
+               smt_mask = cpu_smt_mask(rq->cpu);
+               for_each_cpu(i, smt_mask) {
+                       if (rq->cpu != i)
+                               cpu_rq(i)->clock_update_flags &= 
(RQCF_REQ_SKIP|RQCF_ACT_SKIP);
+               }
+       }
+#endif
+}
+
  /*
   * Serialization rules:
   *
@@ -546,6 +561,7 @@ void raw_spin_rq_lock_nested(struct rq *rq, int 
subclass)
                 if (likely(lock == __rq_lockp(rq))) {
                         /* preempt_count *MUST* be > 1 */
                         preempt_enable_no_resched();
+                       sched_core_rq_clock_clear_update(rq);
                         return;
                 }
                 raw_spin_unlock(lock);
