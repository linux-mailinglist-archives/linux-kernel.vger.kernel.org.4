Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B98374DD3A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 20:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbjGJSU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 14:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjGJSUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 14:20:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BF512B
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 11:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689013212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Nv5fweDCngTesnKRLAb8mrwCNzQpSKJUun6VW1O8oHw=;
        b=PIXtxUBbnkvzYmJ3ifPqJiWLgLXJGzCDSTbWXpVrx52HvIx9K5ygU4sNSclcgi9XNyNIuu
        TAXfmgg90reK/hh8SFQYF83WqukkzcWaxmAQQiZXefeJMbaJ5ncflzrt24hTmp+5bkyler
        40N3S816fXBuYwhPjyLnphMHVQ5aovs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-2YG5B3anO1epJciQrdsgsA-1; Mon, 10 Jul 2023 14:20:06 -0400
X-MC-Unique: 2YG5B3anO1epJciQrdsgsA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74BCB1044589;
        Mon, 10 Jul 2023 18:20:06 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1974F40C6CD1;
        Mon, 10 Jul 2023 18:20:06 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2] perf/arm-dmc620: Reverse locking order in dmc620_pmu_get_irq()
Date:   Mon, 10 Jul 2023 14:19:59 -0400
Message-Id: <20230710181959.2750269-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following circular locking dependency was reported when running
cpus online/offline test on an arm64 system.

[   84.195923] Chain exists of:
                 dmc620_pmu_irqs_lock --> cpu_hotplug_lock --> cpuhp_state-down

[   84.207305]  Possible unsafe locking scenario:

[   84.213212]        CPU0                    CPU1
[   84.217729]        ----                    ----
[   84.222247]   lock(cpuhp_state-down);
[   84.225899]                                lock(cpu_hotplug_lock);
[   84.232068]                                lock(cpuhp_state-down);
[   84.238237]   lock(dmc620_pmu_irqs_lock);
[   84.242236]
                *** DEADLOCK ***

The problematic locking order seems to be

	lock(dmc620_pmu_irqs_lock) --> lock(cpu_hotplug_lock)

This locking order happens when dmc620_pmu_get_irq() is called from
dmc620_pmu_device_probe(). Since dmc620_pmu_irqs_lock is used for
protecting the dmc620_pmu_irqs structure only, we don't actually need
to hold the lock when adding a new instance to the CPU hotplug subsystem.

Fix this possible deadlock scenario by releasing the lock when a new
dmc620_pmu_irq needs to be created and reacquring it again when the
new irq is inserted into dmc620_pmu_irqs.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 drivers/perf/arm_dmc620_pmu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
index 9d0f01c4455a..dbf67c122420 100644
--- a/drivers/perf/arm_dmc620_pmu.c
+++ b/drivers/perf/arm_dmc620_pmu.c
@@ -419,13 +419,16 @@ static irqreturn_t dmc620_pmu_handle_irq(int irq_num, void *data)
 }
 
 static struct dmc620_pmu_irq *__dmc620_pmu_get_irq(int irq_num)
+	__releases(&dmc620_pmu_irqs_lock)
 {
 	struct dmc620_pmu_irq *irq;
 	int ret;
 
 	list_for_each_entry(irq, &dmc620_pmu_irqs, irqs_node)
 		if (irq->irq_num == irq_num && refcount_inc_not_zero(&irq->refcount))
-			return irq;
+			goto out_unlock;
+
+	mutex_unlock(&dmc620_pmu_irqs_lock);
 
 	irq = kzalloc(sizeof(*irq), GFP_KERNEL);
 	if (!irq)
@@ -452,8 +455,12 @@ static struct dmc620_pmu_irq *__dmc620_pmu_get_irq(int irq_num)
 		goto out_free_irq;
 
 	irq->irq_num = irq_num;
+
+	mutex_lock(&dmc620_pmu_irqs_lock);
 	list_add(&irq->irqs_node, &dmc620_pmu_irqs);
 
+out_unlock:
+	mutex_unlock(&dmc620_pmu_irqs_lock);
 	return irq;
 
 out_free_irq:
@@ -469,7 +476,7 @@ static int dmc620_pmu_get_irq(struct dmc620_pmu *dmc620_pmu, int irq_num)
 
 	mutex_lock(&dmc620_pmu_irqs_lock);
 	irq = __dmc620_pmu_get_irq(irq_num);
-	mutex_unlock(&dmc620_pmu_irqs_lock);
+	/* mutex_unlock() called inside __dmc620_pmu_get_irq() */
 
 	if (IS_ERR(irq))
 		return PTR_ERR(irq);
-- 
2.31.1

