Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E53565BE82
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237367AbjACK7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237151AbjACK7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:59:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E06287
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 02:59:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D349B80E95
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:59:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFEDC43398
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672743541;
        bh=CXbMsJ8amTRDKFFvM6G54IqkXE31MPgUrU/r8iQhkdI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lqUx2YMh1XCUkQFXRJ1CW82dcrzC4UQyFRw0dDceRqP2ZO0naI4GfcmhofQngSEuJ
         8RYfsVQr6L9r7U/AKlQChOac3aZqOT1oEAPXR3cu9bfff8zNwL2amiw6Zq0qNhdnik
         VtkZCmaOiWHH7/GUqNu2vGAExdsLMY7oCIGDqUqCPYzE+v69xlb0Gg4lklT/glC9mP
         wN5mNLlZdQ8Ie56NNbtCnwQFichqn8KZI3fKMJOopTp3CP7WCLpcbzG7EEhbSb+vaI
         hm4K/VJpP/LioUTjgKCu627Dsi1UHbF8K1ij4qy5Tb5A9fpTB14coKgIbH1/jXksFz
         2dhqOOQbWA44A==
Received: by mail-lf1-f43.google.com with SMTP id m6so34771829lfj.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 02:59:01 -0800 (PST)
X-Gm-Message-State: AFqh2krTTUnTQdqLjXuu+0KZyTTdBVC0gdnu6uB0oiwC9FMC6tYNfyIO
        dFLwrMQwMQdYaQE8vCGtEkzgo9ZQ3RP1dNCOvVU=
X-Google-Smtp-Source: AMrXdXtFkl7JbY7HdH9+sfbb0HkJS5ihKYaaliEp58Pa6YLG7djJRwmRoQ7h+smOWbU2iRvoVVzBQmwtE+KheFJBOzY=
X-Received: by 2002:a19:ad4b:0:b0:4cb:315d:e9b8 with SMTP id
 s11-20020a19ad4b000000b004cb315de9b8mr950189lfd.110.1672743539856; Tue, 03
 Jan 2023 02:58:59 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wim8DMRzjyYTJ3UbdqZ26keQyZSU02NZb-JY1=9OpcO1w@mail.gmail.com>
 <20230102225656.GA3532398@roeck-us.net> <CAHk-=wjZPPscjDhsHQw_ttHOaQS69rADLm0KuRhbNavBiO62OQ@mail.gmail.com>
 <20230103014535.GA313835@roeck-us.net> <CAHk-=whmeBkyu3iS_s-yk0=t3GEoW3sQb-wJFHKykOjG=iQVFw@mail.gmail.com>
In-Reply-To: <CAHk-=whmeBkyu3iS_s-yk0=t3GEoW3sQb-wJFHKykOjG=iQVFw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 3 Jan 2023 11:58:48 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHqQoqoys83nEp=Q6oT68+-GpCuMjfnYK9pMy-X_+jjKw@mail.gmail.com>
Message-ID: <CAMj1kXHqQoqoys83nEp=Q6oT68+-GpCuMjfnYK9pMy-X_+jjKw@mail.gmail.com>
Subject: Re: Linux 6.2-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jan 2023 at 03:13, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Jan 2, 2023 at 5:45 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > ... and reverting commit 99cb0d917ff indeed fixes the problem.
>
> Hmm. My gut feel is that this just exposes some bug in binutils.
>
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
> But maybe that DISCARDS macrop ends up being used too late?
>

Masahiro's v1 did something like this, and it caused an issue on
RISC-V, which is why we ended up with this approach instead.

> It really shouldn't matter, but here we are, with a build problem with
> some random old binutils on an odd platform..
>

AIUI, the way ld.bfd used to combine output sections may also affect
the /DISCARD/ pseudo-section, and so introducing it much earlier
results in these discards to be interpreted in a different order.

The purpose of this change is to prevent .note.GNU-stack from deciding
the section type of the .notes output section, and so keeping it in
its own section should be sufficient. E.g.,

--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -896,7 +896,7 @@
  * Otherwise, the type of .notes section would become PROGBITS
instead of NOTES.
  */
 #define NOTES                                                          \
-       /DISCARD/ : { *(.note.GNU-stack) }                              \
+       .note.GNU-stack : { *(.note.GNU-stack) }                        \
        .notes : AT(ADDR(.notes) - LOAD_OFFSET) {                       \
                BOUNDED_SECTION_BY(.note.*, _notes)                     \
        } NOTES_HEADERS                                                 \

The .note.GNU-stack has zero size, so the result should be the same.
