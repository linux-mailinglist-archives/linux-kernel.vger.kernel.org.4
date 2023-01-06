Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC756608D9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 22:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjAFVgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 16:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235862AbjAFVgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 16:36:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50823AB27;
        Fri,  6 Jan 2023 13:36:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F19A61F6F;
        Fri,  6 Jan 2023 21:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53A2C433EF;
        Fri,  6 Jan 2023 21:36:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Lw5J2oJG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1673040999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iBuV3hmE9MTswDExTCjyj/E1AIJfosMyykKtbV7OQBQ=;
        b=Lw5J2oJGEsVjlubs6QISg3WV7V7HRaEytxm4hiXK2JwyachDcJi7HU4HWIJVPwyz+rwzLE
        apbuJrPc6ZEHzDw5h3SQ0zATwxJawcJaypUv8oDWcu7Ooryx5hMzkzRAEAM2pLSi2iV3tH
        zZ7rD+4WJHGrP4AqYGzfhQPhxwKrw5U=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1d0af2f9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 6 Jan 2023 21:36:39 +0000 (UTC)
Date:   Fri, 6 Jan 2023 22:36:38 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Yann Droneaud <ydroneaud@opteya.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        patches@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH v14 2/7] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
Message-ID: <Y7iUZmbXOIuBKtIh@zx2c4.com>
References: <Y7SDgtXayQCy6xT6@zx2c4.com>
 <CAHk-=whQdWFw+0eGttxsWBHZg1+uh=0MhxXYtvJGX4t9P1MgNw@mail.gmail.com>
 <Y7SJ+/axonTK0Fir@zx2c4.com>
 <CAHk-=wi4gshfKjbhEO_xZdVb9ztXf0iuv5kKhxtvAHf2HzTmng@mail.gmail.com>
 <Y7STv9+p248zr+0a@zx2c4.com>
 <10302240-51ec-0854-2c86-16752d67a9be@opteya.com>
 <Y7dV1lVUYjqs8fh0@zx2c4.com>
 <CAHk-=wijEC_oDzfUajhmp=ZVnzMTXgjxHEcxAfaHiNQm4iAcqA@mail.gmail.com>
 <CAHk-=wiO4rp8oVmj6i6vvC97gNePLN-SxhSK=UozA88G6nxBGQ@mail.gmail.com>
 <f36f19ee-5bff-4cd0-b9a9-0fe987cf6d38@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f36f19ee-5bff-4cd0-b9a9-0fe987cf6d38@app.fastmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 12:53:41PM -0800, Andy Lutomirski wrote:
> 
> 
> On Thu, Jan 5, 2023, at 6:08 PM, Linus Torvalds wrote:
> > On Thu, Jan 5, 2023 at 5:02 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> >>
> >> None of what you ask for is for any kind of real security, it's all
> >> just crazy "but I want to feel the warm and fuzzies and take shortcuts
> >> elsewhere, and push my pain onto other people".
> >
> > Actually, let me maybe soften that a bit and say that it's
> > "convenience features". It might make some things more _convenient_ to
> > do, exactly because it might allow other parts to do short-cuts.
> >
> > But because it's a convenience-feature, it had also better either be
> > (a) really easy and clear to do in the kernel and (b) have
> > sufficiently *wide* convenience so that it doesn't end up being one of
> > those "corner case things we have to maintain forever and nobody
> > uses".
> >
> > And I think VM_DROPPABLE matches (a), and would be fine if it had some
> > other non-made-up use (although honestly, we should solve the 32-bit
> > problem first - ignoring it isn't fine for anything that is supposed
> > to be widely useful).
> >
> > We *have* talked about features kind of like it before, for people
> > doing basically caches in user space that they can re-create on demand
> > and are ok with just going away under memory pressure.
> >
> > But those people almost invariably want dropped pages to cause a
> > SIGSEGV or SIGBUS, not to come back as zeroes.
> >
> > So you were insulting when you said kernel people don't care about
> > security issues.  And I'm just telling you that's not true, but it
> > *is* 100% true that kernel people are often really fed up with
> > security people who have their blinders on, focus on some small thing,
> > and think nothing else ever matters.
> >
> > So yes, the way to get something like VM_DROPPABLE accepted is to
> > remove the blinders, and have it be something more widely useful, and
> > not be a "for made up bad code".
> 
> I'm going to suggest a very very different approach: fix secret storage in memory for real.  That is, don't lock "super secret sensitive stuff" into memory, and don't wipe it either.  *Encrypt* it.
> 
> This boils down to implementing proper encrypted swap support, which is not conceptually that difficult.  The kernel already has identifiers (mapping, offset, etc) for every page in swap and already stores some metadata.  Using that as part of a cryptographic operation seems conceptually fairly straightforward.

Not sure this solves the right problem, which is primarily related to
forward secrecy, which means the important property is timely secret
erasure. Writing things out to disk complicates that, and encrypted swap
means moving the problem into key lifetime, which sounds like a can of
worms to synchronize. So this doesn't sound so appealing to me as a
solution.

It does sound like a potentially nice thing for other uses, though.

Jason
