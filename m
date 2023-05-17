Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEFE7061DF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjEQH41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjEQH4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:56:16 -0400
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D58274EF8
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ehNPC
        h8aRRorAdcVRYxMqWEJzK0ZC2Aw7HHiwNEAxAM=; b=DgT5cixO7wSJoqNJFAL4r
        Id29Zmuz5+5npJ0W92Gfe92V5nyXphJbeMKqNtvEYvcEzv/qef14g6VGcjDseUAU
        8Eyw66nPHFUJMFE3Mi3iNQztLgkwW9jNmWF8HLbu+ublkRB9EnS0yWgpa6LCQ449
        +mxv5ffDGPFZ17Ddmz2Rgk=
Received: from localhost (unknown [210.13.118.86])
        by zwqz-smtp-mta-g2-0 (Coremail) with SMTP id _____wDHkcpdiGRkDWYqAA--.61946S2;
        Wed, 17 May 2023 15:55:09 +0800 (CST)
From:   zhengyan <zhengyan@asrmicro.com>
To:     tglx@linutronix.de, maz@kernel.org, linux-kernel@vger.kernel.org
Cc:     zhengyan@asrmicro.com, meitaogao@asrmicro.com,
        qiaozhou@asrmicro.com, zhizhouzhang@asrmicro.com
Subject: [PATCH] irqchip/gic-v3: workaround for ASR8601 when reading mpidr
Date:   Wed, 17 May 2023 15:55:00 +0800
Message-Id: <20230517075500.43516-1-zhengyan@asrmicro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDHkcpdiGRkDWYqAA--.61946S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCrWDur1rKr4rZFykZw4Utwb_yoW5tr1rpr
        WFk3yxtrs7XF17WwsrJF47ur98A34kCrWjkwnrK39ava98GryDZFyxXa45ZrsIqFZayw47
        J3Wv9Fyj9F4jyr7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUa9-UUUUU=
X-Originating-IP: [210.13.118.86]
Sender: holmes_jack@126.com
X-CM-SenderInfo: 5krozv5vbmtubn6rjloofrz/1tbiqANyZVpEAfSTaQACsv
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add workaround for ASR8601, which uses an armv8.2
processor with a gic-500. ARMv8.2 uses Multiprocessor Affinity
Register to identify the logical address of the core by
| cluster | core | thread |.
However, gic-500 only supports topologies with
affinity levels less than 2 as
| cluster | core|.

So it needs this patch to shift the MPIDR values
to ensure proper functionality

Signed-off-by: zhengyan <zhengyan@asrmicro.com>
---
 drivers/irqchip/irq-gic-v3.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 6fcee221f201..435b98a8641e 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -39,6 +39,7 @@
 
 #define FLAGS_WORKAROUND_GICR_WAKER_MSM8996	(1ULL << 0)
 #define FLAGS_WORKAROUND_CAVIUM_ERRATUM_38539	(1ULL << 1)
+#define FLAGS_WORKAROUND_MPIDR_ASR8601		(1ULL << 2)
 
 #define GIC_IRQ_TYPE_PARTITION	(GIC_IRQ_TYPE_LPI + 1)
 
@@ -659,6 +660,9 @@ static u64 gic_mpidr_to_affinity(unsigned long mpidr)
 {
 	u64 aff;
 
+	if (gic_data.flags & FLAGS_WORKAROUND_MPIDR_ASR8601)
+		mpidr >>= 8;
+
 	aff = ((u64)MPIDR_AFFINITY_LEVEL(mpidr, 3) << 32 |
 	       MPIDR_AFFINITY_LEVEL(mpidr, 2) << 16 |
 	       MPIDR_AFFINITY_LEVEL(mpidr, 1) << 8  |
@@ -970,6 +974,9 @@ static int __gic_populate_rdist(struct redist_region *region, void __iomem *ptr)
 	 * Convert affinity to a 32bit value that can be matched to
 	 * GICR_TYPER bits [63:32].
 	 */
+	if (gic_data.flags & FLAGS_WORKAROUND_MPIDR_ASR8601)
+		mpidr >>= 8;
+
 	aff = (MPIDR_AFFINITY_LEVEL(mpidr, 3) << 24 |
 	       MPIDR_AFFINITY_LEVEL(mpidr, 2) << 16 |
 	       MPIDR_AFFINITY_LEVEL(mpidr, 1) << 8 |
@@ -1265,6 +1272,8 @@ static u16 gic_compute_target_list(int *base_cpu, const struct cpumask *mask,
 	unsigned long mpidr = cpu_logical_map(cpu);
 	u16 tlist = 0;
 
+	if (gic_data.flags & FLAGS_WORKAROUND_MPIDR_ASR8601)
+		mpidr >>= 8;
 	while (cpu < nr_cpu_ids) {
 		tlist |= 1 << (mpidr & 0xf);
 
@@ -1274,7 +1283,8 @@ static u16 gic_compute_target_list(int *base_cpu, const struct cpumask *mask,
 		cpu = next_cpu;
 
 		mpidr = cpu_logical_map(cpu);
-
+		if (gic_data.flags & FLAGS_WORKAROUND_MPIDR_ASR8601)
+			mpidr >>= 8;
 		if (cluster_id != MPIDR_TO_SGI_CLUSTER_ID(mpidr)) {
 			cpu--;
 			goto out;
@@ -1321,6 +1331,8 @@ static void gic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
 		u64 cluster_id = MPIDR_TO_SGI_CLUSTER_ID(cpu_logical_map(cpu));
 		u16 tlist;
 
+		if (gic_data.flags & FLAGS_WORKAROUND_MPIDR_ASR8601)
+			cluster_id = MPIDR_TO_SGI_CLUSTER_ID(cpu_logical_map(cpu) >> 8);
 		tlist = gic_compute_target_list(&cpu, mask, cluster_id);
 		gic_send_sgi(cluster_id, tlist, d->hwirq);
 	}
@@ -1729,6 +1741,15 @@ static bool gic_enable_quirk_cavium_38539(void *data)
 	return true;
 }
 
+static bool gic_enable_quirk_asr8601(void *data)
+{
+	struct gic_chip_data *d = data;
+
+	d->flags |= FLAGS_WORKAROUND_MPIDR_ASR8601;
+
+	return true;
+}
+
 static bool gic_enable_quirk_hip06_07(void *data)
 {
 	struct gic_chip_data *d = data;
@@ -1823,6 +1844,11 @@ static const struct gic_quirk gic_quirks[] = {
 		.mask	= 0xffffffff,
 		.init	= gic_enable_quirk_nvidia_t241,
 	},
+	{
+		.desc	= "GICv3: ASR 8601 MPIDR SHIFT",
+		.compatible = "asr,asr8601-gic-v3",
+		.init	= gic_enable_quirk_asr8601,
+	},
 	{
 	}
 };
-- 
2.25.1

