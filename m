Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F8A6CC3E4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbjC1O6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbjC1O6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:58:05 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621C13C0E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:58:03 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id d13so11113208pjh.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680015483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mm/+XJd0CmSVOsRZU0I051KkHVVy+39u+QNn8QsY058=;
        b=fqsNROW7MlA7x+v0YHDdg4JhU7jwlfO1TCakjmUK3J9KKV0mFXMNSTE9zJpQj1xSdd
         A82TwPEgdicnTzo9CRmvXR0r8qWY1M/uWXSX9dxQoILcXAJStZ+h3JSF4VUtwCr86Hyi
         BDSiAKBx8hSmU15k3IbAGLOkYIJnK7R+Sa0BlyNaCBmQcsE9RDjA+GGzDES9fnbjmA7g
         /ejsEIC9/29W9I5ko239PgsYUwJzvwvKN0PnCx+3LfB6DRRWUmxNE4SwkNgIKk/BMH3S
         5wsNnNwDJBZ5iV/UfhSToIVdR9g6Ii9Rq/wp4yCwlG/Hmx4peGubSueZTgBzzNdbrONG
         STtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680015483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mm/+XJd0CmSVOsRZU0I051KkHVVy+39u+QNn8QsY058=;
        b=DqHTHxhI8uMQXk4m5Y0s7OICSliAIX1KkeB0WUBLYpQJXrxa1DvdKvuvGbpC+9NRYF
         9aIt4lBmX3pqcyBrsHPNosBjW4BWu1+Jmi7fJRc/lJb0MV5nXxMGuKQXfGF501vzuxRo
         Khf1z9j9eun41EO1eYxxGK72QCD0Fv+WBSJfuiSqEhV2DJakJD6N2rmmK8Y/SwAxPAp+
         QeCqHMHE6dY2TQVenUOt10SpHlD3DWxFokMufMlzcU3/B5D5nlJgqQmgpVNo59BeQCZl
         4HdmFCjGFGzWjcGW2TxYimYERejhEjI4TPFb/KpBG7GcT/zdkZVD8KR3XIHJ472SF/iw
         N/Ew==
X-Gm-Message-State: AAQBX9cRGwSVo29CMiKP3LrNN4kuBdP/E9wxDPTxxdYx5n82x3R/y5e2
        8amgZ+kC6ZXvnqkjSAOyxmBmuw==
X-Google-Smtp-Source: AKy350ZuJPDxtXtKE6oMQqs5ky5bfJ06RHzbK7tcmAL+zIUW5FRRKJ1pOA1hOYo27HuitaPHRZdfdQ==
X-Received: by 2002:a17:90b:1d05:b0:23f:2d2c:abd0 with SMTP id on5-20020a17090b1d0500b0023f2d2cabd0mr14551757pjb.4.1680015482930;
        Tue, 28 Mar 2023 07:58:02 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e6d:5da0:f469:aa9c:494f:b32f])
        by smtp.gmail.com with ESMTPSA id nk13-20020a17090b194d00b0023b3179f0fcsm6382250pjb.6.2023.03.28.07.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 07:58:02 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org,
        josef@toxicpanda.com
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH 3/4] blk-cgroup: delete cpd_init_fn of blkcg_policy
Date:   Tue, 28 Mar 2023 22:57:00 +0800
Message-Id: <20230328145701.33699-3-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230328145701.33699-1-zhouchengming@bytedance.com>
References: <20230328145701.33699-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blkcg_policy cpd_init_fn() is used to just initialize some default
fields of policy data, which is enough to do in cpd_alloc_fn().

This patch delete the only user bfq_cpd_init(), and remove cpd_init_fn
from blkcg_policy.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/bfq-cgroup.c | 10 ++--------
 block/blk-cgroup.c |  4 ----
 block/blk-cgroup.h |  1 -
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index a2ab5dd58068..74f7d051665b 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -497,14 +497,9 @@ static struct blkcg_policy_data *bfq_cpd_alloc(gfp_t gfp)
 	bgd = kzalloc(sizeof(*bgd), gfp);
 	if (!bgd)
 		return NULL;
-	return &bgd->pd;
-}
 
-static void bfq_cpd_init(struct blkcg_policy_data *cpd)
-{
-	struct bfq_group_data *d = cpd_to_bfqgd(cpd);
-
-	d->weight = CGROUP_WEIGHT_DFL;
+	bgd->weight = CGROUP_WEIGHT_DFL;
+	return &bgd->pd;
 }
 
 static void bfq_cpd_free(struct blkcg_policy_data *cpd)
@@ -1300,7 +1295,6 @@ struct blkcg_policy blkcg_policy_bfq = {
 	.legacy_cftypes		= bfq_blkcg_legacy_files,
 
 	.cpd_alloc_fn		= bfq_cpd_alloc,
-	.cpd_init_fn		= bfq_cpd_init,
 	.cpd_free_fn		= bfq_cpd_free,
 
 	.pd_alloc_fn		= bfq_pd_alloc,
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 68b797b3f114..18331cb92914 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1249,8 +1249,6 @@ blkcg_css_alloc(struct cgroup_subsys_state *parent_css)
 		blkcg->cpd[i] = cpd;
 		cpd->blkcg = blkcg;
 		cpd->plid = i;
-		if (pol->cpd_init_fn)
-			pol->cpd_init_fn(cpd);
 	}
 
 	spin_lock_init(&blkcg->lock);
@@ -1605,8 +1603,6 @@ int blkcg_policy_register(struct blkcg_policy *pol)
 			blkcg->cpd[pol->plid] = cpd;
 			cpd->blkcg = blkcg;
 			cpd->plid = pol->plid;
-			if (pol->cpd_init_fn)
-				pol->cpd_init_fn(cpd);
 		}
 	}
 
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 26ce62663e27..2c6788658544 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -173,7 +173,6 @@ struct blkcg_policy {
 
 	/* operations */
 	blkcg_pol_alloc_cpd_fn		*cpd_alloc_fn;
-	blkcg_pol_init_cpd_fn		*cpd_init_fn;
 	blkcg_pol_free_cpd_fn		*cpd_free_fn;
 
 	blkcg_pol_alloc_pd_fn		*pd_alloc_fn;
-- 
2.39.2

