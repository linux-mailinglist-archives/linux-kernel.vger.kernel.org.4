Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFB1659ACE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 18:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbiL3RHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 12:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiL3RHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 12:07:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0587B60DB
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 09:07:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9424A61B13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 17:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8AEC43392
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 17:07:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lcUDeWf4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1672420057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WjxzHUW+ATNpAsgtDaf/I/iJFdkXQhViNn4fOLIII1s=;
        b=lcUDeWf4lKIHAVVyjoGjO8ijI+NNWVxDI27VVjPfGAWwA+LQVx1vyNOwDB8IEG7068c3W4
        pGlYYCgvyZ7/3H3uOuceF2NqW1fXnyblaeuM989wZQoLbpb9PEq6RG2KpHw6S1TGvQinm9
        /6hrWRTQO5i5EZCxX3Nm7e03tVlMgPU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 10e78d47 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 30 Dec 2022 17:07:37 +0000 (UTC)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-466c5fb1c39so291828737b3.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 09:07:36 -0800 (PST)
X-Gm-Message-State: AFqh2kpqkwR5oNAy6VwhRuncgmfJc32CLWcJxoHUlgRL0y8L2Sfxzw2d
        Mbv/1Si9UBX99JvWf2H3RxLNsHgTfSL+gF7CLZs=
X-Google-Smtp-Source: AMrXdXvsN2S5QMH5JwSJbK4YGg/FwFOqsInD94Pqq2iqhoozxwTRcxxJ8vkAgXoeUd37EP8apgr/zXKfuzFfEv/NOok=
X-Received: by 2002:a05:690c:a83:b0:36f:de9a:3229 with SMTP id
 ci3-20020a05690c0a8300b0036fde9a3229mr3490284ywb.143.1672420055863; Fri, 30
 Dec 2022 09:07:35 -0800 (PST)
MIME-Version: 1.0
References: <20221228143831.396245-1-Jason@zx2c4.com> <6cab26b5-06ae-468d-ac79-ecdecb86ef07@linaro.org>
 <Y6xvJheSYC83voCZ@zx2c4.com> <Y6x1knb8udpSyMSp@zx2c4.com> <9188EEE9-2759-4389-B39E-0FEBBA3FA57D@zytor.com>
 <Y6z765zHrQ6Rl/0o@zx2c4.com> <AF921575-0968-434A-8B46-095B78C209C1@zytor.com>
 <Y62MdawGaasXmoVL@zn.tnic> <Y68Js5b0jW/2nLU4@zx2c4.com> <Y68Zf/MKmX3Rr18E@zn.tnic>
In-Reply-To: <Y68Zf/MKmX3Rr18E@zn.tnic>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 30 Dec 2022 18:07:24 +0100
X-Gmail-Original-Message-ID: <CAHmME9oPUJemVRvO3HX0q4BJGTFuzbLYANeizuRcNq2=Ykk1Gg@mail.gmail.com>
Message-ID: <CAHmME9oPUJemVRvO3HX0q4BJGTFuzbLYANeizuRcNq2=Ykk1Gg@mail.gmail.com>
Subject: Re: [PATCH qemu] x86: don't let decompressed kernel image clobber setup_data
To:     Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, pbonzini@redhat.com,
        ebiggers@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, ardb@kernel.org, kraxel@redhat.com,
        philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 6:01 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Dec 30, 2022 at 04:54:27PM +0100, Jason A. Donenfeld wrote:
> > > Right, with CONFIG_X86_VERBOSE_BOOTUP=y in a guest here, it says:
> > >
> > > early console in extract_kernel
> > > input_data: 0x000000000be073a8
> > > input_len: 0x00000000008cfc43
> > > output: 0x0000000001000000
> > > output_len: 0x000000000b600a98
> > > kernel_total_size: 0x000000000ac26000
> > > needed_size: 0x000000000b800000
> > > trampoline_32bit: 0x000000000009d000
> > >
> > > so that's a ~9M kernel which gets decompressed at 0x1000000 and the
> > > output len is, what, ~180M which looks like plenty to me...
> >
> > I think you might have misunderstood the thread.
>
> Maybe...
>
> I've been trying to make sense of all the decompression dancing we're doing and
> the diagrams you've drawn and there's a comment over extract_kernel() which
> basically says that the compressed image is at the back of the memory buffer
>
> input_data: 0x000000000be073a8
>
> and we decompress to a smaller address
>
> output: 0x0000000001000000
>
> And, it *looks* like setup_data is at an address somewhere >= 0x1000000 so when
> we start decompressing, we overwrite it.
>
> I guess extract_kernel() could also dump the setup_data addresses so that we can
> verify that...
>
> > First, to reproduce the bug that this patch fixes, you need a kernel with a
> > compressed size of around 16 megs, not 9.
>
> Not only that - you need setup_data to be placed somewhere just so that it gets
> overwritten during decompression. Also, see below.
>
> > Secondly, that crash is well understood and doesn't need to be reproduced;
>
> Is it?
>
> Where do you get the 0x100000 as the starting address of the kernel image?
>
> Because input_data above says that the input address is somewhere higher...

Look closer at the boot process. The compressed image is initially at
0x100000, but it gets relocated to a safer area at the end of
startup_64:

/*
 * Copy the compressed kernel to the end of our buffer
 * where decompression in place becomes safe.
 */
        pushq   %rsi
        leaq    (_bss-8)(%rip), %rsi
        leaq    rva(_bss-8)(%rbx), %rdi
        movl    $(_bss - startup_32), %ecx
        shrl    $3, %ecx
        std
        rep     movsq
        cld
        popq    %rsi

        /*
         * The GDT may get overwritten either during the copy we just did or
         * during extract_kernel below. To avoid any issues, repoint the GDTR
         * to the new copy of the GDT.
         */
        leaq    rva(gdt64)(%rbx), %rax
        leaq    rva(gdt)(%rbx), %rdx
        movq    %rdx, 2(%rax)
        lgdt    (%rax)

/*
 * Jump to the relocated address.
 */
        leaq    rva(.Lrelocated)(%rbx), %rax
        jmp     *%rax

And that address winds up being calculated with a combination of the
image size and the init_size param, so it's safe. Decompression won't
overwrite the compressed kernel.

HOWEVER, qemu currently appends setup_data to the end of the
compressed kernel image, and this part isn't moved, and setup_data
links aren't walked/relocated. So that means the original address
remains, of 0x100000.

Jason
