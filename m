Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AADA682559
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 08:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjAaHD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 02:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjAaHDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 02:03:51 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9131A943
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 23:03:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0D14DCE1AA5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:03:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB79EC4339B;
        Tue, 31 Jan 2023 07:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675148612;
        bh=yHafjtlGx559zob+5L07Mz3NVgnDF2i9p8fHCsPaqVs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=CGPOf5Nt8Kl4jeb61PMy6b2ywdOjk2bWmBLtUg+MoE2pyxD9n6XgGcZDZY60+e29b
         z+jxm5cVRyXVk09uZWmGVZPDdxQpdkigKGq8P49Bvk4Vg/3zft3ghuNkjVIoZA1KTi
         csdvNbeYuewXHcUUPkM1/HRgzOzUBosSP40Rh4zumWJOE6WQn7Eied3CeuNrL3Tmj3
         WpaKy+NCePBs36FaZ0mSrTk7JzI01Syvnd9fTIiZOwxwlK0PmANbPtTE0FCzxCNaUP
         W9KNYNg7gsA2qy3iqNcVoK3K3hv/07IM9I0EcUUrHJ8gggX2pqJ0m1iucEf/APEGay
         0MV5TnoWVw9KA==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     "liaochang (A)" <liaochang1@huawei.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mhiramat@kernel.org,
        conor.dooley@microchip.com, penberg@kernel.org,
        mark.rutland@arm.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] riscv: kprobe: Optimize kprobe with accurate atomicity
In-Reply-To: <CAJF2gTSHQ7J1a-0tTzaLAHeUTqbco5OXJgGDZpgB-SLb+teL2A@mail.gmail.com>
References: <20230126161559.1467374-1-guoren@kernel.org>
 <0abbbdd4-6b85-9659-03ee-97c56a5b77c1@huawei.com>
 <CAJF2gTS0s4X_uwLaEeSqKAyRmxCR2vxRuHhz7-SP2w4bBqzr+Q@mail.gmail.com>
 <87r0vc9h4g.fsf@all.your.base.are.belong.to.us>
 <CAJF2gTQZWO8Ubi60nHn-J-8czqBnsp1Kdyoim3uLNkjbYd-H8Q@mail.gmail.com>
 <CAJF2gTSHQ7J1a-0tTzaLAHeUTqbco5OXJgGDZpgB-SLb+teL2A@mail.gmail.com>
Date:   Tue, 31 Jan 2023 08:03:29 +0100
Message-ID: <87cz6vtcce.fsf@all.your.base.are.belong.to.us>
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

>> > >> >  static void __kprobes arch_prepare_simulate(struct kprobe *p)
>> > >> > @@ -114,16 +120,23 @@ void *alloc_insn_page(void)
>> > >> >  /* install breakpoint in text */
>> > >> >  void __kprobes arch_arm_kprobe(struct kprobe *p)
>> > >> >  {
>> > >> > -     if ((p->opcode & __INSN_LENGTH_MASK) =3D=3D __INSN_LENGTH_3=
2)
>> > >> > -             patch_text(p->addr, __BUG_INSN_32);
>> > >> > -     else
>> > >> > -             patch_text(p->addr, __BUG_INSN_16);
>> > >> > +#ifdef CONFIG_RISCV_ISA_C
>> > >> > +     u32 opcode =3D __BUG_INSN_16;
>> > >> > +#else
>> > >> > +     u32 opcode =3D __BUG_INSN_32;
>> > >> > +#endif
>> > >> > +     patch_text_nosync(p->addr, &opcode, GET_INSN_LENGTH(opcode)=
);
>> > >>
>> > >> Sounds good, but it will leave some RVI instruction truncated in ke=
rnel text,
>> > >> i doubt kernel behavior depends on the rest of the truncated instru=
ction, well,
>> > >> it needs more strict testing to prove my concern :)
>> > > I do this on purpose, and it doesn't cause any problems. Don't worry;
>> > > IFU hw must enforce the fetch sequence, and there is no way to execu=
te
>> > > broken instructions even in the speculative execution path.
>> >
>> > This is stretching reality a bit much. ARMv8, e.g., has a chapter in t=
he
>> > Arm ARM [2] Appendix B "Concurrent modification and execution of
>> > instructions" (CMODX). *Some* instructions can be replaced concurrentl=
y,
>> > and others cannot without caution. Assuming that that all RISC-V
>> > implementations can, is a stretch. RISC-V hasn't even specified the
>> > behavior of CMODX (which is problematic).
>> Here we only use one sw/sh instruction to store a 32bit/16bit aligned el=
ement:
>>
>> INSN_0 <- ebreak (16bit/32bit aligned)
>> INSN_1
>> INSN_2
>>
>> The ebreak would cause an exception which implies a huge fence here.
>> No machine could give a speculative execution for the ebreak path.
>
> For ARMv7, ebreak is also safe:
>
> ---
> Concurrent modification and execution of instructions
>
> The ARMv7 architecture limits the set of instructions that can be
> executed by one thread of execution as they are being modified by
> another thread of execution without requiring explicit
> synchronization.
> ...
> The instructions to which this guarantee applies are:
> In the Thumb instruction set
> The 16-bit encodings of the B, NOP, BKPT, and SVC instructions.
> ...
> In the ARM instruction set
> The B, BL, NOP, BKPT, SVC, HVC, and SMC instructions.
> ---

Right, and "B7.7 Concurrent modification and execution of instructions"
Armv8-M ARM (https://developer.arm.com/documentation/ddi0553/latest),
also defines that certain instructions can be concurrently modified.

This is beside the point. We don't have a spec for RISC-V, yet. We're
not even sure we can (in general) replace the lower 16b of an 32b
instruction concurrently. "It's in the Armv8-M spec" is not enough.

I'd love to have a spec defining that, and Derek et al has started
[1]. Slide #99 has CMODX details.

Your patch might be great for some HW (which?), but not enough for
general RISC-V Linux (yet). Until then, the existing stop_machine() way
is unfortunately the way to go.


Bj=C3=B6rn

[1] https://github.com/riscv/riscv-j-extension/blob/master/id-consistency-p=
roposal.pdf
