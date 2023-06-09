Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1089B728F5A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 07:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjFIFkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 01:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFIFke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 01:40:34 -0400
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA542D7C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 22:40:32 -0700 (PDT)
X-QQ-mid: bizesmtp88t1686289097t682yu6a
Received: from localhost.localdomain ( [1.202.39.170])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 09 Jun 2023 13:38:14 +0800 (CST)
X-QQ-SSF: 01400000000000B0E000000A0000000
X-QQ-FEAT: rZJGTgY0+YNFG+yb1GNGqx8f75qiC25eKE4m4k6tlVn7ndWRRWnJP3rXBCpvk
        n9+UTpxBVPK5hY0/aTGOMhA8VPyTzBlRQgtb9jSngltO26adYPfDf0bLE6v2wMNqvkk8sQJ
        9hc1KljluTtS58WZOKsE4d2ogbtf1/pO2y2pPnAhFKN40pgeAFSHHJZVCSEVAdv1c07NqYS
        ksCp4Mhv9fuRMe4ukkEKKJwMAe3wbMmpmSnzW48mvgrAolbGT/Pb9KAViisrRhHf1YgoV77
        eQGaBC0ovnPkyMzDG4UU9CRIzX6GCfNnobLpyqp3HgZl/OAJvdcVDqNLd5IfkVnxZMaWbsg
        DkYidf0TEujd/plcFMVeXnU+O0s7IS5vyVeyuQv84WPcudq0+j3QH4HC6l8Cg==
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10052826336545712647
From:   Wang You <wangyoua@uniontech.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Wang You <wangyoua@uniontech.com>
Subject: [RFC PATCH] sched/wait: Determine whether the wait queue is empty before waking up
Date:   Fri,  9 Jun 2023 13:38:12 +0800
Message-Id: <20230609053812.10230-1-wangyoua@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we did some benchmark tests (such as pipe tests), we found
that the wake behavior was still triggered when the wait queue
was empty, even though it would exit later.

This processing consumes some unnecessary resources. Can we
determine at the beginning of the wake up whether there are
elements in the queue that need to be awakened? I think this
judgment is probably good for performance and should be safe.

Looking forward to your reply, thank you.

Signed-off-by: Wang You <wangyoua@uniontech.com>
---
 kernel/sched/wait.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 133b74730738..17011780aa21 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -205,6 +205,9 @@ void __wake_up_sync_key(struct wait_queue_head *wq_head, unsigned int mode,
 	if (unlikely(!wq_head))
 		return;
 
+	if (unlikely(!wq_has_sleeper(wq_head)))
+		return;
+
 	__wake_up_common_lock(wq_head, mode, 1, WF_SYNC, key);
 }
 EXPORT_SYMBOL_GPL(__wake_up_sync_key);
-- 
2.20.1

