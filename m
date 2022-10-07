Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF71D5F7660
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 11:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiJGJiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 05:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJGJiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 05:38:16 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA792F670
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 02:38:14 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1ogjo0-0006Ah-NY; Fri, 07 Oct 2022 11:38:08 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [PATCH 2/8] riscv: cpufeature: detect RISCV_ALTERNATIVES_EARLY_BOOT earlier
Date:   Fri, 07 Oct 2022 11:38:08 +0200
Message-ID: <2057655.bB369e8A3T@diego>
In-Reply-To: <20221006070818.3616-3-jszhang@kernel.org>
References: <20221006070818.3616-1-jszhang@kernel.org> <20221006070818.3616-3-jszhang@kernel.org>
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

Am Donnerstag, 6. Oktober 2022, 09:08:12 CEST schrieb Jisheng Zhang:
> Now, the riscv_cpufeature_patch_func() do nothing in the stage of
> RISCV_ALTERNATIVES_EARLY_BOOT. We can move the detection of "early
> boot" stage earlier.
> 
> In following patch, we will make riscv_cpufeature_patch_func() scans
> all ISA extensions.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/kernel/cpufeature.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 03611b3ef45e..afa54635c180 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -307,6 +307,9 @@ void __init_or_module riscv_cpufeature_patch_func(struct alt_entry *begin,
>  	struct alt_entry *alt;
>  	u32 tmp;
>  
> +	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
> +		return;
> +

This will work as long as no extension needs early patching,
but we can cross that bridge when this happens :-)

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

>  	for (alt = begin; alt < end; alt++) {
>  		if (alt->vendor_id != 0)
>  			continue;
> 




