Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334346CAFEB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 22:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjC0UZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 16:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjC0UZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 16:25:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD593AA5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 13:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679948667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OyPFo4v7z/4QuNDV6N3/A+RFNemmtx8czMnE3tFUcd8=;
        b=QEwqzNqsC6VevxoVx/OSO9gD3wF2487FA+EjAZzuQIsvYiooo0WMaHxE3+n62WBRNuEXwE
        KXA6DsIscPRP7vDUOeWE8LT5zQ7c6VYmNtqvEqB2UYGScXvnQl7l/1KI7Q2rE7NYv5ElrF
        blEEhOr/9ccPUInGN0WXDJo1DPaMckM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-Rithe-3aNKO8GnJWYN1xow-1; Mon, 27 Mar 2023 16:24:23 -0400
X-MC-Unique: Rithe-3aNKO8GnJWYN1xow-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C5C6884EC0;
        Mon, 27 Mar 2023 20:24:23 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D979B2027040;
        Mon, 27 Mar 2023 20:24:22 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] locking/rwsem: Enforce queueing when HANDOFF
Date:   Mon, 27 Mar 2023 16:24:07 -0400
Message-Id: <20230327202413.1955856-3-longman@redhat.com>
In-Reply-To: <20230327202413.1955856-1-longman@redhat.com>
References: <20230327202413.1955856-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Ensure that HANDOFF disables all spinning and stealing.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/rwsem.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index e589f69793df..4b9e492abd59 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -468,7 +468,12 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 					adjustment -= RWSEM_FLAG_HANDOFF;
 					lockevent_inc(rwsem_rlock_handoff);
 				}
+				/*
+				 * With HANDOFF set for reader, we must
+				 * terminate all spinning.
+				 */
 				waiter->handoff_set = true;
+				rwsem_set_nonspinnable(sem);
 			}
 
 			atomic_long_add(-adjustment, &sem->count);
@@ -755,6 +760,10 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
 
 	owner = rwsem_owner_flags(sem, &flags);
 	state = rwsem_owner_state(owner, flags);
+
+	if (owner == current)
+		return OWNER_NONSPINNABLE;	/* Handoff granted */
+
 	if (state != OWNER_WRITER)
 		return state;
 
-- 
2.31.1

