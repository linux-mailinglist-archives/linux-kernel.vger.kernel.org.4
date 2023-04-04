Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F306D6E59
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 22:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbjDDUsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 16:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjDDUsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 16:48:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE849AC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 13:48:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E6F961F69
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 20:48:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D45C433D2;
        Tue,  4 Apr 2023 20:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680641316;
        bh=6hyqS48w9JFhBbwNOamIBNjav2KFQCOfy5UD/mrBZY8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VGTRIsNNgviwMaBhbUjKq8r5r3oOIzifYVy8oqKqYx7EuZCYUOafZ0NSdGjPG8FLM
         beQcdn98zSS9V5hWE9kXw6Iiuhc+zAC5sHZrei0/Wy3EmSS1SABSFM3Zl1KhZDi4wK
         htQHka6VgE8Co6d/0j32IF5S+lOGdLd6zqjRoysgVShnyq3D012EyIlpePxWe0kVV6
         d8che5sVVEPmKmaviILjr3xmfSJoyyFhkMNeKZyzWpxhOPfQ//eRRQJJoIKcozBA0/
         ih3q4e6e381dg+6/D7ULk4gYuj1tJSI0doMbS3DYyb1h/NzYJDqfMVGadACZV540S2
         Vib7l00WxYXpg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6D0B115404B4; Tue,  4 Apr 2023 13:48:36 -0700 (PDT)
Date:   Tue, 4 Apr 2023 13:48:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] tools/nolibc: add testcases for vfprintf
Message-ID: <3d05e613-d7a7-4d21-ac4d-2450613b4836@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230402184806.12440-1-w@1wt.eu>
 <530708ce-92af-41ad-84da-a691a518852b@paulmck-laptop>
 <eec66609-4baa-4412-863e-5beb704982d2@paulmck-laptop>
 <ZCyMn5VCyzYXgfIG@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCyMn5VCyzYXgfIG@1wt.eu>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 10:46:23PM +0200, Willy Tarreau wrote:
> On Tue, Apr 04, 2023 at 01:40:32PM -0700, Paul E. McKenney wrote:
> > On Sun, Apr 02, 2023 at 02:24:04PM -0700, Paul E. McKenney wrote:
> > > On Sun, Apr 02, 2023 at 08:48:02PM +0200, Willy Tarreau wrote:
> > > > Hello Paul,
> > > > 
> > > > Thomas added new tests for vfprintf(), which is a good idea because it
> > > > was a new implementation, we use it a lot in the tests so we'd rather
> > > > make sure it works! This required to implement support for memfd_create()
> > > > that is used to collect the output into a buffer, as well as to complete
> > > > a little bit the minimalistic FILE emulation with fileno(), fdopen(),
> > > > fflush() and fclose(). The result is neat and works equally on glibc and
> > > > nolibc. We just had to cheat on the pointer test because for NULL nolibc
> > > > prints "0x0" while glibc prints "(nil)" so we check 0x1 instead to avoid
> > > > this special case.
> > > > 
> > > > Finally Thomas added a new target to the makefile to ease building the
> > > > test against the default libc. This should help detect incompatibilities
> > > > when new features are added.
> > > > 
> > > > I've tested it locally with my libc and against all supported architectures
> > > > (userland tests only), and all tests passed.
> > > > 
> > > > This can be added to your dev tree for 6.5 on top of the previous series.
> > > 
> > > Looks like some useful code to make testing more comprehensive, thank
> > > you both!  Queued and pushed.
> > 
> > And finally tested:
> > 
> > Kernel: arch/x86/boot/bzImage is ready  (#7)
> > make[1]: Leaving directory '/home/git/linux-build'
> > 133 test(s) passed.
> > 
> >   CC      nolibc-test
> > 133 test(s) passed.
> > 
> > So good agreement between user and kernel, anyway.  Usermode tests
> > note that two of the tests are skipped (chroot_root and link_blah).
> > Kernelmode tests all say "[OK]".
> 
> This is perfect, thank you Paul!
> 
> Eventually I'll clean up my test script I use to build and test for all
> archs, and commit it to help with such testing.

Thank you for confirming the test results!

							Thanx, Paul
