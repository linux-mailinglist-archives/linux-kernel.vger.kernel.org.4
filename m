Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D201A70BEC6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbjEVMxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjEVMxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 08:53:01 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA2CC6
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 05:52:57 -0700 (PDT)
Received: from dggpemm500003.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QPy3t1T0fzsSL5;
        Mon, 22 May 2023 20:50:50 +0800 (CST)
Received: from [10.67.145.254] (10.67.145.254) by
 dggpemm500003.china.huawei.com (7.185.36.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 20:52:55 +0800
Message-ID: <d0fd4794-c22d-910d-8287-8ae5e319b094@hisilicon.com>
Date:   Mon, 22 May 2023 20:52:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH] irqchip: gic-v3: Collection table support muti pages
To:     Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1684152604-12621-1-git-send-email-wangwudi@hisilicon.com>
 <86jzx9n4qg.wl-maz@kernel.org>
 <41cbc6cb4e964fe0bbba87f52110b1c3@hisilicon.com>
 <5e42a892-3826-6370-9702-fefee88bf339@hisilicon.com>
 <87cz30wxto.wl-maz@kernel.org>
From:   wangwudi <wangwudi@hisilicon.com>
In-Reply-To: <87cz30wxto.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.145.254]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500003.china.huawei.com (7.185.36.56)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/16 15:16, Marc Zyngier 写道:
> On Tue, 16 May 2023 03:53:06 +0100,
> wangwudi <wangwudi@hisilicon.com> wrote:
>>
>>
>>
>> 在 2023/5/16 9:57, wangwudi 写道:
>>>
>>>
>>> -----邮件原件-----
>>> 发件人: Marc Zyngier [mailto:maz@kernel.org] 
>>> 发送时间: 2023年5月15日 20:45
>>> 收件人: wangwudi <wangwudi@hisilicon.com>
>>> 抄送: linux-kernel@vger.kernel.org; Thomas Gleixner <tglx@linutronix.de>
>>> 主题: Re: [PATCH] irqchip: gic-v3: Collection table support muti pages
>>>
>>> On Mon, 15 May 2023 13:10:04 +0100,
>>> wangwudi <wangwudi@hisilicon.com> wrote:
>>>>
>>>> Only one page is allocated to the collection table.
>>>> Recalculate the page number of collection table based on the number of 
>>>> CPUs.
>>>
>>> Please document *why* we should even consider this. Do you know of
>>> any existing implementation that is so large (or need so much
>>> memory for its collection) that it would result in overflowing the
>>> collection table?
>>
>> Each CPU occupies an entry in the collection table. When there are a
>> large number of CPUs and only one page of the collection table, some
>> CPUs fail to execute ITS-MAPC cmd, and fail to receive LPI
>> interrupts.
>>
>> For example, GITS_BASER indicates that the page_size of the
>> collection table is 4 KB, the entry size is 16 Bytes, and only 256
>> entries can be stored on one page.  When the number of CPUs is more
>> than 256(which is common in the SMP system of the server), the
>> subsequent CPUs cannot receive the LPI.
> 
> You're stating the obvious. My question was whether we were anywhere
> close to that limit on any existing, or even planned HW.
> 
>> It is noticed by code review, not by on actual HW.
> 
> Right. So let me repeat my question: do you of any existing or planned
> implementation that is both:
> 
> - using a small ITS page size
> - having large per-collection memory requirements
> - with a potentially large number of CPUs
> 
> that would result in CPUs not fitting in the collection table?
> 

Yes, it is noticed in an internal simulation research:
- the page_size of collection table is 4 KB
- the entry_size of collection table is 16 Byte
- with 512 CPUs

> Assuming this is the case, is the CPU numbering space so large and
> potentially sparse that it would benefit from 2 level tables instead
> of a larger single-level table?
> 

Make sense.

> Finally, assuming all the above conditions are satisfied, what
> actually populates the second level table in your patch? I don't see
> anything that does. Which makes me think that it was never properly
> tested.
> 

How do you think populating the second level table in its_cpu_init_collection:

+static void its_cpu_init_collection(struct its_node *its, struct its_baser *baser)
 {
        int cpu = smp_processor_id();
        u64 target;
@@ -3210,6 +3265,9 @@ static void its_cpu_init_collection(struct its_node *its)
                        return;
        }

+       its_alloc_table_entry(its, baser, cpu);
+
        /*
         * We now have to bind each collection to its target
         * redistributor.
@@ -3237,11 +3295,14 @@ static void its_cpu_init_collection(struct its_node *its)
 static void its_cpu_init_collections(void)
 {
        struct its_node *its;
+       struct its_baser *baser;

        raw_spin_lock(&its_lock);

-       list_for_each_entry(its, &its_nodes, entry)
-               its_cpu_init_collection(its);
+       list_for_each_entry(its, &its_nodes, entry) {
+               baser = its_get_baser(its, GITS_BASER_TYPE_COLLECTION);
+               its_cpu_init_collection(its, baser);
+       }

        raw_spin_unlock(&its_lock);


> Thanks,
> 
> 	M.
> 
