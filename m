Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5AC6C2DE1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 10:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjCUJai convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Mar 2023 05:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjCUJaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 05:30:35 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B627291
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 02:30:26 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PgmTd56TCznYDJ;
        Tue, 21 Mar 2023 17:27:17 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 21 Mar 2023 17:30:23 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2507.021;
 Tue, 21 Mar 2023 17:30:23 +0800
From:   "chenjun (AM)" <chenjun102@huawei.com>
To:     Mike Rapoport <rppt@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cl@linux.com" <cl@linux.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "xuqiang (M)" <xuqiang36@huawei.com>,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH] mm/slub: Reduce memory consumption in extreme scenarios
Thread-Topic: [PATCH] mm/slub: Reduce memory consumption in extreme scenarios
Thread-Index: AQHZVnGyqCLx+d0GeECeM+z9zE2Dsg==
Date:   Tue, 21 Mar 2023 09:30:23 +0000
Message-ID: <c3a2280eff5c419ea14b6cad34474e08@huawei.com>
References: <20230314123403.100158-1-chenjun102@huawei.com>
 <0cad1ff3-8339-a3eb-fc36-c8bda1392451@suse.cz>
 <344c7521d72e4107b451c19b329e9864@huawei.com>
 <8c700468-245d-72e9-99e7-b99d4547e6d8@suse.cz>
 <aeb2bd3990004b9eb4f151aa833ddcf2@huawei.com>
 <015855b3-ced3-8d84-e21d-cc6ce112b556@suse.cz> <ZBgjZn7WOqO5ruws@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.178.43]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/3/20 17:12, Mike Rapoport 写道:
> On Mon, Mar 20, 2023 at 09:05:57AM +0100, Vlastimil Babka wrote:
>> On 3/19/23 08:22, chenjun (AM) wrote:
>>> 在 2023/3/17 20:06, Vlastimil Babka 写道:
>>>> On 3/17/23 12:32, chenjun (AM) wrote:
>>>>> 在 2023/3/14 22:41, Vlastimil Babka 写道:
>>>>>>>     	pc.flags = gfpflags;
>>>>>>> +
>>>>>>> +	/*
>>>>>>> +	 * when (node != NUMA_NO_NODE) && (gfpflags & __GFP_THISNODE)
>>>>>>> +	 * 1) try to get a partial slab from target node with __GFP_THISNODE.
>>>>>>> +	 * 2) if 1) failed, try to allocate a new slab from target node with
>>>>>>> +	 *    __GFP_THISNODE.
>>>>>>> +	 * 3) if 2) failed, retry 1) and 2) without __GFP_THISNODE constraint.
>>>>>>> +	 */
>>>>>>> +	if (node != NUMA_NO_NODE && !(gfpflags & __GFP_THISNODE) && try_thisnode)
>>>>>>> +			pc.flags |= __GFP_THISNODE;
>>>>>>
>>>>>> Hmm I'm thinking we should also perhaps remove direct reclaim possibilities
>>>>>> from the attempt 2). In your qemu test it should make no difference, as it
>>>>>> fills everything with kernel memory that is not reclaimable. But in practice
>>>>>> the target node might be filled with user memory, and I think it's better to
>>>>>> quickly allocate on a different node than spend time in direct reclaim. So
>>>>>> the following should work I think?
>>>>>>
>>>>>> pc.flags = GFP_NOWAIT | __GFP_NOWARN |__GFP_THISNODE
>>>>>>
>>>>>
>>>>> Hmm, Should it be that:
>>>>>
>>>>> pc.flags |= GFP_NOWAIT | __GFP_NOWARN |__GFP_THISNODE
>>>>
>>>> No, we need to ignore the other reclaim-related flags that the caller
>>>> passed, or it wouldn't work as intended.
>>>> The danger is that we ignore some flag that would be necessary to pass, but
>>>> I don't think there's any?
>>>>
>>>>
>>>
>>> If we ignore __GFP_ZERO passed by kzalloc， kzalloc will not work.
>>> Could we just unmask __GFP_RECLAIMABLE | __GFP_RECLAIM?
>>>
>>> pc.flags &= ~(__GFP_RECLAIMABLE | __GFP_RECLAIM)
>>> pc.flags |= __GFP_THISNODE
>>
>> __GFP_RECLAIMABLE would be wrong, but also ignored as new_slab() does:
>> 	flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK)
>>
>> which would filter out __GFP_ZERO as well. That's not a problem as kzalloc()
>> will zero out the individual allocated objects, so it doesn't matter if we
>> don't zero out the whole slab page.
>>
>> But I wonder, if we're not past due time for a helper e.g.
>> gfp_opportunistic(flags) that would turn any allocation flags to a
>> GFP_NOWAIT while keeping the rest of relevant flags intact, and thus there
>> would be one canonical way to do it - I'm sure there's a number of places
>> with their own variants now?
>> With such helper we'd just add __GFP_THISNODE to the result here as that's
>> specific to this particular opportunistic allocation.
> 
> I like the idea, but maybe gfp_no_reclaim() would be clearer?
> 

#define gfp_no_reclaim(gfpflag) (gfpflag & ~__GFP_DIRECT_RECLAIM)

And here,

pc.flags = gfp_no_reclaim(gfpflags) | __GFP_THISNODE.

Do I get it right？
