Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691C0707847
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 05:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjERDBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 23:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjERDBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 23:01:02 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F9A1725
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 20:00:56 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ae4c5e12edso12460425ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 20:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684378856; x=1686970856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BcWEUcI0Yjd/tOOOzuGK3jNI16EQymUNbl8FIIsBKDo=;
        b=mLoK4w5CVlwvsn2uGcn61+9bh+RLyGRKMgK9m3fgjetK4/4YKElaxAIt6/76/T18c8
         VmzeBqDjGW4HWvj3Y/TqkKbyLRdu3F4l5VnIkP6DNX2GA33R8IFdIdACrSl9pczRaOMt
         2ZfMa+x24WXfFephLiF1diHTo8w4nSktrtIguS9R164eejlDJm0+1y23x9EZwcfm3P1T
         Y2PkFu5kdYwm8XPO4YEThlTqMeOVieZV4Hn+Dz7HU4GnbZR5Q7j+G+Eh60UOK1RRHkAR
         4TVCDVrmeEB/NW2GRRwc/7IHDqUB8diltMB8I88BzyXbPlvSOr+Q8ldiWDJ0Ty61V1wI
         21Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684378856; x=1686970856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BcWEUcI0Yjd/tOOOzuGK3jNI16EQymUNbl8FIIsBKDo=;
        b=KQFpxKElWClulPFXuZ/n6zvhGIU0D4T0QbhWSPMACgo4mB5zQYheNxUBsuCb36iZFs
         zVrQtFszE9EiVGrxOlJfWauaULlb6UxxHo77CTJfExw9szBtyvEsa/gzOUAJ8GrCNv8H
         a/jwECdVyZzAr119OxnyuG9fE1Zv32gNWHNezXtCtQdU+wYvZKv3XzwvDRmlhrj8Szbx
         GVHj/Rkz3nLnCenUYHrXrf4qmQGxxUtjVey/848i/jgz94Yro9Qcc1/x62Qr5MLRzRjl
         PuJGRE80/Mg93NtfzqUtT/SQMrLkUbt/6+HQGRsmf8L5lPPlzcpb76qqNdC4aJ8R9BrI
         AA7Q==
X-Gm-Message-State: AC+VfDyV3S5QxfTNR5CmSeL7hwoiDrzi3URI7Esw6t89+WSiezRVd+Wd
        5LkWwUX4Q5h2qFYYWeEovuo=
X-Google-Smtp-Source: ACHHUZ7hN07CRSvHyPPHhf1/oO/t2fNm32jdMMbiKV626VQIUJPPCcPumyxmt/bJ607NMz2yyMFeJA==
X-Received: by 2002:a17:903:338e:b0:1ac:6d4c:c26a with SMTP id kb14-20020a170903338e00b001ac6d4cc26amr1026745plb.14.1684378856064;
        Wed, 17 May 2023 20:00:56 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:1c2f])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902daca00b001ac69bdc9d1sm113510plx.156.2023.05.17.20.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 20:00:55 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/7] workqueue: Improve locking rule description for worker fields
Date:   Wed, 17 May 2023 17:00:30 -1000
Message-Id: <20230518030033.4163274-5-tj@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230518030033.4163274-1-tj@kernel.org>
References: <20230518030033.4163274-1-tj@kernel.org>
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

* Some worker fields are modified only by the worker itself while holding
  pool->lock thus making them safe to read from self, IRQ context if the CPU
  is running the worker or while holding pool->lock. Add 'K' locking rule
  for them.

* worker->sleeping is currently marked "None" which isn't very descriptive.
  It's used only by the worker itself. Add 'S' locking rule for it.

A future patch will depend on the 'K' rule to access worker->current_* from
the scheduler ticks.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c          |  6 ++++++
 kernel/workqueue_internal.h | 15 ++++++++-------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index d70bb5be99ce..942421443603 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -126,6 +126,12 @@ enum {
  *    cpu or grabbing pool->lock is enough for read access.  If
  *    POOL_DISASSOCIATED is set, it's identical to L.
  *
+ * K: Only modified by worker while holding pool->lock. Can be safely read by
+ *    self, while holding pool->lock or from IRQ context if %current is the
+ *    kworker.
+ *
+ * S: Only modified by worker self.
+ *
  * A: wq_pool_attach_mutex protected.
  *
  * PL: wq_pool_mutex protected.
diff --git a/kernel/workqueue_internal.h b/kernel/workqueue_internal.h
index 0600f04ceeb2..c2455be7b4c2 100644
--- a/kernel/workqueue_internal.h
+++ b/kernel/workqueue_internal.h
@@ -28,14 +28,15 @@ struct worker {
 		struct hlist_node	hentry;	/* L: while busy */
 	};
 
-	struct work_struct	*current_work;	/* L: work being processed */
-	work_func_t		current_func;	/* L: current_work's fn */
-	struct pool_workqueue	*current_pwq;	/* L: current_work's pwq */
-	unsigned int		current_color;	/* L: current_work's color */
-	int			sleeping;	/* None */
+	struct work_struct	*current_work;	/* K: work being processed and its */
+	work_func_t		current_func;	/* K: function */
+	struct pool_workqueue	*current_pwq;	/* K: pwq */
+	unsigned int		current_color;	/* K: color */
+
+	int			sleeping;	/* S: is worker sleeping? */
 
 	/* used by the scheduler to determine a worker's last known identity */
-	work_func_t		last_func;	/* L: last work's fn */
+	work_func_t		last_func;	/* K: last work's fn */
 
 	struct list_head	scheduled;	/* L: scheduled works */
 
@@ -45,7 +46,7 @@ struct worker {
 	struct list_head	node;		/* A: anchored at pool->workers */
 						/* A: runs through worker->node */
 
-	unsigned long		last_active;	/* L: last active timestamp */
+	unsigned long		last_active;	/* K: last active timestamp */
 	unsigned int		flags;		/* X: flags */
 	int			id;		/* I: worker id */
 
-- 
2.40.1

