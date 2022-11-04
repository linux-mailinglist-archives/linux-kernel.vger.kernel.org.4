Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D7861946C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 11:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbiKDK1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 06:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbiKDK1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 06:27:14 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B07926116
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 03:27:14 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id b21so4466690plc.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 03:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x4yjwlm7DYTeYVq2DRzxWOxunuOUNgGyKWCgjX1uPMo=;
        b=H7wqaeiKrChWcrDLkbn5KgD7qOUBRu2nJ+CbYytS149L09ET+qocDG8Hf5aU4L0ILY
         X4mfje3q2zhrrohpJSdeNhZAeAUAg8INEVI1lNXa1aziXj/YAZsXVyhqNAcFJW/VSkLM
         wG5PwWVaUe4APP2DphYBts62+FEsIzXWW5Xh3zMy8vzxHXLhJ+Wb3/d06V+fyM3dsCmq
         ITqvH68mBCmORwnzDc9UQN97maq/vYssCHYfeGcvoAbxJ9+2eke4hl+gROFnVTl3Swkm
         QRHJ0vkp7hvLVEGLHdnsdkRxKarllBTv/NFuTgvsBdIKGtQcFg9r1B5ATHEyBevCxnWw
         zbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x4yjwlm7DYTeYVq2DRzxWOxunuOUNgGyKWCgjX1uPMo=;
        b=BxywL3PDdwgRv5acakeunIszTqModjMdShaGZDjE+hQUVGOGYWN1xAtHJEKKsxCQCA
         VYbz0LL6cT6Wpl6U6Kx8w/XiVpS5GWDxob2ehYSP42WAxnJba71HmzbiEeqsKtLi1dw/
         Irb8hms1FK0FzyP2a41+YvNbA4Gf4LLxE8RstSe39hqh71PiqURypYPvuVd/gvv9YGRd
         WyzrBWDleQfqKR/vdoqWWoJI77xlnMAVbUSpQyLgbvi8vXEQqPbVzX0wp5Yb0QRgllxp
         INUTOGwYrga498dZBVN/0ZPYYQ2+ZrtfPFZaCYlfdyZBL8ZYDt5TdRShVqNIcYzVZF9i
         AXSg==
X-Gm-Message-State: ACrzQf12NsoyilJj6mB8mm/ggT4ocaVMECXVVpt02N8pGZTMsoDRS8iR
        KVsz956H4NNmrqNWhX4lKAUREl59ivdv4w==
X-Google-Smtp-Source: AMsMyM7sN/Z4cqFRec0nBSATU8bA89nO/3iOJA4oN5pYfrvPzoVoyC58PpSJgD65frDsTxKR0h+eBA==
X-Received: by 2002:a17:903:234c:b0:188:5f62:8e1e with SMTP id c12-20020a170903234c00b001885f628e1emr4754396plh.30.1667557633624;
        Fri, 04 Nov 2022 03:27:13 -0700 (PDT)
Received: from localhost.localdomain (l3b2w1.cn. [159.138.1.25])
        by smtp.gmail.com with ESMTPSA id s19-20020a170903201300b00186b945c0d1sm2300276pla.2.2022.11.04.03.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 03:27:13 -0700 (PDT)
From:   Binglei Wang <l3b2w1@gmail.com>
X-Google-Original-From: Binglei Wang
To:     tj@kernel.org, jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, Binglei Wang <l3b2w1@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] workqueue: make workers threads stick to HK_TYPE_KTHREAD cpumask
Date:   Fri,  4 Nov 2022 18:27:08 +0800
Message-Id: <20221104102708.849989-1-l3b2w1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Binglei Wang <l3b2w1@gmail.com>

    When worker thread newly created or rebinded to hotplug oneline cpu,
    set its affinity to HK_TYPE_KTHREAD cpumask.
    Make workers threads stick to HK_TYPE_KTHREAD cpumask all the time
    to keep the explicitly isolated(nohz_full) cpus away from interference.

Signed-off-by: Binglei Wang <l3b2w1@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
---

Notes:
    v1 -> v2 : fix robot warning and error
    
    v1: https://lkml.org/lkml/2022/11/2/1566
    All error/warnings (new ones prefixed by >>):
    
    >> kernel/workqueue.c:1958:11: error: incompatible pointer types assigning to 'const struct cupmask *' from 'const struct cpumask *' [-Werror,-Wincompatible-pointer-types]
    cpumask = housekeeping_cpumask(HK_TYPE_KTHREAD);
    	^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    >> kernel/workqueue.c:1959:42: warning: pointer type mismatch ('const struct cupmask *' and 'struct cpumask *') [-Wpointer-type-mismatch]
    kthread_bind_mask(worker->task, cpumask ? cpumask : pool->attrs->cpumask);
    ^ ~~~~~~~   ~~~~~~~~~~~~~~~~~~~~
    1 warning and 1 error generated.

 kernel/workqueue.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7cd5f5e7e..3a780f1a1 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1928,6 +1928,7 @@ static struct worker *create_worker(struct worker_pool *pool)
 	struct worker *worker;
 	int id;
 	char id_buf[16];
+	const struct cpumask *cpumask;
 
 	/* ID is needed to determine kthread name */
 	id = ida_alloc(&pool->worker_ida, GFP_KERNEL);
@@ -1952,7 +1953,12 @@ static struct worker *create_worker(struct worker_pool *pool)
 		goto fail;
 
 	set_user_nice(worker->task, pool->attrs->nice);
-	kthread_bind_mask(worker->task, pool->attrs->cpumask);
+
+	if (housekeeping_enabled(HK_TYPE_KTHREAD))
+		cpumask = housekeeping_cpumask(HK_TYPE_KTHREAD);
+	else
+		cpumask = (const struct cpumask *)pool->attrs->cpumask;
+	kthread_bind_mask(worker->task, cpumask);
 
 	/* successful, attach the worker to the pool */
 	worker_attach_to_pool(worker, pool);
@@ -5027,20 +5033,26 @@ static void unbind_workers(int cpu)
 static void rebind_workers(struct worker_pool *pool)
 {
 	struct worker *worker;
+	const struct cpumask *cpumask = NULL;
 
 	lockdep_assert_held(&wq_pool_attach_mutex);
 
+	if (housekeeping_enabled(HK_TYPE_KTHREAD))
+		cpumask = housekeeping_cpumask(HK_TYPE_KTHREAD);
+
 	/*
 	 * Restore CPU affinity of all workers.  As all idle workers should
 	 * be on the run-queue of the associated CPU before any local
 	 * wake-ups for concurrency management happen, restore CPU affinity
 	 * of all workers first and then clear UNBOUND.  As we're called
 	 * from CPU_ONLINE, the following shouldn't fail.
+	 *
+	 * Also consider the housekeeping HK_TYPE_KTHREAD cpumask.
 	 */
 	for_each_pool_worker(worker, pool) {
 		kthread_set_per_cpu(worker->task, pool->cpu);
 		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
-						  pool->attrs->cpumask) < 0);
+						  cpumask ? cpumask : pool->attrs->cpumask) < 0);
 	}
 
 	raw_spin_lock_irq(&pool->lock);
-- 
2.27.0

