Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682DA6EEC39
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 04:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239160AbjDZCEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 22:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239144AbjDZCEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 22:04:46 -0400
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36741194
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 19:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Message-ID:Date:MIME-Version:From:Subject:
        Content-Type; bh=ETdwQvwKsajJ7sDSZgZouUFg8RN9i2k9ZMJKiljQzcY=;
        b=UHNv8L75s8Ru13COyYo1LUjKGY7gl/HKUYeoo0miLT9uNZjRpZmso18jO7TcC9
        8zHshWlZ/MJJF17V276I3ewYZIh2jARrFhd/XmrMgOvqxD3YpeNHU/CAK3MAPm38
        HkdzOyQ2IdgjX31B6+kharuHPXFMd6zzf3cOP2PTwKaE4=
Received: from [172.29.156.86] (unknown [123.52.27.102])
        by zwqz-smtp-mta-g2-0 (Coremail) with SMTP id _____wBnfilygkhkfc8pAA--.63819S2;
        Wed, 26 Apr 2023 09:46:27 +0800 (CST)
Message-ID: <251a903f-e5c3-3cb1-1af7-9ce469fdc7e9@126.com>
Date:   Wed, 26 Apr 2023 09:46:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   zhaomengmeng <zhaomzhao@126.com>
Subject: Re: [PATCH v1] sched/fair: fix inconsistency in
 update_task_scan_period
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org,
        Zhao Mengmeng <zhaomengmeng@kylinos.cn>
References: <20230425100204.2032009-1-zhaomzhao@126.com>
 <20230425102416.GA1335080@hirez.programming.kicks-ass.net>
Content-Language: en-US
In-Reply-To: <20230425102416.GA1335080@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _____wBnfilygkhkfc8pAA--.63819S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr1DZF4xGw1xAw4kKw1rWFg_yoW8KF4kpF
        WFy3WFyF4kJr9rAw1vvw4xXa4xC3s5JrZrXayYgr98Ar98Wr1vqrsrKry8ur9rG393Aa4j
        qr4jqr9Fy3Z0vaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jfl1kUUUUU=
X-Originating-IP: [123.52.27.102]
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/1tbiJxNdd2G5UgXNgwABse
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/25 18:24, Peter Zijlstra wrote:
> On Tue, Apr 25, 2023 at 06:02:04AM -0400, zhaomzhao@126.com wrote:
>> From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
>>
>> During calculate numa_scan_period diff, the actual code
>> and the comment are inconsistent. The comment says it is
>> using shared faults ratio, but code uses private faults
>> ratio. This patch fixes it.
> 
> So for some reason you think the comment is correct ? You also don't
> discuss the performance changes caused by changing the code.

Sorry for the repeated mail and thanks for your comments.

First, I'd like to make some additions. When I was studying the 
numa-balancing code and found this inconsistency, I feel like the same 
as you: the comment is out-dated and not matching the code , so I was 
intended to change the comment. But after some git digging work,  I 
change my mind.

Function update_task_scan_period was added in "04bb2f9475054: 
sched/numa: Adjust scan rate in task_numa_placement", which set up the 
basis. Though the details logic inside the function may change a lot, 
this function's outer-side effect keep the same.
"""
Increase the scan period (slow down scanning) if the majority of our 
memory is
already on our local node, or if the majority of the page accesses are 
shared
with other processes
"""
Later, in commit "37ec97deb3a8c: sched/numa: Slow down scan rate if 
shared faults dominate", the author claims that
"""
    However, with the current code, all a high ratio of shared accesses
    does is slow down the rate at which scanning is made faster.

    This patch changes things so either lots of shared accesses or
    lots of local accesses will slow down scanning, and numa scanning
    is sped up only when there are lots of private faults on remote
    memory pages.
"""
But the actual code logic doesn't reflect his intention in commit log, 
which resulting the latest code used by kernel. Based on the this, I 
change the code and make this patch. That is *the reason I think the 
comment is correct*.

Second, the performance. I'm sorry that it is the shortage of my work. 
Which benchmark shall I use, like autonuma-benchmark?  I'm lack of 
physical server with multi numa node for testing,  is it enough to offer 
a virtual machine testing result? Besides, this patch just meant to 
achieve the initial design, not for optimization, is a performance 
result necessary?

Best regards.

