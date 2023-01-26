Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFCC67D7F1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 22:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbjAZVvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 16:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbjAZVvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 16:51:39 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AAE4E530
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 13:51:38 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QJA4vY011554
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 13:51:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=s5rbVdHY8if3NZwBpxyqPHsyHy0AGgbbdnlk67jswfk=;
 b=ASRbVkEP1febABvLy/E0M7KjVontma+WpIWKpp2bOHChITSLbdpyiQfexfBcy6D/RptR
 bDSRXFGJLr4hPl6ETgdfbdd1EhaMZFsw38KGwRzHFEt+c/fOQ29gMBwyA3uuLvfY+4QX
 bWYQRjIMczLp7ifZe7xe4b+nWOnp/G5In2o/uYYqMwzBDXf/dRCjX2hJd94JsWXjlJBr
 20kd7KkQ1Mf+Ocz8gB9pqjlaD1P2Hy0H4It4QcwGSyeHKoJy7nlMDujxK6i1XjDdzGPk
 0TAfTJOE6d47lcv6WTJ64X4xWgdP+b+ZqAj6Xxbrx5b/cBu8sLHCTHF8GFsJ6LpmuGlt cw== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nbb800mmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 13:51:37 -0800
Received: from twshared24547.08.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 26 Jan 2023 13:51:35 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id DC4FCFE80A8D; Thu, 26 Jan 2023 13:51:25 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>, <hch@lst.de>, <tonyb@cybernetics.com>,
        <akpm@linux-foundation.org>
CC:     <kernel-team@meta.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 01/12] dmapool: add alloc/free performance test
Date:   Thu, 26 Jan 2023 13:51:14 -0800
Message-ID: <20230126215125.4069751-2-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230126215125.4069751-1-kbusch@meta.com>
References: <20230126215125.4069751-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: XmCKWTqd_snPB4UGfIXDAbjTNxq79nor
X-Proofpoint-GUID: XmCKWTqd_snPB4UGfIXDAbjTNxq79nor
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_09,2023-01-26_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Provide a module that allocates and frees many blocks of various sizes
and report how long it takes. This is intended to provide a consistent
way to measure how changes to the dma_pool_alloc/free routines affect
timing.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 mm/Kconfig        |   9 +++
 mm/Makefile       |   1 +
 mm/dmapool_test.c | 147 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 157 insertions(+)
 create mode 100644 mm/dmapool_test.c

diff --git a/mm/Kconfig b/mm/Kconfig
index ebfe5796adf83..28ee03f39e93f 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1099,6 +1099,15 @@ comment "GUP_TEST needs to have DEBUG_FS enabled"
 config GUP_GET_PXX_LOW_HIGH
 	bool
=20
+config DMAPOOL_TEST
+	tristate "Enable a module to run time tests on dma_pool"
+	depends on HAS_DMA
+	help
+	  Provides a test module that will allocate and free many blocks of
+	  various sizes and report how long it takes. This is intended to
+	  provide a consistent way to measure how changes to the
+	  dma_pool_alloc/free routines affect performance.
+
 config ARCH_HAS_PTE_SPECIAL
 	bool
=20
diff --git a/mm/Makefile b/mm/Makefile
index 8e105e5b3e293..3a08f5d7b1782 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -103,6 +103,7 @@ obj-$(CONFIG_MEMCG) +=3D swap_cgroup.o
 endif
 obj-$(CONFIG_CGROUP_HUGETLB) +=3D hugetlb_cgroup.o
 obj-$(CONFIG_GUP_TEST) +=3D gup_test.o
+obj-$(CONFIG_DMAPOOL_TEST) +=3D dmapool_test.o
 obj-$(CONFIG_MEMORY_FAILURE) +=3D memory-failure.o
 obj-$(CONFIG_HWPOISON_INJECT) +=3D hwpoison-inject.o
 obj-$(CONFIG_DEBUG_KMEMLEAK) +=3D kmemleak.o
diff --git a/mm/dmapool_test.c b/mm/dmapool_test.c
new file mode 100644
index 0000000000000..370fb9e209eff
--- /dev/null
+++ b/mm/dmapool_test.c
@@ -0,0 +1,147 @@
+#include <linux/device.h>
+#include <linux/dma-map-ops.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmapool.h>
+#include <linux/kernel.h>
+#include <linux/ktime.h>
+#include <linux/module.h>
+
+#define NR_TESTS (100)
+
+struct dma_pool_pair {
+	dma_addr_t dma;
+	void *v;
+};
+
+struct dmapool_parms {
+	size_t size;
+	size_t align;
+	size_t boundary;
+};
+
+static const struct dmapool_parms pool_parms[] =3D {
+	{ .size =3D 16, .align =3D 16, .boundary =3D 0 },
+	{ .size =3D 64, .align =3D 64, .boundary =3D 0 },
+	{ .size =3D 256, .align =3D 256, .boundary =3D 0 },
+	{ .size =3D 1024, .align =3D 1024, .boundary =3D 0 },
+	{ .size =3D 4096, .align =3D 4096, .boundary =3D 0 },
+	{ .size =3D 68, .align =3D 32, .boundary =3D 4096 },
+};
+
+static struct dma_pool *pool;
+static struct device test_dev;
+static u64 dma_mask;
+
+static inline int nr_blocks(int size)
+{
+	return clamp_t(int, (PAGE_SIZE / size) * 512, 1024, 8192);
+}
+
+static int dmapool_test_alloc(struct dma_pool_pair *p, int blocks)
+{
+	int i;
+
+	for (i =3D 0; i < blocks; i++) {
+		p[i].v =3D dma_pool_alloc(pool, GFP_KERNEL,
+					&p[i].dma);
+		if (!p[i].v)
+			goto pool_fail;
+	}
+
+	for (i =3D 0; i < blocks; i++)
+		dma_pool_free(pool, p[i].v, p[i].dma);
+
+	return 0;
+
+pool_fail:
+	for (--i; i >=3D 0; i--)
+		dma_pool_free(pool, p[i].v, p[i].dma);
+	return -ENOMEM;
+}
+
+static int dmapool_test_block(const struct dmapool_parms *parms)
+{
+	int blocks =3D nr_blocks(parms->size);
+	ktime_t start_time, end_time;
+	struct dma_pool_pair *p;
+	int i, ret;
+
+	p =3D kcalloc(blocks, sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	pool =3D dma_pool_create("test pool", &test_dev, parms->size,
+			       parms->align, parms->boundary);
+	if (!pool) {
+		ret =3D -ENOMEM;
+		goto free_pairs;
+	}
+
+	start_time =3D ktime_get();
+	for (i =3D 0; i < NR_TESTS; i++) {
+		ret =3D dmapool_test_alloc(p, blocks);
+		if (ret)
+			goto free_pool;
+		if (need_resched())
+			cond_resched();
+	}
+	end_time =3D ktime_get();
+
+	printk("dmapool test: size:%-4zu align:%-4zu blocks:%-4d time:%llu\n",
+		parms->size, parms->align, blocks,
+		ktime_us_delta(end_time, start_time));
+
+free_pool:
+	dma_pool_destroy(pool);
+free_pairs:
+	kfree(p);
+	return ret;
+}
+
+static void dmapool_test_release(struct device *dev)
+{
+}
+
+static int dmapool_checks(void)
+{
+	int i, ret;
+
+	ret =3D dev_set_name(&test_dev, "dmapool-test");
+	if (ret)
+		return ret;
+
+	ret =3D device_register(&test_dev);
+	if (ret) {
+		printk("%s: register failed:%d\n", __func__, ret);
+		goto put_device;
+	}
+
+	test_dev.release =3D dmapool_test_release;
+	set_dma_ops(&test_dev, NULL);
+	test_dev.dma_mask =3D &dma_mask;
+	ret =3D dma_set_mask_and_coherent(&test_dev, DMA_BIT_MASK(64));
+	if (ret) {
+		printk("%s: mask failed:%d\n", __func__, ret);
+		goto del_device;
+	}
+
+	for (i =3D 0; i < ARRAY_SIZE(pool_parms); i++) {
+		ret =3D dmapool_test_block(&pool_parms[i]);
+		if (ret)
+			break;
+	}
+
+del_device:
+	device_del(&test_dev);
+put_device:
+	put_device(&test_dev);
+	return ret;
+}
+
+static void dmapool_exit(void)
+{
+}
+
+module_init(dmapool_checks);
+module_exit(dmapool_exit);
+MODULE_LICENSE("GPL");
--=20
2.30.2

