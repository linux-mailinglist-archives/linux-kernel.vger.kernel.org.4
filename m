Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB865F070E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiI3JDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiI3JC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:02:59 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D031F44C1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:02:56 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mf3zw0BMLzlXXc
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 16:58:36 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 17:02:54 +0800
Received: from huawei.com (10.67.174.169) by dggpemm500001.china.huawei.com
 (7.185.36.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 30 Sep
 2022 17:02:54 +0800
From:   Chen Lifu <chenlifu@huawei.com>
To:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC:     <chenlifu@huawei.com>
Subject: [PATCH -next] genirq: Add SPARSE_NR_IRQS Kconfig option
Date:   Fri, 30 Sep 2022 16:58:39 +0800
Message-ID: <20220930085839.315461-1-chenlifu@huawei.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.169]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a large-scale multi-core and NUMA platform, more than 1024 cores and
16 NUMA nodes for example, even if SPASE_IRQ is selected to increase the
number of interrupt numbers by 8196 base on NR_IRQS, the interrupt numbers
requirement cannot be met. Therefore, make the number of sparse interrupt
numbers configurable.

Signed-off-by: Chen Lifu <chenlifu@huawei.com>
---
 kernel/irq/Kconfig     | 8 ++++++++
 kernel/irq/internals.h | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index db3d174c53d4..b517b820e329 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -123,10 +123,18 @@ config SPARSE_IRQ
 	  ( Sparse irqs can also be beneficial on NUMA boxes, as they spread
 	    out the interrupt descriptors in a more NUMA-friendly way. )
 
 	  If you don't know what to do here, say N.
 
+config SPARSE_NR_IRQS
+	int "Number of sparse interrupt numbers"
+	depends on SPARSE_IRQ
+	default 8196
+	help
+	  This defines the maximum number of interrupt numbers
+	  that can be dynamically expanded.
+
 config GENERIC_IRQ_DEBUGFS
 	bool "Expose irq internals in debugfs"
 	depends on DEBUG_FS
 	select GENERIC_IRQ_INJECTION
 	default n
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index f09c60393e55..ab8ac93c60e6 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -10,11 +10,11 @@
 #include <linux/kernel_stat.h>
 #include <linux/pm_runtime.h>
 #include <linux/sched/clock.h>
 
 #ifdef CONFIG_SPARSE_IRQ
-# define IRQ_BITMAP_BITS	(NR_IRQS + 8196)
+# define IRQ_BITMAP_BITS	(NR_IRQS + CONFIG_SPARSE_NR_IRQS)
 #else
 # define IRQ_BITMAP_BITS	NR_IRQS
 #endif
 
 #define istate core_internal_state__do_not_mess_with_it
-- 
2.37.1

