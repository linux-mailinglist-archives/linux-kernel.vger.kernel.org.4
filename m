Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8B46DDC83
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjDKNpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjDKNpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:45:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E6BBB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681220668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u7LHoWentTrJwKTS60Ole0svRMERDtF/mH3xPr83oEY=;
        b=GdyBSmMCfa7eyh/V8pksMUS08FwMoPf7JtJwrmURNYgWrIut+rCkCuyC95a7GnN+kKyK5B
        adKUWS+0R2Bc76j81zTOEoI/I13igpcVGaB1mSH1UcjRH6EHPK6TPysGOYW8xhqq9eFwVQ
        eKP7vswfaWX2lDVOozsk7uUMM6JCXTI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575-DyOtc7AvO5euJA7Tsi1L-w-1; Tue, 11 Apr 2023 09:44:23 -0400
X-MC-Unique: DyOtc7AvO5euJA7Tsi1L-w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4AC548067FA;
        Tue, 11 Apr 2023 13:44:23 +0000 (UTC)
Received: from [10.22.33.155] (unknown [10.22.33.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EAB1247CD0;
        Tue, 11 Apr 2023 13:44:22 +0000 (UTC)
Message-ID: <5a3d4bed-e59c-5728-ce92-c97c905cb0c8@redhat.com>
Date:   Tue, 11 Apr 2023 09:44:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] perf/arm-dmc620: Reverse locking order in
 dmc620_pmu_get_irq()
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tuanphan@os.amperecomputing.com, robin.murphy@arm.com,
        suzuki.poulose@arm.com
References: <20230405172842.2663770-1-longman@redhat.com>
 <20230411123823.GA22686@willie-the-truck>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230411123823.GA22686@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/23 08:38, Will Deacon wrote:
> Hi Waiman,
>
> [+Tuan Phan, Robin and Suzuki]
>
> On Wed, Apr 05, 2023 at 01:28:42PM -0400, Waiman Long wrote:
>> The following circular locking dependency was reported when running
>> cpus online/offline test on an arm64 system.
>>
>> [   84.195923] Chain exists of:
>>                   dmc620_pmu_irqs_lock --> cpu_hotplug_lock --> cpuhp_state-down
>>
>> [   84.207305]  Possible unsafe locking scenario:
>>
>> [   84.213212]        CPU0                    CPU1
>> [   84.217729]        ----                    ----
>> [   84.222247]   lock(cpuhp_state-down);
>> [   84.225899]                                lock(cpu_hotplug_lock);
>> [   84.232068]                                lock(cpuhp_state-down);
>> [   84.238237]   lock(dmc620_pmu_irqs_lock);
>> [   84.242236]
>>                  *** DEADLOCK ***
>>
>> The problematic locking order seems to be
>>
>> 	lock(dmc620_pmu_irqs_lock) --> lock(cpu_hotplug_lock)
>>
>> This locking order happens when dmc620_pmu_get_irq() is called from
>> dmc620_pmu_device_probe(). Fix this possible deadlock scenario by
>> reversing the locking order.
>>
>> Also export __cpuhp_state_add_instance_cpuslocked() so that it can be
>> accessed by kernel modules.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   drivers/perf/arm_dmc620_pmu.c | 4 +++-
>>   kernel/cpu.c                  | 1 +
>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
>> index 54aa4658fb36..78d3bfbe96a6 100644
>> --- a/drivers/perf/arm_dmc620_pmu.c
>> +++ b/drivers/perf/arm_dmc620_pmu.c
>> @@ -425,7 +425,7 @@ static struct dmc620_pmu_irq *__dmc620_pmu_get_irq(int irq_num)
>>   	if (ret)
>>   		goto out_free_irq;
>>   
>> -	ret = cpuhp_state_add_instance_nocalls(cpuhp_state_num, &irq->node);
>> +	ret = cpuhp_state_add_instance_nocalls_cpuslocked(cpuhp_state_num, &irq->node);
>>   	if (ret)
>>   		goto out_free_irq;
>>   
>> @@ -445,9 +445,11 @@ static int dmc620_pmu_get_irq(struct dmc620_pmu *dmc620_pmu, int irq_num)
>>   {
>>   	struct dmc620_pmu_irq *irq;
>>   
>> +	cpus_read_lock();
>>   	mutex_lock(&dmc620_pmu_irqs_lock);
>>   	irq = __dmc620_pmu_get_irq(irq_num);
>>   	mutex_unlock(&dmc620_pmu_irqs_lock);
>> +	cpus_read_unlock();
>>   
>>   	if (IS_ERR(irq))
>>   		return PTR_ERR(irq);
>> diff --git a/kernel/cpu.c b/kernel/cpu.c
>> index 6c0a92ca6bb5..05daaef362e6 100644
>> --- a/kernel/cpu.c
>> +++ b/kernel/cpu.c
>> @@ -2036,6 +2036,7 @@ int __cpuhp_state_add_instance_cpuslocked(enum cpuhp_state state,
>>   	mutex_unlock(&cpuhp_state_mutex);
>>   	return ret;
>>   }
>> +EXPORT_SYMBOL_GPL(__cpuhp_state_add_instance_cpuslocked);
> Thanks for the fix, but I think it would be much cleaner if we could handle
> this internally to the driver without having to export additional symbols
> from the hotplug machinery.
>
> Looking at the driver, it looks like it would make more sense to register
> each PMU instance with the cpuhp state machine and avoid having to traverse
> a mutable list, rather than add irq instances.
>
> That said, I really don't grok this comment:
>
> 	/* We're only reading, but this isn't the place to be involving RCU */
>
> Given that perf_pmu_migrate_context() calls synchronize_rcu()...
>
> So perhaps we could just walk the list using RCU as the easiest fix?

My patch is just one of the possible fixes. I don't mind if you have a 
better fix in mind. My knowledge about the internal working of the 
driver is limited. So it will be great if someone more familiar with the 
driver can come up with a better fix.

Thanks,
longman

