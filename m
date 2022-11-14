Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603E76282B3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236768AbiKNOhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236976AbiKNOhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:37:21 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4F82A720
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 06:37:13 -0800 (PST)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id 63D1140002;
        Mon, 14 Nov 2022 14:37:10 +0000 (UTC)
Message-ID: <b82f4580-76a0-e02b-05c8-4a89e576da0c@ghiti.fr>
Date:   Mon, 14 Nov 2022 15:37:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] riscv: mm: Proper page permissions after initmem free
Content-Language: en-US
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org
References: <20221112113543.3165646-1-bjorn@kernel.org>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20221112113543.3165646-1-bjorn@kernel.org>
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

On 12/11/2022 12:35, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
>
> 64-bit RISC-V kernels have the kernel image mapped separately, and in
> addition to the linear map. When the kernel is loaded, the linear map
> of kernel image is set to PAGE_READ permission, and the kernel map is
> set to PAGE_READ and PAGE_EXEC.
>
> When the initmem is freed, the corresponding pages in the linear map
> should be restored to PAGE_READ and PAGE_WRITE. The corresponding
> pages in the kernel map should also be restored to PAGE_READ and
> PAGE_WRITE, by removing the PAGE_EXEC permission, and adding
> PAGE_WRITE.
>
> This is not the case. For 64-bit kernels, only the linear map is
> restored to its proper page permissions at initmem free, and not the
> kernelmap.
>
> In practise this results in that the kernel can potentially jump to
> dead __init code, and start executing invalid 0xcc instructions,
> without getting an exception.
>
> Restore the freed initmem properly, by setting both the alias (kernel
> map) and the linear map to the correct permissions.
>
> Fixes: e5c35fa04019 ("riscv: Map the kernel with correct permissions the first time")
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
> ---
>   arch/riscv/kernel/setup.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index ad76bb59b059..361e635070fe 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -321,10 +321,12 @@ subsys_initcall(topology_init);
>   
>   void free_initmem(void)
>   {
> -	if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX))
> -		set_kernel_memory(lm_alias(__init_begin), lm_alias(__init_end),
> -				  IS_ENABLED(CONFIG_64BIT) ?
> -					set_memory_rw : set_memory_rw_nx);
> +	if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX)) {
> +		if (IS_ENABLED(CONFIG_64BIT))
> +			set_kernel_memory(lm_alias(__init_begin), lm_alias(__init_end),
> +					  set_memory_rw);
> +		set_kernel_memory(__init_begin, __init_end, set_memory_rw_nx);


That's nits but for 64-bit kernels, do we really want to make the kernel 
mapping writable? I think catching a write access here would be better 
because IMO that should not happen.

Thanks,

Alex


> +	}
>   
>   	free_initmem_default(POISON_FREE_INITMEM);
>   }
>
> base-commit: 442bcbfd2c5401587b983e34bed0b407214735c3
