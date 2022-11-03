Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FF261845E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiKCQ1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiKCQ0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:26:48 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1491B1C4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 09:26:47 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r14so3856555edc.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 09:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NDAA6/E/P9lXM9Ku+t+E0rrluZwqWDYrKOwSkHUnDs=;
        b=Pm/gfINPE4LLxbTpwlYOTiaz4l3SOk0t9OltHwcjVhRDjEjuG1U04RONmR3C2lDHq/
         ad7tnzffxg56mz5f/jxEZNm16QzPp/XXMy5lN2ldidKPteb6Sfv10YYFcFtB+9oFRrtN
         xL/wK7smqz5prIsMRaq026zgKIL/0H0OlFtDCt6H4KtAF+PT6O0Evw/briI9n1E60iwD
         DSFKGsaBCRfxIYhjik5Gc5JUMRc+6O9NFLuospAJhmriCwYXo1labqPUczADLKA/DyMv
         5ZVI2UHx7e2Nlmmv8jc4JrBkNwV4cK3YH8fKWov7VDF4m7B/nEKpM4su3jmUAtdg/UYn
         FC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NDAA6/E/P9lXM9Ku+t+E0rrluZwqWDYrKOwSkHUnDs=;
        b=xDabf2fZ07MLCi3z6pRVu3dogPVFOT7HGML3LKIbKTU+xxgbodobMTD1lqKtUzT+Wg
         KahMUhUXNe0ReuwMsPFMWULsiwiUJEBIqlfPdJzd+d3yJwWshAgntQYTz0Z7V15gXYR+
         DCuwwai345rwFWaB6416hRXrpD1JdUKVobHkDcQAbkhVRepFBFclz0CcrXhoYEdsj0/+
         /Vaa1CU2yYSOIu5XD8n/E2ewRClNg+mt5X/XQS1usFf7ADXpRWZICI8ezoiWjPpjW72n
         1KfUVEwIWzmpswJLD9oGbzC0JuuP9XuO4J3ipp2bnrdM2StCpaj8NQm2NwZZGxfPthwJ
         1W9Q==
X-Gm-Message-State: ACrzQf3OVET1ai+wWWlkbvFJd9ZLJJCPBXtPR+9yvWnxe/U/hfNswTiq
        YLFycTKNxbdn4/xyaCtXn1hS3Q==
X-Google-Smtp-Source: AMsMyM7Z7gsABFnd5jbyemd92szqyQHJQP4shDL1yEiYB9KhJME7VKqMZz8JwwszxMvd9stGWvmfUQ==
X-Received: by 2002:aa7:d5ca:0:b0:464:4ac8:d265 with SMTP id d10-20020aa7d5ca000000b004644ac8d265mr2389437eds.265.1667492806022;
        Thu, 03 Nov 2022 09:26:46 -0700 (PDT)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id kx9-20020a170907774900b0078116c361d9sm702507ejc.10.2022.11.03.09.26.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Nov 2022 09:26:45 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        Davide Zini <davidezini2@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V6 8/8] block, bfq: balance I/O injection among underutilized actuators
Date:   Thu,  3 Nov 2022 17:26:23 +0100
Message-Id: <20221103162623.10286-9-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221103162623.10286-1-paolo.valente@linaro.org>
References: <20221103162623.10286-1-paolo.valente@linaro.org>
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
index db91f1a651d3..c568a5a112a7 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4813,10 +4813,16 @@ bfq_find_active_bfqq_for_actuator(struct bfq_data *bfqd,
 
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
@@ -4824,7 +4830,9 @@ bfq_find_bfqq_for_underused_actuator(struct bfq_data *bfqd)
 	int i;
 
 	for (i = 0 ; i < bfqd->num_actuators; i++)
-		if (bfqd->rq_in_driver[i] < bfqd->actuator_load_threshold) {
+		if (bfqd->rq_in_driver[i] < bfqd->actuator_load_threshold &&
+		    (i == bfqd->num_actuators - 1 ||
+		     bfqd->rq_in_driver[i] < bfqd->rq_in_driver[i+1])) {
 			struct bfq_queue *bfqq =
 				bfq_find_active_bfqq_for_actuator(bfqd, i);
 
-- 
2.20.1

