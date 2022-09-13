Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0C75B6E4F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 15:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbiIMN0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 09:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiIMN0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 09:26:35 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01984192B3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 06:26:34 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MRkfb3QqrzmV9H;
        Tue, 13 Sep 2022 21:22:47 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 13 Sep 2022 21:26:31 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 13 Sep 2022 21:26:31 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Ard Biesheuvel <ardb@kernel.org>, <linux-kernel@vger.kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] ARM: mm: set readonly for MT_MEMORY_RO with ARM_LPAE
Date:   Tue, 13 Sep 2022 21:30:22 +0800
Message-ID: <20220913133022.145977-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT_MEMORY_RO is introduced by commit 598f0a99fa8a ("ARM: 9210/1:
Mark the FDT_FIXED sections as shareable"), which is a readonly
memory type for FDT area, but there are some different between
ARM_LPAE and non-ARM_LPAE, we need to setup PMD_SECT_AP2 and
L_PMD_SECT_RDONLY for MT_MEMORY_RO when ARM_LAPE enabled.

non-ARM_LPAE	0xff800000-0xffa00000           2M PGD KERNEL      ro NX SHD
ARM_LPAE	0xff800000-0xffc00000           4M PMD RW NX SHD
ARM_LPAE+fix	0xff800000-0xffc00000           4M PMD ro NX SHD

Fixes: 598f0a99fa8a ("ARM: 9210/1: Mark the FDT_FIXED sections as shareable")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm/mm/mmu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index a49f0b9c0f75..b8d273651003 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -300,7 +300,11 @@ static struct mem_type mem_types[] __ro_after_init = {
 		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
 			     L_PTE_XN | L_PTE_RDONLY,
 		.prot_l1   = PMD_TYPE_TABLE,
+#ifndef CONFIG_ARM_LPAE
 		.prot_sect = PMD_TYPE_SECT,
+#else
+		.prot_sect = PMD_TYPE_SECT | L_PMD_SECT_RDONLY | PMD_SECT_AP2,
+#endif
 		.domain    = DOMAIN_KERNEL,
 	},
 	[MT_ROM] = {
-- 
2.35.3

