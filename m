Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803FA663009
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237391AbjAITMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237619AbjAITMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:12:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC1813DF7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 11:11:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FDF361349
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 19:11:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BAEC433F0;
        Mon,  9 Jan 2023 19:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673291501;
        bh=TeyhFwGi/frdTtjyAeMDCtCBhJgN1d2nRyVR89UsjgM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=EogoYlqt+AN30++TKdt2qvkfZu0WlXbPTUKZsEBtbeAOkvTEKrbjYoRjwZBlhv73v
         af4rwwQQUofvjDHFtYRQkrVAVfRLr+LPUhppgx+iV5AgP7eshq2FHDQ8xzo0C1MquV
         WPRx5z+z3hdCaWpIQjLCYmqlf8tX8SL2nPoSW56NG+UNVTvBRAMOEkYqSW+4cZYZnf
         MJpqLKy1uZua2j+EbIjIZUHEoa2LCOlznhdQabZQkUbPQ/t8l8JjLqEGhmmLomj3Vn
         GM0JlDegPyPHTR0mC/ZPi3fMHkhJvct+phC4B3xzr8/DXdp8cUE6kxJE6yL7IlHPv5
         oBo9wwVlfF6ZA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 826225C05C8; Mon,  9 Jan 2023 11:11:41 -0800 (PST)
Date:   Mon, 9 Jan 2023 11:11:41 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org, Warner Losh <imp@bsdimp.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH 0/6] pending bug fixes for nolibc
Message-ID: <20230109191141.GT4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230109075442.25963-1-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109075442.25963-1-w@1wt.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 08:54:36AM +0100, Willy Tarreau wrote:
> Hello Paul,
> 
> please consider the current patch series for merging into your fixes queue.
> The intent is to get them before 6.2, then backported where relevant.
> 
> It addresses the following bugs:
>   - fd_set was incorrectly defined as arrays of u32 instead of long,
>     which breaks BE64. Fix courtesy of Sven Schnelle.
> 
>   - S_ISxxx macros were incorrectly testing the bits after applying them
>     instead of applying S_ISFMT to the value. Fix from Warner Losh.
> 
>   - the mips code was randomly broken due to an unprotected "noreorder"
>     directive in the _start code that would prevent the assembler from
>     filling delayed slots, and randomly leaving other instructions there
> 
>   - since the split of the single include file into multiple files, we're
>     implicitly refraining from including some which are not explicitly
>     added in the code. It causes build failures when such files contain
>     definitions for functions that may be used e.g. by libgcc, such as
>     raise() or memset(), which are often called only by a few archs at
>     certain optimization levels only.
> 
>   - gcc 11.3 in ARM thumb2 mode at -O2 was able to recognize a memset()
>     construction inside the memset() definition, and it replaced it with
>     a call to... memset(). We cannot impose to userland to build with
>     -ffreestanding so the introduction of an empty asm() statement in
>     the loop was enough to stop this.
> 
>   - most of the O_* macros were wrong on RISCV because their octal value
>     was used as a hexadecimal one when the platform was introduced. This
>     was revealed by the selftest breaking in getdents64().
> 
> The series was tested on x86_64, i386, armv5, armv7, thumb1, thumb2,
> mips and riscv, all at -O0, -Os and -O3. This is based on the "nolibc"
> branch of your linux-rcu tree. Do not hesitate to let me know if you
> prefer that I rebase it on a different one.

"81 test(s) passed", so queued at urgent-nolibc.2023.01.09a, thank you!

Also, thank you for the detailed cover letter, which I co-opted into the
signed tag.  But please check to make sure that my wordsmithing didn't
break anything.

If all goes well, I will send the pull request to Linus before the end
of this week.

							Thanx, Paul

> Thank you!
> Willy
> 
> ---
> Sven Schnelle (1):
>   nolibc: fix fd_set type
> 
> Warner Losh (1):
>   tools/nolibc: Fix S_ISxxx macros
> 
> Willy Tarreau (4):
>   tools/nolibc: restore mips branch ordering in the _start block
>   tools/nolibc: fix missing includes causing build issues at -O0
>   tools/nolibc: prevent gcc from making memset() loop over itself
>   tools/nolibc: fix the O_* fcntl/open macro definitions for riscv
> 
>  tools/include/nolibc/arch-mips.h  |  2 +
>  tools/include/nolibc/arch-riscv.h | 14 +++----
>  tools/include/nolibc/ctype.h      |  3 ++
>  tools/include/nolibc/errno.h      |  3 ++
>  tools/include/nolibc/signal.h     |  3 ++
>  tools/include/nolibc/stdio.h      |  3 ++
>  tools/include/nolibc/stdlib.h     |  3 ++
>  tools/include/nolibc/string.h     |  8 +++-
>  tools/include/nolibc/sys.h        |  2 +
>  tools/include/nolibc/time.h       |  3 ++
>  tools/include/nolibc/types.h      | 70 ++++++++++++++++++-------------
>  tools/include/nolibc/unistd.h     |  3 ++
>  12 files changed, 79 insertions(+), 38 deletions(-)
> 
> -- 
> 2.35.3
> 
