Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B896566ED
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 03:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiL0Crt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 21:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiL0Crr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 21:47:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C39EBC
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 18:47:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C70D260F88
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 02:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39326C433EF
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 02:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672109265;
        bh=oRMGUMlgunHooW71GZYStFhBEOASFjUHuzyMLPFO5nI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sWA9GVrGqs4e3Y5+Kl2jqEBRl4eu8CO0PdGIDjicGvBgyGkgX6OP9efEV9YScvhyu
         CoPGiEaEf5Tbg2DgOSFWHbYygi8eDBq/1mI/1mZ+w1x0/6UGol3QPm45RDfv1WhL9+
         i7YQpSFb/uEsHDHiaaiz7oRr8nKW/d1sT4CQ+ZnIl4ZkXKdE6xnXbbp3oLrXjTIpGB
         qrnXvctpfRvyRFUe0ErQJplAWNvgNs+6cKAjMhnBwIsKQMlFrNCdFtIk3a76RWs2vm
         YP4MbW7LHrz9hOWw69OoO7b+7tmx+8INs9nxBgp2CjTc74HYuWVZ1Y7CKYPpTGw23A
         8yB5g1HTCQbwg==
Received: by mail-ej1-f41.google.com with SMTP id vm8so22383323ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 18:47:45 -0800 (PST)
X-Gm-Message-State: AFqh2kpOyZadI9M5Oe1ieZy38Teu9oUO++EcRS2d2NOGVXwmUKJJZ9D1
        +8vpcjkyXkgmye0z6bTQGscMNJUHIyfz4AzUBsc=
X-Google-Smtp-Source: AMrXdXthsdPTILqUKdwYJbA6dO5Mg2riMPD3ExObckEClQ8JKtfwUxkDwiocogZDo29fnoQw7dNbmSuVWY9OPVWl844=
X-Received: by 2002:a17:906:a20c:b0:814:356f:91a8 with SMTP id
 r12-20020a170906a20c00b00814356f91a8mr1126860ejy.74.1672109263267; Mon, 26
 Dec 2022 18:47:43 -0800 (PST)
MIME-Version: 1.0
References: <20221227020258.303900-1-uwu@icenowy.me>
In-Reply-To: <20221227020258.303900-1-uwu@icenowy.me>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 27 Dec 2022 10:47:31 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSGvEnTqEqR9f+zU8T3VS8FoCtsgSk=9hz6cWxAL630zQ@mail.gmail.com>
Message-ID: <CAJF2gTSGvEnTqEqR9f+zU8T3VS8FoCtsgSk=9hz6cWxAL630zQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: errata: fix T-Head dcache.cva encoding
To:     Icenowy Zheng <uwu@icenowy.me>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good catch. But I hope c906/910 can directly use paddr here. It's
unnecessary to cause software translation & mmu translation here.

diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
index b0add983530a..30650a0c4481 100644
--- a/arch/riscv/mm/dma-noncoherent.c
+++ b/arch/riscv/mm/dma-noncoherent.c
@@ -24,13 +24,13 @@ void arch_sync_dma_for_device(phys_addr_t paddr,
size_t size,

        switch (dir) {
        case DMA_TO_DEVICE:
-               ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
+               ALT_CMO_OP(clean, vaddr, paddr, size, riscv_cbom_block_size);
                break;
        case DMA_FROM_DEVICE:
-               ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
+               ALT_CMO_OP(clean, vaddr, paddr, size, riscv_cbom_block_size);
                break;
        case DMA_BIDIRECTIONAL:
-               ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
+               ALT_CMO_OP(flush, vaddr, paddr, size, riscv_cbom_block_size);
                break;
        default:
                break;
@@ -47,7 +47,7 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
                break;
        case DMA_FROM_DEVICE:
        case DMA_BIDIRECTIONAL:
-               ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
+               ALT_CMO_OP(flush, vaddr, paddr, size, riscv_cbom_block_size);
                break;
        default:
                break;
@@ -57,8 +57,9 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 void arch_dma_prep_coherent(struct page *page, size_t size)
 {
        void *flush_addr = page_address(page);
+       phys_addr_t paddr = PFN_PHYS(page_to_pfn(x));

-       ALT_CMO_OP(flush, flush_addr, size, riscv_cbom_block_size);
+       ALT_CMO_OP(flush, flush_addr, paddr, size, riscv_cbom_block_size);
 }

On Tue, Dec 27, 2022 at 10:03 AM Icenowy Zheng <uwu@icenowy.me> wrote:
>
> The dcache.cva encoding shown in the comments are wrong, it's for
> dcache.cval1 (which is restricted to L1) instead.
>
> Fix this in the comment and in the hardcoded instruction.
>
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
> The code is tested on a LiteX SoC with OpenC906 core, and it
> successfully boots to Systemd on a SD card connected to LiteSDCard.
>
> This change should be not noticable on C906, but on multi-core C910
> cluster it should fixes something. Unfortunately TH1520 seems to be not
> so ready to test mainline patches on.
>
>  arch/riscv/include/asm/errata_list.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> index 4180312d2a70..605800bd390e 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -102,7 +102,7 @@ asm volatile(ALTERNATIVE(                                           \
>   * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
>   *   0000001    01001      rs1       000      00000  0001011
>   * dcache.cva rs1 (clean, virtual address)
> - *   0000001    00100      rs1       000      00000  0001011
> + *   0000001    00101      rs1       000      00000  0001011
>   *
>   * dcache.cipa rs1 (clean then invalidate, physical address)
>   * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> @@ -115,7 +115,7 @@ asm volatile(ALTERNATIVE(                                           \
>   *   0000000    11001     00000      000      00000  0001011
>   */
>  #define THEAD_inval_A0 ".long 0x0265000b"
> -#define THEAD_clean_A0 ".long 0x0245000b"
> +#define THEAD_clean_A0 ".long 0x0255000b"
>  #define THEAD_flush_A0 ".long 0x0275000b"
>  #define THEAD_SYNC_S   ".long 0x0190000b"
>
> --
> 2.38.1
>


-- 
Best Regards
 Guo Ren
