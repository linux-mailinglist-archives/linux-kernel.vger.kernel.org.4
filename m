Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F155F401A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiJDJno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbiJDJnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:43:01 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF681E3E0
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 02:40:27 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a26so27633664ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 02:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Lkj24CwnqblrU2r7BP9tYzNtlqxQyj6cU7dT5FOgpSw=;
        b=GMFbjSxm9o1TQamkt1NbybYxlFvue+3r266VqXcJfN6PdccRZvTT25BUA0sx0RIvrN
         D3xSAlTqHaPSGUS4BavTR6i5tvrtHLmwm2Q3BJG45EJgATv7eKfh+GecaFT/3YbCbfGd
         q4bwAUsX9YeRwxM8jPbBWaJzwhbyQojNDhuZfB/lnlcI3Iyr85Wr3FzhqM59hpioueOx
         xEUiNDmyGsEKoGzO/skMGT1k7rxanGOiAi8rDHwLZxXZbmTeBsgavCPkD9I7fpN54WVw
         wXpfDECndz0rfteQw5GHbTbxnv4Iy99uPtFp2Si76qmUVzX3ZYjc1aGKDEftu+SvWFPm
         C0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Lkj24CwnqblrU2r7BP9tYzNtlqxQyj6cU7dT5FOgpSw=;
        b=UobQ2xorjNdFmpjnyk3Zwmn25ryZn2BbrO54P06rhpLIi0amhtDtisaJaR4cHvrmai
         5DtDW/KQ48b3LUHxs2icV96LmAo+4jdO5c1V/lkgn/eyXrvCWxh7jmF8FUKIpvY8YIKn
         3wRDNv+V/IS/UsvC/RDFi4PXCwZDRccNqb8j/3P998GzL+MPkcRbNh8BpaBOCmCDGcew
         aMFsTOFJNrgeoiJ/T9X6D86pYhtsIxIxGAu1BivBXhjmBTDSH3jb2Vbqar/G+Rb1Dfo3
         xdcm+TWYZdahPm3x1SsOuylPBtLK6LM3BCkO3KgJoYNMDq+8Ce/QZFq5C1DIDBtrz9CG
         GbDw==
X-Gm-Message-State: ACrzQf3crKLy4dVNa5clzMEpajMWU4idZ9OtYjkmCv/cZLKrRjvOZQGk
        UNTDslZBEGG/zwJQ7PhPNUVrZA==
X-Google-Smtp-Source: AMsMyM780m0v4fpvF9zALrlRv0AoXqheCq3eP6aMp5XLnmEJF6Yh+7mR2S5FvmcYSYlyorkVSXV+MA==
X-Received: by 2002:a17:906:8a5a:b0:781:6a01:5ccc with SMTP id gx26-20020a1709068a5a00b007816a015cccmr18201757ejc.118.1664876425650;
        Tue, 04 Oct 2022 02:40:25 -0700 (PDT)
Received: from MBP-di-Paolo.station (net-2-37-207-44.cust.vodafonedsl.it. [2.37.207.44])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906200900b00780f6071b5dsm6774853ejo.188.2022.10.04.02.40.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Oct 2022 02:40:25 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, andrea.righi@canonical.com, glen.valante@linaro.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        Davide Zini <davidezini2@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V3 8/8] block, bfq: balance I/O injection among underutilized actuators
Date:   Tue,  4 Oct 2022 11:40:10 +0200
Message-Id: <20221004094010.80090-9-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221004094010.80090-1-paolo.valente@linaro.org>
References: <20221004094010.80090-1-paolo.valente@linaro.org>
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
index 4deb0f6c751e..074b6ae77242 100644
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

