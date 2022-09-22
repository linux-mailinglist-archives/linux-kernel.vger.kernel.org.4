Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CB45E63D9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiIVNjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbiIVNjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:39:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC76B94113;
        Thu, 22 Sep 2022 06:39:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31F5FB836DB;
        Thu, 22 Sep 2022 13:38:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43ECEC433D6;
        Thu, 22 Sep 2022 13:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663853937;
        bh=WQkxwy9+uM/SRC2FYHzdcCK+w8RTynMDiFOabZD95zU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lqamFD9iHOgMkzfGfAVzBv5ruLzL74FJ+zgXEJRtt4fqOC8g4XUhva9pxRb0bxxSz
         njVb6WM0qIpLWWGhhXYtzCKd/XpNjTrix8qJYMPPZXzpVFi3qwET6MalRnv0RzlWdC
         oC7q5R1Od2Il90uExl+izBlL3Qz3UtGEt88mlbRjaIl9IjDqQXDpzX5ZuE9dlrJQ+Y
         16bMnC+3s32qHgraWd1C+zqjBOJKi/7oka3d7KduRNW2VUx9lQphiPfS1ACvTihTE3
         M8zAG2R76g/2SDU9F033fiU5vLoPmuSEtFvmDwTkfw6RfwO2NCFwXeaaHUKuM28pE/
         V9Hl/k2hsF7lw==
Date:   Thu, 22 Sep 2022 14:38:51 +0100
From:   Will Deacon <will@kernel.org>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     catalin.marinas@arm.com, guoren@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mhiramat@kernel.org,
        maz@kernel.org, alexandru.elisei@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH V2 3/3] arm64/kprobe: Optimize the performance of
 patching single-step slot
Message-ID: <20220922133850.GC12095@willie-the-truck>
References: <20220913033454.104519-1-liaochang1@huawei.com>
 <20220913033454.104519-4-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913033454.104519-4-liaochang1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 11:34:54AM +0800, Liao Chang wrote:
> Single-step slot would not be used until kprobe is enabled, that means
> no race condition occurs on it under SMP, hence it is safe to pacth ss
> slot without stopping machine.
> 
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  arch/arm64/kernel/probes/kprobes.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index d1d182320245..5902e33fd3b6 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -44,11 +44,10 @@ post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
>  static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
>  {
>  	kprobe_opcode_t *addr = p->ainsn.api.insn;
> -	void *addrs[] = {addr, addr + 1};
> -	u32 insns[] = {p->opcode, BRK64_OPCODE_KPROBES_SS};
>  
>  	/* prepare insn slot */
> -	aarch64_insn_patch_text(addrs, insns, 2);
> +	aarch64_insn_write(addr, p->opcode);
> +	aarch64_insn_write(addr + 1, BRK64_OPCODE_KPROBES_SS);
>  
>  	flush_icache_range((uintptr_t)addr, (uintptr_t)(addr + MAX_INSN_SIZE));

Hmm, so it looks like prior to your change we were doing the cache
maintebnance twice: once in aarch64_insn_patch_text() from stop machine
context and then again in the flush_icache_range() call above.

I suppose the cleanest thing would be to drop the flush_icache_range()
call and then use aarch64_insn_patch_text_nosync() instead of
aarch64_insn_write() in your change.

Will
