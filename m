Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCED6C9A4A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 05:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjC0Dle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 23:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjC0Dlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 23:41:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECBE3C3B
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 20:41:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A262260F91
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:41:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9D0C433D2;
        Mon, 27 Mar 2023 03:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679888489;
        bh=3kWWMiFdYWioPh97XETsY7EN3Qgvh9m0ERHUwWdk5zA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XdHgHv3lPUOkj/Ddw4eeEJwkzxZfqOeVAWS//UrBCt9Jixy09T2FoWkSMGNLdbq6m
         QqJqOTOtKzGc4DTgPqX5QuJz3GciAayerWNvzwcqg6BPKtw138X7Z4l5L6CN4QSgZl
         kWcjyfJvzYG5zN68eL2ylg0PGaI/0fjitULbjqwLC21o9vNKFfsUyhoztfjZxyZLik
         TyYsw2J7pK98y7xO281xUX5mfTGk/dO9UC1yIXMY0yTeNrOiWu901ieWWeEBU0o8B5
         g4tGsaJtKkw/bqOnehDLfr7fDc4d73tommIVzR5j/r01bRS0mqp4PCEb0xDTV8oOsy
         YirPidXU+L81w==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 682051540474; Sun, 26 Mar 2023 20:41:29 -0700 (PDT)
Date:   Sun, 26 Mar 2023 20:41:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] tools/nolibc: add support for stack protector
Message-ID: <d186bd6a-e8ed-4a89-875b-6a4406dd1fbc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <0d9bbc94-7ea2-4bc5-8523-29b100c0f1a1@paulmck-laptop>
 <a65340bb-2d11-445b-8595-9bf25a9f7a47@paulmck-laptop>
 <ZCBiDZfQW+YuiVNs@1wt.eu>
 <35a26245-0171-44b0-8072-325576768f91@paulmck-laptop>
 <ZCBkrOqWR7EVMeP/@1wt.eu>
 <d2c780bb-00ec-4966-87a2-d233f19032ab@paulmck-laptop>
 <ZCBsLQARaZBHeE4k@1wt.eu>
 <ZCBtOxqRJ9+P+G0z@1wt.eu>
 <ZCB5HZVbrjTM37Bd@1wt.eu>
 <8927157b-bf2c-46b7-a385-f4e230a4777d@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8927157b-bf2c-46b7-a385-f4e230a4777d@paulmck-laptop>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 11:00:26AM -0700, Paul E. McKenney wrote:
> On Sun, Mar 26, 2023 at 06:55:57PM +0200, Willy Tarreau wrote:
> > On Sun, Mar 26, 2023 at 06:05:15PM +0200, Willy Tarreau wrote:
> > > On Sun, Mar 26, 2023 at 06:00:45PM +0200, Willy Tarreau wrote:
> > > > On Sun, Mar 26, 2023 at 08:45:55AM -0700, Paul E. McKenney wrote:
> > > > > Glad I could "help"!  Timers.  Huh.  ;-)
> > > > > 
> > > > > Checking v6.2, though the rebase is a bit messy, so I won't be all
> > > > > that confident in the results.
> > > > 
> > > > I got the same as you now. I don't know what I missed before not to
> > > > face it, maybe it's the consequence of the rebase. I've re-applied
> > > > the patches on top of 6.2.8 and am retesting now.
> > > > 
> > > > I think you don't need to waste more of your time on this for now
> > > > since we have a reproducer. Thomas and I should take over.
> > > 
> > > And it's a 6.3 regression, as 6.2.8 works fine:
> > > 
> > >   $ make run
> > >   (...)
> > >   Kernel: arch/x86/boot/bzImage is ready  (#2)
> > >   make[1]: Leaving directory '/g/public/linux/master'
> > >   126 test(s) passed.
> > >   $ tail  run.out 
> > >   Errors during this test: 0
> > >   
> > >   Running test 'protection'
> > >   0 -fstackprotector                                               [OK]
> > >   Errors during this test: 0
> > >   
> > >   Total number of errors: 0
> > >   Leaving init with final status: 0
> > >   [    3.388706] ACPI: PM: Preparing to enter system sleep state S5
> > >   [    3.389424] reboot: Power down
> > > 
> > > Now let's have fun bisecting it!
> > 
> > So I have a good news, 6.3-rc1 which dev.2023.03.20a is based on, fails,
> > while 6.3-rc3 works. I haven't got further yet and am not sure it's useful
> > to dig further given that it's an already fixed problem that is not related
> > to the patches in your branch. I don't know if you usually rebase on more
> > recent tags though.
> 
> Thank you for chasing this down!
> 
> In this case, I will at the very least merge with v6.3 before testing.
> I have Joel Fernandes and Boqun Feng trying their hands at running
> the RCU pull request for v6.4, so I will probably resist the urge to
> inject confusion by rebasing onto v6.3-rc1.  ;-)

And merging the -rcu tree's "dev" branch with v6.3-rc3 got me a successful test:

	Kernel: arch/x86/boot/bzImage is ready  (#5)
	make[1]: Leaving directory '/home/git/linux-build'
	125 test(s) passed.

So looking good.  ;-)

								Thanx, Paul
