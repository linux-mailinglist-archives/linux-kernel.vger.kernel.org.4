Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098135B4BD8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 06:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiIKEha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 00:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiIKEhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 00:37:25 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4575541D06
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 21:37:24 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MQH2z3TDWzHnk2;
        Sun, 11 Sep 2022 12:35:23 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 11 Sep 2022 12:37:22 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 11 Sep 2022 12:37:21 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Russell King <linux@armlinux.org.uk>
CC:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 2/2] ARM: dump: show page table level name
Date:   Sun, 11 Sep 2022 12:41:28 +0800
Message-ID: <20220911044128.138458-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220911044128.138458-1-wangkefeng.wang@huawei.com>
References: <20220911044128.138458-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

ARM could have 3 page table level if ARM_LPAE enabled, or only 2 page
table level, let's show the page table level name when dump.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm/mm/dump.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/dump.c b/arch/arm/mm/dump.c
index 712da6a81b23..a71c2240e319 100644
--- a/arch/arm/mm/dump.c
+++ b/arch/arm/mm/dump.c
@@ -200,6 +200,7 @@ static const struct prot_bits section_bits[] = {
 };
 
 struct pg_level {
+	const char *name;
 	const struct prot_bits *bits;
 	size_t num;
 	u64 mask;
@@ -213,9 +214,11 @@ static struct pg_level pg_level[] = {
 	}, { /* p4d */
 	}, { /* pud */
 	}, { /* pmd */
+		.name	= (CONFIG_PGTABLE_LEVELS > 2) ? "PMD" : "PGD",
 		.bits	= section_bits,
 		.num	= ARRAY_SIZE(section_bits),
 	}, { /* pte */
+		.name	= "PTE",
 		.bits	= pte_bits,
 		.num	= ARRAY_SIZE(pte_bits),
 	},
@@ -282,7 +285,8 @@ static void note_page(struct pg_state *st, unsigned long addr,
 				delta >>= 10;
 				unit++;
 			}
-			pt_dump_seq_printf(st->seq, "%9lu%c", delta, *unit);
+			pt_dump_seq_printf(st->seq, "%9lu%c %s", delta, *unit,
+					   pg_level[st->level].name);
 			if (st->current_domain)
 				pt_dump_seq_printf(st->seq, " %s",
 							st->current_domain);
-- 
2.35.3

