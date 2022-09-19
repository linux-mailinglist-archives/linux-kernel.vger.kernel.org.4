Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3E45BC1A6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 05:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiISDMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 23:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiISDLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 23:11:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258321A3A4;
        Sun, 18 Sep 2022 20:11:54 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MW8kD0D5QzlVyk;
        Mon, 19 Sep 2022 11:07:48 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 11:11:52 +0800
Received: from huawei.com (10.67.175.34) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 19 Sep
 2022 11:11:51 +0800
From:   Ren Zhijie <renzhijie2@huawei.com>
To:     <njavali@marvell.com>, <GR-QLogic-Storage-Upstream@marvell.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <aeasi@marvell.com>, <dwagner@suse.de>,
        <himanshu.madhani@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ren Zhijie <renzhijie2@huawei.com>
Subject: [PATCH -next] scsi: qla2xxx: Fix build error implicit-function-declaration
Date:   Mon, 19 Sep 2022 11:08:10 +0800
Message-ID: <20220919030810.1626-1-renzhijie2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.175.34]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_TRACING is not set,
make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-,
will be failed, like this:

drivers/scsi/qla2xxx/qla_os.c: In function ‘qla_trace_init’:
drivers/scsi/qla2xxx/qla_os.c:2854:18: error: implicit declaration of function ‘trace_array_get_by_name’; did you mean ‘trace_array_set_clr_event’? [-Werror=implicit-function-declaration]
  qla_trc_array = trace_array_get_by_name("qla2xxx");
                  ^~~~~~~~~~~~~~~~~~~~~~~
                  trace_array_set_clr_event
drivers/scsi/qla2xxx/qla_os.c:2854:16: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]
  qla_trc_array = trace_array_get_by_name("qla2xxx");
                ^
drivers/scsi/qla2xxx/qla_os.c: In function ‘qla_trace_uninit’:
drivers/scsi/qla2xxx/qla_os.c:2869:2: error: implicit declaration of function ‘trace_array_put’; did you mean ‘trace_seq_putc’? [-Werror=implicit-function-declaration]
  trace_array_put(qla_trc_array);
  ^~~~~~~~~~~~~~~
  trace_seq_putc
cc1: all warnings being treated as errors

To fix this error, wrap up all the relevant code with CONFIG_TRACING.

Fixes: 8bfc149ba24c ("scsi: qla2xxx: Enhance driver tracing with separate tunable and more")
Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
---
 drivers/scsi/qla2xxx/qla_os.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 2c85f3cce726..e445105ee16d 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -37,7 +37,9 @@ static int apidev_major;
  */
 struct kmem_cache *srb_cachep;
 
+#ifdef CONFIG_TRACING
 static struct trace_array *qla_trc_array;
+#endif
 
 int ql2xfulldump_on_mpifail;
 module_param(ql2xfulldump_on_mpifail, int, S_IRUGO | S_IWUSR);
@@ -2848,6 +2850,7 @@ static void qla2x00_iocb_work_fn(struct work_struct *work)
 	spin_unlock_irqrestore(&vha->work_lock, flags);
 }
 
+#ifdef CONFIG_TRACING
 static void
 qla_trace_init(void)
 {
@@ -2868,7 +2871,7 @@ qla_trace_uninit(void)
 		return;
 	trace_array_put(qla_trc_array);
 }
-
+#endif
 /*
  * PCI driver interface
  */
@@ -8209,7 +8212,9 @@ qla2x00_module_init(void)
 	BUILD_BUG_ON(sizeof(sw_info_t) != 32);
 	BUILD_BUG_ON(sizeof(target_id_t) != 2);
 
+#ifdef CONFIG_TRACING
 	qla_trace_init();
+#endif
 
 	/* Allocate cache for SRBs. */
 	srb_cachep = kmem_cache_create("qla2xxx_srbs", sizeof(srb_t), 0,
@@ -8290,7 +8295,9 @@ qla2x00_module_init(void)
 destroy_cache:
 	kmem_cache_destroy(srb_cachep);
 
+#ifdef CONFIG_TRACING
 	qla_trace_uninit();
+#endif
 	return ret;
 }
 
@@ -8309,7 +8316,9 @@ qla2x00_module_exit(void)
 	fc_release_transport(qla2xxx_transport_template);
 	qlt_exit();
 	kmem_cache_destroy(srb_cachep);
+#ifdef CONFIG_TRACING
 	qla_trace_uninit();
+#endif
 }
 
 module_init(qla2x00_module_init);
-- 
2.17.1

