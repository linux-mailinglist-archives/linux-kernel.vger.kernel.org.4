Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F364165F875
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 02:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236389AbjAFBCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 20:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236382AbjAFBC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 20:02:27 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC7E564C9
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 17:02:24 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-15085b8a2f7so333244fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 17:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E2zTyAKcMSHj1NuBZpldWBfP/uR4r0Oo4FG0pR0Pc4o=;
        b=groJ1iJJAbzkeoFY5z0vFFmU8BFSk2iIyzy4jspxCVqwwWmPsIsjEfRdLdBElbBGOT
         EmrM5lijkGvSvr3nKF/I3GI8riFE7PasAhLLNA/4T+m976ixjVmwz3IcMaPuxSRT3Kgg
         txcqpXsJ9kof2smhhnslMFaxYEJR/ApjGac1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E2zTyAKcMSHj1NuBZpldWBfP/uR4r0Oo4FG0pR0Pc4o=;
        b=vUvTw9EJancUtp/qzNGqERvhyzmT6kfbzbyxKjAVRci6+xH8u2yXbMMYNpFTIBTlKF
         XYJvOoS7GnLrfHnRPNCvqtO66ZcrhGW9f4EfKFA1AHlmylTCdBNV3Dj2P6xOdjyv3suF
         PEuqdEu1+41srbt7ZySlOUOh8Vu0Ma47MgB95RXv0KKMfxmkVfoJ8gOxNimNa5VvckSw
         E7rUvRIVQw4LufT/UDHMgaVNiy5ktYLmIvQPo8E7acu9O3ecLfN3yOQfl9yrYWGMlY7D
         CkZ6PUSk5+lX6ZIJEyawXOemId0us75utzpLP3NZXCTppvkdFG2UsU+dn9Z1mKALM2Ig
         GqnA==
X-Gm-Message-State: AFqh2koOq9T6xM/9BSvZeJplC//Qs6EmR6ER+Wcj2CisXyQukQ4K73D3
        5bgnlSfMJVQtx0QkBeHfDUXLDcwyVhBusp08
X-Google-Smtp-Source: AMrXdXtnbchLwGnEOMEPgT21K3+1El87fkhxtcbJbqBgBi63K10b4qANOKFf1Zc0KtvyiAhJSR3I1Q==
X-Received: by 2002:a05:6871:284:b0:144:49b9:8e3c with SMTP id i4-20020a056871028400b0014449b98e3cmr31396657oae.32.1672966943869;
        Thu, 05 Jan 2023 17:02:23 -0800 (PST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com. [209.85.219.54])
        by smtp.gmail.com with ESMTPSA id d136-20020ae9ef8e000000b006fae7e6204bsm26013924qkg.108.2023.01.05.17.02.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 17:02:22 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id t17so100342qvw.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 17:02:21 -0800 (PST)
X-Received: by 2002:a05:6214:1185:b0:4c6:608c:6b2c with SMTP id
 t5-20020a056214118500b004c6608c6b2cmr2487246qvv.130.1672966941474; Thu, 05
 Jan 2023 17:02:21 -0800 (PST)
MIME-Version: 1.0
References: <20230101162910.710293-3-Jason@zx2c4.com> <Y7QIg/hAIk7eZE42@gmail.com>
 <CALCETrWdw5kxrtr4M7AkKYDOJEE1cU1wENWgmgOxn0rEJz4y3w@mail.gmail.com>
 <CAHk-=wg_6Uhkjy12Vq_hN6rQqGRP2nE15rkgiAo6Qay5aOeigg@mail.gmail.com>
 <Y7SDgtXayQCy6xT6@zx2c4.com> <CAHk-=whQdWFw+0eGttxsWBHZg1+uh=0MhxXYtvJGX4t9P1MgNw@mail.gmail.com>
 <Y7SJ+/axonTK0Fir@zx2c4.com> <CAHk-=wi4gshfKjbhEO_xZdVb9ztXf0iuv5kKhxtvAHf2HzTmng@mail.gmail.com>
 <Y7STv9+p248zr+0a@zx2c4.com> <10302240-51ec-0854-2c86-16752d67a9be@opteya.com>
 <Y7dV1lVUYjqs8fh0@zx2c4.com>
In-Reply-To: <Y7dV1lVUYjqs8fh0@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Jan 2023 17:02:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wijEC_oDzfUajhmp=ZVnzMTXgjxHEcxAfaHiNQm4iAcqA@mail.gmail.com>
Message-ID: <CAHk-=wijEC_oDzfUajhmp=ZVnzMTXgjxHEcxAfaHiNQm4iAcqA@mail.gmail.com>
Subject: Re: [PATCH v14 2/7] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Yann Droneaud <ydroneaud@opteya.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, tglx@linutronix.de,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 5, 2023 at 2:57 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Thu, Jan 05, 2023 at 10:57:48PM +0100, Yann Droneaud wrote:
> >
> > To hold secret material, we need MADV_WIPEONFORK | MADV_DONTDUMP and the side effect of mlock() (pages' content never written to swap), inherited across fork().
> > And I want mlock() without paying the price.
> >
> > Jason's proposed semantics, which I call MADV_WIPEONSWAP, provide a mean to hold /unlimited/ amount secrets in userspace memory (not limited by RLIMIT_MEMLOCK).
> > The only constraint for userspace is to handle the case pages are wiped, which is already the case of userspace arc4random()'s implementation.
>
> If you're actually serious about wanting a generic mechanism for
> userspace, I think the moral of yesterday's poo-poo'ing all over this
> cool new idea is that the Linux innercircle doesn't really care for
> "security things" as a motivator

No.

We don't take stupid statements as a motivator.

Stop with the histrionics and silly security theater BS.

There is *nop* security in "MADV_WIPEONFORK". You claiming that that
is "security" is just making you less believable and me ignoring your
arguments more.

It's a complete make-believe fairy tale.

Why would it be "security" to dump random state data? In most
situations it's a complete non-issue, and nobody cares.

And those situations that want to be extra careful, and are actually
generating keys, those situations can do all of this very carefully on
their own using existing machinery.

If you don't want a core-dump because you have sensitive information,
you do "ulimit -c 0". Or you use MADV_DONTDUMP that we've had forever.

And you don't want to have wipe-on-fork, because

 (a) if you want things to be wiped on fork, you just wipe it before
the fork (duh!)

 (b) but more likely, and more relevantly, you want to make *DAMN
SURE* you wiped things much earlier than that if you are really
security-conscious and just generated a secret key, because you don't
want to leak things accidentally other ways.

 (c) and you can use MADV_DONTFORK to not copy it at all, which again
we've had for a long time.

And if you don't want to have it written to swap, you're just making
sh*t up at that point.

First off, it's a purely theoretical thing in the first place. See (b)
above. Don't keep those random things around long enough (and
untouched enough) to hit the disk.

Secondly, anybody who can read swap space can already ptrace you and
read things much more easily that way.

Thirdly, you can just use mlock, and make sure you never have so much
super-sikret stuff pending for long times and in big buffers.

Fourth, if your keys are *that* sensitive, and *that* secret, just use
/dev/random or getrandom(), because you're not generating that kind of
volume of long-term keys, so the whole "I have a huge random buffer
that is super-secret" is a complete non-issue.

So stop making stupid arguments. The kernel is not supposed to
baby-sit programs that do things wrong on purpose, and that are
literally trying to do things wrong, and leaving secret stuff around
while they do a lot of other things.

You guys have literally MADE UP bad examples of so-called "security",
and then you use those as arguments for bad coding, and for
bad-mouthing kernel developers who just don't happen to believe in
that bad model.

None of what you ask for is for any kind of real security, it's all
just crazy "but I want to feel the warm and fuzzies and take shortcuts
elsewhere, and push my pain onto other people".

          Linus
