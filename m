Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122D572FE83
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244555AbjFNMZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244631AbjFNMYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:24:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6FA19A5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686745431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=35DChW7keH1A0MG1jE0ycDQ3IFSVa8psKti14q3PpAE=;
        b=JDTTMkYrhC96aBlXSwIY5tdkh5m4xrLHWOjJt550lmCHL5IxrMGEpYE/lndHvozdxKPoKU
        rrJdEGnYFutLdCk+h4Ag+ioV+eT9gilKvei1xG998YB5CiM1OHbuhNMBRNaFB2uPw/5ItD
        bSstkn8FV5dYkc+q4AE9jaDMl/E6fsA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-173-4klzjLiSM4qwKObKXbZGzA-1; Wed, 14 Jun 2023 08:23:45 -0400
X-MC-Unique: 4klzjLiSM4qwKObKXbZGzA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F213285A5BB;
        Wed, 14 Jun 2023 12:23:44 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.33.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9362A40C20F5;
        Wed, 14 Jun 2023 12:23:41 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Mike Christie <michael.christie@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wander Lairson Costa <wander@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [PATCH v10 2/2] sched: avoid false lockdep splat in put_task_struct()
Date:   Wed, 14 Jun 2023 09:23:22 -0300
Message-Id: <20230614122323.37957-3-wander@redhat.com>
In-Reply-To: <20230614122323.37957-1-wander@redhat.com>
References: <20230614122323.37957-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In put_task_struct(), a spin_lock is indirectly acquired under the kernel
stock. When running the kernel in real-time (RT) configuration, the
operation is dispatched to a preemptible context call to ensure
guaranteed preemption. However, if PROVE_RAW_LOCK_NESTING is enabled
and __put_task_struct() is called while holding a raw_spinlock, lockdep
incorrectly reports an "Invalid lock context" in the stock kernel.

This false splat occurs because lockdep is unaware of the different
route taken under RT. To address this issue, override the inner wait
type to prevent the false lockdep splat.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Luis Goncalves <lgoncalv@redhat.com>
---
 include/linux/sched/task.h | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index d20de91e3b95..b53909027771 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -125,6 +125,19 @@ static inline void put_task_struct(struct task_struct *t)
 	if (!refcount_dec_and_test(&t->usage))
 		return;
 
+	/*
+	 * In !RT, it is always safe to call __put_task_struct().
+	 * Under RT, we can only call it in preemptible context.
+	 */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
+		static DEFINE_WAIT_OVERRIDE_MAP(put_task_map, LD_WAIT_SLEEP);
+
+		lock_map_acquire_try(&put_task_map);
+		__put_task_struct(t);
+		lock_map_release(&put_task_map);
+		return;
+	}
+
 	/*
 	 * under PREEMPT_RT, we can't call put_task_struct
 	 * in atomic context because it will indirectly
@@ -145,10 +158,7 @@ static inline void put_task_struct(struct task_struct *t)
 	 * when it fails to fork a process. Therefore, there is no
 	 * way it can conflict with put_task_struct().
 	 */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())
-		call_rcu(&t->rcu, __put_task_struct_rcu_cb);
-	else
-		__put_task_struct(t);
+	call_rcu(&t->rcu, __put_task_struct_rcu_cb);
 }
 
 static inline void put_task_struct_many(struct task_struct *t, int nr)
-- 
2.40.1

