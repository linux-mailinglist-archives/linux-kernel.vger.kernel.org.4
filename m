Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2495FDE18
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 18:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiJMQSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 12:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJMQS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 12:18:27 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE0C0D0396;
        Thu, 13 Oct 2022 09:18:25 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 29DGID8o018795;
        Thu, 13 Oct 2022 18:18:13 +0200
Date:   Thu, 13 Oct 2022 18:18:13 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: gcc 5 & 6 & others already out of date?
Message-ID: <20221013161813.GI16609@1wt.eu>
References: <CAHmME9prBJHmo9Bw6aobuGLjtxLsjxKJ9wopOv5+BY6ZtuKaNg@mail.gmail.com>
 <Y0gLyLbdOCetX5LN@sirena.org.uk>
 <Y0gteD0QYVlYxSZh@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0gteD0QYVlYxSZh@zx2c4.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Thu, Oct 13, 2022 at 09:23:36AM -0600, Jason A. Donenfeld wrote:
> On Thu, Oct 13, 2022 at 01:59:52PM +0100, Mark Brown wrote:
> The thing is, do we really want to be catering to this? In the first
> place, enterprise users and enterprise kernels are already doing freaky
> things, forked to no end.

It's important not to confuse enterprise users and enterprise distros.
The users are precisely not forking things to death, they're using
solely what they're being fed by the distro (and possibly other vendors).

> But moreover, do we actually want to support
> people building the kernel with a different compiler than most of us
> develop with? In a basic way, that just seems like a recipe for
> disaster.

I think it's important to make *reasonable efforts* for this, yes.
For example at work we're building appliances for which we test and
validate working combinations of gcc+binutils+glibc+kernel, and once
we've found a sane working combination that doesn't break userspace
too much, we stick to it and we use it for both kernel AND userland.

I must confess that having had to upgrade the toolchain in the past
*only* for the kernel was annoying. It's never wasted since it forces
to do some of the update work, and there could be pretty valid reasons
for this. However being forced to patch userland code to please gcc
just because kernel developers decided to switch again based on what
their distro ship is a needless pain.

Another thing, kernels can take time to build, and people do setup
some distributed toolchains. You may remember the presentation of
my build farm at Kernel Recipes. Once you've spent quite some time
on canadian cross builds and your setup is fine, you cross fingers
for it to last as long as possible. And typically when I worked on
the floppy fixes a few years ago that was when my compiler stopped
being supported. I started by spending several week-ends trying to
update my setup before going back to real work. Again I know that
sometimes this is need and it was my task to devote some time to
this. But let's not have to do this too often unless really needed.

Usually it's considered fair to drop support for a compiler when the
build issues that pop up are too difficult to fix, and/or when they
require quite some work and you figure that if nobody complained for
a long time it definitely means nobody's using it anymore.

But even on personal projects I continue to support older compilers
because once in a while someone asks me if I can help them build on
$RANDOM_OLD_SYSTEM, and I figured that the diversity provided by
exotic environments sometimes uncover interesting issues.

So I'd really suggest to stick to the good old "as long as it works
and doesn't involve unreasonable effort, let's consider it still
works".

> Plus, as I mentioned earlier, this is already the model we're going
> toward by virtue of Rust (and to a small extent, Clang) invading.

That's also the model where people routinely do:

    $ curl github.com/blah | sudo sh

that makes everything very hardly reproducible and is not necessarily
a good approach all the time.

It might be reasonable to reduce the compiler spectrum a bit but losing
users on the way and making it more painful to them to occasionally test
a kernel is neither nice nor profitable to get reports.

I do still remember the days where one needed to build a kernel using
kgcc because the distro's one didn't work, and quite frankly, that was
a total mess and it did discourage quite a few people I knew.

Just my two cents,
Willy
