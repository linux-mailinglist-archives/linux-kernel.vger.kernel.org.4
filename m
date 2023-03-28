Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E636CCA47
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 20:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjC1SwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 14:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjC1SwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 14:52:04 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08EBD2682
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 11:52:02 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 32SIpqUi005382;
        Tue, 28 Mar 2023 20:51:52 +0200
Date:   Tue, 28 Mar 2023 20:51:52 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 0/1] tools/nolibc: tests: use volatile to force stack
 smashing
Message-ID: <ZCM3SF+CySRKhGNv@1wt.eu>
References: <20230328161845.9584-1-w@1wt.eu>
 <d718db04-77b5-4358-9727-8196d4486f32@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d718db04-77b5-4358-9727-8196d4486f32@paulmck-laptop>
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 11:29:53AM -0700, Paul E. McKenney wrote:
> I have queued this for the v6.5 merge window, thank you!  If urgency
> does develop in the next couple of days, please let me know, and I will
> see what I can do about moving it to the v6.4 pile.

Thank you!

> I got this from "make run" (after merging with v6.3-rc3 as discussed
> earlier):
> 
> 	make[1]: Leaving directory '/home/git/linux-build'
> 	126 test(s) passed.
> 
> This differs from your results, so please see below for the run.out file.
> (I see 126 instances of "[OK]".)

Oh you're right! I indeed found no FAIL so it was OK for me and I didn't
pay attention but it's "just" a matter of message appearing on the console
in the middle of the test:

  $ diff -u paul.out willy.out  |less
  --- paul.out    2023-03-28 20:38:40.079920385 +0200
  +++ willy.out   2023-03-28 20:39:04.534900530 +0200
  @@ -130,11 +130,11 @@
   Errors during this test: 0
   
   Running test 'protection'
  -0 -fstackprotector                                               [OK]
  +0 -fstackprotector [    2.696920] init (47) used greatest stack depth: 14536 bytes left
  +                                              [OK]
   Errors during this test: 0

We've had a few occurrences of garbaged outputs like this, so I think I
should improve the test to count OK/FAIL/SKIPPED so that we can be more
confident in the output when seeing 0 FAIL for example. I suspect that
above it could be related to the long chain we've seen during the 6.3-rc1
crash, that went down into the random code, because probably that this
first-time initialization can enlarge the stack a little bit.

In my case, I just applied all the nolibc patches on top of 6.3-rc4 to
run the test so our kernels are slightly different (since my branch
based on rcu-03.20a did still originate from the 6.3-rc1 thus it was
failing to boot like you faced previously).

Maybe I should also improve the grep to try to look for patterns looking
exactly like this (test numer and name followed by a warning).

> But this from "make run-user":
> 
> 	  CC      nolibc-test
> 	124 test(s) passed
> 
> The output of "grep -v "\[OK]" run.out" is as follows:
> 
> 	Running test 'syscall'
> 	18 chroot_root                                                  [SKIPPED]
> 	43 link_dir                                                     [SKIPPED]
> 	Errors during this test: 0
> 
> 	Running test 'stdlib'
> 	Errors during this test: 0
> 
> 	Running test 'protection'
> 	Errors during this test: 0
> 
> 	Total number of errors: 0
> 	Exiting with status 0
> 
> I am guessing is that this is because I am too cowardly to run this
> test with root privileges, but thought I should run it by you.

Yes exactly, that's why I've added getuid() support lately, in order to
skip these two tests when not root (because I cowardly refuse to run
this test as root as well and don't want to get used to seeing "normal"
failures).

Thus what you're seeing is OK overall. There's just this message that
appears now on top of -rc4, I'll retry later on top of -rc3 (probably
not before this week-end, I'm still having other stuff to do), but so
far so good.

Thank you!
Willy
