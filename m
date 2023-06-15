Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DB8731223
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240366AbjFOI2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238441AbjFOI2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:28:04 -0400
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B840C1A3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:27:58 -0700 (PDT)
X-QQ-mid: bizesmtp76t1686817663tyrp1h6u
Received: from [10.7.13.112] ( [113.200.76.118])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 15 Jun 2023 16:27:42 +0800 (CST)
X-QQ-SSF: 01400000000000D0H000000A0000020
X-QQ-FEAT: DWSCcwW/aQbf0QhPLWNXq1lOf4ojSK1+Q6wW+BbzmhGyGUasu1U1SnvEzb0vg
        CNhQKR+wHg0AKGXycK1IHILDN7NkV+AqCBF7P7vSeIEz5W61P81/aiKvBu+9BNngxhkgsLO
        g83IXKsUNKl1CObMeDVMOOEnWzZn9oUFyAJqaPccU5l5jeyjK9UmrtkvPlhXdcsvKKyGXv2
        VlpbIFMPy1+BiR8oM6tjtVOM6bG8ConWfkWw3VLTTnrPnuYXLp/VeMZf0Mty4wx/IXPoOZc
        fZ7d8t/BRBcbhT6ycGaCemVDIoETbDfXKKgKBD3tC5+Y3xx1TMg0onlYaCQCXQAD/vWf31t
        eBgHWj0N+RX3lJdXUDKvi0JnoSqfXXJAiSsuzXy7LA/61pNiUHqf2LaYsPazqVmq4KQsgj9
        gx5aTudAjrPmPX2tEXXO9g==
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4872842073552882932
Subject: Re: [PATCH] locking/osq_lock: Fix false sharing of
 optimistic_spin_node in osq_lock
To:     Waiman Long <longman@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, wangxiaohua@uniontech.com
References: <20230615012437.21087-1-guohui@uniontech.com>
 <9f5321f9-0b35-7f85-ee09-247d961e5a79@redhat.com>
 <b8ec5185-f167-0b11-b823-51ba4fc3ca4f@redhat.com>
From:   Guo Hui <guohui@uniontech.com>
Message-ID: <96DD7021A77A45D4+430029ca-38ee-204a-4ee5-a5246b99bb62@uniontech.com>
Date:   Thu, 15 Jun 2023 16:27:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <b8ec5185-f167-0b11-b823-51ba4fc3ca4f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/15/23 10:57 AM, Waiman Long wrote:
>
> On 6/14/23 21:58, Waiman Long wrote:
>>> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
>>> index d5610ad52b92..bdcd216b73c4 100644
>>> --- a/kernel/locking/osq_lock.c
>>> +++ b/kernel/locking/osq_lock.c
>>> @@ -24,7 +24,7 @@ static inline int encode_cpu(int cpu_nr)
>>>     static inline int node_cpu(struct optimistic_spin_node *node)
>>>   {
>>> -    return node->cpu - 1;
>>> +    return node->prev_cpu - 1;
>>>   }
>>
>> From the first glance, the patch looks OK. The only issue that I have 
>> so far is the "node_cpu" name which is misleading in this case. You 
>> should have renamed it to node_prev_cpu() instead as there is only 
>> one caller.
>
> One more thing. Unlike node->cpu, node->prev_cpu is subjected to 
> change. So you should have use READ_ONCE() to read it to match the 
> WRITE_ONCE() that modifies it.
>
> Thanks,
> Longman
>
>

Ok thanks, I got it.

