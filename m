Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265CF682655
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjAaI1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjAaI1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:27:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E9E4609A
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:27:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C03716143D
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:27:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37362C433A0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675153650;
        bh=vvJkcuBJzcKEihNm4yHDz+l6wkDXkHpjcEVKZQPCzOs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ow7KDHkKwue1QI9aSqgMXi5lroBAraU5rwQ+iC0Y+olHHPmrdtY/eYR0ENJwuNSm0
         M01i8TFwqEHDAopwGAFAtyBqomIOeZcZ0SmOn4x0gX8WQ/n0WWvycPLDjVDbIIkIEJ
         ln+frwMMpZIrrulz26Deucm7qnWG2zhJ6S7O/0UliB9TDuxPGZohador2EzJz9K5WW
         hnSlvdnJnXIaiGJSU69vGe+77fZPnMD+s4lowZ6ZG7xpsl38hZC4LcHW2yqEpmDRlw
         Y/y5tbj08YiwMq7ShjE4EDAdUgFc96nG5RgQTVWuu/fvjdeGyBhgn4XKcIZK4taM7D
         9Uy1CAd6A8JeA==
Received: by mail-ej1-f46.google.com with SMTP id dr8so17718108ejc.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:27:30 -0800 (PST)
X-Gm-Message-State: AO0yUKU875FNpl+52ARarJZCv9oeTVmFE06EC/iQw4ANSwYehZrzq4J8
        BaJPb5ck/e/3HT42MDvYuqaCv3IgOIQTpcTjT8o=
X-Google-Smtp-Source: AK7set9bPQmmHFzvDiD0s5yTXhq5uOXgtMci/DwgvnU2EE+1E2I9X8yu9IysQy+f5yGzMebFer8L7rnTlZpV/9OHBMU=
X-Received: by 2002:a17:907:2155:b0:884:c19c:7c6 with SMTP id
 rk21-20020a170907215500b00884c19c07c6mr2286668ejb.120.1675153648392; Tue, 31
 Jan 2023 00:27:28 -0800 (PST)
MIME-Version: 1.0
References: <20230126161559.1467374-1-guoren@kernel.org> <0abbbdd4-6b85-9659-03ee-97c56a5b77c1@huawei.com>
 <CAJF2gTS0s4X_uwLaEeSqKAyRmxCR2vxRuHhz7-SP2w4bBqzr+Q@mail.gmail.com>
 <87r0vc9h4g.fsf@all.your.base.are.belong.to.us> <CAJF2gTQZWO8Ubi60nHn-J-8czqBnsp1Kdyoim3uLNkjbYd-H8Q@mail.gmail.com>
 <CAJF2gTSHQ7J1a-0tTzaLAHeUTqbco5OXJgGDZpgB-SLb+teL2A@mail.gmail.com> <87cz6vtcce.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87cz6vtcce.fsf@all.your.base.are.belong.to.us>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 31 Jan 2023 16:27:16 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQSLZ6nwh8BY3VGgZf61CyfLotX7VV_fy5otMDzSTiNgw@mail.gmail.com>
Message-ID: <CAJF2gTQSLZ6nwh8BY3VGgZf61CyfLotX7VV_fy5otMDzSTiNgw@mail.gmail.com>
Subject: Re: [PATCH] riscv: kprobe: Optimize kprobe with accurate atomicity
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     "liaochang (A)" <liaochang1@huawei.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mhiramat@kernel.org,
        conor.dooley@microchip.com, penberg@kernel.org,
        mark.rutland@arm.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 3:03 PM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wr=
ote:
>
> Guo Ren <guoren@kernel.org> writes:
>
> >> > >> >  static void __kprobes arch_prepare_simulate(struct kprobe *p)
> >> > >> > @@ -114,16 +120,23 @@ void *alloc_insn_page(void)
> >> > >> >  /* install breakpoint in text */
> >> > >> >  void __kprobes arch_arm_kprobe(struct kprobe *p)
> >> > >> >  {
> >> > >> > -     if ((p->opcode & __INSN_LENGTH_MASK) =3D=3D __INSN_LENGTH=
_32)
> >> > >> > -             patch_text(p->addr, __BUG_INSN_32);
> >> > >> > -     else
> >> > >> > -             patch_text(p->addr, __BUG_INSN_16);
> >> > >> > +#ifdef CONFIG_RISCV_ISA_C
> >> > >> > +     u32 opcode =3D __BUG_INSN_16;
> >> > >> > +#else
> >> > >> > +     u32 opcode =3D __BUG_INSN_32;
> >> > >> > +#endif
> >> > >> > +     patch_text_nosync(p->addr, &opcode, GET_INSN_LENGTH(opcod=
e));
> >> > >>
> >> > >> Sounds good, but it will leave some RVI instruction truncated in =
kernel text,
> >> > >> i doubt kernel behavior depends on the rest of the truncated inst=
ruction, well,
> >> > >> it needs more strict testing to prove my concern :)
> >> > > I do this on purpose, and it doesn't cause any problems. Don't wor=
ry;
> >> > > IFU hw must enforce the fetch sequence, and there is no way to exe=
cute
> >> > > broken instructions even in the speculative execution path.
> >> >
> >> > This is stretching reality a bit much. ARMv8, e.g., has a chapter in=
 the
> >> > Arm ARM [2] Appendix B "Concurrent modification and execution of
> >> > instructions" (CMODX). *Some* instructions can be replaced concurren=
tly,
> >> > and others cannot without caution. Assuming that that all RISC-V
> >> > implementations can, is a stretch. RISC-V hasn't even specified the
> >> > behavior of CMODX (which is problematic).
> >> Here we only use one sw/sh instruction to store a 32bit/16bit aligned =
element:
> >>
> >> INSN_0 <- ebreak (16bit/32bit aligned)
> >> INSN_1
> >> INSN_2
> >>
> >> The ebreak would cause an exception which implies a huge fence here.
> >> No machine could give a speculative execution for the ebreak path.
> >
> > For ARMv7, ebreak is also safe:
> >
> > ---
> > Concurrent modification and execution of instructions
> >
> > The ARMv7 architecture limits the set of instructions that can be
> > executed by one thread of execution as they are being modified by
> > another thread of execution without requiring explicit
> > synchronization.
> > ...
> > The instructions to which this guarantee applies are:
> > In the Thumb instruction set
> > The 16-bit encodings of the B, NOP, BKPT, and SVC instructions.
> > ...
> > In the ARM instruction set
> > The B, BL, NOP, BKPT, SVC, HVC, and SMC instructions.
> > ---
>
> Right, and "B7.7 Concurrent modification and execution of instructions"
> Armv8-M ARM (https://developer.arm.com/documentation/ddi0553/latest),
> also defines that certain instructions can be concurrently modified.
>
> This is beside the point. We don't have a spec for RISC-V, yet. We're
> not even sure we can (in general) replace the lower 16b of an 32b
> instruction concurrently. "It's in the Armv8-M spec" is not enough.
>
> I'd love to have a spec defining that, and Derek et al has started
> [1]. Slide #99 has CMODX details.
For the c.ebreak, CMODX is unnecessary. CMODX would give a wider definition=
.

>
> Your patch might be great for some HW (which?), but not enough for
> general RISC-V Linux (yet). Until then, the existing stop_machine() way
> is unfortunately the way to go.
It's generic for c.ebreak, not some HW. It's natural to support. No
machine would break it.

Please let me clarify our argued premise of "ebreak" injection atomicity:
 - c.ebreak on the head of 32b insn
 - ebreak on an aligned 32b insn

>
>
> Bj=C3=B6rn
>
> [1] https://github.com/riscv/riscv-j-extension/blob/master/id-consistency=
-proposal.pdf



--=20
Best Regards
 Guo Ren
