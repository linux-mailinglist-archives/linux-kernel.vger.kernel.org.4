Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8780071025E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 03:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbjEYB3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 21:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjEYB3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 21:29:01 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C71CF5
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 18:29:00 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QRVhW3d5GzqTPs;
        Thu, 25 May 2023 09:24:27 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 09:28:57 +0800
Message-ID: <44ce007d-8049-1cc9-7e2e-4ccb51a2867d@huawei.com>
Date:   Thu, 25 May 2023 09:28:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] memblock: update numa node of memblk reserved type
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>
CC:     Anshuman Khandual <anshuman.khandual@arm.com>,
        <20230519105321.333-1-ssawgyw@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <tsahu@linux.ibm.com>, <ssawgyw@gmail.com>
References: <20230523115708.195597-1-wangkefeng.wang@huawei.com>
 <03cdccc3-8b8a-d972-bbad-d60966e59ca9@arm.com>
 <4eb83d16-58ed-9f09-4308-f0f786580257@huawei.com>
 <20230524153344.GM4967@kernel.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230524153344.GM4967@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/24 23:33, Mike Rapoport wrote:
> On Wed, May 24, 2023 at 02:47:26PM +0800, Kefeng Wang wrote:
>>
>> On 2023/5/24 12:59, Anshuman Khandual wrote:
>>>

>>>
>>> __memblock_dump_all() gets called only when memblock_debug is enabled.
>>> This helper should be called directly inside memblock_dump_all() right
>>> at the beginning, regardless of memblock_debug.
>>
>> This is my first though, but I found there are still many memblock_alloc and
>> memblock_reserve after memblock_dump_all(), so I update it twice,
>>
>> 1) __memblock_dump_all()
>> 2) memblock_debug_show()
>>
>> and without the above two interface, no one care about the reserved node
>> info, so I put memblock_reserved_update_node into __memblock_dump_all().
>   
> We don't care about the reserved node info and __memblock_dump_all()
> actually does not print node info for reserved regions unless somebody
> explicitly sets the node id on a reserved memory.
> 
> So instead of updating reserved memory node info I'd rather avoid printing
> it in debugfs.

Ok, will skip nid = MAX_NUMNODES in debug show

diff --git a/mm/memblock.c b/mm/memblock.c
index c5c80d9bcea3..e6033de1f76d 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2169,17 +2169,19 @@ static int memblock_debug_show(struct seq_file 
*m, void *private)
  {
         struct memblock_type *type = m->private;
         struct memblock_region *reg;
-       int i, j;
+       int i, j, nid;
         unsigned int count = ARRAY_SIZE(flagname);
         phys_addr_t end;

         for (i = 0; i < type->cnt; i++) {
                 reg = &type->regions[i];
                 end = reg->base + reg->size - 1;
+               nid = memblock_get_region_node(reg);

                 seq_printf(m, "%4d: ", i);
                 seq_printf(m, "%pa..%pa ", &reg->base, &end);
-               seq_printf(m, "%4d ", memblock_get_region_node(reg));
+               if (nid != MAX_NUMNODES)
+                       seq_printf(m, "%4d ", nid);
                 if (reg->flags) {
                         for (j = 0; j < count; j++) {
                                 if (reg->flags & (1U << j)) {

