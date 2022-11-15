Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A779D629CAD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiKOOxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKOOxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:53:53 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0795F1B3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:53:51 -0800 (PST)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id B0C8C1C0009;
        Tue, 15 Nov 2022 14:53:47 +0000 (UTC)
Message-ID: <1057a6ba-3778-f419-fb99-029c26092871@ghiti.fr>
Date:   Tue, 15 Nov 2022 15:53:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] riscv: mm: Proper page permissions after initmem free
Content-Language: en-US
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org
References: <20221115090641.258476-1-bjorn@kernel.org>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20221115090641.258476-1-bjorn@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Björn,

On 15/11/2022 10:06, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
>
> 64-bit RISC-V kernels have the kernel image mapped separately to alias
> the linear map. The linear map and the kernel image map are documented
> as "direct mapping" and "kernel" respectively in [1].
>
> At image load time, the linear map corresponding to the kernel image
> is set to PAGE_READ permission, and the kernel image map is set to
> PAGE_READ|PAGE_EXEC.
>
> When the initmem is freed, the pages in the linear map should be
> restored to PAGE_READ|PAGE_WRITE, whereas the corresponding pages in
> the kernel image map should be restored to PAGE_READ, by removing the
> PAGE_EXEC permission.
>
> This is not the case. For 64-bit kernels, only the linear map is
> restored to its proper page permissions at initmem free, and not the
> kernel image map.
>
> In practise this results in that the kernel can potentially jump to
> dead __init code, and start executing invalid instructions, without
> getting an exception.
>
> Restore the freed initmem properly, by setting both the kernel image
> map to the correct permissions.
>
> [1] Documentation/riscv/vm-layout.rst
>
> Fixes: e5c35fa04019 ("riscv: Map the kernel with correct permissions the first time")
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
> ---
> v2: * Do not set the kernel image map to PAGE_WRITE. (Alex)
>      * Massaged the commit message a bit.
>      
> Samuel, I removed your Reviewed-by:/Tested-by: for the v2.
> ---
>   arch/riscv/kernel/setup.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 67ec1fadcfe2..86acd690d529 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -322,10 +322,11 @@ subsys_initcall(topology_init);
>   
>   void free_initmem(void)
>   {
> -	if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX))
> -		set_kernel_memory(lm_alias(__init_begin), lm_alias(__init_end),
> -				  IS_ENABLED(CONFIG_64BIT) ?
> -					set_memory_rw : set_memory_rw_nx);
> +	if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX)) {
> +		set_kernel_memory(lm_alias(__init_begin), lm_alias(__init_end), set_memory_rw_nx);
> +		if (IS_ENABLED(CONFIG_64BIT))
> +			set_kernel_memory(__init_begin, __init_end, set_memory_nx);
> +	}
>   
>   	free_initmem_default(POISON_FREE_INITMEM);
>   }


This looks good to me, I tested it on both defconfig and rv32_defconfig 
on qemu, so you can add:

Reviewed-by: Alexandre Ghiti <alex@ghiti.fr>
Tested-by: Alexandre Ghiti <alex@ghiti.fr>

Thanks,

Alex


> base-commit: 22dce2b89d6043d5c3f68384285fff5506109317
