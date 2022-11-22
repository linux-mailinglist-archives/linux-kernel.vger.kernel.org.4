Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3F1634499
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 20:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbiKVTbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 14:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234792AbiKVTbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 14:31:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471CC92B42
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 11:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669145409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eQtqTu7JRNjFnV6o8lHrVhZyrgiyx0mHVqwoCilAwG0=;
        b=cHfYR5FI7gs5KBa6wABcFhvST4XH2TkGe23cXdLSkO9pwTnjUWPOaEF53H7CpTH6AeHVSe
        0b7udjKznrEPwTz9cGSXiwUYH2BqO8eL5EEfj4W4TGKCqUAzM14iyavvetXGnAauNwzCQV
        puRlq1gEnBTpfFeLEqGMlGc54s8IxmQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-668-xi6gbFknMy63a4Nqet-pkw-1; Tue, 22 Nov 2022 14:30:08 -0500
X-MC-Unique: xi6gbFknMy63a4Nqet-pkw-1
Received: by mail-wm1-f70.google.com with SMTP id q12-20020a1ce90c000000b003d00f3fe1e7so3324197wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 11:30:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQtqTu7JRNjFnV6o8lHrVhZyrgiyx0mHVqwoCilAwG0=;
        b=SvHyq3eXfvSOdqegQmBFaCzDlYTYSNyKAVikb84E23LpwpoV1qdHXRGWYNWbHpmb8y
         DcTnkXlwasOfXGWGwBpASd2HHolMYsmcOkxmW5/j6pPpFFglycJ0KxlGCcpo2ke53R8N
         /OPcSvRdHhzkUjOfy+F4qFRgKqKGhtzoiq8CYDa5gOJmg0ebEslvF4KWuO1loAForNzG
         S8EzAVoxgGBNUi9JWoNVUsCTbTNjyi9M83+TR4GTq07RdPOUaS78Ly/ajE8ryzbWK1gS
         8vZy9W3wTZwHmrpLNmhOo4nZkNFq1Bsp2F0Ui0UaZIWPmPaFmw6OU1zUC/3UvTlE1yWP
         SZhA==
X-Gm-Message-State: ANoB5pljov2ALT0Jv5J1ZjRyPYi48TaGG0FYs8IpV7ftK1uSdQ8hnI4V
        CiP2Y/mjoJXL6qPDxEvoVAdkQva+e/05/+BZ6ztoTnmHCnNjgQxtuVpVz2w3CZ/jVowTmXDzHEy
        CXU9LobQGecrfT9TowMcZkAy9trp8Fp73O3v5Z8KVDG94aT0hXZZFxUl1CY9WEpyZIV/1pjRm6w
        WW
X-Received: by 2002:a05:600c:3ba1:b0:3d0:47c:9ff5 with SMTP id n33-20020a05600c3ba100b003d0047c9ff5mr10845525wms.121.1669145406535;
        Tue, 22 Nov 2022 11:30:06 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5IkWaGwMuIWJ4V8ybGoi7SIMx9ByicZYl35kCx95SmvLlj0shCDkorl1JfHSORxk8HjsejKg==
X-Received: by 2002:a05:600c:3ba1:b0:3d0:47c:9ff5 with SMTP id n33-20020a05600c3ba100b003d0047c9ff5mr10845499wms.121.1669145406296;
        Tue, 22 Nov 2022 11:30:06 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id r14-20020adff10e000000b002366553eca7sm4173682wro.83.2022.11.22.11.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 11:30:05 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v5 2/5] workqueue: Factorize unbind/rebind_workers() logic
Date:   Tue, 22 Nov 2022 19:29:34 +0000
Message-Id: <20221122192937.2386494-3-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221122192937.2386494-1-vschneid@redhat.com>
References: <20221122192937.2386494-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Later patches will reuse this code, move it into reusable functions.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/workqueue.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 8e21c352c1558..8185a42848c50 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1972,6 +1972,23 @@ static struct worker *create_worker(struct worker_pool *pool)
 	return NULL;
 }
 
+static void unbind_worker(struct worker *worker)
+{
+	lockdep_assert_held(&wq_pool_attach_mutex);
+
+	kthread_set_per_cpu(worker->task, -1);
+	if (cpumask_intersects(wq_unbound_cpumask, cpu_active_mask))
+		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, wq_unbound_cpumask) < 0);
+	else
+		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
+}
+
+static void rebind_worker(struct worker *worker, struct worker_pool *pool)
+{
+	kthread_set_per_cpu(worker->task, pool->cpu);
+	WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask) < 0);
+}
+
 /**
  * destroy_worker - destroy a workqueue worker
  * @worker: worker to be destroyed
@@ -5008,13 +5025,8 @@ static void unbind_workers(int cpu)
 
 		raw_spin_unlock_irq(&pool->lock);
 
-		for_each_pool_worker(worker, pool) {
-			kthread_set_per_cpu(worker->task, -1);
-			if (cpumask_intersects(wq_unbound_cpumask, cpu_active_mask))
-				WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, wq_unbound_cpumask) < 0);
-			else
-				WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
-		}
+		for_each_pool_worker(worker, pool)
+			unbind_worker(worker);
 
 		mutex_unlock(&wq_pool_attach_mutex);
 	}
@@ -5039,11 +5051,8 @@ static void rebind_workers(struct worker_pool *pool)
 	 * of all workers first and then clear UNBOUND.  As we're called
 	 * from CPU_ONLINE, the following shouldn't fail.
 	 */
-	for_each_pool_worker(worker, pool) {
-		kthread_set_per_cpu(worker->task, pool->cpu);
-		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
-						  pool->attrs->cpumask) < 0);
-	}
+	for_each_pool_worker(worker, pool)
+		rebind_worker(worker, pool);
 
 	raw_spin_lock_irq(&pool->lock);
 
-- 
2.31.1

