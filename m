Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA7472F546
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238459AbjFNHAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237570AbjFNHAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:00:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B0F71984
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 00:00:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A5761FB;
        Wed, 14 Jun 2023 00:00:53 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.46.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9D5F23F663;
        Wed, 14 Jun 2023 00:00:04 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, broonie@kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>, kvmarm@lists.linux.dev,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 00/14] arm64/sysreg: Convert TRBE registers to automatic generation
Date:   Wed, 14 Jun 2023 12:29:35 +0530
Message-Id: <20230614065949.146187-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series converts TRBE registers to automatic generation, after renaming
their fields as per the auto-gen tools format. Although the following field
still renames in arch/arm64/include/asm/sysreg.h, as it cannot be converted
(shares bits with other fields) in the tools format.

#define TRBSR_EL1_BSC_MASK		GENMASK(5, 0)
#define TRBSR_EL1_BSC_SHIFT		0

This series applies on v6.4-rc6.

Changes in V3:

- Defined enum for both PAS and SH fields in TRBMAR_EL1
- Defined enum for EA field in TRBIDR_EL1

Changes in V2:

https://lore.kernel.org/all/20230602062552.565992-1-anshuman.khandual@arm.com/

- Renamed each individual TRBE register fields as per auto-gen tools
- Converted each individual TRBE registers as per auto-gen tools
- Added new register fields as per DDI0601 2023-03

Changes in V1:

https://lore.kernel.org/all/20230531055524.16562-1-anshuman.khandual@arm.com/

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: kvmarm@lists.linux.dev
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (14):
  arm64/sysreg: Rename TRBLIMITR_EL1 fields per auto-gen tools format
  arm64/sysreg: Rename TRBPTR_EL1 fields per auto-gen tools format
  arm64/sysreg: Rename TRBBASER_EL1 fields per auto-gen tools format
  arm64/sysreg: Rename TRBSR_EL1 fields per auto-gen tools format
  arm64/sysreg: Rename TRBMAR_EL1 fields per auto-gen tools format
  arm64/sysreg: Rename TRBTRG_EL1 fields per auto-gen tools format
  arm64/sysreg: Rename TRBIDR_EL1 fields per auto-gen tools format
  arm64/sysreg: Convert TRBLIMITR_EL1 register to automatic generation
  arm64/sysreg: Convert TRBPTR_EL1 register to automatic generation
  arm64/sysreg: Convert TRBBASER_EL1 register to automatic generation
  arm64/sysreg: Convert TRBSR_EL1 register to automatic generation
  arm64/sysreg: Convert TRBMAR_EL1 register to automatic generation
  arm64/sysreg: Convert TRBTRG_EL1 register to automatic generation
  arm64/sysreg: Convert TRBIDR_EL1 register to automatic generation

 arch/arm64/include/asm/el2_setup.h           |  2 +-
 arch/arm64/include/asm/sysreg.h              | 50 +------------
 arch/arm64/kvm/debug.c                       |  2 +-
 arch/arm64/kvm/hyp/nvhe/debug-sr.c           |  2 +-
 arch/arm64/tools/sysreg                      | 77 ++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-trbe.c | 33 +++++----
 drivers/hwtracing/coresight/coresight-trbe.h | 38 ++++------
 7 files changed, 114 insertions(+), 90 deletions(-)

-- 
2.25.1

