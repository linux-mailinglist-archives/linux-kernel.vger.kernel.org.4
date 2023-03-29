Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739296CD3A7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjC2Htc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjC2HtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:49:11 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4130140EF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 00:48:53 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id b20so59724080edd.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 00:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680076131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGGlb2745yxdkPMgr58M3JFNd1mBkXZRVV0HG70eWBQ=;
        b=Mj8nPkJrZody38ecyIIvnxELqQKI5NVh7TMcBThhNcnKS93LOhGm7UvbyMRn6gd0RD
         70Jwvz6etfPtO3Nc99xZI/v8r1e9obHfathR0VE5n+Klh+7IKA0LzfMcc4Mfu3CJZ97G
         JXmk2iAz52DIpIKObLxsicmnvRmkiRTZuTv5qTqLtQUfO8zpTwGv+LWewf4DAldNxUEA
         /xIRPgOy4HhgPPzKDekpC85UgIVq7CoQCY2iLw7BQeaLC2yAoCHILZkOJZ5pBwm7Xvvk
         LwfCeG9Xuy9POqjSEuUFyNmKGzd/3zyQZm8kiFpDFlY+IQlBj/vGtC6WAr2XzMosMASi
         DcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680076131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGGlb2745yxdkPMgr58M3JFNd1mBkXZRVV0HG70eWBQ=;
        b=ErY65UR1UC2qFOjOa/D9mYoz8HPZSQxxaHHRCS3XFgTlNgpa2exMb04oxxGKNoDiaz
         yW+y3syo6iXrz88HcfMwiye19KStIDyKc+ayYnfr0Wq2ixzdzoEHGlOKb+19S2mj/Rcv
         rdTbdVCGJBdpEJGKxUqSyFX1elQ0ZhM3v8vb/IDRpjHmsjG0FtYRb8v8wORs11B+Mt9b
         2RMUVEG1Q1GdqZ06qQ9zGoT3EaF2XSbMxBkh0I2wQf2/y3LSiTSFA4WW0XPfDtGghTQ/
         0nOPHtsa10lKZgbKS1VvApYC397bn8sKJVzbGdlxeogXbSf5HhbjFxKIJut253pjYOH7
         1WVA==
X-Gm-Message-State: AAQBX9evlLkQ9uiXnU2aTZnx3IwllopkVYxU6w+XxKRgXCcEz3bfpQO6
        mx/4HnIugPW3Qkt9BGnZ7gM8CmFP1G12687M
X-Google-Smtp-Source: AKy350Zj6NEe+h9y3W95jt7w+CeE8os7f1Xfjj077KBUghne/+W1/qVvxEGuaiNTeMNFROwA+pr7Rg==
X-Received: by 2002:a17:906:845c:b0:93c:efaf:ba75 with SMTP id e28-20020a170906845c00b0093cefafba75mr16223190ejy.37.1680076131282;
        Wed, 29 Mar 2023 00:48:51 -0700 (PDT)
Received: from lelloman-5950.. (host-79-13-135-230.retail.telecomitalia.it. [79.13.135.230])
        by smtp.gmail.com with ESMTPSA id r12-20020a50c00c000000b00501d2f10d19sm12208300edb.20.2023.03.29.00.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 00:48:50 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, surenb@google.com, brauner@kernel.org,
        chris@chrisdown.name, hannes@cmpxchg.org,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH v3 3/4] sched/psi: extract update_triggers side effect
Date:   Wed, 29 Mar 2023 09:48:41 +0200
Message-Id: <20230329074842.16209-4-cerasuolodomenico@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230329074842.16209-1-cerasuolodomenico@gmail.com>
References: <20230329074842.16209-1-cerasuolodomenico@gmail.com>
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

