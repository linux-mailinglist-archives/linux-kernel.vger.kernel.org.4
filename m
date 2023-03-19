Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133AF6C06AB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 00:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjCSXzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 19:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjCSXy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 19:54:58 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380C410A82
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 16:54:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8E24ECE0FF7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 23:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0431C433A0;
        Sun, 19 Mar 2023 23:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679270093;
        bh=ri1bFvzvYCzYc2eDhvW1AHynIvF9z0qIDBW51HwrkZI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Z4E1SzJEEC4NuQePByPdE0eeHVLoB3R0r2dA2tQPWHpMsJpLaoulBzruanD8bCI86
         mWCRYmFFXvdOAXBW6MnOgxdxxgxAwLhPdHiNGhiMFtHkePe2I+wseCybBl5VAzFwdd
         ZPYsKC5dK70bda8/0AGPzV7wSTaSOYW+Cd8pP5OcMU0jFBGJJaQf8pp/pLmsgRwlGK
         FH5USXDqzIoNxvLaNMu+DlMWzaFmYMdqWjvkPClidHSa842LJ1TtKbaGYcEZlEYpYY
         kLXUE63+GR001PMgVFgktAaMTKNnSyHpK5mnPb931DmJZg5pAtKHlzxo6O4xHOzhYW
         x5kl/BaeoQvoQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 422451540381; Sun, 19 Mar 2023 16:54:53 -0700 (PDT)
Date:   Sun, 19 Mar 2023 16:54:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] tools/nolibc: always disable stack protector for
 tests
Message-ID: <b8badcd8-44a0-4380-a5f1-381f058ea276@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230319135100.31952-1-w@1wt.eu>
 <5c2fdd86-4e6a-4f48-ab57-95a223f39e94@paulmck-laptop>
 <ZBdsZ61bt7aLdbSo@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBdsZ61bt7aLdbSo@1wt.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 09:11:19PM +0100, Willy Tarreau wrote:
> Hi Paul,
> 
> On Sun, Mar 19, 2023 at 11:05:15AM -0700, Paul E. McKenney wrote:
> > Queued and pushed, thank you both!
> 
> Thank you!
> 
> > Just to make sure I understand, you would like me to add this to the
> > serieses from Vincent, yourself, and Feiyang that are set up to go into
> > the next merge window, correct?
> > 
> > If you instead would like me to push it to Linus directly into the v6.3
> > release as a regression fix late this coming week, please let me know.
> 
> It would indeed be preferable for 6.3 as it fixes issues, but it's not
> critical at all, just an annoyance for some developers. So if you have a
> series of fixes pending to be sent soon, it would be nice to add it there.

Very well, here is what I currently have for nolibc, from newest to
oldest:

7712ec32cbda selftests/nolibc: Adjust indentation for Makefile
96218cfc79eb selftests/nolibc: Add support for LoongArch
cab6bbd00f2a tools/nolibc: Add support for LoongArch
496921e4724c tools/nolibc: Add statx() and make stat() rely on statx() if necessary
97a15c47b98c tools/nolibc: Include linux/fcntl.h and remove duplicate code
de06f2fe1aac tools/nolibc: check for S_I* macros before defining them
7fb54b517d44 selftests/nolibc: skip the chroot_root and link_dir tests when not privileged
296659c6e551 tools/nolibc: add getuid() and geteuid()
bd9a87d64994 tools/nolibc: add tests for the integer limits in stdint.h
2d1813a7ef67 tools/nolibc: enlarge column width of tests
5dbcbb2da574 tools/nolibc: add integer types and integer limit macros
111bb94f67eb tools/nolibc: add stdint.h
2dbf8575b2da tools/nolibc: Add gitignore to avoid git complaints about sysroot

I will take the new commit, rebase it to precede the first of the above,
so that the stack will look like this:

7712ec32cbda selftests/nolibc: Adjust indentation for Makefile
96218cfc79eb selftests/nolibc: Add support for LoongArch
cab6bbd00f2a tools/nolibc: Add support for LoongArch
496921e4724c tools/nolibc: Add statx() and make stat() rely on statx() if necessary
97a15c47b98c tools/nolibc: Include linux/fcntl.h and remove duplicate code
de06f2fe1aac tools/nolibc: check for S_I* macros before defining them
7fb54b517d44 selftests/nolibc: skip the chroot_root and link_dir tests when not privileged
296659c6e551 tools/nolibc: add getuid() and geteuid()
bd9a87d64994 tools/nolibc: add tests for the integer limits in stdint.h
2d1813a7ef67 tools/nolibc: enlarge column width of tests
5dbcbb2da574 tools/nolibc: add integer types and integer limit macros
111bb94f67eb tools/nolibc: add stdint.h
2dbf8575b2da tools/nolibc: Add gitignore to avoid git complaints about sysroot
???????????? tools/nolibc: always disable stack protector for tests

Then if tests, -next, and kernel test robot are kind, I will send a
pull request to Linus for the "always disable stack protector for tests"
commit.  The rest I send for the upcoming merge window.

Please let me know if I am missing something.

							Thanx, Paul
