Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD27649079
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 20:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiLJTrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 14:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLJTrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 14:47:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE2115FE3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 11:47:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A7E560C85
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 19:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0BDC433D2;
        Sat, 10 Dec 2022 19:47:27 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="S0mOv8yJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1670701645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AsEhTq9Qof1P+euJKIMm+IfKtyxe0Yv+1BDfb+lzKaA=;
        b=S0mOv8yJRFaFusjon0zUbr2a837wdeykNrKZzeVJPsMUC8u++Al57K0gQfdTw3dto5s45i
        Wn1sSaG/Zjhq2xuCrtW8QbJ6T2GoYmErZiJ+K/ZToeUx2Wd/zstJNHGXfF8boRgBEvBvUE
        2vMppZq2KATvB4tQkLRf+l4drQ5+X74=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6ef8c76d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sat, 10 Dec 2022 19:47:25 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] random number generator fixes for 6.2-rc1
Date:   Sat, 10 Dec 2022 20:47:08 +0100
Message-Id: <20221210194708.675884-1-Jason@zx2c4.com>
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

Please pull the following random number generator updates for 6.2-rc1:

- Replacing prandom_u32_max() and various open-coded variants of it, there is
  now a new family of functions that uses fast rejection sampling to choose
  properly uniformly random numbers within an interval:

    * get_random_u32_below(ceil) - [0, ceil)
    * get_random_u32_above(floor) - (floor, U32_MAX]
    * get_random_u32_inclusive(floor, ceil) - [floor, ceil]
 
  Coccinelle was used to convert all current users of prandom_u32_max(), as
  well as many open-coded patterns, resulting in improvements throughout the
  tree.

  I'll have a "late" 6.1-rc1 pull for you that removes the now unused
  prandom_u32_max() function, just in case any other trees add a new use case
  of it that needs to converted. According to linux-next, there may be two
  trivial cases of prandom_u32_max() reintroductions that are fixable with a
  's/.../.../'. So I'll have for you a final conversion patch doing that
  alongside the removal patch during the second week, before you cut rc1.

  This is a treewide change that touches many files throughout, so it would
  probably make sense to merge this pull early.

- More consistent use of get_random_canary().

- Updates to comments, documentation, tests, headers, and simplification in
  configuration.

- The arch_get_random*_early() abstraction was only used by arm64 and wasn't
  entirely useful, so this has been replaced by code that works in all
  relevant contexts.

- The kernel will use and manage random seeds in non-volatile EFI variables,
  refreshing a variable with a fresh seed when the RNG is initialized. The RNG
  GUID namespace is then hidden from efivarfs to prevent accidental leakage.

  These changes are split into random.c infrastructure code used in the EFI
  subsystem, in this pull request, and related support inside of EFISTUB, in
  Ard's EFI tree. These are co-dependent for full functionality, but the order
  of merging doesn't matter.

- Part of the infrastructure added for the EFI support is also used for an
  improvement to the way vsprintf initializes its siphash key, replacing an
  sleep loop wart.

- The hardware RNG framework now always calls its correct random.c input
  function, add_hwgenerator_randomness(), rather than sometimes going through
  helpers better suited for other cases.

- The add_latent_entropy() function has long been called from the fork
  handler, but is a no-op when the latent entropy gcc plugin isn't used,
  which is fine for the purposes of latent entropy. But it was missing out on
  the cycle counter that was also being mixed in beside the latent entropy
  variable. So now, if the latent entropy gcc plugin isn't enabled,
  add_latent_entropy() will expand to a call to add_device_randomness(NULL,
  0), which adds a cycle counter, without the absent latent entropy variable.

- The RNG is now reseeded from a delayed worker, rather than on demand when
  used. Always running from a worker allows it to make use of the CPU RNG on
  platforms like S390x, whose instructions are too slow to do so from
  interrupts. It also has the effect of adding in new inputs more frequently
  with more regularity, amounting to a long term transcript of random values.
  Plus, it helps a bit with the upcoming vDSO implementation (which isn't yet
  ready for 6.2).

- The jitter entropy algorithm now tries to execute on many different CPUs,
  round-robining, in hopes of hitting even more memory latencies and other
  unpredictable effects. It also will mix in a cycle counter when the entropy
  timer fires, in addition to being mixed in from the main loop, to account
  more explicitly for fluctuations in that timer firing. And the state it
  touches is now kept within the same cache line, so that it's assured that
  the different execution contexts will cause latencies.

There are also a few RNG-related changes that will be arriving to you via
other trees:

- The hardware RNG framework will now pass creditable randomness from much
  more dedicated RNG hardware than before, which lets the RNG be initialized
  even faster on various hardware without RDRAND but with a dedicated RNG
  chip. Along with many other changes here and in random.c throughout the last
  few cycles, the overall push has been centered around trying to productively
  make use of all of the various random sources the kernel has access to, in
  hopes of chipping away at the boot time entropy availability issue.

- EFISTUB will concatenate seeds passed via an EFI configuration table along
  with the ones it generates, so that EFI bootloaders, such as systemd-boot or
  systemd-stub, can do their own RNG seed management using various writable
  media available to those bootloaders, and then pass the seed on directly to
  the kernel, so that it's used at the earliest available opportunity in boot.
  The code for this is already in the systemd tree and will be part of their
  next release. Hopefully other bootloaders will also follow that pattern.

- Since get_random_long() now always makes use of RDRAND (if available) before
  the RNG is fully initialized, calling get_random_long() is always better
  during all stages of boot than calling arch_get_random_longs() directly. So
  the x86 espfix code no arranges its slots based on a call to get_random_long(),
  rather than calling RDRAND/RDTSC itself. This is part of a larger effort to
  cleanup direct calls to arch_get_random_*(), which is more of a private
  implementation detail of random.c than a general purpose API. After this
  reaches your tree from tip, I'll have an archrandom.h cleanup patch as part
  of my "late" 6.2-rc1 pull.

Thanks,
Jason

The following changes since commit 094226ad94f471a9f19e8f8e7140a09c2625abaa:

  Linux 6.1-rc5 (2022-11-13 13:12:55 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.2-rc1-for-linus

for you to fetch changes up to 3e6743e28b9b43d37ced234bdf8e19955d0216f8:

  random: include <linux/once.h> in the right header (2022-12-04 14:37:08 +0100)

----------------------------------------------------------------
Random number generator fixes for Linux 6.2-rc1.
----------------------------------------------------------------
Christophe JAILLET (1):
      random: include <linux/once.h> in the right header

Jason A. Donenfeld (22):
      kcsan: remove rng selftest
      random: use rejection sampling for uniform bounded random integers
      random: add helpers for random numbers with given floor or range
      treewide: use get_random_u32_below() instead of deprecated function
      treewide: use get_random_u32_{above,below}() instead of manual loop
      treewide: use get_random_u32_inclusive() when possible
      stackprotector: move get_random_canary() into stackprotector.h
      stackprotector: actually use get_random_canary()
      random: use random.trust_{bootloader,cpu} command line option only
      random: remove early archrandom abstraction
      random: adjust comment to account for removed function
      random: modernize documentation comment on get_random_bytes()
      hw_random: use add_hwgenerator_randomness() for early entropy
      random: always mix cycle counter in add_latent_entropy()
      random: reseed in delayed work rather than on-demand
      random: add back async readiness notifier
      vsprintf: initialize siphash key using notifier
      efi: random: refresh non-volatile random seed when RNG is initialized
      random: remove extraneous period and add a missing one in comments
      random: spread out jitter callback to different CPUs
      random: mix in cycle counter when jitter timer fires
      random: align entropy_timer_state to cache line

 Documentation/admin-guide/kernel-parameters.txt    |  20 +-
 arch/arm/include/asm/stackprotector.h              |   9 +-
 arch/arm/kernel/process.c                          |   2 +-
 arch/arm64/include/asm/archrandom.h                |  48 +---
 arch/arm64/include/asm/stackprotector.h            |   9 +-
 arch/arm64/kernel/process.c                        |   2 +-
 arch/csky/include/asm/stackprotector.h             |  10 +-
 arch/loongarch/kernel/process.c                    |   2 +-
 arch/loongarch/kernel/vdso.c                       |   2 +-
 arch/mips/include/asm/stackprotector.h             |   9 +-
 arch/mips/kernel/process.c                         |   2 +-
 arch/mips/kernel/vdso.c                            |   2 +-
 arch/parisc/kernel/vdso.c                          |   2 +-
 arch/powerpc/configs/microwatt_defconfig           |   1 -
 arch/powerpc/crypto/crc-vpmsum_test.c              |   4 +-
 arch/powerpc/include/asm/stackprotector.h          |  10 +-
 arch/powerpc/kernel/process.c                      |   2 +-
 arch/riscv/include/asm/stackprotector.h            |  10 +-
 arch/s390/configs/debug_defconfig                  |   2 -
 arch/s390/configs/defconfig                        |   2 -
 arch/s390/configs/zfcpdump_defconfig               |   1 -
 arch/s390/kernel/process.c                         |   2 +-
 arch/s390/kernel/vdso.c                            |   2 +-
 arch/sh/include/asm/stackprotector.h               |  10 +-
 arch/sparc/vdso/vma.c                              |   2 +-
 arch/um/kernel/process.c                           |   2 +-
 arch/x86/entry/vdso/vma.c                          |   2 +-
 arch/x86/include/asm/stackprotector.h              |  14 +-
 arch/x86/kernel/cpu/common.c                       |   2 +-
 arch/x86/kernel/module.c                           |   2 +-
 arch/x86/kernel/process.c                          |   2 +-
 arch/x86/kernel/setup_percpu.c                     |   2 +-
 arch/x86/kernel/smpboot.c                          |   1 +
 arch/x86/mm/pat/cpa-test.c                         |   4 +-
 arch/x86/xen/enlighten_pv.c                        |   2 +-
 arch/xtensa/include/asm/stackprotector.h           |   9 +-
 crypto/rsa-pkcs1pad.c                              |   2 +-
 crypto/testmgr.c                                   |  86 +++----
 drivers/block/drbd/drbd_receiver.c                 |   4 +-
 drivers/bus/mhi/host/internal.h                    |   2 +-
 drivers/char/Kconfig                               |  36 ---
 drivers/char/hw_random/core.c                      |   8 +-
 drivers/char/random.c                              | 261 ++++++++++++++-------
 drivers/dma-buf/st-dma-fence-chain.c               |   6 +-
 drivers/firmware/efi/efi.c                         |  19 ++
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c     |   2 +-
 .../gpu/drm/i915/gt/intel_execlists_submission.c   |   2 +-
 drivers/gpu/drm/i915/intel_memory_region.c         |   4 +-
 drivers/infiniband/core/cma.c                      |   2 +-
 drivers/infiniband/hw/cxgb4/id_table.c             |   4 +-
 drivers/infiniband/hw/hns/hns_roce_ah.c            |   5 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c             |   2 +-
 drivers/md/bcache/request.c                        |   2 +-
 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c      |   8 +-
 drivers/media/test-drivers/vidtv/vidtv_demod.c     |   8 +-
 .../media/test-drivers/vivid/vivid-kthread-cap.c   |   2 +-
 .../media/test-drivers/vivid/vivid-kthread-out.c   |   2 +-
 drivers/media/test-drivers/vivid/vivid-radio-rx.c  |   4 +-
 drivers/media/test-drivers/vivid/vivid-sdr-cap.c   |   2 +-
 drivers/media/test-drivers/vivid/vivid-touch-cap.c |   2 +-
 drivers/mmc/core/core.c                            |   4 +-
 drivers/mmc/host/dw_mmc.c                          |   2 +-
 drivers/mtd/nand/raw/nandsim.c                     |   4 +-
 drivers/mtd/tests/mtd_nandecctest.c                |  10 +-
 drivers/mtd/tests/stresstest.c                     |   8 +-
 drivers/mtd/ubi/debug.c                            |   2 +-
 drivers/mtd/ubi/debug.h                            |   6 +-
 drivers/net/ethernet/broadcom/cnic.c               |   2 +-
 .../chelsio/inline_crypto/chtls/chtls_io.c         |   4 +-
 drivers/net/phy/at803x.c                           |   2 +-
 drivers/net/team/team_mode_random.c                |   2 +-
 drivers/net/wireguard/selftest/allowedips.c        |  20 +-
 drivers/net/wireguard/timers.c                     |   4 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |   2 +-
 drivers/pci/p2pdma.c                               |   2 +-
 drivers/s390/scsi/zfcp_fc.c                        |   2 +-
 drivers/scsi/fcoe/fcoe_ctlr.c                      |   4 +-
 drivers/scsi/qedi/qedi_main.c                      |   2 +-
 drivers/scsi/scsi_debug.c                          |   6 +-
 fs/ceph/inode.c                                    |   2 +-
 fs/ceph/mdsmap.c                                   |   2 +-
 fs/ext2/ialloc.c                                   |   2 +-
 fs/ext4/ialloc.c                                   |   2 +-
 fs/ext4/mmp.c                                      |   8 +-
 fs/ext4/super.c                                    |   5 +-
 fs/f2fs/gc.c                                       |   2 +-
 fs/f2fs/segment.c                                  |   8 +-
 fs/ubifs/debug.c                                   |   8 +-
 fs/ubifs/lpt_commit.c                              |  14 +-
 fs/ubifs/tnc_commit.c                              |   2 +-
 fs/xfs/libxfs/xfs_alloc.c                          |   2 +-
 fs/xfs/libxfs/xfs_ialloc.c                         |   2 +-
 fs/xfs/xfs_error.c                                 |   2 +-
 include/linux/damon.h                              |   2 +-
 include/linux/nodemask.h                           |   2 +-
 include/linux/prandom.h                            |  19 +-
 include/linux/random.h                             | 102 +++++---
 include/linux/stackprotector.h                     |  19 ++
 kernel/bpf/core.c                                  |   4 +-
 kernel/fork.c                                      |   2 +-
 kernel/kcsan/selftest.c                            |  12 +-
 kernel/locking/test-ww_mutex.c                     |   4 +-
 kernel/time/clocksource.c                          |   2 +-
 lib/fault-inject.c                                 |   2 +-
 lib/find_bit_benchmark.c                           |   4 +-
 lib/kobject.c                                      |   2 +-
 lib/reed_solomon/test_rslib.c                      |   6 +-
 lib/sbitmap.c                                      |   4 +-
 lib/test-string_helpers.c                          |   2 +-
 lib/test_fprobe.c                                  |   5 +-
 lib/test_hexdump.c                                 |  10 +-
 lib/test_kprobes.c                                 |   5 +-
 lib/test_list_sort.c                               |   2 +-
 lib/test_printf.c                                  |   2 +-
 lib/test_rhashtable.c                              |   6 +-
 lib/test_vmalloc.c                                 |   8 +-
 lib/vsprintf.c                                     |  14 +-
 mm/kasan/kasan_test.c                              |   6 +-
 mm/kfence/core.c                                   |   4 +-
 mm/kfence/kfence_test.c                            |   4 +-
 mm/slub.c                                          |   2 +-
 mm/swapfile.c                                      |   5 +-
 net/802/garp.c                                     |   2 +-
 net/802/mrp.c                                      |   2 +-
 net/batman-adv/bat_iv_ogm.c                        |   4 +-
 net/batman-adv/bat_v_elp.c                         |   2 +-
 net/batman-adv/bat_v_ogm.c                         |   4 +-
 net/batman-adv/network-coding.c                    |   2 +-
 net/bluetooth/mgmt.c                               |   5 +-
 net/can/j1939/socket.c                             |   2 +-
 net/can/j1939/transport.c                          |   2 +-
 net/ceph/mon_client.c                              |   2 +-
 net/ceph/osd_client.c                              |   2 +-
 net/core/neighbour.c                               |   4 +-
 net/core/pktgen.c                                  |  37 ++-
 net/core/stream.c                                  |   2 +-
 net/ipv4/icmp.c                                    |   2 +-
 net/ipv4/igmp.c                                    |   6 +-
 net/ipv4/inet_connection_sock.c                    |   2 +-
 net/ipv4/inet_hashtables.c                         |   2 +-
 net/ipv4/route.c                                   |   4 +-
 net/ipv4/tcp_bbr.c                                 |   2 +-
 net/ipv4/tcp_input.c                               |   3 +-
 net/ipv6/addrconf.c                                |   8 +-
 net/ipv6/mcast.c                                   |  10 +-
 net/ipv6/output_core.c                             |   8 +-
 net/ipv6/route.c                                   |   2 +-
 net/netfilter/ipvs/ip_vs_twos.c                    |   4 +-
 net/netfilter/nf_conntrack_core.c                  |   4 +-
 net/netfilter/nf_nat_helper.c                      |   2 +-
 net/netlink/af_netlink.c                           |   2 +-
 net/packet/af_packet.c                             |   4 +-
 net/sched/act_gact.c                               |   2 +-
 net/sched/act_sample.c                             |   2 +-
 net/sched/sch_choke.c                              |   2 +-
 net/sched/sch_netem.c                              |   4 +-
 net/sctp/socket.c                                  |   2 +-
 net/sctp/transport.c                               |   2 +-
 net/sunrpc/cache.c                                 |   2 +-
 net/sunrpc/xprtsock.c                              |   2 +-
 net/tipc/socket.c                                  |   2 +-
 net/vmw_vsock/af_vsock.c                           |   3 +-
 net/xfrm/xfrm_state.c                              |   2 +-
 .../testing/selftests/wireguard/qemu/kernel.config |   2 -
 165 files changed, 611 insertions(+), 649 deletions(-)
