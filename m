Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D5665F974
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 03:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjAFCO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 21:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAFCOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 21:14:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661026147C;
        Thu,  5 Jan 2023 18:14:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0A9DB81C1B;
        Fri,  6 Jan 2023 02:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8730C433D2;
        Fri,  6 Jan 2023 02:14:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bgtnvABn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1672971284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zV+FAKTYfnq/izK9+tvukztBlOMzR+jVXoKj8+sVMlQ=;
        b=bgtnvABn4fSeLRDj0Z1IpzdpaJQFR7+TNuUvGPrvFiadDeBJvISVPXSUdhO73cfbFx3eY3
        wBlZS5Z3ok6owbfr2P55GSW5V63vvsV9ypXkToVVweV49EB66HEDHUBi6EQ8FI4tI29nKp
        43oTkai88AQ9lczi/cbdycmNc0tGYww=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 74d41f10 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 6 Jan 2023 02:14:44 +0000 (UTC)
Date:   Fri, 6 Jan 2023 03:14:41 +0100
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
Message-ID: <Y7eEEV54s2uqMLs9@zx2c4.com>
References: <CALCETrWdw5kxrtr4M7AkKYDOJEE1cU1wENWgmgOxn0rEJz4y3w@mail.gmail.com>
 <CAHk-=wg_6Uhkjy12Vq_hN6rQqGRP2nE15rkgiAo6Qay5aOeigg@mail.gmail.com>
 <Y7SDgtXayQCy6xT6@zx2c4.com>
 <CAHk-=whQdWFw+0eGttxsWBHZg1+uh=0MhxXYtvJGX4t9P1MgNw@mail.gmail.com>
 <Y7SJ+/axonTK0Fir@zx2c4.com>
 <CAHk-=wi4gshfKjbhEO_xZdVb9ztXf0iuv5kKhxtvAHf2HzTmng@mail.gmail.com>
 <Y7STv9+p248zr+0a@zx2c4.com>
 <10302240-51ec-0854-2c86-16752d67a9be@opteya.com>
 <Y7dV1lVUYjqs8fh0@zx2c4.com>
 <CAHk-=wijEC_oDzfUajhmp=ZVnzMTXgjxHEcxAfaHiNQm4iAcqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wijEC_oDzfUajhmp=ZVnzMTXgjxHEcxAfaHiNQm4iAcqA@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 05:02:05PM -0800, Linus Torvalds wrote:
> On Thu, Jan 5, 2023 at 2:57 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > On Thu, Jan 05, 2023 at 10:57:48PM +0100, Yann Droneaud wrote:
> > >
> > > To hold secret material, we need MADV_WIPEONFORK | MADV_DONTDUMP and the side effect of mlock() (pages' content never written to swap), inherited across fork().
> > > And I want mlock() without paying the price.
> > >
> > > Jason's proposed semantics, which I call MADV_WIPEONSWAP, provide a mean to hold /unlimited/ amount secrets in userspace memory (not limited by RLIMIT_MEMLOCK).
> > > The only constraint for userspace is to handle the case pages are wiped, which is already the case of userspace arc4random()'s implementation.
> >
> > If you're actually serious about wanting a generic mechanism for
> > userspace, I think the moral of yesterday's poo-poo'ing all over this
> > cool new idea is that the Linux innercircle doesn't really care for
> > "security things" as a motivator
> 
> No.
> 
> We don't take stupid statements as a motivator.
> 
> Stop with the histrionics and silly security theater BS.
> 
> There is *nop* security in "MADV_WIPEONFORK". You claiming that that
> is "security" is just making you less believable and me ignoring your
> arguments more.
> 
> It's a complete make-believe fairy tale.
> 
> Why would it be "security" to dump random state data? In most
> situations it's a complete non-issue, and nobody cares.
> 
> And those situations that want to be extra careful, and are actually
> generating keys, those situations can do all of this very carefully on
> their own using existing machinery.
> 
> If you don't want a core-dump because you have sensitive information,
> you do "ulimit -c 0". Or you use MADV_DONTDUMP that we've had forever.
> 
> And you don't want to have wipe-on-fork, because
> 
>  (a) if you want things to be wiped on fork, you just wipe it before
> the fork (duh!)
> 
>  (b) but more likely, and more relevantly, you want to make *DAMN
> SURE* you wiped things much earlier than that if you are really
> security-conscious and just generated a secret key, because you don't
> want to leak things accidentally other ways.
> 
>  (c) and you can use MADV_DONTFORK to not copy it at all, which again
> we've had for a long time.

I never made any of these arguments. This just reads like angry-strawman
to me.

In fact there's actually an intelligent argument against using
VM_DONTDUMP, which is that a core dump will only ever contain state that
hasn't yet been used by anything, since it'll either be a random value
that hasn't yet been returned to the caller, or the overwritten/ratcheted
state that can't be wound backwards to recover the previous state. So it
doesn't really matter that much if it gets written into a core dump.

But in fact, I didn't make any argument one way or another for it.

> And if you don't want to have it written to swap, you're just making
> sh*t up at that point.

I'm really not making stuff up. I've reconstructed and recovered keys
and secrets from pilfered swap partitions before on more than one
occasion. The whole idea is to prevent a state that's going to be used
to generate secrets in the future from being written to a place that
can't be easily and deterministically wiped after use.

I get that you're pretty convinced this is all bologna, and that
"forward secrecy" is really just for security LARPers. But there are
plenty of people whose threat models disagree, including my own
experience reconstructing keys in swap from pulled drives.

> anybody who can read swap space can already ptrace you and
> read things much more easily that way.

As you probably inferred from the above, this isn't a ptrace question.
If you have code execution on the same machine before random bytes are
generated, all bets are off and none of this matters anyway. (And more
generally, if you have code exec prior to use, you can probably not even
care about cryptographic stuff, since in many cases you can just access
whatever sensitive data you were after in the first place.)

> Thirdly, you can just use mlock, and make sure you never have so much
> super-sikret stuff pending for long times and in big buffers.

Yea this is what I initially tried. Then people (Jann and Florian, IIRC)
pointed out all sorts of thorny issues with inheriting that on fork()
and segfaulting if non-reserved and such. So eventually I came up with
this monster as a way to avoid the pitfalls -- as just one particular
technical solution.

It turns out that twiddling with mm/ internals isn't your idea of a fun
time, so I'll keep futzing with things and see if I can come up with a
less intrusive technical solution. IOW, I'm not really wedded at all to
this VM_DROPPABLE thing, and if I find another way to do it, great.

> Fourth, if your keys are *that* sensitive, and *that* secret, just use
> /dev/random or getrandom(), because you're not generating that kind of
> volume of long-term keys, so the whole "I have a huge random buffer
> that is super-secret" is a complete non-issue.

I don't think that's really so accurate, actually. Firstly, this whole
swap discussion is about forward secrecy, so we're most likely talking
about ephemeral keys, not long-term keys. Secondly, many protocols that
have ephemeral keys generate them in every handshake, and that might
mean volume. Thirdly, I'm not sure I'd give greater importance to the
secrecy of long-term keys over ephemeral keys, as your point seems to
do; if you're leaking ephemeral keys for some reason, that's pretty bad.

> You guys have literally MADE UP bad examples of so-called "security",
> and then you use those as arguments for bad coding, and for
> bad-mouthing kernel developers who just don't happen to believe in
> that bad model.

I think you might have made up a bunch of arguments I never made. And if
that "you guys" includes me in it, I also object to being summarily
grouped in with any other folks here.

Most importantly, though, I'm not bad-mouthing anyone. Your whole email
strikes me as an indication that my characterization of the matter is a
pretty accurate one.

That characterization from my last email could be summarized as: you
think the model is bogus, that these sorts of security arguments aren't
typically compelling, and so if this VM_DROPPABLE business is to have
any future, it'll need to be motivated by something non-security related
(if there even is one; I made a few guesses as to other applications,
but they're at best guesses, as I obviously have no credibility or
experience in, e.g., claiming what a database program actually might
need). You even said so yourself a few days ago:

| Now, if the magic buffers were something cool that were a generic
| concept that a lot of *other* cases would also kill for, that's one
| thing.

So I would describe my perspective as basically a realistic and
practical one. I don't really mind that you're highly skeptical of
security things and security people, as you have been for as long as I
can remember. I'm not a diehard purist or something. And it's not
bad-mouthing for me to point out the obvious there. Rather, I'll keep
poking around and seeing if I can come up with better technical
solutions to what I think are worthy goals, and you and others will swat
away things that are distasteful (in this case, mm/ tickling), and
perhaps eventually something will emerge. I don't think there's really
anything wrong with that.

> None of what you ask for is for any kind of real security, it's all
> just crazy "but I want to feel the warm and fuzzies and take shortcuts
> elsewhere, and push my pain onto other people".

No. As discussed, it's simply not toward a security model you care for.
But that's fine, you don't need to care about it; I will do that part.

It's also certainly not at all about wanting to feel warm and fuzzies or
take shortcuts or push pain elsewhere. If anything, this pushes the pain
onto me, since I'm the one implementing and maintaining this! I tried to
make mlock() work vanilla for as long as I could before I couldn't
figure out how to do it, groaned, and then tried to implement something
else. I am generally pretty reluctant to code any thing at all.

Jason
