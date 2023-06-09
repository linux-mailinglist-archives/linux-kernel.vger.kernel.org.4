Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4890972967B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240297AbjFIKN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjFIKM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:12:59 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E7426B3
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 03:02:07 -0700 (PDT)
Received: from dggpemm500003.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QcxPK3XjLzLqcP;
        Fri,  9 Jun 2023 17:59:01 +0800 (CST)
Received: from [10.67.145.254] (10.67.145.254) by
 dggpemm500003.china.huawei.com (7.185.36.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 18:02:04 +0800
Message-ID: <ec424c75-cce8-8828-18a7-1314d94e1875@hisilicon.com>
Date:   Fri, 9 Jun 2023 18:02:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH v2] irqchip: gic-v3: Extend collection table
To:     Marc Zyngier <maz@kernel.org>
References: <1686131113-3611-1-git-send-email-wangwudi@hisilicon.com>
 <87cz26nzm7.wl-maz@kernel.org>
 <82ea3d910d104fbb8df9b27585085895@hisilicon.com>
From:   wangwudi <wangwudi@hisilicon.com>
CC:     <linux-kernel@vger.kernel.org>,
        "liaochang (A)" <liaochang1@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <82ea3d910d104fbb8df9b27585085895@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.145.254]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500003.china.huawei.com (7.185.36.56)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

在 2023/6/9 17:24, wangwudi 写道:
> 
> 
> -----邮件原件-----
> 发件人: Marc Zyngier [mailto:maz@kernel.org] 
> 发送时间: 2023年6月8日 16:10
> 收件人: wangwudi <wangwudi@hisilicon.com>
> 抄送: linux-kernel@vger.kernel.org; liaochang (A) <liaochang1@huawei.com>; Thomas Gleixner <tglx@linutronix.de>
> 主题: Re: [PATCH v2] irqchip: gic-v3: Extend collection table
> 
> On Wed, 07 Jun 2023 10:45:13 +0100,
> wangwudi <wangwudi@hisilicon.com> wrote:
>>
>> Only single level table is supported to the collection table, and only 
>> one page is allocated.
>>
>> Extend collection table to support more CPUs:
>> 1. Recalculate the page number of collection table based on the number 
>> of CPUs.
>> 2. Add 2 level tables to collection table.
>> 3. Add GITS_TYPER_CIDBITS macros.
>>
>> It is noticed in an internal simulation research:
>> - the page_size of collection table is 4 KB
>> - the entry_size of collection table is 16 Byte
>> - with 512 CPUs
>>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Signed-off-by: wangwudi <wangwudi@hisilicon.com>
>> ---
>>
>> ChangeLog:
>> v1-->v2:
>> 	1. Support 2 level table
>> 	2. Rewrite the commit log
>>
>>  drivers/irqchip/irq-gic-v3-its.c   | 62 ++++++++++++++++++++++++++++++--------
>>  include/linux/irqchip/arm-gic-v3.h |  3 ++
>>  2 files changed, 53 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
>> b/drivers/irqchip/irq-gic-v3-its.c
>> index 0ec2b1e1df75..573ef26ad449 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -126,6 +126,7 @@ struct its_node {
>>  #define is_v4(its)		(!!((its)->typer & GITS_TYPER_VLPIS))
>>  #define is_v4_1(its)		(!!((its)->typer & GITS_TYPER_VMAPP))
>>  #define device_ids(its)		(FIELD_GET(GITS_TYPER_DEVBITS, (its)->typer) + 1)
>> +#define collection_ids(its)	(FIELD_GET(GITS_TYPER_CIDBITS, (its)->typer) + 1)
>>  
>>  #define ITS_ITT_ALIGN		SZ_256
>>  
>> @@ -2626,6 +2627,10 @@ static int its_alloc_tables(struct its_node *its)
>>  			indirect = its_parse_indirect_baser(its, baser, &order,
>>  							    ITS_MAX_VPEID_BITS);
>>  			break;
>> +		case GITS_BASER_TYPE_COLLECTION:
>> +			indirect = its_parse_indirect_baser(its, baser, &order,
>> +							    order_base_2(num_possible_cpus()));
>> +			break;
> 
> Nice try, but no. See below.
> 
>>  		}
>>  
>>  		err = its_setup_baser(its, baser, cache, shr, order, indirect); @@ 
>> -3230,18 +3235,6 @@ static void its_cpu_init_collection(struct its_node *its)
>>  	its_send_invall(its, &its->collections[cpu]);  }
>>  
>> -static void its_cpu_init_collections(void) -{
>> -	struct its_node *its;
>> -
>> -	raw_spin_lock(&its_lock);
>> -
>> -	list_for_each_entry(its, &its_nodes, entry)
>> -		its_cpu_init_collection(its);
>> -
>> -	raw_spin_unlock(&its_lock);
>> -}
>> -
>>  static struct its_device *its_find_device(struct its_node *its, u32 
>> dev_id)  {
>>  	struct its_device *its_dev = NULL, *tmp; @@ -3316,6 +3309,51 @@ 
>> static bool its_alloc_table_entry(struct its_node *its,
>>  	return true;
>>  }
>>  
>> +static bool its_alloc_collection_table(struct its_node *its, struct 
>> +its_baser *baser) {
>> +	int cpu = smp_processor_id();
>> +	int cpu_ids = 16;
>> +
>> +	if (its->typer & GITS_TYPER_CIL)
>> +		cpu_ids = collection_ids(its);
>> +
>> +	if (!(ilog2(cpu) < cpu_ids)) {
>> +		pr_warn("ITS: CPU%d out of Collection ID range for %dbits", cpu, cpu_ids);
>> +		return false;
>> +	}
>> +
>> +	if (!its_alloc_table_entry(its, baser, cpu)) {
>> +		pr_warn("ITS: CPU%d failed to allocate collection l2 table", cpu);
>> +		return false;
>> +	}
>> +
>> +	return true;
>> +}
>> +
>> +static bool its_cpu_init_collections(void) {
>> +	struct its_node *its;
>> +	struct its_baser *baser;
>> +
>> +	raw_spin_lock(&its_lock);
>> +
>> +	list_for_each_entry(its, &its_nodes, entry) {
>> +		baser = its_get_baser(its, GITS_BASER_TYPE_COLLECTION);
>> +		if (!baser) {
>> +			raw_spin_unlock(&its_lock);
>> +			return false;
>> +		}
> 
> This looks wrong. ITSs that have a non-zero HCC field may not need memory to back their collections at all, such as GIC500. There may not even be a BASERn register holding the memory.
> 
> So this patch more or less *guarantees* to break most implementation that are more than 5 year old.
>

For the collection table, if the HCC field is not zero, neither l1-table nor
l2-table table is allocated. How do you think?

> 	M.
> 
> --
> Without deviation from the norm, progress is not possible.
