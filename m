Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2895FAB63
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 05:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJKDrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 23:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJKDqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 23:46:51 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A9FB0F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 20:46:50 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MmhRz38mWzVhl3;
        Tue, 11 Oct 2022 11:42:23 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 11:46:47 +0800
Subject: Re: [PATCH v2] x86/alternative: fix undefined reference to
 __ibt_endbr_seal[_end]
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>
CC:     <hpa@zytor.com>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20221011113803.956808-1-linmiaohe@huawei.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <4b5f2d25-0cdf-132a-ae34-77e11611dbfc@huawei.com>
Date:   Tue, 11 Oct 2022 11:46:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20221011113803.956808-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/11 19:38, Miaohe Lin wrote:
> Due to the explicit 'noinline' GCC-7.3 is not able to optimize away the
> argument setup of:
> 
> 	apply_ibt_endbr(__ibt_endbr_seal, __ibt_enbr_seal_end);
> 
> even when X86_KERNEL_IBT=n and the function is an empty stub which leads
> to link errors due to missing __ibt_endbr_seal* symbols like below:
> 
> ld: arch/x86/kernel/alternative.o: in function
> `alternative_instructions':
> alternative.c:(.init.text+0x15d): undefined reference to
> `__ibt_endbr_seal_end'
> ld: alternative.c:(.init.text+0x164): undefined reference to
> `__ibt_endbr_seal'
> 
> Remove explicit 'noinline' to help gcc optimize them away.
> [Thanks Peter Zijlstra for tweaking the commit log.]
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Add cc Peter Zijlstra.

Change log for v2:
Tweak the commit log per Peter Zijlstra. Thanks!

I should have done this in previous thread. Sorry for make noise.

Thanks,
Miaohe Lin


> ---
>  arch/x86/kernel/alternative.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 5cadcea035e0..beaf9fc44e2f 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -624,7 +624,7 @@ void __init_or_module noinline apply_ibt_endbr(s32 *start, s32 *end)
>  
>  #else
>  
> -void __init_or_module noinline apply_ibt_endbr(s32 *start, s32 *end) { }
> +void __init_or_module apply_ibt_endbr(s32 *start, s32 *end) { }
>  
>  #endif /* CONFIG_X86_KERNEL_IBT */
>  
> 

