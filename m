Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76F65BC9B9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiISKqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiISKqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:46:02 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA2C6595
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 03:29:03 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MWLQr0bnZzQj7k;
        Mon, 19 Sep 2022 18:25:08 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 18:29:00 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 18:29:00 +0800
Message-ID: <269c06a8-3885-dbcf-a26e-e7c2312d435d@huawei.com>
Date:   Mon, 19 Sep 2022 18:29:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] ARM: mm: Provide better fault message for permission
 fault
Content-Language: en-US
To:     Russell King <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220919051130.1339-1-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20220919051130.1339-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, is_permission_fault() could be used if CONFIG_MMU disabled, will 
resend.

On 2022/9/19 13:11, Kefeng Wang wrote:
> If there is a permission fault in __do_kernel_fault(), we only
> print the generic "paging request" message which don't show
> read, write or execute information, let's provide better fault
> message for them.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   arch/arm/mm/fault.c | 35 +++++++++++++++++++++--------------
>   1 file changed, 21 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index 46cccd6bf705..d1b848f0f7ed 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -95,6 +95,19 @@ void show_pte(const char *lvl, struct mm_struct *mm, unsigned long addr)
>   
>   	pr_cont("\n");
>   }
> +
> +static inline bool is_permission_fault(unsigned int fsr)
> +{
> +	int fs = fsr_fs(fsr);
> +#ifdef CONFIG_ARM_LPAE
> +	if ((fs & FS_PERM_NOLL_MASK) == FS_PERM_NOLL)
> +		return true;
> +#else
> +	if (fs == FS_L1_PERM || fs == FS_L2_PERM)
> +		return true;
> +#endif
> +	return false;
> +}
>   #else					/* CONFIG_MMU */
>   void show_pte(const char *lvl, struct mm_struct *mm, unsigned long addr)
>   { }
> @@ -137,7 +150,14 @@ __do_kernel_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
>   	/*
>   	 * No handler, we'll have to terminate things with extreme prejudice.
>   	 */
> -	if (addr < PAGE_SIZE) {
> +	if (is_permission_fault(fsr)) {
> +		if (fsr & FSR_WRITE)
> +			msg = "write to read-only memory";
> +		else if (fsr & FSR_LNX_PF)
> +			msg = "execute from non-executable memory";
> +		else
> +			msg = "read from unreadable memory";
> +	} else if (addr < PAGE_SIZE) {
>   		msg = "NULL pointer dereference";
>   	} else {
>   		if (kfence_handle_page_fault(addr, is_write_fault(fsr), regs))
> @@ -204,19 +224,6 @@ void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>   #define VM_FAULT_BADMAP		((__force vm_fault_t)0x010000)
>   #define VM_FAULT_BADACCESS	((__force vm_fault_t)0x020000)
>   
> -static inline bool is_permission_fault(unsigned int fsr)
> -{
> -	int fs = fsr_fs(fsr);
> -#ifdef CONFIG_ARM_LPAE
> -	if ((fs & FS_PERM_NOLL_MASK) == FS_PERM_NOLL)
> -		return true;
> -#else
> -	if (fs == FS_L1_PERM || fs == FS_L2_PERM)
> -		return true;
> -#endif
> -	return false;
> -}
> -
>   static vm_fault_t __kprobes
>   __do_page_fault(struct mm_struct *mm, unsigned long addr, unsigned int flags,
>   		unsigned long vma_flags, struct pt_regs *regs)
