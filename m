Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4E565C6C6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbjACSwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238705AbjACSvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:51:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E5512AB4;
        Tue,  3 Jan 2023 10:51:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 441BF614D8;
        Tue,  3 Jan 2023 18:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E000DC433EF;
        Tue,  3 Jan 2023 18:51:45 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bHHodc0f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1672771903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yIp6kO5eIHdv4v3c2ecLfUgKivnf2+mEm8o0l2hkbzo=;
        b=bHHodc0fH+H7OOTTkxPAWw94TxrIyjgw8ZAmtm3SM0EYAXHTAqUINBwNVpDp+Ep30VQN7N
        ngeXJ0no/zVq7bgjckhK5fPEXBM3HxDC/3PeTN5YrBYhgdotA9NzKVzvi5PfzmDmYoEQJd
        Ss6rEgGplCLChsIP0gx+7BeqKr6GAKg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ea8cdcd1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 3 Jan 2023 18:51:42 +0000 (UTC)
Date:   Tue, 3 Jan 2023 19:51:38 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v14 2/7] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
Message-ID: <Y7R5OokY7P+H2vuD@zx2c4.com>
References: <20230101162910.710293-1-Jason@zx2c4.com>
 <20230101162910.710293-3-Jason@zx2c4.com>
 <Y7QIg/hAIk7eZE42@gmail.com>
 <Y7RDQLEvlLM0o4cp@zx2c4.com>
 <Y7Rw1plb/pqPiWgg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y7Rw1plb/pqPiWgg@gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 07:15:50PM +0100, Ingo Molnar wrote:
> Frankly, I don't appreciate your condescending discussion style that 
> borders on the toxic, and to save time I'm nacking this technical approach 
> until both the patch-set and your reaction to constructive review feedback 
> improves:
> 
>     NAcked-by: Ingo Molnar <mingo@kernel.org>

Your initial email to me did not strike me as constructive at all. All I
gotta say is that you really seem to live up to your reputation here...

But trying to steer things back to the technical realm:

> For a single architecture: x86.
> 
> And it's only 19 lines because x86 already happens to have a bunch of 
> complexity implemented, such as a safe instruction decoder that allows the 
> skipping of an instruction - which relies on thousands of lines of 
> complexity.
> 
> On an architecture where this isn't present, it would have to be 
> implemented to support the instruction-skipping aspect of VM_DROPPABLE.

My assumption is actually the opposite: that x86 (CISC) is basically the
most complex, and that the RISC architectures will all be a good deal
more trivial -- e.g. just adding 4 to IP on some. It looks like some
architectures also already have mature decoders where required.

> Even on x86, it's not common today for the software-decoder to be used in 
> unprivileged code - primary use was debugging & instrumentation code. So 
> your patches bring this piece of complexity to a much larger scope of 
> untrusted user-space functionality.

As far as I can tell, this decoder *is* used with userspace already.
It's used by SEV and by UMIP, in a totally userspace accessible way. Am
I misunderstanding its use there? It looks to me like that operates on
untrusted code.

*However* - if your big objection to this patch is that the instruction
skipping is problematic, we could actually punt that part. The result
will be that userspace just retries the memory write and the fault
happens again, and eventually it succeeds. From a perspective of
vgetrandom(), that's perhaps worse -- with this v14 patchset, it'll
immediately fallback to the syscall under memory pressure -- but you
could argue that nobody really cares about performance at that point
anyway, and so just retrying the fault until it succeeds is a less
complex behavior that would be just fine.

Let me know if you think that'd be an acceptable compromise, and I'll
roll it into v15. As a preview, it pretty much amounts to dropping 3/7
and editing the commit message in this 2/7 patch.

> I did not suggest to swap it: my suggestion is to just pin these vDSO data 
> pages. The per thread memory overhead is infinitesimal on the vast majority 
> of the target systems, and the complexity trade-off you are proposing is 
> poorly reasoned IMO.
> 
> I think my core point that it would be much simpler to simply pin those 
> pages and not introduce rarely-excercised 'discardable memory' semantics in 
> Linux is a fair one - so it's straightforward to lift this NAK.

Okay so this is where I think we're really not lined up and is a large
part of why I wondered whether you'd read the commit messages before
dismissing this. This VM_DROPPABLE mapping comes as a result of a
vgetrandom_alloc() syscall, which (g)libc makes at some point, and then
the result of that is passed to the vDSO getrandom() function. The
memory in vgetrandom_alloc() is then carved up, one per thread, with
(g)libc's various internal pthread creation/exit functions.

So that means this isn't a thing that's trivially limited to just one
per thread. Userspace can call vgetrandom_alloc() all it wants.

Thus, I'm having a hard time seeing how relaxing rlimits here as you
suggested doesn't amount to an rlimit backdoor. I'm also not seeing
other fancy options for "pinning pages" as you mentioned in this email.
Something about having the kernel allocate them on clone()? That seems
terrible and complex. And if you do want this all to go through mlock(),
somehow, there's still the fork() inheritabiity issue. (This was all
discussed on the thread a few versions ago that surfaced these issues,
by the way.)

So I'm not really seeing any good alternatives, no matter how hard I
squint at your suggestions. Maybe you can elaborate a bit?
Alternatively, perhaps the compromise I suggested above where we ditch
the instruction decoder stuff is actually fine with you?

> rarely-excercised 'discardable memory' semantics in 
> Linux is a fair one - so it's straightforward to lift this NAK.

I still don't think calling this "rarely-exercised" is true. Desktop
machines regularly OOM with lots of Chrome tabs, and this is
functionality that'll be in glibc, so it'll be exercised quite often.
Even on servers, many operators work with the philosophy that unused RAM
is wasted RAM, and so servers are run pretty close to capacity. Not to
mention Android, where lots of handsets have way too little RAM.
Swapping and memory pressure and so forth is very real. So claiming that
this is somehow obscure or rarely used or what have you isn't very
accurate. These are code paths that will certainly get exercised.

Jason
