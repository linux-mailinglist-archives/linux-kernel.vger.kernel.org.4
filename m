Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0881562B626
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbiKPJOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiKPJOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:14:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FF0559E;
        Wed, 16 Nov 2022 01:14:29 -0800 (PST)
Date:   Wed, 16 Nov 2022 09:14:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668590067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WHQ6L7e8QAPaBVaj6+20+/2M+FkroSiESCfGsG3tCKM=;
        b=J4Ischh9z8cEBBQg6h+0tjNbbPli0hykWBPD/4yvs8MqHs26rV4xZhFsrWTJ6qta43YEFK
        tBA52QUT9vq0+abkHlhYIpxuMeHOZ06aMJYDSyNmPwph+PgpFPCWIni9LGM+Q6YFPJeLvD
        Euu1N3wrA7owv+GDy8htLT1sksMYfWbsQhQieyQ727mu1IOn5ftwNXYqqvn1lcRueBSeJf
        hdppEHBieTONZXkEBgIFSg3giiRtbpfO5RDobLJUhBPQurid8lMwT4TdJaEPpjhWpFeiM2
        XZbUPoy3bLgv7SYX3onVXs2I84gym4F7TUWWUaA/PccEUViFtWsJvgVHWGsQVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668590067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WHQ6L7e8QAPaBVaj6+20+/2M+FkroSiESCfGsG3tCKM=;
        b=naTgVc+kAp0xTEqmJZcDoyvswmE0R5xJK9LoxeapoC3vE7Xft2Z1x/HXUDh7DNX46cdM9r
        ptZslvOAQ7EQUXCw==
From:   "tip-bot2 for Chen Zhongjin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Fix possible memleak in pmu_dev_alloc()
Cc:     Chen Zhongjin <chenzhongjin@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221111103653.91058-1-chenzhongjin@huawei.com>
References: <20221111103653.91058-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Message-ID: <166859006599.4906.10242789446125515108.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e8d7a90c08ce963c592fb49845f2ccc606a2ac21
Gitweb:        https://git.kernel.org/tip/e8d7a90c08ce963c592fb49845f2ccc606a2ac21
Author:        Chen Zhongjin <chenzhongjin@huawei.com>
AuthorDate:    Fri, 11 Nov 2022 18:36:53 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Nov 2022 22:30:12 +01:00

perf: Fix possible memleak in pmu_dev_alloc()

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221111103653.91058-1-chenzhongjin@huawei.com
---
 kernel/events/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index baa6edf..5f262f9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11308,13 +11308,15 @@ static int pmu_dev_alloc(struct pmu *pmu)
 
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
