Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D412B6CCB29
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 22:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjC1UBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 16:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjC1UBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 16:01:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8B83C29
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 13:01:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3F3061425
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 20:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107B1C433D2;
        Tue, 28 Mar 2023 20:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680033688;
        bh=l3MwakMuJB7Jap9XpZ0gvsNoqC2UXLPrd2621jfFRUI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HT7dPA4PEnrqIjMiZ0ISIlzseR7NF61eT9LUf5L0fVcMUpu86xeBkCDCDwK2cOJx+
         P467QuvP4/ej16WZg2ucLQnqIFJsX9b3sIInyD6cvcZlb0LVFCsNBSnTThrI7lSFZe
         TfFoCocQZRJM9N3iMZq6SP/2nzBjkwG9+iYl+zeBFbklLQPt7cBQ3s555VPIiSlNCu
         8fx4J8BrlvGdUH0BCmjFfjdTzTunEam//n+5DC+czVq/X0hO3juzstIghQfALww2hE
         WB6SZpvSZ+BdC1ecZ5PWhhspFGesje46K5RsGgBwcm1Sa//YoXAVByfDyMBDykZ9to
         UiFUhlO1RL9+Q==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 917B71540479; Tue, 28 Mar 2023 13:01:27 -0700 (PDT)
Date:   Tue, 28 Mar 2023 13:01:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 0/1] tools/nolibc: tests: use volatile to force stack
 smashing
Message-ID: <eaff1b76-d420-47ac-8d84-89d01b3cab76@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230328161845.9584-1-w@1wt.eu>
 <d718db04-77b5-4358-9727-8196d4486f32@paulmck-laptop>
 <ZCM3SF+CySRKhGNv@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCM3SF+CySRKhGNv@1wt.eu>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 08:51:52PM +0200, Willy Tarreau wrote:
> On Tue, Mar 28, 2023 at 11:29:53AM -0700, Paul E. McKenney wrote:
> > I have queued this for the v6.5 merge window, thank you!  If urgency
> > does develop in the next couple of days, please let me know, and I will
> > see what I can do about moving it to the v6.4 pile.
> 
> Thank you!
> 
> > I got this from "make run" (after merging with v6.3-rc3 as discussed
> > earlier):
> > 
> > 	make[1]: Leaving directory '/home/git/linux-build'
> > 	126 test(s) passed.
> > 
> > This differs from your results, so please see below for the run.out file.
> > (I see 126 instances of "[OK]".)
> 
> Oh you're right! I indeed found no FAIL so it was OK for me and I didn't
> pay attention but it's "just" a matter of message appearing on the console
> in the middle of the test:
> 
>   $ diff -u paul.out willy.out  |less
>   --- paul.out    2023-03-28 20:38:40.079920385 +0200
>   +++ willy.out   2023-03-28 20:39:04.534900530 +0200
>   @@ -130,11 +130,11 @@
>    Errors during this test: 0
>    
>    Running test 'protection'
>   -0 -fstackprotector                                               [OK]
>   +0 -fstackprotector [    2.696920] init (47) used greatest stack depth: 14536 bytes left
>   +                                              [OK]
>    Errors during this test: 0
> 
> We've had a few occurrences of garbaged outputs like this, so I think I
> should improve the test to count OK/FAIL/SKIPPED so that we can be more
> confident in the output when seeing 0 FAIL for example. I suspect that
> above it could be related to the long chain we've seen during the 6.3-rc1
> crash, that went down into the random code, because probably that this
> first-time initialization can enlarge the stack a little bit.
> 
> In my case, I just applied all the nolibc patches on top of 6.3-rc4 to
> run the test so our kernels are slightly different (since my branch
> based on rcu-03.20a did still originate from the 6.3-rc1 thus it was
> failing to boot like you faced previously).
> 
> Maybe I should also improve the grep to try to look for patterns looking
> exactly like this (test numer and name followed by a warning).

Good point!

> > But this from "make run-user":
> > 
> > 	  CC      nolibc-test
> > 	124 test(s) passed
> > 
> > The output of "grep -v "\[OK]" run.out" is as follows:
> > 
> > 	Running test 'syscall'
> > 	18 chroot_root                                                  [SKIPPED]
> > 	43 link_dir                                                     [SKIPPED]
> > 	Errors during this test: 0
> > 
> > 	Running test 'stdlib'
> > 	Errors during this test: 0
> > 
> > 	Running test 'protection'
> > 	Errors during this test: 0
> > 
> > 	Total number of errors: 0
> > 	Exiting with status 0
> > 
> > I am guessing is that this is because I am too cowardly to run this
> > test with root privileges, but thought I should run it by you.
> 
> Yes exactly, that's why I've added getuid() support lately, in order to
> skip these two tests when not root (because I cowardly refuse to run
> this test as root as well and don't want to get used to seeing "normal"
> failures).
> 
> Thus what you're seeing is OK overall. There's just this message that
> appears now on top of -rc4, I'll retry later on top of -rc3 (probably
> not before this week-end, I'm still having other stuff to do), but so
> far so good.

Thank you for looking this over!

							Thanx, Paul
