Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174216129DA
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 11:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiJ3KDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 06:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiJ3KDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 06:03:40 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B763EBC7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 03:03:37 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id sc25so22763130ejc.12
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 03:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dagqyailu11jgL84XY9XZ7ZO8PNuYsgn+9sY89yrA6U=;
        b=T9Fs+8e83L0bqfPmtM639a+YtCRBr5w4o65ZRTQeHdi6bOvQ2M+n9GYOuQdbiXrPx2
         AM10J7h1PtP7OamKIIoXg2/E8f+KqVpVdjkQ4ksPCyM0UH6cLHxTsLuK0nwWhzJUBzQ4
         m8r8BAzySbvyPVPufA8mmGAeTT688CWVKfHTy0lv43BgcLCQx7CkvFqULSHisNVXhcDZ
         gwDsKyBIXwXlEpf58IYHkos+NLInCv+yXoRsLyi3EwosNDDxFxPbnV+eyxja4CMvhyof
         XHAgfzscqrBXqmg28LYSe3ic1EgEYgadVLmeeKvS5/deKAD/pXnaLy5w0p0B2X64Mndh
         7eYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dagqyailu11jgL84XY9XZ7ZO8PNuYsgn+9sY89yrA6U=;
        b=noPx1GEY9o6z86I7OL834OpYCXL0mRVYod2xt2pJ0k2zApPrsuvjvy9RfTB1MIzRLM
         4RtrAtRmAQ8H8hnbFhRAz+nyHi7yMLfzMvRdJVRlwTmkhhjqBb1GZi+smQ2Sbqt1S2LT
         QNVveyeJLcMFW1Gx+ZuG8MTNFYqkaFj5F9agLnh035F8x+sObqcPdgqECHdu5v+XGmQo
         vt6mdCkjcge/lC5gcClNgkzodf7zWriiCWU3T3Jee5jrcxLTziFNtb84Ryq4h9HvGOQ7
         YQbh9KHHwxMpwdy8GS6RetYgmQTvhzR/GMOIAnA2fSi3Fenny2dzRQb1LACP6WXAtFtj
         8FFw==
X-Gm-Message-State: ACrzQf1TTzIl/FKb7qTQ/InUcLoYvRoYiT1zWnnRUCEGZyGfXP0u4Lr9
        xO0nE5HY0/9P2GDmebLNwsiqww==
X-Google-Smtp-Source: AMsMyM6JhH0GebmdyqV1zMQdWueBXpI8e4sf8Rmo+d9zd2KAm/m5LgqKre84iBjX+YDXMMUqhGZgiw==
X-Received: by 2002:a17:906:7949:b0:7ac:9917:90b9 with SMTP id l9-20020a170906794900b007ac991790b9mr7337741ejo.536.1667124216223;
        Sun, 30 Oct 2022 03:03:36 -0700 (PDT)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id d27-20020a170906305b00b0073d71792c8dsm1666088ejd.180.2022.10.30.03.03.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Oct 2022 03:03:35 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V5 2/8] block, bfq: forbid stable merging of queues associated with different actuators
Date:   Sun, 30 Oct 2022 11:02:54 +0100
Message-Id: <20221030100300.3085-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221030100300.3085-1-paolo.valente@linaro.org>
References: <20221030100300.3085-1-paolo.valente@linaro.org>
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

If queues associated with different actuators are merged, then control
is lost on each actuator. Therefore some actuator may be
underutilized, and throughput may decrease. This problem cannot occur
with basic queue merging, because the latter is triggered by spatial
locality, and sectors for different actuators are not close to each
other. Yet it may happen with stable merging. To address this issue,
this commit prevents stable merging from occurring among queues
associated with different actuators.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 5c69394bbb65..ec4b0e70265f 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5705,9 +5705,13 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
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
@@ -5725,7 +5729,8 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
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

