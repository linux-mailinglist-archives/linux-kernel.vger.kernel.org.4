Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7005F9C72
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 12:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbiJJKKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 06:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbiJJKKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 06:10:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31F33C8FD
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 03:10:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2232FB80E6A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:10:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3FCAC433D6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665396637;
        bh=/7KzcIlUMYgbYA0zGrOVHVeZ5fCL2Ww3MvQl4Wew+lU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Tr+465bcOT5hFO7SlhSs8repdkZSmga1G50kMHHnXPBNcsVwLI/6rHUTs8fnmotfu
         iG0iWR4i8U/7/auxXAzNLU8x/rNNqJp6pMuyux65I/yIyNuWEIuK/zt/GO9SMjk22k
         GCzYzotdLUKaXz2WDWBm0AoxsyIUS/qlmNsHz42o+GqZVRlAV7XOZhPA8oSX0795EB
         e8Li3P7ZqQ4b6TGBezI0s9vD2XHFPyx5ry+BU32zbYhkqoalji4RXvG//q3DbIKIkK
         seqfTP7sR+4QLrnADEAR4FLu9P8SNjajHbrDmmsNScrAAgvUXlC2hIQ3vHz9r/7hqD
         jJ8GfPlk0xWCg==
Received: by mail-lf1-f44.google.com with SMTP id s20so15835782lfi.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 03:10:37 -0700 (PDT)
X-Gm-Message-State: ACrzQf0NcTOb0aj1pshsiMcXnyLaQ9hhINbeeyKJRZH20RRHWJHsxZWs
        O0E+vcITBkoUsqUOwY11r4Nc7aor/z2RuYgA/0Y=
X-Google-Smtp-Source: AMsMyM5C6QzJmGEVIeDSqPz/CyImAt1baGq28BvCc7RqRLeoaTCnOiHbN5CTFRx+8m2Am/bHxqt8KBydjAZKOZVpKVU=
X-Received: by 2002:a05:6512:150e:b0:492:d9fd:9bdf with SMTP id
 bq14-20020a056512150e00b00492d9fd9bdfmr6174870lfb.583.1665396635846; Mon, 10
 Oct 2022 03:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <20221010095346.1957-1-thunder.leizhen@huawei.com> <20221010095346.1957-3-thunder.leizhen@huawei.com>
In-Reply-To: <20221010095346.1957-3-thunder.leizhen@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 10 Oct 2022 12:10:24 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFHGPpoSvt3J2XN4tAf2QZ--Lp8KpsuyufSjx+HuRfz0A@mail.gmail.com>
Message-ID: <CAMj1kXFHGPpoSvt3J2XN4tAf2QZ--Lp8KpsuyufSjx+HuRfz0A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: Make the dumped instructions are consistent
 with the disassembled ones
To:     Zhen Lei <thunder.leizhen@huawei.com>
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

On Mon, 10 Oct 2022 at 11:56, Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> In ARM, the mapping of instruction memory is always little-endian, except
> some BE-32 supported ARM architectures. Such as ARMv7-R, its instruction
> endianness may be BE-32. Of course, its data endianness will also be BE-32
> mode. Due to two negatives make a positive, the instruction stored in the
> register after reading is in little-endian format. But for the case of
> BE-8, the instruction endianness is LE, the instruction stored in the
> register after reading is in big-endian format, which is inconsistent
> with the disassembled one.
>
> For example:
> The content of disassembly:
> c0429ee8:       e3500000        cmp     r0, #0
> c0429eec:       159f2044        ldrne   r2, [pc, #68]
> c0429ef0:       108f2002        addne   r2, pc, r2
> c0429ef4:       1882000a        stmne   r2, {r1, r3}
> c0429ef8:       e7f000f0        udf     #0
>
> The output of undefined instruction exception:
> Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
> ... ...
> Code: 000050e3 44209f15 02208f10 0a008218 (f000f0e7)
>
> This inconveniences the checking of instructions. What's worse is that,
> for somebody who don't know about this, might think the instructions are
> all broken.
>
> So, when CONFIG_CPU_ENDIAN_BE8=y, let's convert the instructions to
> little-endian format before they are printed. The conversion result is
> as follows:
> Code: e3500000 159f2044 108f2002 1882000a (e7f000f0)
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  arch/arm/kernel/traps.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index 34aa80c09c508c1..50b00c9091f079d 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -193,6 +193,13 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
>                                 bad = get_user(val, &((u32 __user *)addr)[i]);
>                 }
>
> +               if (IS_ENABLED(CONFIG_CPU_ENDIAN_BE8)) {
> +                       if (thumb)
> +                               val = (__force unsigned int)cpu_to_le16(val);

Better use swab16() here instead of the ugly __force cast, given that
the swab is going to occur unconditionally here.


> +                       else
> +                               val = (__force unsigned int)cpu_to_le32(val);

and swab32() here


> +               }
> +
>                 if (!bad)
>                         p += sprintf(p, i == 0 ? "(%0*x) " : "%0*x ",
>                                         width, val);
> --
> 2.25.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
