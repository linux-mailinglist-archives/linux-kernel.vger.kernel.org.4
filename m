Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A495E7AE1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 14:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiIWMfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 08:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiIWMfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 08:35:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF4E127CAA;
        Fri, 23 Sep 2022 05:35:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17602B83101;
        Fri, 23 Sep 2022 12:35:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37D0C433D6;
        Fri, 23 Sep 2022 12:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663936536;
        bh=09mRcGKCdicT2EiSwx9poKFuF1lbe1qx/utrbBqmAEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XVhposLZ4eSYsfYBEGn0xEJoN1w20CmjPf17c4nlgftI1AGQLkbJMleVNE0YE2rfr
         9ACGFcEs49/PgEJ67PD9YOyp6YCXelJnMunqwTQRxYpCFlWBIapw0aw+713MakhE/t
         9H1ntgFvNuISQ5xFGfyTSaBcPNs6Ds6reFX5I3pmnbKVw+O6LAuwjzp0Q+B0zBFqaA
         06Pqm4RHTZK79wEWD+44sGRzjUQzV4B2dMUX6qXVspnMnbOqMdnBCL9Sl/GAkHszUA
         vKkvYR9frDDEYZdj09VN6EcQi3Tq2874ShSnnHk3Kt0DbQJYGS21j3rifPvFPK23ZS
         DJHljxTFkkDuQ==
Date:   Fri, 23 Sep 2022 13:35:30 +0100
From:   Will Deacon <will@kernel.org>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     catalin.marinas@arm.com, guoren@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, mhiramat@kernel.org, rostedt@goodmis.org,
        mark.rutland@arm.com, maz@kernel.org, alexandru.elisei@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 3/3] arm64/kprobe: Optimize the performance of patching
 single-step slot
Message-ID: <20220923123529.GB13942@willie-the-truck>
References: <20220923084658.99304-1-liaochang1@huawei.com>
 <20220923084658.99304-4-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923084658.99304-4-liaochang1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 04:46:58PM +0800, Liao Chang wrote:
> Single-step slot would not be used until kprobe is enabled, that means
> no race condition occurs on it under SMP, hence it is safe to pacth ss
> slot without stopping machine.
> 
> Since I and D caches are coherent within single-step slot from
> aarch64_insn_patch_text_nosync(), hence no need to do it again via
> flush_icache_range().
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  arch/arm64/kernel/probes/kprobes.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index d1d182320245..29b98bc12833 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -44,13 +44,10 @@ post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
>  static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
>  {
>  	kprobe_opcode_t *addr = p->ainsn.api.insn;
> -	void *addrs[] = {addr, addr + 1};
> -	u32 insns[] = {p->opcode, BRK64_OPCODE_KPROBES_SS};
>  
>  	/* prepare insn slot */
> -	aarch64_insn_patch_text(addrs, insns, 2);
> -
> -	flush_icache_range((uintptr_t)addr, (uintptr_t)(addr + MAX_INSN_SIZE));
> +	aarch64_insn_patch_text_nosync(addr, p->opcode);
> +	aarch64_insn_patch_text_nosync(addr + 1, BRK64_OPCODE_KPROBES_SS);
>  
>  	/*
>  	 * Needs restoring of return address after stepping xol.
> -- 
> 2.17.1

Acked-by: Will Deacon <will@kernel.org>

Will
