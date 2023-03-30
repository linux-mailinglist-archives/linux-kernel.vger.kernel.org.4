Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B52C6D0FB3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 22:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjC3UGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 16:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjC3UGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 16:06:42 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D388310429
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 13:06:26 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id ew6so81125913edb.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 13:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680206785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1vTstqwimUvhUc8A7ZyPgFdk3wEGUrShLMTBVm4/iM=;
        b=QIwwRr3lPxhfPEaXuJDlemsrxwiiDdu0W6jvdcUwhEvIbIwRjQeGlItXcaCFLC1KhX
         SVvvPsxUo3gAICj2U+YhzScry6w9RjDHUgm2MLwKqGXmYkvIBwX1hUfD5eq/UlTeoY9X
         9j3/G14YOKZNLbMtyJNPDUkMxKs9FL48B8WlpFJGkuMWxd6neNJ8y7hpFVVEzFwKAb0K
         rQzKrtANkzlB8gMcS3PitHgTh8pMwnP/aOwVXvgjdlbrYKSK08Qv/t2iv3wjdKL32p/H
         yB/CaOO08C2kS4zpf6O2UvCtkFye+tvvK9F2uXe6xK09rY/SbZp6P1mRW6QZx0hyjTkY
         j5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680206785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1vTstqwimUvhUc8A7ZyPgFdk3wEGUrShLMTBVm4/iM=;
        b=m5m+pWFJHvX3gfefl7tu1sjvyLczcCjIzR+4VvdpMc0Wdldssm728BsET9jAKSb4yr
         +4on0OsVyndMEUjqZhc00T1K1XHv4E5YcVBP+1W0bFrxPzUarTFOepuQR5tq9vJMAbK/
         UhDyaxcpuIeWLAQtWMxm7rXgjVpr2DZ537r2yBowt6FD/fFLJmEeDztV7T0erGanGTL/
         VpWyxHIFUb6Hk6yfvo4lUVVJaHcklL9WWiI/+M0he/T3/j4k88rEIqLnoOK/EcNFzTkU
         yqJ7/6VrKwTaHgUu5Fhqr2SXI8XFEzK6VziyMQTHiBeFaFg0VIi10k+Mvup4qWPuvr8n
         G92A==
X-Gm-Message-State: AAQBX9c2Z9fhBBWHaD7a2wK7m5+nKZTwbBMLqURkv638ASXotP68F9uG
        S6Py+kzFENTUOQ3iRvGsJhQF2fCj1Fldzw==
X-Google-Smtp-Source: AKy350bHDVMfIZxlHCM+vJvZ/g64N+jJqV3jNeICi1HtrRjZR/xS39AKmfjZG7+9HhUyeYfEJPun4g==
X-Received: by 2002:a17:906:d1cf:b0:8b1:7aaa:4c25 with SMTP id bs15-20020a170906d1cf00b008b17aaa4c25mr26620215ejb.29.1680206784945;
        Thu, 30 Mar 2023 13:06:24 -0700 (PDT)
Received: from lelloman-5950.. (host-80-182-134-1.retail.telecomitalia.it. [80.182.134.1])
        by smtp.gmail.com with ESMTPSA id g17-20020a1709064e5100b009312cc428e4sm161101ejw.165.2023.03.30.13.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 13:06:24 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, surenb@google.com, brauner@kernel.org,
        chris@chrisdown.name, hannes@cmpxchg.org,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH v7 3/4] sched/psi: extract update_triggers side effect
Date:   Thu, 30 Mar 2023 22:06:13 +0200
Message-Id: <20230330200614.132354-4-cerasuolodomenico@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330200614.132354-1-cerasuolodomenico@gmail.com>
References: <20230330200614.132354-1-cerasuolodomenico@gmail.com>
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

