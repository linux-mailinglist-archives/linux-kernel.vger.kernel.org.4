Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7481067EA12
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbjA0P4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjA0P4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:56:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE3B8325A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674834953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/bK5h6MNc8//WNGJnMK1c7CKTs5twWL/WXAB2tkv6zA=;
        b=U4EeiJtpcdC69qKLu8qgw6e+YUyOSK2nokwWtMnQGULC7eGWLxQ0shX6ShuP3hNxu5dgIE
        Bp+mIdTjwG3GcCqTANUkqHDSSrMAbogt9V19HQswkDSi4gUNIVcfMkZ/GVxjHrd1dM3m/n
        ASirrd0e3IXOcTg3i2D7ewqdyeHpZXg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-246-iS7_y9-oMyuy8DWQpctlzg-1; Fri, 27 Jan 2023 10:55:52 -0500
X-MC-Unique: iS7_y9-oMyuy8DWQpctlzg-1
Received: by mail-qk1-f198.google.com with SMTP id u11-20020a05620a430b00b007052a66d201so3245802qko.23
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:55:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/bK5h6MNc8//WNGJnMK1c7CKTs5twWL/WXAB2tkv6zA=;
        b=e2s85F3hNICIATYVx5+LxmSd8kLNG4DnrFqTlnVVmh5DPI10ZyOgQj7u3iK8sDrLus
         bgW2n3CZ9h9kad7bRoJjHJ5mMT7HI5WWa5ajmiNVYlA9eWX2mF5kc8ocNfwMlQYI6rVb
         e2zTrqV1lo3w9OXENizA0v43/ncUDLn5ILuZ0qf6lqvJnEzuTKa9OufDC2lRDCo1nW7E
         +qWUc07bHm8+vrQ4MF3HDvuQGfs7/JBouJ8cEGWKjyNfkLvXz9qe5yzAzG6O/ObJ1q+M
         QQJGPpTMopnFWw4FppAYcBHz/RdIpxeubF7p0vQ7OmTcA1jpPIm1n2Eeli17sssk+jwy
         2RVg==
X-Gm-Message-State: AFqh2kqGSaB7kbwSwaBfTKiFswnV0F7uf5yS3K2jr8DmG7568mp2rL+1
        SNukZj/S2LPP4GX6+etP8to+sRKnYVx7i+R7BoQ1OWajN+cthwG1mNaF4Nsl5+b7EcklJzCJRbT
        jBngr9DGR6BfhH6aChFwpkg3F
X-Received: by 2002:a05:622a:5c99:b0:3a8:1295:f96a with SMTP id ge25-20020a05622a5c9900b003a81295f96amr57886223qtb.7.1674834951939;
        Fri, 27 Jan 2023 07:55:51 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv7v58yQGul2fxk2rVUyy+r0kUuWTQaTyuEkYOfHCJvOhx+n9Z7LgVEZTgMVeLQ+x2QkpJLhw==
X-Received: by 2002:a05:622a:5c99:b0:3a8:1295:f96a with SMTP id ge25-20020a05622a5c9900b003a81295f96amr57886195qtb.7.1674834951663;
        Fri, 27 Jan 2023 07:55:51 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id n27-20020a05620a153b00b00704c9015e68sm3032043qkk.116.2023.01.27.07.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 07:55:51 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Wander Lairson Costa <wander@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Stafford Horne <shorne@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: [PATCH v2 1/4] sched/task: Add the put_task_struct_atomic_safe
 function
In-Reply-To: <CAAq0SUk1vfNDuzGbXNftgW4wq4PC_EzMhpq4E=RBQNkOB3f4YQ@mail.gmail.com>
References: <20230120150246.20797-1-wander@redhat.com>
 <20230120150246.20797-2-wander@redhat.com>
 <20230123163002.GB6268@redhat.com>
 <CAAq0SUk1vfNDuzGbXNftgW4wq4PC_EzMhpq4E=RBQNkOB3f4YQ@mail.gmail.com>
Date:   Fri, 27 Jan 2023 15:55:47 +0000
Message-ID: <xhsmhbkmkdla4.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/23 14:24, Wander Lairson Costa wrote:
> On Mon, Jan 23, 2023 at 1:30 PM Oleg Nesterov <oleg@redhat.com> wrote:
>>
>> On 01/20, Wander Lairson Costa wrote:
>> >
>> > +static inline void put_task_struct_atomic_safe(struct task_struct *task)
>> > +{
>> > +     if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
>> > +             /*
>> > +              * Decrement the refcount explicitly to avoid unnecessarily
>> > +              * calling call_rcu.
>> > +              */
>> > +             if (refcount_dec_and_test(&task->usage))
>> > +                     /*
>> > +                      * under PREEMPT_RT, we can't call put_task_struct
>> > +                      * in atomic context because it will indirectly
>> > +                      * acquire sleeping locks.
>> > +                      */
>> > +                     call_rcu(&task->rcu, __delayed_put_task_struct);
>>                                   ^^^^^^^^^
>> I am not sure the usage of task->rcu is safe...
>>
>> Suppose that, before __delayed_put_task_struct() is called by RCU, this task
>> does the last schedule and calls put_task_struct_rcu_user().
>>
>> And, can't we simply turn put_task_struct() into something like
>>
>>         put_task_struct(struct task_struct *t)
>>         {
>>                 if (refcount_dec_and_test(&t->usage)) {
>>                         if (IS_ENABLED(CONFIG_PREEMPT_RT)
>>                             && (in_atomic() || irqs_disabled()))
>>                                 call_rcu(...);
>>                         else
>>                                 __put_task_struct(t);
>>                 }
>>         }
>>
>> ?
>
> Yeah, that was one approach I thought about. I chose to use an
> explicit function because I assumed calling __put_task_struct() from a
> non-preemptable context should be the exception, not the rule.

I'd tend to agree.

> Therefore (if I am correct in my assumption), it would make sense for
> only some call sites to pay the overhead price for it. But this is
> just a guess, and I have no evidence to support my claim.

My worry here is that it's easy to miss problematic callgraphs, and it's
potentially easy for new ones to creep in. Having a solution within
put_task_struct() itself would prevent that.

Another thing, if you look at release_task_stack(), it either caches the
outgoing stack for later use, or frees it via RCU (regardless of
PREEMPT_RT). Perhaps we could follow that and just always punt the freeing
of the task struct to RCU?

