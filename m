Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2601663F4C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 12:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbjAJLf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 06:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbjAJLfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 06:35:54 -0500
X-Greylist: delayed 1796 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 Jan 2023 03:35:49 PST
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A71E85014C;
        Tue, 10 Jan 2023 03:35:49 -0800 (PST)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 30AB1UCJ013380;
        Tue, 10 Jan 2023 05:01:30 -0600
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 30AB1SPZ013379;
        Tue, 10 Jan 2023 05:01:28 -0600
Date:   Tue, 10 Jan 2023 05:01:28 -0600
From:   "Dr. Greg" <greg@enjellic.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Yann Droneaud <ydroneaud@opteya.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        patches@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH v14 2/7] mm: add VM_DROPPABLE for designating always lazily freeable mappings
Message-ID: <20230110110128.GA12987@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <CAHk-=whQdWFw+0eGttxsWBHZg1+uh=0MhxXYtvJGX4t9P1MgNw@mail.gmail.com> <Y7SJ+/axonTK0Fir@zx2c4.com> <CAHk-=wi4gshfKjbhEO_xZdVb9ztXf0iuv5kKhxtvAHf2HzTmng@mail.gmail.com> <Y7STv9+p248zr+0a@zx2c4.com> <10302240-51ec-0854-2c86-16752d67a9be@opteya.com> <Y7dV1lVUYjqs8fh0@zx2c4.com> <CAHk-=wijEC_oDzfUajhmp=ZVnzMTXgjxHEcxAfaHiNQm4iAcqA@mail.gmail.com> <CAHk-=wiO4rp8oVmj6i6vvC97gNePLN-SxhSK=UozA88G6nxBGQ@mail.gmail.com> <f36f19ee-5bff-4cd0-b9a9-0fe987cf6d38@app.fastmail.com> <CAHk-=wgLWcKq2AdrTmTOxJKn6w4oEpEGdipWAah5Xad5-Yii6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgLWcKq2AdrTmTOxJKn6w4oEpEGdipWAah5Xad5-Yii6Q@mail.gmail.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Tue, 10 Jan 2023 05:01:30 -0600 (CST)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 01:10:44PM -0800, Linus Torvalds wrote:

Good morning, I hope the week is going well for everyone.

> On Fri, Jan 6, 2023 at 12:54 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > I'm going to suggest a very very different approach: fix secret
> > storage in memory for real. That is, don't lock "super secret
> > sensitive stuff" into memory, and don't wipe it either. *Encrypt* it.
> 
> I don't think you're wrong, but people will complain about key
> management, and worry about that part instead.
> 
> Honestly, this is what SGX and CPU enclaves is _supposed_ to all do
> for you, but then nobody uses it for various reasons.

The principal problem is that enclave technology was not made either
ubiquitous or accessible, long story there, suitable for multiple
snifters of single malt.

Unfortunately, the same goes for just about every other hardware
security technology.  Every conversation comes down to; "what is the
business case for the technology", which translated means, how much
money are we going to make off it.

Encrypting memory based secrets, as an alternative to wiping them, is
attractive, but hardware support is needed to do key management
securely and correctly.  Even than, by definition, there will be a
window when the material needs to be in memory as plaintext.

A discussion can be had in this arena about perfection being the enemy
of good.  If you are truely interested in perfection in this endeavor,
you need to have a trusted platform definition and implementation.

Which, if history is any indication, needs to be an open architecture
with respect to both software and hardware.

>                Linus

Best wishes to everyone for a productive remainder of the week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
