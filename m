Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D90764A9A9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 22:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbiLLVoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 16:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbiLLVob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 16:44:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA73513E35;
        Mon, 12 Dec 2022 13:44:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8306EB80CCA;
        Mon, 12 Dec 2022 21:44:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1D6C433EF;
        Mon, 12 Dec 2022 21:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1670881466;
        bh=aq83rbzGvHma+lAf/GnhBTYFP26IXcg67Dwi7SYgaAM=;
        h=Date:From:To:Cc:Subject:From;
        b=VOygyCzZX0m/3et257MPeRXQ1QVH2rwG25U+m2zk6ZOOQ2cevwZ0Ixb+Zpgqpxc+x
         9d3XATOko4vEBrfBKu1eCz7J37UZALJ6wmKofXfbJLYXXYx/pimSkLPIIfaw2EWzoz
         c7C3T0XSbapp3gMYDk4XQ+zQ8cm01zcH6KDnGX44=
Date:   Mon, 12 Dec 2022 13:44:25 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] non-MM commits for 6.2-rc1
Message-Id: <20221212134425.b20b80955e5e8a4a36ce1b9a@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please merge this cycle's batch on non-MM updates, thanks.

I'll get the MM tree over tomorrow, hopefully.  David went and broke it
as it was being loaded into Santa's sleigh but Sidhartha has some glue.
(https://lkml.kernel.org/r/62ca3baf-4220-e69f-2218-3b4a157e88f0@oracle.com)


The following changes since commit f0c4d9fc9cc9462659728d168387191387e903cc:

  Linux 6.1-rc4 (2022-11-06 15:07:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-nonmm-stable-2022-12-12

for you to fetch changes up to 12b677f2c697d61e5ddbcb6c1650050a39392f54:

  ipc: fix memory leak in init_mqueue_fs() (2022-12-11 19:30:20 -0800)

----------------------------------------------------------------
Non-MM patches for 6.2-rc1.

- A ptrace API cleanup series from Sergey Shtylyov

- Fixes and cleanups for kexec from ye xingchen

- nilfs2 updates from Ryusuke Konishi

- squashfs feature work from Xiaoming Ni: permit configuration of the
  filesystem's compression concurrency from the mount command line.

- A series from Akinobu Mita which addresses bound checking errors when
  writing to debugfs files.

- A series from Yang Yingliang to address rapido memory leaks

- A series from Zheng Yejian to address possible overflow errors in
  encode_comp_t().

- And a whole shower of singleton patches all over the place.

----------------------------------------------------------------
Aditya Garg (1):
      hfsplus: fix bug causing custom uid and gid being unable to be assigned with mount

Akinobu Mita (3):
      libfs: add DEFINE_SIMPLE_ATTRIBUTE_SIGNED for signed value
      lib/notifier-error-inject: fix error when writing -errno to debugfs file
      debugfs: fix error when writing negative value to atomic_t debugfs file

Alexey Asemov (1):
      ocfs2: always read both high and low parts of dinode link count

Alexey Dobriyan (2):
      proc: give /proc/cmdline size
      proc: fixup uptime selftest

Anders Roxell (1):
      kernel: kcsan: kcsan_test: build without structleak plugin

Andy Shevchenko (1):
      panic: use str_enabled_disabled() helper

Baokun Li (1):
      squashfs: fix null-ptr-deref in squashfs_fill_super

Bjorn Helgaas (2):
      checkpatch: add warning for non-lore mailing list URLs
      ia64: remove unused __SLOW_DOWN_IO and SLOW_DOWN_IO definitions

Bo Liu (1):
      fat (exportfs): fix some kernel-doc warnings

Cai Xinchen (1):
      rapidio: devices: fix missing put_device in mport_cdev_open

Chen Lifu (1):
      ARM: kexec: make machine_crash_nonpanic_core() static

Christophe JAILLET (1):
      io-mapping: move some code within the include guarded section

Colin Ian King (2):
      lib/oid_registry.c: remove redundant assignment to variable num
      scripts/spelling.txt: add more spellings to spelling.txt

Gaosheng Cui (2):
      ia64/kprobes: remove orphan declarations from arch/ia64/include/asm/kprobes.h
      lib/fonts: fix undefined behavior in bit shift for get_default_font

Gavrilov Ilia (1):
      relay: fix type mismatch when allocating memory in relay_create_buf()

Iskren Chernev (1):
      mailmap: update email for Iskren Chernev

Ivan Babrou (1):
      proc: report open files as size in stat() for /proc/pid/fd

Jason A. Donenfeld (3):
      minmax: sanity check constant bounds when clamping
      minmax: clamp more efficiently by avoiding extra comparison
      wifi: rt2x00: use explicitly signed or unsigned types

Jianglei Nie (1):
      proc/vmcore: fix potential memory leak in vmcore_init()

Joseph Qi (3):
      ocfs2/cluster: use bitmap API instead of hand-writing it
      ocfs2: use bitmap API in fill_node_map
      ocfs2/dlm: use bitmap API instead of hand-writing it

Li Chen (1):
      kexec: replace crash_mem_range with range

Li Zetao (1):
      ocfs2: fix memory leak in ocfs2_mount_volume()

Liao Chang (1):
      checkpatch: add check for array allocator family argument order

Masahiro Yamada (1):
      linux/init.h: include <linux/build_bug.h> and <linux/stringify.h>

Oleksandr Natalenko (1):
      core_pattern: add CPU specifier

Palmer Dabbelt (1):
      MAINTAINERS: git://github -> https://github.com for linux-test-project

Rong Tao (2):
      lib/radix-tree.c: fix uninitialized variable compilation warning
      kcov: fix spelling typos in comments

Ryusuke Konishi (2):
      nilfs2: fix shift-out-of-bounds/overflow in nilfs_sb2_bad_offset()
      nilfs2: fix shift-out-of-bounds due to too large exponent of block size

Sergey Shtylyov (13):
      arc: ptrace: user_regset_copyin_ignore() always returns 0
      arm: ptrace: user_regset_copyin_ignore() always returns 0
      arm64: ptrace: user_regset_copyin_ignore() always returns 0
      hexagon: ptrace: user_regset_copyin_ignore() always returns 0
      ia64: ptrace: user_regset_copyin_ignore() always returns 0
      mips: ptrace: user_regset_copyin_ignore() always returns 0
      nios2: ptrace: user_regset_copyin_ignore() always returns 0
      openrisc: ptrace: user_regset_copyin_ignore() always returns 0
      parisc: ptrace: user_regset_copyin_ignore() always returns 0
      powerpc: ptrace: user_regset_copyin_ignore() always returns 0
      sh: ptrace: user_regset_copyin_ignore() always returns 0
      sparc: ptrace: user_regset_copyin_ignore() always returns 0
      regset: make user_regset_copyin_ignore() *void*

Shang XiaoJing (1):
      ocfs2: fix memory leak in ocfs2_stack_glue_init()

Stanislaw Gruszka (1):
      scripts: checkpatch: allow "case" macros

Stephen Brennan (1):
      vmcoreinfo: warn if we exceed vmcoreinfo data size

Tetsuo Handa (1):
      rapidio/tsi721: replace flush_scheduled_work() with flush_work()

Uros Bizjak (2):
      llist: avoid extra memory read in llist_add_batch
      sched/fair: use try_cmpxchg in task_numa_work

Wang Weiyang (1):
      rapidio: fix possible UAF when kfifo_alloc() fails

XU pengfei (1):
      initramfs: remove unnecessary (void*) conversion

Xiaoming Ni (2):
      squashfs: add the mount parameter theads=<single|multi|percpu>
      squashfs: allows users to configure the number of decompression threads

Xiongfeng Wang (1):
      tools/accounting/procacct: remove some unused variables

Xu Panda (1):
      relay: use strscpy() is more robust and safer

Yang Yingliang (2):
      rapidio: fix possible name leaks when rio_add_device() fails
      rapidio: rio: fix possible name leak in rio_register_mport()

YueHaibing (1):
      selftests: cgroup: fix unsigned comparison with less than zero

Yury Norov (1):
      cpumask: limit visibility of FORCE_NR_CPUS

Zhang Qilong (1):
      eventfd: change int to __u64 in eventfd_signal() ifndef CONFIG_EVENTFD

ZhangPeng (2):
      hfs: fix OOB Read in __hfs_brec_find
      hfs: Fix OOB Write in hfs_asc2mac

Zhao Gongyi (1):
      selftests/vm: add local_config.h and local_config.mk to .gitignore

Zheng Yejian (2):
      acct: fix accuracy loss for input value of encode_comp_t()
      acct: fix potential integer overflow in encode_comp_t()

Zhengchao Shao (1):
      ipc: fix memory leak in init_mqueue_fs()

wuchi (1):
      lib/debugobjects: fix stat count and optimize debug_objects_mem_init

ye xingchen (2):
      kexec: remove the unneeded result variable
      ia64: replace IS_ERR() with IS_ERR_VALUE()

 .mailmap                                          |   1 +
 Documentation/admin-guide/sysctl/kernel.rst       |   1 +
 Documentation/fault-injection/fault-injection.rst |  10 +--
 Documentation/filesystems/proc.rst                |  17 ++++
 MAINTAINERS                                       |   2 +-
 arch/arc/kernel/ptrace.c                          |   2 +-
 arch/arm/kernel/machine_kexec.c                   |   2 +-
 arch/arm/kernel/ptrace.c                          |   8 +-
 arch/arm64/kernel/ptrace.c                        |  16 +---
 arch/hexagon/kernel/ptrace.c                      |   7 +-
 arch/ia64/include/asm/io.h                        |   4 -
 arch/ia64/include/asm/kprobes.h                   |   2 -
 arch/ia64/kernel/ptrace.c                         |  20 ++---
 arch/ia64/kernel/sys_ia64.c                       |   6 +-
 arch/mips/kernel/ptrace.c                         |   9 +-
 arch/nios2/kernel/ptrace.c                        |   6 +-
 arch/openrisc/kernel/ptrace.c                     |   8 +-
 arch/parisc/kernel/ptrace.c                       |  15 ++--
 arch/powerpc/kernel/ptrace/ptrace-tm.c            |  10 +--
 arch/powerpc/kernel/ptrace/ptrace-view.c          |  15 ++--
 arch/powerpc/kexec/file_load_64.c                 |   2 +-
 arch/powerpc/kexec/ranges.c                       |   8 +-
 arch/sh/kernel/ptrace_32.c                        |   8 +-
 arch/sparc/kernel/ptrace_32.c                     |   9 +-
 arch/sparc/kernel/ptrace_64.c                     |  23 +++--
 drivers/net/wireless/ralink/rt2x00/rt2400pci.c    |   8 +-
 drivers/net/wireless/ralink/rt2x00/rt2400pci.h    |   2 +-
 drivers/net/wireless/ralink/rt2x00/rt2500pci.c    |   8 +-
 drivers/net/wireless/ralink/rt2x00/rt2500pci.h    |   2 +-
 drivers/net/wireless/ralink/rt2x00/rt2500usb.c    |   8 +-
 drivers/net/wireless/ralink/rt2x00/rt2500usb.h    |   2 +-
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c    |  60 ++++++-------
 drivers/net/wireless/ralink/rt2x00/rt2800lib.h    |   8 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00usb.c    |   6 +-
 drivers/net/wireless/ralink/rt2x00/rt61pci.c      |   4 +-
 drivers/net/wireless/ralink/rt2x00/rt61pci.h      |   2 +-
 drivers/net/wireless/ralink/rt2x00/rt73usb.c      |   4 +-
 drivers/net/wireless/ralink/rt2x00/rt73usb.h      |   2 +-
 drivers/rapidio/devices/rio_mport_cdev.c          |  15 ++--
 drivers/rapidio/devices/tsi721.c                  |   3 +-
 drivers/rapidio/rio-scan.c                        |   8 +-
 drivers/rapidio/rio.c                             |   9 +-
 fs/coredump.c                                     |   5 ++
 fs/debugfs/file.c                                 |  28 ++++--
 fs/fat/nfs.c                                      |   4 +-
 fs/hfs/inode.c                                    |   2 +
 fs/hfs/trans.c                                    |   2 +-
 fs/hfsplus/hfsplus_fs.h                           |   2 +
 fs/hfsplus/inode.c                                |   4 +-
 fs/hfsplus/options.c                              |   4 +
 fs/libfs.c                                        |  22 ++++-
 fs/nilfs2/the_nilfs.c                             |  73 ++++++++++++++--
 fs/ocfs2/cluster/heartbeat.c                      |  38 ++++----
 fs/ocfs2/cluster/heartbeat.h                      |   2 +-
 fs/ocfs2/cluster/netdebug.c                       |   2 +-
 fs/ocfs2/cluster/nodemanager.c                    |   2 +-
 fs/ocfs2/cluster/tcp.c                            |   6 +-
 fs/ocfs2/dlm/dlmcommon.h                          |   2 +-
 fs/ocfs2/dlm/dlmdomain.c                          |  19 ++--
 fs/ocfs2/dlm/dlmmaster.c                          |  30 +++----
 fs/ocfs2/dlm/dlmrecovery.c                        |   2 +-
 fs/ocfs2/journal.c                                |   2 +-
 fs/ocfs2/journal.h                                |   1 +
 fs/ocfs2/ocfs2.h                                  |   3 +-
 fs/ocfs2/stack_o2cb.c                             |   6 +-
 fs/ocfs2/stackglue.c                              |   8 +-
 fs/ocfs2/super.c                                  |   5 +-
 fs/proc/cmdline.c                                 |   6 +-
 fs/proc/fd.c                                      |  45 ++++++++++
 fs/proc/vmcore.c                                  |   1 +
 fs/squashfs/Kconfig                               |  51 +++++++++--
 fs/squashfs/block.c                               |   2 +-
 fs/squashfs/decompressor.c                        |   2 +-
 fs/squashfs/decompressor_multi.c                  |  20 +++--
 fs/squashfs/decompressor_multi_percpu.c           |  23 +++--
 fs/squashfs/decompressor_single.c                 |  15 +++-
 fs/squashfs/squashfs.h                            |  23 +++--
 fs/squashfs/squashfs_fs_sb.h                      |   4 +-
 fs/squashfs/super.c                               | 100 +++++++++++++++++++++-
 include/linux/coredump.h                          |   1 +
 include/linux/debugfs.h                           |  19 +++-
 include/linux/eventfd.h                           |   2 +-
 include/linux/fs.h                                |  12 ++-
 include/linux/init.h                              |   3 +
 include/linux/io-mapping.h                        |   4 +-
 include/linux/kcov.h                              |   2 +-
 include/linux/kexec.h                             |   7 +-
 include/linux/minmax.h                            |  26 +++++-
 include/linux/regset.h                            |  15 ++--
 init/initramfs.c                                  |   2 +-
 init/main.c                                       |   7 +-
 ipc/mqueue.c                                      |   6 +-
 kernel/acct.c                                     |   6 +-
 kernel/crash_core.c                               |   3 +
 kernel/kcsan/Makefile                             |   1 +
 kernel/kexec_core.c                               |  10 +--
 kernel/kexec_file.c                               |   2 +-
 kernel/panic.c                                    |   5 +-
 kernel/relay.c                                    |   8 +-
 kernel/sched/fair.c                               |   2 +-
 lib/Kconfig                                       |   4 +-
 lib/debugobjects.c                                |  10 +++
 lib/fonts/fonts.c                                 |   4 +-
 lib/llist.c                                       |   4 +-
 lib/notifier-error-inject.c                       |   2 +-
 lib/oid_registry.c                                |   1 -
 lib/radix-tree.c                                  |   2 +-
 scripts/checkpatch.pl                             |  20 ++++-
 scripts/spelling.txt                              |  33 ++++++-
 tools/accounting/procacct.c                       |   7 +-
 tools/testing/selftests/cgroup/cgroup_util.c      |   5 +-
 tools/testing/selftests/proc/proc-uptime-002.c    |   3 +-
 tools/testing/selftests/vm/.gitignore             |   2 +
 113 files changed, 808 insertions(+), 360 deletions(-)

