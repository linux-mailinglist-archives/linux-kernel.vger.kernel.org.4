Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FDF6CFDC5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjC3ILV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjC3ILK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:11:10 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377746584
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:11:09 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x3so73144625edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680163867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1vTstqwimUvhUc8A7ZyPgFdk3wEGUrShLMTBVm4/iM=;
        b=nJKqdkt+hoWAjnQAYIU68soq6JflYbpRbBqj6WzQKW+eECRAJd7mKJuqJ0QqvBKltX
         74HDjlAjZeV6yTpr5TUOTajqFg/iz4UR+oigZ3lP6vzEf6wKMUznDJj9mPDIGuOuwEBO
         lE+2UJM8Ji1Qx88LiG2KAWswV9adV1lVKq5Gv5uVM92sDm38EuRADDDADjveStMZAnJu
         X9xLXrZNi3n+zMWad730jIyqvQfo9fagha0GBwEBtd0OMc+THH8lV1GpWOILtIaIwPbh
         k++NSd86vxqgRXZqfZ0YK2xdV/brWex+rfaqwFRwUlMZxey57sP6kXYj9IG6OGOJOI+i
         UtqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680163867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1vTstqwimUvhUc8A7ZyPgFdk3wEGUrShLMTBVm4/iM=;
        b=cHPa3bx8Ule7v7lsWwwCP1v9PcP5Qi85GJnIpEOWH1NRDjetaODcm/mtHGjzZny8k3
         94qbMJE/vkUU7Vq5MNNF3VUmiir6S13QVUH5sz6TH5bHmdEAZmExrI/+ID+59V5lTQbV
         865J2E+j5FA0330jueBYvRAxv4EyChrBVezztBwpz2CDJU3VM5+ZSdOzf7ZqRgs24Y4j
         BpwzhdLh3QUYqLjPszgl7NfoeEmjxbjvGCy+s/bnR9iSB3edx9XPQRHVlBMdZd0LzRyp
         H6KB4rwzvqJXsUPmsL5fCf09EJksMsx0TaHZJzy75PZ9QwPca3ws0ZbjiX+WOpxAox8C
         WPBQ==
X-Gm-Message-State: AAQBX9elANILBvTHg/GtnDOu2YI5ry/PYxXDm9Yh3XbpLqXCJOThIS+8
        nwqgs2bOpAfzRl/82fM5Tp+luhYCOkhtJA==
X-Google-Smtp-Source: AKy350YfOOhQ7dYNYYoJkjgzWkQDV77mbCLU1TeKpq7FI3CmLd2Ido01tv35gM3TjnDIGznbY2vX3A==
X-Received: by 2002:a17:906:1e08:b0:93b:d1ee:5f41 with SMTP id g8-20020a1709061e0800b0093bd1ee5f41mr23306677ejj.31.1680163867180;
        Thu, 30 Mar 2023 01:11:07 -0700 (PDT)
Received: from lelloman-5950.. (host-80-182-134-1.pool80182.interbusiness.it. [80.182.134.1])
        by smtp.gmail.com with ESMTPSA id sd24-20020a170906ce3800b00931024e96c5sm17589672ejb.99.2023.03.30.01.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 01:11:06 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, surenb@google.com, brauner@kernel.org,
        chris@chrisdown.name, hannes@cmpxchg.org,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH v5 3/4] sched/psi: extract update_triggers side effect
Date:   Thu, 30 Mar 2023 10:10:59 +0200
Message-Id: <20230330081100.11871-4-cerasuolodomenico@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330081100.11871-1-cerasuolodomenico@gmail.com>
References: <20230330081100.11871-1-cerasuolodomenico@gmail.com>
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

