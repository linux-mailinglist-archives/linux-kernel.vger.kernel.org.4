Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9D363715A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 05:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiKXEAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 23:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKXEAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 23:00:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749B5BB5DB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 19:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669262385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fkz2hylbW8HZpQmkw323Z/bRPjmhymi1XUFxPAPRTlU=;
        b=aOHHhtJ7GYeKlh0unvbg8Vqz7qCscZzR39nJd+xs8H1Yzef6xa9xu532/bYRwNRqJbRfdh
        Wl0VErhCJ3gazNGCi4z6O86kM4fLg4iLQ3bxOuopBFrJSspvT8LqYZFUcmBlGHGpWL/Fbn
        For7TV+0s7MJVadwv83mc0DqdMdSdGQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279-Oo5-gaD1Nty-ITLVfF6ElA-1; Wed, 23 Nov 2022 22:59:42 -0500
X-MC-Unique: Oo5-gaD1Nty-ITLVfF6ElA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3FE51C05AA3;
        Thu, 24 Nov 2022 03:59:41 +0000 (UTC)
Received: from [10.22.8.49] (unknown [10.22.8.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2CAC7492B04;
        Thu, 24 Nov 2022 03:59:41 +0000 (UTC)
Message-ID: <0b50b719-b8df-decb-b6ed-12be8f623ad0@redhat.com>
Date:   Wed, 23 Nov 2022 22:59:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW0V4dGVybmFsIE1haWxdUmU6IFtQQVRDSCAxLzFd?=
 =?UTF-8?Q?_sched=3a_fix_user=5fmask_double_free?=
Content-Language: en-US
To:     =?UTF-8?B?RGF2aWQgV2FuZyDnjovmoIc=?= <wangbiao3@xiaomi.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wenjieli@qti.qualcomm.com" <wenjieli@qti.qualcomm.com>,
        =?UTF-8?B?6ZmI5Yag5pyJ?= <chenguanyou@xiaomi.com>,
        Will Deacon <will@kernel.org>,
        =?UTF-8?B?VGluZzExIFdhbmcg546L5am3?= <wangting11@xiaomi.com>
References: <cover.1669020858.git.wangbiao3@xiaomi.com>
 <b8970a530d420109ee9fe0b268e097fb839211b0.1669020858.git.wangbiao3@xiaomi.com>
 <Y3zXDZeTUgDz2hJ8@hirez.programming.kicks-ass.net>
 <a7fb3cac-176f-3928-f3a3-23c25ab9677e@redhat.com>
 <1c3ce8c4-354d-2f00-1dc6-e13cbe389828@redhat.com>
 <1fe9abbdd12b41fc87c92b60550fc909@xiaomi.com>
 <9a6b10cd-855d-ca15-01e9-2c95a8b692be@redhat.com>
 <9cc51697705f472e99a620eee8569a32@xiaomi.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <9cc51697705f472e99a620eee8569a32@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/22 21:37, David Wang 王标 wrote:
>
> Dear Waiman,
>
> Yes, we have read 
> https://lore.kernel.org/lkml/20221123131612.914906-1-longman@redhat.com/ 
>  and checked it  carefully.
>
> We mean dup_user_cpus_ptr should not judge if the src->user_cpus_ptr 
> is null at the entry of the
> Function dup_user_cpus_ptr.
> If do this when user_cpus_ptr is freed by othe thread, but the parent 
> task copy the user_cpus_ptr
> data for new task through dup_task_struct 
> <https://opengrok.qualcomm.com/source/s?refs=dup_task_struct&project=KERNEL.PLATFORM.2.0> 
> -> arch_dup_task_struct 
> <https://opengrok.qualcomm.com/source/xref/KERNEL.PLATFORM.2.0/kernel_platform/common/kernel/fork.c#arch_dup_task_struct>(tsk 
> <https://opengrok.qualcomm.com/source/s?defs=tsk&project=KERNEL.PLATFORM.2.0>, 
> orig 
> <https://opengrok.qualcomm.com/source/s?defs=orig&project=KERNEL.PLATFORM.2.0>) 
> before the user_cpus_ptr
> ,
> is freed, ,next , when dup_task_struct 
> <https://opengrok.qualcomm.com/source/s?refs=dup_task_struct&project=KERNEL.PLATFORM.2.0> 
> call dup_user_cpus_ptr 
> <https://opengrok.qualcomm.com/source/s?defs=dup_user_cpus_ptr&project=KERNEL.PLATFORM.2.0>(tsk 
> <https://opengrok.qualcomm.com/source/s?defs=tsk&project=KERNEL.PLATFORM.2.0>, 
> orig 
> <https://opengrok.qualcomm.com/source/s?defs=orig&project=KERNEL.PLATFORM.2.0>, 
> node 
> <https://opengrok.qualcomm.com/source/s?defs=node&project=KERNEL.PLATFORM.2.0>),it 
> will return directly
> without doing nothing.  When wake up new task , then call 
> select_fallback_rqàdo_set_cpus_allowed,
> it will meet slub double free issue.  Then new path can not fix issue 
> in this scenario.
> void do_set_cpus_allowed(struct task_struct *p, const struct cpumask 
> *new_mask)
> {
>         struct affinity_context ac = {
>                .new_mask  = new_mask,
>                .user_mask = NULL,
>                .flags     = SCA_USER,      /* clear the user requested 
> mask */
>         };
>         __do_set_cpus_allowed(p, &ac);
>         kfree(ac.user_mask);
> }
> Kfree kfree(ac.user_mask) cause double free issue. New patch just 
> cover the user_cpus_ptr is freed
> after  code running into raw_spin_lock_irqsave, if it can not enter 
> into pi_lock critical section,
> what will happen.
>
> Maybe should delte following code at the entry of fuction . Please 
> help check it.
>
> -       if (!src->user_cpus_ptr)     //delete this
>
> -              return 0;            //delete  this
>
> We think maybe path needs a little more modification like following :
>
> kernel/sched/core.c 
> <https://lore.kernel.org/lkml/20221123131612.914906-1-longman@redhat.com/#Z31kernel:sched:core.c> 
> | 23 +++++++++++++++++++++--
>
> 1 file changed 
> <https://lore.kernel.org/lkml/20221123131612.914906-1-longman@redhat.com/#related>, 
> 21 insertions(+), 2 deletions(-)
>
> diff 
> <https://lore.kernel.org/lkml/20221123131612.914906-1-longman@redhat.com/#iZ31kernel:sched:core.c> 
> --git a/kernel/sched/core.c b/kernel/sched/core.c
>
> index 8df51b08bb38..6b259d9e127a 100644
>
> --- a/kernel/sched/core.c
>
> +++ b/kernel/sched/core.c
>
> @@ -2624,8 +2624,14 @@ void do_set_cpus_allowed(struct task_struct *p, 
> const struct cpumask *new_mask)
>
> int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
>
>       int node)
>
> {
>
> + cpumask_t *user_mask = NULL;
>
>        unsigned long flags;
>
> + /*
>
> + * This check is racy and losing the race is a valid situation.
>
> + * It is not worth the extra overhead of taking the pi_lock on
>
> + * every fork/clone.
>
> + */
>
> -       if (!src->user_cpus_ptr) //delete this
>
> -              return 0;            //delete this
>
The clearing of user_cpus_ptr is protected by pi_lock. IOW, racing 
between dup_user_cpus_ptr() and do_set_cpus_allowed is not possible and 
double free like what you have suggested should not happen. Yes, the 
user_cpus_ptr check here is racy. The worst case result is that a 
user_cpus_ptr has just been set in the task to be cloned, but it fail to 
copy over the user mask. With or without the check, the race can happen. 
The check is an optimization. Its effect is just make one outcome more 
likely than the other.

Cheers,
Longman

