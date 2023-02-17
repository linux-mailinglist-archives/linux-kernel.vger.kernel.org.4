Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2049969A622
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 08:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjBQHcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 02:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBQHcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 02:32:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCB897
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 23:32:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C07CEB82B21
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 07:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7572C433D2;
        Fri, 17 Feb 2023 07:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676619137;
        bh=5xD4jXzcX6ADM9Q4atjvv6cAF2d0OwydmHOaNHC5OfA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=HcgKxdToHTOgSmje/rVj3Zuve67M6oC91M/vpc5SLPB++7eQovvuY9Sl7qjvBqksB
         VOu4c19KrAuFeOThWgU7iUjIYomiR9D5YR4dqjXmGigkP+393xQOg0fXb7vNMR3ouJ
         8g9XrIuxyUFNhZ3rrxE0/GYMYgNZJO6/AKLz2C1yf/RhYhp5fv24S4qrTmWWKCs1ds
         CeXNiqOn/X+tSgwhd0See8tl/8VDerFUiX6vT52J7PrCfkFQ3YT0Nz+Av6FgcNMRH+
         d3ueJOSfRid/x68G0yyfDhadf77LBOyslV7yWWkh4QaBmA6wvWtNWvxjhrbaA4kV2m
         iwWZsvOwmnTow==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        "liaochang (A)" <liaochang1@huawei.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mhiramat@kernel.org,
        conor.dooley@microchip.com, penberg@kernel.org,
        mark.rutland@arm.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Changbin Du <changbin.du@huawei.com>
Subject: Re: [PATCH] riscv: kprobe: Optimize kprobe with accurate atomicity
In-Reply-To: <CAJF2gTTacQXg7e3s9s3dALCnPjstGGMPtk5L5SsN_MWKEov+pQ@mail.gmail.com>
References: <20230126161559.1467374-1-guoren@kernel.org>
 <0abbbdd4-6b85-9659-03ee-97c56a5b77c1@huawei.com>
 <CAJF2gTS0s4X_uwLaEeSqKAyRmxCR2vxRuHhz7-SP2w4bBqzr+Q@mail.gmail.com>
 <87r0vc9h4g.fsf@all.your.base.are.belong.to.us>
 <CAJF2gTQZWO8Ubi60nHn-J-8czqBnsp1Kdyoim3uLNkjbYd-H8Q@mail.gmail.com>
 <87ilgntdef.fsf@all.your.base.are.belong.to.us>
 <CAJF2gTTaartwjVdmtmsm1FqmYVuAq5_nGYU5zc6nkdTtCm200A@mail.gmail.com>
 <Y9jz+zUDebQ4VLlF@andrea>
 <CAJF2gTQsRcUpMk8nvFkEsz_fpVV+v6tpUDcPzaNjqfj+i_VvXA@mail.gmail.com>
 <878rgy3v0e.fsf@all.your.base.are.belong.to.us>
 <CAJF2gTTacQXg7e3s9s3dALCnPjstGGMPtk5L5SsN_MWKEov+pQ@mail.gmail.com>
Date:   Fri, 17 Feb 2023 08:32:14 +0100
Message-ID: <87lekwzr0h.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guo Ren <guoren@kernel.org> writes:

> On Thu, Feb 16, 2023 at 3:54 PM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> =
wrote:
>>
>> Guo Ren <guoren@kernel.org> writes:
>>
>> > On Tue, Jan 31, 2023 at 6:57 PM Andrea Parri <parri.andrea@gmail.com> =
wrote:
>> >>
>> >> > > It's the concurrent modification that I was referring to (removing
>> >> > > stop_machine()). You're saying "it'll always work", I'm saying "I=
'm not
>> >> > > so sure". :-) E.g., writing c.ebreak on an 32b insn. Can you say =
that
>> >> > Software must ensure write c.ebreak on the head of an 32b insn.
>> >> >
>> >> > That means IFU only see:
>> >> >  - c.ebreak + broken/illegal insn.
>> >> > or
>> >> >  - origin insn
>> >> >
>> >> > Even in the worst case, such as IFU fetches instructions one by one:
>> >> > If the IFU gets the origin insn, it will skip the broken/illegal in=
sn.
>> >> > If the IFU gets the c.ebreak + broken/illegal insn, then an ebreak
>> >> > exception is raised.
>> >> >
>> >> > Because c.ebreak would raise an exception, I don't see any problem.
>> >>
>> >> That's the problem, this discussion is:
>> >>
>> >> Reviewer: "I'm not sure, that's not written in our spec"
>> >> Submitter: "I said it, it's called -accurate atomicity-"
>> > I really don't see any hardware that could break the atomicity of this
>> > c.ebreak scenario:
>> >  - c.ebreak on the head of 32b insn
>> >  - ebreak on an aligned 32b insn
>> >
>> > If IFU fetches with cacheline, all is atomicity.
>> > If IFU fetches with 16bit one by one, the first c.ebreak would raise
>> > an exception and skip the next broke/illegal instruction.
>> > Even if IFU fetches without any sequence, the IDU must decode one by
>> > one, right? The first half c.ebreak would protect and prevent the next
>> > broke/illegal instruction. Speculative execution on broke/illegal
>> > instruction won't cause any exceptions.
>> >
>> > It's a common issue, not a specific ISA issue.
>> > 32b instruction A -> 16b ebreak + 16b broken/illegal -> 32b
>> > instruction A. It's safe to transform.
>>
>> Waking up this thread again, now that Changbin has showed some interest
>> from another thread [1].
>>
>> Guo, we can't really add your patches, and claim that they're generic,
>> "works on all" RISC-V systems. While it might work for your I/D coherent
>> system, that does not imply that it'll work on all platforms. RISC-V
>> allows for implementations that are I/D incoherent, and here your
>> IFU-implementations arguments do not hold. I'd really recommend to
>> readup on [2].
> Sorry, [2] isn't related to this patch.

Well, it is. Page 44 and 98. You are changing an instruction, that
potentially the processor fetches and executes, from an instruction
storage which has not been made consistent with data storage.

> This patch didn't have I/D incoherent problem because we broadcast the
> IPI fence.i in patch_text_nosync.

After the modification, yes.

> Compared to the stop_machine version, there is a crazy nested IPI
> broadcast cost.
> stop_machine -> patch_text_nosync -> flush_icache_all
> void flush_icache_all(void)
> {
>         local_flush_icache_all();
>
>         if (IS_ENABLED(CONFIG_RISCV_SBI))
>                 sbi_remote_fence_i(NULL);
>         else
>                 on_each_cpu(ipi_remote_fence_i, NULL, 1);
> }
> EXPORT_SYMBOL(flush_icache_all);

Look, I'd love to have your patch in *if we could say that it works on
all RISC-V platforms*. If everyone agrees that "Guo's approach works" --
I'd be a happy person. I hate the stopmachine flow as much as the next
guy. I want a better mechanism in as well. What I'm saying is that:

There's no specification for this. What assumptions can be made? The
fact that Intel, Arm, and power has this explicitly stated in the specs,
hints that this is something to pay attention to. Undefined behavior is
no fun debugging.

You seem very confident that it's impossible to construct hardware where
your approach does not work.

If there's concensus that your approach is "good enough" -- hey, that'd
be great! Get it in!

>> Now how could we move on with your patches? Get it in a spec, or fold
>> the patches in as a Kconfig.socs-thing for the platforms where this is
>> OK. What are you thoughts on the latter?
>
> I didn't talk about I/D incoherent/coherent; what I say is the basic
> size of the instruction element.
> In an I/D cache system, why couldn't LSU store-half guarantee
> atomicity for I-cache fetch? How I-cache could fetch only one byte of
> that Store-half value?
> We've assumed this guarantee in the riscv jump_label implementation,
> so why not this patch couldn't?

Which is a good point. Is that working on all existing implementations?
Is that assumption correct?  We've seen issues with that approach on
*simulation*, where you/Andy fixed it:
https://lore.kernel.org/linux-riscv/20230206090440.1255001-1-guoren@kernel.=
org/

Maybe the RISC-V kernel's assumptions about text patching should just be
documented, and stating "this is what the kernel does, and what it
assumes about the execution environment -- if your hardware doesn't work
with that =C2=AF\_(=E3=83=84)_/=C2=AF".

What are your thoughts on this, Guo? You don't seem to share my
concerns. Or is it better to go for your path (patches!), and simply
change it if there's issues down the line?

