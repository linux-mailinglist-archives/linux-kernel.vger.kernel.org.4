Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019356C925D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 06:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjCZEgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 00:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjCZEgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 00:36:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C600B776
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 21:36:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 959A160E9A
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 04:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51E8C433D2;
        Sun, 26 Mar 2023 04:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679805388;
        bh=FNpiQgQE2OURs7WljLvtMY+qFVWJkhCSD+wR3XCdK9s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AN+r6GMGB5bBMSFxZali1m7wJUEjQivpimQl23yLKTmz1uC9e+Cd1ZCCVvKg6dQYQ
         5d9oJR0/hCH5vn91NzJs4ChrWt7PNQFY/GizUAypMM044+6hAyHS9b/20DxZlU6meU
         0gu4IcFv5J5xjyF0+KRgWU/RDJ8X2pMgE+JnqyIXGod2xKtsqeK+yUyw/hPVBriInf
         wyesmI0R7XwyBiUS1qOW+FFMzJTUvdLtXAnlTZAXJ/g3CAuRdRP4aZ/myAWeJseWUF
         y3cNFUCCU27EF9GxRmzSUKMqIA2VXJUOYjJA+d7GqKvZ58ZujOgm0Fu+ySzl3BFWRX
         QLNUj3QjIquOw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7AAD91540431; Sat, 25 Mar 2023 21:36:28 -0700 (PDT)
Date:   Sat, 25 Mar 2023 21:36:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] tools/nolibc: add support for stack protector
Message-ID: <0d9bbc94-7ea2-4bc5-8523-29b100c0f1a1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230325154516.7995-1-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230325154516.7995-1-w@1wt.eu>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2023 at 04:45:08PM +0100, Willy Tarreau wrote:
> Hello Paul,
> 
> This is essentially Thomas' work so instead of paraphrasing his work,
> I'm pasting his description below. I've tested his changes on all
> supported archs, applied a tiny modification with his permission
> to continue to support passing CFLAGS, and for me this is all fine.
> In a short summary this adds support for stack protector to i386 and
> x86_64 in nolibc, and the accompanying test to the selftest program.
> 
> A new test category was added, "protection", which currently has a
> single test. Archs that support it will report "OK" there and those
> that do not will report "SKIPPED", as is already the case for tests
> that cannot be run.
> 
> This was applied on top of your dev.2023.03.20a branch. I'm reasonably
> confident with the nature of the changes, so if your queue for 6.4 is
> not closed yet, it can be a good target, otherwise 6.5 will be fine as
> well.

I have applied and pushed it out, thank you both!

We are a little late in the process, but if testing goes well, I can't
see why this cannot make the v6.4 merge window.

							Thanx, Paul

> Thanks in advance!
> Willy
> 
> Thomas' description below:
> 
> This is useful when using nolibc for security-critical tools.
> Using nolibc has the advantage that the code is easily auditable and
> sandboxable with seccomp as no unexpected syscalls are used.
> Using compiler-assistent stack protection provides another security
> mechanism.
> 
> For this to work the compiler and libc have to collaborate.
> 
> This patch adds the following parts to nolibc that are required by the
> compiler:
> 
> * __stack_chk_guard: random sentinel value
> * __stack_chk_fail: handler for detected stack smashes
> 
> In addition an initialization function is added that randomizes the
> sentinel value.
> 
> Only support for global guards is implemented.
> Register guards are useful in multi-threaded context which nolibc does
> not provide support for.
> 
> Link: https://lwn.net/Articles/584225/
> 
> 
> Thomas Weißschuh (8):
>   tools/nolibc: add definitions for standard fds
>   tools/nolibc: add helpers for wait() signal exits
>   tools/nolibc: tests: constify test_names
>   tools/nolibc: add support for stack protector
>   tools/nolibc: tests: fold in no-stack-protector cflags
>   tools/nolibc: tests: add test for -fstack-protector
>   tools/nolibc: i386: add stackprotector support
>   tools/nolibc: x86_64: add stackprotector support
> 
>  tools/include/nolibc/Makefile                |  4 +-
>  tools/include/nolibc/arch-i386.h             |  7 ++-
>  tools/include/nolibc/arch-x86_64.h           |  5 ++
>  tools/include/nolibc/nolibc.h                |  1 +
>  tools/include/nolibc/stackprotector.h        | 53 ++++++++++++++++
>  tools/include/nolibc/types.h                 |  2 +
>  tools/include/nolibc/unistd.h                |  5 ++
>  tools/testing/selftests/nolibc/Makefile      | 11 +++-
>  tools/testing/selftests/nolibc/nolibc-test.c | 64 +++++++++++++++++++-
>  9 files changed, 144 insertions(+), 8 deletions(-)
>  create mode 100644 tools/include/nolibc/stackprotector.h
> 
> -- 
> 2.17.5
> 
