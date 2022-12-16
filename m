Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4651364F243
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 21:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbiLPURW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 15:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiLPURR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 15:17:17 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4234D6A768
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 12:17:16 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGJx9Ra012075
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 12:17:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=90Dk+65o6zL/IJhusSfca6Gtj59oaXmZv+zwCh9VWSM=;
 b=jy9Xam41TnuZ7I7z0bKovbU95FicKE3dZCRm44FQ6DCEVup9aF4QpXQRvrl9nocbv1sg
 V/0dCd8DujYodoVlOGFOvuuBMab2QbNNAAgl3A3FyJK64qVtovK731gEy1OmI9zs6/1D
 W8CBRkE+GrQ+FUL0cXxMS7k8792Lp17sR0TiG3JOMmf7CSE1W6R0T0SmQ+fI2SuCth8X
 /gQroU/8mIo5P85+/B4nulgscA9X+y2p0LN+sNz5Zf3hsRkGwvRE6kCemUdgVATjHR0W
 XvuhS3GmCrRehaK/7aj8kaqM3nhWleUrJQntsUefC5MDMZ/p/yDK+zijL5VsmfUaCbdl Yg== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mgm45uyfn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 12:17:15 -0800
Received: from twshared15216.17.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 16 Dec 2022 12:17:13 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id E5D62D042AB1; Fri, 16 Dec 2022 12:17:09 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     Tony Battersby <tonyb@cybernetics.com>,
        Kernel Team <kernel-team@meta.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 01/11] dmapool: add alloc/free performance test
Date:   Fri, 16 Dec 2022 12:16:15 -0800
Message-ID: <20221216201625.2362737-2-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221216201625.2362737-1-kbusch@meta.com>
References: <20221216201625.2362737-1-kbusch@meta.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: DmbyTOlhU_y47KGbqHdVDZ1PA_OVpTk7
X-Proofpoint-GUID: DmbyTOlhU_y47KGbqHdVDZ1PA_OVpTk7
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_14,2022-12-15_02,2022-06-22_01
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
v1->v2:

  Used appropriate dma_ops accessor, fixing:

   https://lore.kernel.org/all/202212061052.hMChRFTf-lkp@intel.com/=20

  Added ability to test arbitrary alignments and boundaries and added an
  entry to test the previously failing test case:

   https://lore.kernel.org/oe-lkp/202212112301.ad0819f7-oliver.sang@intel.c=
om/

 mm/Kconfig        |   9 +++
 mm/Makefile       |   1 +
 mm/dmapool_test.c | 146 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 156 insertions(+)
 create mode 100644 mm/dmapool_test.c

diff --git a/mm/Kconfig b/mm/Kconfig
index 34d36958b8ac9..3d71acc29c10f 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1070,6 +1070,15 @@ config GUP_TEST
 comment "GUP_TEST needs to have DEBUG_FS enabled"
 	depends on !GUP_TEST && !DEBUG_FS
=20
+config DMAPOOL_TEST
+	tristate "Enable a module to run time tests on dma_pool"
+	depends on HAS_DMA
+	help
+	  Provides a module that will allocate and free many blocks of various
+	  sizes and report how long it takes. This is intended to provide a
+	  consistent way to measure how changes to the dma_pool_alloc/free
+	  routines affect performance.
+
 config GUP_GET_PTE_LOW_HIGH
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
index 0000000000000..c4292dfda3690
--- /dev/null
+++ b/mm/dmapool_test.c
@@ -0,0 +1,146 @@
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
+	printk("dmapool test: size:%-4ld blocks:%-6d time:%llu\n", parms->size,
+	       blocks, ktime_us_delta(end_time, start_time));
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

