Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8C16FD404
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 05:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbjEJDIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 23:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbjEJDIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 23:08:16 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783882703
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 20:08:15 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-643990c5319so4720464b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 20:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683688095; x=1686280095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lYtloagpj+NnCvnAA1uzWiLUzmA+3azU8CQP4Aigv4=;
        b=I6S/rwzPAARnt86r1DJ+bhXEjHAsztVkWuCuEOQakjVaWuOi6DodeD7KtnfzgLZdeq
         bAzP9P96rW2MpqUEfQK6NumDgSlp4W8Ze1U4yGDfFqXQbdLTfY2KvZ2NHOScHKRximrX
         31aqHLipjaDdSWgVp09zPign5NhtR9VTftoZ1iLBmL9NxBrWmCtWBr3aw0g/W++3L+PK
         7Nt9j3fvQiStKZLZIn6TBZ5pIT9+psDAMREtzfkMUi7FeQpm+qa2gL8+CwXDP76r9H0E
         2OaD3eSqiAP31rFzREAiGpPC/spS8lU/GcBKNz2bMcY8Ia26yILcTIFFW7pgadlDwJ7H
         k+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683688095; x=1686280095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/lYtloagpj+NnCvnAA1uzWiLUzmA+3azU8CQP4Aigv4=;
        b=Wb5/BrKK0Y0dtt3vGD3HzdDKmgDgPKrXF0Gw6AYgn1qPboouUmBRkBrhqRg0ToDq82
         34MQwNTiilFQEVJZa23KUW4KFeKswEBuWbdhDs7ggLhwdfcf6qyYH37Afc1IusLr0DyM
         jV+1VwMH3bvUdaG5Q/82FeIeoOMoCY0+kFdibMcDy+Y6FZM2Z5vGRNpA00CUqq4262fG
         7ZaEpURHOQyPLwSaPosZXDXY+Mu9XFjewLDBdyuKdM9Lm97lzQpYkPNNaDj3NZiN4wpD
         Qka+v+B/ClAl7pMkGLOdHj8L+vYFqfBaijnnju0s4afQoZiyl76yLpfPkseWe5BcqPFH
         HVuw==
X-Gm-Message-State: AC+VfDwfoU/hMLZbqdCuACdPxdKXqkl9r/Ez+tN/moI/mCMSX4SHzqtF
        8ZASQzW/TAtGXffBZo1u/W0=
X-Google-Smtp-Source: ACHHUZ7/AijKg2pg25cxmHhIN8zE7MQ9+Ox+k6Tjcx709VhyccuLxjeKNB3X9r9y7AVfTvPAKvcFvg==
X-Received: by 2002:a05:6a20:3cac:b0:f3:b764:5de3 with SMTP id b44-20020a056a203cac00b000f3b7645de3mr20667853pzj.48.1683688094651;
        Tue, 09 May 2023 20:08:14 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id x15-20020a056a00270f00b0063f1a27f2c9sm2493459pfv.70.2023.05.09.20.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 20:08:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/6] workqueue: Re-order struct worker fields
Date:   Tue,  9 May 2023 17:07:48 -1000
Message-Id: <20230510030752.542340-3-tj@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510030752.542340-1-tj@kernel.org>
References: <20230510030752.542340-1-tj@kernel.org>
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

struct worker was laid out with the intent that all fields that are modified
for each work item execution are in the first cacheline. However, this
hasn't been true for a while with the addition of ->last_func. Let's just
collect hot fields together at the top.

Move ->sleeping in the hole after ->current_color and move ->lst_func right
below. While at it, drop the cacheline comment which isn't useful anymore.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
---
 kernel/workqueue_internal.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/workqueue_internal.h b/kernel/workqueue_internal.h
index c34b876af16d..a20b4d052a45 100644
--- a/kernel/workqueue_internal.h
+++ b/kernel/workqueue_internal.h
@@ -32,9 +32,12 @@ struct worker {
 	work_func_t		current_func;	/* L: current_work's fn */
 	struct pool_workqueue	*current_pwq;	/* L: current_work's pwq */
 	unsigned int		current_color;	/* L: current_work's color */
-	struct list_head	scheduled;	/* L: scheduled works */
+	int			sleeping;	/* None */
+
+	/* used by the scheduler to determine a worker's last known identity */
+	work_func_t		last_func;	/* L: last work's fn */
 
-	/* 64 bytes boundary on 64bit, 32 on 32bit */
+	struct list_head	scheduled;	/* L: scheduled works */
 
 	struct task_struct	*task;		/* I: worker task */
 	struct worker_pool	*pool;		/* A: the associated pool */
@@ -45,7 +48,6 @@ struct worker {
 	unsigned long		last_active;	/* L: last active timestamp */
 	unsigned int		flags;		/* X: flags */
 	int			id;		/* I: worker id */
-	int			sleeping;	/* None */
 
 	/*
 	 * Opaque string set with work_set_desc().  Printed out with task
@@ -55,9 +57,6 @@ struct worker {
 
 	/* used only by rescuers to point to the target workqueue */
 	struct workqueue_struct	*rescue_wq;	/* I: the workqueue to rescue */
-
-	/* used by the scheduler to determine a worker's last known identity */
-	work_func_t		last_func;
 };
 
 /**
-- 
2.40.1

