Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1E0699960
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 17:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjBPQB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 11:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBPQB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 11:01:27 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAEB74BE82
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 08:01:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B8D51042;
        Thu, 16 Feb 2023 08:02:08 -0800 (PST)
Received: from e126864.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EF293F881;
        Thu, 16 Feb 2023 08:01:22 -0800 (PST)
From:   Kristina Martsenko <kristina.martsenko@arm.com>
To:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Luis Machado <luis.machado@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] arm64: support Armv8.8 memcpy instructions in userspace
Date:   Thu, 16 Feb 2023 16:00:02 +0000
Message-Id: <20230216160012.272345-1-kristina.martsenko@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Armv8.8 extension adds new instructions to perform memcpy(), memset() and
memmove() operations in hardware (FEAT_MOPS).  The aim is to avoid having many
different performance-optimal memcpy implementations in software (tailored to
CPU model and copy size) and the overhead of selecting between them.  The new
instructions are intended to be at least as fast as any alternative instruction
sequence.

This series adds support for using the new instructions in userspace.  The most
noteworthy part is some exception handling for when there are different memcpy
implementations in the same system.  In addition, the first patches in the
series set up basic handling for the new HCRX_EL2 register (added in Armv8.7),
which is needed to disable MOPS in KVM guests for now.

Support for using memcpy instructions in KVM guests will follow in a future
series, as well as kselftests and more debug support.


Kristina Martsenko (10):
  KVM: arm64: initialize HCRX_EL2
  arm64: cpufeature: detect FEAT_HCX
  KVM: arm64: switch HCRX_EL2 between host and guest
  arm64: mops: document boot requirements for MOPS
  arm64: mops: don't disable host MOPS instructions from EL2
  KVM: arm64: hide MOPS from guests
  arm64: mops: handle MOPS exceptions
  arm64: mops: handle single stepping after MOPS exception
  arm64: mops: detect and enable FEAT_MOPS
  arm64: mops: allow disabling MOPS from the kernel command line

 .../admin-guide/kernel-parameters.txt         |  3 ++
 Documentation/arm64/booting.rst               |  8 +++
 Documentation/arm64/cpu-feature-registers.rst |  2 +
 Documentation/arm64/elf_hwcaps.rst            |  3 ++
 arch/arm64/include/asm/el2_setup.h            |  8 ---
 arch/arm64/include/asm/esr.h                  | 11 +++-
 arch/arm64/include/asm/exception.h            |  1 +
 arch/arm64/include/asm/hwcap.h                |  1 +
 arch/arm64/include/asm/kvm_arm.h              |  4 ++
 arch/arm64/include/uapi/asm/hwcap.h           |  1 +
 arch/arm64/kernel/cpufeature.c                | 31 +++++++++++
 arch/arm64/kernel/cpuinfo.c                   |  1 +
 arch/arm64/kernel/entry-common.c              | 11 ++++
 arch/arm64/kernel/head.S                      |  7 +++
 arch/arm64/kernel/idreg-override.c            |  2 +
 arch/arm64/kernel/traps.c                     | 51 +++++++++++++++++++
 arch/arm64/kvm/hyp/include/hyp/switch.h       |  6 +++
 arch/arm64/kvm/hyp/nvhe/hyp-init.S            |  6 +++
 arch/arm64/kvm/sys_regs.c                     |  1 +
 arch/arm64/tools/cpucaps                      |  2 +
 20 files changed, 151 insertions(+), 9 deletions(-)

-- 
2.25.1

