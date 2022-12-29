Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810D9659197
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 21:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbiL2Uh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 15:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbiL2Uho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 15:37:44 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F08165B2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 12:37:42 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id tz12so47410601ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 12:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qu2Bp3avWp+ua5WBjxSJKabJBT3O2LRwTKJPgSSWaGY=;
        b=J61TpuOQz0dlHt7rlxRtCP3uv1Z8FPHT2neu1sGs3/sq/Sv6Puad8p18yVZRtiCySC
         P+5ra7/JjBLOUFnhfawToplWhlYfJ8QGciLeikBwvOMu7KTD8WMERoM8XmlAUwVDpivF
         shOYpP/LBhdwZjd00IGK5Yhe8oPvwVSyCyozWS3jY+Td5ICDl1SqzZO+Qz5b0yAcmP8c
         MxpfpKCBKGR9sFCvSKeGMs81mcxikzqsLgDLoo518XRWjB0GxCUr9k6sI+DDvi2s5V8V
         jI9XpaAY82xoGOckYYs1a7EVlz95wz9QV0obpUiVIl4/iTTv7WyMUwyLMzqYatof1M7v
         JXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qu2Bp3avWp+ua5WBjxSJKabJBT3O2LRwTKJPgSSWaGY=;
        b=DKsE2agPq2Vpseu2P95VhKjjQWIPTSWskWypyBMln45pIqj0BzhZHh1GOBB+nsTnCh
         UK5v7Hi4pqiX0nX+iRcJQDAOFn0IFHe5oNwG1b7HvaYjyqnKboFS7JCJDbjp4IFoYgF1
         A4HxPRHjMnUW+TLvUq6JxtQuQiLciAtUjoxekH6jtxNoNhzt/iFZufy4zB8Is0gxHPML
         N0nRckgG60UyTQV+u6678QuSF5lIu8UOBis6QUcuwP/ByheDm/8VrShj1Dtrb+MVge7n
         p6Qp3mIvh0abSkPO38R5kbgoE0K5c6qxFiilugi1a0lYC+5Rt6JjDkC0qSFSE2z0+FtZ
         /X6w==
X-Gm-Message-State: AFqh2krE3PKwgViyNGPMomj2eOn5JQjRMtdqvcmhDOOQ5fyRZXFiXcoM
        n3cUy4JToBxohhs8pSDLahPQAg==
X-Google-Smtp-Source: AMrXdXszrXhse4Qz9szBouzaMHX25dA7rFzloIJ6HotOtL7+h55wT0KSklGyBnryLrvdlaPDavKAZw==
X-Received: by 2002:a17:906:1519:b0:803:4426:d31d with SMTP id b25-20020a170906151900b008034426d31dmr23462289ejd.11.1672346261060;
        Thu, 29 Dec 2022 12:37:41 -0800 (PST)
Received: from localhost.localdomain (mob-109-118-160-216.net.vodafone.it. [109.118.160.216])
        by smtp.gmail.com with ESMTPSA id d16-20020a170906371000b0073d7b876621sm8872814ejc.205.2022.12.29.12.37.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Dec 2022 12:37:40 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, damien.lemoal@opensource.wdc.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V13 2/8] block, bfq: forbid stable merging of queues associated with different actuators
Date:   Thu, 29 Dec 2022 21:37:01 +0100
Message-Id: <20221229203707.68458-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221229203707.68458-1-paolo.valente@linaro.org>
References: <20221229203707.68458-1-paolo.valente@linaro.org>
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
index 801fd66df651..54d629639c1b 100644
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

