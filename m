Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5DD6F23D9
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 11:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjD2J2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 05:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjD2J2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 05:28:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13F91FED
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 02:28:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90B2F61028
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 09:28:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F0EC433EF;
        Sat, 29 Apr 2023 09:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682760496;
        bh=VWFkSOEdLdYHiOdgaiiVB7fGkgZE49crp4dpjlI65Pc=;
        h=From:To:Cc:Subject:Date:From;
        b=rIuKB6f9FU/nOuER/hZBfRxBtPrbmVPSaatDgZSQTuMxIruWz+zyg6uN+AVpLrbwg
         ebwOVS4j6jzTn7iSCRogr8mssHL6IQJpzrdZgXPtY0jzlXNPSADDb/gCkRELWtQbvg
         198idl0zmdk2zXNL3MdgLVggZpwemYkSF/PkPZz3OtEDz+UFMvRaRIl5PYoFTu2PLL
         Aj3fWqQpWcbf+LTJsyXEjfaQ+sOWgU9/0xBSkdT7Xy97Glwr+Ngjuh7jK+RjyGJmpH
         jQLwddcGImZH/FuEXb1J3e7p+Zta8GKtbhIgEx2hEBcUzq7hmpKj+uIfHWa3OYc3vt
         9KTHdmaIMpZEg==
From:   Conor Dooley <conor@kernel.org>
To:     palmer@dabbelt.com
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Lukas Bulwhan <lukas.bulwhan@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RISC-V: fixup in-flight collision with ARCH_WANT_OPTIMIZE_VMEMMAP rename
Date:   Sat, 29 Apr 2023 10:27:33 +0100
Message-Id: <20230429-trilogy-jolly-12bf5c53d62d@spud>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1730; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=za3FgcteiUKmO+H+px6+yeLYMnrjzvzxzBnY3YJjDjs=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCk+j5nlwlhrWx1mp2WnevlaT5OJLjq8msNet8duVwHP4 d/aD106SlkYxDgYZMUUWRJv97VIrf/jssO55y3MHFYmkCEMXJwCMJGY7YwML+Kf1SiVv3kqbHJq 8n7pBtX7Lk56rHmXVeo5lwq/CugNZ2S45nD2olPVyTt908PnnVt7gaOb+f0WE58jIsedd77gXn6 FDwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Lukas warned that ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP had been
renamed in the mm tree & that RISC-V would need a fixup as part of the
merge. The warning was missed however, and RISC-V is selecting the
orphaned Kconfig option.

Fixes: 89d77f71f493 ("Merge tag 'riscv-for-linus-6.4-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux")
Reported-by: Lukas Bulwhan <lukas.bulwhan@gmail.com>
Link: https://lore.kernel.org/linux-riscv/CAKXUXMyVeg2kQK_edKHtMD3eADrDK_PKhCSVkMrLDdYgTQQ5rg@mail.gmail.com/
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
I guess you picking this up for your second PR makes the most sense
Palmer?

CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
CC: Lukas Bulwhan <lukas.bulwhan@gmail.com>
CC: linux-riscv@lists.infradead.org
CC: linux-kernel@vger.kernel.org
---
 arch/riscv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 5c88ac4b52be..e1bdb3fb16cc 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -46,9 +46,9 @@ config RISCV
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_GENERAL_HUGETLB if !RISCV_ISA_SVNAPOT
-	select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
 	select ARCH_WANT_LD_ORPHAN_WARN if !XIP_KERNEL
+	select ARCH_WANT_OPTIMIZE_VMEMMAP
 	select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
 	select BUILDTIME_TABLE_SORT if MMU
-- 
2.39.2

