Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884CE651E07
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 10:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbiLTJur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 04:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbiLTJu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 04:50:27 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835D61583C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 01:50:25 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id vv4so27960289ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 01:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1vlVQT7oPM9UWQWJ7LqRXY6nAAmmhTt3SmiNtspLrs=;
        b=OsPsOeL4C5sSq5K8HgMGBMVaRPNqxORKprby5lywWjtIRU8lkF3lby7jTAV+K68hYQ
         fJ1mEy0NGJcketjis9ZXb021nr3ODJtdqHY2yfswSFX8ne5UZhxhE+boBziUtWygVxqf
         1Jm/yCdRYgDiMV0s/jUM6Dfw2PmNqlHv6vqln/WRzT9TlU7bDIoavCniG3wYHoqIDroy
         O35lJuNNX5OmF4rwwUalkRkMknSUonv2BSDkSz7LOe1vVaIU7mNzpaiL+Nmitb1asxct
         6hiMUjlMA4D9GAP5bJhTZ8TOGWW5ta5nxLWDfXhkrqOxcjnPTMluidsRC3wUsFXN45BH
         W08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1vlVQT7oPM9UWQWJ7LqRXY6nAAmmhTt3SmiNtspLrs=;
        b=h8x00XLjntHFoGfspueEyJCFrnku7Pt5u7UV/hoD7JqLauYI+xbzSRZIfVeiL8/Dao
         fmMzTsup2E0CDMxbkWnr0Un9D58vgbLE33z/RdKR86jj+bF7zZhqawJ4VeltdwYOlHAU
         82mmDowBen5OjRO+PRi9uQhLwSOng9QkX5UopzMgh3rJaMiBXE+hZFXzjaQOnBfhYn7o
         BKS/V19mTkEDASE7Uf+MhZnJmouct77nm5EXuilklEzxBHsqQLz6I7JTb+q4SkGLMQgL
         KmM8cnEpquGDseceTI7DnBtjZh0bJn1tCyYtIwfsVz2dLWhmGN88Sj2BrXdF9iWhjlBh
         7xRg==
X-Gm-Message-State: ANoB5pnwMOclMdEs0bSRJVWFAmoMTpgN1aSk6dfJ6Xac1IOOc2d237Xg
        B/nzj0cx0B3GNN3YXvfrImOPpQ==
X-Google-Smtp-Source: AA0mqf7QjrWHU0sYLULomd6L5+M5dBmp5psjUrmWrNASLQFnP9DyR8h85xKB447GaEA++Y/3bGSpRw==
X-Received: by 2002:a17:906:375a:b0:7c1:709d:fa49 with SMTP id e26-20020a170906375a00b007c1709dfa49mr42226524ejc.18.1671529824057;
        Tue, 20 Dec 2022 01:50:24 -0800 (PST)
Received: from MBP-di-Paolo.station (net-93-70-85-0.cust.vodafonedsl.it. [93.70.85.0])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090618a200b0082ea03c395esm1669207ejf.74.2022.12.20.01.50.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:50:23 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, Paolo Valente <paolo.valente@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH V11 2/8] block, bfq: forbid stable merging of queues associated with different actuators
Date:   Tue, 20 Dec 2022 10:50:07 +0100
Message-Id: <20221220095013.55803-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221220095013.55803-1-paolo.valente@linaro.org>
References: <20221220095013.55803-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
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
index 95125c8d52e7..79cdc4dbf76c 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5642,9 +5642,13 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
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
@@ -5662,7 +5666,8 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
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

