Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4191372A423
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjFIULu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjFIULi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:11:38 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856E91A1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 13:11:37 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b1b51ec3e9so37445ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 13:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686341495; x=1688933495;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gzedOAS5VnOsyPHwkcsHdJEaGwgKBZUVHww1f+NvI+k=;
        b=PwSnN4+3EArk/7GW3tOOSGCJ60noYSeyEQxjFAjSCfTd4acIG4sOSKfUdx5Fqgr5UR
         6/I+80kGh5WR+RSKN+RcPkSiqsNTudw40b+V+oKnPdbDyNYNmpopCYcaZ5LauHG+1MLE
         UipGekUqBNdfSQa8UEWfaTBE24xGetNV6A+WsKU/xFklh7S15rOsTEMH/Sna1hq/SPOz
         paDUCQqIzoPNdsjs20zj1rt74vEd1GOYk9N94rnYIEpbV6cvj1IJLUqbuDGZvo+4j//9
         MGLAdGGIYLw209GCopei9ICdXwG95i4E01b8DvaMm3fF3F9ZTLpUzc+nE1cJZ9IHjnyA
         mjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686341495; x=1688933495;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzedOAS5VnOsyPHwkcsHdJEaGwgKBZUVHww1f+NvI+k=;
        b=QgeMVbgAfYhFpmVDcEcf+mJq12d8pa86Mf4nW5880WTH2Tct/7P7yWsFOIPYnD3512
         vVEqovb20z6kYh/ySFywz880MBKaQg7CRsOl6eCnhorGojYi+6Q1XvML91WBbkNo/sT5
         18nLqwj5VyaTzmh2EpBJrLYWKf/9bKyoeHTqcWwttg7KSC+3gUwznwXpYiTSB26J1ogY
         +0xcnLYPwcdtK4O2TExqe5v2NFUu7jrHMoBYfDehz2LIMLSnuYB4PZ7E33hqsYo5HQui
         ZRU/a/jPRaPbDSy9Es/8aHpAsyFiklFxkuHDS0bKniemHQEXfAVosZmlC0O26KvVhLjh
         UEjg==
X-Gm-Message-State: AC+VfDzw9Ti9InU1LGyer4QpjwLGcAs/5n9cDdxJpoTf46/+D/drjMQA
        95fY7g49F+siEjDlO9pxoqarjoOUI+mZ5hPmCO8sLKIQtE8=
X-Google-Smtp-Source: ACHHUZ7LODCtjojeVCb6MyJhccSpq7etCZ4Hvw5pdgEJ5vZv4waz1bmgaWSS+GOYYd5kdyBRKZZbXw==
X-Received: by 2002:a17:903:22c9:b0:1ac:8835:b890 with SMTP id y9-20020a17090322c900b001ac8835b890mr1683plg.14.1686341495156;
        Fri, 09 Jun 2023 13:11:35 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-158-249-138.hsd1.ca.comcast.net. [73.158.249.138])
        by smtp.gmail.com with ESMTPSA id jw8-20020a170903278800b001ab25a19cfbsm3645606plb.139.2023.06.09.13.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 13:11:32 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH v4 4/4] sched/core: Avoid multiple
 calling update_rq_clock() in unthrottle_offline_cfs_rqs()
References: <20230608063312.79440-1-jiahao.os@bytedance.com>
        <20230608063312.79440-5-jiahao.os@bytedance.com>
        <xm26zg59acky.fsf@google.com>
        <504c702c-b31a-a9d4-22a0-8a09547d30e5@bytedance.com>
Date:   Fri, 09 Jun 2023 13:11:31 -0700
In-Reply-To: <504c702c-b31a-a9d4-22a0-8a09547d30e5@bytedance.com> (Hao Jia's
        message of "Fri, 9 Jun 2023 11:19:03 +0800")
Message-ID: <xm26jzwc9z0s.fsf@google.com>
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

> On 2023/6/9 Benjamin Segall wrote:
>> Hao Jia <jiahao.os@bytedance.com> writes:
>> 
>>> This WARN_DOUBLE_CLOCK warning is triggered during cpu offline.
>>> ------------[ cut here ]------------
>>> rq->clock_update_flags & RQCF_UPDATED
>>> WARNING: CPU: 0 PID: 3323 at kernel/sched/core.c:741
>>> update_rq_clock+0xaf/0x180
>>> Call Trace:
>>>   <TASK>
>>>   unthrottle_cfs_rq+0x4b/0x300
>>>   rq_offline_fair+0x89/0x90
>>>   set_rq_offline.part.118+0x28/0x60
>>>   rq_attach_root+0xc4/0xd0
>>>   cpu_attach_domain+0x3dc/0x7f0
>>>   partition_sched_domains_locked+0x2a5/0x3c0
>>>   rebuild_sched_domains_locked+0x477/0x830
>>>   rebuild_sched_domains+0x1b/0x30
>>>   cpuset_hotplug_workfn+0x2ca/0xc90
>>>   ? balance_push+0x56/0xf0
>>>   ? _raw_spin_unlock+0x15/0x30
>>>   ? finish_task_switch+0x98/0x2f0
>>>   ? __switch_to+0x291/0x410
>>>   ? __schedule+0x65e/0x1310
>>>   process_one_work+0x1bc/0x3d0
>>>   worker_thread+0x4c/0x380
>>>   ? preempt_count_add+0x92/0xa0
>>>   ? rescuer_thread+0x310/0x310
>>>   kthread+0xe6/0x110
>>>   ? kthread_complete_and_exit+0x20/0x20
>>>   ret_from_fork+0x1f/0x30
>>>
>>> The rq clock has been updated before the set_rq_offline()
>>> function runs, so we don't need to call update_rq_clock() in
>>> unthrottle_offline_cfs_rqs().
>> I don't think we do in the path from rq_attach_root (though that's easy
>> enough to fix, of course).
>> 
>
> Thanks for your review.
>
> Now our fix method is that after applying patch1, we update the rq clock before
> set_rq_offline(). Then use rq_clock_{start, stop}_loop_update to avoid updating
> the rq clock multiple times in unthrottle_cfs_rq().
>
> Do you have any better suggestions?
>
> Thanks,
> Hao

Yeah, the obvious fixes are to either add an update_rq_clock in
rq_attach_root as you suggest, or put it in set_rq_offline instead of
the callers.
