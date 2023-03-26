Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94516C963A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 17:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjCZPqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 11:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCZPqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 11:46:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A277284
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 08:45:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7DF8BB80C73
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 15:45:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D05C433D2;
        Sun, 26 Mar 2023 15:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679845556;
        bh=t0pBaVbRCosgS5MaUeIK83gEMEWZnIjnMM5Dh/mispI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YC5uzTFSVg8GLFP1LF3xdWZ67v5JgVbVjOjiP9y27/ho65/BcymbyQTLZeibrTBKM
         7uX2IFWZhWlJlhVMWryEEZXG5M/Yzu8IVjAdoZHt3nkQrjSW+OvVTAqriY7fpkoOX5
         RlvQa+HrbDfnncwGJLKXwpVcWJWD9BbZjKRLDHNYIKDY4YfUxMDyWOsLtEllvKaSjL
         UXFHE9d0uGUGr7L+h5UYXiDxYbo08c8SDkyuUZTT85eAdlpmbvG0/rF2tqE+ruQolu
         6zSgYGPoEYFS4NE40jZK1daz7l0sp6nv7mhK+T99trJ6J0NHTUJ3xWVqlbL2UEp56M
         dxK5odDift4vQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 920891540474; Sun, 26 Mar 2023 08:45:55 -0700 (PDT)
Date:   Sun, 26 Mar 2023 08:45:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] tools/nolibc: add support for stack protector
Message-ID: <d2c780bb-00ec-4966-87a2-d233f19032ab@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230325154516.7995-1-w@1wt.eu>
 <0d9bbc94-7ea2-4bc5-8523-29b100c0f1a1@paulmck-laptop>
 <a65340bb-2d11-445b-8595-9bf25a9f7a47@paulmck-laptop>
 <ZCBiDZfQW+YuiVNs@1wt.eu>
 <35a26245-0171-44b0-8072-325576768f91@paulmck-laptop>
 <ZCBkrOqWR7EVMeP/@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCBkrOqWR7EVMeP/@1wt.eu>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 05:28:44PM +0200, Willy Tarreau wrote:
> On Sun, Mar 26, 2023 at 08:26:32AM -0700, Paul E. McKenney wrote:
> > On Sun, Mar 26, 2023 at 05:17:33PM +0200, Willy Tarreau wrote:
> > > On Sun, Mar 26, 2023 at 08:13:48AM -0700, Paul E. McKenney wrote:
> > > > On Sat, Mar 25, 2023 at 09:36:28PM -0700, Paul E. McKenney wrote:
> > > > > On Sat, Mar 25, 2023 at 04:45:08PM +0100, Willy Tarreau wrote:
> > > > > > Hello Paul,
> > > > > > 
> > > > > > This is essentially Thomas' work so instead of paraphrasing his work,
> > > > > > I'm pasting his description below. I've tested his changes on all
> > > > > > supported archs, applied a tiny modification with his permission
> > > > > > to continue to support passing CFLAGS, and for me this is all fine.
> > > > > > In a short summary this adds support for stack protector to i386 and
> > > > > > x86_64 in nolibc, and the accompanying test to the selftest program.
> > > > > > 
> > > > > > A new test category was added, "protection", which currently has a
> > > > > > single test. Archs that support it will report "OK" there and those
> > > > > > that do not will report "SKIPPED", as is already the case for tests
> > > > > > that cannot be run.
> > > > > > 
> > > > > > This was applied on top of your dev.2023.03.20a branch. I'm reasonably
> > > > > > confident with the nature of the changes, so if your queue for 6.4 is
> > > > > > not closed yet, it can be a good target, otherwise 6.5 will be fine as
> > > > > > well.
> > > > > 
> > > > > I have applied and pushed it out, thank you both!
> > > > > 
> > > > > We are a little late in the process, but if testing goes well, I can't
> > > > > see why this cannot make the v6.4 merge window.
> > > > 
> > > > And "make run-user" says "124 test(s) passed", which looks promising.
> > > 
> > > Indeed!
> > > 
> > > > But "make run" says "0 test(s) passed".
> > > > 
> > > > (They initially both said "0 test(s) passed", but that was because I
> > > > forgot to build qemu-x86_64 after an upgrade.)
> > > > 
> > > > Please see below for the full output of "make run".  Am I missing
> > > > some other package?
> > > 
> > > Hmmm I think that the output of run.out will be needed here. We'll
> > > need to understand whether it fails to boot the kernel or to start
> > > the executable.
> > 
> > Ah, I knew I was forgetting something!
> > 
> > I am retrying the test after rebasing Thomas's latest series directly
> > on top of the rest of the nolibc patches.
> > 
> > In the meantime, the kernel died as shown below.
> 
> Ah "great", that's a good reason. I predicted that one day this test
> would detect a kernel bug, we're here now ;-)

Glad I could "help"!  Timers.  Huh.  ;-)

Checking v6.2, though the rebase is a bit messy, so I won't be all
that confident in the results.

							Thanx, Paul
