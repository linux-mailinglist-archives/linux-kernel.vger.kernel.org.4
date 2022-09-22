Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3932B5E5C79
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 09:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiIVHcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 03:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiIVHcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 03:32:03 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E27979A43
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 00:32:02 -0700 (PDT)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id BD6071C0009;
        Thu, 22 Sep 2022 07:31:56 +0000 (UTC)
Message-ID: <b012edf5-60ae-a45a-4da9-823cd0fd1e93@ghiti.fr>
Date:   Thu, 22 Sep 2022 09:31:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] riscv: Fix crash during early errata patching
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org
References: <20220922054743.30159-1-samuel@sholland.org>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20220922054743.30159-1-samuel@sholland.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

On 9/22/22 07:47, Samuel Holland wrote:
> The patch function for the T-Head PBMT errata calls __pa_symbol() before
> relocation. This crashes when CONFIG_DEBUG_VIRTUAL is enabled, because
> __pa_symbol() forwards to __phys_addr_symbol(), and __phys_addr_symbol()
> checks against the absolute kernel start/end address.
>
> Fix this by directly using the underlying kernel_mapping_va_to_pa().


I'd rather fix __phys_addr_symbol so that we can use __pa_symbol and 
then take advantage of the address range check. Instead of using _end in 
phys_addr_symbol, we have access to the size of the kernel mapping, so 
we could do something like that:

diff --git a/arch/riscv/mm/physaddr.c b/arch/riscv/mm/physaddr.c
index f981b1f95fa0..150691aef058 100644
--- a/arch/riscv/mm/physaddr.c
+++ b/arch/riscv/mm/physaddr.c
@@ -22,7 +22,7 @@ EXPORT_SYMBOL(__virt_to_phys);
  phys_addr_t __phys_addr_symbol(unsigned long x)
  {
         unsigned long kernel_start = kernel_map.virt_addr;
-       unsigned long kernel_end = (unsigned long)_end;
+       unsigned long kernel_end = kernel_map.virt_addr + kernel_map.size;

         /*
          * Boundary checking aginst the kernel image mapping.

Thanks,

Alex

>
> Fixes: a35707c3d850 ("riscv: add memory-type errata for T-Head")
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>
>   arch/riscv/errata/thead/errata.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> index 202c83f677b2..83174f13783e 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -76,8 +76,9 @@ void __init_or_module thead_errata_patch_func(struct alt_entry *begin, struct al
>   		if (cpu_req_errata & tmp) {
>   			/* On vm-alternatives, the mmu isn't running yet */
>   			if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
> -				memcpy((void *)__pa_symbol(alt->old_ptr),
> -				       (void *)__pa_symbol(alt->alt_ptr), alt->alt_len);
> +				memcpy((void *)kernel_mapping_va_to_pa((unsigned long)alt->old_ptr),
> +				       (void *)kernel_mapping_va_to_pa((unsigned long)alt->alt_ptr),
> +				       alt->alt_len);
>   			else
>   				patch_text_nosync(alt->old_ptr, alt->alt_ptr, alt->alt_len);
>   		}
