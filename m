Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBA8634496
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 20:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234796AbiKVTbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 14:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbiKVTbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 14:31:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4405690580
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 11:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669145411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zSYjp+tSNrVSXI+gcTD2+vnKTaoJtRYmv4jLOiB9aTk=;
        b=Rj7zYd9sX37WDqapEFV0pXGQtt5+P+0ASTSLUcILy0kzdaLWZNSdd4u5pDLjIgMbERvh44
        k1Oe0TryM+9RAK5jNbuz69gnWvvoeajybO0zb7WnJZ0I2UI0met9X+mk7nwZ6YSzwGVmit
        p7jQZEFbo5HNhLSoY5idXhRqa6hyphU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-195-PEED_0QJOSOISy9CPCxUwQ-1; Tue, 22 Nov 2022 14:30:10 -0500
X-MC-Unique: PEED_0QJOSOISy9CPCxUwQ-1
Received: by mail-wm1-f69.google.com with SMTP id h9-20020a1c2109000000b003cfd37aec58so8516285wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 11:30:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zSYjp+tSNrVSXI+gcTD2+vnKTaoJtRYmv4jLOiB9aTk=;
        b=RilhoFZ1OgHRw7pFXrl0yVmXTZKGdxyW3V3WxmEJrfaLmK4DNme8Jec07LtFsML9Bj
         LwsbkyjkM2isXPrhbbb5EnJFQX7cexHNb9M+QAykL+5HSFOmkutyDTi4p4Rq4QHhHS48
         q6jl4q4+2Xp0UgAvJqWe3OWAxla5jldo0rT9iY28xvjrI/zkNPw+3ofdCPwNDlbm6Guw
         P7r5jUzxuiIep3iW6X42KE5R4y54rBATRhUVmkBJesEurMNeTrvK3xnGUI+x9VCyYXw0
         whXABf/3BJw9oIroMOsRU7YqH29w/ef+bsiAxoYAXuXCe6tcNuZyEL4689HSAW5i+1rW
         PV1A==
X-Gm-Message-State: ANoB5pkTEyQWVZmTCxIXY5uyk8nhZ03ywEnafzrnAf4/7i3rYelY1b38
        jnr9aSjJdVbh/18mAaqHZsZBhreOEQYRBS1VkkW273B/HGK8HqseQVL1l1qaxtMGRG3yPuCwHsP
        uw2/GtQkWZjfZsN4J8CSajAdTnnHYjgfMOrNXmVb07DOXqVh35LUfr5/rm97KuWYMTHcjtfI1zO
        ok
X-Received: by 2002:a05:600c:6545:b0:3cf:baef:e92a with SMTP id dn5-20020a05600c654500b003cfbaefe92amr5385800wmb.178.1669145408533;
        Tue, 22 Nov 2022 11:30:08 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6/JepPLrHqvTtEnrWsWTg0oO86adc7JxOwP62o9Myj55cwEh7sO9iqnA92E83yo76GdpZgpw==
X-Received: by 2002:a05:600c:6545:b0:3cf:baef:e92a with SMTP id dn5-20020a05600c654500b003cfbaefe92amr5385782wmb.178.1669145408300;
        Tue, 22 Nov 2022 11:30:08 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id r14-20020adff10e000000b002366553eca7sm4173682wro.83.2022.11.22.11.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 11:30:07 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v5 3/5] workqueue: Make too_many_workers() return the worker excess
Date:   Tue, 22 Nov 2022 19:29:35 +0000
Message-Id: <20221122192937.2386494-4-vschneid@redhat.com>
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

Later patches will need the logic implemented within too_many_workers() to
get the amount of workers to delete. Rather than duplicate the logic,
rework too_many_workers() to return the count of workers to delete - its
return value can be used as a boolean value, so no change in behaviour
intended.

The function currently returns true when
  (nr_idle - 2) * MAX_IDLE_WORKERS_RATIO >= nr_busy
thus, the desired number of idle workers is expressed by
  (nr_idle - 2) * MAX_IDLE_WORKERS_RATIO == nr_busy - 1
IOW
   nr_idle == ((nr_busy - 1) / MAX_IDLE_WORKERS_RATIO) + 2

MAX_IDLE_WORKERS_RATIO being a compile-time power of 2, we can leave that
as a division.

While at it, rename too_many_workers() to worker_cull_count().

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/workqueue.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 8185a42848c50..4fc8085f3fe17 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -816,14 +816,20 @@ static bool need_to_create_worker(struct worker_pool *pool)
 	return need_more_worker(pool) && !may_start_working(pool);
 }
 
-/* Do we have too many workers and should some go away? */
-static bool too_many_workers(struct worker_pool *pool)
+/* How many idle workers should we get rid of, if any? */
+static unsigned int worker_cull_count(struct worker_pool *pool)
 {
 	bool managing = pool->flags & POOL_MANAGER_ACTIVE;
 	int nr_idle = pool->nr_idle + managing; /* manager is considered idle */
 	int nr_busy = pool->nr_workers - nr_idle;
 
-	return nr_idle > 2 && (nr_idle - 2) * MAX_IDLE_WORKERS_RATIO >= nr_busy;
+	lockdep_assert_held(&pool->lock);
+
+	/*
+	 * We keep at least 2 spare idle workers, but overall aim to keep at
+	 * most (1 / MAX_IDLE_WORKERS_RATIO) workers idle.
+	 */
+	return max(0, nr_idle - 2 - ((nr_busy - 1) / MAX_IDLE_WORKERS_RATIO));
 }
 
 /*
@@ -1806,7 +1812,7 @@ static void worker_enter_idle(struct worker *worker)
 	/* idle_list is LIFO */
 	list_add(&worker->entry, &pool->idle_list);
 
-	if (too_many_workers(pool) && !timer_pending(&pool->idle_timer))
+	if (worker_cull_count(pool) && !timer_pending(&pool->idle_timer))
 		mod_timer(&pool->idle_timer, jiffies + IDLE_WORKER_TIMEOUT);
 
 	/* Sanity check nr_running. */
@@ -2025,7 +2031,7 @@ static void idle_worker_timeout(struct timer_list *t)
 
 	raw_spin_lock_irq(&pool->lock);
 
-	while (too_many_workers(pool)) {
+	while (worker_cull_count(pool)) {
 		struct worker *worker;
 		unsigned long expires;
 
-- 
2.31.1

