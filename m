Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0079D65D2F8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 13:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239255AbjADMoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 07:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbjADMo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 07:44:28 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE48417E0F
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 04:44:27 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Nn8Ln5nVTzqTpb;
        Wed,  4 Jan 2023 20:39:45 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 4 Jan 2023 20:44:24 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] arm64: make ARCH_FORCE_MAX_ORDER selectable
Date:   Wed, 4 Jan 2023 21:00:00 +0800
Message-ID: <20230104130000.69806-1-wangkefeng.wang@huawei.com>
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

The other architectures with ARCH_FORCE_MAX_ORDER are selectable,
but not for ARM64, this is to make it selectable on ARM64, which
is useful for user that need to allocate more than 4MB of physically
contiguous memory with 4K pagesize, also more bigger on 16K pagesize
too, the max value of MAX_ORDER is calculated bellow,

see include/linux/mmzone.h,

  MAX_ORDER - 1 + PAGE_SHIFT <= SECTION_SIZE_BITS

  so max value of MAX_ORDER = SECTION_SIZE_BITS + 1 - PAGE_SHIFT

    | SECTION_SIZE_BITS |  PAGE_SHIFT  |  max MAX_ORDER  |  default MAX_ORDER |
----+-------------------+--------------+-----------------+--------------------+
4K  |       27          |      12      |     16          |      11            |
16K |       27          |      14      |     14          |      12            |
64K |       29          |      16      |     14          |      14            |
----+-------------------+--------------+-----------------+--------------------+

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 03934808b2ed..22f0fb73a762 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1457,9 +1457,11 @@ config XEN
 	  Say Y if you want to run Linux in a Virtual Machine on Xen on ARM64.
 
 config ARCH_FORCE_MAX_ORDER
-	int
+	int "Maximum zone order" if ARM64_4K_PAGES || ARM64_16K_PAGES
 	default "14" if ARM64_64K_PAGES
+	range 12 14 if ARM64_16K_PAGES
 	default "12" if ARM64_16K_PAGES
+	range 11 16 if ARM64_4K_PAGES
 	default "11"
 	help
 	  The kernel memory allocator divides physically contiguous memory
-- 
2.35.3

