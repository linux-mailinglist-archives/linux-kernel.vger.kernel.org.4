Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D416D0233
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjC3KzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjC3Kyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:54:39 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7307A9B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 03:54:37 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h8so74754601ede.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 03:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680173676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1vTstqwimUvhUc8A7ZyPgFdk3wEGUrShLMTBVm4/iM=;
        b=SAhdUE8RtpQp3xboOBAvlJrDteDAvPjfKGtWDLGIdmtp9P7WRiag+VrAVmfymEHsE/
         o8E2OYYoSRb98hpU90/eNIl+MtzGq+fqSzOXEjNMx/LI2BCxISMoyd0bcD5HFsx2PjSj
         hhFc5Gfmm0gnuyBIBnhfyXkK1IRFjdcLMnIN9LHeucdUqINXnB9CTi6AON1QzPWwlVfY
         071VqgphGsCt6FvotWE751IidWNnh0Wglb2BOI8ivJ/gYA9FNtXvW1J8/ExgDCO3f580
         OzctikEjP0ldMyjBWHzCcrMtSzJTHL0hrAoVokxBLjUSBjaJpAuSNCyMjJ0wlLuzVZFG
         X9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680173676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1vTstqwimUvhUc8A7ZyPgFdk3wEGUrShLMTBVm4/iM=;
        b=xYFnnTCegyTZh9es6Nuc1w+x2Oftn2o2O3xpnkOsHVTqTZYLp2uMT8rVYeA0aJdjbJ
         NFxIaPpDg4qVbdnkQdrZBoAY8q3FCX6PylTA5EPRW1EZRpc0YEJ+rZBe8ns8i7edh/5m
         INXfyXPuVWbQO0W+VY7BvbIGt9rmUylWiV5CW3aOq+06Pq9daBA9EQJWaxWnaRYkXPQI
         uSSx7MT36FwAw/Aj4MUCVGd1BiMRSR1ovuiIEgKLoqGoVeazN6g9fa+fxruI/xhrqFi8
         Me9L7T4ocw9Vn/Q9+bW+bLvJ8LdE0KD0wasNTrX/FjSLLJHhPnHM5fbtGATBqZy7mVSv
         uG6w==
X-Gm-Message-State: AAQBX9don+pmXbWUABy/lhXfn4puV2rmQyGc3AvjuPhLMD2MGSd9e7ko
        8oJGeQyy82h7HIAdLygSnnrBvemwNpFaoA==
X-Google-Smtp-Source: AKy350Z4JY4tDfwJ5/I1Vn3RXg2v9830bDiL7NaWZMACTlXYdf7VdRuvLn+CpwJvTUYEGHvo0kaOHA==
X-Received: by 2002:a17:906:1cda:b0:920:3263:d643 with SMTP id i26-20020a1709061cda00b009203263d643mr20687377ejh.72.1680173676021;
        Thu, 30 Mar 2023 03:54:36 -0700 (PDT)
Received: from lelloman-5950.. (host-80-182-134-1.pool80182.interbusiness.it. [80.182.134.1])
        by smtp.gmail.com with ESMTPSA id hb6-20020a170906b88600b0093120a11a5dsm17639628ejb.92.2023.03.30.03.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 03:54:35 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, surenb@google.com, brauner@kernel.org,
        chris@chrisdown.name, hannes@cmpxchg.org,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH v6 3/4] sched/psi: extract update_triggers side effect
Date:   Thu, 30 Mar 2023 12:54:17 +0200
Message-Id: <20230330105418.77061-4-cerasuolodomenico@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330105418.77061-1-cerasuolodomenico@gmail.com>
References: <20230330105418.77061-1-cerasuolodomenico@gmail.com>
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
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 kernel/sched/psi.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index a3d0b5cf797a..f3df6a8ff493 100644
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
-		memcpy(group->rtpoll_total, total,
-				sizeof(group->rtpoll_total));
-
 	return now + group->rtpoll_min_period;
 }
 
@@ -622,6 +618,7 @@ static void psi_rtpoll_work(struct psi_group *group)
 {
 	bool force_reschedule = false;
 	u32 changed_states;
+	bool update_total;
 	u64 now;
 
 	mutex_lock(&group->rtpoll_trigger_lock);
@@ -686,8 +683,12 @@ static void psi_rtpoll_work(struct psi_group *group)
 		goto out;
 	}
 
-	if (now >= group->rtpoll_next_update)
-		group->rtpoll_next_update = update_triggers(group, now);
+	if (now >= group->rtpoll_next_update) {
+		group->rtpoll_next_update = update_triggers(group, now, &update_total);
+		if (update_total)
+			memcpy(group->rtpoll_total, group->total[PSI_POLL],
+				   sizeof(group->rtpoll_total));
+	}
 
 	psi_schedule_rtpoll_work(group,
 		nsecs_to_jiffies(group->rtpoll_next_update - now) + 1,
-- 
2.34.1

