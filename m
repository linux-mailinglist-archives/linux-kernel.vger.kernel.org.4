Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A269773E3E9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjFZPvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjFZPu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:50:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97776186;
        Mon, 26 Jun 2023 08:50:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 138AF60E00;
        Mon, 26 Jun 2023 15:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41AF8C433C9;
        Mon, 26 Jun 2023 15:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1687794647;
        bh=3Ot01nfvZImIYb/HmN0q8QQxroWWnESTigybZx8YBB0=;
        h=Date:From:To:Cc:Subject:From;
        b=o3vVXaLq9KFuaXbWq5GbO13+dbws/vCCG8Pg5GAFM8eJ4KBETw5EpRbmnlO8ktGu/
         SNeYEYZ3QNqQZEuaKqv9Jef7RQ07SKRDYIYhQUY2PcjyPX+k+/kmffVXF8KOyLytzq
         n04yt5acBVJ+YRwthspwSw7bIilxvCI6uOJ82ftA=
Date:   Mon, 26 Jun 2023 08:50:45 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
Subject: [GIT PULL] non-MM updates for 6.5-rc1
Message-Id: <20230626085045.24fa63256602e6e1bd51434b@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please merge these non-MM updates for 6.5-rc1, thanks.


The following changes since commit 7877cb91f1081754a1487c144d85dc0d2e2e7fc4:

  Linux 6.4-rc4 (2023-05-28 07:49:00 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-nonmm-stable-2023-06-24-19-23

for you to fetch changes up to 4afc9a402aa3890885747b396c1adcd45f127665:

  kernel/time/posix-stubs.c: remove duplicated include (2023-06-23 17:04:05 -0700)

----------------------------------------------------------------
- Arnd Bergmann has fixed a bunch of -Wmissing-prototypes in
  top-level directories.

- Douglas Anderson has added a new "buddy" mode to the hardlockup
  detector.  It permits the detector to work on architectures which
  cannot provide the required interrupts, by having CPUs periodically
  perform checks on other CPUs.

- Zhen Lei has enhanced kexec's ability to support two crash regions.

- Petr Mladek has done a lot of cleanup on the hard lockup detector's
  Kconfig entries.

- And the usual bunch of singleton patches in various places.

----------------------------------------------------------------
Alexey Dobriyan (2):
      add intptr_t
      include/linux/math.h: fix mult_frac() multiple argument evaluation bug

Angus Chen (1):
      init: add bdev fs printk if mount_block_root failed

Arnd Bergmann (15):
      mm: percpu: unhide pcpu_embed_first_chunk prototype
      mm: page_poison: always declare __kernel_map_pages() function
      mm: sparse: mark populate_section_memmap() static
      lib: devmem_is_allowed: include linux/io.h
      locking: add lockevent_read() prototype
      panic: hide unused global functions
      panic: make function declarations visible
      kunit: include debugfs header file
      init: consolidate prototypes in linux/init.h
      init: move cifs_root_data() prototype into linux/mount.h
      thread_info: move function declarations to linux/thread_info.h
      time_namespace: always provide arch_get_vdso_data() prototype for vdso
      kcov: add prototypes for helper functions
      decompressor: provide missing prototypes
      syscalls: add sys_ni_posix_timers prototype

Azeem Shaikh (1):
      procfs: replace all non-returning strlcpy with strscpy

Ben Dooks (1):
      devres: show which resource was invalid in __devm_ioremap_resource()

Christoph Hellwig (1):
      squashfs: don't include buffer_head.h

Colin Ian King (2):
      scripts/spelling.txt: add more spellings to spelling.txt
      ocfs2: remove redundant assignment to variable bit_off

Douglas Anderson (23):
      watchdog/perf: define dummy watchdog_update_hrtimer_threshold() on correct config
      watchdog/perf: more properly prevent false positives with turbo modes
      watchdog/hardlockup: add comments to touch_nmi_watchdog()
      watchdog/perf: rename watchdog_hld.c to watchdog_perf.c
      watchdog/hardlockup: move perf hardlockup checking/panic to common watchdog.c
      watchdog/hardlockup: style changes to watchdog_hardlockup_check() / is_hardlockup()
      watchdog/hardlockup: add a "cpu" param to watchdog_hardlockup_check()
      watchdog/hardlockup: move perf hardlockup watchdog petting to watchdog.c
      watchdog/hardlockup: rename some "NMI watchdog" constants/function
      watchdog/hardlockup: have the perf hardlockup use __weak functions more cleanly
      watchdog/hardlockup: detect hard lockups using secondary (buddy) CPUs
      watchdog/perf: add a weak function for an arch to detect if perf can use NMIs
      arm64: enable perf events based hard lockup detector
      watchdog/hardlockup: keep kernel.nmi_watchdog sysctl as 0444 if probe fails
      watchdog/hardlockup: HAVE_NMI_WATCHDOG must implement watchdog_hardlockup_probe()
      watchdog/hardlockup: don't use raw_cpu_ptr() in watchdog_hardlockup_kick()
      watchdog/hardlockup: in watchdog_hardlockup_check() use cpumask_copy()
      watchdog/hardlockup: remove softlockup comment in touch_nmi_watchdog()
      watchdog/buddy: cleanup how watchdog_buddy_check_hardlockup() is called
      watchdog/buddy: don't copy the cpumask in watchdog_next_cpu()
      watchdog/buddy: simplify the dependency for HARDLOCKUP_DETECTOR_PREFER_BUDDY
      watchdog/hardlockup: move SMP barriers from common code to buddy code
      powerpc: move arch_trigger_cpumask_backtrace from nmi.h to irq.h

Haifeng Xu (1):
      fork: optimize memcg_charge_kernel_stack() a bit

Joseph Qi (2):
      ocfs2: correct return value of ocfs2_local_free_info()
      ocfs2: cleanup trace events

Kees Cook (1):
      checkpatch: check for 0-length and 1-element arrays

Lecopzer Chen (4):
      watchdog: remove WATCHDOG_DEFAULT
      watchdog/hardlockup: change watchdog_nmi_enable() to void
      watchdog/perf: adapt the watchdog_perf interface for async model
      arm64: add hw_nmi_get_sample_period for preparation of lockup detector

Lukas Bulwahn (1):
      watchdog/hardlockup: fix typo in config HARDLOCKUP_DETECTOR_PREFER_BUDDY

Petr Mladek (6):
      watchdog/hardlockup: sort hardlockup detector related config values a logical way
      watchdog/hardlockup: make the config checks more straightforward
      watchdog/hardlockup: declare arch_touch_nmi_watchdog() only in linux/nmi.h
      watchdog/hardlockup: make HAVE_NMI_WATCHDOG sparc64-specific
      watchdog/sparc64: define HARDLOCKUP_DETECTOR_SPARC64
      watchdog/hardlockup: define HARDLOCKUP_DETECTOR_ARCH

Pingfan Liu (1):
      watchdog/perf: ensure CPU-bound context when creating hardlockup detector event

Prathu Baronia (1):
      kthread: fix spelling typo and grammar in comments

Simon Horman (1):
      kexec: avoid calculating array size twice

Vincent Whitchurch (1):
      squashfs: cache partial compressed blocks

Yang Li (1):
      kernel/time/posix-stubs.c: remove duplicated include

Zhen Lei (6):
      kexec: fix a memory leak in crash_shrink_memory()
      kexec: delete a useless check in crash_shrink_memory()
      kexec: clear crashk_res if all its memory has been released
      kexec: improve the readability of crash_shrink_memory()
      kexec: add helper __crash_shrink_memory()
      kexec: enable kexec_crash_size to support two crash kernel regions

 arch/Kconfig                               |  16 +-
 arch/alpha/kernel/osf_sys.c                |   2 -
 arch/arm/include/asm/irq.h                 |   1 -
 arch/arm64/Kconfig                         |   3 +
 arch/arm64/include/asm/thread_info.h       |   4 -
 arch/arm64/kernel/Makefile                 |   1 +
 arch/arm64/kernel/watchdog_hld.c           |  36 +++
 arch/microblaze/include/asm/setup.h        |   2 -
 arch/mips/include/asm/fw/cfe/cfe_api.h     |   3 -
 arch/mips/include/asm/irq.h                |   1 -
 arch/parisc/kernel/smp.c                   |   1 -
 arch/powerpc/Kconfig                       |   5 +-
 arch/powerpc/include/asm/irq.h             |   7 +-
 arch/powerpc/include/asm/nmi.h             |  12 +-
 arch/powerpc/kernel/watchdog.c             |  12 +-
 arch/powerpc/platforms/pseries/mobility.c  |   4 +-
 arch/riscv/include/asm/irq.h               |   2 -
 arch/riscv/include/asm/timex.h             |   2 -
 arch/s390/include/asm/thread_info.h        |   3 -
 arch/s390/kernel/entry.h                   |   2 -
 arch/sh/include/asm/irq.h                  |   1 -
 arch/sh/include/asm/rtc.h                  |   2 -
 arch/sh/include/asm/thread_info.h          |   3 -
 arch/sparc/Kconfig                         |   2 +-
 arch/sparc/Kconfig.debug                   |  14 ++
 arch/sparc/include/asm/irq_32.h            |   1 -
 arch/sparc/include/asm/irq_64.h            |   1 -
 arch/sparc/include/asm/nmi.h               |   1 -
 arch/sparc/include/asm/timer_64.h          |   1 -
 arch/sparc/kernel/kernel.h                 |   1 -
 arch/sparc/kernel/nmi.c                    |  15 +-
 arch/x86/include/asm/irq.h                 |   2 -
 arch/x86/include/asm/mem_encrypt.h         |   3 -
 arch/x86/include/asm/thread_info.h         |   3 -
 arch/x86/include/asm/time.h                |   1 -
 arch/x86/include/asm/tsc.h                 |   1 -
 drivers/perf/arm_pmu.c                     |   5 +
 drivers/perf/arm_pmuv3.c                   |  12 +-
 fs/ocfs2/localalloc.c                      |   2 +-
 fs/ocfs2/ocfs2_trace.h                     |   2 -
 fs/ocfs2/quota_local.c                     |   9 +-
 fs/proc/kcore.c                            |   2 +-
 fs/squashfs/block.c                        | 118 +++++++++-
 fs/squashfs/decompressor.c                 |   1 -
 fs/squashfs/decompressor_multi_percpu.c    |   1 -
 fs/squashfs/squashfs_fs_sb.h               |   1 +
 fs/squashfs/super.c                        |  17 ++
 include/asm-generic/bug.h                  |   5 +-
 include/linux/acpi.h                       |   3 +-
 include/linux/delay.h                      |   1 +
 include/linux/init.h                       |  20 ++
 include/linux/kcov.h                       |  17 ++
 include/linux/math.h                       |  22 +-
 include/linux/mm.h                         |   3 +-
 include/linux/mount.h                      |   2 +
 include/linux/nmi.h                        |  83 ++++---
 include/linux/panic.h                      |   3 +
 include/linux/percpu.h                     |   2 -
 include/linux/perf/arm_pmu.h               |   2 +
 include/linux/syscalls.h                   |   1 +
 include/linux/thread_info.h                |   5 +
 include/linux/time_namespace.h             |   3 +-
 include/linux/types.h                      |   1 +
 init/do_mounts.c                           |  15 +-
 init/main.c                                |  18 --
 kernel/Makefile                            |   3 +-
 kernel/fork.c                              |  10 +-
 kernel/kcov.c                              |   7 +-
 kernel/kexec_core.c                        |  93 +++++---
 kernel/kexec_file.c                        |   7 +-
 kernel/kthread.c                           |   4 +-
 kernel/locking/lock_events.h               |   4 +
 kernel/panic.c                             |   3 +-
 kernel/watchdog.c                          | 356 +++++++++++++++++++++--------
 kernel/watchdog_buddy.c                    | 113 +++++++++
 kernel/{watchdog_hld.c => watchdog_perf.c} | 105 +++------
 lib/Kconfig.debug                          |  84 ++++++-
 lib/decompress_inflate.c                   |   2 +-
 lib/decompress_unxz.c                      |   2 +
 lib/decompress_unzstd.c                    |   2 +
 lib/devmem_is_allowed.c                    |   1 +
 lib/devres.c                               |   2 +-
 lib/kunit/debugfs.c                        |   1 +
 lib/zstd/common/zstd_deps.h                |  18 --
 mm/sparse.c                                |   2 +-
 scripts/checkpatch.pl                      |  10 +
 scripts/spelling.txt                       |  22 ++
 87 files changed, 970 insertions(+), 428 deletions(-)
 create mode 100644 arch/arm64/kernel/watchdog_hld.c
 create mode 100644 kernel/watchdog_buddy.c
 rename kernel/{watchdog_hld.c => watchdog_perf.c} (72%)

