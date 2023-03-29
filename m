Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A53B6CED01
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjC2Pd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjC2Pdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:33:43 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C292B101
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 08:33:36 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ew6so64921287edb.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 08:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680104015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGGlb2745yxdkPMgr58M3JFNd1mBkXZRVV0HG70eWBQ=;
        b=Nx+s+uU+6QMulxybZtm8C/77FYeBzRpE1hztS7IJ2L2udTwU8UEGovabFRLAG9/4wt
         I0M2gCGNgND9zwstbITdZlOZafGL8jYbQdt2zbHjg5OMIev4NUEOcumgIGsYea5u/itb
         YOjldUkyDn5m0tll11aTzCoG8FKeUoF1BY9CKIsGl6Gm2VfZjWghotwX2apEEYKoEhLZ
         QMNd1f+HKCuZa+wWcJVselSM1I+3FxGIIxLw3O/SveuRSX84diw5DnYuwt+W3qMwY/W7
         +hbteaGGTGBVej6YDew4vNRTH/NEcKYX1k+Wb3xbe2LnI0wPSCJHw3MwmTIdhsPXtbAw
         FKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680104015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGGlb2745yxdkPMgr58M3JFNd1mBkXZRVV0HG70eWBQ=;
        b=7qNDlFKXsIgMZgtF8RGOKi94tRAzkZ61dmvZisU4VDz6ppEsJ56KDOBQfSTEPj8NLW
         j9a0W6qLgE+KEiuMaHy76x3wCi5FKm2UXGP7U3Azg9xQn9kv1FFD/GPdyp0caYzlIKjl
         JltPwqUbbY7rdjHu0aD+GxADXIDrUy/BR0Vhqvch8xImgXRXDptiI7OomKwoqwYYEch6
         mSTeaQDx5dRtNHmWLAyfUK3m3v6O7hNM849UkidQBj+jciVxkYbsdQnlWY6MAcmCK3WY
         w7vEc5mTSrFL8O/ZTjPgBTE9K8YILFanhXwLOJZ0jY5rcSlFVVKNf7f3W2D6HBOMsImK
         1ZEA==
X-Gm-Message-State: AAQBX9cRda8OkWtKoxRi9tXSuXtYil3WMx+cHUS4UCue3oDx/i3O0NKO
        XsMgEhqWwK0cQ5Xpat5C4VJR4EMQPJg6UhOr
X-Google-Smtp-Source: AKy350a0dhlWODqhuODrFcXbPNgXiFuiYa32DEZesXgv6GSTkMRnnAV0a1F2XslHtMo2V9zzvdCu+A==
X-Received: by 2002:a17:907:6d0c:b0:944:18e0:6ef2 with SMTP id sa12-20020a1709076d0c00b0094418e06ef2mr15946875ejc.73.1680104014707;
        Wed, 29 Mar 2023 08:33:34 -0700 (PDT)
Received: from lelloman-5950.. (host-79-13-135-230.retail.telecomitalia.it. [79.13.135.230])
        by smtp.gmail.com with ESMTPSA id g10-20020a17090670ca00b0093b8c0952e4sm10193735ejk.219.2023.03.29.08.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 08:33:34 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, surenb@google.com, brauner@kernel.org,
        chris@chrisdown.name, hannes@cmpxchg.org,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH v4 3/4] sched/psi: extract update_triggers side effect
Date:   Wed, 29 Mar 2023 17:33:26 +0200
Message-Id: <20230329153327.140215-4-cerasuolodomenico@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230329153327.140215-1-cerasuolodomenico@gmail.com>
References: <20230329153327.140215-1-cerasuolodomenico@gmail.com>
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

