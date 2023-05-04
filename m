Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7D86F6857
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjEDJdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjEDJdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:33:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BE84698
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 02:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683192757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Br2sdhxJExbXbcqoz/VU+uPPIl2iDyGjIsFcKxJYcBE=;
        b=RrtLX3cuFKxRZD9S0mslS6cAXKjFigKANVJvskN/0Hf59GfxbWluA7n6TRFRDcHsqMU6Jt
        tx1Mw9NKNwps6RKU2u8IixQXeVFJvhpaaPeZ1N7jdiD+btIzEOHdvoVwtCViHumVAGAI7I
        I1XunG5+XGH8JTuy7/a/VA+T2jjULmo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-Ku1KV5SaOLeaxWO12_c6Mg-1; Thu, 04 May 2023 05:32:36 -0400
X-MC-Unique: Ku1KV5SaOLeaxWO12_c6Mg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-2fbb99cb244so90412f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 02:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683192754; x=1685784754;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Br2sdhxJExbXbcqoz/VU+uPPIl2iDyGjIsFcKxJYcBE=;
        b=GjgPYtspV2dKtTphjK8Drxg0nv4FRXt/G++Ye+vTcTBf6Jw9Q3gcaUfcReLGDn5Bbl
         76GUVdy9QkA4GgisnkospYH601fvm1JHtQ6JaToyo68WvDIUZ6lt98RDTcUecuQ4IgLQ
         wMQWwW7xGnxAavj9RlchBdtJysKR2Arkr28ZokCBlMrkeoRqiOkBFH77qK2JFB6C1O77
         Yd9s19R0s1lgN4+a/rJX9l1biIAGA+b4nx+NUVhJjkd2wbUN0TV2LarhCnrExtK2okIn
         ZkGT5qt0OvBMwE0Tvl33+ueVdse1fveOJ/2QNyuFfyENZNwsoTZHioUQCM96rDjrC9w/
         Onyg==
X-Gm-Message-State: AC+VfDw6l0rm6vmLRA7qeO//G5xd6Cogge3peSU3JaWYNPL+Z2/oxjzW
        gPgUeTmkp6iVHLlvWmhXMJX47PekWMw23zvvyAnKrxYu83baMFABzkOyskH8PgaMZWHjTQeNScD
        kXc/GIjUH8D/F4MeTPdmt9FZZ
X-Received: by 2002:a05:6000:1292:b0:304:75b1:4dff with SMTP id f18-20020a056000129200b0030475b14dffmr2679664wrx.48.1683192754410;
        Thu, 04 May 2023 02:32:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7lFdaoDN/domYYFl97TJ7iMctTEG96htH3lecWTjBRB0SpQ5yaagyG1HTRY2lhM63g8FCxBg==
X-Received: by 2002:a05:6000:1292:b0:304:75b1:4dff with SMTP id f18-20020a056000129200b0030475b14dffmr2679627wrx.48.1683192754120;
        Thu, 04 May 2023 02:32:34 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id p17-20020a056000019100b002fda1b12a0bsm36383284wrx.2.2023.05.04.02.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 02:32:33 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Wander Lairson Costa <wander@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Brian Cain <bcain@quicinc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>, Hu Chunyu <chuhu@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v7 2/3] sched/task: Add the
 put_task_struct_atomic_safe() function
In-Reply-To: <20230504084229.GI1734100@hirez.programming.kicks-ass.net>
References: <20230425114307.36889-1-wander@redhat.com>
 <20230425114307.36889-3-wander@redhat.com>
 <20230504084229.GI1734100@hirez.programming.kicks-ass.net>
Date:   Thu, 04 May 2023 10:32:31 +0100
Message-ID: <xhsmha5ykjvbk.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/23 10:42, Peter Zijlstra wrote:
> On Tue, Apr 25, 2023 at 08:43:02AM -0300, Wander Lairson Costa wrote:
>> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
>> index b597b97b1f8f..cf774b83b2ec 100644
>> --- a/include/linux/sched/task.h
>> +++ b/include/linux/sched/task.h
>> @@ -141,6 +141,41 @@ static inline void put_task_struct_many(struct task_struct *t, int nr)
>>
>>  void put_task_struct_rcu_user(struct task_struct *task);
>>
>> +extern void __delayed_put_task_struct(struct rcu_head *rhp);
>> +
>> +static inline void put_task_struct_atomic_safe(struct task_struct *task)
>> +{
>> +	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
>> +		/*
>> +		 * Decrement the refcount explicitly to avoid unnecessarily
>> +		 * calling call_rcu.
>> +		 */
>> +		if (refcount_dec_and_test(&task->usage))
>> +			/*
>> +			 * under PREEMPT_RT, we can't call put_task_struct
>> +			 * in atomic context because it will indirectly
>> +			 * acquire sleeping locks.
>> +			 * call_rcu() will schedule __delayed_put_task_struct()
>> +			 * to be called in process context.
>> +			 *
>> +			 * __put_task_struct() is called when
>> +			 * refcount_dec_and_test(&t->usage) succeeds.
>> +			 *
>> +			 * This means that it can't conflict with
>> +			 * put_task_struct_rcu_user() which abuses ->rcu the same
>> +			 * way; rcu_users has a reference so task->usage can't be
>> +			 * zero after rcu_users 1 -> 0 transition.
>> +			 *
>> +			 * delayed_free_task() also uses ->rcu, but it is only called
>> +			 * when it fails to fork a process. Therefore, there is no
>> +			 * way it can conflict with put_task_struct().
>> +			 */
>> +			call_rcu(&task->rcu, __delayed_put_task_struct);
>> +	} else {
>> +		put_task_struct(task);
>> +	}
>> +}
>
> Urgh.. that's plenty horrible. And I'm sure everybody plus kitchen sink
> has already asked why can't we just rcu free the thing unconditionally.
>
> Google only found me an earlier version of this same patch set, but I'm
> sure we've had that discussion many times over the past several years.
> The above and your follow up patch is just horrible.
>

So on v3/v4 we got to doing that unconditionally for PREEMPT_RT, but per
[1] Wander went back to hand-fixing the problematic callsites.

Now that I'm looking at it again, I couldn't find a concrete argument from
Oleg against doing this unconditionally - as Wander is pointing out in the
changelog and comments, reusing task_struct.rcu for that purpose is safe
(although not necessarily obviously so).

Is this just miscommunication, or is there a genuine issue with doing this
unconditionally? As argued before, I'd also much rather have this be an
unconditional call_rcu() (regardless of context or PREEMPT_RT).

