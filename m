Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3082965D0B6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 11:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbjADKeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 05:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbjADKeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:34:18 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D572295BE
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 02:34:15 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Nn5Yr2J42z4xwl;
        Wed,  4 Jan 2023 21:34:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1672828450;
        bh=5gtoEfhVejTP2PSgVm0jnlqHjpeRUn34WQgEHxOBFKo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ZgQc1aUhkiFUlsN1j3jU9HhNE9Mc/f5fex+rJfbq/ViJ/I45I7m1Nawieeq0kUPuy
         OjSsaoBVGoAxMd+6G6OvQiTizzajnZ77O8cWzKrOkwI3VOy10QtrnSWF9UwqNutxnB
         mFY+2SYBZVMLvDSw9cUnEP1yVBVEVxpZP0/A2VR5knYFZde6FYruZHJb4N7UqYhGM1
         vioLbAL/Zxo8qgC0GL0iQUcy0rPPul6NBBtUQoIPDohhIRMzAquHn/9TOvQ9bRmWaC
         eAEbZL+nB/MY9veAzSVOI+uppvtT1pJsa2jp3V2S1Q2iBMiTMj4Z6om5vLO9SxRhdg
         ZI6UueG8lj68w==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: Linux 6.2-rc2
In-Reply-To: <CAMj1kXHqQoqoys83nEp=Q6oT68+-GpCuMjfnYK9pMy-X_+jjKw@mail.gmail.com>
References: <CAHk-=wim8DMRzjyYTJ3UbdqZ26keQyZSU02NZb-JY1=9OpcO1w@mail.gmail.com>
 <20230102225656.GA3532398@roeck-us.net>
 <CAHk-=wjZPPscjDhsHQw_ttHOaQS69rADLm0KuRhbNavBiO62OQ@mail.gmail.com>
 <20230103014535.GA313835@roeck-us.net>
 <CAHk-=whmeBkyu3iS_s-yk0=t3GEoW3sQb-wJFHKykOjG=iQVFw@mail.gmail.com>
 <CAMj1kXHqQoqoys83nEp=Q6oT68+-GpCuMjfnYK9pMy-X_+jjKw@mail.gmail.com>
Date:   Wed, 04 Jan 2023 21:34:07 +1100
Message-ID: <874jt64mhs.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ard Biesheuvel <ardb@kernel.org> writes:
> On Tue, 3 Jan 2023 at 03:13, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> On Mon, Jan 2, 2023 at 5:45 PM Guenter Roeck <linux@roeck-us.net> wrote:
>> >
>> > ... and reverting commit 99cb0d917ff indeed fixes the problem.
>>
>> Hmm. My gut feel is that this just exposes some bug in binutils.
...
>> It really shouldn't matter, but here we are, with a build problem with
>> some random old binutils on an odd platform..
>>
>
> AIUI, the way ld.bfd used to combine output sections may also affect
> the /DISCARD/ pseudo-section, and so introducing it much earlier
> results in these discards to be interpreted in a different order.
>
> The purpose of this change is to prevent .note.GNU-stack from deciding
> the section type of the .notes output section, and so keeping it in
> its own section should be sufficient. E.g.,
>
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -896,7 +896,7 @@
>   * Otherwise, the type of .notes section would become PROGBITS
> instead of NOTES.
>   */
>  #define NOTES                                                          \
> -       /DISCARD/ : { *(.note.GNU-stack) }                              \
> +       .note.GNU-stack : { *(.note.GNU-stack) }                        \
>         .notes : AT(ADDR(.notes) - LOAD_OFFSET) {                       \
>                 BOUNDED_SECTION_BY(.note.*, _notes)                     \
>         } NOTES_HEADERS                                                 \

This also fixes errors seen in the powerpc build with binutils <= 2.35.

Tested-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
