Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730056C092D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 04:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjCTDFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 23:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCTDFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 23:05:14 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD3C7A5E8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:05:11 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 32K352C5003205;
        Mon, 20 Mar 2023 04:05:02 +0100
Date:   Mon, 20 Mar 2023 04:05:02 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] tools/nolibc: always disable stack protector for
 tests
Message-ID: <ZBfNXlUBBB6c6Btw@1wt.eu>
References: <20230319135100.31952-1-w@1wt.eu>
 <5c2fdd86-4e6a-4f48-ab57-95a223f39e94@paulmck-laptop>
 <ZBdsZ61bt7aLdbSo@1wt.eu>
 <b8badcd8-44a0-4380-a5f1-381f058ea276@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8badcd8-44a0-4380-a5f1-381f058ea276@paulmck-laptop>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 04:54:53PM -0700, Paul E. McKenney wrote:
> On Sun, Mar 19, 2023 at 09:11:19PM +0100, Willy Tarreau wrote:
> > Hi Paul,
> > 
> > On Sun, Mar 19, 2023 at 11:05:15AM -0700, Paul E. McKenney wrote:
> > > Queued and pushed, thank you both!
> > 
> > Thank you!
> > 
> > > Just to make sure I understand, you would like me to add this to the
> > > serieses from Vincent, yourself, and Feiyang that are set up to go into
> > > the next merge window, correct?
> > > 
> > > If you instead would like me to push it to Linus directly into the v6.3
> > > release as a regression fix late this coming week, please let me know.
> > 
> > It would indeed be preferable for 6.3 as it fixes issues, but it's not
> > critical at all, just an annoyance for some developers. So if you have a
> > series of fixes pending to be sent soon, it would be nice to add it there.
> 
> Very well, here is what I currently have for nolibc, from newest to
> oldest:
> 
> 7712ec32cbda selftests/nolibc: Adjust indentation for Makefile
> 96218cfc79eb selftests/nolibc: Add support for LoongArch
> cab6bbd00f2a tools/nolibc: Add support for LoongArch
> 496921e4724c tools/nolibc: Add statx() and make stat() rely on statx() if necessary
> 97a15c47b98c tools/nolibc: Include linux/fcntl.h and remove duplicate code
> de06f2fe1aac tools/nolibc: check for S_I* macros before defining them
> 7fb54b517d44 selftests/nolibc: skip the chroot_root and link_dir tests when not privileged
> 296659c6e551 tools/nolibc: add getuid() and geteuid()
> bd9a87d64994 tools/nolibc: add tests for the integer limits in stdint.h
> 2d1813a7ef67 tools/nolibc: enlarge column width of tests
> 5dbcbb2da574 tools/nolibc: add integer types and integer limit macros
> 111bb94f67eb tools/nolibc: add stdint.h
> 2dbf8575b2da tools/nolibc: Add gitignore to avoid git complaints about sysroot
> 
> I will take the new commit, rebase it to precede the first of the above,
> so that the stack will look like this:
> 
> 7712ec32cbda selftests/nolibc: Adjust indentation for Makefile
> 96218cfc79eb selftests/nolibc: Add support for LoongArch
> cab6bbd00f2a tools/nolibc: Add support for LoongArch
> 496921e4724c tools/nolibc: Add statx() and make stat() rely on statx() if necessary
> 97a15c47b98c tools/nolibc: Include linux/fcntl.h and remove duplicate code
> de06f2fe1aac tools/nolibc: check for S_I* macros before defining them
> 7fb54b517d44 selftests/nolibc: skip the chroot_root and link_dir tests when not privileged
> 296659c6e551 tools/nolibc: add getuid() and geteuid()
> bd9a87d64994 tools/nolibc: add tests for the integer limits in stdint.h
> 2d1813a7ef67 tools/nolibc: enlarge column width of tests
> 5dbcbb2da574 tools/nolibc: add integer types and integer limit macros
> 111bb94f67eb tools/nolibc: add stdint.h
> 2dbf8575b2da tools/nolibc: Add gitignore to avoid git complaints about sysroot
> ???????????? tools/nolibc: always disable stack protector for tests
> 
> Then if tests, -next, and kernel test robot are kind, I will send a
> pull request to Linus for the "always disable stack protector for tests"
> commit.  The rest I send for the upcoming merge window.
> 
> Please let me know if I am missing something.

This is perfect, thank you very much, Paul!

Willy
