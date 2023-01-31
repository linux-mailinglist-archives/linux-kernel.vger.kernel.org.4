Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553866824C0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 07:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjAaGmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 01:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjAaGl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 01:41:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B343FF23
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 22:40:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59144B81914
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 06:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7208C433D2;
        Tue, 31 Jan 2023 06:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675147243;
        bh=HGGqP/Pod6SsODLD3CZR2XKgRMAKC38fnBK/HFU5oRE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=et1PKkGleQIe9Ebmz0wVxWaM3B6pL2quMxKzOs8ddeE8+fDpa2JLiEN8tdlsEwSt+
         r2B5gMlZw9Yaeey/RewYXbzL/4TWBByH/6K3kO2popDXT3jk4eIExkxnhOZWdgjVM1
         3S78lKkvZc1fLNBjrl2x9ICdxUCI5U4vBtMZy5k9IpbaM2ACIsJqHCiahbFmXOYQwr
         OoF5AcMbqBYOfQsP0QkWnXL4SXUQWpGR53GGkhcGaKknFIWe6QQWe0k4uAwmZafGMe
         yia0qaODJ5Mg7WLM1Xw+ogniiVH44P5OCeRnUOiqninWIRulyduExZ3bYkK4AcTc6O
         Whk21Szhc2EjQ==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     "liaochang (A)" <liaochang1@huawei.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mhiramat@kernel.org,
        conor.dooley@microchip.com, penberg@kernel.org,
        mark.rutland@arm.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] riscv: kprobe: Optimize kprobe with accurate atomicity
In-Reply-To: <CAJF2gTQZWO8Ubi60nHn-J-8czqBnsp1Kdyoim3uLNkjbYd-H8Q@mail.gmail.com>
References: <20230126161559.1467374-1-guoren@kernel.org>
 <0abbbdd4-6b85-9659-03ee-97c56a5b77c1@huawei.com>
 <CAJF2gTS0s4X_uwLaEeSqKAyRmxCR2vxRuHhz7-SP2w4bBqzr+Q@mail.gmail.com>
 <87r0vc9h4g.fsf@all.your.base.are.belong.to.us>
 <CAJF2gTQZWO8Ubi60nHn-J-8czqBnsp1Kdyoim3uLNkjbYd-H8Q@mail.gmail.com>
Date:   Tue, 31 Jan 2023 07:40:40 +0100
Message-ID: <87ilgntdef.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guo Ren <guoren@kernel.org> writes:

> On Mon, Jan 30, 2023 at 11:28 PM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>=
 wrote:
>>
>> Guo Ren <guoren@kernel.org> writes:
>>
>> >> In the serie of RISCV OPTPROBES [1], it patches a long-jump instructi=
ons pair
>> >> AUIPC/JALR in kernel text, so in order to ensure other CPUs does not =
execute
>> >> in the instructions that will be modified, it is still need to stop o=
ther CPUs
>> >> via patch_text API, or you have any better solution to achieve the pu=
rpose?
>> >  - The stop_machine is an expensive way all architectures should
>> > avoid, and you could keep that in your OPTPROBES implementation files
>> > with static functions.
>> >  - The stop_machine couldn't work with PREEMPTION, so your
>> > implementation needs to work with !PREEMPTION.
>>
>> ...and stop_machine() with !PREEMPTION is broken as well, when you're
>> replacing multiple instructions (see Mark's post at [1]). The
>> stop_machine() dance might work when you're replacing *one* instruction,
>> not multiple as in the RISC-V case. I'll expand on this in a comment in
>> the OPTPROBES v6 series.
>>
>> >> >  static void __kprobes arch_prepare_simulate(struct kprobe *p)
>> >> > @@ -114,16 +120,23 @@ void *alloc_insn_page(void)
>> >> >  /* install breakpoint in text */
>> >> >  void __kprobes arch_arm_kprobe(struct kprobe *p)
>> >> >  {
>> >> > -     if ((p->opcode & __INSN_LENGTH_MASK) =3D=3D __INSN_LENGTH_32)
>> >> > -             patch_text(p->addr, __BUG_INSN_32);
>> >> > -     else
>> >> > -             patch_text(p->addr, __BUG_INSN_16);
>> >> > +#ifdef CONFIG_RISCV_ISA_C
>> >> > +     u32 opcode =3D __BUG_INSN_16;
>> >> > +#else
>> >> > +     u32 opcode =3D __BUG_INSN_32;
>> >> > +#endif
>> >> > +     patch_text_nosync(p->addr, &opcode, GET_INSN_LENGTH(opcode));
>> >>
>> >> Sounds good, but it will leave some RVI instruction truncated in kern=
el text,
>> >> i doubt kernel behavior depends on the rest of the truncated instruct=
ion, well,
>> >> it needs more strict testing to prove my concern :)
>> > I do this on purpose, and it doesn't cause any problems. Don't worry;
>> > IFU hw must enforce the fetch sequence, and there is no way to execute
>> > broken instructions even in the speculative execution path.
>>
>> This is stretching reality a bit much. ARMv8, e.g., has a chapter in the
>> Arm ARM [2] Appendix B "Concurrent modification and execution of
>> instructions" (CMODX). *Some* instructions can be replaced concurrently,
>> and others cannot without caution. Assuming that that all RISC-V
>> implementations can, is a stretch. RISC-V hasn't even specified the
>> behavior of CMODX (which is problematic).
> Here we only use one sw/sh instruction to store a 32bit/16bit aligned ele=
ment:
>
> INSN_0 <- ebreak (16bit/32bit aligned)
> INSN_1
> INSN_2
>
> The ebreak would cause an exception which implies a huge fence here.
> No machine could give a speculative execution for the ebreak path.

It's the concurrent modification that I was referring to (removing
stop_machine()). You're saying "it'll always work", I'm saying "I'm not
so sure". :-) E.g., writing c.ebreak on an 32b insn. Can you say that
will work on all RISC-V implementations? Do you have examples of
hardware where it will work?


Bj=C3=B6rn
