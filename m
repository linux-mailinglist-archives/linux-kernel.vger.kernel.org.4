Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268CA6DEA3F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 06:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjDLEPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 00:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDLEP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 00:15:29 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398B42683
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 21:15:27 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Px8V1619Kzrb2J;
        Wed, 12 Apr 2023 12:14:01 +0800 (CST)
Received: from DESKTOP-6NKE0BC.china.huawei.com (10.174.185.210) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 12:15:24 +0800
From:   Kunkun Jiang <jiangkunkun@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        "open list:IRQCHIP DRIVERS" <linux-kernel@vger.kernel.org>
CC:     <wanghaibin.wang@huawei.com>,
        Kunkun Jiang <jiangkunkun@huawei.com>,
        <chenxiang66@hisilicon.com>, <tangnianyao@huawei.com>
Subject: [PATCH] irqchipi/gic-v4: Ensure accessing the correct RD when and writing INVLPIR
Date:   Wed, 12 Apr 2023 12:15:10 +0800
Message-ID: <20230412041510.497-1-jiangkunkun@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.185.210]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit f3a059219bc7 ("irqchip/gic-v4.1: Ensure mutual exclusion between
vPE affinity change and RD access") tried to address the race
between the RD accesses and the vPE affinity change, but somehow
forgot to take GICR_INVLPIR into account. Let's take the vpe_lock
before evaluating vpe->col_idx to fix it.

Fixes: f3a059219bc7 ("irqchip/gic-v4.1: Ensure mutual exclusion between vPE affinity change and RD access")
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: Nianyao Tang <tangnianyao@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 586271b8aa39..041f06922587 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3943,13 +3943,17 @@ static void its_vpe_send_inv(struct irq_data *d)
 
 	if (gic_rdists->has_direct_lpi) {
 		void __iomem *rdbase;
+		unsigned long flags;
+		int cpu;
 
 		/* Target the redistributor this VPE is currently known on */
-		raw_spin_lock(&gic_data_rdist_cpu(vpe->col_idx)->rd_lock);
-		rdbase = per_cpu_ptr(gic_rdists->rdist, vpe->col_idx)->rd_base;
+		cpu = vpe_to_cpuid_lock(vpe, &flags);
+		raw_spin_lock(&gic_data_rdist_cpu(cpu)->rd_lock);
+		rdbase = per_cpu_ptr(gic_rdists->rdist, cpu)->rd_base;
 		gic_write_lpir(d->parent_data->hwirq, rdbase + GICR_INVLPIR);
 		wait_for_syncr(rdbase);
-		raw_spin_unlock(&gic_data_rdist_cpu(vpe->col_idx)->rd_lock);
+		raw_spin_unlock(&gic_data_rdist_cpu(cpu)->rd_lock);
+		vpe_to_cpuid_unlock(vpe, flags);
 	} else {
 		its_vpe_send_cmd(vpe, its_send_inv);
 	}
-- 
2.27.0

