Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1AB6F9E63
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 05:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjEHDvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 23:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjEHDvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 23:51:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4577759E0
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 20:51:10 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QF6fK6Wq7zTk0n;
        Mon,  8 May 2023 11:46:33 +0800 (CST)
Received: from [10.174.176.93] (10.174.176.93) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 11:51:08 +0800
Message-ID: <f3241001-d9ff-703d-9e9c-9f8c888edf3f@huawei.com>
Date:   Mon, 8 May 2023 11:51:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 9/9] softirq, timer: Use softirq_needs_break()
To:     Hillf Danton <hdanton@sina.com>
CC:     <edumazet@google.com>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230505113315.3307723-1-liujian56@huawei.com>
 <20230505135553.4248-1-hdanton@sina.com>
From:   "liujian (CE)" <liujian56@huawei.com>
In-Reply-To: <20230505135553.4248-1-hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.93]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/5 21:55, Hillf Danton wrote:
> On 5 May 2023 19:33:15 +0800 Liu Jian <liujian56@huawei.com>
>> In the while loop of __run_timers(), because there are too many timers or
>> improper timer handler functions, if the processing time of the expired
>> timers is always greater than the time wheel's next_expiry, the function
>> will loop infinitely.
>>
>> To prevent this, use the timeout/break logic provided by SoftIRQs. If the
>> running time exceeds the limit, break the loop and an additional
>> TIMER_SOFTIRQ is triggered.
> 
> This can not be a correct fix without getting every timer hog that runs
> longer than MAX_SOFTIRQ_TIME identified first and fixed.
> Do you mean that the timer that takes too long to execute needs to be 
fixed first? Let's ignore this problem here. The modification is only 
used to ensure that the loop exits when the loop execution time in 
__run_timers() exceeds MAX_SOFTIRQ_TIME.

> The same applies to any softirq in general.
> 
