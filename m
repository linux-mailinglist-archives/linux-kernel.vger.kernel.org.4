Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1594708CBA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjESAR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjESARp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:17:45 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F7A10C6
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:17:44 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64d247a023aso806598b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684455463; x=1687047463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dpnSLC9bQ8To4/SaHarG2WNUmWGl1/1r8Lc4Ap+s7k=;
        b=RWc82gZQcOi3ewtdnwMSvpCmToFXueBwQ6xBJ4oFtXS4FCJQTTQDQbd5KnlaQxiy9T
         G08WrCfizDTtILfIV3A7oADxIX9VzS1umuKnlgTNtKAok7o910DO/MLWpR+HWBZjnjG+
         kjXIr0t+ue6cNYgafS5lHgW1H4R65TrljtG6lEHphPShRDKB5RZWQJLfpubtm1VwZxYM
         AfL/lA0oc3BmkVXvNGekKPGXdvM+ZHUd+bqI4g1qDdxXjvOZXl7ZVN5G5KV9qxfsju87
         9MV56x3SzhZwRPKWFn4kAshdpDnQbdp7a1VQ05yLf/mXIWwboZhmvrkteIgCDwMlSBuD
         GaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684455463; x=1687047463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+dpnSLC9bQ8To4/SaHarG2WNUmWGl1/1r8Lc4Ap+s7k=;
        b=Fd43J/FTuD8uVAK8bTxpiyESrVMZlp4nqXVFhke93FtyiiRjsGPtKcp2ulEqIhnb2I
         8+GTNu+zxxJyGNYaoccQ0lQMa+5nVeN3QRrOcNaDhQOJZCSQLGyh6W/ZdwUpNuJ3omzP
         7i59qQySgcjkD6VfQ+wYU7CFVRxYCGiD332R2fiOds+mU4o5rN9byp1KO1itaT+huLqV
         hjVMmqcfqdbrH63pm70K6vTWDNKuxjTaVwn3boWyzNWwE21291ksNZkgDejbtGeAKY0+
         XQ4eb+oW2zLDTqB1RscaSTpW64nIlv52+bOrwEx3pQRdGGuE6z7t8CBuXJ6U49tGQSRU
         I/OA==
X-Gm-Message-State: AC+VfDzBCfDi0BvPOjvLWpwiwlzt6D0yfWfQl+jMYefnt/jHzXA1esPJ
        bl5Eo0tITfgv/Ic798noCe0=
X-Google-Smtp-Source: ACHHUZ73093wXZaDT+CZrHL52ClOwc6kmYoFeDreHY35BPA9pLZbnD6vF+9BqhP8r5Mh3xaFUMbjhg==
X-Received: by 2002:a05:6a00:228d:b0:64d:1c59:6767 with SMTP id f13-20020a056a00228d00b0064d1c596767mr776394pfe.24.1684455463409;
        Thu, 18 May 2023 17:17:43 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id f2-20020a655502000000b0051baf3f1b3esm1649710pgr.76.2023.05.18.17.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 17:17:42 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 04/24] workqueue: Rename wq->cpu_pwqs to wq->cpu_pwq
Date:   Thu, 18 May 2023 14:16:49 -1000
Message-Id: <20230519001709.2563-5-tj@kernel.org>
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

wq->cpu_pwqs is a percpu variable carraying one pointer to a pool_workqueue.
The field name being plural is unusual and confusing. Rename it to singular.

This patch doesn't cause any functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0d5eb436d31a..80b2bd01c718 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -320,7 +320,7 @@ struct workqueue_struct {
 
 	/* hot fields used during command issue, aligned to cacheline */
 	unsigned int		flags ____cacheline_aligned; /* WQ: WQ_* flags */
-	struct pool_workqueue __percpu *cpu_pwqs; /* I: per-cpu pwqs */
+	struct pool_workqueue __percpu *cpu_pwq; /* I: per-cpu pwqs */
 	struct pool_workqueue __rcu *numa_pwq_tbl[]; /* PWR: unbound pwqs indexed by node */
 };
 
@@ -1616,7 +1616,7 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	} else {
 		if (req_cpu == WORK_CPU_UNBOUND)
 			cpu = raw_smp_processor_id();
-		pwq = per_cpu_ptr(wq->cpu_pwqs, cpu);
+		pwq = per_cpu_ptr(wq->cpu_pwq, cpu);
 	}
 
 	pool = pwq->pool;
@@ -3807,7 +3807,7 @@ static void rcu_free_wq(struct rcu_head *rcu)
 	wq_free_lockdep(wq);
 
 	if (!(wq->flags & WQ_UNBOUND))
-		free_percpu(wq->cpu_pwqs);
+		free_percpu(wq->cpu_pwq);
 	else
 		free_workqueue_attrs(wq->unbound_attrs);
 
@@ -4501,13 +4501,13 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
 	int cpu, ret;
 
 	if (!(wq->flags & WQ_UNBOUND)) {
-		wq->cpu_pwqs = alloc_percpu(struct pool_workqueue);
-		if (!wq->cpu_pwqs)
+		wq->cpu_pwq = alloc_percpu(struct pool_workqueue);
+		if (!wq->cpu_pwq)
 			return -ENOMEM;
 
 		for_each_possible_cpu(cpu) {
 			struct pool_workqueue *pwq =
-				per_cpu_ptr(wq->cpu_pwqs, cpu);
+				per_cpu_ptr(wq->cpu_pwq, cpu);
 			struct worker_pool *cpu_pools =
 				per_cpu(cpu_worker_pools, cpu);
 
@@ -4888,7 +4888,7 @@ bool workqueue_congested(int cpu, struct workqueue_struct *wq)
 		cpu = smp_processor_id();
 
 	if (!(wq->flags & WQ_UNBOUND))
-		pwq = per_cpu_ptr(wq->cpu_pwqs, cpu);
+		pwq = per_cpu_ptr(wq->cpu_pwq, cpu);
 	else
 		pwq = unbound_pwq_by_node(wq, cpu_to_node(cpu));
 
-- 
2.40.1

