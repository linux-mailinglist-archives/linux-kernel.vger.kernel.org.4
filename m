Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4686A15BC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 05:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjBXEKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 23:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBXEK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 23:10:28 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D365D34C1A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 20:10:00 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id h31so6901840pgl.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 20:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1677211800;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GkPChxxBr1+bV69QLfEnx1kZNmbYqrLFgGkKBlocGAk=;
        b=HxirGtgmGV4s00ojJs5ww98nCZ1qZ9PylWNXfx6usQd3IFMgRz0nM83TBaqW79Imj7
         lZcN6WZ3xW/KWhHzOzZmVA40iylkRaVtYTyIUh52CIa1jYDhTNOxT6SYKus58iT0yQPq
         UEtHiqIIy2xAKfYlWcpeSeeC/xT97YG7WKMjAzdUDtFijuOm4g/TEgPs3FNuLRler+v5
         CGwN1ol7CxbgaNWwhqMbfPjxGiUqSCH7xl8AujaBIlOFg0CiVzHEfWIJwDutHkWaQub/
         ud4ocjU2CQtUmMcKVHZX8ykwUfrAaCbddKKwM2K8fKK3gxj668QWMJyji9/dq/ZQ5wtG
         bx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677211800;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GkPChxxBr1+bV69QLfEnx1kZNmbYqrLFgGkKBlocGAk=;
        b=FGq6y6ymuNgANvWSQYQitEVHYzZpE68a5mWgWOSdqWHYrc+42OEeQLguQl2wbkXcSd
         4NTDJjFqek/B+2nsaepANCHuw0PcjBm/aopnSBI5HfNArKFp2nt+o5AEMW8WHxeRsgh4
         eIsPU80CYZgB/VCusbsG3lHKftmcKOa+v0HOqxpDiuD216yA9zAgbpwBX+p3FGv5Pfxc
         SW/WurwMe9V9xSCVLX3VDzbSW01U1X0uuI4i9hNP4PpuIY4hAU3jrspo/K+iiINZOUaT
         bLt0ydfeK4Pns5HrZGQ49znlV+tOkOGKWax5QXyCfix0i+SaFeLyRnVu4BcGGIpGjHwQ
         EhdQ==
X-Gm-Message-State: AO0yUKXWpigIFN2DFbgGrM9v5nEZMlh8cpBweKF5dh60weIyXFRtMV9Z
        mSLy0ndkwAH+vTYehs1iRHrpfQ==
X-Google-Smtp-Source: AK7set9uHvRpoySuV3Jf4xtRzBDaJj9OgcWCJaeK615MtJTW5VsrpNafcVwgNFnzaac2vW4wdFC+kg==
X-Received: by 2002:a05:6a00:23c3:b0:5a8:c179:7b02 with SMTP id g3-20020a056a0023c300b005a8c1797b02mr14492010pfc.1.1677211800146;
        Thu, 23 Feb 2023 20:10:00 -0800 (PST)
Received: from [10.70.252.135] ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id q15-20020a62ae0f000000b005a9131b6668sm2815781pff.2.2023.02.23.20.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 20:09:59 -0800 (PST)
Message-ID: <684fab83-a506-33fc-4b24-bdf0902e2397@bytedance.com>
Date:   Fri, 24 Feb 2023 12:09:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v2 2/7] mm: vmscan: make global slab shrink lockless
Content-Language: en-US
To:     Rafael Aquini <aquini@redhat.com>
Cc:     akpm@linux-foundation.org, tkhai@ya.ru, hannes@cmpxchg.org,
        shakeelb@google.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com,
        sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@i-love.sakura.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230223132725.11685-1-zhengqi.arch@bytedance.com>
 <20230223132725.11685-3-zhengqi.arch@bytedance.com>
 <Y/eFtTO+8kXlsW7x@optiplex-fbsd> <Y/eIMXtEJVszprNb@optiplex-fbsd>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Y/eIMXtEJVszprNb@optiplex-fbsd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/23 23:37, Rafael Aquini wrote:
> On Thu, Feb 23, 2023 at 10:26:45AM -0500, Rafael Aquini wrote:
>> On Thu, Feb 23, 2023 at 09:27:20PM +0800, Qi Zheng wrote:
>>> The shrinker_rwsem is a global lock in shrinkers subsystem,
>>> it is easy to cause blocking in the following cases:
>>>
>>> a. the write lock of shrinker_rwsem was held for too long.
>>>     For example, there are many memcgs in the system, which
>>>     causes some paths to hold locks and traverse it for too
>>>     long. (e.g. expand_shrinker_info())
>>> b. the read lock of shrinker_rwsem was held for too long,
>>>     and a writer came at this time. Then this writer will be
>>>     forced to wait and block all subsequent readers.
>>>     For example:
>>>     - be scheduled when the read lock of shrinker_rwsem is
>>>       held in do_shrink_slab()
>>>     - some shrinker are blocked for too long. Like the case
>>>       mentioned in the patchset[1].
>>>
>>> Therefore, many times in history ([2],[3],[4],[5]), some
>>> people wanted to replace shrinker_rwsem reader with SRCU,
>>> but they all gave up because SRCU was not unconditionally
>>> enabled.
>>>
>>> But now, since commit 1cd0bd06093c ("rcu: Remove CONFIG_SRCU"),
>>> the SRCU is unconditionally enabled. So it's time to use
>>> SRCU to protect readers who previously held shrinker_rwsem.
>>>
>>> [1]. https://lore.kernel.org/lkml/20191129214541.3110-1-ptikhomirov@virtuozzo.com/
>>> [2]. https://lore.kernel.org/all/1437080113.3596.2.camel@stgolabs.net/
>>> [3]. https://lore.kernel.org/lkml/1510609063-3327-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp/
>>> [4]. https://lore.kernel.org/lkml/153365347929.19074.12509495712735843805.stgit@localhost.localdomain/
>>> [5]. https://lore.kernel.org/lkml/20210927074823.5825-1-sultan@kerneltoast.com/
>>>
>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>> ---
>>>   mm/vmscan.c | 27 +++++++++++----------------
>>>   1 file changed, 11 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> index 9f895ca6216c..02987a6f95d1 100644
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -202,6 +202,7 @@ static void set_task_reclaim_state(struct task_struct *task,
>>>   
>>>   LIST_HEAD(shrinker_list);
>>>   DECLARE_RWSEM(shrinker_rwsem);
>>> +DEFINE_SRCU(shrinker_srcu);
>>>   
>>>   #ifdef CONFIG_MEMCG
>>>   static int shrinker_nr_max;
>>> @@ -706,7 +707,7 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
>>>   void register_shrinker_prepared(struct shrinker *shrinker)
>>>   {
>>>   	down_write(&shrinker_rwsem);
>>
>> I think you could revert the rwsem back to a simple mutex, now.
>>
> 
> NVM, that's exactly what patch 7 does. :)

Yeah. :)

> 
>   
> 

-- 
Thanks,
Qi
