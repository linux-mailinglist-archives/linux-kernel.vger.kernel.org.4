Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930196D9B37
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239522AbjDFOwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238100AbjDFOwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:52:12 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B168B778
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 07:51:14 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id j13so37462422pjd.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 07:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680792672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IukBswUItQA0MwJ6mr8lJHmbvkt98zOHJDlzuZ9xc8=;
        b=iRJlt1CJvMm9eA18RMsi4Pd2vmqTpZST7WKy5PYRQriAE6O/3yD7tZ46f159yNbdWd
         sWkHmJyRT1QPOpKg1FKIakni2SeNhFvE47g04BKr12DCIKMh5ntJ8Bhq++/2LSXORGQk
         81N2B5tvbHSyGgxcdDOX6g+f+n/1cRHK2LWyUferpNf/DBOa02WAou5MUpMmVmafqLT5
         X0hpmy3pNW832fIRF8gT3xx7WlcPuwgoseI7QevKWW1jDeRF0C3XA6YUMBdgE0HE/zEH
         CFK2P57NKeaxPyOJZPLj/9/XBA61NM442z53Dnz6jwJ/G0q1piRk0XHrxw84/n75W0mq
         CEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680792672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4IukBswUItQA0MwJ6mr8lJHmbvkt98zOHJDlzuZ9xc8=;
        b=TBa7aqQoqyX/Pnc7ZtkHVzp315nJNV5FrLZjiN4ueH0rUv1MHiNMhwXWZeeemAnotF
         jyFFyPabsgDulVhgWybLNLaZwoXrA48sPxeIFmI6U+b12eUv4y+2Rr7m/VaBP4qwEX2A
         vIXQ1kxItNDDY0T2y/a/A5u2FXV4DX/O+Kk1c48X/IzFTUO2pYyofjYeXe3QjcYdetD2
         m9+SHQjtaJu5ODRnL2NGrg38XOHhI8GWPb8idLlMFmRweGPBbVUsZciTUoMyB1WYqwZu
         IcFah0fXxKAVeEbZuHez6nC16d5KeMMjR5Lioo1MYiMtUSIEJPqcHC9usdOuh2WlSa6c
         LijQ==
X-Gm-Message-State: AAQBX9fctR8ucUdrn6PEug4+oQYGMjqeYBn4SdIFnTFQN1/o++5ih/wD
        6D73Xu8p22I5HB/bCG9cgA574A==
X-Google-Smtp-Source: AKy350bKD/N614XCLXav3ebLsFXgDjtshr3+E7sESXsbgXqxHi+VsF3jJtgjKaWQ49jOjPijP3JTtA==
X-Received: by 2002:a17:903:11d1:b0:19f:1c64:c9d8 with SMTP id q17-20020a17090311d100b0019f1c64c9d8mr12440320plh.14.1680792672041;
        Thu, 06 Apr 2023 07:51:12 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e63:f500:18d3:10f7:2e64:a1a7])
        by smtp.gmail.com with ESMTPSA id i4-20020a170902eb4400b0019ca68ef7c3sm1487398pli.74.2023.04.06.07.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 07:51:11 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     axboe@kernel.dk, tj@kernel.org
Cc:     paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 3/3] blk-cgroup: delete cpd_init_fn of blkcg_policy
Date:   Thu,  6 Apr 2023 22:50:50 +0800
Message-Id: <20230406145050.49914-4-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230406145050.49914-1-zhouchengming@bytedance.com>
References: <20230406145050.49914-1-zhouchengming@bytedance.com>
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
Acked-by: Tejun Heo <tj@kernel.org>
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
index f663178f3a19..5fa77f32a52b 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1289,8 +1289,6 @@ blkcg_css_alloc(struct cgroup_subsys_state *parent_css)
 		blkcg->cpd[i] = cpd;
 		cpd->blkcg = blkcg;
 		cpd->plid = i;
-		if (pol->cpd_init_fn)
-			pol->cpd_init_fn(cpd);
 	}
 
 	spin_lock_init(&blkcg->lock);
@@ -1645,8 +1643,6 @@ int blkcg_policy_register(struct blkcg_policy *pol)
 			blkcg->cpd[pol->plid] = cpd;
 			cpd->blkcg = blkcg;
 			cpd->plid = pol->plid;
-			if (pol->cpd_init_fn)
-				pol->cpd_init_fn(cpd);
 		}
 	}
 
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 073488b9c7a0..6794157ea1eb 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -174,7 +174,6 @@ struct blkcg_policy {
 
 	/* operations */
 	blkcg_pol_alloc_cpd_fn		*cpd_alloc_fn;
-	blkcg_pol_init_cpd_fn		*cpd_init_fn;
 	blkcg_pol_free_cpd_fn		*cpd_free_fn;
 
 	blkcg_pol_alloc_pd_fn		*pd_alloc_fn;
-- 
2.39.2

