Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC285F4624
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 17:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiJDPGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 11:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiJDPGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 11:06:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DB25AA06
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 08:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664895966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3cLF6DtNyC/Gb0WGy4zL7jnNQldQMBfszjQeREq5ULU=;
        b=BLwn0k+HMWEfPeRYkfeE4PCsZEXKmgTarc8LQepVey5gVFw0u1O3D/z1P6V1eW8t4zS1fN
        ehUFLa4k7gRzf+szaKK4BPrg2VVN5jGIl8jtg7hMwQkfDQxvm/NBYxiEZDc+3js73jP5Gw
        EiATVCyMVs/8QMGen09vwutOsfbm0ZY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-549-eMoEcQiFMkCiKn1EBThmtQ-1; Tue, 04 Oct 2022 11:06:04 -0400
X-MC-Unique: eMoEcQiFMkCiKn1EBThmtQ-1
Received: by mail-wr1-f70.google.com with SMTP id n8-20020adf8b08000000b0022e4d3dc8d2so850935wra.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 08:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3cLF6DtNyC/Gb0WGy4zL7jnNQldQMBfszjQeREq5ULU=;
        b=P9F/A+gD0S5NZGOKC3iDe9pgD7Fjcc4Dz3aZidODa/AOoj78PpQV38JxBYQ1yY4a9B
         Tlg625kAuPILLixmT2Cn6SnR5/D1kzqpqisBUp7xIDFWAUt7eQwHuot+kxdPqzoJZ83v
         oRlqPGypNoY7XD/dWSGbt8hX10aJnK2shyv+6GadCfgnI3T448OjpVKpMGKdtl2e/QYu
         5O4EzBcuY5r1BfHo2gWSgONvA3m7nl2+WbR7+uCX+LnLTTsqawQu7Tzu047Ghu0mwnGu
         XkW4M+X/3VcBYNhmhtotTGq7hTBpsqOIdQq3UtxKHvoU/4Jh4KRmwBPDX7jblt2MsGWi
         a/PQ==
X-Gm-Message-State: ACrzQf1t4LYiae/zOXe+nT6ufDlFYc8FNrsRP437QU+BtfNk75D5cmbZ
        ox1jzuz+o+FigDWsX/CtFkFfYgImzI93DRAl9Lue8nbV8eBDfp4ajOURZkAzgeJgmhcinqw7VTC
        CZiW8Ut5rmZFY4lmAW3budSQdOX767wWdo3teEOuapGjkrmqEsRQJxD/dIKdwPu/hVb3359vyyC
        vy
X-Received: by 2002:a05:6000:10cc:b0:22e:39a:efe4 with SMTP id b12-20020a05600010cc00b0022e039aefe4mr12519659wrx.256.1664895962637;
        Tue, 04 Oct 2022 08:06:02 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6X7Cem+rU2pIGih05enKEhzv4swiuzdhoH5HERlNmvpiizxdblaOMcFhmsxOCSwl1h+y7Wqg==
X-Received: by 2002:a05:6000:10cc:b0:22e:39a:efe4 with SMTP id b12-20020a05600010cc00b0022e039aefe4mr12519631wrx.256.1664895962348;
        Tue, 04 Oct 2022 08:06:02 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id w10-20020a05600c474a00b003b4ac05a8a4sm25777717wmo.27.2022.10.04.08.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 08:06:01 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v4 2/4] workqueue: Factorize unbind/rebind_workers() logic
Date:   Tue,  4 Oct 2022 16:05:19 +0100
Message-Id: <20221004150521.822266-3-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221004150521.822266-1-vschneid@redhat.com>
References: <20221004150521.822266-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index 8e21c352c155..8185a42848c5 100644
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

