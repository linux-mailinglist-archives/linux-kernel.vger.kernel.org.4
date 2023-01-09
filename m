Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7341661EA9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 07:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbjAIGYu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Jan 2023 01:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjAIGYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 01:24:22 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A047BE14
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 22:24:17 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id DF58924E035;
        Mon,  9 Jan 2023 14:24:15 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 9 Jan
 2023 14:24:15 +0800
Received: from jsia-virtual-machine.localdomain (60.49.128.133) by
 EXMBX066.cuchost.com (172.16.6.66) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Mon, 9 Jan 2023 14:24:12 +0800
From:   Sia Jee Heng <jeeheng.sia@starfivetech.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <jeeheng.sia@starfivetech.com>, <leyfoon.tan@starfivetech.com>,
        <mason.huo@starfivetech.com>
Subject: [PATCH v2 0/3] RISC-V Hibernation Support
Date:   Mon, 9 Jan 2023 14:24:04 +0800
Message-ID: <20230109062407.3235-1-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [60.49.128.133]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds RISC-V Hibernation/suspend to disk support.
Low level Arch functions were created to support hibernation.
swsusp_arch_suspend() relies code from __cpu_suspend_enter() to write
cpu state onto the stack, then calling swsusp_save() to save the memory
image.

arch_hibernation_header_restore() and arch_hibernation_header_save()
functions are implemented to prevent kernel crash when resume,
the kernel built version is saved into the hibernation image header
to making sure only the same kernel is restore when resume.

swsusp_arch_resume() creates a temporary page table that covering only
the linear map, copies the restore code to a 'safe' page, then start to
restore the memory image. Once completed, it restores the original
kernel's page table. It then calls into __hibernate_cpu_resume()
to restore the CPU context. Finally, it follows the normal hibernation
path back to the hibernation core.

To enable hibernation/suspend to disk into RISCV, the below config
need to be enabled:
- CONFIG_ARCH_HIBERNATION_HEADER
- CONFIG_ARCH_HIBERNATION_POSSIBLE
- CONFIG_ARCH_RV64I
- CONFIG_64BIT

At high-level, this series includes the following changes:
1) Change suspend_save_csrs() and suspend_restore_csrs()
   to public function as these functions are common to
   suspend/hibernation. (patch 1)
2) Enhance kernel_page_present() function to support huge page. (patch 2)
3) Add arch/riscv low level functions to support
   hibernation/suspend to disk. (patch 3)

The above patches are based on kernel v6.2-rc3 and are tested on
StarFive VF2 SBC board. Hibernation for RV32 and ACPI platform mode are not
supported in this series at the moment.

Changes since v1:
- Rebased to kernel v6.2-rc3
- Fixed bot's compilation error

Sia Jee Heng (3):
  RISC-V: Change suspend_save_csrs and suspend_restore_csrs to public
    function
  RISC-V: mm: Enable huge page support to kernel_page_present() function
  RISC-V: Add arch functions to support hibernation/suspend-to-disk

 arch/riscv/Kconfig                |   8 +
 arch/riscv/include/asm/suspend.h  |  23 ++
 arch/riscv/kernel/Makefile        |   2 +-
 arch/riscv/kernel/asm-offsets.c   |   5 +
 arch/riscv/kernel/hibernate-asm.S | 123 +++++++++++
 arch/riscv/kernel/hibernate.c     | 353 ++++++++++++++++++++++++++++++
 arch/riscv/kernel/suspend.c       |   4 +-
 arch/riscv/mm/pageattr.c          |   6 +
 8 files changed, 521 insertions(+), 3 deletions(-)
 create mode 100644 arch/riscv/kernel/hibernate-asm.S
 create mode 100644 arch/riscv/kernel/hibernate.c


base-commit: 1fe4fd6f5cad346e598593af36caeadc4f5d4fa9
-- 
2.34.1

