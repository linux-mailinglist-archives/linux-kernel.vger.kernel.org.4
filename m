Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3462685CDF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 02:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjBABxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 20:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjBABxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 20:53:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C88B4A216
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 17:53:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41CEDB81FB1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 01:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7BBC433D2;
        Wed,  1 Feb 2023 01:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675216389;
        bh=RpFg111OSlAsEiBZp9SuzdgJ3YXxrBaF+gupz9LpZ4I=;
        h=From:To:Cc:Subject:Date:From;
        b=Js78uiOsWwy2ggvshXrD23mqWrYpmJHeeUCWV28V1SWaHO4juUx1FBuy4DmOEimTl
         Rkbb41y7pw7QIAlWLRpNiQaJo1mRl5m6r1crPusCh0SWK2X/56tmVDY5TjMMQMHEqU
         KgS/eb7wO1FT7tIxffWq2K/V5hKlG5QQMcCOzg40AX+z03O5kDyogv7YSCfZ+rmv/i
         7e3F0JdcLG7F5gG6x+DCOTwycNtFyCObLoDeKeSiD/aK9MwzwfeBb+Ciiu938DaAJM
         lg1m546dZqbjgVBPeUqow1KCauU3/ZZUe199Xnn20q4KgS2KYlLGETJSmBwbzkxpPi
         uVUC/xuGSTQOA==
From:   guoren@kernel.org
To:     tongtiangen@huawei.com, alexandre.ghiti@canonical.com,
        muchun.song@linux.dev, palmer@rivosinc.com, guoren@kernel.org,
        conor@kernel.org, ajones@ventanamicro.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH V3] riscv: mm: hugetlb: Enable ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
Date:   Tue, 31 Jan 2023 20:52:59 -0500
Message-Id: <20230201015259.3222524-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Add HVO support for RISC-V; see commit 6be24bed9da3 ("mm: hugetlb:
introduce a new config HUGETLB_PAGE_FREE_VMEMMAP"). This patch is
similar to commit 1e63ac088f20 ("arm64: mm: hugetlb: enable
HUGETLB_PAGE_FREE_VMEMMAP for arm64"), and riscv's motivation is the
same as arm64. The current riscv was ready to enable HVO after fixup,
ref commit d33deda095d3 ("riscv/mm: hugepage's PG_dcache_clean flag
is only set in head page").

See Documentation/mm/vmemmap_dedup.rst for more details.

The HugeTLB VmemmapvOptimization (HVO) defaults to off in Kconfig.

Here is the riscv test log:
cat /proc/sys/vm/hugetlb_optimize_vmemmap
echo 8 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
mount -t hugetlbfs none test/ -o pagesize=2048k
<Try some simple hugetlb test in test dir, no problem found.>

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Link: https://lore.kernel.org/linux-riscv/1F5AF29D-708A-483B-A29F-CAEE6F554866@linux.dev/
Acked-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
Changelog:
V3:
 - Optimize the commit log (Thx Andrew)
 - Optimize alphabet order (Thx Conor)
 - Add Reviewed-by tag

V2:
 - Optimize the commit log
 - Remove riscv page compound_head fixup which has been merged.
 - Rebase on riscv for-next (20230127)
 - Add HVO author's acked-by

V1:
https://lore.kernel.org/linux-riscv/20221023133205.3493564-1-guoren@kernel.org/
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index e2b656043abf..54972e719f49 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -45,6 +45,7 @@ config RISCV
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_GENERAL_HUGETLB
+	select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
 	select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
-- 
2.36.1

