Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2296F744BD1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 01:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjGAXra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 19:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGAXr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 19:47:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD3F1728
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 16:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688255202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TDU61wNE5DfHlHzCDfWw1kbbpWQEnHGkk8TG6nyshaY=;
        b=ODsg2iHVZedkeCMTONW9vuiMxxHwjBM16fUSpv2ZjZgr5qKmDx6lD86GPMO77EsT57H9w4
        TO60UgcW9VmK8/UW30RQ3wMjDCep5R9qSb4+W+s77RDU5bheBhYB5nc0puMB6xwW+1NoRq
        ki6noCGShPrtNW4R4w2Ud98a7UeVys0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-FswU8bavM8W7m5hWDgwS8w-1; Sat, 01 Jul 2023 19:46:38 -0400
X-MC-Unique: FswU8bavM8W7m5hWDgwS8w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 097DE29AA39D;
        Sat,  1 Jul 2023 23:46:38 +0000 (UTC)
Received: from [10.22.32.52] (unknown [10.22.32.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 940CAF00E5;
        Sat,  1 Jul 2023 23:46:37 +0000 (UTC)
Message-ID: <a6c55b82-71eb-ad18-e4b2-d62f1102a0e4@redhat.com>
Date:   Sat, 1 Jul 2023 19:46:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] cgroup/cpuset: update parent subparts cpumask while
 holding css refcnt
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     Miaohe Lin <linmiaohe@huawei.com>, tj@kernel.org,
        hannes@cmpxchg.org, lizefan.x@bytedance.com
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230701065049.1758266-1-linmiaohe@huawei.com>
 <9244d968-b25a-066f-2ff3-1281bf03983e@redhat.com>
In-Reply-To: <9244d968-b25a-066f-2ff3-1281bf03983e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/23 19:38, Waiman Long wrote:
> On 7/1/23 02:50, Miaohe Lin wrote:
>> update_parent_subparts_cpumask() is called outside RCU read-side 
>> critical
>> section without holding extra css refcnt of cp. In theroy, cp could be
>> freed at any time. Holding extra css refcnt to ensure cp is valid while
>> updating parent subparts cpumask.
>>
>> Fixes: d7c8142d5a55 ("cgroup/cpuset: Make partition invalid if 
>> cpumask change violates exclusivity rule")
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 58e6f18f01c1..632a9986d5de 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1806,9 +1806,12 @@ static int update_cpumask(struct cpuset *cs, 
>> struct cpuset *trialcs,
>>           cpuset_for_each_child(cp, css, parent)
>>               if (is_partition_valid(cp) &&
>>                   cpumask_intersects(trialcs->cpus_allowed, 
>> cp->cpus_allowed)) {
>> +                if (!css_tryget_online(&cp->css))
>> +                    continue;
>>                   rcu_read_unlock();
>>                   update_parent_subparts_cpumask(cp, 
>> partcmd_invalidate, NULL, &tmp);
>>                   rcu_read_lock();
>> +                css_put(&cp->css);
>>               }
>>           rcu_read_unlock();
>>           retval = 0;
>
> Thanks for finding that. It looks good to me.
>
> Reviewed-by: Waiman Long <longman@redhat.com>

Though, I will say that an offline cpuset cannot be a valid partition 
root. So it is not really a problem. For correctness sake and 
consistency with other similar code, I am in favor of getting it merged.

Cheers,
Longman

