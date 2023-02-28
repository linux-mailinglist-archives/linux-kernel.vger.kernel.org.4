Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F686A52C0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 06:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjB1F7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 00:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjB1F7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 00:59:02 -0500
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C4D9EF3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 21:59:00 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VchnyNb_1677563936;
Received: from 30.97.48.254(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VchnyNb_1677563936)
          by smtp.aliyun-inc.com;
          Tue, 28 Feb 2023 13:58:57 +0800
Message-ID: <c770beee-aa1d-0001-3025-ca0073b228e8@linux.alibaba.com>
Date:   Tue, 28 Feb 2023 13:58:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v5] erofs: add per-cpu threads for decompression as an
 option
To:     Sandeep Dhavale <dhavale@google.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Nathan Huckleberry <nhuck@google.com>,
        Yue Hu <huyue2@coolpad.com>, kernel-team@android.com
References: <20230208093322.75816-1-hsiangkao@linux.alibaba.com>
 <Y/ewpGQkpWvOf7qh@gmail.com>
 <ca1e604a-92ba-023b-8896-dcad9413081d@linux.alibaba.com>
 <8e067230-ce1b-1c75-0c23-87b926357f96@linux.alibaba.com>
 <CAB=BE-SQZA7gETEvxnHmy0FDQ182fUSRoa0bJBNouN33SFx3hQ@mail.gmail.com>
 <CAB=BE-Svf7TMPs-eA+sVuGtYjVWfKd1Nd_AkA9im4Op7TCLW3g@mail.gmail.com>
 <1f926a20-6b45-137d-4e78-30025ba33574@linux.alibaba.com>
 <CAB=BE-SBtO6vcoyLNA9F-9VaN5R0t3o_Zn+FW8GbO6wyUqFneQ@mail.gmail.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAB=BE-SBtO6vcoyLNA9F-9VaN5R0t3o_Zn+FW8GbO6wyUqFneQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/28 13:51, Sandeep Dhavale wrote:
> On Mon, Feb 27, 2023 at 9:01 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>> Hi Sandeep,
>>
>> On 2023/2/28 12:47, Sandeep Dhavale via Linux-erofs wrote:
>>> Hi all,
>>> I completed the tests and the results are consistent with
>>> our previous observation. We can see that removing WQ_UNBOUND
>>> helps but the scheduling latency by using high priority per cpu
>>> kthreads is even lower. Below is the table.
>>>
>>> |---------------------+-------+-------+------+-------|
>>> | Table               | avg   | med   | min  | max   |
>>> |---------------------+-------+-------+------+-------|
>>> | Default erofs       | 19323 | 19758 | 3986 | 35051 |
>>> |---------------------+-------+-------+------+-------|
>>> | !WQ_UNBOUND         | 11202 | 10798 | 3493 | 19822 |
>>> |---------------------+-------+-------+------+-------|
>>> | hipri pcpu kthreads | 7182  | 7017  | 2463 | 12300 |
>>> |---------------------+-------+-------+------+-------|
>>
>> May I ask did it test with different setup since the test results
>> in the original commit message are:
>>
> Hi Gao,
> Yes I did the test on the different (older) hardware than my original testing
> (but the same one Nathan had used) to remove that as a variable.

Ok, good to know that.

> 
> Thanks,
> Sandeep.
> 
>> +-------------------------+-----------+----------------+---------+
>> |                         | workqueue | kthread_worker |  diff   |
>> +-------------------------+-----------+----------------+---------+
>> | Average (us)            |     15253 |           2914 | -80.89% |
>> | Median (us)             |     14001 |           2912 | -79.20% |
>> | Minimum (us)            |      3117 |           1027 | -67.05% |
>> | Maximum (us)            |     30170 |           3805 | -87.39% |
>> | Standard deviation (us) |      7166 |            359 |         |
>> +-------------------------+-----------+----------------+---------+
>>
>> Otherwise it looks good to me for now, hopefully helpful to Android
>> users.
>>
>> Thanks,
>> Gao Xiang
>>
>>>
>>>
>>> Thanks,
>>> Sandeep.
