Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49023720BA5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 00:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236638AbjFBWCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 18:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236081AbjFBWCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 18:02:34 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2BD1BB
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 15:02:33 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5692be06cb2so30399297b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 15:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685743352; x=1688335352;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AVjM9PUczt0nDjxkij5BkD4dd+zhr4U2nnWMZn0A5Bw=;
        b=uBcG8llgLyXLJw3VLTL2Bvns2D7YVia5ndNhO91QH45R2xx9A7wVa7TVzRK04hCFKY
         YgokuKsEowAw5IW8mQSmHB/Lfm0T4TBvTbjIvN48mtSm4GhFn2hkUtTCM4EJOdqwmbrC
         eUp+OKo3kgnmm/DvcpebDqUwCsaFoOetIVkso9ewvcq1NSdnfXh/DvvJKJZ/3QN4nbdp
         qYTqhW5lhY+yoh90KVXZy9EyYTwluoYtjB7nFtqGtH24YIRMLD+CesTo9Scb1qVUAlJ1
         gzSKCFVm+64JaSQGP60YFnb5tHWKzMVh1o5nGigrGm5M0Pgn0ICdiBZ5FNAPuPS/5P8O
         EXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685743352; x=1688335352;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AVjM9PUczt0nDjxkij5BkD4dd+zhr4U2nnWMZn0A5Bw=;
        b=UgSAIyF7EdlN7lIOp/feLGO7I/JgxFU3RnzLm0nZZMLVJM0K/vmW/ZpDiYkOf3mjn1
         3EPaHUJa6cat0H67fmKT8mPT0yoIoFXD7WYcjCJ37qKpV8e8fAz98Gorw8Uau02GTJNs
         MF6XShb3ukIYv9W9xbG46vKn/Q73pkoDap5zYNm5ON/DYgTYIsU7MWDQh8apLi/DPJBw
         qScNvdAXsorZX0wY82vEnKHjIcbv9oacsNmFrzouz196e8UCnv1XyMOHjejgKpcBEHm9
         acXfw3uM5+9YkaANyOfelSaEWwQl1Qukz0m9CvewCzlTtyp3PwpR3QVrTTEYpDHkANrA
         OB2w==
X-Gm-Message-State: AC+VfDzR8uFV+uka4tRxhp8VXThAJcO+Ur5aHA7VFlUXrYkMSl19bHrR
        veulrJKm8Jfau2CXvfqpwI4F2sBRTD7HZAOeGIZ3X+h1unprmAmmjTHsTlGm0so/2OPBiRuhaDi
        zrOtCiBiYfN459Hl4HSSCDlxCHNw9jhq8rMqk4cyFKM/W4tJP1xgY0hF+HAVE2gkwmLE5cNo=
X-Google-Smtp-Source: ACHHUZ68pc0wl9b8ZbJYmzSvYJXocG8Rf5OTackLFz2UYKGQ5AD89Am+UfTuQDbFinmWGjWN6FUfdBg09buE
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a81:ac06:0:b0:561:8e86:9818 with SMTP id
 k6-20020a81ac06000000b005618e869818mr540804ywh.7.1685743352408; Fri, 02 Jun
 2023 15:02:32 -0700 (PDT)
Date:   Fri,  2 Jun 2023 22:02:09 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <20230602220221.600774-1-jstultz@google.com>
Subject: [PATCH 1/2] torture: Support randomized shuffling for proxy exec testing
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Connor O'Brien" <connoro@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        kernel-team@android.com, John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Connor O'Brien <connoro@google.com>

Currently shuffling sets the same cpu affinities for all tasks,
which makes us less likely to hit paths involving migrating
blocked tasks onto a cpu where they can't run.

This patch adds an element of randomness to allow affinities of
different writer tasks to diverge.

This has helped uncover issues in testing with Proxy Execution

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: kernel-team@android.com
Signed-off-by: Connor O'Brien <connoro@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/torture.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index 1a0519b836ac..8be83fdc6be1 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -54,6 +54,9 @@ module_param(verbose_sleep_frequency, int, 0444);
 static int verbose_sleep_duration = 1;
 module_param(verbose_sleep_duration, int, 0444);
 
+static int random_shuffle;
+module_param(random_shuffle, int, 0444);
+
 static char *torture_type;
 static int verbose;
 
@@ -518,6 +521,7 @@ static void torture_shuffle_task_unregister_all(void)
  */
 static void torture_shuffle_tasks(void)
 {
+	DEFINE_TORTURE_RANDOM(rand);
 	struct shuffle_task *stp;
 
 	cpumask_setall(shuffle_tmp_mask);
@@ -537,8 +541,10 @@ static void torture_shuffle_tasks(void)
 		cpumask_clear_cpu(shuffle_idle_cpu, shuffle_tmp_mask);
 
 	mutex_lock(&shuffle_task_mutex);
-	list_for_each_entry(stp, &shuffle_task_list, st_l)
-		set_cpus_allowed_ptr(stp->st_t, shuffle_tmp_mask);
+	list_for_each_entry(stp, &shuffle_task_list, st_l) {
+		if (!random_shuffle || torture_random(&rand) & 0x1)
+			set_cpus_allowed_ptr(stp->st_t, shuffle_tmp_mask);
+	}
 	mutex_unlock(&shuffle_task_mutex);
 
 	cpus_read_unlock();
-- 
2.41.0.rc2.161.g9c6817b8e7-goog

