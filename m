Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722286F418B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 12:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbjEBK0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 06:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbjEBKZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 06:25:40 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267DD61A3
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 03:23:04 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ab13da70a3so1158855ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 03:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683022983; x=1685614983;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ft1fnPcDv67OANOwaRzZrkPde9/JdoQaeFQn1dDjv3Y=;
        b=BMj85Z43WenW5jVe/BwFoe5h9/DCE3RBxa3rEd9loZPF+0FkkhLOzA2hIvNjoB/vx1
         h3Yl3O0dNI2yJ50vEJkm7QiVSCuNcba5K/dfmGUlANIK2RTtWgmuY+5SHi4+yk0XIkjY
         3f0JUFckNRFImtWrk77WChtqXYxrG0V2zlwuV99M39dF0FPj2+vzVO2sPLTT1OfJN4IQ
         iKN3zh12J8E5S75Omq1xF6OZTipk0Sm3QknltV7rDi3P5iYXOotCOrguyILAD6fxCmi0
         ltSxizLQQVw9eSUbWsIGjCmlV92+8mDfnbf8xPxYRU7VVn/7f2dcJHlbLoKkmti3vdd2
         Zo0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683022983; x=1685614983;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ft1fnPcDv67OANOwaRzZrkPde9/JdoQaeFQn1dDjv3Y=;
        b=XOh1iSn6Jk7xzNQf7ff3QHERwN8UE+nVgKKaVBVrW40GW8iVRZ4xiMWUv8ksToRbes
         LtxFjaauefjEtvCT5OVHcv9/sl6K1FWmgdpa3Au0F73usQdskNuxGCLHOHZ5EA31XQM6
         fze5KDyZydB3N2ypfUUtMOhxGqd3apOpZQjyfDBzuxmOCgcyTUrjDQUC6e0nNpbhhB3q
         0Q/Lb/poOa2gqTOaralQgrgf3GHewTnsU2DoXsfSsJVhSFwtANBlu99+SzBSzGy5Xp/4
         qWk+V6gLTdh5SJIlKmSkfLNAvquoYXPYQ0oZT5CqblcscqICM+1WEtWpv2qHubc3Sdh1
         7u9w==
X-Gm-Message-State: AC+VfDx0cc6kagcIAvKHq+yrfMVjJknEaFTSpc2lTopkS3gvvOz+a3Nu
        781aFsU58VLfD5Kpfc0A313ITQ==
X-Google-Smtp-Source: ACHHUZ4vbtWvWtNKVB5PTPHCECAzeKBtBc7aW18QCKYYlueya3dQXLQBKwubooAvadJy98KvdMzA9Q==
X-Received: by 2002:a17:902:cf07:b0:1a6:d2af:5a3f with SMTP id i7-20020a170902cf0700b001a6d2af5a3fmr17701821plg.3.1683022983550;
        Tue, 02 May 2023 03:23:03 -0700 (PDT)
Received: from [10.85.115.102] ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id o4-20020a170902bcc400b001a980a23802sm13629621pls.111.2023.05.02.03.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 03:23:03 -0700 (PDT)
Message-ID: <28cacb73-73d7-778a-24ca-9053702f6af7@bytedance.com>
Date:   Tue, 2 May 2023 18:22:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [External] Re: [PATCH 2/2] sched/core: Avoid double calling
 update_rq_clock()
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
References: <20230410081206.23441-1-jiahao.os@bytedance.com>
 <20230410081206.23441-3-jiahao.os@bytedance.com>
 <CAKfTPtDaG12qb4piQahJNNrEgAM3ouTKCzHA8BsAAYg015Ggpw@mail.gmail.com>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <CAKfTPtDaG12qb4piQahJNNrEgAM3ouTKCzHA8BsAAYg015Ggpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/21 Vincent Guittot wrote:
> On Mon, 10 Apr 2023 at 10:12, Hao Jia <jiahao.os@bytedance.com> wrote:
>>
>> There are some double rq clock update warnings are triggered.
>> ------------[ cut here ]------------
>> rq->clock_update_flags & RQCF_UPDATED
>> WARNING: CPU: 17 PID: 138 at kernel/sched/core.c:741
>> update_rq_clock+0xaf/0x180
>> Call Trace:
>>   <TASK>
>>   __balance_push_cpu_stop+0x146/0x180
>>   ? migration_cpu_stop+0x2a0/0x2a0
>>   cpu_stopper_thread+0xa3/0x140
>>   smpboot_thread_fn+0x14f/0x210
>>   ? sort_range+0x20/0x20
>>   kthread+0xe6/0x110
>>   ? kthread_complete_and_exit+0x20/0x20
>>   ret_from_fork+0x1f/0x30
>>
>> ------------[ cut here ]------------
>> rq->clock_update_flags & RQCF_UPDATED
>> WARNING: CPU: 54 PID: 0 at kernel/sched/core.c:741
>> update_rq_clock+0xaf/0x180
>> Call Trace:
>>   <TASK>
>>   unthrottle_cfs_rq+0x4b/0x300
>>   __cfsb_csd_unthrottle+0xe0/0x100
>>   __flush_smp_call_function_queue+0xaf/0x1d0
>>   flush_smp_call_function_queue+0x49/0x90
>>   do_idle+0x17c/0x270
>>   cpu_startup_entry+0x19/0x20
>>   start_secondary+0xfa/0x120
>>   secondary_startup_64_no_verify+0xce/0xdb
>>
>> ------------[ cut here ]------------
>> rq->clock_update_flags & RQCF_UPDATED
>> WARNING: CPU: 0 PID: 3323 at kernel/sched/core.c:741
>> update_rq_clock+0xaf/0x180
>> Call Trace:
>>   <TASK>
>>   unthrottle_cfs_rq+0x4b/0x300
>>   rq_offline_fair+0x89/0x90
>>   set_rq_offline.part.118+0x28/0x60
> 
> So this is generated by patch 1, isn't it ?

Sorry for the late reply, I just got back from a long term.

IIRC, this is not generated by patch1.

In the unthrottle_offline_cfs_rqs() function, we traverse task_groups 
through list_for_each_entry_rcu, so unthrottle_cfs_rq() may be called 
multiple times, resulting in multiple updates to the rq clock.

Thanks,
Hao
> 
>>   rq_attach_root+0xc4/0xd0
>>   cpu_attach_domain+0x3dc/0x7f0
>>   partition_sched_domains_locked+0x2a5/0x3c0
>>   rebuild_sched_domains_locked+0x477/0x830
>>   rebuild_sched_domains+0x1b/0x30
>>   cpuset_hotplug_workfn+0x2ca/0xc90
>>   ? balance_push+0x56/0xf0
>>   ? _raw_spin_unlock+0x15/0x30
>>   ? finish_task_switch+0x98/0x2f0
>>   ? __switch_to+0x291/0x410
>>   ? __schedule+0x65e/0x1310
>>   process_one_work+0x1bc/0x3d0
>>   worker_thread+0x4c/0x380
>>   ? preempt_count_add+0x92/0xa0
>>   ? rescuer_thread+0x310/0x310
>>   kthread+0xe6/0x110
>>   ? kthread_complete_and_exit+0x20/0x20
>>   ret_from_fork+0x1f/0x30
>>
>> For the __balance_push_cpu_stop() case, we remove update_rq_clock() from
>> the __migrate_task() function to avoid double updating the rq clock.
>> And in order to avoid missing rq clock update, add update_rq_clock()
>> call before migration_cpu_stop() calls __migrate_task().
>>
>> This also works for unthrottle_cfs_rq(), so we also removed
>> update_rq_clock() from the unthrottle_cfs_rq() function to avoid
>> warnings caused by calling it multiple times, such as
>> __cfsb_csd_unthrottle() and unthrottle_offline_cfs_rqs(). and
>> in order to avoid missing rq clock update, we correspondingly add
>> update_rq_clock() calls before unthrottle_cfs_rq() runs.
>>
>> Note that the rq clock has been updated before the set_rq_offline()
>> function runs, so we don't need to add update_rq_clock() call in
>> unthrottle_offline_cfs_rqs().
>>



