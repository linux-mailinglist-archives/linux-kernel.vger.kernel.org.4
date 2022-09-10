Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8763B5B43BB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 04:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiIJCYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 22:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiIJCYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 22:24:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7F221809
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 19:24:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 565B1B82624
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 02:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36DEC433D6;
        Sat, 10 Sep 2022 02:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662776680;
        bh=io4rGpmTLzIQymApR1FQ0JROcbXXYwJLqgIkb1TY2S8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tLD7rq2saOfG/rFAIfRZpvIHMOn1+gVhCmWZrtJ4ki2GqYpEacMGF5FCD5Ou/YcEq
         zJVUjxYa/74Fkkni/kUYRRhSclC3pHAvTW28gA0aCep9pv0ayLipgnwApUroTnmWsB
         9+68GHJQkIIEBIwESEC7x5XczfkTIezQR3pAAQSs79PDWQaD+PB/euT9xohkugI26M
         VfOq6qIsx468UU10ruL6tAwHbquav439G+XDYkRw/UBBU/E56oJR4TF1+PxTKZ1Exh
         wLG5+nuqEnT65nzzHAFDvTSjuiEFL648riBG6d/nHrXvVXNOk/eFdpUL3hASgcF2/m
         VqTVeu1hbxaUA==
Date:   Sat, 10 Sep 2022 11:24:35 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "liaochang (A)" <liaochang1@huawei.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <rostedt@goodmis.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv/kprobe: Optimize the performance of patching
 instruction slot
Message-Id: <20220910112435.3c3f72afee5182f7ec1c1ce6@kernel.org>
In-Reply-To: <50a65f24-08b7-ab36-5e25-b6a90f90a9d8@huawei.com>
References: <20220907023327.85630-1-liaochang1@huawei.com>
        <YxjTF2FlIJbbKq0p@xhacker>
        <a00328a1-47ee-3700-8cd8-1a9f4e0d7a2b@huawei.com>
        <20220908214958.c8139533dccad1ee8f927214@kernel.org>
        <50a65f24-08b7-ab36-5e25-b6a90f90a9d8@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Sep 2022 09:55:08 +0800
"liaochang (A)" <liaochang1@huawei.com> wrote:
> 
> 
> 在 2022/9/8 20:49, Masami Hiramatsu (Google) 写道:
> > On Thu, 8 Sep 2022 09:43:45 +0800
> > "liaochang (A)" <liaochang1@huawei.com> wrote:
> > 
> >> Thanks for comment.
> >>
> >> 在 2022/9/8 1:21, Jisheng Zhang 写道:
> >>> On Wed, Sep 07, 2022 at 10:33:27AM +0800, Liao Chang wrote:
> >>>> Since no race condition occurs on each instruction slot, hence it is
> >>>> safe to patch instruction slot without stopping machine.
> >>>
> >>> hmm, IMHO there's race when arming kprobe under SMP, so stopping
> >>> machine is necessary here. Maybe I misundertand something.
> >>>
> >>
> >> It is indeed necessary to stop machine when arm kprobe under SMP,
> >> but i don't think it need to stop machine when prepare instruction slot,
> >> two reasons:
> >>
> >> 1. Instruction slot is dynamically allocated data.
> >> 2. Kernel would not execute instruction slot until original instruction
> >>    is replaced by breakpoint.
> > 
> > Ah, this is for ss (single step out of line) slot. So until
> > kprobe is enabled, this should not be used from other cores.
> > OK, then it should be safe.
> 
> Exactly, Masami, and i find out this optimization could be applied to some other
> architectures, such as arm64 and csky, do you think it is good time to do them all.

Yes, we should reduce the stop_machine() usage. Thanks for pointing it!

> 
> Thanks.
> 
> > 
> > 
> >>>>
> >>>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> >>>> ---
> >>>>  arch/riscv/kernel/probes/kprobes.c | 8 +++++---
> >>>>  1 file changed, 5 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
> >>>> index e6e950b7cf32..eff7d7fab535 100644
> >>>> --- a/arch/riscv/kernel/probes/kprobes.c
> >>>> +++ b/arch/riscv/kernel/probes/kprobes.c
> >>>> @@ -24,12 +24,14 @@ post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
> >>>>  static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
> >>>>  {
> >>>>  	unsigned long offset = GET_INSN_LENGTH(p->opcode);
> >>>> +	const kprobe_opcode_t brk_insn = __BUG_INSN_32;
> >>>> +	kprobe_opcode_t slot[MAX_INSN_SIZE];
> >>>>  
> >>>>  	p->ainsn.api.restore = (unsigned long)p->addr + offset;
> >>>>  
> >>>> -	patch_text(p->ainsn.api.insn, p->opcode);
> >>>> -	patch_text((void *)((unsigned long)(p->ainsn.api.insn) + offset),
> >>>> -		   __BUG_INSN_32);
> >>>> +	memcpy(slot, &p->opcode, offset);
> >>>> +	memcpy((void *)((unsigned long)slot + offset), &brk_insn, 4);
> >>>> +	patch_text_nosync(p->ainsn.api.insn, slot, offset + 4);
> > 
> > BTW, didn't you have a macro for the size of __BUG_INSN_32?
> > 
> > Thank you,
> 
> I think you are saying GET_INSN_LENGTH, i will use it to caculate
> the size of __BUG_INSN_32 in v2, instead of magic number '4'.


Yeah, that's better.

Thank you!

> 
> Thanks.
> 
> > 
> > 
> >>>>  }
> >>>>  
> >>>>  static void __kprobes arch_prepare_simulate(struct kprobe *p)
> >>>> -- 
> >>>> 2.17.1
> >>>>
> >>>>
> >>>> _______________________________________________
> >>>> linux-riscv mailing list
> >>>> linux-riscv@lists.infradead.org
> >>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> >>> .
> >>
> >> -- 
> >> BR,
> >> Liao, Chang
> > 
> > 
> 
> -- 
> BR,
> Liao, Chang


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
