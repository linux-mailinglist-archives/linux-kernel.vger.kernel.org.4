Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63D86D6E2E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 22:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbjDDUki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 16:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjDDUkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 16:40:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8550035B1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 13:40:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 127BA63991
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 20:40:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71034C433D2;
        Tue,  4 Apr 2023 20:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680640833;
        bh=GZzrd7gOa64jUTIaoFzxbHp98pGdRRFmB1z7I0zLUA0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HFAZpygRHcIFM/maQyUZ3a+oraiiZQDkpB4gl8mwrnlo7CCTzuMakoTwL5XpBEdYz
         c8RoE5bfUvqguQX/tU7u40iWQBQa/YLR3pF2dr7i7mZIh+SHe+P5FYP25QEeuuY4o7
         Lx2Rq8HOODG98+jGE7tnpcUiCP1GM78VeDebe6s9bXzAkE4t3AvSsDqBguOSgJ6XMj
         G5rqW2MuGOCtcUe1oYeq1s3+oNu4tLXhwnIL59+9sn/sLgPugpuXE9R5KFAnw28KAc
         jczlyx8ump/BBAqcF+hF3ygvmn1ue7KdLXZDUNTqmJIbosQ2yy9G6m9DmpN5xC81VF
         8ibuhwbm5GM4A==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 04D0015404B4; Tue,  4 Apr 2023 13:40:33 -0700 (PDT)
Date:   Tue, 4 Apr 2023 13:40:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] tools/nolibc: add testcases for vfprintf
Message-ID: <eec66609-4baa-4412-863e-5beb704982d2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230402184806.12440-1-w@1wt.eu>
 <530708ce-92af-41ad-84da-a691a518852b@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <530708ce-92af-41ad-84da-a691a518852b@paulmck-laptop>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2023 at 02:24:04PM -0700, Paul E. McKenney wrote:
> On Sun, Apr 02, 2023 at 08:48:02PM +0200, Willy Tarreau wrote:
> > Hello Paul,
> > 
> > Thomas added new tests for vfprintf(), which is a good idea because it
> > was a new implementation, we use it a lot in the tests so we'd rather
> > make sure it works! This required to implement support for memfd_create()
> > that is used to collect the output into a buffer, as well as to complete
> > a little bit the minimalistic FILE emulation with fileno(), fdopen(),
> > fflush() and fclose(). The result is neat and works equally on glibc and
> > nolibc. We just had to cheat on the pointer test because for NULL nolibc
> > prints "0x0" while glibc prints "(nil)" so we check 0x1 instead to avoid
> > this special case.
> > 
> > Finally Thomas added a new target to the makefile to ease building the
> > test against the default libc. This should help detect incompatibilities
> > when new features are added.
> > 
> > I've tested it locally with my libc and against all supported architectures
> > (userland tests only), and all tests passed.
> > 
> > This can be added to your dev tree for 6.5 on top of the previous series.
> 
> Looks like some useful code to make testing more comprehensive, thank
> you both!  Queued and pushed.

And finally tested:

Kernel: arch/x86/boot/bzImage is ready  (#7)
make[1]: Leaving directory '/home/git/linux-build'
133 test(s) passed.

  CC      nolibc-test
133 test(s) passed.

So good agreement between user and kernel, anyway.  Usermode tests
note that two of the tests are skipped (chroot_root and link_blah).
Kernelmode tests all say "[OK]".

							Thanx, Paul
