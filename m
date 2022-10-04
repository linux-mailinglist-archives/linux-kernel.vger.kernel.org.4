Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332255F3F5A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiJDJTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiJDJS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:18:57 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DC22ED67
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 02:18:54 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y100so17475208ede.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 02:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=gmxZf6QkPzz+sxP+3JgThS4uu0ir5KC0SdCPLMQLKec=;
        b=o0Vn75LSs+VDuxa4a29TXta1IDYsGi3D6s7QRsVtwxJeYPjH5T6cOjSj4aH89zgdx9
         qb1S5383hKtzOD7XbE/1Fr6icM2eGQxv/hRzd3EUCe39bh2qMS0cgh9FrDZujQWebheh
         O+nJqRB9at1PNA6IApSUUTuGhmKM9QRHtdOypri2FQW3OwacNrUEQNS3MObTCPraZ/Yz
         +kEKSgWiH5V0+xaY9xNRmoj79qLpyVdocKxASNYhMXFg32N6fhyjhhiXQ62VxbEP7qld
         6GZeTDnq7TJxn4d+AzGxgHMCRfMMiSib4jnDXryMOnrAf6bShDp09kTTRTtkjaOlvrKV
         /ADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=gmxZf6QkPzz+sxP+3JgThS4uu0ir5KC0SdCPLMQLKec=;
        b=vWR7+PEH9wsYDnAUuB8qyR7/aZp9axZOehXSayfMWCiAl/Rd3hHxDMCdbp8byy9UTA
         pSdOewX+huR+ZQPBqmG/EHqaOy4eme7qTJOlcEhjUw/CWyamiE1myS1TkaAyc+kFbL0m
         iW3xYhWgkPRj7laThYpu5ujH16lFavJdlq+rhxTYITQiRtZp5bqEaidKIktrcJ24CEEU
         W7VxTF0ICNfWCGuTQVZDJy058vkC7Ih4WA8iKZTO8cGA5mv9bkexEL5rUE+xFtVly8q+
         XE4vx6Im/0+0HtT34gqmntLjC/wypk7xqG8LX4l0gVlniOX4zTQwjdPo3A9wcE9ndvGF
         zEKw==
X-Gm-Message-State: ACrzQf2QeslZYmRqb0ZBpzp9n8fYDOtlmqVgdxP8DzOYjI2jNm7Cw6CN
        uxOti5EzCZe8gKNzS433uh2JAw==
X-Google-Smtp-Source: AMsMyM6nZXWtodzOZsdMWwIgR+03UqxUEeZhCDjN/DCIjQrb+Y3ZnN/BRZ22KFYb8u20rgcjUIgVvg==
X-Received: by 2002:a50:ec84:0:b0:459:ae8:8025 with SMTP id e4-20020a50ec84000000b004590ae88025mr7004355edr.321.1664875134075;
        Tue, 04 Oct 2022 02:18:54 -0700 (PDT)
Received: from MBP-di-Paolo.station (net-2-37-207-44.cust.vodafonedsl.it. [2.37.207.44])
        by smtp.gmail.com with ESMTPSA id c17-20020a17090618b100b007826c0a05ecsm6597926ejf.209.2022.10.04.02.18.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Oct 2022 02:18:53 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, andrea.righi@canonical.com, glen.valante@linaro.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        Davide Zini <davidezini2@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V2 8/8] block, bfq: balance I/O injection among underutilized actuators
Date:   Tue,  4 Oct 2022 11:18:16 +0200
Message-Id: <20221004091816.79799-9-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221004091816.79799-1-paolo.valente@linaro.org>
References: <20221004091816.79799-1-paolo.valente@linaro.org>
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

Upon the invocation of its dispatch function, BFQ returns the next I/O
request of the in-service bfq_queue, unless some exception holds. One
such exception is that there is some underutilized actuator, different
from the actuator for which the in-service queue contains I/O, and
that some other bfq_queue happens to contain I/O for such an
actuator. In this case, the next I/O request of the latter bfq_queue,
and not of the in-service bfq_queue, is returned (I/O is injected from
that bfq_queue). To find such an actuator, a linear scan, in
increasing index order, is performed among actuators.

Performing a linear scan entails a prioritization among actuators: an
underutilized actuator may be considered for injection only if all
actuators with a lower index are currently fully utilized, or if there
is no pending I/O for any lower-index actuator that happens to be
underutilized.

This commits breaks this prioritization and tends to distribute
injection uniformly across actuators. This is obtained by adding the
following condition to the linear scan: even if an actuator A is
underutilized, A is however skipped if its load is higher than that of
the next actuator.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Davide Zini <davidezini2@gmail.com>
---
 block/bfq-iosched.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index fc4658438ecc..7945aa307cd9 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4800,17 +4800,25 @@ struct bfq_queue *bfq_find_active_bfqq_for_actuator(struct bfq_data *bfqd,
 
 /*
  * Perform a linear scan of each actuator, until an actuator is found
- * for which the following two conditions hold: the load of the
- * actuator is below the threshold (see comments on actuator_load_threshold
- * for details), and there is a queue that contains I/O for that
- * actuator. On success, return that queue.
+ * for which the following three conditions hold: the load of the
+ * actuator is below the threshold (see comments on
+ * actuator_load_threshold for details) and lower than that of the
+ * next actuator (comments on this extra condition below), and there
+ * is a queue that contains I/O for that actuator. On success, return
+ * that queue.
+ *
+ * Performing a plain linear scan entails a prioritization among
+ * actuators. The extra condition above breaks this prioritization and
+ * tends to distribute injection uniformly across actuators.
  */
 struct bfq_queue *bfq_find_bfqq_for_underused_actuator(struct bfq_data *bfqd)
 {
 	int i;
 
 	for (i = 0 ; i < bfqd->num_ia_ranges; i++)
-		if (bfqd->rq_in_driver[i] < bfqd->actuator_load_threshold) {
+		if (bfqd->rq_in_driver[i] < bfqd->actuator_load_threshold &&
+		    (i == bfqd->num_ia_ranges - 1 ||
+		     bfqd->rq_in_driver[i] < bfqd->rq_in_driver[i+1])) {
 			struct bfq_queue *bfqq =
 				bfq_find_active_bfqq_for_actuator(bfqd, i);
 
-- 
2.20.1

