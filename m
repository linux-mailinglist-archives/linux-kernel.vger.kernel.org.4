Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE6A6D6E48
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 22:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236245AbjDDUqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 16:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236087AbjDDUql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 16:46:41 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 980EB4C10
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 13:46:30 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 334KkNIw015876;
        Tue, 4 Apr 2023 22:46:23 +0200
Date:   Tue, 4 Apr 2023 22:46:23 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] tools/nolibc: add testcases for vfprintf
Message-ID: <ZCyMn5VCyzYXgfIG@1wt.eu>
References: <20230402184806.12440-1-w@1wt.eu>
 <530708ce-92af-41ad-84da-a691a518852b@paulmck-laptop>
 <eec66609-4baa-4412-863e-5beb704982d2@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eec66609-4baa-4412-863e-5beb704982d2@paulmck-laptop>
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 01:40:32PM -0700, Paul E. McKenney wrote:
> On Sun, Apr 02, 2023 at 02:24:04PM -0700, Paul E. McKenney wrote:
> > On Sun, Apr 02, 2023 at 08:48:02PM +0200, Willy Tarreau wrote:
> > > Hello Paul,
> > > 
> > > Thomas added new tests for vfprintf(), which is a good idea because it
> > > was a new implementation, we use it a lot in the tests so we'd rather
> > > make sure it works! This required to implement support for memfd_create()
> > > that is used to collect the output into a buffer, as well as to complete
> > > a little bit the minimalistic FILE emulation with fileno(), fdopen(),
> > > fflush() and fclose(). The result is neat and works equally on glibc and
> > > nolibc. We just had to cheat on the pointer test because for NULL nolibc
> > > prints "0x0" while glibc prints "(nil)" so we check 0x1 instead to avoid
> > > this special case.
> > > 
> > > Finally Thomas added a new target to the makefile to ease building the
> > > test against the default libc. This should help detect incompatibilities
> > > when new features are added.
> > > 
> > > I've tested it locally with my libc and against all supported architectures
> > > (userland tests only), and all tests passed.
> > > 
> > > This can be added to your dev tree for 6.5 on top of the previous series.
> > 
> > Looks like some useful code to make testing more comprehensive, thank
> > you both!  Queued and pushed.
> 
> And finally tested:
> 
> Kernel: arch/x86/boot/bzImage is ready  (#7)
> make[1]: Leaving directory '/home/git/linux-build'
> 133 test(s) passed.
> 
>   CC      nolibc-test
> 133 test(s) passed.
> 
> So good agreement between user and kernel, anyway.  Usermode tests
> note that two of the tests are skipped (chroot_root and link_blah).
> Kernelmode tests all say "[OK]".

This is perfect, thank you Paul!

Eventually I'll clean up my test script I use to build and test for all
archs, and commit it to help with such testing.

thanks!
Willy
