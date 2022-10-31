Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8851614036
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 22:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiJaV4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 17:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJaV4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 17:56:18 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D4E140CA
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 14:56:18 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so17129029pjc.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 14:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uvYZNQDziAHvtHngpIip5+ezNIS5JG1pvAy9dd4TxpE=;
        b=DfJlDLVLgorokxki2nr8OZDvus4mEGdtGrLBfEMqr8bKzjbkxiC/oPs5WocqyL7oNY
         9zSjcbNxoKpQzJDJnJ8F98odXZg7OKKk4ZSIVhpGR7WxAZt3Q110UOLmgtsPIWJx1xUh
         yuD9pZIqpwkTHfm4XQxf9Q01/RQ6hOMPsxQBhIcDAikCJQQZq0d3bw+41mgDpN9AHQQX
         lnomkO+ZOSvJwzqxt+JcJIfNMgUhIkSPuRy0+vZlpgEods02PuT/kfPYrFqaJUTH8A6+
         0q1CfYK52FGE2xXuI18qtH/t5hXFm1mpY0o0FUpAhFrGpqbT4rAzPiCJGQozMwSGnh3j
         IaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvYZNQDziAHvtHngpIip5+ezNIS5JG1pvAy9dd4TxpE=;
        b=w+sCh+k6TT++UWDZ5VuZ7YiAPA2E3gWj78GFMhhro+KO5+NXqu8b84a2tKz83BgkwV
         RYboxHQJDosPQuEUUdk+aBwHIyLTz0rFqC0P3xG/jOaZoILhwyTsxL/36D54y5xUUNc2
         dDApCiNqVTYUvTNP1ie7Ko1+wmM4x/hpeHISZTV/3KuHoKP8u2QkchPbsDDwwN2Nmm3z
         RDXEzCv69F7m2aN6z13XnTukwUwOBWGntFxOKv00V39KpygZcf5l0fITeLi967/SewrZ
         iMD5o2T5VTvYe3ZRLTafSrSXUQq674NIRcUqJyluXr2MzMWFFglKw/+T3EubZ7JRWFv7
         z15g==
X-Gm-Message-State: ACrzQf3ZuivXma5M8weWE1hkaTvv0vnFRxY/BFENZRnJOkSXjYhkVw0+
        Je7dm2WDlJ+kojGgNrz0C+EwOQ==
X-Google-Smtp-Source: AMsMyM70dzmWPWuPQ93zYfsHtMAwMAe1akN99tiCGkXzDC6yjdc6KuLr30SZXqJxnFvhCM9PUJeLEw==
X-Received: by 2002:a17:90a:680d:b0:213:d200:e992 with SMTP id p13-20020a17090a680d00b00213d200e992mr9893924pjj.220.1667253377626;
        Mon, 31 Oct 2022 14:56:17 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-67-188-112-16.hsd1.ca.comcast.net. [67.188.112.16])
        by smtp.gmail.com with ESMTPSA id b9-20020aa78ec9000000b0056abfa74eddsm5235937pfr.147.2022.10.31.14.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 14:56:16 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] sched: async unthrottling for cfs bandwidth
References: <20221026224449.214839-1-joshdon@google.com>
        <Y1/HzzA1FIawYM11@hirez.programming.kicks-ass.net>
Date:   Mon, 31 Oct 2022 14:56:13 -0700
In-Reply-To: <Y1/HzzA1FIawYM11@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Mon, 31 Oct 2022 14:04:15 +0100")
Message-ID: <xm26fsf3wtc2.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Wed, Oct 26, 2022 at 03:44:49PM -0700, Josh Don wrote:
>> CFS bandwidth currently distributes new runtime and unthrottles cfs_rq's
>> inline in an hrtimer callback. Runtime distribution is a per-cpu
>> operation, and unthrottling is a per-cgroup operation, since a tg walk
>> is required. On machines with a large number of cpus and large cgroup
>> hierarchies, this cpus*cgroups work can be too much to do in a single
>> hrtimer callback: since IRQ are disabled, hard lockups may easily occur.
>> Specifically, we've found this scalability issue on configurations with
>> 256 cpus, O(1000) cgroups in the hierarchy being throttled, and high
>> memory bandwidth usage.
>> 
>> To fix this, we can instead unthrottle cfs_rq's asynchronously via a
>> CSD. Each cpu is responsible for unthrottling itself, thus sharding the
>> total work more fairly across the system, and avoiding hard lockups.
>
> So, TJ has been complaining about us throttling in kernel-space, causing
> grief when we also happen to hold a mutex or some other resource and has
> been prodding us to only throttle at the return-to-user boundary.
>
> Would this be an opportune moment to do this? That is, what if we
> replace this CSD with a task_work that's ran on the return-to-user path
> instead?

This is unthrottle, not throttle, but it would probably be
straightfoward enough to do what you said for throttle. I'd expect this
to not help all that much though, because throttle hits the entire
cfs_rq, not individual threads.

I'm currently trying something more invasive, which doesn't throttle a
cfs_rq while it has any kernel tasks, and prioritizes kernel tasks / ses
containing kernel tasks when a cfs_rq "should" be throttled. "Invasive"
is a key word though, as it needs to do the sort of h_nr_kernel_tasks
tracking on put_prev/set_next in ways we currently only need to do on
enqueue/dequeue.
