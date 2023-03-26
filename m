Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E9C6C96FD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 18:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjCZQ4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 12:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjCZQ4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 12:56:12 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 675794C1F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 09:56:07 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 32QGtv5B011131;
        Sun, 26 Mar 2023 18:55:57 +0200
Date:   Sun, 26 Mar 2023 18:55:57 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] tools/nolibc: add support for stack protector
Message-ID: <ZCB5HZVbrjTM37Bd@1wt.eu>
References: <20230325154516.7995-1-w@1wt.eu>
 <0d9bbc94-7ea2-4bc5-8523-29b100c0f1a1@paulmck-laptop>
 <a65340bb-2d11-445b-8595-9bf25a9f7a47@paulmck-laptop>
 <ZCBiDZfQW+YuiVNs@1wt.eu>
 <35a26245-0171-44b0-8072-325576768f91@paulmck-laptop>
 <ZCBkrOqWR7EVMeP/@1wt.eu>
 <d2c780bb-00ec-4966-87a2-d233f19032ab@paulmck-laptop>
 <ZCBsLQARaZBHeE4k@1wt.eu>
 <ZCBtOxqRJ9+P+G0z@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCBtOxqRJ9+P+G0z@1wt.eu>
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 06:05:15PM +0200, Willy Tarreau wrote:
> On Sun, Mar 26, 2023 at 06:00:45PM +0200, Willy Tarreau wrote:
> > On Sun, Mar 26, 2023 at 08:45:55AM -0700, Paul E. McKenney wrote:
> > > Glad I could "help"!  Timers.  Huh.  ;-)
> > > 
> > > Checking v6.2, though the rebase is a bit messy, so I won't be all
> > > that confident in the results.
> > 
> > I got the same as you now. I don't know what I missed before not to
> > face it, maybe it's the consequence of the rebase. I've re-applied
> > the patches on top of 6.2.8 and am retesting now.
> > 
> > I think you don't need to waste more of your time on this for now
> > since we have a reproducer. Thomas and I should take over.
> 
> And it's a 6.3 regression, as 6.2.8 works fine:
> 
>   $ make run
>   (...)
>   Kernel: arch/x86/boot/bzImage is ready  (#2)
>   make[1]: Leaving directory '/g/public/linux/master'
>   126 test(s) passed.
>   $ tail  run.out 
>   Errors during this test: 0
>   
>   Running test 'protection'
>   0 -fstackprotector                                               [OK]
>   Errors during this test: 0
>   
>   Total number of errors: 0
>   Leaving init with final status: 0
>   [    3.388706] ACPI: PM: Preparing to enter system sleep state S5
>   [    3.389424] reboot: Power down
> 
> Now let's have fun bisecting it!

So I have a good news, 6.3-rc1 which dev.2023.03.20a is based on, fails,
while 6.3-rc3 works. I haven't got further yet and am not sure it's useful
to dig further given that it's an already fixed problem that is not related
to the patches in your branch. I don't know if you usually rebase on more
recent tags though.

Willy
