Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFB565F9A0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 03:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjAFCmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 21:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjAFCmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 21:42:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E1165AD0;
        Thu,  5 Jan 2023 18:42:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83B1AB81C3E;
        Fri,  6 Jan 2023 02:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C6DC433D2;
        Fri,  6 Jan 2023 02:42:34 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ny+dCxXQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1672972951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g1mMlBEGSH2yJeXHfEJcLsexhlCzf0SSwDSRSbPe6+4=;
        b=ny+dCxXQ/0DuBUk+XJHzeaUeqT3EVGKAl2Rr/lYLEYrmHIJQ+MtDOg153v2IZImUWbtoig
        lBdmtGmPSXabTgE1Eq9qNkpvwrBAw3PPVOtNlibVP70ZIK94iVKC6HLt5FtPyDCWJ1UkN5
        W85ewNz9OiZziXXdzYUzyDzqup9d0c4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 71928115 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 6 Jan 2023 02:42:31 +0000 (UTC)
Date:   Fri, 6 Jan 2023 03:42:28 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Yann Droneaud <ydroneaud@opteya.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, tglx@linutronix.de,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH v14 2/7] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
Message-ID: <Y7eKlGDHyfHLRDuE@zx2c4.com>
References: <CAHk-=wg_6Uhkjy12Vq_hN6rQqGRP2nE15rkgiAo6Qay5aOeigg@mail.gmail.com>
 <Y7SDgtXayQCy6xT6@zx2c4.com>
 <CAHk-=whQdWFw+0eGttxsWBHZg1+uh=0MhxXYtvJGX4t9P1MgNw@mail.gmail.com>
 <Y7SJ+/axonTK0Fir@zx2c4.com>
 <CAHk-=wi4gshfKjbhEO_xZdVb9ztXf0iuv5kKhxtvAHf2HzTmng@mail.gmail.com>
 <Y7STv9+p248zr+0a@zx2c4.com>
 <10302240-51ec-0854-2c86-16752d67a9be@opteya.com>
 <Y7dV1lVUYjqs8fh0@zx2c4.com>
 <CAHk-=wijEC_oDzfUajhmp=ZVnzMTXgjxHEcxAfaHiNQm4iAcqA@mail.gmail.com>
 <CAHk-=wiO4rp8oVmj6i6vvC97gNePLN-SxhSK=UozA88G6nxBGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiO4rp8oVmj6i6vvC97gNePLN-SxhSK=UozA88G6nxBGQ@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 06:08:28PM -0800, Linus Torvalds wrote:
> (although honestly, we should solve the 32-bit
> problem first - ignoring it isn't fine for anything that is supposed
> to be widely useful).

Yea, the 64-bit aspect of that patch is pretty gnarly. I would hope that
if converting the field to be 64-bit everywhere, the compiler would
still generate good code for most cases, when testing against
common-case constant bit masks that are half unset, but I didn't look
into it. Indeed if this is to become something real, that'd be a
worthwhile pre-requisite project.

> And I think VM_DROPPABLE matches (a), and would be fine if it had some
> other non-made-up use (although honestly, we should solve the 32-bit
> problem first - ignoring it isn't fine for anything that is supposed
> to be widely useful).
> 
> We *have* talked about features kind of like it before, for people
> doing basically caches in user space that they can re-create on demand
> and are ok with just going away under memory pressure.
> 
> But those people almost invariably want dropped pages to cause a
> SIGSEGV or SIGBUS, not to come back as zeroes.

Yea it seems intuitively like that would be a useful thing. Rather than
trying to heuristically monitor memory pressure from inside
uncoordinated userspace apps, just have the kernel nuke pages when it
makes sense to do.

The thing is -- and this is what I was trying to express to Yann --
while I have some theoretical notion of how it /might/ be useful, that's
mainly just a guess from me. But one could run around discussing the
idea with actual potential users of it, and see if anyone's eyes light
up. And then once, for example, the Chrome renderer team is clamoring
for it, then hey, there'd be a good use that wouldn't be bound up with
security models not everybody cares about.

> So you were insulting when you said kernel people don't care about
> security issues.  And I'm just telling you that's not true, but it

Maybe you read that without looking at the end of the sentence which
read: ", assuming that the concerns are unreal or niche or paranoid or
whatever." Because the email you sent in response pretty much described
the concerns as either unreal or niche. So I didn't mean to be
insulting. I actually think we agree with each other on the nature of
your position.

> *is* 100% true that kernel people are often really fed up with
> security people who have their blinders on, focus on some small thing,
> and think nothing else ever matters.
> 
> So yes, the way to get something like VM_DROPPABLE accepted is to
> remove the blinders, and have it be something more widely useful, and
> not be a "for made up bad code".

I get this part. Either the implementation is trivial/convenient/
unintrusive/unnoticeable, or it really needs to be motivated by
something you find compelling and preferably has wide application. No
objection from me there.

If you ignore the instruction decoder part, though -- which I mentioned
to Ingo could be nixed anyway -- my initial estimation of this patch
here was that it wasn't /that/ bad, being +32/-3, and I didn't buy the
arguments that it'd be rarely used code paths and that nobody OOMs and
nobody swaps, because it doesn't match my own experience of seeing
OOMing regularly and the fact that if this is in glibc, it'll wind up
being used. So the initial arguments against it were not compelling.

But then you and others elaborated that VM_* flags really ought to be
for general things, and that as a matter of taste and cleanliness,
sticking things into the *core* of mm/ is just really a sensitive thing
not to be done lightly and without a really compelling reason. And so I
also get that.

So, I'm playing around with other technical solutions to the mlock()
limitation thing that started all of this (amidst other things in my
end-of-the-year backlog), and I'll post results if I can get something
working.

Jason
