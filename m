Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16442625887
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 11:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbiKKKkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 05:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233915AbiKKKkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 05:40:07 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31803654E5;
        Fri, 11 Nov 2022 02:40:06 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N7wFN1BB9zRp1W;
        Fri, 11 Nov 2022 18:39:52 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 18:40:04 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 18:40:04 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <chenzhongjin@huawei.com>
Subject: [PATCH] perf: Fix possible memleak in pmu_dev_alloc()
Date:   Fri, 11 Nov 2022 18:36:53 +0800
Message-ID: <20221111103653.91058-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In pmu_dev_alloc(), when dev_set_name() failed, it will goto free_dev
and call put_device(pmu->dev) to release it.
However pmu->dev->release is assigned after this, which makes warning
and memleak.
Call dev_set_name() after pmu->dev->release = pmu_dev_release to fix it.

  Device '(null)' does not have a release() function...
  WARNING: CPU: 2 PID: 441 at drivers/base/core.c:2332 device_release+0x1b9/0x240
  ...
  Call Trace:
    <TASK>
    kobject_put+0x17f/0x460
    put_device+0x20/0x30
    pmu_dev_alloc+0x152/0x400
    perf_pmu_register+0x96b/0xee0
    ...
  kmemleak: 1 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
  unreferenced object 0xffff888014759000 (size 2048):
    comm "modprobe", pid 441, jiffies 4294931444 (age 38.332s)
    backtrace:
      [<0000000005aed3b4>] kmalloc_trace+0x27/0x110
      [<000000006b38f9b8>] pmu_dev_alloc+0x50/0x400
      [<00000000735f17be>] perf_pmu_register+0x96b/0xee0
      [<00000000e38477f1>] 0xffffffffc0ad8603
      [<000000004e162216>] do_one_initcall+0xd0/0x4e0
      ...

Fixes: abe43400579d ("perf: Sysfs enumeration")
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 kernel/events/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4ec3717003d5..baf0f33b06af 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11148,13 +11148,15 @@ static int pmu_dev_alloc(struct pmu *pmu)
 
 	pmu->dev->groups = pmu->attr_groups;
 	device_initialize(pmu->dev);
-	ret = dev_set_name(pmu->dev, "%s", pmu->name);
-	if (ret)
-		goto free_dev;
 
 	dev_set_drvdata(pmu->dev, pmu);
 	pmu->dev->bus = &pmu_bus;
 	pmu->dev->release = pmu_dev_release;
+
+	ret = dev_set_name(pmu->dev, "%s", pmu->name);
+	if (ret)
+		goto free_dev;
+
 	ret = device_add(pmu->dev);
 	if (ret)
 		goto free_dev;
-- 
2.17.1

