Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B1F5E90A2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 03:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiIYBWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 21:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiIYBWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 21:22:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C67476C2;
        Sat, 24 Sep 2022 18:22:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4217FB80E08;
        Sun, 25 Sep 2022 01:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41599C433C1;
        Sun, 25 Sep 2022 01:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664068925;
        bh=qhboV+u/W6osVsaLDhVKyfWJzh4Q5MlXbTHoaPiEXHU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JVGVoFhvnFL9oOZRfQ05ElBS3fBaQ2nhBIKBONEoM15IDTA8RW3y42BnaM+OiEaMo
         MPgHf33j3jLlQoNDmpls+XrIQ+vEjvVISRTsf7xhGkt6daz6q7nN+OhcK6x/xh+W0z
         t5D2q9z9IZdllrISTU4IKPFELox9OpkznNG8/fPFLYIK+QiKefHYr0I6nHxD77Jc0P
         3UHIJ86nacQueMkKos2aymrHwQu/M3gjinO0J/gsEqW61VGR05DY02kOX5zKEDHojT
         03MvoA1eIiDzEjDG2VKxhDlU417y7KGeDg525kghdPbfgPKur1GoaNDJMlzhXs+nlB
         bsq+AIXw384Ow==
Date:   Sun, 25 Sep 2022 10:21:59 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "liaochang (A)" <liaochang1@huawei.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <guoren@kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <mhiramat@kernel.org>, <rostedt@goodmis.org>, <maz@kernel.org>,
        <alexandru.elisei@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-csky@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 3/3] arm64/kprobe: Optimize the performance of patching
 single-step slot
Message-Id: <20220925102159.639f39818672ef60a4ddc7f1@kernel.org>
In-Reply-To: <19ffdae6-8484-08e5-f408-ab39a97ce5c0@huawei.com>
References: <20220923084658.99304-1-liaochang1@huawei.com>
        <20220923084658.99304-4-liaochang1@huawei.com>
        <Yy2pAEvWKVloVr3U@FVFF77S0Q05N>
        <19ffdae6-8484-08e5-f408-ab39a97ce5c0@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Sep 2022 09:52:28 +0800
"liaochang (A)" <liaochang1@huawei.com> wrote:

> 
> 
> 在 2022/9/23 20:39, Mark Rutland 写道:
> > On Fri, Sep 23, 2022 at 04:46:58PM +0800, Liao Chang wrote:
> >> Single-step slot would not be used until kprobe is enabled, that means
> >> no race condition occurs on it under SMP, hence it is safe to pacth ss
> >> slot without stopping machine.
> > 
> > I think this is correct, but this depends on a couple of subtleties,
> > importantly:
> > 
> > * That the I-cache maintenance for these instructions is complete *before* the
> >   kprobe BRK is written (and aarch64_insn_patch_text_nosync() ensures this, but
> >   just omits causing a Context-Synchronization-Event on all CPUS).
> 
> So in order to guarantee the I-cache maintenance is observed on all CPUS,
> it needs to be followed by a explicit Context-Synchronization-Event, perhaps
> it is better to place ISB before kprobe BRK is written.
> 
> > 
> > * That the kprobe BRK results in an exception (and consequently a
> >   Context-Synchronoization-Event), which ensures that the CPU will fetch the
> >   single-step slot instructions *after* this, ensuring that the new
> >   instructions are used.
> 
> Yes, because of single-step slot is installed int the BRK execption handler,
> so it is not necessary to generate Context-Synchronization-Event via ISB mentioned above...

Can you update the patch including above as comments in the code?
Maybe you also have to ensure it on other patches too.

Thank you,

> 
> Thanks.
> 
> > 
> > It would be good if we could call that out explicitly.
> > 
> > Thanks,
> > Mark.
> > 
> >> Since I and D caches are coherent within single-step slot from
> >> aarch64_insn_patch_text_nosync(), hence no need to do it again via
> >> flush_icache_range().
> >>
> >> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> >> ---
> >>  arch/arm64/kernel/probes/kprobes.c | 7 ++-----
> >>  1 file changed, 2 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> >> index d1d182320245..29b98bc12833 100644
> >> --- a/arch/arm64/kernel/probes/kprobes.c
> >> +++ b/arch/arm64/kernel/probes/kprobes.c
> >> @@ -44,13 +44,10 @@ post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
> >>  static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
> >>  {
> >>  	kprobe_opcode_t *addr = p->ainsn.api.insn;
> >> -	void *addrs[] = {addr, addr + 1};
> >> -	u32 insns[] = {p->opcode, BRK64_OPCODE_KPROBES_SS};
> >>  
> >>  	/* prepare insn slot */
> >> -	aarch64_insn_patch_text(addrs, insns, 2);
> >> -
> >> -	flush_icache_range((uintptr_t)addr, (uintptr_t)(addr + MAX_INSN_SIZE));
> >> +	aarch64_insn_patch_text_nosync(addr, p->opcode);
> >> +	aarch64_insn_patch_text_nosync(addr + 1, BRK64_OPCODE_KPROBES_SS);
> >>  
> >>  	/*
> >>  	 * Needs restoring of return address after stepping xol.
> >> -- 
> >> 2.17.1
> >>
> > 
> > .
> 
> -- 
> BR,
> Liao, Chang


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
