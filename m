Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142AB6814FC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238193AbjA3P2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238140AbjA3P2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:28:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8664367E4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:28:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2540361180
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403F8C433EF;
        Mon, 30 Jan 2023 15:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675092497;
        bh=AcZ+6LQcfJ+3FmwU9zsCTeQShF/vTWZBT8hNMdtfOgM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=t771CfotsgOeet6SsmHZxofnxjF5IgLLG7iA5r5z06iAMCbpJjnIyIG+MOEehuAqJ
         fk/Oi5NXadt6VvUNOjbA24vloE8vYk8pZ4mSmGiJfygmDZKkoiGsXW3e90hNeREC4d
         1TGJYEYi9hori0Slb9aFavWLBEGX2KUtuSG9DhyH5DTqq2AHeBvcBPdKZK9laSIiXW
         MNaBmm6Ijjuy/RZvasrEfpj1h1WWWN8vkiYUIWqOxpxGESDsNi2DOMnhDEPv8Uhnmi
         k7kPebQbV1CnYeTTgP+jV3dPzgBJqPGSRfbm017Bvcw0OdKeTESp8JK8/MlqYYDM7E
         6stLWoytBxhPQ==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Guo Ren <guoren@kernel.org>,
        "liaochang (A)" <liaochang1@huawei.com>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com, mhiramat@kernel.org,
        conor.dooley@microchip.com, penberg@kernel.org,
        mark.rutland@arm.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] riscv: kprobe: Optimize kprobe with accurate atomicity
In-Reply-To: <CAJF2gTS0s4X_uwLaEeSqKAyRmxCR2vxRuHhz7-SP2w4bBqzr+Q@mail.gmail.com>
References: <20230126161559.1467374-1-guoren@kernel.org>
 <0abbbdd4-6b85-9659-03ee-97c56a5b77c1@huawei.com>
 <CAJF2gTS0s4X_uwLaEeSqKAyRmxCR2vxRuHhz7-SP2w4bBqzr+Q@mail.gmail.com>
Date:   Mon, 30 Jan 2023 16:28:15 +0100
Message-ID: <87r0vc9h4g.fsf@all.your.base.are.belong.to.us>
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

>> In the serie of RISCV OPTPROBES [1], it patches a long-jump instructions=
 pair
>> AUIPC/JALR in kernel text, so in order to ensure other CPUs does not exe=
cute
>> in the instructions that will be modified, it is still need to stop othe=
r CPUs
>> via patch_text API, or you have any better solution to achieve the purpo=
se?
>  - The stop_machine is an expensive way all architectures should
> avoid, and you could keep that in your OPTPROBES implementation files
> with static functions.
>  - The stop_machine couldn't work with PREEMPTION, so your
> implementation needs to work with !PREEMPTION.

...and stop_machine() with !PREEMPTION is broken as well, when you're
replacing multiple instructions (see Mark's post at [1]). The
stop_machine() dance might work when you're replacing *one* instruction,
not multiple as in the RISC-V case. I'll expand on this in a comment in
the OPTPROBES v6 series.

>> >  static void __kprobes arch_prepare_simulate(struct kprobe *p)
>> > @@ -114,16 +120,23 @@ void *alloc_insn_page(void)
>> >  /* install breakpoint in text */
>> >  void __kprobes arch_arm_kprobe(struct kprobe *p)
>> >  {
>> > -     if ((p->opcode & __INSN_LENGTH_MASK) =3D=3D __INSN_LENGTH_32)
>> > -             patch_text(p->addr, __BUG_INSN_32);
>> > -     else
>> > -             patch_text(p->addr, __BUG_INSN_16);
>> > +#ifdef CONFIG_RISCV_ISA_C
>> > +     u32 opcode =3D __BUG_INSN_16;
>> > +#else
>> > +     u32 opcode =3D __BUG_INSN_32;
>> > +#endif
>> > +     patch_text_nosync(p->addr, &opcode, GET_INSN_LENGTH(opcode));
>>
>> Sounds good, but it will leave some RVI instruction truncated in kernel =
text,
>> i doubt kernel behavior depends on the rest of the truncated instruction=
, well,
>> it needs more strict testing to prove my concern :)
> I do this on purpose, and it doesn't cause any problems. Don't worry;
> IFU hw must enforce the fetch sequence, and there is no way to execute
> broken instructions even in the speculative execution path.

This is stretching reality a bit much. ARMv8, e.g., has a chapter in the
Arm ARM [2] Appendix B "Concurrent modification and execution of
instructions" (CMODX). *Some* instructions can be replaced concurrently,
and others cannot without caution. Assuming that that all RISC-V
implementations can, is a stretch. RISC-V hasn't even specified the
behavior of CMODX (which is problematic).

If anything it would be more likely that the existing
"stop_machine()-to-replace-with-ebreak" works (again, replacing one
instruction does not have the !PREEMPTION issues). Then again, no spec,
so mostly guessing from my side. :-(

Oh, but the existing "ebreak replace" might be broken like [3].


Bj=C3=B6rn


[1] https://lore.kernel.org/linux-riscv/Y7%2F6AtX5X0+5qF6Y@FVFF77S0Q05N/
[2] https://developer.arm.com/documentation/ddi0487/latest
[3] https://lore.kernel.org/linux-riscv/20230126170607.1489141-2-guoren@ker=
nel.org/
