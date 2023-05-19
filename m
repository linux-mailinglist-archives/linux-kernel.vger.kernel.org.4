Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC46709429
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjESJzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjESJzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:55:32 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BEC9EF0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 02:55:30 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 34J9eU7k025050;
        Fri, 19 May 2023 11:40:30 +0200
Date:   Fri, 19 May 2023 11:40:30 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] tools/nolibc: riscv: Fix up compile error for rv32
Message-ID: <20230519094030.GA24947@1wt.eu>
References: <cover.1684425792.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684425792.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhangjin,

On Fri, May 19, 2023 at 01:00:18AM +0800, Zhangjin Wu wrote:
> Hi, Willy
> 
> nolibc for riscv is only tested for rv64 currently (see
> tools/testing/selftests/nolibc/Makefile), this patchset tries to let it
> compile for rv32, but still not pass the nolibc selftest:
> 
> * The first patch uses lw/sw instead of ld/sd for rv32 and verse-vice for rv64
>     * This patch may conflict with the stackprotector patch [1], because
>       both of them changed the _start assembly in arch-riscv.h

That's quite embarrassing, I'm having to trace of that series here. Now
I can find it in my LKML archives, but I don't have the direct message and
didn't spot the other ones. I'll have to investigate, thanks for notifying
me! I'm CCing Thomas, I will check with him how to best merge the two.

> * The second patch adds __NR_llseek based sys_lseek implementation for rv32
>     * There is no __NR_lseek for rv32, see include/uapi/asm-generic/unistd.h
>     * This code is based on the version from glibc, sysdeps/unix/sysv/linux/lseek.c
>     * It passed the two lseek tests in nolibc selftest (write a test case manually)

OK.

> * To let it compile for rv32, we still need to apply one of such actions:
>     * Revert the kernel commit d4c08b9776b3 ("riscv: Use latest system call ABI"),
>       but it is not the right direction, that commit has removed all of the time32 syscalls,
>       and let C lib (e.g. glibc) provide the same C APIs based on the other time64 syscalls
> 
>     * If not really use any of the time32 syscalls, defining __ARCH_WANT_TIME32_SYSCALLS
>       macro will let it compile, but this is buggy for the current implmentations are based
>       on time32 syscalls!
> 
>     * Really implement the C APIs for rv32, based on the time64 syscalls, just like glibc.
>       This commit c8ce48f06503 ("asm-generic: Make time32 syscall numbers optional") shows
>       us which functions should be re-implemented.
> 
> So, the work todo for rv32 is:
> 
> * Rebasing all of the old time32 syscalls based C APIs on the new time64 syscalls,
>   but they are not simply mapped one by one, glibc is a good reference.
> 
> * Add standalone rv32 test support in tools/testing/selftests/nolibc/

I'm not the right one to judge how to best support rv32 but at least I just
don't want to go backwards. I'm just having a probably stupid question, but
how relevant is rv32 ? I mean, all the boards I've seen to date were based
on rv64 even the smallest embedded ones, so I'm sincerely wondering if there
exists at all any rv32 devices capable of running Linux. Because if that's
not the case, maybe we should instead declare that we only support rv64 ?
If such devices exist however, I'm all for us supporting them well.

Thanks,
Willy
