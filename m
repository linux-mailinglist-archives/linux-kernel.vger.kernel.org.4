Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BF266D5BD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 06:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbjAQFyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 00:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbjAQFyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 00:54:07 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0186B222D3;
        Mon, 16 Jan 2023 21:54:05 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id x4so18465245pfj.1;
        Mon, 16 Jan 2023 21:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ErCs8xKixr0TtfZpav6tzyRAe7m6gIT7Rr5YvISmiQ=;
        b=VEaMuBhHAfXgeFxeZ0fquPaXPJQIuvZ6Fffs/VyL4NX0GISZAxX6T3le3NmAePugcH
         KYHR63ZbcWLoAcSR7ejDrBWiaNaM2UhA2j+bV2gahTAzF3JxuoMVVpITCIyxjz4Q86yM
         sVNabr23ZIQceefmF9XbZR1iTRDQ0KWyBN2rrdOmZWijW9MkHtNRevJVcl8TZKWc8WFD
         17S0HXkiInMhpXNPs1aIc5o3ZtELWpSNzRX4DbODEzY5Xb1uhhRpyVV8oWT61+PN3eM/
         PzNst+tsQ5s8lfxa2336tDxMScod9aKY3ESyjvv73L/15uKLBNwQvZ6/NhH0oUXJ6knl
         xISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ErCs8xKixr0TtfZpav6tzyRAe7m6gIT7Rr5YvISmiQ=;
        b=p7D7v2fpySF6w6zaydA6FEUdmcPg8iuyD/I3KGjTRjtkfB2vm3Dx5MaQnJ9/FMiQaH
         vUvlFcVznyXJGyVHqbxgSb9bDu7v6m4EF6EI1q4cQOqLPHerX3uliqbpNtac1J09M0Oa
         ziQojkxUVM0VRK24ep5CFHeOLuIttYU5KlQaSJX3l+9I9kHUWM0/2nQXTTxa5JXLpyA0
         aMB1nAekGH9C6EVuVoh7H7LUeuJPogSwMA9UAJTCysHz/M0weHDuomftzs2/RTsS2001
         QAYHcjxbfkiQ4K8T25rue7fqe3vItcmn71dqlOgfGeRe8UHc2WEHTzqOplcakpGBlgnl
         z3mw==
X-Gm-Message-State: AFqh2kqppKAdXZpiK7heOA75vtWJfKdc28sW9xXKmHEs3GqIoGAAlU+K
        4NAbERSgB2+utcsH0pFmCHkzPAR3BE8=
X-Google-Smtp-Source: AMrXdXt9HMOjQBNQ3vyngzhjY1ZE9mekFrHdsIcJLgZ3tGHBxf9QelqkGgv6amQNNZwPfwijDREe6g==
X-Received: by 2002:a62:1ac9:0:b0:57a:7b74:4ec5 with SMTP id a192-20020a621ac9000000b0057a7b744ec5mr2337657pfa.13.1673934845346;
        Mon, 16 Jan 2023 21:54:05 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id z13-20020aa79e4d000000b0058bc1a13ffcsm5763856pfq.25.2023.01.16.21.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 21:54:04 -0800 (PST)
From:   Yue Hu <zbestahu@gmail.com>
To:     rcu@vger.kernel.org, paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, zhangwen@coolpad.com,
        Yue Hu <huyue2@coolpad.com>
Subject: [PATCH] rcu/rcutorture: Eliminate variable n_rcu_torture_boost_rterror
Date:   Tue, 17 Jan 2023 13:53:10 +0800
Message-Id: <20230117055310.3408-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@coolpad.com>

After commit 8b700983de82 ("sched: Remove sched_set_*() return value"),
this variable is not used anymore. So eliminate it entirely.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 kernel/rcu/rcutorture.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 634df26a2c27..327c8fbb7e00 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -179,7 +179,6 @@ static atomic_t n_rcu_torture_mbchk_tries;
 static atomic_t n_rcu_torture_error;
 static long n_rcu_torture_barrier_error;
 static long n_rcu_torture_boost_ktrerror;
-static long n_rcu_torture_boost_rterror;
 static long n_rcu_torture_boost_failure;
 static long n_rcu_torture_boosts;
 static atomic_long_t n_rcu_torture_timers;
@@ -2194,12 +2193,11 @@ rcu_torture_stats_print(void)
 		atomic_read(&n_rcu_torture_alloc),
 		atomic_read(&n_rcu_torture_alloc_fail),
 		atomic_read(&n_rcu_torture_free));
-	pr_cont("rtmbe: %d rtmbkf: %d/%d rtbe: %ld rtbke: %ld rtbre: %ld ",
+	pr_cont("rtmbe: %d rtmbkf: %d/%d rtbe: %ld rtbke: %ld ",
 		atomic_read(&n_rcu_torture_mberror),
 		atomic_read(&n_rcu_torture_mbchk_fail), atomic_read(&n_rcu_torture_mbchk_tries),
 		n_rcu_torture_barrier_error,
-		n_rcu_torture_boost_ktrerror,
-		n_rcu_torture_boost_rterror);
+		n_rcu_torture_boost_ktrerror);
 	pr_cont("rtbf: %ld rtb: %ld nt: %ld ",
 		n_rcu_torture_boost_failure,
 		n_rcu_torture_boosts,
@@ -2217,15 +2215,13 @@ rcu_torture_stats_print(void)
 	if (atomic_read(&n_rcu_torture_mberror) ||
 	    atomic_read(&n_rcu_torture_mbchk_fail) ||
 	    n_rcu_torture_barrier_error || n_rcu_torture_boost_ktrerror ||
-	    n_rcu_torture_boost_rterror || n_rcu_torture_boost_failure ||
-	    i > 1) {
+	    n_rcu_torture_boost_failure || i > 1) {
 		pr_cont("%s", "!!! ");
 		atomic_inc(&n_rcu_torture_error);
 		WARN_ON_ONCE(atomic_read(&n_rcu_torture_mberror));
 		WARN_ON_ONCE(atomic_read(&n_rcu_torture_mbchk_fail));
 		WARN_ON_ONCE(n_rcu_torture_barrier_error);  // rcu_barrier()
 		WARN_ON_ONCE(n_rcu_torture_boost_ktrerror); // no boost kthread
-		WARN_ON_ONCE(n_rcu_torture_boost_rterror); // can't set RT prio
 		WARN_ON_ONCE(n_rcu_torture_boost_failure); // boost failed (TIMER_SOFTIRQ RT prio?)
 		WARN_ON_ONCE(i > 1); // Too-short grace period
 	}
@@ -3540,7 +3536,6 @@ rcu_torture_init(void)
 	atomic_set(&n_rcu_torture_error, 0);
 	n_rcu_torture_barrier_error = 0;
 	n_rcu_torture_boost_ktrerror = 0;
-	n_rcu_torture_boost_rterror = 0;
 	n_rcu_torture_boost_failure = 0;
 	n_rcu_torture_boosts = 0;
 	for (i = 0; i < RCU_TORTURE_PIPE_LEN + 1; i++)
-- 
2.17.1

