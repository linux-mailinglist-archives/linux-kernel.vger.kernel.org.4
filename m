Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABB35BECB0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 20:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiITSSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 14:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiITSSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 14:18:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF6D5209A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 11:18:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52F6362C16
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 18:18:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC72C433D6;
        Tue, 20 Sep 2022 18:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663697879;
        bh=+HVQJ3kjgFnkSJtb8OPsQU+IhPNSgPKAs+x42YJ7ydE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pHI/lt+yv0PsEyiEwS5iu3nWREEzeNYXInMX653FA0omaolG9fUxT60G7w7dXZp6B
         I7tkakIdOCCPCTBwkYTZTY4AGs8Qg5WthOoov1+tLQGdQ5iWhpQeVMKJZqN98FsbSp
         DYw8v0ka5jGcAy2yqNtRk9oaR1Fjzb0drsnJ5wzv2LuAKmG47WjAToGPugl5/IzMxd
         Pcm8RcLOXdBu9pwQovP+v1cjHUaQ8fWkZOVpHH117ddOFoooLQlo5bNwS58yO+JrCr
         XAklb989/PUhHj10s4uEkIFjHj9fOTRy7eCSTkHRmdYqmJyK0+SMTvnRDUkTMARCxk
         R9GVlsr4SO/SQ==
Received: by pali.im (Postfix)
        id 710ED97E; Tue, 20 Sep 2022 20:17:56 +0200 (CEST)
Date:   Tue, 20 Sep 2022 20:17:56 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/highmem: Properly handle fragmented memory
Message-ID: <20220920181756.snty255rhiexjvzh@pali>
References: <f08cca5c46d67399c53262eca48e015dcf1841f9.1663695394.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f08cca5c46d67399c53262eca48e015dcf1841f9.1663695394.git.christophe.leroy@csgroup.eu>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 September 2022 19:36:42 Christophe Leroy wrote:
> In addition to checking whether a page is reserved before allocating
> it to highmem, verify that it is valid memory.
> 
> Otherwise the kernel Oopses as below:
> 
> [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    0.000000] Kernel attempted to read user page (7df58) - exploit attempt? (uid: 0)
> [    0.000000] BUG: Unable to handle kernel data access on read at 0x0007df58
> [    0.000000] Faulting instruction address: 0xc01c8348
> [    0.000000] Oops: Kernel access of bad area, sig: 11 [#1]
> [    0.000000] BE PAGE_SIZE=4K SMP NR_CPUS=2 P2020RDB-PC
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.0.0-rc2-0caacb197b677410bdac81bc34f05235+ #121
> [    0.000000] NIP:  c01c8348 LR: c01cb2bc CTR: 0000000a
> [    0.000000] REGS: c10d7e20 TRAP: 0300   Not tainted  (6.0.0-rc2-0caacb197b677410bdac81bc34f05235+)
> [    0.000000] MSR:  00021000 <CE,ME>  CR: 48044224  XER: 00000000
> [    0.000000] DEAR: 0007df58 ESR: 00000000
> [    0.000000] GPR00: c01cb294 c10d7f10 c1045340 00000001 00000004 c112bcc0 00000015 eedf1000
> [    0.000000] GPR08: 00000003 0007df58 00000000 f0000000 28044228 00000200 00000000 00000000
> [    0.000000] GPR16: 00000000 00000000 00000000 0275cb7a c0000000 00000001 0000075f 00000000
> [    0.000000] GPR24: c1031004 00000000 00000000 00000001 c10f0000 eedf1000 00080000 00080000
> [    0.000000] NIP [c01c8348] free_unref_page_prepare.part.93+0x48/0x60
> [    0.000000] LR [c01cb2bc] free_unref_page+0x84/0x4b8
> [    0.000000] Call Trace:
> [    0.000000] [c10d7f10] [eedf1000] 0xeedf1000 (unreliable)
> [    0.000000] [c10d7f20] [c01cb294] free_unref_page+0x5c/0x4b8
> [    0.000000] [c10d7f70] [c1007644] mem_init+0xd0/0x194
> [    0.000000] [c10d7fa0] [c1000e4c] start_kernel+0x4c0/0x6d0
> [    0.000000] [c10d7ff0] [c00003e0] set_ivor+0x13c/0x178
> [    0.000000] Instruction dump:
> [    0.000000] 552817be 5509103a 7d294214 55293830 7d4a4a14 812a003c 814a0038 5529002a
> [    0.000000] 7c892050 5484c23a 5489eafa 548406fe <7d2a482e> 7d242430 5484077e 90870010
> [    0.000000] ---[ end trace 0000000000000000 ]---
> 
> Reported-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Hello and thank you for care about this issue!

I have already tested this change, it fixes crash, so add my:

Tested-by: Pali Rohár <pali@kernel.org>

Anyway, should there be some Fixes: tag? E.g.

Fixes: b0e0d68b1c52 ("powerpc/32: Allow fragmented physical memory")

(which enabled support for fragmented memory and therefore kernel
started crashing?)

Link: https://lore.kernel.org/linuxppc-dev/20220908201701.sd3zqn5hfixmjvhh@pali/

> ---
>  arch/powerpc/mm/mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 01772e79fd93..6ddbd6cb3a2a 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -302,7 +302,7 @@ void __init mem_init(void)
>  		for (pfn = highmem_mapnr; pfn < max_mapnr; ++pfn) {
>  			phys_addr_t paddr = (phys_addr_t)pfn << PAGE_SHIFT;
>  			struct page *page = pfn_to_page(pfn);
> -			if (!memblock_is_reserved(paddr))
> +			if (memblock_is_memory(paddr) && !memblock_is_reserved(paddr))
>  				free_highmem_page(page);
>  		}
>  	}
> -- 
> 2.37.1
> 
