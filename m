Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669C770BBB5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbjEVLZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbjEVLZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:25:20 -0400
X-Greylist: delayed 915 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 May 2023 04:22:33 PDT
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0D082127
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=I32Es
        NwSqafi4+MtLCJFzQgaW96mnGcnKhtn1a3Imsg=; b=XwPyEkHuuqYRDHoRk6/8z
        WdPsR0kGpDwDDOUY2UWAOAXMBzcHoO8VY82PSxf1K8f/L2yukfXklBZJ/IPe+ZaV
        7iYLhNRkPl1gHjjsTSoD1i47worQsmsBJObzPPy03XUS75se5o1FTuUgFQPqFIHm
        RpWwoi/+XjNOa1ptxpJVg4=
Received: from localhost (unknown [210.13.118.86])
        by zwqz-smtp-mta-g0-1 (Coremail) with SMTP id _____wBXLWrGTGtksgvPAA--.18087S2;
        Mon, 22 May 2023 19:06:47 +0800 (CST)
From:   zhengyan <zhengyan@asrmicro.com>
To:     zhengyan@asrmicro.com, linux-kernel@vger.kernel.org, maz@kernel.org
Cc:     meitaogao@asrmicro.com, qiaozhou@asrmicro.com, tglx@linutronix.de,
        zhizhouzhang@asrmicro.com
Subject: [PATCH v2] irqchip/gic-v3: workaround for ASR8601 when reading mpidr
Date:   Mon, 22 May 2023 19:06:43 +0800
Message-Id: <20230522110643.3063073-1-zhengyan@asrmicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517075500.43516-1-zhengyan@asrmicro.com>
References: <20230517075500.43516-1-zhengyan@asrmicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBXLWrGTGtksgvPAA--.18087S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCrWfGrWDWF4Dtw1kGw1xXwb_yoWruF43pF
        Wak3yxtrs3Jr15Wr47Ja17Jry5Awn3Cw4qkFnrt3yIqFy5Ar1UZr4xW34rAFW5try8Ar4U
        JF1jqF1UWr47ArUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UsvtZUUUUU=
X-Originating-IP: [210.13.118.86]
Sender: holmes_jack@126.com
X-CM-SenderInfo: 5krozv5vbmtubn6rjloofrz/1tbiqAh3ZVpEAiYKgQAAsD
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add workaround for ASR8601, which uses an armv8.2
processor with a gic-500. But gic-500 is incompatible with
ARMv8.2 implementations from ARM.

ARMv8.2 from ARM implementation uses Multiprocessor Affinity
Register to identify the logical address of the core by
| cluster | core | thread |.
However, gic-500 only supports topologies with
affinity levels less than 2 as
| cluster | core|.

So we need this patch as workaround to shift the MPIDR values
to ensure proper functionality

Signed-off-by: zhengyan <zhengyan@asrmicro.com>
---
 Documentation/arm64/silicon-errata.rst |  4 ++++
 drivers/irqchip/irq-gic-v3.c           | 30 ++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 9e311bc43e05..d6430ade349d 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -214,3 +214,7 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Fujitsu        | A64FX           | E#010001        | FUJITSU_ERRATUM_010001      |
 +----------------+-----------------+-----------------+-----------------------------+
+
++----------------+-----------------+-----------------+-----------------------------+
+| ASR            | ASR8601         | #8601001        | N/A                         |
++----------------+-----------------+-----------------+-----------------------------+
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 6fcee221f201..cf64783dfe70 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -39,6 +39,9 @@
 
 #define FLAGS_WORKAROUND_GICR_WAKER_MSM8996	(1ULL << 0)
 #define FLAGS_WORKAROUND_CAVIUM_ERRATUM_38539	(1ULL << 1)
+#define FLAGS_WORKAROUND_ASR_ERRATUM_8601001	(1ULL << 2)
+
+#define ASR8601_AFF_QUIRK(aff)			(aff >> 8)
 
 #define GIC_IRQ_TYPE_PARTITION	(GIC_IRQ_TYPE_LPI + 1)
 
@@ -659,6 +662,9 @@ static u64 gic_mpidr_to_affinity(unsigned long mpidr)
 {
 	u64 aff;
 
+	if (gic_data.flags & FLAGS_WORKAROUND_ASR_ERRATUM_8601001)
+		mpidr = ASR8601_AFF_QUIRK(mpidr);
+
 	aff = ((u64)MPIDR_AFFINITY_LEVEL(mpidr, 3) << 32 |
 	       MPIDR_AFFINITY_LEVEL(mpidr, 2) << 16 |
 	       MPIDR_AFFINITY_LEVEL(mpidr, 1) << 8  |
@@ -970,6 +976,9 @@ static int __gic_populate_rdist(struct redist_region *region, void __iomem *ptr)
 	 * Convert affinity to a 32bit value that can be matched to
 	 * GICR_TYPER bits [63:32].
 	 */
+	if (gic_data.flags & FLAGS_WORKAROUND_ASR_ERRATUM_8601001)
+		mpidr = ASR8601_AFF_QUIRK(mpidr);
+
 	aff = (MPIDR_AFFINITY_LEVEL(mpidr, 3) << 24 |
 	       MPIDR_AFFINITY_LEVEL(mpidr, 2) << 16 |
 	       MPIDR_AFFINITY_LEVEL(mpidr, 1) << 8 |
@@ -1265,6 +1274,9 @@ static u16 gic_compute_target_list(int *base_cpu, const struct cpumask *mask,
 	unsigned long mpidr = cpu_logical_map(cpu);
 	u16 tlist = 0;
 
+	if (gic_data.flags & FLAGS_WORKAROUND_ASR_ERRATUM_8601001)
+		mpidr = ASR8601_AFF_QUIRK(mpidr);
+
 	while (cpu < nr_cpu_ids) {
 		tlist |= 1 << (mpidr & 0xf);
 
@@ -1275,6 +1287,8 @@ static u16 gic_compute_target_list(int *base_cpu, const struct cpumask *mask,
 
 		mpidr = cpu_logical_map(cpu);
 
+		if (gic_data.flags & FLAGS_WORKAROUND_ASR_ERRATUM_8601001)
+			mpidr = ASR8601_AFF_QUIRK(mpidr);
 		if (cluster_id != MPIDR_TO_SGI_CLUSTER_ID(mpidr)) {
 			cpu--;
 			goto out;
@@ -1321,6 +1335,8 @@ static void gic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
 		u64 cluster_id = MPIDR_TO_SGI_CLUSTER_ID(cpu_logical_map(cpu));
 		u16 tlist;
 
+		if (gic_data.flags & FLAGS_WORKAROUND_ASR_ERRATUM_8601001)
+			cluster_id = MPIDR_TO_SGI_CLUSTER_ID(ASR8601_AFF_QUIRK(cpu_logical_map(cpu)));
 		tlist = gic_compute_target_list(&cpu, mask, cluster_id);
 		gic_send_sgi(cluster_id, tlist, d->hwirq);
 	}
@@ -1786,6 +1802,15 @@ static bool gic_enable_quirk_nvidia_t241(void *data)
 	return true;
 }
 
+static bool gic_enable_quirk_asr8601(void *data)
+{
+	struct gic_chip_data *d = data;
+
+	d->flags |= FLAGS_WORKAROUND_ASR_ERRATUM_8601001;
+
+	return true;
+}
+
 static const struct gic_quirk gic_quirks[] = {
 	{
 		.desc	= "GICv3: Qualcomm MSM8996 broken firmware",
@@ -1823,6 +1848,11 @@ static const struct gic_quirk gic_quirks[] = {
 		.mask	= 0xffffffff,
 		.init	= gic_enable_quirk_nvidia_t241,
 	},
+	{
+		.desc	= "GICv3: ASR erratum 8601001",
+		.compatible = "asr,asr8601-gic-v3",
+		.init	= gic_enable_quirk_asr8601,
+	},
 	{
 	}
 };
-- 
2.25.1

