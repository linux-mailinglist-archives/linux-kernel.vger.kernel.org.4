Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7657E648C87
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 03:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiLJC2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 21:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLJC2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 21:28:15 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC6A2C67C;
        Fri,  9 Dec 2022 18:28:14 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NTWxd4qQfzRphm;
        Sat, 10 Dec 2022 10:27:17 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 10 Dec 2022 10:28:11 +0800
Subject: Re: [PATCH] mce: fix missing stack-dumping in mce_panic()
To:     <bp@alien8.de>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>
CC:     <x86@kernel.org>, <hpa@zytor.com>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tony Luck <tony.luck@intel.com>
References: <20221202163728.392509-1-linmiaohe@huawei.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <470ffd37-3f65-7ad1-71cb-a1d4547d8afa@huawei.com>
Date:   Sat, 10 Dec 2022 10:28:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20221202163728.392509-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/3 0:37, Miaohe Lin wrote:
> When machine check exception occurs, there is no stack-dumping now in
> mce_panic(). It's because bust_spinlocks(1) is called prematurely so
> oops_in_progress will be >= 2 when trying to call dump_stack() in
> panic(). Thus dump_stack() won't be called as this is considered as
> nested stack-dumping.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Friendly ping. ;)

> ---
>  arch/x86/kernel/cpu/mce/core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 2c8ec5c71712..c40dad1a6749 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -254,7 +254,6 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
>  			wait_for_panic();
>  		barrier();
>  
> -		bust_spinlocks(1);
>  		console_verbose();
>  	} else {
>  		/* Don't log too much for fake panic */
> 

