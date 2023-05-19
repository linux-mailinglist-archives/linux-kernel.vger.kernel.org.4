Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E89F708CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjESARp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjESARl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:17:41 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACCDE0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:17:40 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ae3fe67980so27240635ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684455459; x=1687047459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgmojnMiZ1jSUNbjWXd5AKfczzQxJVqGZLAZfKAvf+k=;
        b=k7sPPSPDqJoNSbNjwl8Wbx/ds81S3tZeDxUEEuHSI5RN03Qz5E2hU3BT0haOFYC2dC
         NlsN4GbO36sveNFWoHSiFHqreq9vagZwuJp3er+6onAz1uhuyNrel4b18vu6YDv2hTU6
         wzwO1VueAH80fRzhhmFoi4flDzgLiLV2jA+eErSx5m9Z4mq7nmHKkmgMZ3RYUXeh7Rr3
         av/Ywx/D0t3YvVhn1TkWsRLvJIGB73njblcxkhPwgnyqtNcZi7ZjgN3SomBdagE2IqH8
         AIKyD+mc6BZs/rRm4DdBt+J/bgPqSe5q5TtEDaqoWX+GZP79smcgG8QNp55AYjlTAzAC
         c45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684455459; x=1687047459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EgmojnMiZ1jSUNbjWXd5AKfczzQxJVqGZLAZfKAvf+k=;
        b=TvxH5RNtksFCUDknxzl8mDMDm0J4Lo4Q+4MXpW/G3JKIWcwk4pBmkI/gwzXdovckML
         667XiWcaMqNNE+Qf9NoNM9CltoxqqaWqg5/MHS4FdO2j8EsO57ycAJj+7KWGNbrdgzSO
         cWY9XeRNTyibIKjOYwwyvef+CbkMvRGgS8XG+KkJi2g4olu3Lcflv/admVrm8FjCxqja
         RuHlE9I4imL6nef9ZPYXfKDgdn9zcQOW/tTfxX9Q/QXBPzeueVGp6nLHwHQ7852EtcjF
         fm6f/En5dTYaN4YD5dwtQIDZEj2hx7P4mRqSNzcuy2JQVTRvxjieQmD0t5RlRwa92J06
         mGBQ==
X-Gm-Message-State: AC+VfDwEaN/br4XVWh9eaWYeD8MTlC3CFFLlYbEzgfX4tTVq7EDneYHR
        H4phatKMzFN/bdJ1H6hKz3A=
X-Google-Smtp-Source: ACHHUZ7rChw/+cX+EBQsfk8zgjmNWyj//7nBWJpSV+TccGQYHicYmfRTPOR2ionR84xegYoVb1kgWQ==
X-Received: by 2002:a17:902:e5ce:b0:1ab:14f2:e7e6 with SMTP id u14-20020a170902e5ce00b001ab14f2e7e6mr921534plf.65.1684455459492;
        Thu, 18 May 2023 17:17:39 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id f3-20020a17090274c300b001a980a23804sm2077797plt.4.2023.05.18.17.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 17:17:38 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 02/24] workqueue: Cleanups around process_scheduled_works()
Date:   Thu, 18 May 2023 14:16:47 -1000
Message-Id: <20230519001709.2563-3-tj@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519001709.2563-1-tj@kernel.org>
References: <20230519001709.2563-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Drop the trivial optimization in worker_thread() where it bypasses calling
  process_scheduled_works() if the first work item isn't linked. This is a
  mostly pointless micro optimization and gets in the way of improving the
  work processing path.

* Consolidate pool->watchdog_ts updates in the two callers into
  process_scheduled_works().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 9a97db94e1dc..c1e56ba4a038 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2634,9 +2634,15 @@ __acquires(&pool->lock)
  */
 static void process_scheduled_works(struct worker *worker)
 {
-	while (!list_empty(&worker->scheduled)) {
-		struct work_struct *work = list_first_entry(&worker->scheduled,
-						struct work_struct, entry);
+	struct work_struct *work;
+	bool first = true;
+
+	while ((work = list_first_entry_or_null(&worker->scheduled,
+						struct work_struct, entry))) {
+		if (first) {
+			worker->pool->watchdog_ts = jiffies;
+			first = false;
+		}
 		process_one_work(worker, work);
 	}
 }
@@ -2717,17 +2723,8 @@ static int worker_thread(void *__worker)
 			list_first_entry(&pool->worklist,
 					 struct work_struct, entry);
 
-		pool->watchdog_ts = jiffies;
-
-		if (likely(!(*work_data_bits(work) & WORK_STRUCT_LINKED))) {
-			/* optimization path, not strictly necessary */
-			process_one_work(worker, work);
-			if (unlikely(!list_empty(&worker->scheduled)))
-				process_scheduled_works(worker);
-		} else {
-			move_linked_works(work, &worker->scheduled, NULL);
-			process_scheduled_works(worker);
-		}
+		move_linked_works(work, &worker->scheduled, NULL);
+		process_scheduled_works(worker);
 	} while (keep_working(pool));
 
 	worker_set_flags(worker, WORKER_PREP);
@@ -2802,7 +2799,6 @@ static int rescuer_thread(void *__rescuer)
 					struct pool_workqueue, mayday_node);
 		struct worker_pool *pool = pwq->pool;
 		struct work_struct *work, *n;
-		bool first = true;
 
 		__set_current_state(TASK_RUNNING);
 		list_del_init(&pwq->mayday_node);
@@ -2820,12 +2816,9 @@ static int rescuer_thread(void *__rescuer)
 		WARN_ON_ONCE(!list_empty(scheduled));
 		list_for_each_entry_safe(work, n, &pool->worklist, entry) {
 			if (get_work_pwq(work) == pwq) {
-				if (first)
-					pool->watchdog_ts = jiffies;
 				move_linked_works(work, scheduled, &n);
 				pwq->stats[PWQ_STAT_RESCUED]++;
 			}
-			first = false;
 		}
 
 		if (!list_empty(scheduled)) {
-- 
2.40.1

