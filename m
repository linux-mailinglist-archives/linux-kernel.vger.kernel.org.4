Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1251B64805B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 10:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiLIJpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 04:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiLIJox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 04:44:53 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814685F6E9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 01:44:51 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id qk9so10240187ejc.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 01:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H138aqobhHjmcHH6RFqFD59W1hrmC7/KCJez2I0jafo=;
        b=btsU6l53eY4vFTX9AKDdy2g9od1LLpdLdDuu1QCPF/k7IGTTEemCejPLwajzETQFOM
         rHSM4wnGbVop+UajdwrT/guv2ol9KtEfORylRr+hxwkiQnVNvBx+7LMBBg3KGjQbf11o
         9f9nHHpTXziUIugVTOV14V58b7lRvIhMWGQti3p+PROjNvzcqtbqT1Bp7hIH7y9zhnZ1
         tyJm3f2OgsfG42zlttZeAGz/0UdT3NcR9ljWDRl/9t5ZQPSNum9HsWM9DR8C/dEHNtVR
         eunCVoF7iRT8Ke4TBTKkXZCV2B0wcmKLkXbqmZrp1D2EiNVfAble4f6sHizgGQ27PaPD
         Qaag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H138aqobhHjmcHH6RFqFD59W1hrmC7/KCJez2I0jafo=;
        b=vcJNWdUlyjSVNoiDpUorKC9zQEnVgh/DiFsLOAkGM1AInlMPEHU/xoFitwO/DuhUUk
         2372NlbUBVbyLCo4fF4flBS9Wa0F6OgR2LIVa5b8QZnReFQulZ7bJ5GVI90fyo0Zsml1
         yWNFcOmbj3fV8pbOXR6P2aZfcWL+fFQRSoaRE225cous/ikmd+9NV2hT3bTzOl5ufAoO
         /sdLwmhDUy1VV8ZyOb44RBkvqeRE3U0ndb4tbQu/AU6hFvL9PayNbafuiYaoYAy49f5e
         FNCs/qjoGiwK/qUoS2sxI2/dMKLfYqcnTgYjCbaBSs7Ty2+DNtMraVFjzA8iRwpjyZ65
         bnzw==
X-Gm-Message-State: ANoB5pka26grHC2ePY0UgThhpKiEioXvmTxtN6RIhl38OZscgIW4VniL
        I+kPvO68uFsksFhucJf+QeYv6w==
X-Google-Smtp-Source: AA0mqf56YsryAxyHwHwpOu7+wWTQ89NirJxVuHzRZQds2YmCDTN7qwuW2baOR6DrPcHkXgWAYPsz8g==
X-Received: by 2002:a17:907:a0cb:b0:7b9:c08b:e8a2 with SMTP id hw11-20020a170907a0cb00b007b9c08be8a2mr4665419ejc.15.1670579089983;
        Fri, 09 Dec 2022 01:44:49 -0800 (PST)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id oz18-20020a170906cd1200b007c11f2a3b3dsm353421ejb.107.2022.12.09.01.44.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Dec 2022 01:44:49 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, Paolo Valente <paolo.valente@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH V10 2/8] block, bfq: forbid stable merging of queues associated with different actuators
Date:   Fri,  9 Dec 2022 10:44:36 +0100
Message-Id: <20221209094442.36896-3-paolo.valente@linaro.org>
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
index 16dbf52ce74b..456b5f5c24fd 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5708,9 +5708,13 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
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
@@ -5728,7 +5732,8 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
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

