Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46C26DE96D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 04:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjDLCcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 22:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDLCcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 22:32:01 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39EB449E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 19:31:58 -0700 (PDT)
Received: from kwepemm600017.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Px67h3pSXzSrTM;
        Wed, 12 Apr 2023 10:28:00 +0800 (CST)
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 10:31:53 +0800
Message-ID: <88914aef-b73e-b8c1-1c06-5a424d8a8b57@huawei.com>
Date:   Wed, 12 Apr 2023 10:31:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From:   Tong Tiangen <tongtiangen@huawei.com>
Subject: Re: [PATCH -next v8 4/4] arm64: add cow to machine check safe
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Guohanjun <guohanjun@huawei.com>, Xie XiuQi <xiexiuqi@huawei.com>
References: <20221219120008.3818828-1-tongtiangen@huawei.com>
 <20221219120008.3818828-5-tongtiangen@huawei.com> <ZDWOnsW/lPM45VCq@arm.com>
In-Reply-To: <ZDWOnsW/lPM45VCq@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/4/12 0:45, Catalin Marinas 写道:
> On Mon, Dec 19, 2022 at 12:00:08PM +0000, Tong Tiangen wrote:
>> At present, Recover from poison consumption from copy-on-write has been
>> supported[1], arm64 should also support this mechanism.
>>
>> Add new helper copy_mc_page() which provide a page copy implementation with
>> machine check safe. At present, only used in cow. In the future, we can
>> expand more scenes. As long as the consequences of page copy failure are
>> not fatal(eg: only affect user process), we can use this helper.
>>
>> The copy_mc_page() in copy_page_mc.S is largely borrows from copy_page()
>> in copy_page.S and the main difference is copy_mc_page() add extable entry
>> to every load/store insn to support machine check safe. largely to keep the
>> patch simple. If needed those optimizations can be folded in.
>>
>> Add new extable type EX_TYPE_COPY_MC_PAGE which used in copy_mc_page().
>>
>> [1]https://lore.kernel.org/lkml/20221031201029.102123-1-tony.luck@intel.com/
>>
>> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> 
> This series needs rebasing onto a newer kernel. Some random comments
> below.

OK, very willing to do it :)

> 
>> diff --git a/arch/arm64/lib/copy_mc_page.S b/arch/arm64/lib/copy_mc_page.S
>> new file mode 100644
>> index 000000000000..03d657a182f6
>> --- /dev/null
>> +++ b/arch/arm64/lib/copy_mc_page.S
>> @@ -0,0 +1,82 @@
> [...]
>> +SYM_FUNC_START(__pi_copy_mc_page)
>> +alternative_if ARM64_HAS_NO_HW_PREFETCH
>> +	// Prefetch three cache lines ahead.
>> +	prfm	pldl1strm, [x1, #128]
>> +	prfm	pldl1strm, [x1, #256]
>> +	prfm	pldl1strm, [x1, #384]
>> +alternative_else_nop_endif
>> +
>> +CPY_MC(9998f, ldp	x2, x3, [x1])
>> +CPY_MC(9998f, ldp	x4, x5, [x1, #16])
>> +CPY_MC(9998f, ldp	x6, x7, [x1, #32])
>> +CPY_MC(9998f, ldp	x8, x9, [x1, #48])
>> +CPY_MC(9998f, ldp	x10, x11, [x1, #64])
>> +CPY_MC(9998f, ldp	x12, x13, [x1, #80])
>> +CPY_MC(9998f, ldp	x14, x15, [x1, #96])
>> +CPY_MC(9998f, ldp	x16, x17, [x1, #112])
> [...]
> [...]
>> +9998:	ret
> 
> What I don't understand, is there any error returned here or the bytes
> not copied? I can see its return value is never used in this series.
> 
> Also, do we need to distinguish between fault on the source or the
> destination?

Oh, missing it, This should rerun bytes not copied.
will be fixed next version.

> 
>> diff --git a/arch/arm64/lib/mte.S b/arch/arm64/lib/mte.S
>> index 5018ac03b6bf..bf4dd861c41c 100644
>> --- a/arch/arm64/lib/mte.S
>> +++ b/arch/arm64/lib/mte.S
>> @@ -80,6 +80,25 @@ SYM_FUNC_START(mte_copy_page_tags)
>>   	ret
>>   SYM_FUNC_END(mte_copy_page_tags)
>>   
>> +/*
>> + * Copy the tags from the source page to the destination one wiht machine check safe
>> + *   x0 - address of the destination page
>> + *   x1 - address of the source page
>> + */
>> +SYM_FUNC_START(mte_copy_mc_page_tags)
>> +	mov	x2, x0
>> +	mov	x3, x1
>> +	multitag_transfer_size x5, x6
>> +1:
>> +CPY_MC(2f, ldgm	x4, [x3])
>> +	stgm	x4, [x2]
>> +	add	x2, x2, x5
>> +	add	x3, x3, x5
>> +	tst	x2, #(PAGE_SIZE - 1)
>> +	b.ne	1b
>> +2:	ret
>> +SYM_FUNC_END(mte_copy_mc_page_tags)
> 
> While the data copy above handles errors on both source and destination,
> here you skip the destination. Any reason?

Oh, my fault, miss the destination.


> 
>> diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
>> index 8dd5a8fe64b4..005ee2a3cb4e 100644
>> --- a/arch/arm64/mm/copypage.c
>> +++ b/arch/arm64/mm/copypage.c
> [...]
>> +#ifdef CONFIG_ARCH_HAS_COPY_MC
>> +void copy_mc_highpage(struct page *to, struct page *from)
>> +{
>> +	void *kto = page_address(to);
>> +	void *kfrom = page_address(from);
>> +
>> +	copy_mc_page(kto, kfrom);
>> +	do_mte(to, from, kto, kfrom, true);
>> +}
>> +EXPORT_SYMBOL(copy_mc_highpage);
>> +
>> +int copy_mc_user_highpage(struct page *to, struct page *from,
>> +			unsigned long vaddr, struct vm_area_struct *vma)
>> +{
>> +	copy_mc_highpage(to, from);
>> +	flush_dcache_page(to);
>> +	return 0;
>> +}
> 
> This one always returns 0. Does it actually catch any memory failures?

Yes, will be fixed next version.

> 
>> +EXPORT_SYMBOL_GPL(copy_mc_user_highpage);
>> +#endif
>> diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
>> index 28ec35e3d210..0fdab18f2f07 100644
>> --- a/arch/arm64/mm/extable.c
>> +++ b/arch/arm64/mm/extable.c
>> @@ -16,6 +16,13 @@ get_ex_fixup(const struct exception_table_entry *ex)
>>   	return ((unsigned long)&ex->fixup + ex->fixup);
>>   }
>>   
>> +static bool ex_handler_fixup(const struct exception_table_entry *ex,
>> +			     struct pt_regs *regs)
>> +{
>> +	regs->pc = get_ex_fixup(ex);
>> +	return true;
>> +}
> 
> Should we prepare some error here like -EFAULT? That's done in
> ex_handler_uaccess_err_zero().

Yes, it should be done here and will be fixed next version.

Thank you for these great suggestions.
Tong.

> 
