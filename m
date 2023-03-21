Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584216C270B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 02:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjCUBL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 21:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjCUBLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:11:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C893724729;
        Mon, 20 Mar 2023 18:10:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FC98B8107D;
        Tue, 21 Mar 2023 01:08:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255B8C4339E;
        Tue, 21 Mar 2023 01:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360903;
        bh=ORYn0hmLI/lHHRs2xTEScWQH353TgooExgMv39w2gTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KSu7D6iBO0wcHykfFXaUdQ46UmKYkDAxRY9FpkFSvWJpXPPtuN9YxebEtV6Wvz+VG
         cxJcjHS5v4ghf9ccVSV0LIv1h37FIuGL3WZnqdRXhxV/WxKjRuETrPCyWqkmQ+F01T
         /iRqTNwJX6hvBZbROOBLAEjFkmEkYKWXw7nsngEh4BmgyGPrR9u0HfQHZzMq5mL6Vk
         35GoplgqaEFzhMSOov+H4cIrWwnzIOgWj74kyOTrvYtx5ce6ALjrc1DZIpfcuQ4IUA
         MbomuVXCcVd5qzcTZRFpeLInG1T9SBKVaZvzsv+A3qYKKpComVDsXbTCtYo67tlklT
         pRp3PrrDo68sQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B6335154039C; Mon, 20 Mar 2023 18:08:22 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, John Stultz <jstultz@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        kernel-team@android.com, Connor O'Brien <connoro@google.com>
Subject: [PATCH locktorture 4/5] locktorture: With nested locks, occasionally skip main lock
Date:   Mon, 20 Mar 2023 18:08:20 -0700
Message-Id: <20230321010821.51601-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <3679d2b2-bdb9-4fa3-8134-240a8d0f449b@paulmck-laptop>
References: <3679d2b2-bdb9-4fa3-8134-240a8d0f449b@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Stultz <jstultz@google.com>

If we're using nested locking to stress things, occasionally
skip taking the main lock, so that we can get some different
contention patterns between the writers (to hopefully get two
disjoint blocked trees)

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: kernel-team@android.com
Co-developed-by: Connor O'Brien <connoro@google.com>
Signed-off-by: Connor O'Brien <connoro@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/locktorture.c | 37 ++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index c7f264aed5b7..9425aff08936 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -760,6 +760,7 @@ static int lock_torture_writer(void *arg)
 	int tid = lwsp - cxt.lwsa;
 	DEFINE_TORTURE_RANDOM(rand);
 	u32 lockset_mask;
+	bool skip_main_lock;
 
 	VERBOSE_TOROUT_STRING("lock_torture_writer task started");
 	set_user_nice(current, MAX_NICE);
@@ -769,21 +770,37 @@ static int lock_torture_writer(void *arg)
 			schedule_timeout_uninterruptible(1);
 
 		lockset_mask = torture_random(&rand);
+		/*
+		 * When using nested_locks, we want to occasionally
+		 * skip the main lock so we can avoid always serializing
+		 * the lock chains on that central lock. By skipping the
+		 * main lock occasionally, we can create different
+		 * contention patterns (allowing for multiple disjoint
+		 * blocked trees)
+		 */
+		skip_main_lock = (nested_locks &&
+				 !(torture_random(&rand) % 100));
+
 		cxt.cur_ops->task_boost(&rand);
 		if (cxt.cur_ops->nested_lock)
 			cxt.cur_ops->nested_lock(tid, lockset_mask);
-		cxt.cur_ops->writelock(tid);
-		if (WARN_ON_ONCE(lock_is_write_held))
-			lwsp->n_lock_fail++;
-		lock_is_write_held = true;
-		if (WARN_ON_ONCE(atomic_read(&lock_is_read_held)))
-			lwsp->n_lock_fail++; /* rare, but... */
 
-		lwsp->n_lock_acquired++;
+		if (!skip_main_lock) {
+			cxt.cur_ops->writelock(tid);
+			if (WARN_ON_ONCE(lock_is_write_held))
+				lwsp->n_lock_fail++;
+			lock_is_write_held = true;
+			if (WARN_ON_ONCE(atomic_read(&lock_is_read_held)))
+				lwsp->n_lock_fail++; /* rare, but... */
+
+			lwsp->n_lock_acquired++;
+		}
 		cxt.cur_ops->write_delay(&rand);
-		lock_is_write_held = false;
-		WRITE_ONCE(last_lock_release, jiffies);
-		cxt.cur_ops->writeunlock(tid);
+		if (!skip_main_lock) {
+			lock_is_write_held = false;
+			WRITE_ONCE(last_lock_release, jiffies);
+			cxt.cur_ops->writeunlock(tid);
+		}
 		if (cxt.cur_ops->nested_unlock)
 			cxt.cur_ops->nested_unlock(tid, lockset_mask);
 
-- 
2.40.0.rc2

