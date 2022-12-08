Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D97646D93
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 11:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiLHKt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 05:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiLHKss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 05:48:48 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94412178A4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 02:44:05 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id c17so1492864edj.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 02:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7xEq2tmiQO2KsEHqRclviFrnGV/8d8j2wl23Ajh0XU=;
        b=vDa4LXRWKgw4W2u9WKOecDvbeqsF9ooSi/mdfU9eLI18SHW8WE45FLgdDSGl603Rhx
         4mzQdt0J6sAmNEIPUpOZk/sfi/gh22x9VJJT9DeWCZYF+mNwQQA4FG4BjNFwj2aMxAQt
         Fnmv3nNzeEimIMEhK5XVtM/hiBbOiTmhVtgF33VIYoZ/3BYisWwxRPbhBw54+FH2XYET
         1u0Mkp88JuR3rKvQb9S3wbRyEX4W2WNtNXdmIipx8FterzkopVBR3m3AKLFPPHkEymnQ
         6k3A2SW+OW9uZ75B7YF0NZAOgj0AYJg2SqdlPomq9KWRfnqlOcCYsf/7t+l2zhv8CdsY
         21jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7xEq2tmiQO2KsEHqRclviFrnGV/8d8j2wl23Ajh0XU=;
        b=RXJDpt8YmYikT7CrWYEdTxV3H340qKT/yIWZypSKVXlYmgj2omo7ivEjOJCJpNR0PU
         8SV5dnwLe9A9j1/LzKI8i2/TzKRuSDzW9Ov8VNdmYS/nU4qlb4LCc/jl7YwwAm5bapki
         TiFIl2QraSpgUna6OGUyEgOJCOKN2GrkLi+zjlMeANs+0UlbISqagI7eheWGQqiKAZnF
         PA5ceadIEYM+YmtFflFzhKrTizUFDlaGluFT6gqayMtm6IVc1hziSvFhUXTah0r5a/+c
         dJZ9n/slq+tS9xO8Ihb/9SPd6LMXLU4fGJI7//PMt0ihtvY5CeTTc8QMKXa7AX31YuRS
         Q/ng==
X-Gm-Message-State: ANoB5pmxE2X1nxCkM36DZmC6v18HGXJmt4RbQNrqt4D5RzIEhk9sZdDU
        jdoir3TDK2pBZyFPW/lpmojHig==
X-Google-Smtp-Source: AA0mqf6FC3KEKfqL6uNadOIwNC1HgvysQ3djan/RKEiL01w3dlAmNxUlpMfN90mgyusdI8eFWiQBlA==
X-Received: by 2002:a05:6402:2949:b0:468:fb6b:3a79 with SMTP id ed9-20020a056402294900b00468fb6b3a79mr26310140edb.63.1670496243600;
        Thu, 08 Dec 2022 02:44:03 -0800 (PST)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id fe17-20020a1709072a5100b0077a8fa8ba55sm9544193ejc.210.2022.12.08.02.44.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Dec 2022 02:44:03 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, Federico Gavioli <f.gavioli97@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V9 6/8] block, bfq: retrieve independent access ranges from request queue
Date:   Thu,  8 Dec 2022 11:43:49 +0100
Message-Id: <20221208104351.35038-7-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221208104351.35038-1-paolo.valente@linaro.org>
References: <20221208104351.35038-1-paolo.valente@linaro.org>
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

From: Federico Gavioli <f.gavioli97@gmail.com>

This patch implements the code to gather the content of the
independent_access_ranges structure from the request_queue and copy
it into the queue's bfq_data. This copy is done at queue initialization.

We copy the access ranges into the bfq_data to avoid taking the queue
lock each time we access the ranges.

This implementation, however, puts a limit to the maximum independent
ranges supported by the scheduler. Such a limit is equal to the constant
BFQ_MAX_ACTUATORS. This limit was placed to avoid the allocation of
dynamic memory.

Co-developed-by: Rory Chen <rory.c.chen@seagate.com>
Signed-off-by: Rory Chen <rory.c.chen@seagate.com>
Signed-off-by: Federico Gavioli <f.gavioli97@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 60 +++++++++++++++++++++++++++++++++++++++------
 block/bfq-iosched.h |  8 +++++-
 2 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index dcecba3c6e23..957ce61faaf2 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1839,10 +1839,25 @@ static bool bfq_bfqq_higher_class_or_weight(struct bfq_queue *bfqq,
  */
 static unsigned int bfq_actuator_index(struct bfq_data *bfqd, struct bio *bio)
 {
-	/*
-	 * Multi-actuator support not complete yet, so always return 0
-	 * for the moment (to keep incomplete mechanisms off).
-	 */
+	unsigned int i;
+	sector_t end;
+
+	/* no search needed if one or zero ranges present */
+	if (bfqd->num_actuators == 1)
+		return 0;
+
+	/* bio_end_sector(bio) gives the sector after the last one */
+	end = bio_end_sector(bio) - 1;
+
+	for (i = 0; i < bfqd->num_actuators; i++) {
+		if (end >= bfqd->sector[i] &&
+		    end < bfqd->sector[i] + bfqd->nr_sectors[i])
+			return i;
+	}
+
+	WARN_ONCE(true,
+		  "bfq_actuator_index: bio sector out of ranges: end=%llu\n",
+		  end);
 	return 0;
 }
 
@@ -7160,6 +7175,8 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 {
 	struct bfq_data *bfqd;
 	struct elevator_queue *eq;
+	unsigned int i;
+	struct blk_independent_access_ranges *ia_ranges = q->disk->ia_ranges;
 
 	eq = elevator_alloc(q, e);
 	if (!eq)
@@ -7202,12 +7219,39 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 
 	bfqd->queue = q;
 
+	bfqd->num_actuators = 1;
 	/*
-	 * Multi-actuator support not complete yet, unconditionally
-	 * set to only one actuator for the moment (to keep incomplete
-	 * mechanisms off).
+	 * If the disk supports multiple actuators, copy independent
+	 * access ranges from the request queue structure.
 	 */
-	bfqd->num_actuators = 1;
+	spin_lock_irq(&q->queue_lock);
+	if (ia_ranges) {
+		/*
+		 * Check if the disk ia_ranges size exceeds the current bfq
+		 * actuator limit.
+		 */
+		if (ia_ranges->nr_ia_ranges > BFQ_MAX_ACTUATORS) {
+			pr_crit("nr_ia_ranges higher than act limit: iars=%d, max=%d.\n",
+				ia_ranges->nr_ia_ranges, BFQ_MAX_ACTUATORS);
+			pr_crit("Falling back to single actuator mode.\n");
+		} else {
+			bfqd->num_actuators = ia_ranges->nr_ia_ranges;
+
+			for (i = 0; i < bfqd->num_actuators; i++) {
+				bfqd->sector[i] = ia_ranges->ia_range[i].sector;
+				bfqd->nr_sectors[i] =
+					ia_ranges->ia_range[i].nr_sectors;
+			}
+		}
+	}
+
+	/* Otherwise use single-actuator dev info */
+	if (bfqd->num_actuators == 1) {
+		bfqd->sector[0] = 0;
+		bfqd->nr_sectors[0] =
+			bdev_nr_sectors(dev_to_bdev(disk_to_dev(q->disk)));
+	}
+	spin_unlock_irq(&q->queue_lock);
 
 	INIT_LIST_HEAD(&bfqd->dispatch);
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 1450990dba32..953980de6b4b 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -810,7 +810,13 @@ struct bfq_data {
 	 * case of single-actuator drives.
 	 */
 	unsigned int num_actuators;
-
+	/*
+	 * Disk independent access ranges for each actuator
+	 * in this device.
+	 */
+	sector_t sector[BFQ_MAX_ACTUATORS];
+	sector_t nr_sectors[BFQ_MAX_ACTUATORS];
+	struct blk_independent_access_range ia_ranges[BFQ_MAX_ACTUATORS];
 };
 
 enum bfqq_state_flags {
-- 
2.20.1

