Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40A770B8BD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjEVJWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbjEVJV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:21:56 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D505012B
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 02:21:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VjCMWO._1684747302;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VjCMWO._1684747302)
          by smtp.aliyun-inc.com;
          Mon, 22 May 2023 17:21:47 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Sandeep Dhavale <dhavale@google.com>
Subject: [PATCH] erofs: use HIPRI by default if per-cpu kthreads are enabled
Date:   Mon, 22 May 2023 17:21:41 +0800
Message-Id: <20230522092141.124290-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Sandeep shown [1], high priority RT per-cpu kthreads are
typically helpful for Android scenarios to minimize the scheduling
latencies.

Switch EROFS_FS_PCPU_KTHREAD_HIPRI on by default if
EROFS_FS_PCPU_KTHREAD is on since it's the typical use cases for
EROFS_FS_PCPU_KTHREAD.

Also clean up unneeded sched_set_normal().

[1] https://lore.kernel.org/r/CAB=BE-SBtO6vcoyLNA9F-9VaN5R0t3o_Zn+FW8GbO6wyUqFneQ@mail.gmail.com
Cc: Sandeep Dhavale <dhavale@google.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/Kconfig | 1 +
 fs/erofs/zdata.c | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 704fb59577e0..f259d92c9720 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -121,6 +121,7 @@ config EROFS_FS_PCPU_KTHREAD
 config EROFS_FS_PCPU_KTHREAD_HIPRI
 	bool "EROFS high priority per-CPU kthread workers"
 	depends on EROFS_FS_ZIP && EROFS_FS_PCPU_KTHREAD
+	default y
 	help
 	  This permits EROFS to configure per-CPU kthread workers to run
 	  at higher priority.
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 92f3a01262cf..3ba505434f03 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -367,8 +367,6 @@ static struct kthread_worker *erofs_init_percpu_worker(int cpu)
 		return worker;
 	if (IS_ENABLED(CONFIG_EROFS_FS_PCPU_KTHREAD_HIPRI))
 		sched_set_fifo_low(worker->task);
-	else
-		sched_set_normal(worker->task, 0);
 	return worker;
 }
 
-- 
2.24.4

