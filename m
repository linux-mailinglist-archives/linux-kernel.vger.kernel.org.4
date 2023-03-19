Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502CC6BFFC4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 08:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjCSHW6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 19 Mar 2023 03:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjCSHW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 03:22:56 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436562331A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 00:22:54 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PfTpc39qjz9tTN;
        Sun, 19 Mar 2023 15:22:32 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 19 Mar 2023 15:22:50 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2507.021;
 Sun, 19 Mar 2023 15:22:50 +0800
From:   "chenjun (AM)" <chenjun102@huawei.com>
To:     Vlastimil Babka <vbabka@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cl@linux.com" <cl@linux.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC:     "xuqiang (M)" <xuqiang36@huawei.com>,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] mm/slub: Reduce memory consumption in extreme scenarios
Thread-Topic: [PATCH] mm/slub: Reduce memory consumption in extreme scenarios
Thread-Index: AQHZVnGyqCLx+d0GeECeM+z9zE2Dsg==
Date:   Sun, 19 Mar 2023 07:22:50 +0000
Message-ID: <aeb2bd3990004b9eb4f151aa833ddcf2@huawei.com>
References: <20230314123403.100158-1-chenjun102@huawei.com>
 <0cad1ff3-8339-a3eb-fc36-c8bda1392451@suse.cz>
 <344c7521d72e4107b451c19b329e9864@huawei.com>
 <8c700468-245d-72e9-99e7-b99d4547e6d8@suse.cz>
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

在 2023/3/17 20:06, Vlastimil Babka 写道:
> On 3/17/23 12:32, chenjun (AM) wrote:
>> 在 2023/3/14 22:41, Vlastimil Babka 写道:
>>>>    	pc.flags = gfpflags;
>>>> +
>>>> +	/*
>>>> +	 * when (node != NUMA_NO_NODE) && (gfpflags & __GFP_THISNODE)
>>>> +	 * 1) try to get a partial slab from target node with __GFP_THISNODE.
>>>> +	 * 2) if 1) failed, try to allocate a new slab from target node with
>>>> +	 *    __GFP_THISNODE.
>>>> +	 * 3) if 2) failed, retry 1) and 2) without __GFP_THISNODE constraint.
>>>> +	 */
>>>> +	if (node != NUMA_NO_NODE && !(gfpflags & __GFP_THISNODE) && try_thisnode)
>>>> +			pc.flags |= __GFP_THISNODE;
>>>
>>> Hmm I'm thinking we should also perhaps remove direct reclaim possibilities
>>> from the attempt 2). In your qemu test it should make no difference, as it
>>> fills everything with kernel memory that is not reclaimable. But in practice
>>> the target node might be filled with user memory, and I think it's better to
>>> quickly allocate on a different node than spend time in direct reclaim. So
>>> the following should work I think?
>>>
>>> pc.flags = GFP_NOWAIT | __GFP_NOWARN |__GFP_THISNODE
>>>
>>
>> Hmm, Should it be that:
>>
>> pc.flags |= GFP_NOWAIT | __GFP_NOWARN |__GFP_THISNODE
> 
> No, we need to ignore the other reclaim-related flags that the caller
> passed, or it wouldn't work as intended.
> The danger is that we ignore some flag that would be necessary to pass, but
> I don't think there's any?
> 
> 

If we ignore __GFP_ZERO passed by kzalloc， kzalloc will not work.
Could we just unmask __GFP_RECLAIMABLE | __GFP_RECLAIM?

pc.flags &= ~(__GFP_RECLAIMABLE | __GFP_RECLAIM)
pc.flags |= __GFP_THISNODE
