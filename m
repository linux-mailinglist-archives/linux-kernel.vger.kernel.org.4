Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CAF6C960D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 17:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjCZPN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 11:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjCZPN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 11:13:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CFF6198
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 08:13:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9301FB80B72
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 15:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A767C433D2;
        Sun, 26 Mar 2023 15:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679843629;
        bh=9jj/64akHwjgxVYTXCDlX40+KI/02CvyR4nC7e0Pb2A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Ub9ytD0HoaERs7v4PGncimjtewdwTCzWptYKZ+36Wuq3Y9+Cc5UKy4UPjI/SSpv5F
         KpsBUsqkmUsB1CRmbx4o3xKJfsGOQeH0mF0vJM2jQKSgSr9RaDFSSbcjfY3gqrYqzM
         jkahxqw/H0D+v3y0idrfsu3YKa03QgJqEwrzysiRzC30vQQPMZeALDNVZ60AhrfoF3
         YmMqADJ81tgv5t6yq2vUGnCeAVr3poNBLGs3O0UIGFr7e2FSD87I8+rVP5TwkgCHjz
         WoPZ1hunVJT3wWbSY4lR2Y7jlLwgiEQdkowKxh/DlMJXSCnQ8F4oJHwh322fhusFU+
         yXA4QfdnRAoCA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A57891540431; Sun, 26 Mar 2023 08:13:48 -0700 (PDT)
Date:   Sun, 26 Mar 2023 08:13:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] tools/nolibc: add support for stack protector
Message-ID: <a65340bb-2d11-445b-8595-9bf25a9f7a47@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230325154516.7995-1-w@1wt.eu>
 <0d9bbc94-7ea2-4bc5-8523-29b100c0f1a1@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d9bbc94-7ea2-4bc5-8523-29b100c0f1a1@paulmck-laptop>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2023 at 09:36:28PM -0700, Paul E. McKenney wrote:
> On Sat, Mar 25, 2023 at 04:45:08PM +0100, Willy Tarreau wrote:
> > Hello Paul,
> > 
> > This is essentially Thomas' work so instead of paraphrasing his work,
> > I'm pasting his description below. I've tested his changes on all
> > supported archs, applied a tiny modification with his permission
> > to continue to support passing CFLAGS, and for me this is all fine.
> > In a short summary this adds support for stack protector to i386 and
> > x86_64 in nolibc, and the accompanying test to the selftest program.
> > 
> > A new test category was added, "protection", which currently has a
> > single test. Archs that support it will report "OK" there and those
> > that do not will report "SKIPPED", as is already the case for tests
> > that cannot be run.
> > 
> > This was applied on top of your dev.2023.03.20a branch. I'm reasonably
> > confident with the nature of the changes, so if your queue for 6.4 is
> > not closed yet, it can be a good target, otherwise 6.5 will be fine as
> > well.
> 
> I have applied and pushed it out, thank you both!
> 
> We are a little late in the process, but if testing goes well, I can't
> see why this cannot make the v6.4 merge window.

And "make run-user" says "124 test(s) passed", which looks promising.

But "make run" says "0 test(s) passed".

(They initially both said "0 test(s) passed", but that was because I
forgot to build qemu-x86_64 after an upgrade.)

Please see below for the full output of "make run".  Am I missing
some other package?

							Thanx, Paul

------------------------------------------------------------------------

  MKDIR   sysroot/x86/include
make[1]: Entering directory '/home/git/linux-rcu/tools/include/nolibc'
make[2]: Entering directory '/home/git/linux-rcu'
make[2]: Leaving directory '/home/git/linux-rcu'
make[2]: Entering directory '/home/git/linux-rcu'
  INSTALL /home/git/linux-rcu/tools/testing/selftests/nolibc/sysroot/sysroot/include
make[2]: Leaving directory '/home/git/linux-rcu'
make[1]: Leaving directory '/home/git/linux-rcu/tools/include/nolibc'
  CC      nolibc-test
  MKDIR   initramfs
  INSTALL initramfs/init
make[1]: Entering directory '/home/git/linux-rcu'
  DESCEND objtool
  INSTALL libsubcmd_headers
  CALL    scripts/checksyscalls.sh
  GEN     usr/initramfs_data.cpio
  GZIP    usr/initramfs_inc_data
  AS      usr/initramfs_data.o
  AR      usr/built-in.a
  AR      built-in.a
  AR      vmlinux.a
  LD      vmlinux.o
  OBJCOPY modules.builtin.modinfo
  GEN     modules.builtin
  MODPOST vmlinux.symvers
  UPD     include/generated/utsversion.h
  CC      init/version-timestamp.o
  LD      .tmp_vmlinux.kallsyms1
  NM      .tmp_vmlinux.kallsyms1.syms
  KSYMS   .tmp_vmlinux.kallsyms1.S
  AS      .tmp_vmlinux.kallsyms1.S
  LD      .tmp_vmlinux.kallsyms2
  NM      .tmp_vmlinux.kallsyms2.syms
  KSYMS   .tmp_vmlinux.kallsyms2.S
  AS      .tmp_vmlinux.kallsyms2.S
  LD      .tmp_vmlinux.kallsyms3
  NM      .tmp_vmlinux.kallsyms3.syms
  KSYMS   .tmp_vmlinux.kallsyms3.S
  AS      .tmp_vmlinux.kallsyms3.S
  LD      vmlinux
  NM      System.map
  SORTTAB vmlinux
  CC      arch/x86/boot/version.o
  VOFFSET arch/x86/boot/compressed/../voffset.h
  OBJCOPY arch/x86/boot/compressed/vmlinux.bin
  RELOCS  arch/x86/boot/compressed/vmlinux.relocs
  CC      arch/x86/boot/compressed/kaslr.o
  GZIP    arch/x86/boot/compressed/vmlinux.bin.gz
  CC      arch/x86/boot/compressed/misc.o
  MKPIGGY arch/x86/boot/compressed/piggy.S
  AS      arch/x86/boot/compressed/piggy.o
  LD      arch/x86/boot/compressed/vmlinux
  ZOFFSET arch/x86/boot/zoffset.h
  OBJCOPY arch/x86/boot/vmlinux.bin
  AS      arch/x86/boot/header.o
  LD      arch/x86/boot/setup.elf
  OBJCOPY arch/x86/boot/setup.bin
  BUILD   arch/x86/boot/bzImage
Kernel: arch/x86/boot/bzImage is ready  (#103)
make[1]: Leaving directory '/home/git/linux-rcu'
0 test(s) passed.
