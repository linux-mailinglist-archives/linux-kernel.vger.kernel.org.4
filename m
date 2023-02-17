Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17DB69A31B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 01:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjBQAuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 19:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjBQAuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 19:50:02 -0500
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F20454D2B;
        Thu, 16 Feb 2023 16:49:58 -0800 (PST)
X-QQ-mid: bizesmtp76t1676594968txapoplj
Received: from localhost.localdomain ( [116.30.131.224])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 17 Feb 2023 08:49:27 +0800 (CST)
X-QQ-SSF: 01200000000000C0T000000A0000000
X-QQ-FEAT: XBN7tc9DADICBB7k9+bU2BGS/LL6SOD01z1AvX6M7TbM1IcrrUquN8VoZSqxR
        z7Nk+jrerltyFZKM69igDS4EKfCoEx4eH6SS0q3im5pC77mpjTus7/qkaA/0Ohf5qWxBiSC
        4Hu8t+EjNzV8mnlaxl1RoP2a/5sdzMO7dKFr4PtGFbPx5rSV0crjKNH4ttqQ0A/7z7SWxWg
        aMh+cL67CSCH4xi5C/PYiEmJeaIhgaE2hjsHbq5zyRgiIf199tLovOH5MfKhtGcX+ZRBUtS
        /F5sSaWtSDT54mwaeY3AWMVidSPEJQFeZ4yEZQ1Ona/TpGryQoxiRjY8ah9acgpXRU6BL00
        6KmZ3DS5NXoEdmkiTnOykaFz6Cu8YR/8elR/E2knszdeujRYJlXTp5UEK5Y9VGt5LfrcCrG
X-QQ-GoodBg: 0
From:   Zhangjin Wu <falcon@tinylab.org>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Palmer Dabbelt <palmer@rivosinc.com>, Willy Tarreau <w@1wt.eu>,
        Paul Burton <paulburton@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Zhangjin Wu <falcon@tinylab.org>
Subject: [RFC PATCH 0/5] Add dead syscalls elimination support
Date:   Fri, 17 Feb 2023 08:49:20 +0800
Message-Id: <cover.1676594211.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all

CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION allows to eliminate dead code
and data, this patchset allows to further eliminate dead syscalls which
are not used in target system.

It includes 5 patches:

- syscall: Allow configure used system calls

  This adds a new CONFIG_SYSCALLS_USED option to allow users or tools to
  tell kernel what syscalls are used in target system. A list of
  used syscalls can be passed to it.

- MIPS: Add dead syscalls elimination support

  Add CONFIG_SYSCALLS_USED support for mips, it simply adds a 'used'
  variant for the syscall*.tbl and accordingly updates the kernel apis
  and eventually the sys_call_table. The unused ones in the table are
  replaced by sys_ni_syscall and therefore if they are also not used by
  kernel itself, they will be eliminated by gc-sections.

  The old architectures use syscall*.tbl, so, they can use this method.

- RISC-V: Enable dead code elimination

  Select HAVE_LD_DEAD_CODE_DATA_ELIMINATION for riscv.

- RISC-V: Add dead syscalls elimination support

  Add CONFIG_SYSCALLS_USED support for riscv, it simply adds a 'used'
  variant for the *syscall_table.c and eventually the sys_call_table.

  The new architectures use generic unistd.h, they can use this method.

- nolibc: Record used syscalls in their own sections

  This allows to record syscalls used by a nolibc based application. It
  is possible to eliminate dead syscalls automatically while building
  the monolithic kernel+nolibc software.

Testing shows, on both mips and riscv, with a small config, gc-sections
shrinks ~10% and syscalls_used shrinks another ~5%.

This patchset is only a prototype implementation, welcome your feedback
and suggestion, Thanks.

Related emails:

- Re: Re: Kernel-only deployments
  https://lore.kernel.org/lkml/20230216130935.37976-1-falcon@tinylab.org/

- Re: Re: RISC-V: Enable dead code elimination
  https://lore.kernel.org/linux-riscv/Y+qSBu3YZH0JPY4I@spud/T/#t

Best Regards,
- Zhangjin Wu

---

Zhangjin Wu (5):
  syscall: Allow configure used system calls
  MIPS: Add dead syscalls elimination support
  RISC-V: Enable dead code elimination
  RISC-V: Add dead syscalls elimination support
  nolibc: Record used syscalls in their own sections

 arch/mips/Kconfig                   |  1 +
 arch/mips/kernel/syscalls/Makefile  | 24 ++++++++-
 arch/riscv/Kconfig                  |  2 +
 arch/riscv/kernel/Makefile          |  5 +-
 arch/riscv/kernel/syscalls/Makefile | 38 ++++++++++++++
 arch/riscv/kernel/vmlinux.lds.S     |  2 +-
 init/Kconfig                        | 22 +++++++++
 tools/include/nolibc/Makefile       |  2 +-
 tools/include/nolibc/arch-aarch64.h | 17 ++++---
 tools/include/nolibc/arch-arm.h     | 15 +++---
 tools/include/nolibc/arch-i386.h    | 17 ++++---
 tools/include/nolibc/arch-mips.h    | 15 +++---
 tools/include/nolibc/arch-riscv.h   | 17 ++++---
 tools/include/nolibc/arch-x86_64.h  | 17 ++++---
 tools/include/nolibc/arch.h         |  2 +
 tools/include/nolibc/record.h       | 77 +++++++++++++++++++++++++++++
 16 files changed, 226 insertions(+), 47 deletions(-)
 create mode 100644 arch/riscv/kernel/syscalls/Makefile
 create mode 100644 tools/include/nolibc/record.h

-- 
2.25.1

