Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E135F9D86
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 13:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiJJLYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 07:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiJJLYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 07:24:19 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFE066A7A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 04:24:18 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MmGhV3qPxzwPYT;
        Mon, 10 Oct 2022 19:21:46 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 19:24:16 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 19:24:16 +0800
Message-ID: <4339e1f4-b5c1-0b61-3a37-e63aafe22857@huawei.com>
Date:   Mon, 10 Oct 2022 19:24:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3] ARM: mm: Provide better message when kernel fault
Content-Language: en-US
To:     Russell King <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <YzF7X2PBdps2MaG/@shell.armlinux.org.uk>
 <20220927062134.99019-1-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20220927062134.99019-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/9/27 14:21, Kefeng Wang wrote:
> If there is a kernel fault, see do_kernel_fault(), we only print
> the generic "paging request" or "NULL pointer dereference" message
> which don't show read, write or excute information, let's provide
> better fault message for them.

Hi Russell, what's your option about this one, if no object,

I will send to ARM patch system, thanks,

> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> v3: show the infos in die_kernel_fault()
>   arch/arm/mm/fault.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index 46cccd6bf705..f8fe0ec64c23 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -111,8 +111,9 @@ static void die_kernel_fault(const char *msg, struct mm_struct *mm,
>   {
>   	bust_spinlocks(1);
>   	pr_alert("8<--- cut here ---\n");
> -	pr_alert("Unable to handle kernel %s at virtual address %08lx\n",
> -		 msg, addr);
> +	pr_alert("Unable to handle kernel %s at virtual address %08lx when %s\n",
> +		 msg, addr, fsr & FSR_LNX_PF ? "execute" :
> +		 fsr & FSR_WRITE ? "write" : "read");
>   
>   	show_pte(KERN_ALERT, mm, addr);
>   	die("Oops", regs, fsr);
