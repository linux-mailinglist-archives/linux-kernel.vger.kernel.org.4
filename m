Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DEF5F3809
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 23:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiJCVqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 17:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiJCVqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 17:46:02 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B0A20BF5
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 14:45:24 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id y16-20020a17090aa41000b001fdf0a76a4eso5057821pjp.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 14:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=wyqNJEpK8hc99eBxWvCga97s0cP9TToGQQczW693ZQg=;
        b=h8czXoK277slpGQf+bpvwfua+gFDF9NUzYgIFFOEfmpYpF8o1tAD/fMdDL7197AECO
         THvbVgyzmJynlB+rrpjAGhEKfhe9Bw6gD9Bks5W4EOOOf7EUMA0tzBUKiVJJcfxtM7K6
         rCMsuJYVKVVK9jAheJWA6FGDLIkABfqtfuPv4ibUAjr+aSQFC/wyp99fSj+1FtrsKm5I
         0FhQMMQI8gPFhzdO54qaj6Nh0pMyr58ioMFEGdDYOkDOvXqIX6zA3prnyeKAlivv9XsC
         iBHQ4EP3+NwiGdGBfj3mb+s4fc1mi6HjC8UTwx9MVWitByDPwAO7pyRcSDtIHDY2B3q0
         c2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=wyqNJEpK8hc99eBxWvCga97s0cP9TToGQQczW693ZQg=;
        b=AguMcZvXvwNTog+HQhwEZ6KyBp40cF+mQOsB6RmO677bcjQFemtxmFQgMPpUOlzjEX
         MKZH6d1OjDObrXTqxouIdJ7Q+dGEGFPhMHzvuxWpFJUbY/bYDgeTfqibp9L1GX8A2Pej
         M5uq7/20gPBLolC2uDloVlMNCSxLlIpVEaiqLZjs3twr9ZgQAjDZpWwoFshcvmsH9/+E
         Axz69ABW6pALaLCAuteeTRmYTgiwAb1+iP/T5FM2JhZWjEk4czQMadCM6EOEDVKVnmTE
         4lbKO8sfZpBAvES0FeERZa1Giaq9yu6m2GWMdfAf+SfQEFKh4S/gAxx+aMgtn2D6fb8E
         GO6Q==
X-Gm-Message-State: ACrzQf1OHebBDM6pXI/wYOu9aB7ckO/z4BuKlaVbtznTdeZf7Sjx6w//
        C6QWJ/YzDAlTp51mNSJGm6LcKRfkfaUKlLXH3LijPOTlBKKmvnxSyn4pKR3RENOZ2JiMxVjRIbc
        hjhTgpaj0LPlgQ57hEPNv2c7I+BclWAkfy0u1raFAMkJjfWhwQ9qClBjLy8sthq2KIe0ug48I
X-Google-Smtp-Source: AMsMyM4btjRP5nxnP96+XjlgNpxrr4Brvn4C5nCpYv1pEtkw8lHkLuZn9LJAO50hz9iyuzqpA1Qd00v0wzqq
X-Received: from connoro.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:a99])
 (user=connoro job=sendgmr) by 2002:a17:90b:3ec9:b0:205:cc2d:7fb6 with SMTP id
 rm9-20020a17090b3ec900b00205cc2d7fb6mr13833913pjb.142.1664833523279; Mon, 03
 Oct 2022 14:45:23 -0700 (PDT)
Date:   Mon,  3 Oct 2022 21:45:01 +0000
In-Reply-To: <20221003214501.2050087-1-connoro@google.com>
Mime-Version: 1.0
References: <20221003214501.2050087-1-connoro@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221003214501.2050087-12-connoro@google.com>
Subject: [RFC PATCH 11/11] locktorture: support nested mutexes
From:   "Connor O'Brien" <connoro@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Connor O'Brien" <connoro@google.com>
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

Quick hack to better surface bugs in proxy execution.

The single lock used by locktorture does not reliably exercise proxy
exec code paths for handling chains of blocked tasks involving >1
mutex. Add 2 more mutexes and randomize whether they are taken.

Signed-off-by: Connor O'Brien <connoro@google.com>
---
 kernel/locking/locktorture.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 9c2fb613a55d..bc3557677eed 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -48,6 +48,8 @@ torture_param(int, stat_interval, 60,
 torture_param(int, stutter, 5, "Number of jiffies to run/halt test, 0=disable");
 torture_param(int, verbose, 1,
 	     "Enable verbose debugging printk()s");
+torture_param(int, nlocks, 1,
+	      "Number of locks");
 
 static char *torture_type = "spin_lock";
 module_param(torture_type, charp, 0444);
@@ -327,6 +329,8 @@ static struct lock_torture_ops rw_lock_irq_ops = {
 };
 
 static DEFINE_MUTEX(torture_mutex);
+static DEFINE_MUTEX(torture_mutex2);
+static DEFINE_MUTEX(torture_mutex3);
 
 static int torture_mutex_lock(int tid __maybe_unused)
 __acquires(torture_mutex)
@@ -666,6 +670,7 @@ static struct lock_torture_ops percpu_rwsem_lock_ops = {
  */
 static int lock_torture_writer(void *arg)
 {
+	bool twolocks = false, threelocks = false;
 	struct lock_stress_stats *lwsp = arg;
 	int tid = lwsp - cxt.lwsa;
 	DEFINE_TORTURE_RANDOM(rand);
@@ -677,6 +682,12 @@ static int lock_torture_writer(void *arg)
 		if ((torture_random(&rand) & 0xfffff) == 0)
 			schedule_timeout_uninterruptible(1);
 
+		twolocks = nlocks > 1 ? (torture_random(&rand) & 0x1) : 0;
+		if (twolocks)
+			mutex_lock(&torture_mutex2);
+		threelocks = nlocks > 2 ? (torture_random(&rand) & 0x2) : 0;
+		if (threelocks)
+			mutex_lock(&torture_mutex3);
 		cxt.cur_ops->task_boost(&rand);
 		cxt.cur_ops->writelock(tid);
 		if (WARN_ON_ONCE(lock_is_write_held))
@@ -691,6 +702,11 @@ static int lock_torture_writer(void *arg)
 		WRITE_ONCE(last_lock_release, jiffies);
 		cxt.cur_ops->writeunlock(tid);
 
+		if (threelocks)
+			mutex_unlock(&torture_mutex3);
+		if (twolocks)
+			mutex_unlock(&torture_mutex2);
+
 		stutter_wait("lock_torture_writer");
 	} while (!torture_must_stop());
 
@@ -830,11 +846,11 @@ lock_torture_print_module_parms(struct lock_torture_ops *cur_ops,
 				const char *tag)
 {
 	pr_alert("%s" TORTURE_FLAG
-		 "--- %s%s: nwriters_stress=%d nreaders_stress=%d stat_interval=%d verbose=%d shuffle_interval=%d stutter=%d shutdown_secs=%d onoff_interval=%d onoff_holdoff=%d\n",
+		 "--- %s%s: nwriters_stress=%d nreaders_stress=%d stat_interval=%d verbose=%d shuffle_interval=%d stutter=%d shutdown_secs=%d onoff_interval=%d onoff_holdoff=%d nlocks=%d\n",
 		 torture_type, tag, cxt.debug_lock ? " [debug]": "",
 		 cxt.nrealwriters_stress, cxt.nrealreaders_stress, stat_interval,
 		 verbose, shuffle_interval, stutter, shutdown_secs,
-		 onoff_interval, onoff_holdoff);
+		 onoff_interval, onoff_holdoff, nlocks);
 }
 
 static void lock_torture_cleanup(void)
-- 
2.38.0.rc1.362.ged0d419d3c-goog

