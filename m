Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0229E65C65A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238190AbjACSgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238308AbjACSgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:36:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC859EE02
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:36:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 136B6B80FEE
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 18:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5617C433F2
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 18:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672770975;
        bh=qmyYVNpngCof8L0z9bRxBJGgthB1paphMx+6zOsfGUY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZceGyxLulP1Ffg0N9eFZITlz0PbWaHWU9wdl8KnetIpDUFk+9vwdsfYzkZv1CmqZ6
         6vlFXiUdzOgnjfo3fjTSRVMlI+0Jezi5r+MFGk2lROx5qsmf6zrd9t2ghGIfG69oyS
         PTGZ+8DSFyDtLaNWMWbPR9t+qsk6OXEw1871o+2ZwsXo9QH/7XzVggCFWfA0lguW7O
         9pjlXnWGMCrkd+v50ka/cVfQ6jk4kA1NuyviIsGIkD0s3RCh5pAcm2SnEDrakU1Pto
         BiOWIL23tPgixi669Buux3TBPy3+U8zY4TEac6GVi6d6pIGsBTe6Bn1UVLdPFuiKdW
         t0zcQqdO9FwwA==
Received: by mail-ed1-f51.google.com with SMTP id c34so38537200edf.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 10:36:15 -0800 (PST)
X-Gm-Message-State: AFqh2kpT+/qpMLQxQ2OhwVwSKnlmSoM3dcr2YDAtbtyH2ic4nowxxTu6
        YkoaHmImCT5v92aYxhDRo6HaEOi/ef4ejYyve+NtIw==
X-Google-Smtp-Source: AMrXdXvSiNT+YujtDx1T+6ZLaxF3U2v/w4nEOY3CSip0uqIHfbU5yuT8L8QlBy/NoU6MZIaK9pJyN5cu3smxVpElQ/s=
X-Received: by 2002:aa7:cb4f:0:b0:486:1c44:a6fa with SMTP id
 w15-20020aa7cb4f000000b004861c44a6famr3256292edt.372.1672770974013; Tue, 03
 Jan 2023 10:36:14 -0800 (PST)
MIME-Version: 1.0
References: <20230101162910.710293-1-Jason@zx2c4.com> <20230101162910.710293-3-Jason@zx2c4.com>
 <Y7QIg/hAIk7eZE42@gmail.com>
In-Reply-To: <Y7QIg/hAIk7eZE42@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 3 Jan 2023 10:36:01 -0800
X-Gmail-Original-Message-ID: <CALCETrWdw5kxrtr4M7AkKYDOJEE1cU1wENWgmgOxn0rEJz4y3w@mail.gmail.com>
Message-ID: <CALCETrWdw5kxrtr4M7AkKYDOJEE1cU1wENWgmgOxn0rEJz4y3w@mail.gmail.com>
Subject: Re: [PATCH v14 2/7] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
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

On Tue, Jan 3, 2023 at 2:50 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> > The vDSO getrandom() implementation works with a buffer allocated with a
> > new system call that has certain requirements:
> >
> > - It shouldn't be written to core dumps.
> >   * Easy: VM_DONTDUMP.
> > - It should be zeroed on fork.
> >   * Easy: VM_WIPEONFORK.

I have a rather different suggestion: make a special mapping.  Jason,
you're trying to shoehorn all kinds of bizarre behavior into the core
mm, and none of that seems to me to belong to the core mm.  Instead,
have an actual special mapping with callbacks that does the right
thing.  No fancy VM flags.

Memory pressure: have it free and unmap it self.  Gets accessed again?
 ->fault can handle it.

Want to mlock it?  No, don't do that -- that's absurd.  Just arrange
so that, if it gets evicted, it's not written out anywhere.  And when
it gets faulted back in it does the right thing -- see above.

Zero on fork?  I'm sure that's manageable with a special mapping.  If
not, you can add a new vm operation or similar to make it work.  (Kind
of like how we extended special mappings to get mremap right a couple
years go.)  But maybe you don't want to *zero* it on fork and you want
to do something more intelligent.  Fine -- you control ->fault!

> >
> > - It shouldn't be written to swap.
> >   * Uh-oh: mlock is rlimited.
> >   * Uh-oh: mlock isn't inherited by forks.

No mlock, no problems.

> >
> > - It shouldn't reserve actual memory, but it also shouldn't crash when
> >   page faulting in memory if none is available
> >   * Uh-oh: MAP_NORESERVE respects vm.overcommit_memory=2.
> >   * Uh-oh: VM_NORESERVE means segfaults.

->fault can do whatever you want.

And there is no shortage of user memory that *must* be made available
on fault in order to resume the faulting process.  ->fault can handle
this.

> >
> > It turns out that the vDSO getrandom() function has three really nice
> > characteristics that we can exploit to solve this problem:
> >
> > 1) Due to being wiped during fork(), the vDSO code is already robust to
> >    having the contents of the pages it reads zeroed out midway through
> >    the function's execution.
> >
> > 2) In the absolute worst case of whatever contingency we're coding for,
> >    we have the option to fallback to the getrandom() syscall, and
> >    everything is fine.
> >
> > 3) The buffers the function uses are only ever useful for a maximum of
> >    60 seconds -- a sort of cache, rather than a long term allocation.
> >
> > These characteristics mean that we can introduce VM_DROPPABLE, which
> > has the following semantics:

No need for another vm flag.

> >
> > a) It never is written out to swap.

No need to complicate the swap logic for this.

> > b) Under memory pressure, mm can just drop the pages (so that they're
> >    zero when read back again).

Or ->fault could even repopulate it without needing to ever read zeros.

> > c) If there's not enough memory to service a page fault, it's not fatal,
> >    and no signal is sent. Instead, writes are simply lost.

This just seems massively overcomplicated to me.  If there isn't
enough memory to fault in a page of code, we don't have some magic
instruction emulator in the kernel.  We either OOM or we wait for
memory to show up.

> > d) It is inherited by fork.

If you have a special mapping and you fork, it doesn't magically turn
into normal memory.

> > e) It doesn't count against the mlock budget, since nothing is locked.

Special mapping -> no mlock.

> >
> > This is fairly simple to implement, with the one snag that we have to
> > use 64-bit VM_* flags, but this shouldn't be a problem, since the only
> > consumers will probably be 64-bit anyway.
> >
> > This way, allocations used by vDSO getrandom() can use:
> >
> >     VM_DROPPABLE | VM_DONTDUMP | VM_WIPEONFORK | VM_NORESERVE
> >
> > And there will be no problem with OOMing, crashing on overcommitment,
> > using memory when not in use, not wiping on fork(), coredumps, or
> > writing out to swap.
> >
> > At the moment, rather than skipping writes on OOM, the fault handler
> > just returns to userspace, and the instruction is retried. This isn't
> > terrible, but it's not quite what is intended. The actual instruction
> > skipping has to be implemented arch-by-arch, but so does this whole
> > vDSO series, so that's fine. The following commit addresses it for x86.

I really dislike this.  I'm with Ingo.
