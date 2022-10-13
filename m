Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B864C5FDBF7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 16:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiJMOEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 10:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiJMOE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 10:04:29 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204D64C032;
        Thu, 13 Oct 2022 07:04:14 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1364357a691so2383861fac.7;
        Thu, 13 Oct 2022 07:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P3lzffeHmbexWVtKhrHG9c286PrH8ea4fn4/VFTKtUI=;
        b=pyTFtbpqkize8kW1Owf9hUAM5zNNJzYmp5MHcfKlmD519xwRmXSE4n8iqx4pQ9Th+f
         EcsrFVvUa4cZWU89Ca8lSQHMhQ7o+HX8RwhyKWpeyint//6sEXm3SUKO/6Hdp2VanFsd
         jTkd+EdzA02ULjiIdWxm/w/VfU8FsvHQ/LrjEXJJGHBAURWxBKE4brKJrqOAu6fAcO0a
         77THxw6s65Vxah9u6PS2SSm/RhAQMG+tUw+QrerMVy9linXduPhEqu4Mig147SMxMIy8
         Q6RrjJN7+bkstFgaRmV1oCSfE4ws23vpFUikNLbok6MHVe4PpKHEGzwWlZgFJeIIgHMi
         VcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P3lzffeHmbexWVtKhrHG9c286PrH8ea4fn4/VFTKtUI=;
        b=Ekft9pK3bnXqNEG1l7o07LCkv+tjyTs8zu5olIGSDrhp6cNOwl3BwJMMPUgeGRV3gJ
         LLj6aaJ4JxNI+9FTS7u5KNz++yFPhSt1Zk1wSrWUf+g0zfbki/3/vN4nkWgAypdHKpVF
         EdopC0VcedtGyce8Hrsu6wjwoe7CLdxrNAV81xCFEP8cBic7AM+wqNwBgS46pn05RXu8
         Puam2ZjGVD1MBPqx/RdtZcvS+mRqh0sxkiYHz4kfLFhoXrniCz9eJSCvF7dG/Flldtye
         uCcBvufrnr/L6eYW3mptJzZqPYd/ZC1sdz0kpgpqr0KzgA2WzYgRMrbmRcTKfYrEateP
         Ssvw==
X-Gm-Message-State: ACrzQf1f94kjgAboXzT37PBKkb3ZymxNRs2alhVGA0jh6TpfbhQpmFUD
        ch3CYUV5Y0bzeDhNlY5zb2kxThpKaTSSKVzMlaM=
X-Google-Smtp-Source: AMsMyM7WNtzh048Cixz7xAMEuZLEvsqFShLD207m5i7JKfrcDOHZ+w8jM7YOCo9WKrnANABbqtLaBQ==
X-Received: by 2002:a17:90b:1c0e:b0:20d:8cc5:23e5 with SMTP id oc14-20020a17090b1c0e00b0020d8cc523e5mr9849752pjb.111.1665669252648;
        Thu, 13 Oct 2022 06:54:12 -0700 (PDT)
Received: from Zbook.localdomain ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id s15-20020a170902ea0f00b0016d72804664sm12650457plg.205.2022.10.13.06.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 06:54:12 -0700 (PDT)
From:   Yuwei Guan <ssawgyw@gmail.com>
X-Google-Original-From: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, jack@suse.cz
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuwei.Guan@zeekrlife.com
Subject: [PATCH] bfq: do try insert merge before bfq_init_rq() call
Date:   Thu, 13 Oct 2022 21:53:21 +0800
Message-Id: <20221013135321.174-1-Yuwei.Guan@zeekrlife.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's useless to do bfq_init_rq(rq), if the rq can do merge first.

In the patch 5f550ede5edf8, it moved to bfq_init_rq() before
blk_mq_sched_try_insert_merge(), but it's pointless,
as the fifo_time of next is not set yet,
and !list_empty(&next->queuelist) is 0, so it does not
need to reposition rq's fifo_time.

And for the "hash lookup, try again" situation, as follow,
bfq_requests_merged() call can work normally.

blk_mq_sched_try_insert_merge
  elv_attempt_insert_merge
    elv_rqhash_find

Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
---
 block/bfq-iosched.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 7ea427817f7f..9845370a701c 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6147,7 +6147,7 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 		bfqg_stats_update_legacy_io(q, rq);
 #endif
 	spin_lock_irq(&bfqd->lock);
-	bfqq = bfq_init_rq(rq);
+
 	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
 		spin_unlock_irq(&bfqd->lock);
 		blk_mq_free_requests(&free);
@@ -6156,6 +6156,7 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	trace_block_rq_insert(rq);
 
+	bfqq = bfq_init_rq(rq);
 	if (!bfqq || at_head) {
 		if (at_head)
 			list_add(&rq->queuelist, &bfqd->dispatch);
-- 
2.34.1

