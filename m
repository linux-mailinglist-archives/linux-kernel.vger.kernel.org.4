Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B16741B9D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 00:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjF1WBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 18:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjF1WBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 18:01:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF27107
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 15:01:43 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687989702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JlPsTklnnnm336I84+lRNtdD8MZIAjpKQwAL33RrC/w=;
        b=sAyPGH1N4pNf9UEOKZvn7yuH/1KRvFtkyyaApk2QwcEG5oHLCo5f10RKmpCky2SmhplW+M
        hoFbiM/5WoZ7UGKPwyCiZFzUfWW7sAsV1XDJBB/7X5ovLVH7oBkT4+c6iFASZntNZpwJsx
        9YSFIMO/7P1LlZK2tGK10+fZmnWxAtlLdmrHPiNnaadK3uP9NNCrqgwwWHjgsXhCzHfOFi
        7/zsV3T9mG5jJn1Y6b24WJfmXUK5z8IEc+UjUupjtKAGBpZZuLEUzS86kIVj5qdHBwzKjZ
        NfZpo8IHW6MSW4WBRjmKsXllUMASxu6ClBvyq07EpTQuXs6dWJ88s2JYXn9aXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687989702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JlPsTklnnnm336I84+lRNtdD8MZIAjpKQwAL33RrC/w=;
        b=+pJqfi4H7+8CUs2D8ZVkkYvaH8ya5QnNA3YBfTv3vRZ1KPfamcqHyNTCfEeTuPLd6P7BXQ
        GVeWnOR414OBDWBA==
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>, vschneid@redhat.com,
        Phil Auld <pauld@redhat.com>, vdonnefort@google.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Li <liwei391@huawei.com>,
        "liaoyu (E)" <liaoyu15@huawei.com>, zhangqiao22@huawei.com,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [Question] report a race condition between CPU hotplug state
 machine and hrtimer 'sched_cfs_period_timer' for cfs bandwidth throttling
In-Reply-To: <CAKfTPtAzTy4KPrBNRA4cMeTonxn5EKLEAg0b9iH5ecJkAMEStw@mail.gmail.com>
References: <8e785777-03aa-99e1-d20e-e956f5685be6@huawei.com>
 <87mt18it1y.ffs@tglx> <68baeac9-9fa7-5594-b5e7-4baf8ac86b77@huawei.com>
 <ba352e83-b8b1-d900-9c1f-56b8c8a8b8fb@huawei.com>
 <CAKfTPtBoe_jRn-EMsQxssQ4BcveT+Qcd+GmsRbQEXQDGfzFOMg@mail.gmail.com>
 <875y774wvp.ffs@tglx>
 <CAKfTPtAzTy4KPrBNRA4cMeTonxn5EKLEAg0b9iH5ecJkAMEStw@mail.gmail.com>
Date:   Thu, 29 Jun 2023 00:01:41 +0200
Message-ID: <87pm5f2qm2.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28 2023 at 14:35, Vincent Guittot wrote:
> On Wed, 28 Jun 2023 at 14:03, Thomas Gleixner <tglx@linutronix.de> wrote:
>> No, because this is fundamentally wrong.
>>
>> If the CPU is on the way out, then the scheduler hotplug machinery
>> has to handle the period timer so that the problem Xiongfeng analyzed
>> does not happen in the first place.
>
> But the hrtimer was enqueued before it starts to offline the cpu

It does not really matter when it was enqueued. The important point is
that it was enqueued on that outgoing CPU for whatever reason.

> Then, hrtimers_dead_cpu should take care of migrating the hrtimer out
> of the outgoing cpu but :
> - it must run on another target cpu to migrate the hrtimer.
> - it runs in the context of the caller which can be throttled.

Sure. I completely understand the problem. The hrtimer hotplug callback
does not run because the task is stuck and waits for the timer to
expire. Circular dependency.

>> sched_cpu_wait_empty() would be the obvious place to cleanup armed CFS
>> timers, but let me look into whether we can migrate hrtimers early in
>> general.
>
> but for that we must check if the timer is enqueued on the outgoing
> cpu and we then need to choose a target cpu.

You're right. I somehow assumed that cfs knows where it queued stuff,
but obviously it does not.

I think we can avoid all that by simply taking that user space task out
of the picture completely, which avoids debating whether there are other
possible weird conditions to consider alltogether.

Something like the untested below should just work.

Thanks,

        tglx
---
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1490,6 +1490,13 @@ static int cpu_down(unsigned int cpu, en
 	return err;
 }
 
+static long __cpu_device_down(void *arg)
+{
+	struct device *dev = arg;
+
+	return cpu_down(dev->id, CPUHP_OFFLINE);
+}
+
 /**
  * cpu_device_down - Bring down a cpu device
  * @dev: Pointer to the cpu device to offline
@@ -1502,7 +1509,12 @@ static int cpu_down(unsigned int cpu, en
  */
 int cpu_device_down(struct device *dev)
 {
-	return cpu_down(dev->id, CPUHP_OFFLINE);
+	unsigned int cpu = cpumask_any_but(cpu_online_mask, dev->id);
+
+	if (cpu >= nr_cpu_ids)
+		return -EBUSY;
+
+	return work_on_cpu(cpu, __cpu_device_down, dev);
 }
 
 int remove_cpu(unsigned int cpu)
