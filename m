Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AD865B9E5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 04:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjACD5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 22:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236687AbjACD5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 22:57:09 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07FAF28
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 19:57:06 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-14fb3809eaeso29620413fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 19:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bWVeQQpdd/jLPKPydMjlUMpExApWVFcNiP/MSHvrGpg=;
        b=BaCgF7PC9rILICMUIct+fv8mdyG/o76D6FnY05KGtn8aV9H9avuC2xyBgPv+h55dfz
         hUSbbGhuzPJTX51C0M/srLlm5P44nbXFIVLctYm0AK76kqq1S9bHAnrYOkpHov+wUyN3
         +0Rk5+Sb2EcMfYMjpUO2Dj+50snq0VG50r8JjR3jkJQie22g5s8L6vzcVfbT5kktFZQ8
         UtlwHAV9hwBrN1un/6HssmeLceA23e6UnxqR4awR/SGyAY9sg5CELREHeQDcx2lOYrmN
         LC6mTeOF5lXbAH4qm7QzPCipBt/AZfYaT4xP0SRI883IP8rZR4pfLUNAUYDa/pHeE9e8
         TjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWVeQQpdd/jLPKPydMjlUMpExApWVFcNiP/MSHvrGpg=;
        b=Yp0kqi/fp8hTrFH1GZ9hMvYDf+MYFg/IIffsbVcbuKiTs5mxG4cnW3+iL0OJL5yYV3
         yTrFpyZk6Ig3hgEV72KRxnc85dlcTWcdZ0kmwkg4qshLGSoDQJHRn/a73bQw9y0/YBxk
         Es1Gv1EHv1TmIcVB1MRzmypOGgrU78jvQJB+srn/dmgjTzOxE0R3f8kCsoV51D9JJrZo
         ih1eYqPRrc8LtPc+fxhXRznA8yQO4IyU525mFYMI2+t/+gJgVpNfFs2wubhLEKA9hogC
         NjqEpG+TO7aW7g37eDq9JXXjD7Pmfs/6XdYQi2z2+ZlupBwesKfDgCxsd/OWKQV+H3/O
         ZRTA==
X-Gm-Message-State: AFqh2krUoTkQGk1LZaG0XMw3LTf9MsVLfaUA/hIYKbM0EcguPRMyC40r
        IbkNrK5EPefNnQbKSWa4FdJiQiQQfw4=
X-Google-Smtp-Source: AMrXdXvHZbBKlts29WlnYcd2ogt4i6LCsjDZzB4C105wWcUln7Ut5YV44aPQtggHlCfclXuFDjs4Lg==
X-Received: by 2002:a05:6870:d0c7:b0:150:9356:1d12 with SMTP id k7-20020a056870d0c700b0015093561d12mr5336085oaa.1.1672718226208;
        Mon, 02 Jan 2023 19:57:06 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t8-20020a4aadc8000000b004d7363cdddfsm8012771oon.19.2023.01.02.19.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 19:57:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 2 Jan 2023 19:57:04 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: Linux 6.2-rc2
Message-ID: <20230103035704.GA1207672@roeck-us.net>
References: <CAHk-=wim8DMRzjyYTJ3UbdqZ26keQyZSU02NZb-JY1=9OpcO1w@mail.gmail.com>
 <20230102225656.GA3532398@roeck-us.net>
 <CAHk-=wjZPPscjDhsHQw_ttHOaQS69rADLm0KuRhbNavBiO62OQ@mail.gmail.com>
 <20230103014535.GA313835@roeck-us.net>
 <CAHk-=whmeBkyu3iS_s-yk0=t3GEoW3sQb-wJFHKykOjG=iQVFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whmeBkyu3iS_s-yk0=t3GEoW3sQb-wJFHKykOjG=iQVFw@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 06:13:09PM -0800, Linus Torvalds wrote:
> On Mon, Jan 2, 2023 at 5:45 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > ... and reverting commit 99cb0d917ff indeed fixes the problem.
> 
> Hmm. My gut feel is that this just exposes some bug in binutils.
> 
May well be, but it would be an architecture specific bug. The problem
is not seen when building an x86 image with binutils 2.32. Of course it
might affect other architectures.

> That said, maybe that commit should not have added its own /DISCARDS/
> thing, and instead just added that "*(.note.GNU-stack)" to the general
> /DISCARDS/ thing that is defined by the
> 
>   #define DISCARDS  ..
> 
> a little bit later, so that we only end up with one single DISCARD
> list. Something like this (broken patch on purpose):
> 
>   --- a/include/asm-generic/vmlinux.lds.h
>   +++ b/include/asm-generic/vmlinux.lds.h
>   @@ -897,5 +897,4 @@
>     */
>    #define NOTES                                        \
>   -     /DISCARD/ : { *(.note.GNU-stack) }              \
>         .notes : AT(ADDR(.notes) - LOAD_OFFSET) {       \
>                 BOUNDED_SECTION_BY(.note.*, _notes)     \
>   @@ -1016,4 +1015,5 @@
>    #define DISCARDS                                     \
>         /DISCARD/ : {                                   \
>   +     *(.note.GNU-stack)                              \
>         EXIT_DISCARDS                                   \
>         EXIT_CALL                                       \
> 

I don't know if and how it affects arm64 and riscv, but the above fixes
the problem for sh.

> But maybe that DISCARDS macrop ends up being used too late?
> 

DISCARDS is the very first entry in SECTIONS. NOTES is part of RO_DATA
and comes much later.

> It really shouldn't matter, but here we are, with a build problem with
> some random old binutils on an odd platform..

The one we know of. I could try to compile all architectures with
binutils 2.32, but I don't really want to do that if I can avoid it.

Guenter
