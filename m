Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98C5688D78
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 03:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjBCCzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 21:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjBCCzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 21:55:01 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF9853B657
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 18:54:45 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3132sd6b006525;
        Fri, 3 Feb 2023 03:54:39 +0100
Date:   Fri, 3 Feb 2023 03:54:39 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Vincent Dagonneau <v@vda.io>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tools/nolibc: Add stdint.h
Message-ID: <20230203025439.GA6464@1wt.eu>
References: <20230202201101.43160-1-v@vda.io>
 <20230202214657.GA4579@1wt.eu>
 <7c7f14f9-7625-4e9e-bc6e-c85bdc32b289@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c7f14f9-7625-4e9e-bc6e-c85bdc32b289@app.fastmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 06:29:59PM -0500, Vincent Dagonneau wrote:
> >   - I'm seeing some preparatory changes in nolibc-test.c that are not
> >     directly caused by the patch itself but by its impact (essentially
> >     the width changes), and these ones should be separate so that they
> >     do not pollute the patch and allow reviewers to focus on the
> >     important part of your changes. I even think that you could proceed
> >     in three steps:
> >       - introduce stdint with the new types and values
> >       - enlarge all fields in the selftest to preserve alignment when
> >         dealing with large return values
> >       - add the integer tests to the suite.
> >
> 
> I'm thinking of four steps:
>   - move the existing types to stdint.h, it should compile just fine and would not be adding anything
>   - add the new stuff to stdint.h (*_least_* types + limit macros)
>   - enlarge the fields in the test file
>   - add the tests themselves
> 
> Would it work for you?

You're right, it's even better. I'm happy that you got the principle :-)

> >> +#define         SIZE_MAX UINT64_MAX
> >
> > This one is not correct, it must follow the word size since it's defined
> > as an unsigned long (i.e. same as UINTPTR_MAX later).
> >
> 
> This one is a trick one I think. I've been using
> https://pubs.opengroup.org/onlinepubs/009695399/basedefs/stdint.h.html as a
> reference for this patch and it says SIZE_MAX > 65535 (implementation
> defined).

In fact it says, that these are the minimum ranges an implementation must
support.

> I guess in this case I should follow
> include/uapi/asm-generic/posix_types.h ?

Yes, that's the same principle there, indeed.

> > Other than that it looks correct.
> >
> > If you're having doubts, please run it in i386 mode. For this, please have
> > a look at the thread surrounding this message, as we had a very similar
> > discussion recently:
> >
> >    
> > https://lore.kernel.org/lkml/Y87EVVt431Wx2zXk@biznet-home.integral.gnuweeb.org/
> >
> > It will show how to run the test for other architectures under qemu
> > without having to rebuild a whole kernel. For what you're doing it's
> > a perfect example where it makes sense.
> >
> > I would also suggest always trying arm (has unsigned chars, could
> > possibly catch a mistake) and mips (big endian though should not
> > be affected by your changes, but it's a good habit to develop).
> >
> 
> Yes, as soon as I have some workable patch I'll test it on other arch. Most
> of it will be on qemu though, I might be able to test on x86_64 and arm64
> hardware but that is all I have.

It's fine to run on qemu for this because what you're testing is that
you're using the right combinations of types and ranges on the different
supported platforms, which means verifying that each compiler will produce
the code you're expecting. There's no hardware dependency nor any need to
verify something related to the kernel itself.

> > Thanks!
> > Willy
> 
> Thank you for the review, I do appreciate the time you've spent on the
> response. I'll get a new version out soon.

You're welcome!

Willy
