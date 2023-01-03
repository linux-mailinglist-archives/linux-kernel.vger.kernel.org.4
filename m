Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB2E65C26F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237936AbjACOzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjACOz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:55:28 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA7BFD0C
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:55:23 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id u19so74243726ejm.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 06:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0d4MosATHMJxt0bdurE2AL3gK0xP2e0HXm81ECVDQs=;
        b=nIZbEVpZFdPxZXFuW1jTgdH1T6VdOM/cbMLygn3bm/yx7vDj8tm97hV+ZWCWhJoYhp
         S2xlNJdiUN+tK2W2rpZ5gRBobG7o+tTZkrF8AbtGH61whnjmXLigjlJ4JVbbOixFpCTR
         7lt0i+dGNWFWCXwsPBgwgBouBwHZ/g13bCxPpq2kk8kTAfoYerWIiZii9MqOI3ELNcN6
         7jjwhM5Cx0IfjMG2rSavglggjlOQez8zQYtd3vPAl/hHvKDGiwtyTET7NlI14rk3RYyR
         T4VO/TloMajCikv84fxlbEx1+bK7YkxlWcfyqoqgwN2uvpD2+2LhWt4LlqDytBsXS387
         ANMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0d4MosATHMJxt0bdurE2AL3gK0xP2e0HXm81ECVDQs=;
        b=7eWN2/XUMsXz+hSWVyifGYOeCGgagtu9D+EcKWuLwVN8HCoBelEErGkirDxqyEZcUn
         7N93yB/UFbhLMWkqbhPRmDYkzC6K++xZKHFGTa9NOoeYLtVq8jWtjL0JTxokclf1+APQ
         1zoo7FAninPVKHI2wZbYRAvWKKzVdeBJHcdQYo/MQIdlOvEzGzArDR0UQBKZi5WKVeaN
         +YAr1RB2cSmHatCsWuRfQdQpYFcdTNwLusUTrz/anBMD/K6De11O7YBjOcznoJeXpAHu
         tv9d6Jqsdxh4m0+Wm6fi1MNMeQUXzwGRHLMNhkFGYwZBp5YICimth1aE2O6ZqkbUZ/S/
         QY7A==
X-Gm-Message-State: AFqh2kqCWrVOmGYxOaEbJX3WcsR0kTvrAtRDZd5gpgGvW+PN7YOTEqyE
        6bV450Th1qyXL/nBzolKrqnm5w==
X-Google-Smtp-Source: AMrXdXtKiz1+4PfEbvupQ8hd59N0IyFXZHSvBkbroZ+zohW8twn8CF9iTWP2YmKDQm0VSHveNsraqQ==
X-Received: by 2002:a17:906:308b:b0:7ae:cda1:76d0 with SMTP id 11-20020a170906308b00b007aecda176d0mr36632976ejv.15.1672757721870;
        Tue, 03 Jan 2023 06:55:21 -0800 (PST)
Received: from localhost.localdomain (mob-5-91-46-2.net.vodafone.it. [5.91.46.2])
        by smtp.gmail.com with ESMTPSA id g17-20020a17090604d100b007c16fdc93ddsm14122595eja.81.2023.01.03.06.55.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jan 2023 06:55:21 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, damien.lemoal@opensource.wdc.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V13 REBASED 2/8] block, bfq: forbid stable merging of queues associated with different actuators
Date:   Tue,  3 Jan 2023 15:54:57 +0100
Message-Id: <20230103145503.71712-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230103145503.71712-1-paolo.valente@linaro.org>
References: <20230103145503.71712-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If queues associated with different actuators are merged, then control
is lost on each actuator. Therefore some actuator may be
underutilized, and throughput may decrease. This problem cannot occur
with basic queue merging, because the latter is triggered by spatial
locality, and sectors for different actuators are not close to each
other. Yet it may happen with stable merging. To address this issue,
this commit prevents stable merging from occurring among queues
associated with different actuators.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 597f5a109092..b21ca9111b87 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5647,9 +5647,13 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
 	 * it has been set already, but too long ago, then move it
 	 * forward to bfqq. Finally, move also if bfqq belongs to a
 	 * different group than last_bfqq_created, or if bfqq has a
-	 * different ioprio or ioprio_class. If none of these
-	 * conditions holds true, then try an early stable merge or
-	 * schedule a delayed stable merge.
+	 * different ioprio, ioprio_class or actuator_idx. If none of
+	 * these conditions holds true, then try an early stable merge
+	 * or schedule a delayed stable merge. As for the condition on
+	 * actuator_idx, the reason is that, if queues associated with
+	 * different actuators are merged, then control is lost on
+	 * each actuator. Therefore some actuator may be
+	 * underutilized, and throughput may decrease.
 	 *
 	 * A delayed merge is scheduled (instead of performing an
 	 * early merge), in case bfqq might soon prove to be more
@@ -5667,7 +5671,8 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
 			bfqq->creation_time) ||
 		bfqq->entity.parent != last_bfqq_created->entity.parent ||
 		bfqq->ioprio != last_bfqq_created->ioprio ||
-		bfqq->ioprio_class != last_bfqq_created->ioprio_class)
+		bfqq->ioprio_class != last_bfqq_created->ioprio_class ||
+		bfqq->actuator_idx != last_bfqq_created->actuator_idx)
 		*source_bfqq = bfqq;
 	else if (time_after_eq(last_bfqq_created->creation_time +
 				 bfqd->bfq_burst_interval,
-- 
2.20.1

