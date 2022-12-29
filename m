Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E0065919E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 21:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbiL2UiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 15:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbiL2Uhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 15:37:52 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E1B167FB
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 12:37:51 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id u19so47361323ejm.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 12:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zlPY0Un+v49wAp4Agod/FVz6SE5LhUB8HuWcFquXnc=;
        b=sdpJY2+NyUmLkfu+69Bgwa7d+tcwQGa4x1nj/LQ5dFbmRDTboBYdKioPr/sVUeIltu
         BnYk3KOvv6XfK9pMHkcsWdKAFwrS16GabcsrkUj++Os0adepdMfqThdiWJq+5j2G6p4p
         r7lEaCONi81KIIQAYX6QfVrMQp2NUQuKjpON+wA7Gco1Xj2/wSwzpE2IGm1zndSlI54U
         QAMofPprAxaBIE5Ei0ccCoinDXYE/w9FbQXsVrYNXUsr9mt6mfEctD5x9sb1XWAH1sbd
         ij1ROss27WN+HRInA3raMHsx/RqQd/QPgh6XLSFb8mqnVNjmxXK15/NVh9yFyDN1MZHX
         uEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9zlPY0Un+v49wAp4Agod/FVz6SE5LhUB8HuWcFquXnc=;
        b=TRaZjq6xLwDt8AVuF/301Tuqk4/mPzME7dtdPabXG8H7y7gjrjtaYmDOd+u4jhm8rF
         MVA22GRUO6P3juF0MEsfPV6R3oq5Y3Sug0Wm4+q/JN0+x9NKxMiP1EfAcPW7vXa1VSzs
         zpoYK1oYhuoQ+WSguLLVRUEKaEZWCA1V3GcEXUcLEFxVtDfsaWbHpqvzOq6xhIa6a4Fu
         oWnwxcSqih2e9epdw4wxs/Q88tNg+JJvL9FCzWM2ruf65KTkP2oTosBpAd5qXeXBZnRH
         cHiRwGCWM0UuczQ642iUS4KpEUDPaOncekqcHd9giFkXTyYYfu5RuuyPyj/a5qllvrnK
         J7Sw==
X-Gm-Message-State: AFqh2kpJgZ/wVErxZr+uqQsjr5DlDjz/wXsxFBVj34FSv8dySZa8hFaF
        poi2DR+GlqC49W7UXsXPUaZ0yQ==
X-Google-Smtp-Source: AMrXdXsrSlcKanVbB0wXQJjNGwoTxQZqpP3fPlRUhqCa6ENu3JN5drvPNz4/WeEsVzzsEnI35rlNiw==
X-Received: by 2002:a17:906:8517:b0:7c0:a48b:2dff with SMTP id i23-20020a170906851700b007c0a48b2dffmr30315702ejx.43.1672346269647;
        Thu, 29 Dec 2022 12:37:49 -0800 (PST)
Received: from localhost.localdomain (mob-109-118-160-216.net.vodafone.it. [109.118.160.216])
        by smtp.gmail.com with ESMTPSA id d16-20020a170906371000b0073d7b876621sm8872814ejc.205.2022.12.29.12.37.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Dec 2022 12:37:49 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, damien.lemoal@opensource.wdc.com,
        Davide Zini <davidezini2@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V13 8/8] block, bfq: balance I/O injection among underutilized actuators
Date:   Thu, 29 Dec 2022 21:37:07 +0100
Message-Id: <20221229203707.68458-9-paolo.valente@linaro.org>
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

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Davide Zini <davidezini2@gmail.com>
---
 block/bfq-iosched.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 6ebcd94bf3b3..f729f51fd383 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4767,10 +4767,16 @@ bfq_find_active_bfqq_for_actuator(struct bfq_data *bfqd, int idx)
 
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
@@ -4778,7 +4784,9 @@ bfq_find_bfqq_for_underused_actuator(struct bfq_data *bfqd)
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

