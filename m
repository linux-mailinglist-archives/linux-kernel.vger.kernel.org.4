Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E57675BE5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjATRqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjATRqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:46:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF4D5E52E
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674236712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KDOmQTuMJjaRjeSS0NisXXC7yuCfwxS18QfehfrTcFs=;
        b=hfKezTBQ4HPAMvHimI3uP/e/j9YCsmar4S8QV9coH3fB4JJ5P2mpJTbauxq0cWjmuMOHFF
        xSuFSnla4IfXnjY94TUtyMHx3tYFvU/6z5UckAZ1ERPcb314quGy+0PsGZry3+lMsl9x3b
        9K5DzWzRWd6mZohU8xU99yMfD7qDI6o=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-375-GMKTOS4lM5CqRRG1l_Bntg-1; Fri, 20 Jan 2023 12:45:08 -0500
X-MC-Unique: GMKTOS4lM5CqRRG1l_Bntg-1
Received: by mail-qk1-f200.google.com with SMTP id y3-20020a05620a44c300b00709109448a3so1892732qkp.19
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:45:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KDOmQTuMJjaRjeSS0NisXXC7yuCfwxS18QfehfrTcFs=;
        b=Y4EQjjdi7VVpQucLeK7bija/EIiX8I30aQ+K4Eh58RKUAOgoL8tCMw3mcC64Thvf93
         ZRYSTo5woW5TBsps0SNWLh8eh3E2YvdqZlJSzG5GGQ6bPXO4Kd0hmZ9AYrLAEVbKAMpL
         IsjlF3H3+nXv3uHTE7z4EKFV4n5HF3WOII8b7KgogwYFkCHeriefCG8QiHpMQ8uCW1a5
         khJnN+leG2vU/+gV+89YjIqWFYXkj6U6uvuEl3v+WaSuEwTpJe9fNjFrDW9U07G8gGui
         kEOSBymJZCQp8Lhn6kbBCqTgfLgB+wVVxREagqJ+bAL+OA04+F7nP0fUq2qRJwny2/5Y
         WkDg==
X-Gm-Message-State: AFqh2koRSi2NyU5KZJJQBOWQXk67k0M9fBzuZv9YiFaBo9iQixGl1GE7
        /mjtdTCCtngz22ms9hZ/k55fpxUjhTBZ8iz+DixbO7AD5/EfsDHujMnB8nDH2Htv/xhcIrId6v1
        yeQzA4eUXrnsJ2HFrSHSAvrWA2S3WPkfBBMSmGDBXwWek04EG+UCofGbkfj/tntgWQEBwSkH4nF
        Ly
X-Received: by 2002:a05:622a:2586:b0:3b6:2e1c:616e with SMTP id cj6-20020a05622a258600b003b62e1c616emr35012574qtb.22.1674236707810;
        Fri, 20 Jan 2023 09:45:07 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtEsUyMq+icjqWSfsyPcm42rWdQmOLGRk+P+s9YhlRTi03alS+dwSNklE6UkM/tz2oo2mi+8w==
X-Received: by 2002:a05:622a:2586:b0:3b6:2e1c:616e with SMTP id cj6-20020a05622a258600b003b62e1c616emr35012529qtb.22.1674236707516;
        Fri, 20 Jan 2023 09:45:07 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id v3-20020a05620a440300b00708fd79fab7sm3047975qkp.101.2023.01.20.09.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 09:45:06 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Wander Lairson Costa <wander@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] Fix put_task_struct() calls under PREEMPT_RT
In-Reply-To: <20230120150246.20797-1-wander@redhat.com>
References: <20230120150246.20797-1-wander@redhat.com>
Date:   Fri, 20 Jan 2023 17:45:01 +0000
Message-ID: <xhsmhy1pxgkwy.mognet@vschneid.remote.csb>
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

On 20/01/23 12:02, Wander Lairson Costa wrote:
> put_task_struct() decrements a usage counter and calls
> __put_task_struct() if the counter reaches zero.
>
> __put_task_struct() indirectly acquires a spinlock, which is a sleeping
> lock under PREEMPT_RT. Therefore, we can't call put_task_struct() in an
> atomic context in RT kernels.
>
> This patch series introduces put_task_struct_atomic_safe(), which defers
> the call to __put_task_struct() to a process context when compiled with
> PREEMPT_RT.
>
> It also fixes known problematic call sites.
>

Browsing around put_task_struct() callsites gives me the impression there
are more problematic call sites lurking around, which makes me wonder:
should we make the PREEMPT_RT put_task_struct() *always* be done via
call_rcu()?

The task's stack is actually always freed that way in put_task_stack(), cf.

  e540bf3162e8 ("fork: Only cache the VMAP stack in finish_task_switch()")

> Changelog:
> ==========
>
> v2:
>  * Add the put_task_struct_atomic_safe() function that is responsible for
>    handling the conditions to call put_task_struct().
>  * Replace put_task_struct() by put_task_struct_atomic_safe() in known
>    atomic call sites.
>
> Wander Lairson Costa (4):
>   sched/task: Add the put_task_struct_atomic_safe function
>   sched/deadline: fix inactive_task_timer splat
>   sched/rt: use put_task_struct_atomic_safe() to avoid potential splat
>   sched/core: use put_task_struct_atomic_safe() to avoid potential splat
>
>  include/linux/sched/task.h | 21 +++++++++++++++++++++
>  kernel/fork.c              |  8 ++++++++
>  kernel/sched/core.c        |  2 +-
>  kernel/sched/deadline.c    |  2 +-
>  kernel/sched/rt.c          |  4 ++--
>  5 files changed, 33 insertions(+), 4 deletions(-)
>
> --
> 2.39.0

