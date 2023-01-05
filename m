Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FDE65F5B3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 22:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbjAEVYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 16:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235738AbjAEVYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 16:24:46 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B91B631AD;
        Thu,  5 Jan 2023 13:24:45 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id z4-20020a17090a170400b00226d331390cso2283028pjd.5;
        Thu, 05 Jan 2023 13:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WPbvsPoBO1wdRnnR1ui7BApmCnbJf4jlfv1HBKIBy8=;
        b=h7Rkd2eoAqOSb3NPQcC429lnxpLGOUQWpdpDfVRumSo56ccDcW26pC/hLGdMgC/Iic
         QgeeKnII9Fkf8pa3RVL9oEpVLXr8eNHSU4BhUMszxqbHlRyDNUTknRTO8JN+aD0Z7Hh4
         ILf01WtrtaEjA9OjrHxoW1rKO1wJzGbv1L8QqO3wAlSfVALhhjT6oW45MkTD1qixXnuC
         pjc6+ch1UdJD8mjiS0+EJsG9dSeZyJlTmvMRzqFgVHC0xiF0aviW8kOnr9tC/zkdOszn
         C2AiozuHZoAYbEumaaFxY5clPdUZXF8TeGh+gPTJi8kDsfLVPAQIVnoFN7GyykDGZ6M1
         cYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3WPbvsPoBO1wdRnnR1ui7BApmCnbJf4jlfv1HBKIBy8=;
        b=DCEo0iGvo6tzKgjM7O1XXvjdLNyB1p25NHjSJUes58Nr8vLmK/aQZEHw26vm+oobtb
         ML89g+h1dD/iGMmo68p5su39IAHAbiR72mG7OEt4KbF/FVrBLwS9/y/n/67fPz6Ol2HJ
         794p3NRoY5Ctpxs2ltYC6tKoxutwb75xN54ZTOiwF1iBKdHNYOzQ4h8/I/XUtXW7y+Ol
         9FYMTU7J8Pkc0HJ8dpy8niVlnf1YPmkfbn3kxHy/8CGNnNsHhgV0Z8QnvmtbWLF2BPD8
         4eL2wfXOgLpeqDXTZfkByQujRWAtWbt5w+ANOsTL7yp8+o4H0z6N/fgWi/9laC0U19Rp
         NIgQ==
X-Gm-Message-State: AFqh2kqlnMNUKzXUTzyPx99DGuYUPlkVIi2cLf7OJRctbpKAlINhOD8G
        J5Xue6xMJGxg8dumf21GGmg=
X-Google-Smtp-Source: AMrXdXv8TvNCpT/+B43gLCoaPxf6EUgyZ6sV9YGzP9vxvPxJPkB0OQ1g0jouAN2nf8P4uTl8EBor4A==
X-Received: by 2002:a17:902:f24c:b0:189:7d30:7623 with SMTP id j12-20020a170902f24c00b001897d307623mr47885881plc.30.1672953884912;
        Thu, 05 Jan 2023 13:24:44 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id z4-20020a1709027e8400b0018685257c0dsm3689527pla.58.2023.01.05.13.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 13:24:44 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, josef@toxicpanda.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/4] blk-iolatency: s/blkcg_rq_qos/iolat_rq_qos/
Date:   Thu,  5 Jan 2023 11:24:31 -1000
Message-Id: <20230105212432.289569-4-tj@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105212432.289569-1-tj@kernel.org>
References: <20230105212432.289569-1-tj@kernel.org>
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

