Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BDA67E344
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbjA0L3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbjA0L3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:29:14 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E5537C73E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:28:21 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48E572F;
        Fri, 27 Jan 2023 03:28:53 -0800 (PST)
Received: from e122027.cambridge.arm.com (e122027.cambridge.arm.com [10.1.35.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 761C33F64C;
        Fri, 27 Jan 2023 03:28:08 -0800 (PST)
From:   Steven Price <steven.price@arm.com>
To:     kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Cc:     Steven Price <steven.price@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev
Subject: [RFC PATCH 00/14] arm64: Support for running as a guest in Arm CCA
Date:   Fri, 27 Jan 2023 11:27:44 +0000
Message-Id: <20230127112758.37891-1-steven.price@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127112248.136810-1-suzuki.poulose@arm.com>
References: <20230127112248.136810-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is an RFC adding support for running Linux in a protected
VM under the new Arm Confidential Compute Architecture (CCA). The
purpose of this series is to gather feedback on the proposed changes to
the architecture code for CCA.

The ABI to the RMM from a realm (the RSI) is based on the Beta 0
specification[2] and will be updated in the future when a final version
of the specification is published.

This series is based on v6.2-rc1. It is also available as a git
repository:

https://gitlab.arm.com/linux-arm/linux-cca cca-guest/rfc-v1

Introduction
============
A more general introduction to Arm CCA is available on the Arm
website[3], and links to the other components involved are available in
the overall cover letter[4].

Arm Confidential Compute Architecture adds two new 'worlds' to the
architecture: Root and Realm. A new software component known as the RMM
(Realm Management Monitor) runs in Realm EL2 and is trusted by both the
Normal World and VMs running within Realms. This enables mutual
distrust between the Realm VMs and the Normal World.

Virtual machines running within a Realm can decide on a (4k)
page-by-page granularity whether to share a page with the (Normal World)
host or to keep it private (protected). This protection is provided by
the hardware and attempts to access a page which isn't shared by the
Normal World will trigger a Granule Protection Fault.

Realm VMs can communicate with the RMM via another SMC interface known
as RSI (Realm Services Interface). This series adds wrappers for the
full set of RSI commands and uses them to manage the Realm IPA State
(RIPAS) and to discover the configuration of the realm.

The VM running within the Realm needs to ensure that memory that is
going to use is marked as 'RIPAS_RAM' (i.e. protected memory accessible
only to the guest). This could be provided by the VMM (and subject to
measurement to ensure it is setup correctly) or the VM can set it
itself.  This series includes a patch which will iterate over all
described RAM and set the RIPAS. An alternative would be to update
booting.rst and state this as a requirement, but this would reduce the
flexibility of the VMM to manage the available memory to the guest (as
the initial RIPAS state is part of the guest's measurement).

Within the Realm the most-significant active bit of the IPA is used to
select whether the access is to protected memory or to memory shared
with the host. This series treats this bit as if it is attribute bit in
the page tables and will modify it when sharing/unsharing memory with
the host.

This top bit usage also necessitates that the IPA width is made more
dynamic in the guest. The VMM will choose a width (and therefore which
bit controls the shared flag) and the guest must be able to identify
this bit to mask it out when necessary. PHYS_MASK_SHIFT/PHYS_MASK are
therefore made dynamic.

To allow virtio to communicate with the host the shared buffers must be
placed in memory which has this top IPA bit set. This is achieved by
implementating the set_memory_{encrypted,decrypted} APIs for arm64 and
forcing the use of bounce buffers. For now all device access is
considered to required the memory to be shared, at this stage there is
no support for real devices to be assigned to a realm guest - obviously
if device assignment is added this will have to change.

Finally the GIC is (largely) emulated by the (untrusted) host. The RMM
provides some management (including register save/restore) but the
ITS buffers must be placed into shared memory for the host to emulate.
There is likely to be future work to harden the GIC driver against a
malicious host (along with any other drivers used within a Realm guest).

[1] https://lore.kernel.org/r/20221202061347.1070246-1-chao.p.peng%40linux.intel.com
[2] https://developer.arm.com/documentation/den0137/1-0bet0/
[3] https://www.arm.com/architecture/security-features/arm-confidential-compute-architecture
[4] https://lore.kernel.org/r/20230127112248.136810-1-suzuki.poulose%40arm.com

Steven Price (9):
  arm64: remove redundant 'extern'
  arm64: Detect if in a realm and set RIPAS RAM
  arm64: realm: Query IPA size from the RMM
  arm64: Mark all I/O as non-secure shared
  arm64: Make the PHYS_MASK_SHIFT dynamic
  arm64: Enforce bounce buffers for realm DMA
  arm64: Enable memory encrypt for Realms
  arm64: realm: Support nonsecure ITS emulation shared
  HACK: Accept prototype RSI version

Suzuki K Poulose (5):
  arm64: rsi: Add RSI definitions
  fixmap: Allow architecture overriding set_fixmap_io
  arm64: Override set_fixmap_io
  arm64: Force device mappings to be non-secure shared
  efi: arm64: Map Device with Prot Shared

 arch/arm64/Kconfig                     |   3 +
 arch/arm64/include/asm/fixmap.h        |   4 +-
 arch/arm64/include/asm/io.h            |   6 +-
 arch/arm64/include/asm/kvm_arm.h       |   2 +-
 arch/arm64/include/asm/mem_encrypt.h   |  19 ++++
 arch/arm64/include/asm/pgtable-hwdef.h |   4 +-
 arch/arm64/include/asm/pgtable-prot.h  |   2 +
 arch/arm64/include/asm/pgtable.h       |   7 +-
 arch/arm64/include/asm/rsi.h           |  46 +++++++++
 arch/arm64/include/asm/rsi_cmds.h      |  71 +++++++++++++
 arch/arm64/include/asm/rsi_smc.h       | 132 +++++++++++++++++++++++++
 arch/arm64/kernel/Makefile             |   2 +-
 arch/arm64/kernel/efi.c                |   2 +-
 arch/arm64/kernel/head.S               |   2 +-
 arch/arm64/kernel/rsi.c                |  82 +++++++++++++++
 arch/arm64/kernel/setup.c              |   3 +
 arch/arm64/kvm/Kconfig                 |   8 ++
 arch/arm64/mm/init.c                   |  10 +-
 arch/arm64/mm/mmu.c                    |  13 +++
 arch/arm64/mm/pageattr.c               |  48 ++++++++-
 drivers/irqchip/irq-gic-v3-its.c       |  95 +++++++++++++-----
 include/asm-generic/fixmap.h           |   2 +
 22 files changed, 523 insertions(+), 40 deletions(-)
 create mode 100644 arch/arm64/include/asm/mem_encrypt.h
 create mode 100644 arch/arm64/include/asm/rsi.h
 create mode 100644 arch/arm64/include/asm/rsi_cmds.h
 create mode 100644 arch/arm64/include/asm/rsi_smc.h
 create mode 100644 arch/arm64/kernel/rsi.c

-- 
2.34.1

