Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C2E5BDC92
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 07:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiITFuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 01:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiITFu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 01:50:28 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B992DABF
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 22:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663653026; x=1695189026;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=azjpc/W1xgm63w6co4quNz/N14+KNfXPM4ToOaCNS2Q=;
  b=gBlydoEcGQYi6cb8MlIDQ2zpW+1coarkjM4ITuVayDWFMGLfd6eGJlLQ
   VmsPskMRe4i8LwJ9EwWd67SKcln7aFJag7EFvR1MpHpA01Pk02i+G9IXA
   AyMaoKmlkd65+K1oYT3we/QHJ1n+uZNI6wYcehiuJSVsToPGdu9BrbYEa
   +TxTmISTQ2Xsej56CZVj1tK4U3svzauLSVn+XtaNejVkDjMU0BDZsqbTH
   VYX87YmwnyBdOxMhSATxmrqnS5axu1pQOpNbnNby5UK/+8hNTxeuyWgne
   4EHpbQn55XXhLtJUH/s0NAs1TC1/Hm3Qfu5eSfY+bhCjZqsF31m4xtQej
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="300423156"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="300423156"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 22:50:26 -0700
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="569944306"
Received: from jiebinsu-mobl.ccr.corp.intel.com (HELO [10.238.4.108]) ([10.238.4.108])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 22:50:22 -0700
Message-ID: <e75d5408-d57b-af5b-f8b9-b9ffdcc9a554@intel.com>
Date:   Tue, 20 Sep 2022 13:50:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v6 2/2] ipc/msg: mitigate the lock contention with percpu
 counter
Content-Language: en-US
To:     Manfred Spraul <manfred@colorfullife.com>,
        akpm@linux-foundation.org, vasily.averin@linux.dev,
        shakeelb@google.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, ebiederm@xmission.com, legion@kernel.org,
        alexander.mikhalitsyn@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     tim.c.chen@intel.com, feng.tang@intel.com, ying.huang@intel.com,
        tianyou.li@intel.com, wangyang.guo@intel.com,
        Tim Chen <tim.c.chen@linux.intel.com>
References: <20220902152243.479592-1-jiebin.sun@intel.com>
 <20220913192538.3023708-1-jiebin.sun@intel.com>
 <20220913192538.3023708-3-jiebin.sun@intel.com>
 <aadf6c7e-dea8-4dff-1815-cca9c2c2da9e@colorfullife.com>
 <6ed22478-0c89-92ea-a346-0349be2dd99c@intel.com>
 <8d74a7d4-b80f-2a0f-ee95-243bdbd51ccd@colorfullife.com>
From:   "Sun, Jiebin" <jiebin.sun@intel.com>
In-Reply-To: <8d74a7d4-b80f-2a0f-ee95-243bdbd51ccd@colorfullife.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/20/2022 12:53 PM, Manfred Spraul wrote:
> On 9/20/22 04:36, Sun, Jiebin wrote:
>>
>> On 9/18/2022 8:53 PM, Manfred Spraul wrote:
>>> Hi Jiebin,
>>>
>>> On 9/13/22 21:25, Jiebin Sun wrote:
>>>> The msg_bytes and msg_hdrs atomic counters are frequently
>>>> updated when IPC msg queue is in heavy use, causing heavy
>>>> cache bounce and overhead. Change them to percpu_counter
>>>> greatly improve the performance. Since there is one percpu
>>>> struct per namespace, additional memory cost is minimal.
>>>> Reading of the count done in msgctl call, which is infrequent.
>>>> So the need to sum up the counts in each CPU is infrequent.
>>>>
>>>> Apply the patch and test the pts/stress-ng-1.4.0
>>>> -- system v message passing (160 threads).
>>>>
>>>> Score gain: 3.99x
>>>>
>>>> CPU: ICX 8380 x 2 sockets
>>>> Core number: 40 x 2 physical cores
>>>> Benchmark: pts/stress-ng-1.4.0
>>>> -- system v message passing (160 threads)
>>>>
>>>> Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
>>>> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
>>> Reviewed-by: Manfred Spraul <manfred@colorfullif.com>
>>>> @@ -495,17 +496,18 @@ static int msgctl_info(struct ipc_namespace 
>>>> *ns, int msqid,
>>>>       msginfo->msgssz = MSGSSZ;
>>>>       msginfo->msgseg = MSGSEG;
>>>>       down_read(&msg_ids(ns).rwsem);
>>>> -    if (cmd == MSG_INFO) {
>>>> +    if (cmd == MSG_INFO)
>>>>           msginfo->msgpool = msg_ids(ns).in_use;
>>>> -        msginfo->msgmap = atomic_read(&ns->msg_hdrs);
>>>> -        msginfo->msgtql = atomic_read(&ns->msg_bytes);
>>>> +    max_idx = ipc_get_maxidx(&msg_ids(ns));
>>>> +    up_read(&msg_ids(ns).rwsem);
>>>> +    if (cmd == MSG_INFO) {
>>>> +        msginfo->msgmap = percpu_counter_sum(&ns->percpu_msg_hdrs);
>>>> +        msginfo->msgtql = percpu_counter_sum(&ns->percpu_msg_bytes);
>>>
>>> Not caused by your change, it just now becomes obvious:
>>>
>>> msginfo->msgmap and ->msgtql are type int, i.e. signed 32-bit, and 
>>> the actual counters are 64-bit.
>>> This can overflow - and I think the code should handle this. Just 
>>> clamp the values to INT_MAX.
>>>
>> Hi Manfred,
>>
>> Thanks for your advice. But I'm not sure if we could fix the overflow 
>> issue in ipc/msg totally by
>>
>> clamp(val, low, INT_MAX). If the value is over s32, we might avoid 
>> the reversal sign, but still could
>>
>> not get the accurate value.
>
> I think just clamping it to INT_MAX is the best approach.
> Reporting negative values is worse than clamping. If (and only if) 
> there are real users that need to know the total amount of memory 
> allocated for messages queues in one namespace, then we could add a 
> MSG_INFO64 with long values. But I would not add that right now, I do 
> not see a real use case where the value would be needed.
>
> Any other opinions?
>
> -- 
>
>     Manfred
>
>
OK. I will work on it and send it out for review.
