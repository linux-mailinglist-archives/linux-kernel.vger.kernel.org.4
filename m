Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0CE73811B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjFUKZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbjFUKZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:25:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761821AC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 03:25:11 -0700 (PDT)
Received: from dggpemm500003.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QmK186dd9zqV5v;
        Wed, 21 Jun 2023 18:07:08 +0800 (CST)
Received: from localhost.localdomain (10.28.77.120) by
 dggpemm500003.china.huawei.com (7.185.36.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 21 Jun 2023 18:07:16 +0800
From:   wangwudi <wangwudi@hisilicon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <liaochang1@huawei.com>, wangwudi <wangwudi@hisilicon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH v3] irqchip: gic-v3: Extend collection table
Date:   Wed, 21 Jun 2023 18:01:31 +0800
Message-ID: <1687341691-894-1-git-send-email-wangwudi@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.28.77.120]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500003.china.huawei.com (7.185.36.56)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only single level table is supported to the collection table, and only 
one page is allocated.

Extend collection table to support more CPUs:
1. Recalculate the page number of collection table based on the number
of CPUs.
2. Add 2 level tables to collection table when HCC field is zero.
3. Add GITS_TYPER_CIDBITS macros.

It is noticed in an internal simulation research:
- the page_size of collection table is 4 KB
- the entry_size of collection table is 16 Byte
- with 512 CPUs

And I don't find a have a GIC500 platform to test this path. 

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: wangwudi <wangwudi@hisilicon.com>
---

ChangeLog:
v1-->v2:
1. Support 2 level table.
2. Rewrite the commit log.
v2-->v3
1. Fixed the error when HCC is field is not zero.
2. Modifiy the commit log.

 drivers/irqchip/irq-gic-v3-its.c   | 67 +++++++++++++++++++++++++++++++-------
 include/linux/irqchip/arm-gic-v3.h |  3 ++
 2 files changed, 58 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 0ec2b1e1df75..c37e010fd50c 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -126,6 +126,7 @@ struct its_node {
 #define is_v4(its)		(!!((its)->typer & GITS_TYPER_VLPIS))
 #define is_v4_1(its)		(!!((its)->typer & GITS_TYPER_VMAPP))
 #define device_ids(its)		(FIELD_GET(GITS_TYPER_DEVBITS, (its)->typer) + 1)
+#define collection_ids(its)	(FIELD_GET(GITS_TYPER_CIDBITS, (its)->typer) + 1)
 
 #define ITS_ITT_ALIGN		SZ_256
 
@@ -2626,6 +2627,10 @@ static int its_alloc_tables(struct its_node *its)
 			indirect = its_parse_indirect_baser(its, baser, &order,
 							    ITS_MAX_VPEID_BITS);
 			break;
+		case GITS_BASER_TYPE_COLLECTION:
+			indirect = its_parse_indirect_baser(its, baser, &order,
+							    order_base_2(num_possible_cpus()));
+			break;
 		}
 
 		err = its_setup_baser(its, baser, cache, shr, order, indirect);
@@ -3230,18 +3235,6 @@ static void its_cpu_init_collection(struct its_node *its)
 	its_send_invall(its, &its->collections[cpu]);
 }
 
-static void its_cpu_init_collections(void)
-{
-	struct its_node *its;
-
-	raw_spin_lock(&its_lock);
-
-	list_for_each_entry(its, &its_nodes, entry)
-		its_cpu_init_collection(its);
-
-	raw_spin_unlock(&its_lock);
-}
-
 static struct its_device *its_find_device(struct its_node *its, u32 dev_id)
 {
 	struct its_device *its_dev = NULL, *tmp;
@@ -3316,6 +3309,56 @@ static bool its_alloc_table_entry(struct its_node *its,
 	return true;
 }
 
+static bool its_alloc_collection_table(struct its_node *its, struct its_baser *baser)
+{
+	int cpu = smp_processor_id();
+	int cpu_ids = 16;
+
+	if (its->typer & GITS_TYPER_CIL)
+		cpu_ids = collection_ids(its);
+
+	if (!(ilog2(cpu) < cpu_ids)) {
+		pr_warn("ITS: CPU%d out of Collection ID range for %dbits", cpu, cpu_ids);
+		return false;
+	}
+
+	if (!its_alloc_table_entry(its, baser, cpu)) {
+		pr_warn("ITS: CPU%d failed to allocate collection l2 table", cpu);
+		return false;
+	}
+
+	return true;
+}
+
+static bool its_cpu_init_collections(void)
+{
+	struct its_node *its;
+	struct its_baser *baser;
+	void __iomem *base;
+
+	raw_spin_lock(&its_lock);
+
+	list_for_each_entry(its, &its_nodes, entry) {
+		base = its->base;
+		if (!GITS_TYPER_HCC(gic_read_typer(base + GITS_TYPER))) {
+			baser = its_get_baser(its, GITS_BASER_TYPE_COLLECTION);
+			if (!baser) {
+				raw_spin_unlock(&its_lock);
+				return false;
+			}
+
+			if (!its_alloc_collection_table(its, baser)) {
+				raw_spin_unlock(&its_lock);
+				return false;
+			}
+		}
+
+		its_cpu_init_collection(its);
+	}
+	raw_spin_unlock(&its_lock);
+	return true;
+}
+
 static bool its_alloc_device_table(struct its_node *its, u32 dev_id)
 {
 	struct its_baser *baser;
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 728691365464..35e83da8961f 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -400,6 +400,9 @@
 #define GITS_TYPER_PTA			(1UL << 19)
 #define GITS_TYPER_HCC_SHIFT		24
 #define GITS_TYPER_HCC(r)		(((r) >> GITS_TYPER_HCC_SHIFT) & 0xff)
+#define GITS_TYPER_CIDBITS_SHIFT	32
+#define GITS_TYPER_CIDBITS		GENMASK_ULL(35, 32)
+#define GITS_TYPER_CIL			(1ULL << 36)
 #define GITS_TYPER_VMOVP		(1ULL << 37)
 #define GITS_TYPER_VMAPP		(1ULL << 40)
 #define GITS_TYPER_SVPET		GENMASK_ULL(42, 41)
-- 
2.7.4

