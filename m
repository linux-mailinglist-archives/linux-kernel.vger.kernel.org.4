Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5550D664EC8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 23:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbjAJW1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 17:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbjAJW12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 17:27:28 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62BDD6F;
        Tue, 10 Jan 2023 14:27:27 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id q9so9257885pgq.5;
        Tue, 10 Jan 2023 14:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOFSBnqjB48KOjeQGTibsUyBy/akQHHtICGHjNlGAJ4=;
        b=QWEmoPu95KfP04FOQJpWNyYxw4a3On/ooyWssXcXrtElHZtPDgVH5xUzQYj/paYOJh
         D9DuJWRctRbd3n+amzwFupuI55FyfnwA/wvbe3QTJlRnXP5XYKMQ/r06tsX3z0aZGpZx
         W+gXr9aKfbqoyUyO9ewMtPwtrHVLLmLDaL1UAfqyCV4CNNjbttOfoMniCG1SdUbRShRD
         K2+aO2Ibc89xeolvO/vOYzSBZ5oYJSedwVL9a0wAQQvXiKKkcKybamBz8gwHsD+G73w0
         9vp0Vn6xrR5acktiHz8vPytJ8uuxN+KA1Awks8Jn4GQit2rI95gRyRFLG0f/xyfmT1ab
         4wwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rOFSBnqjB48KOjeQGTibsUyBy/akQHHtICGHjNlGAJ4=;
        b=Gp9pMwUL+iFJ+D0V6e4gxpgT5lrhFcCMR0uyWyY1vBFVS5wooxECt5q3q0cuUsFtmy
         wdXM2PncgfBPU7IKqgFz8HsaPhbEKfFpG1YsEUrDDe71TzOzRtjynPlrH12LdTleL8Cw
         01Rrui8rMr/uXSUo6BtQuMdxyzEFu1rpdQVJax3sKmnCvjOFrWIHGLb28w6H5X+NHzde
         L/ToKK65+y4wphgYB/ji3pI3Vr0MWqSBZrZeqx3aFEl1Tz/XBWt08HOg2BIubm0PSi/R
         xDbKLQ0QkLZ7NzQPtkgsFOOVawRICfp5tYNaaR+J3HaUx/u27zjPS2VE7/LAy+/KmiHG
         aS0g==
X-Gm-Message-State: AFqh2krVDhWNoFGvIW5/6pDoYZ8zp9JNIxO6G1+v/KAScu3nH+KmmL8N
        Thb2BCD0uMUJDn393tFymwA=
X-Google-Smtp-Source: AMrXdXuyEiN+AJY9aDgFPQ6sldoACsCoTbylMx6Pz4ybZzlrVc9ad1ooaaHnYZj6teZBMww/p0n0Tg==
X-Received: by 2002:a62:4e8e:0:b0:583:3d70:3661 with SMTP id c136-20020a624e8e000000b005833d703661mr14840396pfb.9.1673389647062;
        Tue, 10 Jan 2023 14:27:27 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id e11-20020a056a0000cb00b00582e4fda343sm7015762pfj.200.2023.01.10.14.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 14:27:26 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, josef@toxicpanda.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/4] blk-iolatency: s/blkcg_rq_qos/iolat_rq_qos/
Date:   Tue, 10 Jan 2023 12:27:13 -1000
Message-Id: <20230110222714.552241-4-tj@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110222714.552241-1-tj@kernel.org>
References: <20230110222714.552241-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

