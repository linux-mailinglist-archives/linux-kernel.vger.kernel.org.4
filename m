Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AC065C86D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbjACUw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbjACUwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:52:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED62912ACA
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 12:52:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 741E461517
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 20:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03E9C43392
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 20:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672779140;
        bh=xs5A+nMiaJ/Zy5xE1gzTZdyLZdx/SjaaBqXGHdvbWO4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IViIz6XhLna+IMieFjX0kFayYqlTjoK4+UskVhEDdMhHOndGCCTRyqPaAieL8owHT
         pQXfK+agxm0x3tTTeVx7yC+pwtxkji9bgIkV37m1k0+Ga6fXMCDxXcJtWbKSVOncSO
         dYo1bfTvjn6nVQAxcu5xgNJ+b/aiBEzVsrnfffA4R19DIxLqWzoAE3SuKKm2gld83q
         FqiFd9fplaWqc5DpIYzb0Y6uvms1SQ5FN9SKFpHLPdE3ZA9nNiZMXBdDGD2De9aLuu
         2JwzNU83DTalxqv9ivLGHCDGxKNWIdW7DOp/VAZvcdtZmzadzDcvm9IP/0fE1zywnC
         TkheMl1WauzXg==
Received: by mail-ej1-f52.google.com with SMTP id tz12so77114450ejc.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 12:52:20 -0800 (PST)
X-Gm-Message-State: AFqh2kqOayuIq5XdO6N2VvR4c6mAApoaty/Rh99YTkacxDkk4XI3QjcX
        P3FrCe3/F+rJTDeq4OZMbjkgolHRkVJyD84b559yjg==
X-Google-Smtp-Source: AMrXdXtJn4wvVsf0Gv6tOxeEuC/2g3dPY5tqpzGUE+LHAvoe7SJkKjKb2Tii9tUOZsU2wwA8B5p3fjKCk0JZwPbcZjk=
X-Received: by 2002:a17:906:9155:b0:81a:c468:4421 with SMTP id
 y21-20020a170906915500b0081ac4684421mr5049277ejw.149.1672779138998; Tue, 03
 Jan 2023 12:52:18 -0800 (PST)
MIME-Version: 1.0
References: <20230101162910.710293-1-Jason@zx2c4.com> <20230101162910.710293-3-Jason@zx2c4.com>
 <Y7QIg/hAIk7eZE42@gmail.com> <CALCETrWdw5kxrtr4M7AkKYDOJEE1cU1wENWgmgOxn0rEJz4y3w@mail.gmail.com>
 <Y7R8Zq6sIKAIprtr@zx2c4.com>
In-Reply-To: <Y7R8Zq6sIKAIprtr@zx2c4.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 3 Jan 2023 12:52:07 -0800
X-Gmail-Original-Message-ID: <CALCETrXaHPZMNx7g2NS9-5ShG3i74615W7gKQ2tmr4xpvgTBkA@mail.gmail.com>
Message-ID: <CALCETrXaHPZMNx7g2NS9-5ShG3i74615W7gKQ2tmr4xpvgTBkA@mail.gmail.com>
Subject: Re: [PATCH v14 2/7] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 3, 2023 at 11:06 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Andy,
>
> Thanks for your constructive suggestions.
>
> On Tue, Jan 03, 2023 at 10:36:01AM -0800, Andy Lutomirski wrote:
> > > > c) If there's not enough memory to service a page fault, it's not fatal,
> > > >    and no signal is sent. Instead, writes are simply lost.
> >
> > This just seems massively overcomplicated to me.  If there isn't
> > enough memory to fault in a page of code, we don't have some magic
> > instruction emulator in the kernel.  We either OOM or we wait for
> > memory to show up.
>
> Before addressing the other parts of your email, I thought I'd touch on
> this. Quoting from the email I just wrote Ingo:
>
> | *However* - if your big objection to this patch is that the instruction
> | skipping is problematic, we could actually punt that part. The result
> | will be that userspace just retries the memory write and the fault
> | happens again, and eventually it succeeds. From a perspective of
> | vgetrandom(), that's perhaps worse -- with this v14 patchset, it'll
> | immediately fallback to the syscall under memory pressure -- but you
> | could argue that nobody really cares about performance at that point
> | anyway, and so just retrying the fault until it succeeds is a less
> | complex behavior that would be just fine.
> |
> | Let me know if you think that'd be an acceptable compromise, and I'll
> | roll it into v15. As a preview, it pretty much amounts to dropping 3/7
> | and editing the commit message in this 2/7 patch.
>
> IOW, I think the main ideas of the patch work just fine without "point
> c" with the instruction skipping. Instead, waiting/retrying could
> potentially work. So, okay, it seems like the two of you both hate the
> instruction decoder stuff, so I'll plan on working that part in, in one
> way or another, for v15.
>
> > On Tue, Jan 3, 2023 at 2:50 AM Ingo Molnar <mingo@kernel.org> wrote:
> > > > The vDSO getrandom() implementation works with a buffer allocated with a
> > > > new system call that has certain requirements:
> > > >
> > > > - It shouldn't be written to core dumps.
> > > >   * Easy: VM_DONTDUMP.
> > > > - It should be zeroed on fork.
> > > >   * Easy: VM_WIPEONFORK.
> >
> > I have a rather different suggestion: make a special mapping.  Jason,
> > you're trying to shoehorn all kinds of bizarre behavior into the core
> > mm, and none of that seems to me to belong to the core mm.  Instead,
> > have an actual special mapping with callbacks that does the right
> > thing.  No fancy VM flags.
>
> Oooo! I like this. Avoiding adding VM_* flags would indeed be nice.
> I had seen things that I thought looked in this direction with the shmem
> API, but when I got into the details, it looked like this was meant for
> something else and couldn't address most of what I wanted here.
>
> If you say this is possible, I'll look again to see if I can figure it
> out. Though, if you have some API name at the top of your head, you
> might save me some code squinting time.

Look for _install_special_mapping().

--Andy

> > Want to mlock it?  No, don't do that -- that's absurd.  Just arrange
> > so that, if it gets evicted, it's not written out anywhere.  And when
> > it gets faulted back in it does the right thing -- see above.
>
> Presumably mlock calls are redirected to some function pointer so I can
> just return EINTR?

Or just don't worry about it.  If someone mlocks() it, that's their
problem.  The point is that no one needs to.

>
> > Zero on fork?  I'm sure that's manageable with a special mapping.  If
> > not, you can add a new vm operation or similar to make it work.  (Kind
> > of like how we extended special mappings to get mremap right a couple
> > years go.)  But maybe you don't want to *zero* it on fork and you want
> > to do something more intelligent.  Fine -- you control ->fault!
>
> Doing something more intelligent would be an interesting development, I
> guess... But, before I think about that, all mapping have flags;
> couldn't I *still* set VM_WIPEONFORK on the special mapping? Or does the
> API you have in mind not work that way? (Side note: I also want
> VM_DONTDUMP to work.)

You really want unmap (the pages, not the vma) on fork, not wipe on
fork.  It'll be VM_SHARED, and I'm not sure what VM_WIPEONFORK |
VM_SHARED does.
