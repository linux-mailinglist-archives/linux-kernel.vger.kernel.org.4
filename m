Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8DE5E7AF7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 14:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiIWMjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 08:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiIWMjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 08:39:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5248F638C;
        Fri, 23 Sep 2022 05:39:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA1D3139F;
        Fri, 23 Sep 2022 05:39:39 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.80.223])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2B323F73B;
        Fri, 23 Sep 2022 05:39:30 -0700 (PDT)
Date:   Fri, 23 Sep 2022 13:39:28 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, mhiramat@kernel.org, rostedt@goodmis.org,
        maz@kernel.org, alexandru.elisei@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 3/3] arm64/kprobe: Optimize the performance of patching
 single-step slot
Message-ID: <Yy2pAEvWKVloVr3U@FVFF77S0Q05N>
References: <20220923084658.99304-1-liaochang1@huawei.com>
 <20220923084658.99304-4-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923084658.99304-4-liaochang1@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 04:46:58PM +0800, Liao Chang wrote:
> Single-step slot would not be used until kprobe is enabled, that means
> no race condition occurs on it under SMP, hence it is safe to pacth ss
> slot without stopping machine.

I think this is correct, but this depends on a couple of subtleties,
importantly:

* That the I-cache maintenance for these instructions is complete *before* the
  kprobe BRK is written (and aarch64_insn_patch_text_nosync() ensures this, but
  just omits causing a Context-Synchronization-Event on all CPUS).

* That the kprobe BRK results in an exception (and consequently a
  Context-Synchronoization-Event), which ensures that the CPU will fetch the
  single-step slot instructions *after* this, ensuring that the new
  instructions are used.

It would be good if we could call that out explicitly.

Thanks,
Mark.

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
> 
