Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E3E65E167
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbjAEAUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbjAEAUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:20:20 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20AF43A30;
        Wed,  4 Jan 2023 16:20:19 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id fz16-20020a17090b025000b002269d6c2d83so2409601pjb.0;
        Wed, 04 Jan 2023 16:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WPbvsPoBO1wdRnnR1ui7BApmCnbJf4jlfv1HBKIBy8=;
        b=EZe5uvVOFYXNEuUGDh4QJb0VayBNgzRP6IhXwU6tFrtelFuoSP5DYf0ecdARuLhzmk
         GFtDqtggbTIuOgAsX6ChDBkwD45DtJ6462EB3grRGBPqXxkAKJMxr7A0aorIyVZoTe3S
         9YxoGSFfVi8TFXaa/ACdn87SQR5CzZtHq30rOmccDaM8VjFL/By/6zPd48N26tQRXtEU
         3ZeCauGAqrtucEJujs0qIuWfHaOAsRQYH8IwqAhRwIgSGhZauhstNvnjhMkA/0cJBa4I
         PogP6zCoOZuksFGGWCbBtUcoLRcM1unBSgBgTubfxaRtFIm8dYQTd9C9mBEcd/Hdagvl
         3LXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3WPbvsPoBO1wdRnnR1ui7BApmCnbJf4jlfv1HBKIBy8=;
        b=Bm12wUCyr4y5IR/M+Uza9S6777EyeVVukhX4zGMFEbTKe7YxLdzfBzvkGzQjW+A6q9
         P87ZAXa6KTjomMJLYO6Q4aRgP8UbWoJw+Oo11PLaBVaFSKNKT9mT5cdgw/S2miUw7FT8
         +Dx0IA0vO0PJuNTIng6HOdyxzVPNVyxmgZoJAbFuTzeQ3uHoIP5lHIwfyJIBh8ZgC3K8
         GjtE4fZRJWHoJPTmWKRvtVyw69z9tkbCUV6Ro4H6/BWIm2l3VKmGDKjvnPsZXcAN5aUI
         zpXitXnseboivUfvyAplkUMkRNn86CuOGQEJX+jCg+IJbS0zhE5AP1xFgmaTre8O/cc1
         VHHg==
X-Gm-Message-State: AFqh2kony83KwLHBFlY1GHHzH6dvj31NPrcQS7EJArHzVaOTMDV5ritL
        Moqb/2WTiGMiMSkVEFdrlB7p1ji6mC0=
X-Google-Smtp-Source: AMrXdXsz/HM8FFPzfd1LLR3BOfBojNIgcNCDT1KhX96VQ/3tbilAJa0YxHz0C+IFbxmc/o3PuuDgIw==
X-Received: by 2002:a17:903:40cd:b0:180:f32c:7501 with SMTP id t13-20020a17090340cd00b00180f32c7501mr55907158pld.0.1672878019188;
        Wed, 04 Jan 2023 16:20:19 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id j5-20020a170903024500b0019101215f63sm24718881plh.93.2023.01.04.16.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 16:20:18 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, josef@toxicpanda.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/4] blk-iolatency: s/blkcg_rq_qos/iolat_rq_qos/
Date:   Wed,  4 Jan 2023 14:20:06 -1000
Message-Id: <20230105002007.157497-4-tj@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105002007.157497-1-tj@kernel.org>
References: <20230105002007.157497-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name was too generic given that there are multiple blkcg rq-qos
policies.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-iolatency.c | 2 +-
 block/blk-rq-qos.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 3b3667f397a9..3601345808d2 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -976,7 +976,7 @@ static void iolatency_pd_init(struct blkg_policy_data *pd)
 {
 	struct iolatency_grp *iolat = pd_to_lat(pd);
 	struct blkcg_gq *blkg = lat_to_blkg(iolat);
-	struct rq_qos *rqos = blkcg_rq_qos(blkg->q);
+	struct rq_qos *rqos = iolat_rq_qos(blkg->q);
 	struct blk_iolatency *blkiolat = BLKIOLATENCY(rqos);
 	u64 now = ktime_to_ns(ktime_get());
 	int cpu;
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 1ef1f7d4bc3c..27f004fae66b 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -74,7 +74,7 @@ static inline struct rq_qos *wbt_rq_qos(struct request_queue *q)
 	return rq_qos_id(q, RQ_QOS_WBT);
 }
 
-static inline struct rq_qos *blkcg_rq_qos(struct request_queue *q)
+static inline struct rq_qos *iolat_rq_qos(struct request_queue *q)
 {
 	return rq_qos_id(q, RQ_QOS_LATENCY);
 }
-- 
2.39.0

