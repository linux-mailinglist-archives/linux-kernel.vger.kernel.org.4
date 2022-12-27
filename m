Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B4E657001
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 22:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbiL0Vf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 16:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiL0Vfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 16:35:54 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 766BCD5E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 13:35:49 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 2BRLZUlp006457;
        Tue, 27 Dec 2022 22:35:30 +0100
Date:   Tue, 27 Dec 2022 22:35:30 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] nolibc: add support for s390
Message-ID: <20221227213530.GA6390@1wt.eu>
References: <20221209141939.3634586-1-svens@linux.ibm.com>
 <20221209141939.3634586-3-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209141939.3634586-3-svens@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

On Fri, Dec 09, 2022 at 03:19:36PM +0100, Sven Schnelle wrote:
> Use arch-x86_64 as a template. Not really different, but
> we have our own mmap syscall which takes a structure instead
> of discrete arguments.
(...)

This evening I downloaded an s390 toolchain from kernel.org's nolibc
toolchains and expected to test the code under qemu, but I met two
build errors.

The first one is that __maybe_unused breaks the build below:

> +static __maybe_unused
> +void *sys_mmap(void *addr, size_t length, int prot, int flags, int fd,
> +	       off_t offset)

And indeed, __maybe_unused is not defined here in userland. The following
patch allows to go further:

  diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
  index 34b744e2f7d6..effae6e3d9e2 100644
  --- a/tools/include/nolibc/arch-s390.h
  +++ b/tools/include/nolibc/arch-s390.h
  @@ -194,7 +194,7 @@ struct s390_mmap_arg_struct {
          unsigned long offset;
   };
   
  -static __maybe_unused
  +static __attribute__((unused))
   void *sys_mmap(void *addr, size_t length, int prot, int flags, int fd,
                 off_t offset)
   {
  
But with this addressed, I'm facing this next error:

  $ make nolibc-test LDFLAGS= ARCH=s390 CC=/f/tc/nolibc/gcc-12.2.0-nolibc/s390-linux/bin/s390-linux-gcc
    MKDIR   sysroot/s390/include
  make[1]: Entering directory '/g/public/linux/master/tools/include/nolibc'
  make[2]: Entering directory '/g/public/linux/master'
  make[2]: Leaving directory '/g/public/linux/master'
  make[2]: Entering directory '/g/public/linux/master'
    INSTALL /g/public/linux/master/tools/testing/selftests/nolibc/sysroot/sysroot/include
  make[2]: Leaving directory '/g/public/linux/master'
  make[1]: Leaving directory '/g/public/linux/master/tools/include/nolibc'
    CC      nolibc-test
  /tmp/ccCzaBgD.s: Assembler messages:
  /tmp/ccCzaBgD.s:9: Error: Unrecognized opcode: `lg'
  /tmp/ccCzaBgD.s:12: Error: Unrecognized opcode: `lay'
  /tmp/ccCzaBgD.s:15: Error: Unrecognized opcode: `lghi'
  make: *** [Makefile:108: nolibc-test] Error 1

Thus I'm wondering if specific options are required for the compiler
(it's gcc 12.2.0 + binutils 2.39), if I'm not using the proper compiler,
or if there's anything wrong in the asm code (e.g. maybe by accident you
sent the patch from an earlier development branch), or anything else ?

FWIW I've used the patches from Paul's dev branch:

  https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/log/?h=dev

And the s390 toolchain from here:

  https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/12.2.0/

Thanks in advance for any help,
Willy
