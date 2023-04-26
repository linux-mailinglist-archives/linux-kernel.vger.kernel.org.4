Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80736EF135
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240270AbjDZJbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240262AbjDZJbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:31:46 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEB7E7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 02:31:45 -0700 (PDT)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id 30DC1240004;
        Wed, 26 Apr 2023 09:31:35 +0000 (UTC)
Message-ID: <83540cb1-0c9b-f572-849a-cb100437d049@ghiti.fr>
Date:   Wed, 26 Apr 2023 11:31:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH -fixes] riscv: mm: remove redundant parameter of
 create_fdt_early_page_table
Content-Language: en-US
To:     Song Shuai <suagrfillet@gmail.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, alexghiti@rivosinc.com,
        heiko@sntech.de, conor.dooley@microchip.com, guoren@kernel.org,
        anshuman.khandual@arm.com, mick@ics.forth.gr, samuel@sholland.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230426091511.674496-1-suagrfillet@gmail.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230426091511.674496-1-suagrfillet@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Song,


On 4/26/23 11:15, Song Shuai wrote:
> create_fdt_early_page_table() explicitly uses early_pg_dir for
> 32-bit ftb mapping and the pgdir parameter is redundant here.


s/ftb/fdt


> So remove it and its caller.
>
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> ---
>   arch/riscv/mm/init.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 0f14f4a8d179..6ebb75a9a6b9 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -843,8 +843,7 @@ static void __init create_kernel_page_table(pgd_t *pgdir, bool early)
>    * this means 2 PMD entries whereas for 32-bit kernel, this is only 1 PGDIR
>    * entry.
>    */
> -static void __init create_fdt_early_page_table(pgd_t *pgdir,
> -					       uintptr_t fix_fdt_va,
> +static void __init create_fdt_early_page_table(uintptr_t fix_fdt_va,
>   					       uintptr_t dtb_pa)
>   {
>   	uintptr_t pa = dtb_pa & ~(PMD_SIZE - 1);
> @@ -1034,8 +1033,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>   	create_kernel_page_table(early_pg_dir, true);
>   
>   	/* Setup early mapping for FDT early scan */
> -	create_fdt_early_page_table(early_pg_dir,
> -				    __fix_to_virt(FIX_FDT), dtb_pa);
> +	create_fdt_early_page_table(__fix_to_virt(FIX_FDT), dtb_pa);
>   
>   	/*
>   	 * Bootime fixmap only can handle PMD_SIZE mapping. Thus, boot-ioremap


You're right, it was never used, weird the compiler never complained. 
And the function name clearly indicates it is for early_pg_dir so no 
need for this parameter. You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks!

Alex

