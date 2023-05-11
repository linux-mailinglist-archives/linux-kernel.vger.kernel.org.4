Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612156FF96B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 20:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239219AbjEKSTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 14:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239195AbjEKSTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 14:19:43 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436E465A4
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 11:19:42 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1aad6f2be8eso83130555ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 11:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683829181; x=1686421181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDANAV6Ubr5KkEqy3DIRzGm4anT8hIgcnesbBUBsaAg=;
        b=WtIDqfn+V8MY0/g3+qsxH3AhZvgNbaX5FZiNHaef8+SdE8ZMxAVNTffmWdOgQ9bDM8
         BdepHSrLnfySVcOp7N2MU5mP/S/iFFzodZtgU4UTTB9g31/2D4mp4Gs/+ea4rbqUIKAI
         2+kWfcuXv9jFEAEtrYmK4xtA5qGeLUPfv3Qi7jib6l/4OTiYmWi6sDjUiVA7amKhxRIT
         /H0n8vSxg5J7f/K7CbVpWMVp27+zrWCrChAkK+b3IDWoOz06qOQrmrRCb2Qjq8YuaoYd
         lK+P4o+ymI5G+NFe+Qdw+yOZE44DqpnLkJc/sf58WWgjIwtzHkQMK/7T5Q2hJ2tetPn+
         P3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683829181; x=1686421181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QDANAV6Ubr5KkEqy3DIRzGm4anT8hIgcnesbBUBsaAg=;
        b=HA0WJFKqlcHduSq4em1dm3wFCTcVXnUo4zCpW8ir61sB13pZOghKk5m09dYpjEI55Z
         REyff7YhgFl2kiEubXnuNV+iMYiT0IHxoJJk8Cx5TTaXebU4g7Pj1UJdIDs+2f+/V1Ux
         eVbVmXvPc94/+y0Z1aJ99dzllx8AAYDAQ+WOcOwqPkWgdebNhrhaaWpd/GLtPB1d2k/a
         nL3lVRGtxRwlxmFi2SXnUtQAhK9mr93mTR3IU9qn3zEy9VnMgw88J1VVbvif0IeEZFAi
         jo32BrJGYV9dGDirq5s3kZ1fmI3CD057vJKbJ3FSKsjbjdpUWvev9QUVmvgSbpZQgvvA
         YbXQ==
X-Gm-Message-State: AC+VfDy7/y5fFeqk0kcHzTWMLv7aBBw2CfY1iVbvevYtG+bCoCnUDuGv
        oCeNcdwtjWt8U+XS9DPulpg=
X-Google-Smtp-Source: ACHHUZ60n3lQTTFqlfxbsLy7Jg5CyUz5DPu7Bt4y9h5RJiqXP7NkckxSatW/k2EiDR/D1zKeV/I0EA==
X-Received: by 2002:a17:902:ba84:b0:1ab:1c09:2df8 with SMTP id k4-20020a170902ba8400b001ab1c092df8mr22587871pls.50.1683829181121;
        Thu, 11 May 2023 11:19:41 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id s16-20020a170902989000b001acae093442sm4500255plp.82.2023.05.11.11.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 11:19:40 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/7] workqueue: Re-order struct worker fields
Date:   Thu, 11 May 2023 08:19:26 -1000
Message-Id: <20230511181931.869812-3-tj@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230511181931.869812-1-tj@kernel.org>
References: <20230511181931.869812-1-tj@kernel.org>
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

