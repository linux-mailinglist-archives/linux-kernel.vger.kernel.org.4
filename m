Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B592F667CDA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 18:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238082AbjALRpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 12:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjALRo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 12:44:28 -0500
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [IPv6:2a01:e0c:1:1599::15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D6E82D05;
        Thu, 12 Jan 2023 09:03:14 -0800 (PST)
Received: from localhost (unknown [IPv6:2a01:e35:39f2:1220:dc8b:b602:9bcd:3004])
        by smtp6-g21.free.fr (Postfix) with ESMTPS id 90AC57802D7;
        Thu, 12 Jan 2023 18:02:54 +0100 (CET)
From:   Yann Droneaud <ydroneaud@opteya.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Cc:     Yann Droneaud <ydroneaud@opteya.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Florian Weimer <fweimer@redhat.com>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>
Subject: [RFC PATCH 0/4] random: a simple vDSO mechanism for reseeding userspace CSPRNGs
Date:   Thu, 12 Jan 2023 18:02:32 +0100
Message-Id: <cover.1673539719.git.ydroneaud@opteya.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's my humble hack at improving kernel for a faster secure arc4random()
userspace implementation, by allowing userspace to buffer getrandom()
generated entropy, discarding it as the kernel's own CSPRNG is reseeded.

It's largely built upon the vDSO work of Jason A. Donenfeld, as part of
its latest patchset "[PATCH v14 0/7] implement getrandom() in vDSO" [1]
but it's made simpler by making available only one of the missing tools
for the userspace to properly buffer the output of getrandom().

Using MADV_WIPEONFORK and mlock(), userspace can reasonably offer forward
secrecy*, until something like VM_DROPPABLE[2] is provided by the kernel,
to allow for the buffer memory to never, ever be written to the disk
before its used, being inherited accross fork(), and isn't limited by
RLIMIT_MEMLOCK.

 * provided userspace can mlock() the memory and calls mlock() on buffer
   after fork, as memory locks are not inherited accross fork().

As it's a hack, it's far from perfect. The main drawback I see is the
case where fresh entropy has to be discarded as the kernel's CSPRNG
generation is updated as the result of calling getrandom() to generate
the mentionned entropy. The workaround, is to limit the amount of fresh
entropy fetched when a kernel's CSPRNG generation change is detected,
and to increase the amount the data retrieved with getrandom() when
generation doesn't change between calls.

Performance wise, the improvements are here, as one can check with the
test program provided:

    getrandom(,,GRND_TIMESTAMP) test
    getrandom() support GRND_TIMESTAMP
    found getrandom() in vDSO at 0x7ffc3efccc60
    == direct syscall getrandom(), 16777216 u32, 2.866324020 s,   5.853 M u32/s, 170.846 ns/u32
    == direct vDSO getrandom(),    16777216 u32, 2.883473280 s,   5.818 M u32/s, 171.868 ns/u32
    == pooled syscall getrandom(), 16777216 u32, 1.152421219 s,  14.558 M u32/s,  68.690 ns/u32, (0 bytes discarded)
    == pooled vDSO getrandom(),    16777216 u32, 0.162477863 s, 103.258 M u32/s,   9.684 ns/u32, (0 bytes discarded)

With the requirement to mlock() the memory page(s) used to buffer
getrandom() output, I'm not sure userspace could afford to allocate
4KBytes per thread, before being hit by RLIMIT_MEMLOCK (or worse,
OOM killer). Thus, some form of sharing between threads would be
needed, which would require locking, reducing the performances
shown above.

Also I haven't studied the security impact of making the kernel base
CSPRNG seed generation available to userspace. It can be made more
opaque if needed.

Regards.

[1] https://lore.kernel.org/all/20230101162910.710293-1-Jason@zx2c4.com/
[2] https://lore.kernel.org/all/20230101162910.710293-3-Jason@zx2c4.com/

Jason A. Donenfeld (2):
  random: introduce generic vDSO getrandom(,, GRND_TIMESTAMP) fast path
  x86: vdso: Wire up getrandom() vDSO implementation.

Yann Droneaud (2):
  random: introduce getrandom() GRND_TIMESTAMP
  testing: add a getrandom() GRND_TIMESTAMP vDSO demonstration/benchmark

 MAINTAINERS                                   |   1 +
 arch/x86/Kconfig                              |   1 +
 arch/x86/entry/vdso/Makefile                  |   3 +-
 arch/x86/entry/vdso/vdso.lds.S                |   2 +
 arch/x86/entry/vdso/vgetrandom.c              |  17 +
 arch/x86/include/asm/vdso/getrandom.h         |  42 +++
 arch/x86/include/asm/vdso/vsyscall.h          |   2 +
 arch/x86/include/asm/vvar.h                   |  16 +
 drivers/char/random.c                         |  52 ++-
 include/linux/random.h                        |  31 ++
 include/uapi/linux/random.h                   |   2 +
 include/vdso/datapage.h                       |   9 +
 lib/vdso/Kconfig                              |   5 +
 lib/vdso/getrandom.c                          |  51 +++
 tools/testing/crypto/getrandom/Makefile       |   4 +
 .../testing/crypto/getrandom/test-getrandom.c | 307 ++++++++++++++++++
 16 files changed, 543 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/entry/vdso/vgetrandom.c
 create mode 100644 arch/x86/include/asm/vdso/getrandom.h
 create mode 100644 lib/vdso/getrandom.c
 create mode 100644 tools/testing/crypto/getrandom/Makefile
 create mode 100644 tools/testing/crypto/getrandom/test-getrandom.c

-- 
2.37.2

