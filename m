Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0C25F07FA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiI3Jud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiI3Ju2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:50:28 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FBF8B2E1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:50:25 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mf52j1164zlXS5;
        Fri, 30 Sep 2022 17:46:05 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 17:50:06 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 17:50:05 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Russell King <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2] efi/arm: dump UEFI runtime page tables for ARM
Date:   Fri, 30 Sep 2022 18:10:24 +0800
Message-ID: <20220930101024.118394-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UEFI runtime page tables dump only for ARM64 at present,
but ARM support EFI and ARM_PTDUMP_DEBUGFS now. Since
ARM could potentially execute with a 1G/3G user/kernel
split, choosing 1G as the upper limit for UEFI runtime
end, with this, we could enable UEFI runtime page tables.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
v2: update upper limit for ARM, only build test due to
    my qemu without UEFI boot support.
 arch/arm/include/asm/ptdump.h      | 1 +
 arch/arm64/include/asm/ptdump.h    | 1 +
 drivers/firmware/efi/arm-runtime.c | 4 ++--
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/ptdump.h b/arch/arm/include/asm/ptdump.h
index 0c2d3d0d4cc6..aad1d034136c 100644
--- a/arch/arm/include/asm/ptdump.h
+++ b/arch/arm/include/asm/ptdump.h
@@ -21,6 +21,7 @@ struct ptdump_info {
 
 void ptdump_walk_pgd(struct seq_file *s, struct ptdump_info *info);
 #ifdef CONFIG_ARM_PTDUMP_DEBUGFS
+#define EFI_RUNTIME_MAP_END	SZ_1G
 void ptdump_debugfs_register(struct ptdump_info *info, const char *name);
 #else
 static inline void ptdump_debugfs_register(struct ptdump_info *info,
diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
index b1dd7ecff7ef..581caac525b0 100644
--- a/arch/arm64/include/asm/ptdump.h
+++ b/arch/arm64/include/asm/ptdump.h
@@ -23,6 +23,7 @@ struct ptdump_info {
 
 void ptdump_walk(struct seq_file *s, struct ptdump_info *info);
 #ifdef CONFIG_PTDUMP_DEBUGFS
+#define EFI_RUNTIME_MAP_END	DEFAULT_MAP_WINDOW_64
 void __init ptdump_debugfs_register(struct ptdump_info *info, const char *name);
 #else
 static inline void ptdump_debugfs_register(struct ptdump_info *info,
diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 3359ae2adf24..8f8ae479061b 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -25,14 +25,14 @@
 #include <asm/mmu.h>
 #include <asm/pgalloc.h>
 
-#if defined(CONFIG_PTDUMP_DEBUGFS) && defined(CONFIG_ARM64)
+#if defined(CONFIG_PTDUMP_DEBUGFS) || defined(CONFIG_ARM_PTDUMP_DEBUGFS)
 #include <asm/ptdump.h>
 
 static struct ptdump_info efi_ptdump_info = {
 	.mm		= &efi_mm,
 	.markers	= (struct addr_marker[]){
 		{ 0,				"UEFI runtime start" },
-		{ DEFAULT_MAP_WINDOW_64,	"UEFI runtime end" },
+		{ EFI_RUNTIME_MAP_END,		"UEFI runtime end" },
 		{ -1,				NULL }
 	},
 	.base_addr	= 0,
-- 
2.35.3

