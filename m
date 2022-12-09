Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A140648062
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 10:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiLIJpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 04:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiLIJpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 04:45:08 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8A962E97
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 01:44:56 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id x22so10193955ejs.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 01:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaqQn9QBmVk5NBvgZzVnJIbHKeIyyamAKMjG6Bafei0=;
        b=Sj8iI9sGK76NewZS3Nd/PjxEAikAxNkrULKH08r/OmP7RB+LUpVZrAPjE8ZgIBYTFY
         B13h6iJ2MMa6kp51hftaaKXYIODkle/laWFJwprBbe8R6mRftJ/C9HMI0otSp2IcrtI6
         PYxlQ07qYohodAUwdMVEgC+P5vsKGflEMegYna6mJIqE85P8/LbYGj35DZMcc+6Opc9P
         mtJZv13ncQVFrh0qC98YD6mir2hV/opDgG6lV0pZ2+ELlb1NSU2GzBHzlMrnqotvjvpG
         t3EFKci1yrpcIRZIQZzB1YIo9xTG9NR9jA/aWt55rceXltKcyzFsIRYAdyZeZppMcrYz
         XiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaqQn9QBmVk5NBvgZzVnJIbHKeIyyamAKMjG6Bafei0=;
        b=VteKjVQojZv7eZvC4xO2MNfq4nqOusgciq7mvI71vStrs1PjYMdy18lYL7HXuwEUyD
         xdTwSsYmEMHN5FRP4JzsG8cpSm4i5S6Ts0FGHOszMeQ52gOm/yVdoIY/Uhs5KIrzdhVT
         3HSV+hz0NSElPwkulS49v4TgZiBveA36MwimBe0L+YjUasm1UyMWgEHbrFiROT5NOW2q
         s25sEoIActcLlGuo3yn850yJ6QMFYBGT4bH6toz5Bmqr6IcoJuHHBj+RV//eRaJ3aNkf
         MTE8izhmQUYJh2tKhr1fPcozrgYgMFh+l8jDMR8XDGxXzrlII12V8Jz6qePZjPzQz/Wg
         M71A==
X-Gm-Message-State: ANoB5pljx6dwa35Roe9jWKjWUJtGW2RXLQ2BgjAq2VfYYCm5AIX2HPd2
        l+cdZ1BreznDW5LA1lSOKrjlIw==
X-Google-Smtp-Source: AA0mqf4isvrXEIo+NVn/pEPgCc9sU6Vc8mT/qvqgE5DDUZuXrDhXuZx3Bt5TvXzVw/tWy03QcctB/A==
X-Received: by 2002:a17:907:b610:b0:7ad:80cd:67b4 with SMTP id vl16-20020a170907b61000b007ad80cd67b4mr4621065ejc.48.1670579095577;
        Fri, 09 Dec 2022 01:44:55 -0800 (PST)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id oz18-20020a170906cd1200b007c11f2a3b3dsm353421ejb.107.2022.12.09.01.44.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Dec 2022 01:44:55 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, Davide Zini <davidezini2@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V10 8/8] block, bfq: balance I/O injection among underutilized actuators
Date:   Fri,  9 Dec 2022 10:44:42 +0100
Message-Id: <20221209094442.36896-9-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221209094442.36896-1-paolo.valente@linaro.org>
References: <20221209094442.36896-1-paolo.valente@linaro.org>
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
index 527def05ce44..0ec8310331e1 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4830,10 +4830,16 @@ bfq_find_active_bfqq_for_actuator(struct bfq_data *bfqd, int idx)
 
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
 static struct bfq_queue *
 bfq_find_bfqq_for_underused_actuator(struct bfq_data *bfqd)
@@ -4841,7 +4847,9 @@ bfq_find_bfqq_for_underused_actuator(struct bfq_data *bfqd)
 	int i;
 
 	for (i = 0 ; i < bfqd->num_actuators; i++) {
-		if (bfqd->rq_in_driver[i] < bfqd->actuator_load_threshold) {
+		if (bfqd->rq_in_driver[i] < bfqd->actuator_load_threshold &&
+		    (i == bfqd->num_actuators - 1 ||
+		     bfqd->rq_in_driver[i] < bfqd->rq_in_driver[i+1])) {
 			struct bfq_queue *bfqq =
 				bfq_find_active_bfqq_for_actuator(bfqd, i);
 
-- 
2.20.1

