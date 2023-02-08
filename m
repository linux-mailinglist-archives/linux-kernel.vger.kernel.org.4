Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E294A68E99A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 09:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjBHINE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 03:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjBHINC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 03:13:02 -0500
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F85366BA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 00:12:59 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VbBAcXR_1675843974;
Received: from 30.97.49.7(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VbBAcXR_1675843974)
          by smtp.aliyun-inc.com;
          Wed, 08 Feb 2023 16:12:56 +0800
Message-ID: <d6976454-6921-b94e-4da8-44e613816d5b@linux.alibaba.com>
Date:   Wed, 8 Feb 2023 16:12:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v4] erofs: replace erofs_unzipd workqueue with per-cpu
 threads
To:     Sandeep Dhavale <dhavale@google.com>
Cc:     Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Yue Hu <huyue2@coolpad.com>, kernel-team@android.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230106073502.4017276-1-dhavale@google.com>
 <Y+DP6V9fZG7XPPGy@debian>
 <CAB=BE-Ttt6mO6x+xNv+VSWnoRgzXd_VyQuYiuz55uR3zqxWMFA@mail.gmail.com>
 <126ddd77-edae-d942-6fec-fe6bcc3c54ff@linux.alibaba.com>
 <CAB=BE-QAqEnK8fQGoWE4dBagF=EPHwS7oL-DnLeooA3RUL4TXw@mail.gmail.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAB=BE-QAqEnK8fQGoWE4dBagF=EPHwS7oL-DnLeooA3RUL4TXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/8 14:58, Sandeep Dhavale wrote:
> On Mon, Feb 6, 2023 at 6:55 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2023/2/7 03:41, Sandeep Dhavale wrote:
>>> On Mon, Feb 6, 2023 at 2:01 AM Gao Xiang <xiang@kernel.org> wrote:
>>>>
>>>> Hi Sandeep,
>>>>
>>>> On Fri, Jan 06, 2023 at 07:35:01AM +0000, Sandeep Dhavale wrote:
>>>>> Using per-cpu thread pool we can reduce the scheduling latency compared
>>>>> to workqueue implementation. With this patch scheduling latency and
>>>>> variation is reduced as per-cpu threads are high priority kthread_workers.
>>>>>
>>>>> The results were evaluated on arm64 Android devices running 5.10 kernel.
>>>>>
>>>>> The table below shows resulting improvements of total scheduling latency
>>>>> for the same app launch benchmark runs with 50 iterations. Scheduling
>>>>> latency is the latency between when the task (workqueue kworker vs
>>>>> kthread_worker) became eligible to run to when it actually started
>>>>> running.
>>>>> +-------------------------+-----------+----------------+---------+
>>>>> |                         | workqueue | kthread_worker |  diff   |
>>>>> +-------------------------+-----------+----------------+---------+
>>>>> | Average (us)            |     15253 |           2914 | -80.89% |
>>>>> | Median (us)             |     14001 |           2912 | -79.20% |
>>>>> | Minimum (us)            |      3117 |           1027 | -67.05% |
>>>>> | Maximum (us)            |     30170 |           3805 | -87.39% |
>>>>> | Standard deviation (us) |      7166 |            359 |         |
>>>>> +-------------------------+-----------+----------------+---------+
>>>>>
>>>>> Background: Boot times and cold app launch benchmarks are very
>>>>> important to the android ecosystem as they directly translate to
>>>>> responsiveness from user point of view. While erofs provides
>>>>> a lot of important features like space savings, we saw some
>>>>> performance penalty in cold app launch benchmarks in few scenarios.
>>>>> Analysis showed that the significant variance was coming from the
>>>>> scheduling cost while decompression cost was more or less the same.
>>>>>
>>>>> Having per-cpu thread pool we can see from the above table that this
>>>>> variation is reduced by ~80% on average. This problem was discussed
>>>>> at LPC 2022. Link to LPC 2022 slides and
>>>>> talk at [1]
>>>>>
>>>>> [1] https://lpc.events/event/16/contributions/1338/
>>>>>
>>>>> Signed-off-by: Sandeep Dhavale <dhavale@google.com>
>>>>> ---
>>>>> V3 -> V4
>>>>> * Updated commit message with background information
>>>>> V2 -> V3
>>>>> * Fix a warning Reported-by: kernel test robot <lkp@intel.com>
>>>>> V1 -> V2
>>>>> * Changed name of kthread_workers from z_erofs to erofs_worker
>>>>> * Added kernel configuration to run kthread_workers at normal or
>>>>>     high priority
>>>>> * Added cpu hotplug support
>>>>> * Added wrapped kthread_workers under worker_pool
>>>>> * Added one unbound thread in a pool to handle a context where
>>>>>     we already stopped per-cpu kthread worker
>>>>> * Updated commit message
>>>>
>>>> I've just modified your v4 patch based on erofs -dev branch with
>>>> my previous suggestion [1], but I haven't tested it.
>>>>
>>>> Could you help check if the updated patch looks good to you and
>>>> test it on your side?  If there are unexpected behaviors, please
>>>> help update as well, thanks!
>>> Thanks Xiang, I was working on the same. I see that you have cleaned it up.
>>> I will test it and report/fix any problems.
>>>
>>> Thanks,
>>> Sandeep.
>>
>> Thanks! Look forward to your test. BTW, we have < 2 weeks for 6.3, so I'd
>> like to fix it this week so that we could catch 6.3 merge window.
>>
>>
>> I've fixed some cpu hotplug errors as below and added to a branch for 0day CI
>> testing.
>>
> Hi Xiang,
> With this version of the patch I have tested
> - Multiple device reboot test
> - Cold App launch tests
> - Cold App launch tests with cpu offline/online
> 
> All tests ran successfully and no issue was observed.

Okay, thanks! I will resend & submit this version for -next now
and test on my side if no other concerns.

Thanks,
Gao XIang
