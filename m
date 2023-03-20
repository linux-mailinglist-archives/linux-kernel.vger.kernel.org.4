Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5718A6C1CB1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjCTQuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbjCTQt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:49:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F8A28EB5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:42:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF102616F2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:41:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA93C433EF;
        Mon, 20 Mar 2023 16:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679330494;
        bh=lN/KIewXkXIxyysAXNK65g3bJDzRG2lqUTNvfeaMf4o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QWFoDCsklTTvKolrKhwK6yxMLGkJwgjnCBzaJYnT7to6XmhSN4IpQEHbw5C2db6PM
         wxfkDhjlvqt982abOB1XaCj64Nkn0Ov/m/grlCVAeGtg90CWNV3H3Pw4iZmtE/iAOi
         EoeTRpBw5DbON2BA7FrZzDnBTgRmM70JcfTom0yJuTOOT6nSD3PgZsVVbNZ6kU2lOK
         SI+d0KXwml4I+moge7ZWw8mmPIUnDSfABd2erR3SKAlBS1Tizq2phGqcbMS8vcTOQu
         EQ2rU69GEH2ZM8E8NgMLLNGGKhMHgLI0OIDC7bUaCad+9VZd15QqLnM+OeOW7NUwSn
         kJMxLmkLyM8Yg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C44C71540395; Mon, 20 Mar 2023 09:41:33 -0700 (PDT)
Date:   Mon, 20 Mar 2023 09:41:33 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] tools/nolibc: always disable stack protector for
 tests
Message-ID: <c6ed0408-a84e-4950-9259-3807d352f9a7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230319135100.31952-1-w@1wt.eu>
 <5c2fdd86-4e6a-4f48-ab57-95a223f39e94@paulmck-laptop>
 <ZBdsZ61bt7aLdbSo@1wt.eu>
 <b8badcd8-44a0-4380-a5f1-381f058ea276@paulmck-laptop>
 <ZBfNXlUBBB6c6Btw@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBfNXlUBBB6c6Btw@1wt.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 04:05:02AM +0100, Willy Tarreau wrote:
> On Sun, Mar 19, 2023 at 04:54:53PM -0700, Paul E. McKenney wrote:
> > On Sun, Mar 19, 2023 at 09:11:19PM +0100, Willy Tarreau wrote:
> > > Hi Paul,
> > > 
> > > On Sun, Mar 19, 2023 at 11:05:15AM -0700, Paul E. McKenney wrote:
> > > > Queued and pushed, thank you both!
> > > 
> > > Thank you!
> > > 
> > > > Just to make sure I understand, you would like me to add this to the
> > > > serieses from Vincent, yourself, and Feiyang that are set up to go into
> > > > the next merge window, correct?
> > > > 
> > > > If you instead would like me to push it to Linus directly into the v6.3
> > > > release as a regression fix late this coming week, please let me know.
> > > 
> > > It would indeed be preferable for 6.3 as it fixes issues, but it's not
> > > critical at all, just an annoyance for some developers. So if you have a
> > > series of fixes pending to be sent soon, it would be nice to add it there.
> > 
> > Very well, here is what I currently have for nolibc, from newest to
> > oldest:
> > 
> > 7712ec32cbda selftests/nolibc: Adjust indentation for Makefile
> > 96218cfc79eb selftests/nolibc: Add support for LoongArch
> > cab6bbd00f2a tools/nolibc: Add support for LoongArch
> > 496921e4724c tools/nolibc: Add statx() and make stat() rely on statx() if necessary
> > 97a15c47b98c tools/nolibc: Include linux/fcntl.h and remove duplicate code
> > de06f2fe1aac tools/nolibc: check for S_I* macros before defining them
> > 7fb54b517d44 selftests/nolibc: skip the chroot_root and link_dir tests when not privileged
> > 296659c6e551 tools/nolibc: add getuid() and geteuid()
> > bd9a87d64994 tools/nolibc: add tests for the integer limits in stdint.h
> > 2d1813a7ef67 tools/nolibc: enlarge column width of tests
> > 5dbcbb2da574 tools/nolibc: add integer types and integer limit macros
> > 111bb94f67eb tools/nolibc: add stdint.h
> > 2dbf8575b2da tools/nolibc: Add gitignore to avoid git complaints about sysroot
> > 
> > I will take the new commit, rebase it to precede the first of the above,
> > so that the stack will look like this:
> > 
> > 7712ec32cbda selftests/nolibc: Adjust indentation for Makefile
> > 96218cfc79eb selftests/nolibc: Add support for LoongArch
> > cab6bbd00f2a tools/nolibc: Add support for LoongArch
> > 496921e4724c tools/nolibc: Add statx() and make stat() rely on statx() if necessary
> > 97a15c47b98c tools/nolibc: Include linux/fcntl.h and remove duplicate code
> > de06f2fe1aac tools/nolibc: check for S_I* macros before defining them
> > 7fb54b517d44 selftests/nolibc: skip the chroot_root and link_dir tests when not privileged
> > 296659c6e551 tools/nolibc: add getuid() and geteuid()
> > bd9a87d64994 tools/nolibc: add tests for the integer limits in stdint.h
> > 2d1813a7ef67 tools/nolibc: enlarge column width of tests
> > 5dbcbb2da574 tools/nolibc: add integer types and integer limit macros
> > 111bb94f67eb tools/nolibc: add stdint.h
> > 2dbf8575b2da tools/nolibc: Add gitignore to avoid git complaints about sysroot
> > ???????????? tools/nolibc: always disable stack protector for tests
> > 
> > Then if tests, -next, and kernel test robot are kind, I will send a
> > pull request to Linus for the "always disable stack protector for tests"
> > commit.  The rest I send for the upcoming merge window.
> > 
> > Please let me know if I am missing something.
> 
> This is perfect, thank you very much, Paul!

Done!

							Thanx, Paul
