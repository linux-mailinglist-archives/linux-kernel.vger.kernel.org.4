Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A100A62EB24
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 02:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240896AbiKRBlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 20:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiKRBlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 20:41:10 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD87B50
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:41:07 -0800 (PST)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NCztn5Y6gzJnfJ;
        Fri, 18 Nov 2022 09:37:53 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 09:41:03 +0800
Message-ID: <dadac419-acda-7ba5-b7bb-4bc5b6fee92d@huawei.com>
Date:   Fri, 18 Nov 2022 09:41:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 2/8] riscv/kprobe: Allocate detour buffer from module
 area
To:     Steven Rostedt <rostedt@goodmis.org>,
        Chen Guokai <chenguokai17@mails.ucas.ac.cn>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <mingo@redhat.com>,
        <sfr@canb.auug.org.au>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20221106100316.2803176-1-chenguokai17@mails.ucas.ac.cn>
 <20221106100316.2803176-3-chenguokai17@mails.ucas.ac.cn>
 <20221116202521.6c528955@gandalf.local.home>
From:   "liaochang (A)" <liaochang1@huawei.com>
In-Reply-To: <20221116202521.6c528955@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/11/17 9:25, Steven Rostedt 写道:
> On Sun,  6 Nov 2022 18:03:10 +0800
> Chen Guokai <chenguokai17@mails.ucas.ac.cn> wrote:
> 
>> @@ -84,6 +85,30 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>>  }
>>  
>>  #ifdef CONFIG_MMU
>> +#if defined(CONFIG_OPTPROBES) && defined(CONFIG_64BIT)
>> +void *alloc_optinsn_page(void)
>> +{
>> +	void *page;
>> +
>> +	page = __vmalloc_node_range(PAGE_SIZE, 1, MODULES_VADDR,
>> +				    MODULES_END, GFP_KERNEL,
>> +				    PAGE_KERNEL, 0, NUMA_NO_NODE,
>> +				    __builtin_return_address(0));
>> +	if (!page)
>> +		return NULL;
>> +
>> +	set_vm_flush_reset_perms(page);
>> +	/*
>> +	 * First make the page read-only, and only then make it executable to
>> +	 * prevent it from being W+X in between.
>> +	 */
>> +	set_memory_ro((unsigned long)page, 1);
>> +	set_memory_x((unsigned long)page, 1);
> 
> FYI, the above combination is going to be going away:
> 
>   https://lore.kernel.org/all/Y10OyLCLAAS6rsZv@hirez.programming.kicks-ass.net/

Thanks for reminding, i will use this API in next revision.
> -- Steve
> 
> 
>> +
>> +	return page;
>> +}
>> +#endif
>> +
> 

-- 
BR,
Liao, Chang
