Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02CD5BDCD0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiITGBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiITGBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:01:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0E615731
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663653683; x=1695189683;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mNy52+6WxoYe/YHruALlMJMB2aDWgFWZufTGAbS/0S0=;
  b=EoyGBJjpIn+KbemBQeW9jWPolGgS69YS2NZ60rUfDJc7+GUiXaMPIv2t
   FBBfzpaSbilrJVCbMHO2vD/uQKuIiAlhcsd3qo0rgaZ34v8eof/mc3Zkv
   ZTlZl7iJ0d4y2BRV2wlSfjEYbDxTplEorerFK4ensDcD9iCBiElIIDKmY
   g0rDL+o/c4jZ410Hu8UwLj5+NTffEt7a+hd7kvF7nVKwjJ5Cyz0cWXIe2
   EAh4CZpznmFW453NGplr1jQkvGeM7lBBaA5LuNExb+MbZNuimO3JCJRhx
   erq41YRr78x1szLcAaxgneuX/JLU3jZ/cWNLSnLBFSDHGO9V7ZyfhUllc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="299596071"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="299596071"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 23:01:21 -0700
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="649448596"
Received: from jiebinsu-mobl.ccr.corp.intel.com (HELO [10.238.4.108]) ([10.238.4.108])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 23:01:16 -0700
Message-ID: <be1cf4e7-9344-8e36-b44b-a55a548af5dd@intel.com>
Date:   Tue, 20 Sep 2022 14:01:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v6 1/2] percpu: Add percpu_counter_add_local and
 percpu_counter_sub_local
Content-Language: en-US
To:     Manfred Spraul <manfred@colorfullife.com>,
        akpm@linux-foundation.org, vasily.averin@linux.dev,
        shakeelb@google.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, ebiederm@xmission.com, legion@kernel.org,
        alexander.mikhalitsyn@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     tim.c.chen@intel.com, feng.tang@intel.com, ying.huang@intel.com,
        tianyou.li@intel.com, wangyang.guo@intel.com,
        Tim Chen <tim.c.chen@linux.intel.com>,
        kernel test robot <lkp@intel.com>, 1vier1@web.de
References: <20220902152243.479592-1-jiebin.sun@intel.com>
 <20220913192538.3023708-1-jiebin.sun@intel.com>
 <20220913192538.3023708-2-jiebin.sun@intel.com>
 <b736022c-5028-a06e-5edb-f5cb526b0821@colorfullife.com>
From:   "Sun, Jiebin" <jiebin.sun@intel.com>
In-Reply-To: <b736022c-5028-a06e-5edb-f5cb526b0821@colorfullife.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/18/2022 7:08 PM, Manfred Spraul wrote:
> Hi Jiebin,
>
> On 9/13/22 21:25, Jiebin Sun wrote:
>>   +/*
>> + * With percpu_counter_add_local() and percpu_counter_sub_local(), 
>> counts
>> + * are accumulated in local per cpu counter and not in fbc->count until
>> + * local count overflows PERCPU_COUNTER_LOCAL_BATCH. This makes counter
>> + * write efficient.
>> + * But percpu_counter_sum(), instead of percpu_counter_read(), needs 
>> to be
>> + * used to add up the counts from each CPU to account for all the local
>> + * counts. So percpu_counter_add_local() and percpu_counter_sub_local()
>> + * should be used when a counter is updated frequently and read rarely.
>> + */
>> +static inline void
>> +percpu_counter_add_local(struct percpu_counter *fbc, s64 amount)
>> +{
>> +    percpu_counter_add_batch(fbc, amount, PERCPU_COUNTER_LOCAL_BATCH);
>> +}
>> +
>
> Unrelated to your patch, and not relevant for ipc/msg as the functions 
> are not called from interrupts, but:
> Aren't there races with interrupts?
>
>> *
>> * This function is both preempt and irq safe. The former is due to 
>> explicit
>> * preemption disable. The latter is guaranteed by the fact that the 
>> slow path
>> * is explicitly protected by an irq-safe spinlock whereas the fast 
>> patch uses
>> * this_cpu_add which is irq-safe by definition. Hence there is no 
>> need muck
>> * with irq state before calling this one
>> */
>> void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, 
>> s32 batch)
>> {
>>        s64 count;
>>
>>        preempt_disable();
>>        count = __this_cpu_read(*fbc->counters) + amount;
>>        if (abs(count) >= batch) {
>>                unsigned long flags;
>>                raw_spin_lock_irqsave(&fbc->lock, flags);
>>                fbc->count += count;
>>                __this_cpu_sub(*fbc->counters, count - amount);
>>                raw_spin_unlock_irqrestore(&fbc->lock, flags);
>>        } else {
>>                this_cpu_add(*fbc->counters, amount);
>>        }
>>        preempt_enable();
>> }
>> EXPORT_SYMBOL(percpu_counter_add_batch);
>>
>>
> Race 1:
>
> start: __this_cpu_read(*fbc->counters) = INT_MAX-1.
>
> Call: per_cpu_counter_add_batch(fbc, 1, INT_MAX);
>
> Result:
>
> count=INT_MAX;
>
> if (abs(count) >= batch) { // branch taken
>
> before the raw_spin_lock_irqsave():
>
> Interrupt
>
> Within interrupt:
>
>    per_cpu_counter_add_batch(fbc, -2*(INT_MAX-1), INT_MAX)
>
>    count=-(INT_MAX-1);
>
>    branch not taken
>
>    this_cpu_add() updates fbc->counters, new value is -(INT_MAX-1)
>
>    exit interrupt
>
> raw_spin_lock_irqsave()
>
> __this_cpu_sub(*fbc->counters, count - amount)
>
> will substract INT_MAX-1 from *fbc->counters. But the value is already 
> -(INT_MAX-1) -> underflow.
>
>
> Race 2: (much simpler)
>
> start: __this_cpu_read(*fbc->counters) = 0.
>
> Call: per_cpu_counter_add_batch(fbc, INT_MAX-1, INT_MAX);
>
> amont=INT_MAX-1;
>
> - branch not taken.
>
> before this_cpu_add(): interrupt
>
> within the interrupt: call per_cpu_counter_add_batch(fbc, INT_MAX-1, 
> INT_MAX)
>
>    new value of *fbc->counters: INT_MAX-1.
>
>    exit interrupt
>
> outside interrupt:
>
> this_cpu_add(*fbc->counters, amount);
>
> <<< overflow.
>
> Attached is an incomplete patch (untested).
> If needed, I could check the whole file and add/move the required 
> local_irq_save() calls.
>
>
> -- 
>
>     Manfred

The interrupt protect patch in the real case looks good to me. Thanks.


