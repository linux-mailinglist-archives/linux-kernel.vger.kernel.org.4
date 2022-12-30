Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DC6659C96
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 22:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbiL3V7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 16:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiL3V65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 16:58:57 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBFE1CFE8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 13:58:56 -0800 (PST)
Received: from [127.0.0.1] ([50.193.22.81])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 2BULwdhn1419253
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 30 Dec 2022 13:58:40 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 2BULwdhn1419253
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022120601; t=1672437521;
        bh=5mHwRJkoGXPFOj6AeA/b5ADGAertCv6FWoM0j9lKKqY=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=I6m/C03GS8+E25iheyQCyVkw8i6FbDwXumhf0zJmMDwhc9pfcFtFXbsclwH7xqxcy
         OV5iuevn4x9Ep/0FoiYh9pK4LRCA2I4LY/4DXqfFkFaJ+flRX9Neg8qmBgLvzjcXiQ
         VBlS22tCpkVY2/PplcRMyM9iY7K+RjFL3d26xuMShQJSfgfLa7aRV8QJC9X1l4PPK2
         yWGAXpgWNu8ZvUKhaOr4SUQFPYbRnedWD5b+ml1uC/KMMqlOqEZUt0Q9QeRTuYnvwT
         Q5GpJIXzDvBk0Zz7/a38pOS+p0fcfRv/dlUQCnH1BzISEksRyMfzi2kIahrcA/1Kt4
         nq4Jau4ML+Ecg==
Date:   Fri, 30 Dec 2022 13:58:39 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Borislav Petkov <bp@alien8.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     pbonzini@redhat.com, ebiggers@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        ardb@kernel.org, kraxel@redhat.com, philmd@linaro.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_qemu=5D_x86=3A_don=27t_let_decomp?= =?US-ASCII?Q?ressed_kernel_image_clobber_setup=5Fdata?=
User-Agent: K-9 Mail for Android
In-Reply-To: <Y69B40T9kWfxZpmf@zn.tnic>
References: <6cab26b5-06ae-468d-ac79-ecdecb86ef07@linaro.org> <Y6xvJheSYC83voCZ@zx2c4.com> <Y6x1knb8udpSyMSp@zx2c4.com> <9188EEE9-2759-4389-B39E-0FEBBA3FA57D@zytor.com> <Y6z765zHrQ6Rl/0o@zx2c4.com> <AF921575-0968-434A-8B46-095B78C209C1@zytor.com> <Y62MdawGaasXmoVL@zn.tnic> <Y68Js5b0jW/2nLU4@zx2c4.com> <Y68Zf/MKmX3Rr18E@zn.tnic> <CAHmME9oPUJemVRvO3HX0q4BJGTFuzbLYANeizuRcNq2=Ykk1Gg@mail.gmail.com> <Y69B40T9kWfxZpmf@zn.tnic>
Message-ID: <E5D0A77E-5ABC-4978-9A66-37B60DA43869@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On December 30, 2022 11:54:11 AM PST, Borislav Petkov <bp@alien8=2Ede> wrot=
e:
>On Fri, Dec 30, 2022 at 06:07:24PM +0100, Jason A=2E Donenfeld wrote:
>> Look closer at the boot process=2E The compressed image is initially at
>> 0x100000, but it gets relocated to a safer area at the end of
>> startup_64:
>
>That is the address we're executing here from, rip here looks like 0x100x=
xx=2E
>
>> /*
>>  * Copy the compressed kernel to the end of our buffer
>>  * where decompression in place becomes safe=2E
>>  */
>>         pushq   %rsi
>>         leaq    (_bss-8)(%rip), %rsi
>>         leaq    rva(_bss-8)(%rbx), %rdi
>
>when you get to here, it looks something like this:
>
>        leaq    (_bss-8)(%rip), %rsi		# 0x9e7ff8
>        leaq    rva(_bss-8)(%rbx), %rdi		# 0xc6eeff8
>
>so the source address is that _bss thing and we copy=2E=2E=2E
>
>>         movl    $(_bss - startup_32), %ecx
>>         shrl    $3, %ecx
>>         std
>
>=2E=2E=2E backwards since DF=3D1=2E
>
>Up to:
>
># rsi =3D 0xffff8
># rdi =3D 0xbe06ff8
>
>Ok, so the source address is 0x100000=2E Good=2E
>
>> HOWEVER, qemu currently appends setup_data to the end of the
>> compressed kernel image,
>
>Yeah, you mean the kernel which starts executing at 0x100000, i=2Ee=2E, t=
hat part
>which is compressed/head_64=2ES and which does the above and the relocati=
on etc=2E
>
>> and this part isn't moved, and setup_data links aren't walked/relocated=
=2E So
>> that means the original address remains, of 0x100000=2E
>
>See above: when it starts copying the kernel image backwards to a higher
>address, that last byte is at 0x9e7ff8 so I'm guessing qemu has put setup=
_data
>*after* that address=2E And that doesn't get copied ofc=2E
>
>So far, so good=2E
>
>Now later, we extract the compressed kernel created with the mkpiggy magi=
c:
>
>input_data:
>=2Eincbin "arch/x86/boot/compressed/vmlinux=2Ebin=2Egz"
>input_data_end:
>
>by doing
>
>/*
> * Do the extraction, and jump to the new kernel=2E=2E
> */
>
>        pushq   %rsi                    /* Save the real mode argument */=
	0x13d00
>        movq    %rsi, %rdi              /* real mode address */			0x13d00
>        leaq    boot_heap(%rip), %rsi   /* malloc area for uncompression =
*/	0xc6ef000
>        leaq    input_data(%rip), %rdx  /* input_data */			0xbe073a8
>        movl    input_len(%rip), %ecx   /* input_len */				0x8cfe13
>        movq    %rbp, %r8               /* output target address */		0x10=
00000
>        movl    output_len(%rip), %r9d  /* decompressed length, end of re=
locs */
>        call    extract_kernel          /* returns kernel location in %ra=
x */
>        popq    %rsi
>
>(actual addresses at the end=2E)
>
>Now, when you say you triplefault somewhere in initialize_identity_maps()=
 when
>trying to access setup_data, then if you look a couple of lines before th=
at call
>we do
>
>	call load_stage2_idt
>
>which sets up a boottime #PF handler do_boot_page_fault() and it actually=
 does
>call kernel_add_identity_map() so *actually* it should map any unmapped
>setup_data addresses=2E
>
>So why doesn't it do that and why do you triplefault?
>
>Hmmm=2E
>

See the other thread fork=2E They have identified the problem already=2E
