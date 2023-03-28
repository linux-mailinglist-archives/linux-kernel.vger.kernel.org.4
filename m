Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB18B6CC3F1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbjC1O6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbjC1O6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:58:24 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC4B6A54
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:57:57 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so15375404pjp.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680015477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JKgdRUirgIZoU7+JyVOh+FcbHYUvKjPRVe7MS66oIFw=;
        b=U64rvy0fPv5B3bl2GVSa2WjftX+lfIuzgkjwaxrNFtIrB+XsboRO7PFXTQbk1mwVsV
         FN6Pzz6qfjLHk9sbxl5SSLhjBVRJeg409SHrQXfxHdvwEiPn/EEBtMtQSkTVhJrXX42v
         zjU4KHit5sr8z2482ceOgCcDuI79Gupf681GcQ14KPG4ueLDcRAusKZ97ntmP8YS2uA4
         JvUfvKJk3+5iZsFxJVlL2WY/wtvmN4Q4LYfc3qAyAGDTViRjQgOtVSLAwaHGgty/KUQO
         Zi+ohbIa49gVpGmlp7KYceNekMRIH31UNYsivdlNODxViXDeplMjIoqMXtx8YEK+2WYA
         WIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680015477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JKgdRUirgIZoU7+JyVOh+FcbHYUvKjPRVe7MS66oIFw=;
        b=k1L7G8p2mYnq59VivdJQ6n4+StXVu6n4FEmE7yxMTg1FvbCQTJtowtKXCi83p901z2
         ZgXGLJhhf+GyhvVoQ/TngFtpug+WKuY3IGwiCA+4hc43MMDdb696ogfJFzTkp5UnnQbP
         SvXxKDOIShHYqTYzH2Z7Nj9YUN0VpoBFFxKLkO1EfAkEZM6AxCr1/rk8FolUYvE1zioG
         Eg6RLKRaU81qEkFx0Qdemk1r1uIQXY8CPcLXNa+h1GpvTb/LCO+rtlnwsmd/boyabl1F
         vZajfOh437SJFvT4rF0ZDm1oQWRFOqYY9vf/gY48hbd83YL86FZzL572DiuDIfrc6oMh
         ilUg==
X-Gm-Message-State: AAQBX9cdGLk+Ntd0yAYb9Am1RanijgzCHt2Mud0J6CIGmPkl/QdZz98r
        pFfbU0nbIOEtj4YbN9GEoF4iu/untD5Jkw0zBrLHFw==
X-Google-Smtp-Source: AKy350Z0gk1JmhHV2YqkSNfo28WpGsA4+RBZHbcWp07wiKZE7+TZEdXt7UeGnkNFOSnlhbvip4WaPw==
X-Received: by 2002:a17:90b:1e4f:b0:23f:4dfd:4fc1 with SMTP id pi15-20020a17090b1e4f00b0023f4dfd4fc1mr18014809pjb.43.1680015476833;
        Tue, 28 Mar 2023 07:57:56 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e6d:5da0:f469:aa9c:494f:b32f])
        by smtp.gmail.com with ESMTPSA id nk13-20020a17090b194d00b0023b3179f0fcsm6382250pjb.6.2023.03.28.07.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 07:57:56 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org,
        josef@toxicpanda.com
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH 1/4] block, bfq: remove BFQ_WEIGHT_LEGACY_DFL
Date:   Tue, 28 Mar 2023 22:56:58 +0800
Message-Id: <20230328145701.33699-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
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

BFQ_WEIGHT_LEGACY_DFL is the same as CGROUP_WEIGHT_DFL, which means
we don't need cpd_bind_fn() callback to update default weight when
attached to a hierarchy.

This patch remove BFQ_WEIGHT_LEGACY_DFL and cpd_bind_fn().

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/bfq-cgroup.c  | 4 +---
 block/bfq-iosched.h | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 89ffb3aa992c..a2ab5dd58068 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -504,8 +504,7 @@ static void bfq_cpd_init(struct blkcg_policy_data *cpd)
 {
 	struct bfq_group_data *d = cpd_to_bfqgd(cpd);
 
-	d->weight = cgroup_subsys_on_dfl(io_cgrp_subsys) ?
-		CGROUP_WEIGHT_DFL : BFQ_WEIGHT_LEGACY_DFL;
+	d->weight = CGROUP_WEIGHT_DFL;
 }
 
 static void bfq_cpd_free(struct blkcg_policy_data *cpd)
@@ -1302,7 +1301,6 @@ struct blkcg_policy blkcg_policy_bfq = {
 
 	.cpd_alloc_fn		= bfq_cpd_alloc,
 	.cpd_init_fn		= bfq_cpd_init,
-	.cpd_bind_fn	        = bfq_cpd_init,
 	.cpd_free_fn		= bfq_cpd_free,
 
 	.pd_alloc_fn		= bfq_pd_alloc,
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 69aaee52285a..467e8cfc41a2 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -20,7 +20,6 @@
 
 #define BFQ_DEFAULT_QUEUE_IOPRIO	4
 
-#define BFQ_WEIGHT_LEGACY_DFL	100
 #define BFQ_DEFAULT_GRP_IOPRIO	0
 #define BFQ_DEFAULT_GRP_CLASS	IOPRIO_CLASS_BE
 
-- 
2.39.2

