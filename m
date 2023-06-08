Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BFE7289E7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 23:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236950AbjFHVGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 17:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236417AbjFHVGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 17:06:30 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3D92D51
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 14:06:27 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b1fdab9d68so262835ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 14:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686258386; x=1688850386;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jv2tN0JqBK7d6JW9O3sH3O61Mg4WAY/x7lHveUrWRVk=;
        b=3KMWfVUkEzATOh1/DghMUglCGUV9387S6S6NpJpiGHH8ZONDQEaaykX5QlVGArTItK
         wjOTcwSGGvvlDqrSuYgwTAbLQBdi9s8v6cE8TzVeXhT6Rk/XshOklhP1mxMKZR7X/IqF
         ldHzZrjoYAmwtMQPAT/i3C0Lp8RBeZV7QYWmCjXadPOBSIPh/DLTQKhZ4GicoR423AwX
         6fli/EXqF1fvpHn8jYpOCeCx+P1c+CDwZtYI0EAjNptd+gf9P2QQs3gqh9GD8Tov+Jaw
         u5QdAth6q54HcsEuCxP7PRippTvMTMfPN5ILaOapyuu6O12ibiBFqdTQ56s8LlY3gZYP
         PY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686258386; x=1688850386;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jv2tN0JqBK7d6JW9O3sH3O61Mg4WAY/x7lHveUrWRVk=;
        b=KInBVXkutZqml3TTCrIWO21x7U3nvlGRSBk/fY1cILj/JWXyY/jv+uxWj3jiRx2UZJ
         PomJiyJeVUPxCygTN/T2kQalLRywfqi3LlU0vtIKNBjF+ORduaqFxihtyJpdMZl1tHrt
         5rWwqZ727O3ijdv9dqb0fyb34CfHJS7Qe3sAQl0gI0trQg5Pd7k3ueVeV1BPDbxRo2Um
         ndtcLN6aWLo7DmYBUrf+2zv765QDvr+Nx3h65Cn3tljPcVfhtyFhBOhmyVp5ICfLE5JK
         lSyaZWWzftD7TwuVYZIh4lq7+qsGZRfu604BBU+1P61n4obGw3GBWEwCOIRFyiSH92wL
         14jQ==
X-Gm-Message-State: AC+VfDzyTU+WCeWcDrkbAQhDHZ8igw0piiEekZi9dcBJeE+z1mPgnPVP
        GAxcHhIWEN/DJg/XpnrVP0rFlfOlt5Zw4X+BaTf2GAHZ8UU=
X-Google-Smtp-Source: ACHHUZ5jjIPNAv3M5nDF/cvGyS1MuQrKg/+FZbWKf8z85iPhpEtK8NV11FC1SjohA/BTdNKHnf3kIg==
X-Received: by 2002:a17:902:ced0:b0:1b0:2a98:90d4 with SMTP id d16-20020a170902ced000b001b02a9890d4mr302835plg.3.1686258385884;
        Thu, 08 Jun 2023 14:06:25 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-158-249-138.hsd1.ca.comcast.net. [73.158.249.138])
        by smtp.gmail.com with ESMTPSA id b16-20020a170902d51000b001af98dcf958sm1829384plg.288.2023.06.08.14.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 14:06:24 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] sched/core: Avoid multiple calling
 update_rq_clock() in unthrottle_offline_cfs_rqs()
References: <20230608063312.79440-1-jiahao.os@bytedance.com>
        <20230608063312.79440-5-jiahao.os@bytedance.com>
Date:   Thu, 08 Jun 2023 14:06:21 -0700
In-Reply-To: <20230608063312.79440-5-jiahao.os@bytedance.com> (Hao Jia's
        message of "Thu, 8 Jun 2023 14:33:12 +0800")
Message-ID: <xm26zg59acky.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hao Jia <jiahao.os@bytedance.com> writes:

> This WARN_DOUBLE_CLOCK warning is triggered during cpu offline.
> ------------[ cut here ]------------
> rq->clock_update_flags & RQCF_UPDATED
> WARNING: CPU: 0 PID: 3323 at kernel/sched/core.c:741
> update_rq_clock+0xaf/0x180
> Call Trace:
>  <TASK>
>  unthrottle_cfs_rq+0x4b/0x300
>  rq_offline_fair+0x89/0x90
>  set_rq_offline.part.118+0x28/0x60
>  rq_attach_root+0xc4/0xd0
>  cpu_attach_domain+0x3dc/0x7f0
>  partition_sched_domains_locked+0x2a5/0x3c0
>  rebuild_sched_domains_locked+0x477/0x830
>  rebuild_sched_domains+0x1b/0x30
>  cpuset_hotplug_workfn+0x2ca/0xc90
>  ? balance_push+0x56/0xf0
>  ? _raw_spin_unlock+0x15/0x30
>  ? finish_task_switch+0x98/0x2f0
>  ? __switch_to+0x291/0x410
>  ? __schedule+0x65e/0x1310
>  process_one_work+0x1bc/0x3d0
>  worker_thread+0x4c/0x380
>  ? preempt_count_add+0x92/0xa0
>  ? rescuer_thread+0x310/0x310
>  kthread+0xe6/0x110
>  ? kthread_complete_and_exit+0x20/0x20
>  ret_from_fork+0x1f/0x30
>
> The rq clock has been updated before the set_rq_offline()
> function runs, so we don't need to call update_rq_clock() in
> unthrottle_offline_cfs_rqs().

I don't think we do in the path from rq_attach_root (though that's easy
enough to fix, of course).

