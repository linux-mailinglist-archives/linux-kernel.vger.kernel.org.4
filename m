Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5E86193D1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiKDJrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbiKDJrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:47:12 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1464D11C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 02:47:09 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N3bLM68R4zJnVQ;
        Fri,  4 Nov 2022 17:44:11 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 17:47:07 +0800
Received: from [10.67.108.67] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 4 Nov
 2022 17:47:07 +0800
Message-ID: <5ebfe6dc-326c-0c33-13dd-d2a6cb2fb11d@huawei.com>
Date:   Fri, 4 Nov 2022 17:47:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] ARM: module: Reclaim the unwind list of module on kmalloc
 failed
To:     Liao Chang <liaochang1@huawei.com>, <linux@armlinux.org.uk>,
        <linus.walleij@linaro.org>, <ardb@kernel.org>, <nico@fluxnic.net>,
        <rmk+kernel@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221103011713.138974-1-liaochang1@huawei.com>
Content-Language: en-US
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <20221103011713.138974-1-liaochang1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/3 9:17, Liao Chang wrote:
> When unwind table allocation failed, it needs to reclaim the unwind list
> of module to avoid potential NULL pointer exception and memory leakage.
>
> Fixes: b6f21d14f1ac ("ARM: 9204/2: module: Add all unwind tables when load module")
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> Cc: Chen Zhongjin <chenzhongjin@huawei.com>
> ---
>   arch/arm/kernel/module.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
> index d59c36dc0494..cc637dcdcb10 100644
> --- a/arch/arm/kernel/module.c
> +++ b/arch/arm/kernel/module.c
> @@ -485,6 +485,10 @@ int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
>   						s->sh_size,
>   						txt_sec->sh_addr,
>   						txt_sec->sh_size);
> +			if (!table) {
> +				module_arch_cleanup(mod);
> +				return -ENOMEM;
> +			}
>   
>   			list_add(&table->mod_list, unwind_list);
>   

Looks good to me.

Reviewed-by: Chen Zhongjin <chenzhongjin@huawei.com>


Thanks.

