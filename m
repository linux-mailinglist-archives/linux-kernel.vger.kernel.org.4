Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5554A65C6E8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238692AbjACTFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238727AbjACTFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:05:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9252313CF1;
        Tue,  3 Jan 2023 11:05:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39F85B80EC2;
        Tue,  3 Jan 2023 19:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E56C433D2;
        Tue,  3 Jan 2023 19:05:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="UdnPlTE1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1672772714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5NpNAATWWkRP+91skuEFC6IGLeSW0ntw/LmFnvD5DJo=;
        b=UdnPlTE1GPtqZiqmhGqOPzd6vGqyg6RTb0tEiIQb3JQvC+0sAK7ZpyfNLtyLmIrUtUf9K6
        w7Kfep3+so7dS+IlkrWLwGAzluYN53gA4o+QhAuIxj4VDfXQ7+yIY1g4OGUVazEqAj/nV8
        46Fjym8BynZrySEy5c5LuroAzBOGafw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cfe7dd4e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 3 Jan 2023 19:05:14 +0000 (UTC)
Date:   Tue, 3 Jan 2023 20:05:10 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, tglx@linutronix.de,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v14 2/7] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
Message-ID: <Y7R8Zq6sIKAIprtr@zx2c4.com>
References: <20230101162910.710293-1-Jason@zx2c4.com>
 <20230101162910.710293-3-Jason@zx2c4.com>
 <Y7QIg/hAIk7eZE42@gmail.com>
 <CALCETrWdw5kxrtr4M7AkKYDOJEE1cU1wENWgmgOxn0rEJz4y3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrWdw5kxrtr4M7AkKYDOJEE1cU1wENWgmgOxn0rEJz4y3w@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thanks for your constructive suggestions.

On Tue, Jan 03, 2023 at 10:36:01AM -0800, Andy Lutomirski wrote:
> > > c) If there's not enough memory to service a page fault, it's not fatal,
> > >    and no signal is sent. Instead, writes are simply lost.
> 
> This just seems massively overcomplicated to me.  If there isn't
> enough memory to fault in a page of code, we don't have some magic
> instruction emulator in the kernel.  We either OOM or we wait for
> memory to show up.

Before addressing the other parts of your email, I thought I'd touch on
this. Quoting from the email I just wrote Ingo:

| *However* - if your big objection to this patch is that the instruction
| skipping is problematic, we could actually punt that part. The result
| will be that userspace just retries the memory write and the fault
| happens again, and eventually it succeeds. From a perspective of
| vgetrandom(), that's perhaps worse -- with this v14 patchset, it'll
| immediately fallback to the syscall under memory pressure -- but you
| could argue that nobody really cares about performance at that point
| anyway, and so just retrying the fault until it succeeds is a less
| complex behavior that would be just fine.
| 
| Let me know if you think that'd be an acceptable compromise, and I'll
| roll it into v15. As a preview, it pretty much amounts to dropping 3/7
| and editing the commit message in this 2/7 patch.

IOW, I think the main ideas of the patch work just fine without "point
c" with the instruction skipping. Instead, waiting/retrying could
potentially work. So, okay, it seems like the two of you both hate the
instruction decoder stuff, so I'll plan on working that part in, in one
way or another, for v15.

> On Tue, Jan 3, 2023 at 2:50 AM Ingo Molnar <mingo@kernel.org> wrote:
> > > The vDSO getrandom() implementation works with a buffer allocated with a
> > > new system call that has certain requirements:
> > >
> > > - It shouldn't be written to core dumps.
> > >   * Easy: VM_DONTDUMP.
> > > - It should be zeroed on fork.
> > >   * Easy: VM_WIPEONFORK.
> 
> I have a rather different suggestion: make a special mapping.  Jason,
> you're trying to shoehorn all kinds of bizarre behavior into the core
> mm, and none of that seems to me to belong to the core mm.  Instead,
> have an actual special mapping with callbacks that does the right
> thing.  No fancy VM flags.

Oooo! I like this. Avoiding adding VM_* flags would indeed be nice.
I had seen things that I thought looked in this direction with the shmem
API, but when I got into the details, it looked like this was meant for
something else and couldn't address most of what I wanted here.

If you say this is possible, I'll look again to see if I can figure it
out. Though, if you have some API name at the top of your head, you
might save me some code squinting time.

> Memory pressure: have it free and unmap it self.  Gets accessed again?
>  ->fault can handle it.

Right.

> Want to mlock it?  No, don't do that -- that's absurd.  Just arrange
> so that, if it gets evicted, it's not written out anywhere.  And when
> it gets faulted back in it does the right thing -- see above.

Presumably mlock calls are redirected to some function pointer so I can
just return EINTR?

> Zero on fork?  I'm sure that's manageable with a special mapping.  If
> not, you can add a new vm operation or similar to make it work.  (Kind
> of like how we extended special mappings to get mremap right a couple
> years go.)  But maybe you don't want to *zero* it on fork and you want
> to do something more intelligent.  Fine -- you control ->fault!

Doing something more intelligent would be an interesting development, I
guess... But, before I think about that, all mapping have flags;
couldn't I *still* set VM_WIPEONFORK on the special mapping? Or does the
API you have in mind not work that way? (Side note: I also want
VM_DONTDUMP to work.)

> > > - It shouldn't reserve actual memory, but it also shouldn't crash when
> > >   page faulting in memory if none is available
> > >   * Uh-oh: MAP_NORESERVE respects vm.overcommit_memory=2.
> > >   * Uh-oh: VM_NORESERVE means segfaults.
> 
> ->fault can do whatever you want.
> 
> And there is no shortage of user memory that *must* be made available
> on fault in order to resume the faulting process.  ->fault can handle
> this.

I'll look to see how other things handle this...

Anyway, thanks for the suggestion. That seems like a good future
direction for this.

Jason
