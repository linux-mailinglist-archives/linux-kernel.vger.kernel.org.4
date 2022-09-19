Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981F45BCD61
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiISNhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiISNho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:37:44 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C7812D10;
        Mon, 19 Sep 2022 06:37:43 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MWQfZ1sQ5zHnv7;
        Mon, 19 Sep 2022 21:35:34 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 21:37:41 +0800
Received: from huawei.com (10.67.175.34) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 19 Sep
 2022 21:37:41 +0800
From:   Ren Zhijie <renzhijie2@huawei.com>
To:     <njavali@marvell.com>, <GR-QLogic-Storage-Upstream@marvell.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <aeasi@marvell.com>, <dwagner@suse.de>,
        <himanshu.madhani@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ren Zhijie <renzhijie2@huawei.com>
Subject: [PATCH v2 -next] scsi: qla2xxx: Fix build error implicit-function-declaration
Date:   Mon, 19 Sep 2022 21:34:04 +0800
Message-ID: <20220919133404.85425-1-renzhijie2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.175.34]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
Changes in v2:
 - warp the definition statement of qla_trace_init() and qla_trace_uninit() with CONFIG_TRACING.
---
 drivers/scsi/qla2xxx/qla_os.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 2c85f3cce726..f64063e56f3d 100644
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
@@ -2851,6 +2853,7 @@ static void qla2x00_iocb_work_fn(struct work_struct *work)
 static void
 qla_trace_init(void)
 {
+#ifdef CONFIG_TRACING
 	qla_trc_array = trace_array_get_by_name("qla2xxx");
 	if (!qla_trc_array) {
 		ql_log(ql_log_fatal, NULL, 0x0001,
@@ -2859,14 +2862,17 @@ qla_trace_init(void)
 	}
 
 	QLA_TRACE_ENABLE(qla_trc_array);
+#endif
 }
 
 static void
 qla_trace_uninit(void)
 {
+#ifdef CONFIG_TRACING
 	if (!qla_trc_array)
 		return;
 	trace_array_put(qla_trc_array);
+#endif
 }
 
 /*
-- 
2.17.1

