Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06801648060
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 10:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiLIJp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 04:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiLIJpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 04:45:07 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5325661B85
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 01:44:55 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ud5so10233679ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 01:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8Ndh5ww5PJl6V+nNKyxMmWERBXisd1X8r2wdGJifcs=;
        b=SU0NrwSy9J6RrBWZ4G4Z9peX4zNN8U2k5xHUuUagSYqVUF93Zow+lD9umnp7fENtDX
         XD7aoLYVZ8p173G2zU8KQsHQl8scqKDs4vN26PGYSACczDKxKlv8CvzaY9p4PMgWQeWW
         2PWWo0QOiWLGC4rQqN4+TL9OWViY9fXY610Q60UbUcqazeQAreWYrYTU2XqJ4iIlgUEa
         Zw3pKQthrOltFY5TjmcJY0cgskXcjvEISS7pADSlwuT+OLjCjtDsIzfLtTXgokHLnxID
         Szi4789EySjwqpP+QC/sxgjX33ocTOIJqkC+oECiqOfeOLPzJ4jvzLoRVsWNcs8mc4wj
         +iRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8Ndh5ww5PJl6V+nNKyxMmWERBXisd1X8r2wdGJifcs=;
        b=Dgpym+Y+OLQOaOMy4g31bPL+2KFxie+X5oh7oninyi60qiWgnS5zJl1E28lX1Tvskk
         qAHk5nge2Cm86F1r2DSpcbd9Fa/L2mThyViG7dKtRV0nqSlcq9l9AcFqxxQXwW0a/MHn
         Wlc29nW5VwsspJN2Ne05vNkm32dKG1b+psMEkc4YTmmGL38pHUFfTywETRY7JHhd0Azn
         611D92yq80hqplGU/K8NjV78sl9yII61zuxYiuluit/7/kELFCd50pxsyOoFIbwH/09O
         abVnVVFYKlX2/yFWcOE7FkM8npxaofNQz88h1DVqIlQMLsDs7+JivbSRGSX7HN1bYJZO
         c1Bw==
X-Gm-Message-State: ANoB5pnM7Jsdd+BQFyGQlFWfBqFj0DQ7nhCElTvEwmKmftOx+WoQFTr4
        xH/zJKAjJ+n/4xNMxQlC6SCu0A==
X-Google-Smtp-Source: AA0mqf5tOqEFQXSiuTEgkvmxIxN19DMe1VdzQiF8xYxIvL+z82HrS/o4UbxTfoSvYtMJZnjZidX11Q==
X-Received: by 2002:a17:907:d40c:b0:7c0:8a2c:8883 with SMTP id vi12-20020a170907d40c00b007c08a2c8883mr5098961ejc.56.1670579093792;
        Fri, 09 Dec 2022 01:44:53 -0800 (PST)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id oz18-20020a170906cd1200b007c11f2a3b3dsm353421ejb.107.2022.12.09.01.44.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Dec 2022 01:44:53 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, Federico Gavioli <f.gavioli97@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V10 6/8] block, bfq: retrieve independent access ranges from request queue
Date:   Fri,  9 Dec 2022 10:44:40 +0100
Message-Id: <20221209094442.36896-7-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221209094442.36896-1-paolo.valente@linaro.org>
References: <20221209094442.36896-1-paolo.valente@linaro.org>
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

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Co-developed-by: Rory Chen <rory.c.chen@seagate.com>
Signed-off-by: Rory Chen <rory.c.chen@seagate.com>
Signed-off-by: Federico Gavioli <f.gavioli97@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 59 +++++++++++++++++++++++++++++++++++++++------
 block/bfq-iosched.h |  8 +++++-
 2 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index e6684442d775..b5ed666be0e6 100644
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
 
@@ -7159,6 +7174,8 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 {
 	struct bfq_data *bfqd;
 	struct elevator_queue *eq;
+	unsigned int i;
+	struct blk_independent_access_ranges *ia_ranges = q->disk->ia_ranges;
 
 	eq = elevator_alloc(q, e);
 	if (!eq)
@@ -7201,12 +7218,38 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 
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
+		bfqd->nr_sectors[0] = get_capacity(q->disk);
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

