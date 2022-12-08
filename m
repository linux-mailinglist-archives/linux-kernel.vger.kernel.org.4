Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB537646D8D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 11:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiLHKtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 05:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiLHKsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 05:48:46 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C8D5BD7C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 02:44:01 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id vp12so2861032ejc.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 02:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H138aqobhHjmcHH6RFqFD59W1hrmC7/KCJez2I0jafo=;
        b=CzlENSXIlHjwUOyd67Oro8J9zGfNfaRzYFG93Ulb9hv/6zS6G+b9XaV+dCu+ZWNhED
         +HU0nltoTBvmExw2O29qJ+TsptddL3PAmYZQ62XqZCQ7QUhqcDChUUEvOTiA9h34wooq
         sUqN1lZtAMUiBz0QW9pgWcObvCpJNtHdQf9A1Wb0QOaEvZFn1AsAn3NoFOUGvuh5hfJq
         uEZNaaLFLSoeOZMIvXYLgLrACvltaevVvTBp814KWYSsJj9RXoyQQcXqPCZKN3RXRHwT
         pnjBA9M8a7Zt0PLWb49IGqdZ/TJO+pq8S5tdzZ7AO9cS9Hw2JB4ERmAcrNW33XNk1oHD
         cGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H138aqobhHjmcHH6RFqFD59W1hrmC7/KCJez2I0jafo=;
        b=O9tw0I751yxdT69u+z7D3XIJvf5hEq7XjSvEUwmawOT/SbTO6ZcwBm+3K6asX46NV+
         N/VUMmLJXK5eQE3woQg7NifN9ehEGDWw6e2Nlx8zlsiFs5/94+WI7O64dL1QpxyeFP5g
         OT5Ol5UYCNZC9vR/6MOrt8WWxPShsz0uP3qBqHuyFjp+GIuZP03uscQW2hPF5Cihk7QF
         jW0ttd1jQn1ZMKOqmdGOS5Seg3L4bqRRI668ZYCFW7nE/2tqzHpnTyqctydl9Rw8GchM
         mNHfUNEIPPEvrkbPv700jTTGphhZXxeMf5ewaycVq/+Ii4gtXKMefvh4UU+2H7mS7N3k
         SwXQ==
X-Gm-Message-State: ANoB5pl9ypjAINsOw7HAe/izKVIFChm2Smj5edHUaR3AP4HYSj7yTe1z
        6K0pVJX1EixsOkhYCx9nUMANMg==
X-Google-Smtp-Source: AA0mqf7ohP1f4N+OjCCGBeI0b2uGvG148r9PxPu8WybtywdVkvCp5WeiCvAaDBuTLsSdKzDszpVVKA==
X-Received: by 2002:a17:906:3a85:b0:7ab:afd4:d7ed with SMTP id y5-20020a1709063a8500b007abafd4d7edmr11333715ejd.228.1670496240066;
        Thu, 08 Dec 2022 02:44:00 -0800 (PST)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id fe17-20020a1709072a5100b0077a8fa8ba55sm9544193ejc.210.2022.12.08.02.43.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Dec 2022 02:43:59 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, Paolo Valente <paolo.valente@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH V9 2/8] block, bfq: forbid stable merging of queues associated with different actuators
Date:   Thu,  8 Dec 2022 11:43:45 +0100
Message-Id: <20221208104351.35038-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221208104351.35038-1-paolo.valente@linaro.org>
References: <20221208104351.35038-1-paolo.valente@linaro.org>
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

