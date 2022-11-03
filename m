Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534906174C3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 04:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiKCDKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 23:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiKCDJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 23:09:47 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB0D14009
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 20:09:41 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id y4so702215plb.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 20:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BdWhTXBxXiysd2poPDnV59IYfoHF6Yvsi7EDbvrcVKE=;
        b=gYbvK43L1DZqFx+ncvrgw/oZ6CiqmHTE5VXqD3ed95nY7yH3kULTt25HQtXLklnJaB
         tgtwTvK906H+5ij8UMm2GcH5+gE1/axheql6d5qiYQXIUI7OkBd8aDXwPJ3pGNo+SzKI
         6vjBAhPqgRSNZaaaGYlpjeAnJ8RLRoB4rW6cUWEjufDq7lP2SB2uv/PcMP5NoCcti8cU
         94Wh1hJUdzBwdlUhPD50yHQArO9HJG77bepaWCd04enO5PUAu6rsZV2giYlMWRg8s6RA
         PqbBmJ/bS4WQhFMgbyQboPxkvbpdkk/R/IeAv+lUTDBo8t/cdpyfmQVROOJyAgRYZjDP
         7DQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BdWhTXBxXiysd2poPDnV59IYfoHF6Yvsi7EDbvrcVKE=;
        b=8SVFoAyNH4U1g2mn1pj55onNRCfywUUOCeR6vBKOLDvMougJjmQxST31vSrAtGd8XQ
         4mybaj45YKuq45tpDQern1+CW5JfuME9ShU1kC2vA8KcCjBK1g4tKf/Hs5odTag5W4i8
         cDxJ2X/1Bdo8MXKCrYphNV85TQuFW+9j0aC4XfqjQiRLMgkuRjWW5Sv27eQp/kzVCdyp
         zR+GXWwtAUyt4BBpVxnxkX48Q7Z1MKU9ih+GizDI7wZ8mRGi61NPIlYIon4H/6zSknLt
         Wg2E9pwo/DCFkBnZY8WCxqafQ2d7nNmvw6YK7FOjXDxhYXpoSdWxXRIsGuxmSCUjBrwc
         WlFA==
X-Gm-Message-State: ACrzQf2Q+gTGUctNjgrsg85zh7fN65JrnxPlOMr9s97F1bcj3k4nUALz
        bjLvIntSQCnLpbMuAshSS19PllrNb/LBlA==
X-Google-Smtp-Source: AMsMyM7uSuuhKoGAPzmNJmbUvpb56rIIwES06581l3wkuah03l/sMXRHXkXz6UQjsGmmrvzxEbwaMA==
X-Received: by 2002:a17:90b:3886:b0:213:5ccc:973b with SMTP id mu6-20020a17090b388600b002135ccc973bmr45301295pjb.193.1667444980508;
        Wed, 02 Nov 2022 20:09:40 -0700 (PDT)
Received: from localhost.localdomain (l3b2w1.cn. [159.138.1.25])
        by smtp.gmail.com with ESMTPSA id q1-20020a17090a7a8100b0020d67a726easm2177563pjf.10.2022.11.02.20.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 20:09:40 -0700 (PDT)
From:   Binglei Wang <l3b2w1@gmail.com>
X-Google-Original-From: Binglei Wang
To:     tj@kernel.org, jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, Binglei Wang <l3b2w1@gmail.com>
Subject: [PATCH] workqueue: make workers threads stick to HK_TYPE_KTHREAD cpumask
Date:   Thu,  3 Nov 2022 11:09:33 +0800
Message-Id: <20221103030933.840989-1-l3b2w1@gmail.com>
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

When new worker thread created, set its affinity to HK_TYPE_KTHREAD
cpumask.
When hotplug cpu online, rebind workers's affinity to HK_TYPE_KTHREAD
cpumask.
Make workers threads stick to HK_TYPE_KTHREAD cpumask all the time.

Signed-off-by: Binglei Wang <l3b2w1@gmail.com>
---
 kernel/workqueue.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7cd5f5e7e..77b303f5e 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1928,6 +1928,7 @@ static struct worker *create_worker(struct worker_pool *pool)
 	struct worker *worker;
 	int id;
 	char id_buf[16];
+	const struct cupmask *cpumask = NULL;
 
 	/* ID is needed to determine kthread name */
 	id = ida_alloc(&pool->worker_ida, GFP_KERNEL);
@@ -1952,7 +1953,10 @@ static struct worker *create_worker(struct worker_pool *pool)
 		goto fail;
 
 	set_user_nice(worker->task, pool->attrs->nice);
-	kthread_bind_mask(worker->task, pool->attrs->cpumask);
+
+	if (housekeeping_enabled(HK_TYPE_KTHREAD))
+		cpumask = housekeeping_cpumask(HK_TYPE_KTHREAD);
+	kthread_bind_mask(worker->task, cpumask ? cpumask : pool->attrs->cpumask);
 
 	/* successful, attach the worker to the pool */
 	worker_attach_to_pool(worker, pool);
@@ -5027,20 +5031,26 @@ static void unbind_workers(int cpu)
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

