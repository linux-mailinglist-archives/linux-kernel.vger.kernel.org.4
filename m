Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B265659BC5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 20:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiL3TyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 14:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiL3TyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 14:54:19 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A273B11A1F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 11:54:17 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 38F521EC0453;
        Fri, 30 Dec 2022 20:54:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672430056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4d9mZokcf7UfkVL0VJHyHQx1vADaAzgo+xzFXO0gE5U=;
        b=W3nWTuFC4+SoGZ4dg81fPRaAAOUn4LHr8f0gnB3ufyE6nEkFfLvxLQNpkbhC44gAyUUF6Z
        7mUlobY/V4ClDBHLImUQq70yjMtiydadbCZ+vL782EL3ew4sB2C7+rqkiqROk6kI48xHlF
        Y9y8ACSasRhvBCzpFWIu1WVIfz2q/vk=
Date:   Fri, 30 Dec 2022 20:54:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, pbonzini@redhat.com,
        ebiggers@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, ardb@kernel.org, kraxel@redhat.com,
        philmd@linaro.org
Subject: Re: [PATCH qemu] x86: don't let decompressed kernel image clobber
 setup_data
Message-ID: <Y69B40T9kWfxZpmf@zn.tnic>
References: <6cab26b5-06ae-468d-ac79-ecdecb86ef07@linaro.org>
 <Y6xvJheSYC83voCZ@zx2c4.com>
 <Y6x1knb8udpSyMSp@zx2c4.com>
 <9188EEE9-2759-4389-B39E-0FEBBA3FA57D@zytor.com>
 <Y6z765zHrQ6Rl/0o@zx2c4.com>
 <AF921575-0968-434A-8B46-095B78C209C1@zytor.com>
 <Y62MdawGaasXmoVL@zn.tnic>
 <Y68Js5b0jW/2nLU4@zx2c4.com>
 <Y68Zf/MKmX3Rr18E@zn.tnic>
 <CAHmME9oPUJemVRvO3HX0q4BJGTFuzbLYANeizuRcNq2=Ykk1Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9oPUJemVRvO3HX0q4BJGTFuzbLYANeizuRcNq2=Ykk1Gg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 06:07:24PM +0100, Jason A. Donenfeld wrote:
> Look closer at the boot process. The compressed image is initially at
> 0x100000, but it gets relocated to a safer area at the end of
> startup_64:

That is the address we're executing here from, rip here looks like 0x100xxx.

> /*
>  * Copy the compressed kernel to the end of our buffer
>  * where decompression in place becomes safe.
>  */
>         pushq   %rsi
>         leaq    (_bss-8)(%rip), %rsi
>         leaq    rva(_bss-8)(%rbx), %rdi

when you get to here, it looks something like this:

        leaq    (_bss-8)(%rip), %rsi		# 0x9e7ff8
        leaq    rva(_bss-8)(%rbx), %rdi		# 0xc6eeff8

so the source address is that _bss thing and we copy...

>         movl    $(_bss - startup_32), %ecx
>         shrl    $3, %ecx
>         std

... backwards since DF=1.

Up to:

# rsi = 0xffff8
# rdi = 0xbe06ff8

Ok, so the source address is 0x100000. Good.

> HOWEVER, qemu currently appends setup_data to the end of the
> compressed kernel image,

Yeah, you mean the kernel which starts executing at 0x100000, i.e., that part
which is compressed/head_64.S and which does the above and the relocation etc.

> and this part isn't moved, and setup_data links aren't walked/relocated. So
> that means the original address remains, of 0x100000.

See above: when it starts copying the kernel image backwards to a higher
address, that last byte is at 0x9e7ff8 so I'm guessing qemu has put setup_data
*after* that address. And that doesn't get copied ofc.

So far, so good.

Now later, we extract the compressed kernel created with the mkpiggy magic:

input_data:
.incbin "arch/x86/boot/compressed/vmlinux.bin.gz"
input_data_end:

by doing

/*
 * Do the extraction, and jump to the new kernel..
 */

        pushq   %rsi                    /* Save the real mode argument */	0x13d00
        movq    %rsi, %rdi              /* real mode address */			0x13d00
        leaq    boot_heap(%rip), %rsi   /* malloc area for uncompression */	0xc6ef000
        leaq    input_data(%rip), %rdx  /* input_data */			0xbe073a8
        movl    input_len(%rip), %ecx   /* input_len */				0x8cfe13
        movq    %rbp, %r8               /* output target address */		0x1000000
        movl    output_len(%rip), %r9d  /* decompressed length, end of relocs */
        call    extract_kernel          /* returns kernel location in %rax */
        popq    %rsi

(actual addresses at the end.)

Now, when you say you triplefault somewhere in initialize_identity_maps() when
trying to access setup_data, then if you look a couple of lines before that call
we do

	call load_stage2_idt

which sets up a boottime #PF handler do_boot_page_fault() and it actually does
call kernel_add_identity_map() so *actually* it should map any unmapped
setup_data addresses.

So why doesn't it do that and why do you triplefault?

Hmmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
