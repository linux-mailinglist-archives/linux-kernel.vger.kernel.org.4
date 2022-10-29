Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B47A61223D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 12:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiJ2Ksz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 06:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ2Ksx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 06:48:53 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366B782859
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 03:48:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mzx3f3jHJz4xGR;
        Sat, 29 Oct 2022 21:48:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1667040527;
        bh=w4Rmmw3RS24hXRNe+iPdpTEFwX0r7o0PH0nM1I/G3U0=;
        h=From:To:Cc:Subject:Date:From;
        b=PewceabmNMnMjE/7Tp7JPCcgXvMHwQAGd9AJdAALJmmhC2Rpzxgs8e4wYPf6MIpXz
         rzYFty7Ibb4axiPwnC501svvWHwTnrqi6oY5kUR4PWFTzs86dZLDOXwF3DPdzwS3CR
         bN3Hz0K0eZ8/KY/X23x76p3q+j8fynXwyrH6Wq/4MdS/W6BGNvgeDSI4iH6i2V+I+Q
         inZiHh1RglMrQ410+2k4wbAocLFLI4t/wB6BqZ/zGcx/fNSMOSjAARoS6pMG8eX7hr
         QwscPmIUxrjCiMJ86F3RpkmSC7MsiB6b3o/5K6fOJ0FvNNzbwdiP4+gRVx+vCCd2D2
         8CzJSTfR2u6CA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     haren@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.1-3 tag
Date:   Sat, 29 Oct 2022 21:48:41 +1100
Message-ID: <87zgdesy5y.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 6.1:

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.1-3

for you to fetch changes up to 65722736c3baf29e02e964a09e85c9ef71c48e8d:

  powerpc/64s/interrupt: Fix clear of PACA_IRQS_HARD_DIS when returning to soft-masked context (2022-10-27 00:38:35 +1100)

- ------------------------------------------------------------------
powerpc fixes for 6.1 #3

 - Fix a case of rescheduling with user access unlocked, when preempt is enabled.

 - A follow-up fix for a recent fix, which could lead to IRQ state assertions firing
   incorrectly.

 - Two fixes for lockdep warnings seen when using kfence with the Hash MMU.

 - Two fixes for preempt warnings seen when using the Hash MMU.

 - Two fixes for the VAS coprocessor mechanism used on pseries.

 - Prevent building some of our older KVM backends when CONTEXT_TRACKING_USER is enabled,
   as it's known to cause crashes.

 - A couple of fixes for issues seen with PMU NMIs.

Thanks to: Nicholas Piggin, Guenter Roeck, Frederic Barrat Haren Myneni, Sachin Sant,
Samuel Holland.

- ------------------------------------------------------------------
Haren Myneni (2):
      powerpc/pseries/vas: Add VAS IRQ primary handler
      powerpc/pseries: Use lparcfg to reconfig VAS windows for DLPAR CPU

Nicholas Piggin (10):
      powerpc/64s: Add lockdep for HPTE lock
      powerpc/64s: make HPTE lock and native_tlbie_lock irq-safe
      powerpc/64s: make linear_map_hash_lock a raw spinlock
      powerpc/64s: Disable preemption in hash lazy mmu mode
      powerpc/64s: Fix hash__change_memory_range preemption warning
      powerpc: Fix reschedule bug in KUAP-unlocked user copy
      KVM: PPC: BookS PR-KVM and BookE do not support context tracking
      powerpc/64/interrupt: Prevent NMI PMI causing a dangerous warning
      powerpc/64s/interrupt: Perf NMI should not take normal exit path
      powerpc/64s/interrupt: Fix clear of PACA_IRQS_HARD_DIS when returning to soft-masked context


 arch/powerpc/include/asm/book3s/64/tlbflush-hash.h |  6 ++
 arch/powerpc/kernel/exceptions-64e.S               |  7 ++
 arch/powerpc/kernel/exceptions-64s.S               | 14 +++-
 arch/powerpc/kernel/interrupt.c                    | 14 +++-
 arch/powerpc/kernel/interrupt_64.S                 | 13 ++-
 arch/powerpc/kvm/Kconfig                           |  4 +
 arch/powerpc/lib/vmx-helper.c                      | 12 ++-
 arch/powerpc/mm/book3s64/hash_native.c             | 67 ++++++++++++++--
 arch/powerpc/mm/book3s64/hash_pgtable.c            |  8 +-
 arch/powerpc/mm/book3s64/hash_utils.c              | 12 +--
 arch/powerpc/platforms/pseries/lparcfg.c           | 11 +++
 arch/powerpc/platforms/pseries/vas.c               | 83 +++++++++++++++-----
 arch/powerpc/platforms/pseries/vas.h               |  6 ++
 13 files changed, 212 insertions(+), 45 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmNdBLMACgkQUevqPMjh
pYBiVRAAmr/98OnqSULxJsuJHZnLGTZuMCnMOsk4sPYVEqfwiR2wF4GmQWV1EHG1
hSk9nw46lZaPBtg5FLxp8VrmRsJLv9GTM81bvfIA40+nmpHwuljXckEtkVkTMO4M
EPBMbrinLJhBczXNJ9etAK/Sm7zlBW4Zunyo8ejm04RfrbNdUTEzhzwV9uK0AE0S
Leg2LAYsChcd1on0L+rcBIHLZUCFd3GJJz0i4MHGtLV/cBtbg+qrNRxYQMyHVZmG
PlWUHywweya6mzyDi2WBU2rjzRz0ZjcNAEnMvqsihAmrnDQJcYGXc61gDH3lYuDk
oGLcm7an2aElPnoJOCCmAugUk1IY7c9WVxgrHCQ08kBtHgPkuL0XGMJNGYRyNcUN
azoz0VikviOLkECPP9MGrKUuYSewUXjk4DIYLEZclvvRbBKp7gM7hAAtJXJxghVH
mynKr2zTGTJb73sGo7ey/kAgzXPBX6mre2BhSYR+odzSEcptg+Rd+6pDqwAw2Xkt
ao8iTGZUA2Vrq+KutoXvWb1mtP/EKLTz7dhbJUid4+cTrNo7NCTiNj/jSKEVXI2p
FNwLXpP16VihJNg2ttOxz2GPhB2+6TIk9TeVJDFytqZPqx2bhY9PVpZxt0ARm3tH
m8cl0gI8zXfbpyhAT3Y6IGRwpEFEyJ7UEQk9ew+JnRol2uaPLiM=
=Dccx
-----END PGP SIGNATURE-----
