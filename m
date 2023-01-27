Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5789167DD02
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 06:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjA0FE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 00:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjA0FE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 00:04:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D315CE74
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 21:04:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4AD5FB81F87
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:04:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6801C433EF;
        Fri, 27 Jan 2023 05:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674795893;
        bh=/HLKprgFCkbwfasw3ymLCwPg8rX60Yypp+3lYT3FCJ4=;
        h=From:To:Cc:Subject:Date:From;
        b=Mp/rTFaZrIswP/zPyxJsexO6HD1kJWsmPpq+Dl17E8g8+5vNo28eKn/wnbal/dq+9
         ue1W8sWQZARzTxdJxD6tWGlMycrf0stBW/c7G7KK/kcP6+66EeJei/Z9Zi4wMHLoM6
         nbjjXIAZo0T+MSGYbJ24kPTSIRpWwwZ3lqEhgQvQfLV9n3Je9q25UJf2/w8NXrWgJz
         ec7ljPaw+1OEHlYYuOawmSCkTUEeJ8MbV1+hZQmJMBXMrlUqZN0/9hHe7xJMt1/vqP
         hYlq3slKHiZe3SDP9+qiaDFB969ICKH9rAnBhfUQ+nYmjrK6Up8PxAvs9+9CW+ZgkA
         VvNYgMm89j8TA==
From:   guoren@kernel.org
To:     tongtiangen@huawei.com, alexandre.ghiti@canonical.com,
        muchun.song@linux.dev, palmer@rivosinc.com, guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH -next V2] riscv: mm: hugetlb: Enable ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
Date:   Fri, 27 Jan 2023 00:04:21 -0500
Message-Id: <20230127050421.1920048-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
---
Changelog:
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
index e2b656043abf..949974a38a41 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -46,6 +46,7 @@ config RISCV
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_GENERAL_HUGETLB
 	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
+	select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 	select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
 	select BUILDTIME_TABLE_SORT if MMU
-- 
2.36.1

