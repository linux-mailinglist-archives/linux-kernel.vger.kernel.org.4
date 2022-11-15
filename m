Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE824628FB0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 03:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbiKOCC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 21:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbiKOCBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 21:01:16 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2FD2C0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:01:15 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NB8Xl3N0JzRpHK;
        Tue, 15 Nov 2022 10:00:55 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 10:01:13 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 10:01:12 +0800
Subject: Re: [PATCH] mm/vmalloc: allow mem_dump_obj() to be called in
 interrupt context
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Zhang Qiang1 <qiang1.zhang@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
References: <20221112121537.1634-1-thunder.leizhen@huawei.com>
 <20221114165443.98042d9244ee8899901df164@linux-foundation.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5762dc9e-dc9f-81ff-829e-cfa6ca2180d2@huawei.com>
Date:   Tue, 15 Nov 2022 10:01:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20221114165443.98042d9244ee8899901df164@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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



On 2022/11/15 8:54, Andrew Morton wrote:
> On Sat, 12 Nov 2022 20:15:37 +0800 Zhen Lei <thunder.leizhen@huawei.com> wrote:
> 
>> The function mem_dump_obj() can sometimes provide valuable debugging
>> information, but it cannot be called in an interrupt context because
>> spinlock vmap_area_lock has not been protected against IRQs. If the
>> current task has held the lock before hard/soft interrupt handler calls
>> mem_dump_obj(), simply abandoning the dump operation can avoid deadlock.
>> That is, no deadlock occurs in extreme cases, and dump succeeds in most
>> cases.
>>
>> ...
>>
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -4034,6 +4034,9 @@ bool vmalloc_dump_obj(void *object)
>>  	struct vm_struct *vm;
>>  	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
>>  
>> +	if (unlikely(spin_is_locked(&vmap_area_lock)))
>> +		return false;
>> +
>>  	vm = find_vm_area(objp);
>>  	if (!vm)
>>  		return false;
> 
> Yes, but this will worsen the current uses of this function.  Consider
> the case where task A wants to call vmalloc_dump_obj() but task B holds
> vmap_area_lock.  No problem, task A will simply spin until task B is
> done.
> 
> But after this patch, task A's call to vmalloc_dump_obj() will return
> without having done anything.

Oh, right, this problem occurs when task A and task B run on
two different cores.


> 
> .
> 

-- 
Regards,
  Zhen Lei
