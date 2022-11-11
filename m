Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334D26260C2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 19:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbiKKSCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 13:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbiKKSCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 13:02:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5660E63BA0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 10:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668189715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q+VFaP9yDxSExDVcEKpk1aWOcb0mRXqNdFbpZ1STzPg=;
        b=WWm4kzd9OmuGrR57kTRKlBGzQs/T3wbbhJnVKYov8DSKvH6QEk1VxYkADBmGiDT1AAAZmR
        sjfhV2XmAZA5pqDLCCkzDrh3aJE7A9YFikIK+kBT8hS3BdOa9YMBwsX1C6NeI1+6vAMBfw
        RJF1frAZ2TlYZQckpfrMWRlc0CeqH3I=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-624-lpKOK7l3MqOe-fw7n7r69g-1; Fri, 11 Nov 2022 13:01:54 -0500
X-MC-Unique: lpKOK7l3MqOe-fw7n7r69g-1
Received: by mail-qk1-f197.google.com with SMTP id x2-20020a05620a448200b006fa7dad5c1cso5290432qkp.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 10:01:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q+VFaP9yDxSExDVcEKpk1aWOcb0mRXqNdFbpZ1STzPg=;
        b=1maBaYjoT4c9FyDBONZhcefgvfY5bJLkewhFJ5q4gsbhQTudVLdrHfA/FKzAonCZ2M
         4N0/s4yxJdkgSJjU93pcZ5oSuMGw1wKMD2Ehf7VhsAMNviffghlXc8ZX1fBNyyLEO5PF
         fJzbnaqVb7ffQNVJKBqEtQ0ltOdCoLd0fpnaHfoEbXojHV0wRScszFePYiECnJ4wpFc8
         L5DsoAMmT13QWx93KRYTI4oloebSFi9v+GdLhkdvMlJgrdNmU23+T7jRroEam6io+YUg
         ikw2tWO1j9bzMkAn6cZ4WHZqKyU3X+F7yGxxmwMQY7pTi+tPR5XnU1mr09uNFZBWwPF+
         Enuw==
X-Gm-Message-State: ANoB5pnRjwtGFrxdpb/yfcZGevBf2xTYEhjfCxx0y0FdJ+jHsspU0uf1
        9Daa4s2bd12gsrxw1hytpxrrNMxrVTVG59vd5qveKd4cLsHlmRtGT8DhIn6f9nB88yVcsKL1gut
        +NmMxaGEJi40uUEWfZDr6MjKq
X-Received: by 2002:ac8:4e05:0:b0:3a5:926c:e824 with SMTP id c5-20020ac84e05000000b003a5926ce824mr2341392qtw.546.1668189713498;
        Fri, 11 Nov 2022 10:01:53 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5CHswaGItWsC6DrEunitMqwTz8zvmU6aVhtaB8D2n2MXV89b3m9NtakBxP0qqFLQQO5+9abw==
X-Received: by 2002:ac8:4e05:0:b0:3a5:926c:e824 with SMTP id c5-20020ac84e05000000b003a5926ce824mr2341374qtw.546.1668189713268;
        Fri, 11 Nov 2022 10:01:53 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id u16-20020a05620a0c5000b006cfc7f9eea0sm1764044qki.122.2022.11.11.10.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 10:01:52 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Chengming Zhou <zhouchengming@bytedance.com>, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH v2] sched/core: Minor optimize ttwu_runnable()
In-Reply-To: <20221108162402.99125-1-zhouchengming@bytedance.com>
References: <20221108162402.99125-1-zhouchengming@bytedance.com>
Date:   Fri, 11 Nov 2022 18:01:29 +0000
Message-ID: <xhsmhbkpdz7ye.mognet@vschneid.remote.csb>
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


Hi,

some minor changelog nitpicks, otherwise this LGTM

On 09/11/22 00:24, Chengming Zhou wrote:
> ttwu_runnable() is used as a fast wakeup path when the wakee task
> is running on CPU or runnable on RQ, in both cases we can just
> set its state to TASK_RUNNING to prevent a sleep.
>
> If the wakee task is on_cpu running, we don't need to update_rq_clock()
> or check_preempt_curr().
>
> But if the wakee task is on_rq && !on_cpu (e.g. an IRQ hit before
> the task got to schedule() and the task been preempted), we should
> check_preempt_curr() to see if it can preempt the current running.
>
> This patch reorg ttwu_do_wakeup() and ttwu_do_activate() to make
> ttwu_do_wakeup() only mark the task runnable, so it can be used
> in ttwu_runnable() and try_to_wake_up() fast paths.
>
> As for p->sched_class->task_woken(), ttwu_do_wakeup() needn't it
> anymore, since p isn't a woken task in this case, so should not
> affect RT/DL push/pull.

I would rephrase that last paragraph into something like:
"""
This also removes the class->task_woken() callback from ttwu_runnable(),
which wasn't required per the RT/DL implementations: any required push
operation would have been queued during class->set_next_task() when p
got preempted.

ttwu_runnable() also loses the update to rq->idle_stamp, as by definition
the rq cannot be idle in this scenario.
"""

>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> Suggested-by: Valentin Schneider <vschneid@redhat.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>

With those changes:

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

