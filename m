Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7EF5F34BD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 19:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiJCRpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 13:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiJCRpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 13:45:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF014FD0E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 10:45:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BDCAB811B2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 17:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5CDC433D6;
        Mon,  3 Oct 2022 17:45:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Cz8dIu05"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664819106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XdPJ/y5doG64tnx75SbEfcn5QlUKJaYUT01m0WsjDwE=;
        b=Cz8dIu05TlAhOUfu61lFMyyQgZScfSuKNJ4DvLVo7TiifbaJdAHcaETVj5QuD3q9Kf7Bx1
        5zDFNPWqWgtgQ6pokMJekkCXfvbime6b1/V1cKhMkKkvb34BdPXttitTOPd3gg/QSVwDg9
        VdQ0TX6JKPAZEf8UYmkd7QxkGhOJMvc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0ac52f4d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 3 Oct 2022 17:45:05 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] random number generator updates for 6.1-rc1
Date:   Mon,  3 Oct 2022 19:44:31 +0200
Message-Id: <20221003174431.1189919-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the following random number generator updates for 6.1-rc1:

- Huawei reported that when they updated their kernel from 4.4 to something
  much newer, some userspace code they had broke, the culprit being the
  accidental removal of O_NONBLOCK from /dev/random way back in 5.6. It's been
  gone for over 2 years now and this is the first we've heard of it, but
  userspace breakage is userspace breakage, so O_NONBLOCK is now back.

- Use randomness from hardware RNGs much more often during early boot, at the
  same interval that crng reseeds are done, from Dominik.

- A semantic change in hardware RNG throttling, so that the hwrng framework
  can properly feed random.c with randomness from hardware RNGs that aren't
  specifically marked as creditable.

  A related patch coming to you via Herbert's hwrng tree depends on this one,
  not to compile, but just to function properly, so you may want to merge this
  PULL before that one.

- A fix to clamp credited bits from the interrupts pool to the size of the
  pool sample. This is mainly just a theoretical fix, as it'd be pretty hard
  to exceed it in practice.

- Oracle reported that InfiniBand TCP latency regressed by around 10-15% after
  a change a few cycles ago made at the request of the RT folks, in which we
  hoisted a somewhat rare operation (1 in 1024 times) out of the hard IRQ
  handler and into a workqueue, a pretty common and boring pattern.

  It turns out, though, that scheduling a worker from there has overhead of
  its own, whereas scheduling a timer on that same CPU for the next jiffy
  amortizes better and doesn't incur the same overhead.

  I also eliminated a cache miss by moving the work_struct (and subsequently,
  the timer_list) to below a critical cache line, so that the more critical
  members that are accessed on every hard IRQ aren't split between two cache
  lines.

- The boot-time initialization of the RNG has been split into two approximate
  phases: what we can accomplish before timekeeping is possible and what we
  can accomplish after. This winds up being useful so that we can use RDRAND
  to seed the RNG before CONFIG_SLAB_FREELIST_RANDOM=y systems initialize
  slabs, in addition to other early uses of randomness. The effect is that
  systems with RDRAND (or a bootloader seed) will never see any warnings at
  all when setting CONFIG_WARN_ALL_UNSEEDED_RANDOM=y. And kfence benefits from
  getting a better seed of its own.

- Small systems without much entropy sometimes wind up putting some truncated
  serial number read from flash into hostname, so contribute utsname changes
  to the RNG, without crediting. 

- Add smaller batches to serve requests for smaller integers, and make use of
  them when people ask for random numbers bounded by a given compile-time
  constant. This has positive effects all over the tree, most notably in
  networking and kfence.

- The original jitter algorithm intended (I believe) to schedule the timer for
  the next jiffy, not the next-next jiffy, yet it used mod_timer(jiffies + 1),
  which will fire on the next-next jiffy, instead of what I believe was
  intended, mod_timer(jiffies), which will fire on the next jiffy. So fix
  that. (If you did actually intend the next-next jiffy for this voodoo, let
  me know and I'll happily send you a new pull.)

- Fix a comment typo, from William.

Not in this PULL, but coming your way via other trees are several improvements
to bootloader seeding infrastructure. For 6.1, MIPS firmware environments will
be able to pass a random seed, m68k's support from 6.0 is generalized and
works with kexec, and the EFI stub will learn how to combine its own seed with
that of the previous EFI bootloader, so that bootloaders like systemd-boot can
manage seed files on various mediums and pass it along to the kernel safely.
I've also been working on wiring up these various seeds on the QEMU side. If
you haven't noticed, there's been a lot of effort toward enabling bootloaders
and firmwares to communicate a RNG seed safely with the kernel, somehow. The
hope is that providing some means of manufacturers and firmware writers to
provide entropy lays foundations for eliminating the boot-time entropy issue. 

Also worth noting is that in my Plumbers talk, I mentioned how add_device_
randomness() can be called on data or events that /might/ be random, but also
might not, and the RNG will benefit if it is random but won't be hurt if it's
not. So, as long as it doesn't impact performance, driver developers should
feel free to shuffle entropy into random.c with add_device_randomness() as
they see fit. Right after the talk ended, Bryan sent a patch for a wireless
driver to contribute some of its environmental noise to the RNG. Very cool.
This is in the same category as a patch a few months ago in the MMC tree
adding SD/MMC serial numbers to the pool, on the theory that this is often the
only unique thing on small boards. Little zero-cost improvements like this can
make a difference, so I'm happy to see them.

Thanks,
Jason

The following changes since commit 504c25cb76a9cb805407f7701b25a1fbd48605fa:

  Merge tag 'net-6.0-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2022-09-22 10:58:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.1-rc1-for-linus

for you to fetch changes up to d687772e6d2cbffd91fdda64812f79192c1e7ca0:

  random: fix typos in get_random_bytes() comment (2022-10-01 23:37:51 +0200)

----------------------------------------------------------------
Random number generator updates for Linux 6.1-rc1.
----------------------------------------------------------------

Dominik Brodowski (1):
      random: use hwgenerator randomness more frequently at early boot

Jason A. Donenfeld (12):
      random: restore O_NONBLOCK support
      random: throttle hwrng writes if no entropy is credited
      random: clamp credited irq bits to maximum mixed
      random: avoid reading two cache lines on irq randomness
      random: use expired timer rather than wq for mixing fast pool
      random: split initialization into early step and later step
      kfence: use better stack hash seed
      random: use init_utsname() instead of utsname()
      utsname: contribute changes to RNG
      random: add 8-bit and 16-bit batches
      prandom: make use of smaller types in prandom_u32_max
      random: schedule jitter credit for next jiffy, not in two jiffies

William Zijl (1):
      random: fix typos in get_random_bytes() comment

 drivers/char/mem.c      |   4 +-
 drivers/char/random.c   | 115 ++++++++++++++++++++++++++++--------------------
 include/linux/prandom.h |  17 ++++---
 include/linux/random.h  |   5 ++-
 init/main.c             |  17 ++++---
 kernel/sys.c            |   3 ++
 kernel/utsname_sysctl.c |   2 +
 mm/kfence/core.c        |   2 +-
 8 files changed, 98 insertions(+), 67 deletions(-)
