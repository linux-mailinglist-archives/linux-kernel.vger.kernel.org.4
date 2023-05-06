Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A0F6F904D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 09:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjEFHnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 03:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjEFHnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 03:43:13 -0400
Received: from out0-206.mail.aliyun.com (out0-206.mail.aliyun.com [140.205.0.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0515248
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 00:43:10 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047194;MF=yanyan.yan@antgroup.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---.SZmu5XX_1683358983;
Received: from localhost(mailfrom:yanyan.yan@antgroup.com fp:SMTPD_---.SZmu5XX_1683358983)
          by smtp.aliyun-inc.com;
          Sat, 06 May 2023 15:43:04 +0800
From:   "=?UTF-8?B?5pmP6ImzKOmHh+iLkyk=?=" <yanyan.yan@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "=?UTF-8?B?6LCI6Ym06ZSL?=" <henry.tjf@antgroup.com>,
        "Tiwei Bie" <tiwei.btw@antgroup.com>, <peterz@infradead.org>,
        "=?UTF-8?B?5pmP6ImzKOmHh+iLkyk=?=" <yanyan.yan@antgroup.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Juri Lelli" <juri.lelli@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Ben Segall" <bsegall@google.com>, "Mel Gorman" <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        "Valentin Schneider" <vschneid@redhat.com>
Subject: [PATCH v2] sched/debug: correct printing for rq->nr_uninterruptible
Date:   Sat, 06 May 2023 15:42:53 +0800
Message-Id: <20230506074253.44526-1-yanyan.yan@antgroup.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e6fe3f422be1 ("sched: Make multiple runqueue task counters
32-bit") changed the type for rq->nr_uninterruptible from "unsigned
long" to "unsigned int", but left wrong cast print to
/sys/kernel/debug/sched/debug and to the console.

For example, nr_uninterruptible's value is fffffff7 with type
"unsigned int", (long)nr_uninterruptible shows 4294967287 while
(int)nr_uninterruptible prints -9. So using int cast fixes wrong
printing.

Signed-off-by: Yan Yan <yanyan.yan@antgroup.com>
---
 kernel/sched/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 667876da8382..ac6684cd4ae4 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -730,7 +730,7 @@ static void print_cpu(struct seq_file *m, int cpu)
 #define P(x)								\
 do {									\
 	if (sizeof(rq->x) == 4)						\
-		SEQ_printf(m, "  .%-30s: %ld\n", #x, (long)(rq->x));	\
+		SEQ_printf(m, "  .%-30s: %d\n", #x, (int)(rq->x));	\
 	else								\
 		SEQ_printf(m, "  .%-30s: %Ld\n", #x, (long long)(rq->x));\
 } while (0)
-- 
2.32.0.3.g01195cf9f

