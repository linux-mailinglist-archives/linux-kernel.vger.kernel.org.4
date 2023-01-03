Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B5D65BA05
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 05:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjACE0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 23:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjACE0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 23:26:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DCCE5C
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 20:26:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 681AAB80E44
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 04:26:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF11C433EF;
        Tue,  3 Jan 2023 04:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672719965;
        bh=EKrLIhyucnOE01psCGtVPdULGM4gVEWd2qaTTQhWm6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tIKaVROCEsAgKF3VG38LD4C8ApxJqV054duwiK04s5Yw1DG5QyYICXIoWAbVkau4y
         bzcc+YPPbuISbKrGDLhP3dDtJfhDVwfm2w9q6A2wgkRC6sg2707xb/Rpg1jn8I7Vkx
         resWcx3yP5KzXm7f5S4w30iCQ6Qy58Zxoi8j77XJqBszrLZSh6IL9RhR0UHicxKLM6
         5yjM27Vd7VXkNsLiLENBUonr4nzk2aKOBYukOj8mYiZz4ZdhUAXHB/+Qo6FJ5tG8x4
         zWdrN2ws2wDhbXKcRbsA6SH6T4dXNcrB4/pO0Ssw7+kiKUCFyHB26RJIwNG144kSj2
         bXL+dg83Oaasg==
Date:   Mon, 2 Jan 2023 21:26:02 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: Linux 6.2-rc2
Message-ID: <Y7OuWjxR4M9cdtlR@dev-arch.thelio-3990X>
References: <CAHk-=wim8DMRzjyYTJ3UbdqZ26keQyZSU02NZb-JY1=9OpcO1w@mail.gmail.com>
 <20230102225656.GA3532398@roeck-us.net>
 <CAHk-=wjZPPscjDhsHQw_ttHOaQS69rADLm0KuRhbNavBiO62OQ@mail.gmail.com>
 <20230103014535.GA313835@roeck-us.net>
 <CAHk-=whmeBkyu3iS_s-yk0=t3GEoW3sQb-wJFHKykOjG=iQVFw@mail.gmail.com>
 <20230103035704.GA1207672@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103035704.GA1207672@roeck-us.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 07:57:04PM -0800, Guenter Roeck wrote:
> On Mon, Jan 02, 2023 at 06:13:09PM -0800, Linus Torvalds wrote:
> > On Mon, Jan 2, 2023 at 5:45 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > ... and reverting commit 99cb0d917ff indeed fixes the problem.
> > 
> > Hmm. My gut feel is that this just exposes some bug in binutils.
> > 
> May well be, but it would be an architecture specific bug. The problem
> is not seen when building an x86 image with binutils 2.32. Of course it
> might affect other architectures.

It is likely a generic binutils bug, as I have seen it with PowerPC and
s390. I assume it comes down to how architectures have written their
linker scripts. I did some initial investigation yesterday and reported
my findings on Masahiro's patch thread:

https://lore.kernel.org/Y7Jal56f6UBh1abE@dev-arch.thelio-3990X/

I have seen at least three separate threads now with this issue, perhaps
it is just worth reverting the patch now and submitting a fixed version?
2.35.2 is Debian stable's binutils version so this will likely impact a
lot of CIs.

Cheers,
Nathan

> > That said, maybe that commit should not have added its own /DISCARDS/
> > thing, and instead just added that "*(.note.GNU-stack)" to the general
> > /DISCARDS/ thing that is defined by the
> > 
> >   #define DISCARDS  ..
> > 
> > a little bit later, so that we only end up with one single DISCARD
> > list. Something like this (broken patch on purpose):
> > 
> >   --- a/include/asm-generic/vmlinux.lds.h
> >   +++ b/include/asm-generic/vmlinux.lds.h
> >   @@ -897,5 +897,4 @@
> >     */
> >    #define NOTES                                        \
> >   -     /DISCARD/ : { *(.note.GNU-stack) }              \
> >         .notes : AT(ADDR(.notes) - LOAD_OFFSET) {       \
> >                 BOUNDED_SECTION_BY(.note.*, _notes)     \
> >   @@ -1016,4 +1015,5 @@
> >    #define DISCARDS                                     \
> >         /DISCARD/ : {                                   \
> >   +     *(.note.GNU-stack)                              \
> >         EXIT_DISCARDS                                   \
> >         EXIT_CALL                                       \
> > 
> 
> I don't know if and how it affects arm64 and riscv, but the above fixes
> the problem for sh.
> 
> > But maybe that DISCARDS macrop ends up being used too late?
> > 
> 
> DISCARDS is the very first entry in SECTIONS. NOTES is part of RO_DATA
> and comes much later.
> 
> > It really shouldn't matter, but here we are, with a build problem with
> > some random old binutils on an odd platform..
> 
> The one we know of. I could try to compile all architectures with
> binutils 2.32, but I don't really want to do that if I can avoid it.
> 
> Guenter
