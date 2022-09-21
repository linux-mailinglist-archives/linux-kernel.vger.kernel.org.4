Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80F15BFEE4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 15:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiIUNXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 09:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiIUNXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 09:23:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1839994101
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 06:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663766600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HLBVj14Kvh+//JrUKkTN2m6cYRtNgN5l9LrKO3WBsbY=;
        b=XZedqRQZWTOMq0hYY7CE0RI5dYCxZphbORFEoT6z3zDNb0VR3VrPO4iDqQ+tlOIHdlvlpY
        i/29EDPX1KRX8hkB4qibmBzCi5ZrUQ+BIHZ2530LpiE7hzgl+KwhrJPsnWmVhr+1N9YDAG
        G6qKl04ZkfVqF+kQMFYegmEtUQhUpto=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-K_HxCTUOO3KFwfpU19TkqA-1; Wed, 21 Sep 2022 09:23:16 -0400
X-MC-Unique: K_HxCTUOO3KFwfpU19TkqA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 924DF181B7D4;
        Wed, 21 Sep 2022 13:23:15 +0000 (UTC)
Received: from llong.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5AACA35429;
        Wed, 21 Sep 2022 13:23:15 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH 1/2] locking: Provide a low overhead do_arch_spin_lock() API
Date:   Wed, 21 Sep 2022 09:21:51 -0400
Message-Id: <20220921132152.1622616-2-longman@redhat.com>
In-Reply-To: <20220921132152.1622616-1-longman@redhat.com>
References: <20220921132152.1622616-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some code paths in the kernel like tracing or rcu where they
want to use a spinlock without the lock debugging overhead (lockdep,
etc). Provide a do_arch_spin_lock() API with proper preemption disabling
and enabling without any debugging or tracing overhead.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/spinlock.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 5c0c5174155d..535ef0d5bb80 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -119,6 +119,33 @@ do {									\
 #define raw_spin_is_contended(lock)	(((void)(lock), 0))
 #endif /*arch_spin_is_contended*/
 
+/*
+ * Provide a set of do_arch_spin*() APIs to make use of the arch_spinlock_t
+ * with proper preemption disabling & enabling without any debugging and
+ * tracing overhead. Any users of arch_spinlock_t should use this set of
+ * APIs unless it is sure that either preemption or irqs has been disabled.
+ */
+static __always_inline void do_arch_spin_lock(arch_spinlock_t *lock)
+{
+	preempt_disable_notrace();
+	arch_spin_lock(lock);
+}
+
+static __always_inline int do_arch_spin_trylock(arch_spinlock_t *lock)
+{
+	preempt_disable_notrace();
+	if (arch_spin_trylock(lock))
+		return 1;
+	preempt_enable_notrace();
+	return 0;
+}
+
+static __always_inline void do_arch_spin_unlock(arch_spinlock_t *lock)
+{
+	arch_spin_unlock(lock);
+	preempt_enable_notrace();
+}
+
 /*
  * smp_mb__after_spinlock() provides the equivalent of a full memory barrier
  * between program-order earlier lock acquisitions and program-order later
-- 
2.31.1

