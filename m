Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FFC626D4E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 02:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbiKMB1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 20:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiKMB1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 20:27:10 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 376DA60C9;
        Sat, 12 Nov 2022 17:27:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B011323A;
        Sat, 12 Nov 2022 17:27:11 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.40.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C05193F73D;
        Sat, 12 Nov 2022 17:27:01 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org
Subject: [PATCH V2 0/2] arm64: errata: Workaround Cortex-A715 errata #2645198
Date:   Sun, 13 Nov 2022 06:56:43 +0530
Message-Id: <20221113012645.190301-1-anshuman.khandual@arm.com>
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

This series adds Cortex-A715 partnumber and workarounds the errata #2645198
which gets triggered when an userspace page mapping permission changes from
executable to non-executable, corrupting both ESR_EL1/FAR_EL1 registers
when an instruction abort is taken.

This series applies on v6.1-rc4.

The errata description can be found here.

https://developer.arm.com/documentation/SDEN2148827/1000/?lang=en

Cc: Catalin Marinas <catalin.marinas@arm.com> 
Cc: Will Deacon <will@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mark Rutland <mark.rutland@arm.com> 
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org

Changes in V2:

- Added ptep_modify_prot_start/commit declaration into [asm/pgtable.h]
- Moved ptep_modify_prot_start/commit definitions into [arch/arm64/mm/mmu.c]
- Above code movements solved ptep_clear_flush() related build dependency
- Replaced __flush_tlb_range() with ptep_clear_flush()/huge_ptep_clear_flush()

Changes in V1:

https://lore.kernel.org/all/20221027023915.1318100-1-anshuman.khandual@arm.com/

Anshuman Khandual (2):
  arm64: Add Cortex-715 CPU part definition
  arm64: errata: Workaround possible Cortex-A715 [ESR|FAR]_ELx corruption

 Documentation/arm64/silicon-errata.rst |  2 ++
 arch/arm64/Kconfig                     | 16 ++++++++++++++++
 arch/arm64/include/asm/cputype.h       |  2 ++
 arch/arm64/include/asm/hugetlb.h       |  9 +++++++++
 arch/arm64/include/asm/pgtable.h       |  9 +++++++++
 arch/arm64/kernel/cpu_errata.c         |  7 +++++++
 arch/arm64/mm/hugetlbpage.c            | 21 +++++++++++++++++++++
 arch/arm64/mm/mmu.c                    | 21 +++++++++++++++++++++
 arch/arm64/tools/cpucaps               |  1 +
 9 files changed, 88 insertions(+)

-- 
2.25.1

