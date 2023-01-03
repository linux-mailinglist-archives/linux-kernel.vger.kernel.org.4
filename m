Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA9065BC4C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 09:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237044AbjACIe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 03:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjACIey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 03:34:54 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7DA9596
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 00:34:51 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pCckn-0004ze-Ue; Tue, 03 Jan 2023 09:34:37 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Icenowy Zheng <uwu@icenowy.me>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Icenowy Zheng <uwu@icenowy.me>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>
Subject: Re: [PATCH RESEND 1/2] riscv: errata: fix T-Head dcache.cva encoding
Date:   Tue, 03 Jan 2023 09:34:37 +0100
Message-ID: <2668919.mvXUDI8C0e@diego>
In-Reply-To: <20230103062610.69704-1-uwu@icenowy.me>
References: <20230103062610.69704-1-uwu@icenowy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 3. Januar 2023, 07:26:09 CET schrieb Icenowy Zheng:
> The dcache.cva encoding shown in the comments are wrong, it's for
> dcache.cval1 (which is restricted to L1) instead.
> 
> Fix this in the comment and in the hardcoded instruction.
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> Tested-by: Sergey Matyukevich <sergey.matyukevich@syntacore.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Original was on
https://lore.kernel.org/all/5894419.tdWV9SEqCh@phil/

> ---
> Included when resending:
> - Sergey's Tested-by tag.
> 
>  arch/riscv/include/asm/errata_list.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> index 4180312d2a70..605800bd390e 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -102,7 +102,7 @@ asm volatile(ALTERNATIVE(						\
>   * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
>   *   0000001    01001      rs1       000      00000  0001011
>   * dcache.cva rs1 (clean, virtual address)
> - *   0000001    00100      rs1       000      00000  0001011
> + *   0000001    00101      rs1       000      00000  0001011
>   *
>   * dcache.cipa rs1 (clean then invalidate, physical address)
>   * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> @@ -115,7 +115,7 @@ asm volatile(ALTERNATIVE(						\
>   *   0000000    11001     00000      000      00000  0001011
>   */
>  #define THEAD_inval_A0	".long 0x0265000b"
> -#define THEAD_clean_A0	".long 0x0245000b"
> +#define THEAD_clean_A0	".long 0x0255000b"
>  #define THEAD_flush_A0	".long 0x0275000b"
>  #define THEAD_SYNC_S	".long 0x0190000b"
>  
> 




