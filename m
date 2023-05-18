Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4133370784A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 05:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjERDBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 23:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjERDBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 23:01:02 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF4DE79
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 20:00:52 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-51f1b6e8179so1009097a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 20:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684378852; x=1686970852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDANAV6Ubr5KkEqy3DIRzGm4anT8hIgcnesbBUBsaAg=;
        b=sLAJ2+kmCOJti90TvkNgjY86PPE0vpEXL9euJKkSmkS1p81QIaLkF6Pk8cNha9FYxs
         rRPdd2HaJfXmvDBYBs9Of7AOgXz2ifHMcrenWrZNon2pCCfYCeVToChobjepuZ3KPh/k
         kO6QNRLzViLp3KHzaY9jIngFQPH0UP/5jspLaixDAWRGlA6xFDQJ22WD+WfNGa1GWm4G
         B4bc3yKuEvuG91vLLALshkvUiKKN50lkfY7mGh1eIL1lqvWuWOk0O4PmTPx+Bvo2cq30
         jN0C4+7xzAk64f/XRsBwMAQI+sB8OoSwYPp0jCzx7B73UQUcwrFKIjhIJPGLIVAtnQZ2
         21kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684378852; x=1686970852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QDANAV6Ubr5KkEqy3DIRzGm4anT8hIgcnesbBUBsaAg=;
        b=BXbZaG1FHvlir9Cd9h1UrfUHC6WiNw4UfHAq4CnPbok6eCx8v/x1rkiLaA4ZfkW+if
         2+2pUeSmZ7fElhUPEMdJk5W9kjfCZrUpZ7J0w85rwz/tPqCiHio/BYq9rRaRpOD/9eNk
         HvCC7RFk0xUc1K+Y8NRQjkVulTbetEnJ4b1jmCPUSiASQIyNAoGpJtTgmO02oSSUu74n
         UYCnOwPUx/Dhjelv7fBI/LqBRovA4ITZMrbIFAjk0Zkj7bXDrWjMNlxXVHmI4HgsT9n4
         9rxBQ3VkjdBXR1RbWgw7/eoEteeKRFpB6wqyiBlnwfVNnQCUPUpCoO2SSvLeu4+hFbkj
         /qtg==
X-Gm-Message-State: AC+VfDxfILVhJz22CR3DvowQxDNLzAz+PqVNx2bKvWh/aUmgeXehHzvw
        abuS+AALnrw9nrqPlhhKppY=
X-Google-Smtp-Source: ACHHUZ7DOEJ6rNpIx2ljuIcYqNIy9aWS6yvzj5YoMGHVSIVUe7+swj7plkIZ9+JirpL9/EC8isooww==
X-Received: by 2002:a05:6a20:e68e:b0:f6:55c:5371 with SMTP id mz14-20020a056a20e68e00b000f6055c5371mr517058pzb.49.1684378851577;
        Wed, 17 May 2023 20:00:51 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:1c2f])
        by smtp.gmail.com with ESMTPSA id ds15-20020a17090b08cf00b0025069c8a151sm272370pjb.53.2023.05.17.20.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 20:00:51 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/7] workqueue: Re-order struct worker fields
Date:   Wed, 17 May 2023 17:00:28 -1000
Message-Id: <20230518030033.4163274-3-tj@kernel.org>
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
index e00b1204a8e9..0600f04ceeb2 100644
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

