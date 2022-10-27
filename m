Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4861160EDFD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 04:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbiJ0Cjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 22:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbiJ0Cji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 22:39:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 237ADB3F;
        Wed, 26 Oct 2022 19:39:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E2B623A;
        Wed, 26 Oct 2022 19:39:35 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BC7363F792;
        Wed, 26 Oct 2022 19:39:25 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org
Subject: [PATCH 0/2] arm64: errata: Workaround Cortex-A715 errata #2645198
Date:   Thu, 27 Oct 2022 08:09:13 +0530
Message-Id: <20221027023915.1318100-1-anshuman.khandual@arm.com>
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

This series applies on v6.1-rc1.

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

Anshuman Khandual (2):
  arm64: Add Cortex-715 CPU part definition
  arm64: errata: Workaround possible Cortex-A715 [ESR|FAR]_ELx corruption

 Documentation/arm64/silicon-errata.rst |  2 ++
 arch/arm64/Kconfig                     | 16 +++++++++++
 arch/arm64/include/asm/cputype.h       |  2 ++
 arch/arm64/include/asm/hugetlb.h       |  9 +++++++
 arch/arm64/include/asm/pgtable.h       | 24 +++++++++++++++++
 arch/arm64/kernel/cpu_errata.c         |  7 +++++
 arch/arm64/mm/hugetlbpage.c            | 37 ++++++++++++++++++++++++++
 arch/arm64/tools/cpucaps               |  1 +
 8 files changed, 98 insertions(+)

-- 
2.25.1

