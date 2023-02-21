Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9A069E7FB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 20:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjBUTDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 14:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjBUTCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 14:02:52 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4C4DC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 11:02:48 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536bf635080so43999207b3.23
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 11:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DqmNrLVmJBftM1yoPM/PSlPmkh/mDl2swNT+iqdeHDo=;
        b=Q4j2nMBXUKKLmBRvTfp0HrFhmn7yV4Ga7xgMIUOjN4sPurLnmgrZAET75ngq+zcDqU
         nTdkChOjaWLBQu4/IvY9A4afYsRcyrq77u8X2d58PaoCsfJ/jwvM5EuT+btFvc6EP95e
         zHZPlpdfTjjs3V2sXm5OjFqhxCENOM9jIm01smePUIAejPypPof7i96+nzM+h3GzErgy
         wXdJFS5CsZDhDKkSqf4ZrnOMhcFNppwF2Li7jc5SBOVsrV54Co5wyyMMtb5FMC6apPTR
         QCc+ka1E30I6MZmpGDXgIi8Tao5UxyAkIPgLiztFL4LnBvpd/WNAPdK/WXWMyarghhU4
         m1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DqmNrLVmJBftM1yoPM/PSlPmkh/mDl2swNT+iqdeHDo=;
        b=G+6Mkc5zt6d9KYUbmFHp9yIAQKm4No/moN3dMGjHUoF+NryqLXtUcPaWaWUuM8Srd5
         KQOnYyTjGHWplAe+MsIdkbOni/aHlj3PSV3VUHWl5rlNA4LVDaW6nsnrWiQbIi89AFus
         AZBvSyfdWp8+dJTubDrOvbaIJ7I1dRBFZINDuyfU1n9+K0znEjRfgg5krAfqv76oYuzW
         K6+OchNanUDNDxfbFvzBCf5LdSOj2vy5AKBCw/oWcHLY83RQn5Pu9zglBDs0rK/2Isyt
         aSFtPp85yrvYyltoSPYojiQ0D5CW26X+NYHWOcixtRvB60FxOiLAAYcUg3kc89V7/6X8
         s+XA==
X-Gm-Message-State: AO0yUKVmjX9zffSEZDyxBLXneUci2ae3pkIgoEi4IERgMXT17ushMrBU
        GVHpqrKPXeIsKjYSw6pPlCvG0iS80do3zn/2HHEDT2oZID2V/Ihg0iAQYb3EBmEw0Qs0JwT+kvi
        /iwtmTDz3uzgyb0mvzxuMlaoyzF/M3qeAMZPuL7PTSw4AZLRyGRI4OJIiS+z0krVouIdyMVU=
X-Google-Smtp-Source: AK7set9vXFw3+hWFXtvfBD5WOvnx7hmKn1MkeXUsIDu6AH4ZBUiPiaK9s/o2LJcBJNifdbN5W17npIBqFX4F
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a81:a24d:0:b0:536:ff56:531a with SMTP id
 z13-20020a81a24d000000b00536ff56531amr46299ywg.544.1677006167995; Tue, 21 Feb
 2023 11:02:47 -0800 (PST)
Date:   Tue, 21 Feb 2023 19:02:38 +0000
In-Reply-To: <20230221190238.21285-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230221190238.21285-1-jstultz@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230221190238.21285-4-jstultz@google.com>
Subject: [PATCH v4 4/4] locktorture: With nested locks, occasionally skip main lock
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        kernel-team@android.com, "Connor O'Brien" <connoro@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
v3:
* Minor rework for naming changes suggested by Davidlohr Bueso
* Added comment explaining why we skip the main lock, as
  suggested by Davidlohr Bueso
v4:
* Add co-developed tag
---
 kernel/locking/locktorture.c | 37 ++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index fd8b2b007c26..ab896cc42b87 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -745,6 +745,7 @@ static int lock_torture_writer(void *arg)
 	int tid = lwsp - cxt.lwsa;
 	DEFINE_TORTURE_RANDOM(rand);
 	u32 lockset_mask;
+	bool skip_main_lock;
 
 	VERBOSE_TOROUT_STRING("lock_torture_writer task started");
 	set_user_nice(current, MAX_NICE);
@@ -754,21 +755,37 @@ static int lock_torture_writer(void *arg)
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
2.39.2.637.g21b0678d19-goog

