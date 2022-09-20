Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F6C5BEE10
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 21:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiITT4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 15:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiITTzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 15:55:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532824DF17
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 12:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663703752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=EvSPE19vYY50yERcfNczWACCNLmBgP6vCyooUyO9/Mc=;
        b=BzE9oOvq43Qt03tqgfq25gG523GqTRf0bb0vjdsRSeMdwDFRA/Ux/csvniiRMl+UrK82TQ
        LEH+btfON3IZ6RN190rcOEwHHiV2Ey6ndpfMaS+t0L6nUQXBqBLMge970f5LK6Tbz3dzMd
        TKB01WKLBZth99IPyK1e1FPxfTz82Wo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-CHSg0IPtNdSws-lVilMKgQ-1; Tue, 20 Sep 2022 15:55:51 -0400
X-MC-Unique: CHSg0IPtNdSws-lVilMKgQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB060811E87;
        Tue, 20 Sep 2022 19:55:50 +0000 (UTC)
Received: from llong.com (unknown [10.22.34.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 70247492B05;
        Tue, 20 Sep 2022 19:55:50 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH v2] locking/qspinlock: Do spin-wait in slowpath if preemptible
Date:   Tue, 20 Sep 2022 15:55:42 -0400
Message-Id: <20220920195542.1548164-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some code paths in the kernel where arch_spin_lock() will be
called directly when the lock isn't expected to be contended and critical
section is short. For example, tracing_saved_cmdlines_size_read()
in kernel/trace/trace.c does that.

In most cases, preemption is also not disabled. This creates a problem
for the qspinlock slowpath which expects preemption to be disabled
to guarantee the safe use of per cpu qnodes structure. To work around
these special use cases, add a preemption count check in the slowpath
and do a simple spin-wait when preemption isn't disabled.

Fixes: a33fda35e3a7 ("Introduce a simple generic 4-byte queued spinlock")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 [v2] Move down spin-wait to after the pending bit wait.

 kernel/locking/qspinlock.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 65a9a10caa6f..d0159038084d 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -398,6 +398,23 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 queue:
 	lockevent_inc(lock_slowpath);
 pv_queue:
+#ifdef CONFIG_PREEMPT_COUNT
+	/*
+	 * As arch_spin_lock() can be called directly in some use cases
+	 * where the lock isn't expected to be contended, critical section
+	 * is short and preemption isn't disabled, we can't use qnodes in
+	 * this case as state may be screwed up in case preemption happens
+	 * or preemption warning may be printed (CONFIG_DEBUG_PREEMPT).
+	 * Just do a simple spin-wait in this case as the lock shouldn't be
+	 * contended for long.
+	 */
+	if (unlikely(!preempt_count())) {
+		while (!queued_spin_trylock(lock))
+			cpu_relax();
+		return;
+	}
+#endif
+
 	node = this_cpu_ptr(&qnodes[0].mcs);
 	idx = node->count++;
 	tail = encode_tail(smp_processor_id(), idx);
-- 
2.31.1

