Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FE7611ED8
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 03:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiJ2BBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 21:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJ2BBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 21:01:22 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC49C58A9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 18:01:18 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Mzgw40qf8z15MD6;
        Sat, 29 Oct 2022 08:56:20 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 29 Oct 2022 09:01:15 +0800
Message-ID: <14294a23-3746-e933-dfe2-6c766551c0d8@huawei.com>
Date:   Sat, 29 Oct 2022 09:01:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next v2] powerpc/mpic_msgr: fix cast removes address
 space of expression warnings
To:     <mpe@ellerman.id.au>, <npiggin@gmail.com>,
        <christophe.leroy@csgroup.eu>, <joel@jms.id.au>,
        <Julia.Lawall@inria.fr>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>
References: <20221019063414.3758087-1-ruanjinjie@huawei.com>
Content-Language: en-US
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20221019063414.3758087-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping.

On 2022/10/19 14:34, ruanjinjie wrote:
> When build Linux kernel, encounter the following warnings:
> 
> ./arch/powerpc/sysdev/mpic_msgr.c:230:38: warning: cast removes address space '__iomem' of expression
> ./arch/powerpc/sysdev/mpic_msgr.c:230:27: warning: incorrect type in assignment (different address spaces)
> 
> The data type of msgr->mer and msgr->base are 'u32 __iomem *', but
> converted to 'u32 *' and 'u8 *' directly and cause above warnings, now
> instead of using a type cast, change the size of the pointer offset to fix
> these warnings.
> 
> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
> ---
> v2:
> - change the macro of MPIC_MSGR_MER_OFFSET to avoid type cast and
>   simplify the fix
> ---
>  arch/powerpc/sysdev/mpic_msgr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/mpic_msgr.c b/arch/powerpc/sysdev/mpic_msgr.c
> index a439e33eae06..d75064fb7d12 100644
> --- a/arch/powerpc/sysdev/mpic_msgr.c
> +++ b/arch/powerpc/sysdev/mpic_msgr.c
> @@ -20,7 +20,7 @@
>  
>  #define MPIC_MSGR_REGISTERS_PER_BLOCK	4
>  #define MPIC_MSGR_STRIDE		0x10
> -#define MPIC_MSGR_MER_OFFSET		0x100
> +#define MPIC_MSGR_MER_OFFSET		(0x100 / sizeof(u32))
>  #define MSGR_INUSE			0
>  #define MSGR_FREE			1
>  
> @@ -234,7 +234,7 @@ static int mpic_msgr_probe(struct platform_device *dev)
>  
>  		reg_number = block_number * MPIC_MSGR_REGISTERS_PER_BLOCK + i;
>  		msgr->base = msgr_block_addr + i * MPIC_MSGR_STRIDE;
> -		msgr->mer = (u32 *)((u8 *)msgr->base + MPIC_MSGR_MER_OFFSET);
> +		msgr->mer = msgr->base + MPIC_MSGR_MER_OFFSET;
>  		msgr->in_use = MSGR_FREE;
>  		msgr->num = i;
>  		raw_spin_lock_init(&msgr->lock);
