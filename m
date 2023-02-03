Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D6B68A5E7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 23:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbjBCWPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 17:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233740AbjBCWOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 17:14:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27359222CE
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 14:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675462389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hCk2+BxzUpvLmEF7sy7cEcsYKmmUH5hSWlVtIr99+rk=;
        b=D8DsrO0KSDuCJuiGDCV2M5DGKA2qSPLwrwil0VKC27/HaDESLDa6DvztPeUxWeTpL+6DSX
        g8za8I1PQWGeMd3BVi5UjASljtD0qCBvPPITIUCiKG0VPNTpiMSl/SOiw4RGAh7TiJoZap
        2oHuHBZ+1Tg71WbQXZ39bcnXjMUvxws=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-213-3_Olb3JcMPuipX3qvmZEzA-1; Fri, 03 Feb 2023 17:13:04 -0500
X-MC-Unique: 3_Olb3JcMPuipX3qvmZEzA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E89C80D0E3;
        Fri,  3 Feb 2023 22:13:03 +0000 (UTC)
Received: from [10.22.8.92] (unknown [10.22.8.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D701C404CD80;
        Fri,  3 Feb 2023 22:13:02 +0000 (UTC)
Message-ID: <820b04a1-8c2f-ba81-f508-5750c63f3239@redhat.com>
Date:   Fri, 3 Feb 2023 17:13:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] sched/core: Fix a missed update of user_cpus_ptr
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>, Phil Auld <pauld@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20230203181849.221943-1-longman@redhat.com>
 <Y9128uN5X8L3VTG3@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y9128uN5X8L3VTG3@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/23 16:04, Tejun Heo wrote:
> On Fri, Feb 03, 2023 at 01:18:49PM -0500, Waiman Long wrote:
>> Since commit 8f9ea86fdf99 ("sched: Always preserve the user requested
>> cpumask"), a successful call to sched_setaffinity() should always save
>> the user requested cpu affinity mask in a task's user_cpus_ptr. However,
>> when the given cpu mask is the same as the current one, user_cpus_ptr
>> is not updated. Fix this by saving the user mask in this case too.
>>
>> Fixes: 8f9ea86fdf99 ("sched: Always preserve the user requested cpumask")
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/sched/core.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 30d9752e2ca5..91255f791df3 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -2951,8 +2951,11 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
>>   	}
>>   
>>   	if (!(ctx->flags & SCA_MIGRATE_ENABLE)) {
>> -		if (cpumask_equal(&p->cpus_mask, ctx->new_mask))
>> +		if (cpumask_equal(&p->cpus_mask, ctx->new_mask)) {
>> +			if (ctx->flags & SCA_USER)
>> +				swap(p->user_cpus_ptr, ctx->user_mask);
>>   			goto out;
>> +		}
>>   
>>   		if (WARN_ON_ONCE(p == current &&
>>   				 is_migration_disabled(p) &&
> and this is for a separate bug and should go through the scheduler tree.

Yes, this is for Peter to pick up.

Cheers,
Longman

