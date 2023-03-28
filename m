Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8F26CB552
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 06:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjC1EJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 00:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbjC1EJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 00:09:35 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061E4118
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 21:09:33 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32S49HG1005337
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 00:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1679976559; bh=xEUgyi4FtJcJgG0kTZg0LTpdeLCMPOiAauE4Hxtwv9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=cZQq84ou90UYxoi1qbSYS1CWz3QrV9hEXYFHU/F8mhs6PSPbQxfVjTD/sMeqgzmF0
         Myax1ED508R4PdvFhmCDV6ihOErvFw5OxpJkMU9goXskTJkTFY19zwyFm1rPKjV1Zl
         ZnLC9sL1Qvjj5BK/c610Q/XU7zJ/V/C+6B+jM6MdCiDWZlaRuJEUZx21YlpVAwzDPj
         crsm2js7j31HzkIvFTv94KT2SvDYihugP2E1MpLC9r8SjMYchMylh5AX9BZbxT3a8f
         XgP/oH0TbnIumCT4RtNZOJ0dj/YaiYlEaAz0lzpsWa5oajRg3nOQocrdgHWgmhOHlR
         zqZhhzza06fog==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5A14E15C4930; Tue, 28 Mar 2023 00:09:17 -0400 (EDT)
Date:   Tue, 28 Mar 2023 00:09:17 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Change in kernel debian packages between -rc2 and -rc3
Message-ID: <20230328040917.GC108653@mit.edu>
References: <20230325143122.GA409315@mit.edu>
 <CAK7LNARndpbtzRAW1kEiqyNBmAxdqJKiTquvY9bW08LYTTMiOg@mail.gmail.com>
 <20230326121118.GB323408@mit.edu>
 <CAK7LNARcUSsjzi7UV+rHHaQU1X-XJ0jN0sLAw2m=SypTQTCHKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARcUSsjzi7UV+rHHaQU1X-XJ0jN0sLAw2m=SypTQTCHKA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 10:35:09PM +0900, Masahiro Yamada wrote:
> 
> The actual effect is whether you can install
> multiple kernel packages at the same time or not
> because the ABI version is a part of the package name.
> The ABI is nothing more than that for upstream kernel packages.

Well, for me, technically speaking CONFIG_LOCAVERSION *does* specify
an module ABI.  I have a install-kconfig[1] which is **different**
from what I might use in other contexts (for example, when building a
custom kernel for my laptop and desktop).  And in fact, there are two
flavors, with different kernel configs --- and hence, different and
incompatible module ABI's.  "xfstests"[2] and "xfstests-perf"[3]

[1] https://github.com/tytso/xfstests-bld/blob/master/kernel-build/install-kconfig
[2] https://github.com/tytso/xfstests-bld/blob/master/kernel-build/kernel-configs/config-6.1
[3] https://github.com/tytso/xfstests-bld/blob/master/kernel-build/kernel-configs/perf-config-6.1

And since they are different ABI's, and I want to distinguish between
them in the package name, so I can keep them straight --- and in
theory, there would be nothing wrong with wanting to have both an
"xfstests" and "xfstests-perf" installed at the same time, and being
able to select between the two of them using a bootloader.

Ergo, in my case CONFIG_LOCAVERSION is *part* of the version, and it
is a **feature*** that package names should include the
CONFIG_LOCALVERSIONS --- because they are different kernels, with
different properties!


> > In any case, it's an incompatible regression made during rc2 and rc3,
> > which I think is at the very least, unfortunate.
> 
> Your tool was working on a wrong assumption, which nobody promised.

It's still a backwards incompatible change.  And Linus doesn't like
backwards compatible changes which is noticeable, even if it's
something which isn't promised in, say, the POSIX spec.  If we change
kernel behavior, and it's noticeable, it's BAD BAD BAD.  I would claim
the same is true for kbuild infrastructure, unless there's a really
good reason.


> Kbuild already provides various hooks.
> You can use CONFIG options and KERNELRELEASE to override uname,
> and use KDEB_PKGVERSION to override the package version.

KDEB_PKGVERSION is not documented anywhere.  Thank you for telling me
about it, though.

I'd suggest that perhaps KDEB_PKGVERSION is documented, so there is an
explicit promise that this interface will be preserved?  I would hate
for you to later change, and break me, and claim "nobody promised",
since it's not documented.

And if you really want users to be able to replicate a Debian kernel's
"module ABI", then I'd **strongly** suggest that you document how they
are supposed to do that.  After all, Debian and Ubuntu doesn't use the
kbuild infrastructure; they have their own hugely complicated way of
generating files.

And oh by the way, I've just looked up Debian's documentation on that,
and the "ABI name" is not just the kernel version.  So it's not just
(for example) "2.6.18", but "2.6.18-1-686".   See [2].

[2] https://wiki.debian.org/DebianKernelABIChanges

And if you are going to be including the full git commit id in the
version, e.g., "6.3.0-rc3-00043-g463f2e46bf7c", it's not going to be
compatible with the Debian kernel ABI name ***anyway***.  So it's also
equally broken in terms of hwo Debian does things.


> They are enough to continue your broken workflow.

Well, for upstream developers, it's very useful to be able to
distinguish between kernel configs and this very *much* implicates the
"module ABI".  So IMHO think my particular use case is not "broken",
but in fact essential.

There are Very Good Reasons for doing things in this particular way.

      	       	    	    	      - Ted

P.S.  I actually simplified the story a little bit; there are actually
quite a lot more possible "module ABI's", or "kernel configs" than
just the two "xfstests" and "xfstests-perf".  These are all valid
install-kconfig commands:

# This will produce a CONFIG_LOCALVERSION of "xfstests-blktests"
% install-kconfig --blktests

# This will produce a CONFIG_LOCALVERSION of "xfstests-perf-kasan"
% install-kconfig --perf --kasan

# This will produce a CONFIG_LOCALVERSION of "xfstests-dept"
% install-kconfig --dept

# This will produce a CONFIG_LOCALVERSION of "xfstests-debug-lockdep"
% install-kconfig --debug --lockdep

etc.

These are all different kernel configs, producing different "module
ABI"'s, and I want to be able to distinguish between them in the
generated package files!

