Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0975E6A1A03
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjBXKV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjBXKVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:21:52 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482FC1A647
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:21:21 -0800 (PST)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id CF0F9100006;
        Fri, 24 Feb 2023 10:21:16 +0000 (UTC)
Message-ID: <22aeef5b-99cf-bf98-daa1-8e7cf22dffa7@ghiti.fr>
Date:   Fri, 24 Feb 2023 11:21:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 3/4] RISC-V: mm: Enable huge page support to
 kernel_page_present() function
Content-Language: en-US
To:     Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        leyfoon.tan@starfivetech.com, mason.huo@starfivetech.com
References: <20230221023523.1498500-1-jeeheng.sia@starfivetech.com>
 <20230221023523.1498500-4-jeeheng.sia@starfivetech.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230221023523.1498500-4-jeeheng.sia@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/21/23 03:35, Sia Jee Heng wrote:
> Currently kernel_page_present() function doesn't support huge page
> detection causes the function to mistakenly return false to the
> hibernation core.
>
> Add huge page detection to the function to solve the problem.
>
> Fixes tag: commit 9e953cda5cdf ("riscv:
> Introduce huge page support for 32/64bit kernel")
>
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
> ---
>   arch/riscv/mm/pageattr.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
> index 86c56616e5de..ea3d61de065b 100644
> --- a/arch/riscv/mm/pageattr.c
> +++ b/arch/riscv/mm/pageattr.c
> @@ -217,18 +217,26 @@ bool kernel_page_present(struct page *page)
>   	pgd = pgd_offset_k(addr);
>   	if (!pgd_present(*pgd))
>   		return false;
> +	if (pgd_leaf(*pgd))
> +		return true;
>   
>   	p4d = p4d_offset(pgd, addr);
>   	if (!p4d_present(*p4d))
>   		return false;
> +	if (p4d_leaf(*p4d))
> +		return true;
>   
>   	pud = pud_offset(p4d, addr);
>   	if (!pud_present(*pud))
>   		return false;
> +	if (pud_leaf(*pud))
> +		return true;
>   
>   	pmd = pmd_offset(pud, addr);
>   	if (!pmd_present(*pmd))
>   		return false;
> +	if (pmd_leaf(*pmd))
> +		return true;
>   
>   	pte = pte_offset_kernel(pmd, addr);
>   	return pte_present(*pte);


Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex

