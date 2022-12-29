Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FBD65919C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 21:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbiL2UiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 15:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbiL2Uhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 15:37:48 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2502717046
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 12:37:47 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id vm8so40509873ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 12:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PR1sxuRU/36TJDiACytBY64OGuYBjmbBR8pWbCnAcBY=;
        b=GWZy175mB1j6fdLDvTSm6Lmk2BC9k4erUX21w+Mmc/mvwPbOo59uJFZedUv1rICbsC
         idCKGc1Ut6k8q5neOSJMutWJvmfhEwn60I3KKX2k91P5BKI7EvJBMky6q7omvXeasaEl
         81/xB88Dgar6X7jJUn5Tgks454bTK+OhHwuSby9q5nK2ND7GQNrHVTxiTcpJdXh0RmjM
         RZiZ/PluNlJZ8Drt/ja086JyTH5vf1YNMHeR3cv71lji4DtdWxiLI+PruycMzh/4LRAw
         qSc5GFio38KZkD/MSMS2gpwobZSa9snrEBLTDhwg7FDKxrEBwjkitCjoovtZe4ewgnQy
         wlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PR1sxuRU/36TJDiACytBY64OGuYBjmbBR8pWbCnAcBY=;
        b=ChzQHBZebZhlsjlzbkD2f2QTHhBCHlCGza5FLHYknrywRNYXct5Uf5CqsCkRZkf8y0
         XKRRxNUGk+7A73EWPXganqIBslfBc/QR8euzBsfsR3n2EO8uLHgIK8lnSvaWCR5ZXbAr
         eWR4p+708cWDpPVyu4t7mGuHCFm3nYqmDDVGyGjBB3cuLShLRopWKbRMujU5tMfEpaCe
         8+DwCHjp3t84kk9seAdbdq/36bn4rQ4rlTrpMO/vSyMUJP9LCtgk+Nkh9VWoQ6+bCXZq
         r9Z5hew8ZZpuwDvi+PtpCWMgJ8lfUrQ2bdV7f+raeXq4XIYqhF1NH5O71U4GH4CcQLzz
         LofQ==
X-Gm-Message-State: AFqh2kqY3zBCuKqWXarAzMy6KtXpzwFq+oW7BETHage2LIPm5gDu3rZ2
        L1N4mPFEYVcjZrmKWGbCbRXMWA==
X-Google-Smtp-Source: AMrXdXufFOOaHr2CU7hsFNKq4Pqijjdinl6gtA+zgaHltSxcHTAmWt73sRQKXepop457/r9988hy4w==
X-Received: by 2002:a17:907:a407:b0:84c:7974:8a73 with SMTP id sg7-20020a170907a40700b0084c79748a73mr8259023ejc.57.1672346265657;
        Thu, 29 Dec 2022 12:37:45 -0800 (PST)
Received: from localhost.localdomain (mob-109-118-160-216.net.vodafone.it. [109.118.160.216])
        by smtp.gmail.com with ESMTPSA id d16-20020a170906371000b0073d7b876621sm8872814ejc.205.2022.12.29.12.37.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Dec 2022 12:37:45 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, damien.lemoal@opensource.wdc.com,
        Davide Zini <davidezini2@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V13 5/8] block, bfq: split also async bfq_queues on a per-actuator basis
Date:   Thu, 29 Dec 2022 21:37:04 +0100
Message-Id: <20221229203707.68458-6-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221229203707.68458-1-paolo.valente@linaro.org>
References: <20221229203707.68458-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davide Zini <davidezini2@gmail.com>

Similarly to sync bfq_queues, also async bfq_queues need to be split
on a per-actuator basis.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Davide Zini <davidezini2@gmail.com>
---
 block/bfq-iosched.c | 41 +++++++++++++++++++++++------------------
 block/bfq-iosched.h |  8 ++++----
 2 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index b522438a61cd..9abd920467cf 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2620,14 +2620,16 @@ static void bfq_bfqq_end_wr(struct bfq_queue *bfqq)
 void bfq_end_wr_async_queues(struct bfq_data *bfqd,
 			     struct bfq_group *bfqg)
 {
-	int i, j;
-
-	for (i = 0; i < 2; i++)
-		for (j = 0; j < IOPRIO_NR_LEVELS; j++)
-			if (bfqg->async_bfqq[i][j])
-				bfq_bfqq_end_wr(bfqg->async_bfqq[i][j]);
-	if (bfqg->async_idle_bfqq)
-		bfq_bfqq_end_wr(bfqg->async_idle_bfqq);
+	int i, j, k;
+
+	for (k = 0; k < bfqd->num_actuators; k++) {
+		for (i = 0; i < 2; i++)
+			for (j = 0; j < IOPRIO_NR_LEVELS; j++)
+				if (bfqg->async_bfqq[i][j][k])
+					bfq_bfqq_end_wr(bfqg->async_bfqq[i][j][k]);
+		if (bfqg->async_idle_bfqq[k])
+			bfq_bfqq_end_wr(bfqg->async_idle_bfqq[k]);
+	}
 }
 
 static void bfq_end_wr(struct bfq_data *bfqd)
@@ -5575,18 +5577,18 @@ static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 static struct bfq_queue **bfq_async_queue_prio(struct bfq_data *bfqd,
 					       struct bfq_group *bfqg,
-					       int ioprio_class, int ioprio)
+					       int ioprio_class, int ioprio, int act_idx)
 {
 	switch (ioprio_class) {
 	case IOPRIO_CLASS_RT:
-		return &bfqg->async_bfqq[0][ioprio];
+		return &bfqg->async_bfqq[0][ioprio][act_idx];
 	case IOPRIO_CLASS_NONE:
 		ioprio = IOPRIO_BE_NORM;
 		fallthrough;
 	case IOPRIO_CLASS_BE:
-		return &bfqg->async_bfqq[1][ioprio];
+		return &bfqg->async_bfqq[1][ioprio][act_idx];
 	case IOPRIO_CLASS_IDLE:
-		return &bfqg->async_idle_bfqq;
+		return &bfqg->async_idle_bfqq[act_idx];
 	default:
 		return NULL;
 	}
@@ -5759,7 +5761,8 @@ static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
 	bfqg = bfq_bio_bfqg(bfqd, bio);
 	if (!is_sync) {
 		async_bfqq = bfq_async_queue_prio(bfqd, bfqg, ioprio_class,
-						  ioprio);
+						  ioprio,
+						  bfq_actuator_index(bfqd, bio));
 		bfqq = *async_bfqq;
 		if (bfqq)
 			goto out;
@@ -6982,13 +6985,15 @@ static void __bfq_put_async_bfqq(struct bfq_data *bfqd,
  */
 void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg)
 {
-	int i, j;
+	int i, j, k;
 
-	for (i = 0; i < 2; i++)
-		for (j = 0; j < IOPRIO_NR_LEVELS; j++)
-			__bfq_put_async_bfqq(bfqd, &bfqg->async_bfqq[i][j]);
+	for (k = 0; k < bfqd->num_actuators; k++) {
+		for (i = 0; i < 2; i++)
+			for (j = 0; j < IOPRIO_NR_LEVELS; j++)
+				__bfq_put_async_bfqq(bfqd, &bfqg->async_bfqq[i][j][k]);
 
-	__bfq_put_async_bfqq(bfqd, &bfqg->async_idle_bfqq);
+		__bfq_put_async_bfqq(bfqd, &bfqg->async_idle_bfqq[k]);
+	}
 }
 
 /*
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 5a6f888930ad..de2b2af643e5 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -980,8 +980,8 @@ struct bfq_group {
 
 	struct bfq_data *bfqd;
 
-	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS];
-	struct bfq_queue *async_idle_bfqq;
+	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS][BFQ_MAX_ACTUATORS];
+	struct bfq_queue *async_idle_bfqq[BFQ_MAX_ACTUATORS];
 
 	struct bfq_entity *my_entity;
 
@@ -998,8 +998,8 @@ struct bfq_group {
 	struct bfq_entity entity;
 	struct bfq_sched_data sched_data;
 
-	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS];
-	struct bfq_queue *async_idle_bfqq;
+	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS][BFQ_MAX_ACTUATORS];
+	struct bfq_queue *async_idle_bfqq[BFQ_MAX_ACTUATORS];
 
 	struct rb_root rq_pos_tree;
 };
-- 
2.20.1

