Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC186E0304
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 02:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjDMAHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 20:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjDMAHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 20:07:04 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E546B76BB;
        Wed, 12 Apr 2023 17:07:01 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso4994198pjc.1;
        Wed, 12 Apr 2023 17:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681344421; x=1683936421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4IbWZnTXBOzIxRU6MUG4lSyI23IeZVC+QVDJ/RpU5E=;
        b=P0pDbjFzPRdinRnTj4Ok5PfWTprkWOlQNhTcHfH4iCyJTQETRXAdDh9h7uI8XvcIdN
         /QuJd9YxROGZU2xH+d1hueAaUAuoHHtWvWSIif9i0fYxHMo6pF+LZTl4kGd69KCzuiD1
         k1zfNZ3qJidbW+m/ZniOa1xmrvND9MOsEI5UrTq6ulqBYzK1EWosHwuy/MtP8w++u1Po
         Hlv0/AiL2/8kqN4A2PnIhg8fDdlheWLG6NdE/NoO/+4FKA0GMbv8fx0V4KUBZ0IXTlIz
         YNdbBP9pPsVzloBfKHNdJtBQimbBXz0IIrnTCHwqn7se+I1bU6hYH5L8IoW0pwBDn0Qr
         R5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681344421; x=1683936421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M4IbWZnTXBOzIxRU6MUG4lSyI23IeZVC+QVDJ/RpU5E=;
        b=HwU6e+pzUHrlocXgOFxz8Kqpj/bPL6EtQq9uYjbu0X5sXHBy4aaBrenki06I4Y/T6b
         h1kU6iTW1EjvZv0WxIARGdnbelZWaGyQjg8gIG9lgn/GyXRneGNwjzJuVuklGWDpujaK
         wQzcMJCaPRGEQV+VkystokkD2WtRYtnBMNo2ATTntavCkvrioBZQCtpYftHXbWcxsGhw
         BG8D6W4g8fgAi6iMAMNpMrmQD4l9/C+sdUnDwMzp7YHp75cfYRHXTU8+MXWr35mRuJEl
         XvqznPKwsFYFCElspyBGrVhVOI4gWJjjpDwvfUO4NbJW7NTMwSuz+gGPJ+u41JbdyX0g
         zrJw==
X-Gm-Message-State: AAQBX9fr4epoEEq9wKz0qdXRUoqJmI1sdbWdgP+fi7CDQ4jJPT1B+OWh
        UJqeZM7D0+rnT7HX31oxi24=
X-Google-Smtp-Source: AKy350bA/wlhMB8kKD1xq6pWlj3VZ8nNDPo12O7Qsjx0TisZprIXr5POdtVTyjuAtCMyizXNrqt+fw==
X-Received: by 2002:a17:902:e54f:b0:19c:a9b8:4349 with SMTP id n15-20020a170902e54f00b0019ca9b84349mr152990plf.32.1681344421005;
        Wed, 12 Apr 2023 17:07:01 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id bi12-20020a170902bf0c00b001a63c61f06esm140111plb.195.2023.04.12.17.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 17:07:00 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, josef@toxicpanda.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/4] blk-iolatency: s/blkcg_rq_qos/iolat_rq_qos/
Date:   Wed, 12 Apr 2023 14:06:48 -1000
Message-Id: <20230413000649.115785-4-tj@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230413000649.115785-1-tj@kernel.org>
References: <20230413000649.115785-1-tj@kernel.org>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-iolatency.c | 2 +-
 block/blk-rq-qos.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 6707164c37f1..2560708b9109 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -969,7 +969,7 @@ static void iolatency_pd_init(struct blkg_policy_data *pd)
 {
 	struct iolatency_grp *iolat = pd_to_lat(pd);
 	struct blkcg_gq *blkg = lat_to_blkg(iolat);
-	struct rq_qos *rqos = blkcg_rq_qos(blkg->q);
+	struct rq_qos *rqos = iolat_rq_qos(blkg->q);
 	struct blk_iolatency *blkiolat = BLKIOLATENCY(rqos);
 	u64 now = ktime_to_ns(ktime_get());
 	int cpu;
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index b02a1a3d33a8..f48ee150d667 100644
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
2.40.0

