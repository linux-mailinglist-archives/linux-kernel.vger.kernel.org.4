Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB1565C465
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238317AbjACRAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238225AbjACRAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:00:08 -0500
Received: from fx302.security-mail.net (mxout.security-mail.net [85.31.212.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1BA13CC1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 09:00:03 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by fx302.security-mail.net (Postfix) with ESMTP id 663D01C3E6D4
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 17:44:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1672764274;
        bh=InGiH0iJgYy181wPqhv2n8GVVjOkRYsDk7RhLrTs5TM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fjmfVZWNpZzNnyxKFsAz0lO4L8fb129/ggKr6N55h7BlmsMDF98V/S9OaLq5AtrVQ
         tR0MOaIaZEffT5Gj/xOvo4wLXBFTabnR2PGd4nWALKXI6YPlByITUdX74QHdYPeVC5
         l0odhbywVPSJDWQPG1YTxIBz9m6iCsZ2Ygfvk+7U=
Received: from fx302 (localhost [127.0.0.1]) by fx302.security-mail.net
 (Postfix) with ESMTP id 4A6701C3E65C; Tue,  3 Jan 2023 17:44:34 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx302.security-mail.net (Postfix) with ESMTPS id CD0491C3E57B; Tue,  3 Jan
 2023 17:44:33 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id A96A027E03FC; Tue,  3 Jan 2023
 17:44:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 91C8627E03F5; Tue,  3 Jan 2023 17:44:33 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 lkbzYJVXlLq4; Tue,  3 Jan 2023 17:44:33 +0100 (CET)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 71DD727E0405; Tue,  3 Jan 2023
 17:44:33 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <b5d8.63b45b71.cbfe1.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 91C8627E03F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1672764273;
 bh=l1B+GuA0cSDkFnB6q8inQW9UGtWLD1f9lwEi9XlAUjo=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=CD8+2a9wr+G8GeAdeGJ19NEE83uZer6StyzC6xEj8WXdws2HS7nwU6GM8nTzoaImq
 31QVcVrLbOOM+IkwAtbMZEhcB6HTdstcnV9BeA+wn4G4kNn7/nesibL+C44gRYTrcR
 VTc4tZbXkGbYLkEIQfhr8DrvE2arxSz/+VKBfkEE=
From:   Yann Sionneau <ysionneau@kalray.eu>
Cc:     Yann Sionneau <ysionneau@kalray.eu>, linux-kernel@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Julian Vetter <jvetter@kalray.eu>
Subject: [RFC PATCH 25/25] kvx: Add support for cpuinfo
Date:   Tue,  3 Jan 2023 17:43:59 +0100
Message-ID: <20230103164359.24347-26-ysionneau@kalray.eu>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230103164359.24347-1-ysionneau@kalray.eu>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for cpuinfo on kvx arch.

CC: linux-kernel@vger.kernel.org
Co-developed-by: Clement Leger <clement.leger@bootlin.com>
Signed-off-by: Clement Leger <clement.leger@bootlin.com>
Co-developed-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
Signed-off-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
Co-developed-by: Julian Vetter <jvetter@kalray.eu>
Signed-off-by: Julian Vetter <jvetter@kalray.eu>
Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---
 arch/kvx/kernel/cpuinfo.c | 96 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 arch/kvx/kernel/cpuinfo.c

diff --git a/arch/kvx/kernel/cpuinfo.c b/arch/kvx/kernel/cpuinfo.c
new file mode 100644
index 000000000000..f44c46c1e4ba
--- /dev/null
+++ b/arch/kvx/kernel/cpuinfo.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Guillaume Thouvenin
+ */
+
+#include <linux/seq_file.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/cpu.h>
+#include <linux/of.h>
+
+unsigned long elf_hwcap __read_mostly;
+
+static int show_cpuinfo(struct seq_file *m, void *v)
+{
+	int cpu_num = *(unsigned int *)v;
+	struct cpuinfo_kvx *n = per_cpu_ptr(&cpu_info, cpu_num);
+
+	seq_printf(m, "processor\t: %d\nvendor_id\t: Kalray\n", cpu_num);
+
+	seq_printf(m,
+		   "copro enabled\t: %s\n"
+		   "arch revision\t: %d\n"
+		   "uarch revision\t: %d\n",
+		   n->copro_enable ? "yes" : "no",
+		   n->arch_rev,
+		   n->uarch_rev);
+
+	seq_printf(m,
+		   "bogomips\t: %lu.%02lu\n"
+		   "cpu MHz\t\t: %llu.%03llu\n\n",
+		   (loops_per_jiffy * HZ) / 500000,
+		   ((loops_per_jiffy * HZ) / 5000) % 100,
+		   n->freq / 1000000, (n->freq / 10000) % 100);
+
+	return 0;
+}
+
+static void *c_start(struct seq_file *m, loff_t *pos)
+{
+	if (*pos == 0)
+		*pos = cpumask_first(cpu_online_mask);
+	if (*pos >= num_online_cpus())
+		return NULL;
+
+	return pos;
+}
+
+static void *c_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	*pos = cpumask_next(*pos, cpu_online_mask);
+
+	return c_start(m, pos);
+}
+
+static void c_stop(struct seq_file *m, void *v)
+{
+}
+
+const struct seq_operations cpuinfo_op = {
+	.start = c_start,
+	.next = c_next,
+	.stop = c_stop,
+	.show = show_cpuinfo,
+};
+
+static int __init setup_cpuinfo(void)
+{
+	int cpu;
+	struct clk *clk;
+	unsigned long cpu_freq = 1000000000;
+	struct device_node *node = of_get_cpu_node(0, NULL);
+
+	clk = of_clk_get(node, 0);
+	if (IS_ERR(clk)) {
+		printk(KERN_WARNING
+		       "Device tree missing CPU 'clock' parameter. Assuming frequency is 1GHZ");
+		goto setup_cpu_freq;
+	}
+
+	cpu_freq = clk_get_rate(clk);
+
+	clk_put(clk);
+
+setup_cpu_freq:
+	of_node_put(node);
+
+	for_each_possible_cpu(cpu)
+		per_cpu_ptr(&cpu_info, cpu)->freq = cpu_freq;
+
+	return 0;
+}
+
+late_initcall(setup_cpuinfo);
-- 
2.37.2





