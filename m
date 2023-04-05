Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1526D84F5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 19:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjDERaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 13:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbjDER35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 13:29:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4426A5A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 10:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680715731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GPqtHGUUdaGMWj+r62KgPaCWtTqZFGGxhe2WBH2SAZQ=;
        b=dKfPiQA6BAAutZCGHfi9HFDycnmnIzn1N6UINI8LZ0W0HZ1W0IPU0l7ZkakqacGgSCkd2o
        KTqBKi6NXVj1Ie9uDJJ+JuX09aD2Pwe6Z2dMaK7jg/cqsrtKFMSOC1nPfPkMiDe68NsG3V
        cZHMmszg0r3CT1PtY5moSUj1+SQeTog=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-qymVOFufN7GrAuaKToXmBQ-1; Wed, 05 Apr 2023 13:28:49 -0400
X-MC-Unique: qymVOFufN7GrAuaKToXmBQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 43936381458A;
        Wed,  5 Apr 2023 17:28:49 +0000 (UTC)
Received: from llong.com (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C647C1602A;
        Wed,  5 Apr 2023 17:28:49 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] perf/arm-dmc620: Reverse locking order in dmc620_pmu_get_irq()
Date:   Wed,  5 Apr 2023 13:28:42 -0400
Message-Id: <20230405172842.2663770-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
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
dmc620_pmu_device_probe(). Fix this possible deadlock scenario by
reversing the locking order.

Also export __cpuhp_state_add_instance_cpuslocked() so that it can be
accessed by kernel modules.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 drivers/perf/arm_dmc620_pmu.c | 4 +++-
 kernel/cpu.c                  | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
index 54aa4658fb36..78d3bfbe96a6 100644
--- a/drivers/perf/arm_dmc620_pmu.c
+++ b/drivers/perf/arm_dmc620_pmu.c
@@ -425,7 +425,7 @@ static struct dmc620_pmu_irq *__dmc620_pmu_get_irq(int irq_num)
 	if (ret)
 		goto out_free_irq;
 
-	ret = cpuhp_state_add_instance_nocalls(cpuhp_state_num, &irq->node);
+	ret = cpuhp_state_add_instance_nocalls_cpuslocked(cpuhp_state_num, &irq->node);
 	if (ret)
 		goto out_free_irq;
 
@@ -445,9 +445,11 @@ static int dmc620_pmu_get_irq(struct dmc620_pmu *dmc620_pmu, int irq_num)
 {
 	struct dmc620_pmu_irq *irq;
 
+	cpus_read_lock();
 	mutex_lock(&dmc620_pmu_irqs_lock);
 	irq = __dmc620_pmu_get_irq(irq_num);
 	mutex_unlock(&dmc620_pmu_irqs_lock);
+	cpus_read_unlock();
 
 	if (IS_ERR(irq))
 		return PTR_ERR(irq);
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6c0a92ca6bb5..05daaef362e6 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2036,6 +2036,7 @@ int __cpuhp_state_add_instance_cpuslocked(enum cpuhp_state state,
 	mutex_unlock(&cpuhp_state_mutex);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(__cpuhp_state_add_instance_cpuslocked);
 
 int __cpuhp_state_add_instance(enum cpuhp_state state, struct hlist_node *node,
 			       bool invoke)
-- 
2.31.1

