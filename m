Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0075F9D4E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 13:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbiJJLHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 07:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiJJLHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 07:07:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CE35BC3B
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 04:07:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06C5F60DE2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 11:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6DEC433D7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 11:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665400063;
        bh=B+AzV2ZhONY3qHnIHTspBJ5LR4zVG0BS1fmbIV4UnyA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Hqe6DnqeAyjr2jq3XcGDs9NOuxHpLnmWq1L318I0I233zN4tHz5I5bc/6/LBbp6TW
         RiT2ftLtn0S6rFWPAZIGZtlnttKK2QEPGJeHWvjl73IZ+mhLbGbXaPeoFvEdaET+/9
         pfuzOVNpa+7wWEzBC7LiTdnTCPoRiu7viqfSLT1v3iklG1TWyZQP+D/otpeV6V5DPt
         AKdjGPK8kWBpleLt/1Ezn5/961TunrA4eHrei6ugd1phnmr9uhgg21Wi8bP3hdMVr7
         XvUPhCJVMUn3BQB7RC98/dOINC+SJfsY9olCmUll292ONHTeoTG76uBUI4AZWdg7VM
         fjuUPQ0iy+pdA==
Received: by mail-lj1-f179.google.com with SMTP id by36so12834426ljb.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 04:07:43 -0700 (PDT)
X-Gm-Message-State: ACrzQf2dPE2pN7KghO+3OMegapfxKMGqvIYyzUob7v5HNeqb+QWCufOV
        JZh2IpH3iu5MxQ7zOMUiHNH6bbsKihV4Y+kmS0k=
X-Google-Smtp-Source: AMsMyM6aocuLMBstCGeIZyvoZtjQ5KesnAv1ySmfjkiq5DxtlSf4HT/9M/HdkHVbj8mTzhhEY4H4BZP3aMfLtCj+hBY=
X-Received: by 2002:a05:651c:1590:b0:26c:4311:9b84 with SMTP id
 h16-20020a05651c159000b0026c43119b84mr6977362ljq.152.1665400061464; Mon, 10
 Oct 2022 04:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <20221010095346.1957-1-thunder.leizhen@huawei.com>
 <20221010095346.1957-3-thunder.leizhen@huawei.com> <CAMj1kXFHGPpoSvt3J2XN4tAf2QZ--Lp8KpsuyufSjx+HuRfz0A@mail.gmail.com>
 <08054412-06de-3c3e-48b8-1a7eb327a2d0@huawei.com>
In-Reply-To: <08054412-06de-3c3e-48b8-1a7eb327a2d0@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 10 Oct 2022 13:07:30 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHN=oa2bokjX6VJkoW2TC92hVF5pn5a4U40+bJ08k0kMA@mail.gmail.com>
Message-ID: <CAMj1kXHN=oa2bokjX6VJkoW2TC92hVF5pn5a4U40+bJ08k0kMA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: Make the dumped instructions are consistent
 with the disassembled ones
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Oct 2022 at 12:46, Leizhen (ThunderTown)
<thunder.leizhen@huawei.com> wrote:
>
>
>
> On 2022/10/10 18:10, Ard Biesheuvel wrote:
> > On Mon, 10 Oct 2022 at 11:56, Zhen Lei <thunder.leizhen@huawei.com> wrote:
> >>
> >> In ARM, the mapping of instruction memory is always little-endian, except
> >> some BE-32 supported ARM architectures. Such as ARMv7-R, its instruction
> >> endianness may be BE-32. Of course, its data endianness will also be BE-32
> >> mode. Due to two negatives make a positive, the instruction stored in the
> >> register after reading is in little-endian format. But for the case of
> >> BE-8, the instruction endianness is LE, the instruction stored in the
> >> register after reading is in big-endian format, which is inconsistent
> >> with the disassembled one.
> >>
> >> For example:
> >> The content of disassembly:
> >> c0429ee8:       e3500000        cmp     r0, #0
> >> c0429eec:       159f2044        ldrne   r2, [pc, #68]
> >> c0429ef0:       108f2002        addne   r2, pc, r2
> >> c0429ef4:       1882000a        stmne   r2, {r1, r3}
> >> c0429ef8:       e7f000f0        udf     #0
> >>
> >> The output of undefined instruction exception:
> >> Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
> >> ... ...
> >> Code: 000050e3 44209f15 02208f10 0a008218 (f000f0e7)
> >>
> >> This inconveniences the checking of instructions. What's worse is that,
> >> for somebody who don't know about this, might think the instructions are
> >> all broken.
> >>
> >> So, when CONFIG_CPU_ENDIAN_BE8=y, let's convert the instructions to
> >> little-endian format before they are printed. The conversion result is
> >> as follows:
> >> Code: e3500000 159f2044 108f2002 1882000a (e7f000f0)
> >>
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >> ---
> >>  arch/arm/kernel/traps.c | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> >> index 34aa80c09c508c1..50b00c9091f079d 100644
> >> --- a/arch/arm/kernel/traps.c
> >> +++ b/arch/arm/kernel/traps.c
> >> @@ -193,6 +193,13 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
> >>                                 bad = get_user(val, &((u32 __user *)addr)[i]);
> >>                 }
> >>
> >> +               if (IS_ENABLED(CONFIG_CPU_ENDIAN_BE8)) {
> >> +                       if (thumb)
> >> +                               val = (__force unsigned int)cpu_to_le16(val);
> >
> > Better use swab16() here instead of the ugly __force cast, given that
> > the swab is going to occur unconditionally here.
>
> Good idea.
>
> >
> >
> >> +                       else
> >> +                               val = (__force unsigned int)cpu_to_le32(val);
> >
> > and swab32() here
>
> OK
>

Actually, come to think of it, should this code perhaps be using the
mem_to_opcode helpers that are being used elsewhere in the file?
