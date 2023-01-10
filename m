Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7621B66405F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238444AbjAJMXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbjAJMWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:22:55 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C475F49;
        Tue, 10 Jan 2023 04:20:20 -0800 (PST)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Nrqc40JrVzJrHc;
        Tue, 10 Jan 2023 20:19:00 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 10 Jan 2023 20:20:16 +0800
Subject: Re: [PATCH v2] kallsyms: Fix sleeping function called from invalid
 context when CONFIG_KALLSYMS_SELFTEST=y
To:     Petr Mladek <pmladek@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-modules@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
References: <20221228014511.328-1-thunder.leizhen@huawei.com>
 <Y7wZSxw+Ys5MNf8g@alley> <Y7ythXxlzsJkFQcd@bombadil.infradead.org>
 <Y702gW+5P5EepCkG@alley>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5fdf54c7-7b21-66ca-944e-aa8dde4e3427@huawei.com>
Date:   Tue, 10 Jan 2023 20:20:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <Y702gW+5P5EepCkG@alley>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/1/10 17:57, Petr Mladek wrote:
> On Mon 2023-01-09 16:12:53, Luis Chamberlain wrote:
>> On Mon, Jan 09, 2023 at 02:40:27PM +0100, Petr Mladek wrote:
>>> Why are try hardly comparable?
>>>
>>> 1. The speed depends on the number of loaded modules
>>>    and number of symbols. It highly depends on the configuration
>>>    that was used to build the kernel.
>>>
>>> 2. The test runs only once. As a result it is hard to judge
>>>    how big is the noise.
>>>
>>> 3. The noise might depend on the size and state of CPU caches.
>>>
>>>
>>> I personally vote for removing this selftest!
>>
>> Even so, just as with testing a filesystem with different types of
>> configurations, at least testing a few configs helps and it's what
>> we do. Then, if anyone ever wanted to try to increase performance
>> on symbol lookup today they have no easy way to measure things. How
>> would they go about comparing things performance without this selftest?
> 
> How many people cares about kallsyms performance, please?
> Is it worth spending time one implementing and maintaining such a
> selftest?
> 
> Yes, Zhen wanted to make it faster. But how likely will anyone else
> try to make it even better? Do we need to spend time on this
> in the meantime?
> 
> 
>> This selftests helps generically with that *and* helps peg on to it any sanity
>> checks you may wish to add to those APIs which we just don't want to do
>> upstream.
> 
>>From my POV, it would be much more important to check if the API
> works as expected. I mean that it gives the right results.
> 
> I am not sure that performance is that important to spend more time
> on this one.
> 
> Also I am not sure if selftests are the right location for performance
> tests. My understanding is that it is a framework for functional
> testing. It is showing if the tests passed or not. But performance
> tests do not give "pass or not" results.

I think both of you have a point. In the absence of a better way to
improve it, perhaps deleting the performance test is the best option now.
OK, I'll do this first.

> 
> Best Regards,
> Petr
> .
> 

-- 
Regards,
  Zhen Lei
