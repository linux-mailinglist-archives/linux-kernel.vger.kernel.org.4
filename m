Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EE1698D9D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 08:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjBPHNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 02:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjBPHNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 02:13:14 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F0C27D6E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 23:12:46 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id m2so1157784plg.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 23:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oRJfoVOuCSLIf78Tk6rnAQ5m7tVOuXtuPC5IuUQp6R4=;
        b=FEpvpz7mUvMjqlm3jQ3PCJGj/ZK71ogs072O+aTQvHvll2bdi0VzLG5enkjmpeeTi8
         G5ua1ZIpC56xTVM/1Onk6Qr8qpmt1qH17E6CXo0XMwDmm26CuiQUeaaqOfq6TKTESUpk
         hEeCprjNFzSQ5mRE9MU/gutxEgamglP3q/YpBW3nsYL63NMnLSrJ78lJIKedq807NCtm
         FcEXPnfIFfUtyBXIoJCUBwF5KDhTTWusH+inkYdIuV0St6OVNKB+128izxNuZACCZfx8
         yDt7+JXgPNxwpGRgYzvZMS8Pf1PZoroiS0wUlKkdCnK+0wHShrr59gcNLl0wip609kVc
         uzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oRJfoVOuCSLIf78Tk6rnAQ5m7tVOuXtuPC5IuUQp6R4=;
        b=N7ieRou7/4hcOPotwpNtCWzg4y0vLSjUMqUzqf1N5VPTH/zRh7pZyTxZfORENBG0Pf
         pRhvfYXFiSdXo4SYFSFCXQ3/pPc1xTe2zrIA5ZVcZ4ncbiteZR6Xk9o8msRugz00vi/f
         0WE9imHM0uqH/lGk25o7lvNDbLEY44u9/NX9uksJksavcEbFBMJFVUSsDkQJ63x8qIPf
         IKdvo1W2QysYCuOXVaGDTdlLBSM5Ej8bueVLymtT3ACo1x5IWMr4ok9EPEMorjNlIegp
         M61R31fwwFAJC4LOqwURKbSdh1Oq91qqx9B4PArsaAyiBjl6yySE7DI4n5bldQ7+kENt
         51HA==
X-Gm-Message-State: AO0yUKWkrj/HqpWE7ixD5YzgfFrTbxlx0BDChFhGHKQZFdZpxNV3qoNY
        5Zx2vyR/LIgHKSEgjXuuyUAvAA==
X-Google-Smtp-Source: AK7set9YQaOKAwsu85KcDYCDCX/HCS3jh1iu4dV8DrS1VIphXH2yomAeQBnOqpPSdAnnMBdnW6ZPSg==
X-Received: by 2002:a05:6a20:441b:b0:c0:af73:be4d with SMTP id ce27-20020a056a20441b00b000c0af73be4dmr5946807pzb.54.1676531566264;
        Wed, 15 Feb 2023 23:12:46 -0800 (PST)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id v5-20020a170902b7c500b001994554099esm517126plz.173.2023.02.15.23.12.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Feb 2023 23:12:45 -0800 (PST)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     robin.murphy@arm.com, joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        Li Bin <huawei.libin@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: [PATCH] iommu: Avoid softlockup and rcu stall in fq_flush_timeout().
Date:   Thu, 16 Feb 2023 15:11:48 +0800
Message-Id: <20230216071148.2060-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is softlockup under fio pressure test with smmu enabled:
watchdog: BUG: soft lockup - CPU#81 stuck for 22s!  [swapper/81:0]
...
Call trace:
 fq_flush_timeout+0xc0/0x110
 call_timer_fn+0x34/0x178
 expire_timers+0xec/0x158
 run_timer_softirq+0xc0/0x1f8
 __do_softirq+0x120/0x324
 irq_exit+0x11c/0x140
 __handle_domain_irq+0x6c/0xc0
 gic_handle_irq+0x6c/0x170
 el1_irq+0xb8/0x140
 arch_cpu_idle+0x38/0x1c0
 default_idle_call+0x24/0x44
 do_idle+0x1f4/0x2d8
 cpu_startup_entry+0x2c/0x30
 secondary_start_kernel+0x17c/0x1c8

Rcu stall may also be triggered:

rcu: INFO: rcu_sched self-detected stall on CPU
NMI backtrace for cpu 21
CPU: 21 PID: 118 Comm: ksoftirqd/21
...
Call trace:
 fq_flush_timeout+0x6d/0x90
 ? fq_ring_free+0xc0/0xc0
 call_timer_fn+0x2b/0x120
 run_timer_softirq+0x1a6/0x420
 ? finish_task_switch+0x80/0x280
 __do_softirq+0xda/0x2da
 ? sort_range+0x20/0x20
 run_ksoftirqd+0x26/0x40
 smpboot_thread_fn+0xb8/0x150
 kthread+0x110/0x130
 ? __kthread_cancel_work+0x40/0x40
 ret_from_fork+0x1f/0x30

This is because the timer callback fq_flush_timeout may run more than
10ms, and timer may be processed continuously in the softirq so trigger
softlockup and rcu stall. We can use work to deal with fq_ring_free for
each cpu which may take long time, that to avoid triggering softlockup
and rcu stall.

This patch is modified from the patch[1] of openEuler.

[1] https://mailweb.openeuler.org/hyperkitty/list/kernel@openeuler.org/message/C3KYS4BXTDMVVBQNEQYNAOGOQWFFINHJ/

Signed-off-by: Li Bin <huawei.libin@huawei.com>
Reviewed-by: Xie XiuQi <xiexiuqi@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 drivers/iommu/dma-iommu.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 99b2646cb5c7..bc4c979d7091 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -59,6 +59,8 @@ struct iommu_dma_cookie {
 			struct timer_list	fq_timer;
 			/* 1 when timer is active, 0 when not */
 			atomic_t		fq_timer_on;
+			/* The work to free iova */
+			struct work_struct free_iova_work;
 		};
 		/* Trivial linear page allocator for IOMMU_DMA_MSI_COOKIE */
 		dma_addr_t		msi_iova;
@@ -155,20 +157,10 @@ static void fq_flush_iotlb(struct iommu_dma_cookie *cookie)
 static void fq_flush_timeout(struct timer_list *t)
 {
 	struct iommu_dma_cookie *cookie = from_timer(cookie, t, fq_timer);
-	int cpu;
 
 	atomic_set(&cookie->fq_timer_on, 0);
 	fq_flush_iotlb(cookie);
-
-	for_each_possible_cpu(cpu) {
-		unsigned long flags;
-		struct iova_fq *fq;
-
-		fq = per_cpu_ptr(cookie->fq, cpu);
-		spin_lock_irqsave(&fq->lock, flags);
-		fq_ring_free(cookie, fq);
-		spin_unlock_irqrestore(&fq->lock, flags);
-	}
+	schedule_work(&cookie->free_iova_work);
 }
 
 static void queue_iova(struct iommu_dma_cookie *cookie,
@@ -227,6 +219,7 @@ static void iommu_dma_free_fq(struct iommu_dma_cookie *cookie)
 		return;
 
 	del_timer_sync(&cookie->fq_timer);
+	cancel_work_sync(&cookie->free_iova_work);
 	/* The IOVAs will be torn down separately, so just free our queued pages */
 	for_each_possible_cpu(cpu) {
 		struct iova_fq *fq = per_cpu_ptr(cookie->fq, cpu);
@@ -238,6 +231,23 @@ static void iommu_dma_free_fq(struct iommu_dma_cookie *cookie)
 	free_percpu(cookie->fq);
 }
 
+static void free_iova_work_func(struct work_struct *work)
+{
+	struct iommu_dma_cookie *cookie;
+	int cpu;
+
+	cookie = container_of(work, struct iommu_dma_cookie, free_iova_work);
+	for_each_possible_cpu(cpu) {
+		unsigned long flags;
+		struct iova_fq *fq;
+
+		fq = per_cpu_ptr(cookie->fq, cpu);
+		spin_lock_irqsave(&fq->lock, flags);
+		fq_ring_free(cookie, fq);
+		spin_unlock_irqrestore(&fq->lock, flags);
+	}
+}
+
 /* sysfs updates are serialised by the mutex of the group owning @domain */
 int iommu_dma_init_fq(struct iommu_domain *domain)
 {
@@ -271,6 +281,7 @@ int iommu_dma_init_fq(struct iommu_domain *domain)
 
 	cookie->fq = queue;
 
+	INIT_WORK(&cookie->free_iova_work, free_iova_work_func);
 	timer_setup(&cookie->fq_timer, fq_flush_timeout, 0);
 	atomic_set(&cookie->fq_timer_on, 0);
 	/*
-- 
2.20.1

