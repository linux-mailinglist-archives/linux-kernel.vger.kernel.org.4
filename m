Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412546E6DB5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 22:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjDRUwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 16:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbjDRUwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 16:52:12 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF6B1700
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 13:52:11 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-24796e21f99so1162679a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 13:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681851130; x=1684443130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZLsMy53i2Ldb54DndITCO0BVOXRELg6hjYgzqJlVcQ=;
        b=Wx1WdSw74wlB+Nq/+vGjkFxdpQeAs0M2oa5xwykzBATElQVet5w+CgRDTK5maIGI5T
         z2LPfX0scW+3+kFKRts9kiWJJIiYTyli+ggYLkoWHdLcWeMKzVSLYVDHkSqUHbnmpPBi
         OWD+KoEUxKkNUcbuupC6+1G82Wpxkb/Ii3BHXOLE9R6Jauu69VqF8qFl2bpw86XK1z/f
         3E6bbhGorL1YhSecYvTtr4bC9JqJz47SQA2nRx8n78z2sOuijxkk71fom2jAPynNfXE4
         HeHq6pNHdH0M2QAg276LkQTrByJ9aEbJLLuCVjvGH5UoddiYQ0QcwwVJtyu3eshyfjU3
         x1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681851130; x=1684443130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WZLsMy53i2Ldb54DndITCO0BVOXRELg6hjYgzqJlVcQ=;
        b=hASQAWcrmsXRGixueWVJko3WMzDs4OfmC7efTbpjSRJEtToC7y5Y6/UfFedbLKwi6q
         SnUZ4m2znTAKzwklGYqDc6EUQahq59HW90efZRCBPPKHFMHQAWspKmJpninxkJbuHqdV
         bkG+M2NXVj/2h6Xzupf0TCqXWWTBqfLuLB7yWA0tq2nmoXX0hXa0igpS7OxinPsTzN3V
         M90ikQogVFMIVj7MN4xTYo59+gXLUpPb9PZZaPL9Mj0HE0M1rUAV92s849rUYgGPSMqZ
         iwVmA6ADaxc/VNJBWrrP18YayJ1y0QFVRtavLsGU4VMwdMMjlrUaxRROQQ7B/uq1gEPL
         0Y8w==
X-Gm-Message-State: AAQBX9cNrOrZWKUI0b0pUyTlvFs2U/mk+Sp2lk5p385S0mN86HiUU21t
        CT/KCm7NDWyW2mqQxzYk/xc=
X-Google-Smtp-Source: AKy350be5UJ8w1TJbqVI0lYFRIIFt2jC6d3gkvDnKKl3c1Ovd5lj4ZLFDorYiYJkOsGoeG0q41J5tA==
X-Received: by 2002:a17:90b:3847:b0:247:2d9d:4722 with SMTP id nl7-20020a17090b384700b002472d9d4722mr961137pjb.0.1681851130454;
        Tue, 18 Apr 2023 13:52:10 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id gm5-20020a17090b100500b002479c36b10esm12266pjb.23.2023.04.18.13.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 13:52:10 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/5] workqueue: Re-order struct worker fields
Date:   Tue, 18 Apr 2023 10:51:56 -1000
Message-Id: <20230418205159.724789-3-tj@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230418205159.724789-1-tj@kernel.org>
References: <20230418205159.724789-1-tj@kernel.org>
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
index b3b4b2b41d93..902459b328de 100644
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
2.40.0

