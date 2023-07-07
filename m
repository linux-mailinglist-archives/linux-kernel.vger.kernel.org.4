Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B37374A7F4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 02:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjGGACY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 20:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjGGACW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 20:02:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5B71997
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 17:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688688095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=td6ndgPu8UyiPBmx1pFKVKko26hP20xZBaFgi1+OAqA=;
        b=daoVDoGVcufBPdK8wj3l9/RADR3e/F5cysgeTHVmr6WQWwpPxMl2Gavt5v8FM93h8OMBN8
        uj9Qeue8QgPeodOe8ppq862NUszC0/iWDPncrOwBYye0L9UckRp/Gv+/sxgQDH8wsIvmzY
        W4bP//xbiMiwey9kFWP+TQBXkc2Rvdw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-374-R49XuHfEOle7pJJ01ySK9w-1; Thu, 06 Jul 2023 20:01:27 -0400
X-MC-Unique: R49XuHfEOle7pJJ01ySK9w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 81647185A791;
        Fri,  7 Jul 2023 00:01:26 +0000 (UTC)
Received: from llong.com (unknown [10.22.9.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F4522166B25;
        Fri,  7 Jul 2023 00:01:25 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] refscale: Fix use of uninitalized wait_queue_head_t
Date:   Thu,  6 Jul 2023 20:01:17 -0400
Message-Id: <20230707000117.2371697-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was found that running the refscale test might sometimes crash the
kernel with the following error:

[ 8569.952896] BUG: unable to handle page fault for address: ffffffffffffffe8
[ 8569.952900] #PF: supervisor read access in kernel mode
[ 8569.952902] #PF: error_code(0x0000) - not-present page
[ 8569.952904] PGD c4b048067 P4D c4b049067 PUD c4b04b067 PMD 0
[ 8569.952910] Oops: 0000 [#1] PREEMPT_RT SMP NOPTI
[ 8569.952916] Hardware name: Dell Inc. PowerEdge R750/0WMWCR, BIOS 1.2.4 05/28/2021
[ 8569.952917] RIP: 0010:prepare_to_wait_event+0x101/0x190
  :
[ 8569.952940] Call Trace:
[ 8569.952941]  <TASK>
[ 8569.952944]  ref_scale_reader+0x380/0x4a0 [refscale]
[ 8569.952959]  kthread+0x10e/0x130
[ 8569.952966]  ret_from_fork+0x1f/0x30
[ 8569.952973]  </TASK>

This is likely caused by the fact that init_waitqueue_head() is called
after the ref_scale_reader kthread is created. So the kthread may try
to use the waitqueue head before it is properly initialized. Fix this
by initializing the waitqueue head first before kthread creation.

Fixes: 653ed64b01dc ("refperf: Add a test to measure performance of read-side synchronization")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/rcu/refscale.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 1970ce5f22d4..e365d6f8c139 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -1107,12 +1107,11 @@ ref_scale_init(void)
 	VERBOSE_SCALEOUT("Starting %d reader threads", nreaders);
 
 	for (i = 0; i < nreaders; i++) {
+		init_waitqueue_head(&(reader_tasks[i].wq));
 		firsterr = torture_create_kthread(ref_scale_reader, (void *)i,
 						  reader_tasks[i].task);
 		if (torture_init_error(firsterr))
 			goto unwind;
-
-		init_waitqueue_head(&(reader_tasks[i].wq));
 	}
 
 	// Main Task
-- 
2.31.1

