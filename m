Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961456C6541
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 11:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjCWKiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 06:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjCWKhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:37:39 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA04227B5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 03:34:00 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id o12so84314923edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 03:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679567639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmkAbvZMMAm1tWub9ISTg2NSODjujuFeUC6lDF5gaQo=;
        b=iBU8OGv6tP3Y2HJGuiCD511Ba3WPR8/e99J1WXNwsVjiW2Nl9j37CeHv795s3t/keM
         49SCi5bn1H1Pv6sGkdCrr5x24BlvbqFoQuV56aQl8JpGFqkHRjv9KtEcZ37AFmsNZRSD
         nzNbWCmpSHkVnMau5YVGO/cdtwSg57XXNCoE9B3YwB82ePq1qNXGqseA//ED+IOqZ7fc
         zpsJzwKCIp49vw6ff6h8RWnHkUw2TnqO0oOCBJivk9drcjx7lJpd5Aa8aon/SiEI985B
         /fgYxLXmvzKYmsXF5di1jAW0x2haaYm7nJtmul1PV82aM20+Q+4N8z+Zzi0eOE79pJkq
         pHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679567639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HmkAbvZMMAm1tWub9ISTg2NSODjujuFeUC6lDF5gaQo=;
        b=OvnlAtllf7DnHo+suVCU+n7AYbN5GLZfV5mw/BBiMhU6X/wehzpZNbCHmH1awGzM25
         +CSmb0Ukccd3F/XJYiqGSXG+vPV1MnijlJ5IWkV7Mah/FJP/mktx1WyM04T32Db+LtL3
         iN0W0s1lqzNeDbWV80z3obeFgBsKsTgh/3Z8H3lnlxpShJOBZJMhgjnRsdPyjJc+b2kV
         OFtGGT8AQFhbnTRdCSZcfbgnCm5I8I8oJ3zc6JztfneRNwmHt09lr23JM7K0AQSDR42g
         urJGSCM3LAnINZvo8tkTof85QwB3dL4J740Ftx5i3o9TXlpHZ6qH8Sz0oNLERa4Pxg0V
         9U4g==
X-Gm-Message-State: AO0yUKX6YHvZmvvi3dxInmXH6ECMXZA6CKL4Ht8HZ8HLmOPkKKpmq7ed
        beSt4x+aGUOV4vBEgLH0dCrnDC6xzex/Eg==
X-Google-Smtp-Source: AK7set93oMU0LZITgtxGMQpjErPHyrMlZcwSouYiQK1ie9TIpdUgjE8DLGrczDD0WwPXBC9cCeJxmQ==
X-Received: by 2002:a17:906:f8c2:b0:930:3916:df17 with SMTP id lh2-20020a170906f8c200b009303916df17mr11515224ejb.0.1679567639041;
        Thu, 23 Mar 2023 03:33:59 -0700 (PDT)
Received: from lelloman-5950.. (host-79-13-135-230.retail.telecomitalia.it. [79.13.135.230])
        by smtp.gmail.com with ESMTPSA id s15-20020a1709060c0f00b00928e0ea53e5sm8432687ejf.84.2023.03.23.03.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 03:33:58 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, surenb@google.com, brauner@kernel.org,
        chris@chrisdown.name, hannes@cmpxchg.org,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH v2 2/3] sched/psi: extract update_triggers side effect
Date:   Thu, 23 Mar 2023 11:33:49 +0100
Message-Id: <20230323103350.40569-3-cerasuolodomenico@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230323103350.40569-1-cerasuolodomenico@gmail.com>
References: <20230323103350.40569-1-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change moves update_total flag out of update_triggers function,
currently called only in psi_poll_work.
In the next patch, update_triggers will be called also in psi_avgs_work,
but the total update information is specific to psi_poll_work.
Returning update_total value to the caller let us avoid differentiating
the implementation of update_triggers for different aggregators.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
---
 kernel/sched/psi.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index fe9269f1d2a4..17d71ef07751 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -430,11 +430,11 @@ static u64 window_update(struct psi_window *win, u64 now, u64 value)
 	return growth;
 }
 
-static u64 update_triggers(struct psi_group *group, u64 now)
+static u64 update_triggers(struct psi_group *group, u64 now, bool *update_total)
 {
 	struct psi_trigger *t;
-	bool update_total = false;
 	u64 *total = group->total[PSI_POLL];
+	*update_total = false;
 
 	/*
 	 * On subsequent updates, calculate growth deltas and let
@@ -462,7 +462,7 @@ static u64 update_triggers(struct psi_group *group, u64 now)
 			 * been through all of them. Also remember to extend the
 			 * polling time if we see new stall activity.
 			 */
-			update_total = true;
+			*update_total = true;
 
 			/* Calculate growth since last update */
 			growth = window_update(&t->win, now, total[t->state]);
@@ -485,10 +485,6 @@ static u64 update_triggers(struct psi_group *group, u64 now)
 		t->pending_event = false;
 	}
 
-	if (update_total)
-		memcpy(group->polling_total, total,
-				sizeof(group->polling_total));
-
 	return now + group->poll_min_period;
 }
 
@@ -622,6 +618,7 @@ static void psi_poll_work(struct psi_group *group)
 {
 	bool force_reschedule = false;
 	u32 changed_states;
+	bool update_total;
 	u64 now;
 
 	mutex_lock(&group->trigger_lock);
@@ -686,8 +683,12 @@ static void psi_poll_work(struct psi_group *group)
 		goto out;
 	}
 
-	if (now >= group->polling_next_update)
-		group->polling_next_update = update_triggers(group, now);
+	if (now >= group->polling_next_update) {
+		group->polling_next_update = update_triggers(group, now, &update_total);
+		if (update_total)
+			memcpy(group->polling_total, group->total[PSI_POLL],
+				   sizeof(group->polling_total));
+	}
 
 	psi_schedule_poll_work(group,
 		nsecs_to_jiffies(group->polling_next_update - now) + 1,
-- 
2.34.1

