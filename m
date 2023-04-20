Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61876E8EBD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbjDTJ7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbjDTJ7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:59:35 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F9C1A7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 02:59:34 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q2CYz2kxjz9v7VJ
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 17:49:59 +0800 (CST)
Received: from A2101119013HW2.china.huawei.com (unknown [10.81.207.102])
        by APP2 (Coremail) with SMTP id GxC2BwDXhj3oDEFkH7g7Ag--.1836S3;
        Thu, 20 Apr 2023 10:59:16 +0100 (CET)
From:   Petr Tesarik <petrtesarik@huaweicloud.com>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     Roberto Sassu <roberto.sassu@huawei.com>, petr@tesarici.cz
Subject: [PATCH v1 1/1] swiotlb: Omit total_used and used_hiwater if !CONFIG_DEBUG_FS
Date:   Thu, 20 Apr 2023 11:58:58 +0200
Message-Id: <f7bac7c24c00b0fde0505759af4cd200e7e62740.1681984708.git.petr.tesarik.ext@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1681984708.git.petr.tesarik.ext@huawei.com>
References: <cover.1681984708.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwDXhj3oDEFkH7g7Ag--.1836S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uF17Zr1xJr17ZrW3Zw17trb_yoW8tw1kpF
        ykur15Ga1DXF18C3y3Cr4DuFyfKw4I93y7urWY934rAr17Jw4ftF4kKrWYyFWFqFWvgF4a
        qFy09ry5Kw17ZwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmmb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
        Av7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
        6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r1q6r43MxkF7I0Ew4C26cxK6c
        8Ij28IcwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVWUtVW8ZwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r
        1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
        YxBIdaVFxhVjvjDU0xZFpf9x07j5cTPUUUUU=
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Tesarik <petr.tesarik.ext@huawei.com>

The tracking of used_hiwater adds an atomic operation to the hot
path. This is acceptable only when debugging the kernel. To make
sure that the fields can never be used by mistake, do not even
include them in struct io_tlb_mem if CONFIG_DEBUG_FS is not set.

The build fails after doing that. To fix it, it is necessary to
remove all code specific to debugfs and instead provide a stub
implementation of swiotlb_create_debugfs_files(). As a bonus, this
change allows to remove one __maybe_unused attribute.

Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
---
 include/linux/swiotlb.h |  2 ++
 kernel/dma/swiotlb.c    | 15 ++++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 6dc4598d2260..44767844e12b 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -107,8 +107,10 @@ struct io_tlb_mem {
 	unsigned int area_nslabs;
 	struct io_tlb_area *areas;
 	struct io_tlb_slot *slots;
+#ifdef CONFIG_DEBUG_FS
 	atomic_long_t total_used;
 	atomic_long_t used_hiwater;
+#endif
 };
 extern struct io_tlb_mem io_tlb_default_mem;
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 9bbc2802a444..e67dafc255f2 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -966,6 +966,8 @@ bool is_swiotlb_active(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(is_swiotlb_active);
 
+#ifdef CONFIG_DEBUG_FS
+
 static int io_tlb_used_get(void *data, u64 *val)
 {
 	struct io_tlb_mem *mem = data;
@@ -1015,15 +1017,22 @@ static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
 			&fops_io_tlb_hiwater);
 }
 
-static int __init __maybe_unused swiotlb_create_default_debugfs(void)
+static int __init swiotlb_create_default_debugfs(void)
 {
 	swiotlb_create_debugfs_files(&io_tlb_default_mem, "swiotlb");
 	return 0;
 }
 
-#ifdef CONFIG_DEBUG_FS
 late_initcall(swiotlb_create_default_debugfs);
-#endif
+
+#else  /* !CONFIG_DEBUG_FS */
+
+static inline void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
+						const char *dirname)
+{
+}
+
+#endif	/* CONFIG_DEBUG_FS */
 
 #ifdef CONFIG_DMA_RESTRICTED_POOL
 
-- 
2.25.1

