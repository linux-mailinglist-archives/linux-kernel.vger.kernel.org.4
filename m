Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6864074DEBB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 22:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjGJUEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 16:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjGJUEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:04:06 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF8F133
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:04:05 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-40355e76338so43937231cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689019444; x=1691611444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SBGw2jXOpZgmbGBedJ7/r5mS0Q0qMFpeepfUvmrysc=;
        b=IthWIhQjs6zlc88WmpO6Tw+iLkfYLE4qsiPGQbHzR18BIMxjVADrsoqnXTU2Wg0YOx
         VrH7k7uxvBd9QBOKJQM9JBtYM8AEraUrTufGixUtt9Xv7M1v7bYgvHcWKxIUNtETpKoO
         MKzQ+eaq/7V5ehlnF66s6e6ZLa+NPJAJUP79oRgcwF5tNKfBzS9UpEM5BqruHRMNSkJ8
         TRfNwVXBpkR21ZeEgKqAcwehQfdXcErrgNwYwAr+/1w+laS/cqRcznzytuDDOH87Bpz9
         jXPKPvL0aVTPq7IlB77JO8M6HxetvpVRmaDf8V7rdOfxZH3E9QYiz91xP932pqCTZh9G
         3Nmg==
X-Gm-Message-State: ABy/qLaWEmridOc+HdPJy6oMmp3nAeDFscgjwD0P/djKM1Q45JGUWMBZ
        ztmC8s8YJp1IUG4lUX1zrJ1NxcWNMjVafumg
X-Google-Smtp-Source: APBJJlFXKIc271vLQDN756+0T2CUOvBZoIOFPeV9CYqSYjs2XHITZ7kofgy1dG/IlTtDLmFHRJFOFw==
X-Received: by 2002:ac8:5f13:0:b0:403:b395:b450 with SMTP id x19-20020ac85f13000000b00403b395b450mr2250143qta.2.1689019444299;
        Mon, 10 Jul 2023 13:04:04 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:4850])
        by smtp.gmail.com with ESMTPSA id d15-20020ac8668f000000b003f394decd08sm250151qtp.62.2023.07.10.13.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 13:04:03 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, gautham.shenoy@amd.com,
        kprateek.nayak@amd.com, aaron.lu@intel.com, clm@meta.com,
        tj@kernel.org, roman.gushchin@linux.dev, kernel-team@meta.com
Subject: [PATCH v2 3/7] sched: Check cpu_active() earlier in newidle_balance()
Date:   Mon, 10 Jul 2023 15:03:38 -0500
Message-Id: <20230710200342.358255-4-void@manifault.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710200342.358255-1-void@manifault.com>
References: <20230710200342.358255-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In newidle_balance(), we check if the current CPU is inactive, and then
decline to pull any remote tasks to the core if so. Before this check,
however, we're currently updating rq->idle_stamp. If a core is offline,
setting its idle stamp is not useful. The core won't be chosen by any
task in select_task_rq_fair(), and setting the rq->idle_stamp is
misleading anyways given that the core being inactive should imply that
it should have a very cold cache.

Let's set rq->idle_stamp in newidle_balance() only if the cpu is active.

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/sched/fair.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a80a73909dc2..6e882b7bf5b4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11837,18 +11837,18 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	if (this_rq->ttwu_pending)
 		return 0;
 
-	/*
-	 * We must set idle_stamp _before_ calling idle_balance(), such that we
-	 * measure the duration of idle_balance() as idle time.
-	 */
-	this_rq->idle_stamp = rq_clock(this_rq);
-
 	/*
 	 * Do not pull tasks towards !active CPUs...
 	 */
 	if (!cpu_active(this_cpu))
 		return 0;
 
+	/*
+	 * We must set idle_stamp _before_ calling idle_balance(), such that we
+	 * measure the duration of idle_balance() as idle time.
+	 */
+	this_rq->idle_stamp = rq_clock(this_rq);
+
 	/*
 	 * This is OK, because current is on_cpu, which avoids it being picked
 	 * for load-balance and preemption/IRQs are still disabled avoiding
-- 
2.40.1

