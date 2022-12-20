Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B606518C2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 03:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiLTCZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 21:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiLTCZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 21:25:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620EBB90
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 18:25:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D12DDB80D2F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 02:25:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFAFC433EF;
        Tue, 20 Dec 2022 02:25:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="dk2sESxH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1671503104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GONWkYR5ETRlvmjHJNSwCeq8iqU0rT6jTSaQSVLxGz4=;
        b=dk2sESxHrdei6xMlG087PmIVoxtEye0K1eOR4CFHYeoa6REbhlfP5hnYl2p3R21tIR9wxT
        d6kvl8NtRfuiIoKcQMjEesfA/iOBxAuAk+KFdd5B6TiGvyrQrUSFKYkNwuCsKX4zvsTTYg
        kmiPAIPJcwjupR4FqYj/hwlSgisjktk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f89d33e8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 20 Dec 2022 02:25:04 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] random number generator fixes for 6.2-rc1, part 2
Date:   Tue, 20 Dec 2022 03:24:58 +0100
Message-Id: <20221220022458.11682-1-Jason@zx2c4.com>
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

As mentioned in the first pull for 6.2-rc1, this second late pull request has
two remaining changes that are now possible after you merged a few other
trees:

- #include <asm/archrandom.h> can be removed from random.h now, making the
  direct use of the arch_random_* API more of a private implementation detail
  between the archs and random.c, rather than something for general consumers.

- Two additional uses of prandom_u32_max() snuck in during the initial phase
  of pulls, so these have been converted to get_random_u32_below(), and now
  the deprecated prandom_u32_max() alias -- which was just a wrapper around
  get_random_u32_below() -- can be removed.

In addition, there is one fix:

- Check efi_rt_services_supported() before attempting to use an EFI runtime
  function. This affected EFI systems that disable runtime services yet still
  boot via EFI (e.g. the reporter's Dell arm64 laptop), as well systems where
  EFI runtime services have been forcibly disabled, such as on PREEMPT_RT. On
  those machines, a very early and hard to diagnose crash would happen,
  preventing boot.

Please pull.

Thanks,
Jason

The following changes since commit 6feb57c2fd7c787aecf2846a535248899e7b70fa:

  Merge tag 'kbuild-v6.2' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild (2022-12-19 12:33:32 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.2-rc1-for-linus

for you to fetch changes up to 3c202d14a9d73fb63c3dccb18feac5618c21e1c4:

  prandom: remove prandom_u32_max() (2022-12-20 03:13:45 +0100)

----------------------------------------------------------------
Random number generator fixes for Linux 6.2-rc1.
----------------------------------------------------------------

Jason A. Donenfeld (2):
      random: do not include <asm/archrandom.h> from random.h
      prandom: remove prandom_u32_max()

Johan Hovold (1):
      efi: random: fix NULL-deref when refreshing seed

 arch/powerpc/kernel/setup-common.c   | 1 +
 arch/s390/kernel/setup.c             | 1 +
 arch/x86/mm/cpu_entry_area.c         | 2 +-
 drivers/char/hw_random/powernv-rng.c | 1 +
 drivers/char/hw_random/s390-trng.c   | 1 +
 drivers/char/random.c                | 1 +
 drivers/firmware/efi/efi.c           | 4 +++-
 include/linux/prandom.h              | 6 ------
 include/linux/random.h               | 2 --
 net/ipv4/tcp_plb.c                   | 2 +-
 10 files changed, 10 insertions(+), 11 deletions(-)
