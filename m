Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DBA5FBF00
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 04:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiJLCDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 22:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiJLCDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 22:03:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D99F4D149;
        Tue, 11 Oct 2022 19:03:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26F34612A3;
        Wed, 12 Oct 2022 02:03:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE89C433D6;
        Wed, 12 Oct 2022 02:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1665540222;
        bh=L2p6lD/xrQZQcmwbFXyCNtN4VKrixbrXjc+A1cDkdC0=;
        h=Date:From:To:Cc:Subject:From;
        b=ln/+a1sngVk1adpaEJTeGVvGkVTshrv5WxGiDAHpHf128UaIumoIAECTnXInYOlDX
         RyPC34zPMRL8gE6LPcencoDKOhc/qA2rZZNPaYBRN3iDrmlhMhtVskrn72Y1AlkKF9
         iuyg/hkJV68HRJoOYHP7g6csiXzjVvfmuwzanTto=
Date:   Tue, 11 Oct 2022 19:03:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
Subject: [GIT PULL] non-MM updates for 6.1-rc1
Message-Id: <20221011190341.511a73168c42a296fd6589a6@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

this is the bulk of non-MM changes for this cycle.  Please merge, thanks.


The following changes since commit b90cb1053190353cc30f0fef0ef1f378ccc063c5:

  Linux 6.0-rc3 (2022-08-28 15:05:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-nonmm-stabl=
e-2022-10-11

for you to fetch changes up to 6a961bffd1c3505c13b4d33bbb8385fe08239cb8:

  include/linux/entry-common.h: remove has_signal comment of arch_do_signal=
_or_restart() prototype (2022-10-11 18:51:11 -0700)

----------------------------------------------------------------
- hfs and hfsplus kmap API modernization from Fabio Francesco

- Valentin Schneider makes crash-kexec work properly when invoked from
  an NMI-time panic.

- ntfs bugfixes from Hawkins Jiawei

- Jiebin Sun improves IPC msg scalability by replacing atomic_t's with
  percpu counters.

- nilfs2 cleanups from Minghao Chi

- lots of other single patches all over the tree!

----------------------------------------------------------------
Alexey Dobriyan (2):
      proc: mark more files as permanent
      proc: test how it holds up with mapping'less process

Andrew Morton (1):
      fs: uninline inode_maybe_inc_iversion()

Andy Shevchenko (1):
      asm-generic: make parameter types consistent in _unaligned_be48()

Arnd Bergmann (1):
      treewide: defconfig: address renamed CONFIG_DEBUG_INFO=3Dy

Borislav Petkov (1):
      scripts/decodecode: improve faulting line determination

Brian Foster (1):
      proc: save LOC in vsyscall test

Fabio M. De Francesco (9):
      hfsplus: unmap the page in the "fail_page" label
      hfsplus: convert kmap() to kmap_local_page() in bnode.c
      hfsplus: convert kmap() to kmap_local_page() in bitmap.c
      hfsplus: convert kmap() to kmap_local_page() in btree.c
      fs/isofs: replace kmap() with kmap_local_page()
      kexec: replace kmap() with kmap_local_page()
      hfs: unmap the page in the "fail_page" label
      hfs: replace kmap() with kmap_local_page() in bnode.c
      hfs: replace kmap() with kmap_local_page() in btree.c

Frank Rowand (1):
      mailmap: update Frank Rowand email address

Guilherme G. Piccoli (1):
      firmware: google: test spinlock on panic path to avoid lockups

Gustavo A. R. Silva (1):
      ocfs2: replace zero-length arrays with DECLARE_FLEX_ARRAY() helper

Hawkins Jiawei (3):
      ntfs: fix use-after-free in ntfs_attr_find()
      ntfs: fix out-of-bounds read in ntfs_attr_find()
      ntfs: check overflow when iterating ATTR_RECORDs

Ira Weiny (1):
      checkpatch: add kmap and kmap_atomic to the deprecated list

Jiangshan Yi (2):
      fs/ocfs2/suballoc.h: fix spelling typo in comment
      init.h: fix spelling typo in comment

Jiebin Sun (2):
      percpu: add percpu_counter_add_local and percpu_counter_sub_local
      ipc/msg: mitigate the lock contention with percpu counter

Jingyu Wang (1):
      ipc: mqueue: remove unnecessary conditionals

Kefeng Wang (1):
      kernel: exit: cleanup release_thread()

Li zeming (1):
      usr/gen_init_cpio.c: remove unnecessary -1 values from int file

Lukas Bulwahn (2):
      proc: make config PROC_CHILDREN depend on PROC_FS
      ia64: update config files

Manfred Spraul (1):
      ipc/util.c: cleanup and improve sysvipc_find_ipc()

Micka=EBl Sala=FCn (1):
      checkpatch: handle FILE pointer type

Minghao Chi (2):
      fs/qnx6: delete unnecessary checks before brelse()
      nilfs2: delete unnecessary checks before brelse()

Neel Natu (1):
      lib/cmdline: avoid page fault in next_arg

Niklas S=F6derlund (1):
      checkpatch: warn for non-standard fixes tag style

Petr Vorel (1):
      kernel/utsname_sysctl.c: print kernel arch

Ren Zhijie (1):
      init/Kconfig: fix unmet direct dependencies

Ryusuke Konishi (1):
      nilfs2: replace WARN_ONs by nilfs_error for checkpoint acquisition fa=
ilure

Sergei Trofimovich (1):
      ia64: fix clock_getres(CLOCK_MONOTONIC) to report ITC frequency

Tiezhu Yang (1):
      include/linux/entry-common.h: remove has_signal comment of arch_do_si=
gnal_or_restart() prototype

Uros Bizjak (8):
      llist: use try_cmpxchg in llist_add_batch and llist_del_first
      epoll: use try_cmpxchg in list_add_tail_lockless
      buffer: use try_cmpxchg in discard_buffer
      aio: use atomic_try_cmpxchg in __get_reqs_available
      iversion: use atomic64_try_cmpxchg)
      bitops: use try_cmpxchg in set_mask_bits and bit_clear_unless
      task_work: use try_cmpxchg in task_work_add, task_work_cancel_match a=
nd task_work_run
      smpboot: use atomic_try_cmpxchg in cpu_wait_death and cpu_report_death

Valentin Schneider (2):
      kexec: turn all kexec_mutex acquisitions into trylocks
      panic, kexec: make __crash_kexec() NMI safe

Wolfram Sang (6):
      alpha: move from strlcpy with unused retval to strscpy
      ia64: move from strlcpy with unused retval to strscpy
      ocfs2: move from strlcpy with unused retval to strscpy
      reiserfs: move from strlcpy with unused retval to strscpy
      init: move from strlcpy with unused retval to strscpy
      lib: move from strlcpy with unused retval to strscpy

Xu Panda (1):
      fork: remove duplicate included header files

Yang Yingliang (3):
      fail_function: switch to memdup_user_nul() helper
      fail_function: refactor code of checking return value of register_kpr=
obe()
      fail_function: fix wrong use of fei_attr_remove()

Zhou jie (1):
      init/main.c: remove unnecessary (void*) conversions

wangjianli (1):
      fs/ocfs2: fix repeated words in comments

wuchi (4):
      initramfs: mark my_inptr as __initdata
      kernel/profile.c: simplify duplicated code in profile_setup()
      latencytop: use the last element of latency_record of system
      relay: use kvcalloc to alloc page array in relay_alloc_page_array

xu xin (1):
      ia64: mca: use strscpy() is more robust and safer

ye xingchen (1):
      nilfs2: remove the unneeded result variable

 .mailmap                                     |   1 +
 Documentation/admin-guide/sysctl/kernel.rst  |   5 +
 Documentation/dev-tools/checkpatch.rst       |   7 +
 arch/alpha/configs/defconfig                 |   2 +-
 arch/alpha/include/asm/processor.h           |   2 -
 arch/alpha/kernel/process.c                  |   5 -
 arch/alpha/kernel/setup.c                    |   4 +-
 arch/arc/configs/tb10x_defconfig             |   2 +-
 arch/arc/include/asm/processor.h             |   3 -
 arch/arm/include/asm/processor.h             |   3 -
 arch/arm/kernel/process.c                    |   4 -
 arch/arm64/include/asm/processor.h           |   3 -
 arch/arm64/kernel/process.c                  |   4 -
 arch/csky/include/asm/processor.h            |   5 -
 arch/hexagon/include/asm/processor.h         |   4 -
 arch/hexagon/kernel/process.c                |   7 -
 arch/ia64/configs/bigsur_defconfig           |   2 -
 arch/ia64/configs/generic_defconfig          |   2 -
 arch/ia64/configs/gensparse_defconfig        |   3 -
 arch/ia64/configs/tiger_defconfig            |   2 -
 arch/ia64/configs/zx1_defconfig              |   1 -
 arch/ia64/include/asm/processor.h            |   7 -
 arch/ia64/kernel/mca.c                       |   2 +-
 arch/ia64/kernel/setup.c                     |   2 +-
 arch/ia64/kernel/sys_ia64.c                  |  26 ++
 arch/ia64/kernel/syscalls/syscall.tbl        |   2 +-
 arch/loongarch/include/asm/processor.h       |   3 -
 arch/m68k/include/asm/processor.h            |   5 -
 arch/microblaze/configs/mmu_defconfig        |   2 +-
 arch/microblaze/include/asm/processor.h      |   5 -
 arch/mips/configs/bcm47xx_defconfig          |   2 +-
 arch/mips/configs/cavium_octeon_defconfig    |   2 +-
 arch/mips/configs/ci20_defconfig             |   2 +-
 arch/mips/configs/cu1000-neo_defconfig       |   2 +-
 arch/mips/configs/cu1830-neo_defconfig       |   2 +-
 arch/mips/configs/generic_defconfig          |   2 +-
 arch/mips/configs/omega2p_defconfig          |   2 +-
 arch/mips/configs/qi_lb60_defconfig          |   2 +-
 arch/mips/configs/vocore2_defconfig          |   2 +-
 arch/mips/include/asm/processor.h            |   3 -
 arch/nios2/configs/10m50_defconfig           |   2 +-
 arch/nios2/configs/3c120_defconfig           |   2 +-
 arch/nios2/include/asm/processor.h           |   5 -
 arch/openrisc/include/asm/processor.h        |   1 -
 arch/openrisc/kernel/process.c               |   4 -
 arch/parisc/include/asm/processor.h          |   3 -
 arch/parisc/kernel/process.c                 |   4 -
 arch/powerpc/include/asm/processor.h         |   1 -
 arch/powerpc/kernel/process.c                |   5 -
 arch/riscv/include/asm/processor.h           |   5 -
 arch/s390/include/asm/processor.h            |   3 -
 arch/sh/configs/apsh4a3a_defconfig           |   2 +-
 arch/sh/configs/apsh4ad0a_defconfig          |   2 +-
 arch/sh/configs/edosk7760_defconfig          |   2 +-
 arch/sh/configs/magicpanelr2_defconfig       |   2 +-
 arch/sh/configs/polaris_defconfig            |   2 +-
 arch/sh/configs/r7780mp_defconfig            |   2 +-
 arch/sh/configs/r7785rp_defconfig            |   2 +-
 arch/sh/configs/rsk7203_defconfig            |   2 +-
 arch/sh/configs/sdk7780_defconfig            |   2 +-
 arch/sh/configs/se7712_defconfig             |   2 +-
 arch/sh/configs/se7721_defconfig             |   2 +-
 arch/sh/configs/sh2007_defconfig             |   2 +-
 arch/sh/configs/sh7757lcr_defconfig          |   2 +-
 arch/sh/configs/sh7785lcr_32bit_defconfig    |   2 +-
 arch/sh/configs/urquell_defconfig            |   2 +-
 arch/sh/include/asm/processor_32.h           |   3 -
 arch/sh/kernel/process_32.c                  |   5 -
 arch/sparc/include/asm/processor_32.h        |   3 -
 arch/sparc/include/asm/processor_64.h        |   3 -
 arch/um/configs/i386_defconfig               |   2 +-
 arch/um/configs/x86_64_defconfig             |   2 +-
 arch/um/include/asm/processor-generic.h      |   4 -
 arch/x86/include/asm/processor.h             |   3 -
 arch/xtensa/configs/audio_kc705_defconfig    |   2 +-
 arch/xtensa/configs/cadence_csp_defconfig    |   2 +-
 arch/xtensa/configs/generic_kc705_defconfig  |   2 +-
 arch/xtensa/configs/nommu_kc705_defconfig    |   2 +-
 arch/xtensa/configs/smp_lx200_defconfig      |   2 +-
 arch/xtensa/configs/virt_defconfig           |   2 +-
 arch/xtensa/configs/xip_kc705_defconfig      |   2 +-
 arch/xtensa/include/asm/processor.h          |   3 -
 drivers/firmware/google/gsmi.c               |   9 +
 fs/aio.c                                     |   9 +-
 fs/buffer.c                                  |  14 +-
 fs/eventpoll.c                               |   2 +-
 fs/hfs/bnode.c                               |  32 +--
 fs/hfs/btree.c                               |  29 +-
 fs/hfsplus/bitmap.c                          |  20 +-
 fs/hfsplus/bnode.c                           | 105 ++++----
 fs/hfsplus/btree.c                           |  27 +-
 fs/isofs/compress.c                          |  20 +-
 fs/libfs.c                                   |  46 ++++
 fs/nilfs2/btree.c                            |   6 +-
 fs/nilfs2/segment.c                          |  18 +-
 fs/ntfs/attrib.c                             |  28 +-
 fs/ntfs/inode.c                              |   7 +
 fs/ocfs2/ocfs2_fs.h                          |   8 +-
 fs/ocfs2/refcounttree.c                      |   2 +-
 fs/ocfs2/stackglue.c                         |   4 +-
 fs/ocfs2/suballoc.h                          |   2 +-
 fs/ocfs2/super.c                             |   2 +-
 fs/proc/Kconfig                              |   1 +
 fs/proc/devices.c                            |   6 +-
 fs/proc/internal.h                           |   5 +
 fs/proc/loadavg.c                            |   6 +-
 fs/proc/meminfo.c                            |   5 +-
 fs/proc/page.c                               |   3 +
 fs/proc/softirqs.c                           |   6 +-
 fs/proc/uptime.c                             |   6 +-
 fs/proc/version.c                            |   6 +-
 fs/qnx6/inode.c                              |   6 +-
 fs/reiserfs/procfs.c                         |   4 +-
 include/asm-generic/unaligned.h              |   2 +-
 include/linux/bitops.h                       |  11 +-
 include/linux/entry-common.h                 |   1 -
 include/linux/init.h                         |   2 +-
 include/linux/ipc_namespace.h                |   5 +-
 include/linux/iversion.h                     |  72 +----
 include/linux/kexec.h                        |   2 +-
 include/linux/percpu_counter.h               |  32 +++
 include/linux/sched/task.h                   |   3 +
 init/Kconfig                                 |   1 +
 init/do_mounts.c                             |   4 +-
 init/initramfs.c                             |   2 +-
 init/main.c                                  |   8 +-
 ipc/mqueue.c                                 |   3 +-
 ipc/msg.c                                    |  48 +++-
 ipc/namespace.c                              |   5 +-
 ipc/util.c                                   |  53 ++--
 ipc/util.h                                   |   4 +-
 kernel/exit.c                                |   4 +
 kernel/fail_function.c                       |  26 +-
 kernel/fork.c                                |   1 -
 kernel/kexec.c                               |  11 +-
 kernel/kexec_core.c                          |  36 +--
 kernel/kexec_file.c                          |   4 +-
 kernel/kexec_internal.h                      |  15 +-
 kernel/ksysfs.c                              |   7 +-
 kernel/latencytop.c                          |   4 +-
 kernel/profile.c                             |  32 +--
 kernel/relay.c                               |   5 +-
 kernel/smpboot.c                             |  15 +-
 kernel/task_work.c                           |  16 +-
 kernel/utsname_sysctl.c                      |   7 +
 lib/cmdline.c                                |   2 +-
 lib/earlycpio.c                              |   2 +-
 lib/llist.c                                  |  12 +-
 scripts/checkpatch.pl                        |  52 +++-
 scripts/decodecode                           | 120 +++++++--
 tools/testing/selftests/proc/.gitignore      |   1 +
 tools/testing/selftests/proc/Makefile        |   1 +
 tools/testing/selftests/proc/proc-empty-vm.c | 386 +++++++++++++++++++++++=
++++
 tools/testing/selftests/proc/proc-pid-vm.c   |  56 ++--
 usr/gen_init_cpio.c                          |   2 +-
 155 files changed, 1154 insertions(+), 618 deletions(-)
 create mode 100644 tools/testing/selftests/proc/proc-empty-vm.c

