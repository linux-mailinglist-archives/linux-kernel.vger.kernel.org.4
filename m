Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B006CB446
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 04:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjC1CtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 22:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjC1CtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 22:49:04 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB851FC1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 19:48:37 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id u38so6997508pfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 19:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679971717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P1LTltbENpYsxSmvZ7pet3y5MXV4TTxagfiA0dyuCW0=;
        b=ZE5xUc/7IodL5MuXevDgShrP02OEOSfTlBhuHF2OYufWVblx2fTFD9+qmpA6Z++UqK
         b9e9D3/76c61YjLFOsSGnTFaSZlKZ1EW95xwmFPgCrJCm3G+rkdsBR59vmn29m5O3q2Z
         VD6OFjswIyITOX5b477D2je6pbLZpv8huPOZMd8g2qyeBGS3PaRrsrO5JCPHRu5x3dPi
         6hxL8vPrOvhCUbGiUxpCAN80pmIHHb7McWN7o0ABWNHCw24KyuqFTbEelqHy/YvUm70J
         eYD4EAjg5EbNxlq3pYJajTpwuyiN47BHLmACqpgmDKZoLZboY5DZvW4s4FpNbxNUF5j0
         xO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679971717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P1LTltbENpYsxSmvZ7pet3y5MXV4TTxagfiA0dyuCW0=;
        b=fLEHK754wvjtfYDiYnYbIlF/8v8gkRdHBj3ky4z9DLHSzeIIMK7vRUdY6hjcJIhuuL
         EQjg3q4+Ez1MBpOkfAWV2N9sBpFSJKUpGyyGPTvIeSjHI31gforuwUnjNEP/pBMxAuWS
         vaDinmMcw73dlJala/vCw26qiRftZLeqoZcCbxjTVn+iCDXaulhU8yiijUybMQNsM9yq
         BM+EDP3Hj3mqCl72sZExvAJY77H5cYe6TOBTwFns36UZAxbk7NZ+npjp4RPlnf+Wo4P3
         ZouyVejYuACjHia55ne7jXcCJgdJBxFQxjubg1rh2peE92PL8CqSWOaL2ynOpI1kZSeK
         ZB3Q==
X-Gm-Message-State: AO0yUKUjWagSz7hRLoX23WYggUueXP8QRmL6tA9HFJWzZI3T70pR+9AZ
        M94DtezcfWx1a9ovScpK706AHg==
X-Google-Smtp-Source: AK7set/XyBBWrnVOnZP1FBEekHi/QRYPml6mnwLPudI+7zoOkHiTA8R1UGIQeRgUBolJBBd1Yl12Yg==
X-Received: by 2002:a05:6a00:c8d:b0:62a:43e2:ab99 with SMTP id a13-20020a056a000c8d00b0062a43e2ab99mr22126561pfv.5.1679971716897;
        Mon, 27 Mar 2023 19:48:36 -0700 (PDT)
Received: from V2264L26XN.bytedance.net ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id b2-20020aa78702000000b00592543d7363sm19760805pfo.1.2023.03.27.19.48.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Mar 2023 19:48:35 -0700 (PDT)
From:   Ma Xing <maxing.lan@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.co
Cc:     linux-kernel@vger.kernel.org, yuanzhu@bytedance.com,
        Ma Xing <maxing.lan@bytedance.com>
Subject: [PATCH] sched/cputime: Make cputime_adjust() more accurate
Date:   Tue, 28 Mar 2023 10:48:27 +0800
Message-Id: <20230328024827.12187-1-maxing.lan@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current algorithm of cputime_adjust(), the accumulated stime and
utime are used to divide the accumulated rtime. When the value is very
large, it is easy for the stime or utime not to be updated. It can cause
sys or user utilization to be zero for long time.

A better and intuitive way is to save the last stime and utime, and
divide the rtime increment proportionally according to the tick
increment.

I wrote the test-case: refer to
https://lore.kernel.org/lkml/20190718131834.GA22211@redhat.com/

	int main(int argc, char ** argv) {
		struct task_cputime c;
		struct prev_cputime p;
		u64 st, pst, cst;
		u64 ut, put, cut;
		u64 x, y;
		int i = -1; // one step not printed

		if (argc != 2) {
			printf("usage: %s <start_in_seconds>\n", argv[0]);
			return 1;
		}
		x = strtoull(argv[1], NULL, 0) * SEC;
		printf("start=%lld\n", x);

		p.stime = p.stick = x;
		p.utime = p.utick = x;

		c.stime = p.stime;
		c.utime = p.utime;
		c.sum_exec_runtime = p.stime + p.utime;

		while (i++ < NSTEPS) {
			y = STEP;
			c.stime += 4*y;
			c.utime += y;
			c.sum_exec_runtime += y;
			pst = nsec_to_clock_t(p.stime);
			put = nsec_to_clock_t(p.utime);
			cputime_adjust( & c, & p, & ut, & st);
			cst = nsec_to_clock_t(st);
			cut = nsec_to_clock_t(ut);
			if (i)
				printf("ut(diff)/st(diff): %20lld (%4lld)  %20lld (%4lld)\n",
						cut, cut - put, cst, cst - pst);
		}
		printf("\n\n");

		while (i++ < 2*NSTEPS) {
			y = STEP;
			c.stime += y;
			c.utime += 4*y;
			c.sum_exec_runtime += y;
			pst = nsec_to_clock_t(p.stime);
			put = nsec_to_clock_t(p.utime);
			cputime_adjust( & c, & p, & ut, & st);
			cst = nsec_to_clock_t(st);
			cut = nsec_to_clock_t(ut);
			if (i)
				printf("ut(diff)/st(diff): %20lld (%4lld)  %20lld (%4lld)\n",
						cut, cut - put, cst, cst - pst);
		}
	}

For example, the new patch works well when cfs based rtime disagrees
with tick based stime/utime, the root reason is it converges fast:

	# ./a.out 300000
	start=300000000000000
	ut(diff)/st(diff):            300000400 ( 200)             300001600 ( 800)
	ut(diff)/st(diff):            300000600 ( 200)             300002400 ( 800)
	ut(diff)/st(diff):            300000800 ( 200)             300003200 ( 800)
	ut(diff)/st(diff):            300001000 ( 200)             300004000 ( 800)
	ut(diff)/st(diff):            300001200 ( 200)             300004800 ( 800)
	ut(diff)/st(diff):            300001400 ( 200)             300005600 ( 800)
	ut(diff)/st(diff):            300001600 ( 200)             300006400 ( 800)
	ut(diff)/st(diff):            300001800 ( 200)             300007200 ( 800)
	ut(diff)/st(diff):            300002000 ( 200)             300008000 ( 800)
	ut(diff)/st(diff):            300002200 ( 200)             300008800 ( 800)
	ut(diff)/st(diff):            300002400 ( 200)             300009600 ( 800)
	ut(diff)/st(diff):            300002600 ( 200)             300010400 ( 800)
	ut(diff)/st(diff):            300002800 ( 200)             300011200 ( 800)
	ut(diff)/st(diff):            300003000 ( 200)             300012000 ( 800)
	ut(diff)/st(diff):            300003200 ( 200)             300012800 ( 800)
	ut(diff)/st(diff):            300003400 ( 200)             300013600 ( 800)
	ut(diff)/st(diff):            300003600 ( 200)             300014400 ( 800)
	ut(diff)/st(diff):            300003800 ( 200)             300015200 ( 800)
	ut(diff)/st(diff):            300004000 ( 200)             300016000 ( 800)
	ut(diff)/st(diff):            300004200 ( 200)             300016800 ( 800)

	ut(diff)/st(diff):            300005000 ( 800)             300017000 ( 200)
	ut(diff)/st(diff):            300005800 ( 800)             300017200 ( 200)
	ut(diff)/st(diff):            300006600 ( 800)             300017400 ( 200)
	ut(diff)/st(diff):            300007400 ( 800)             300017600 ( 200)
	ut(diff)/st(diff):            300008200 ( 800)             300017800 ( 200)
	ut(diff)/st(diff):            300009000 ( 800)             300018000 ( 200)
	ut(diff)/st(diff):            300009800 ( 800)             300018200 ( 200)
	ut(diff)/st(diff):            300010600 ( 800)             300018400 ( 200)
	ut(diff)/st(diff):            300011400 ( 800)             300018600 ( 200)
	ut(diff)/st(diff):            300012200 ( 800)             300018800 ( 200)
	ut(diff)/st(diff):            300013000 ( 800)             300019000 ( 200)
	ut(diff)/st(diff):            300013800 ( 800)             300019200 ( 200)
	ut(diff)/st(diff):            300014600 ( 800)             300019400 ( 200)
	ut(diff)/st(diff):            300015400 ( 800)             300019600 ( 200)
	ut(diff)/st(diff):            300016200 ( 800)             300019800 ( 200)
	ut(diff)/st(diff):            300017000 ( 800)             300020000 ( 200)
	ut(diff)/st(diff):            300017800 ( 800)             300020200 ( 200)
	ut(diff)/st(diff):            300018600 ( 800)             300020400 ( 200)
	ut(diff)/st(diff):            300019400 ( 800)             300020600 ( 200)

while the old cputime_adjust has the following problem, when sum_exec_runtime is 300000 secs.

	# ./a.out 300000
	start=300000000000000
	ut(diff)/st(diff):            300000000 (   0)             300002000 (1000)
	ut(diff)/st(diff):            300000000 (   0)             300003000 (1000)
	ut(diff)/st(diff):            300000000 (   0)             300004000 (1000)
	ut(diff)/st(diff):            300000000 (   0)             300005000 (1000)
	ut(diff)/st(diff):            300000000 (   0)             300006000 (1000)
	ut(diff)/st(diff):            300000000 (   0)             300007000 (1000)
	ut(diff)/st(diff):            300000000 (   0)             300008000 (1000)
	ut(diff)/st(diff):            300000000 (   0)             300009000 (1000)
	ut(diff)/st(diff):            300000000 (   0)             300010000 (1000)
	ut(diff)/st(diff):            300000000 (   0)             300011000 (1000)
	ut(diff)/st(diff):            300000000 (   0)             300012000 (1000)
	ut(diff)/st(diff):            300000000 (   0)             300013000 (1000)
	ut(diff)/st(diff):            300000000 (   0)             300014000 (1000)
	ut(diff)/st(diff):            300000000 (   0)             300015000 (1000)
	ut(diff)/st(diff):            300000000 (   0)             300016000 (1000)
	ut(diff)/st(diff):            300000000 (   0)             300017000 (1000)
	ut(diff)/st(diff):            300000000 (   0)             300018000 (1000)
	ut(diff)/st(diff):            300000000 (   0)             300019000 (1000)
	ut(diff)/st(diff):            300000000 (   0)             300020000 (1000)
	ut(diff)/st(diff):            300000000 (   0)             300021000 (1000)

	ut(diff)/st(diff):            300000000 (   0)             300022000 (1000)
	ut(diff)/st(diff):            300000000 (   0)             300023000 (1000)
	ut(diff)/st(diff):            300000000 (   0)             300024000 (1000)
	ut(diff)/st(diff):            300000000 (   0)             300025000 (1000)
	ut(diff)/st(diff):            300000000 (   0)             300026000 (1000)
	ut(diff)/st(diff):            300000000 (   0)             300027000 (1000)
	ut(diff)/st(diff):            300000000 (   0)             300028000 (1000)
	ut(diff)/st(diff):            300000000 (   0)             300029000 (1000)
	ut(diff)/st(diff):            300000000 (   0)             300030000 (1000)
	ut(diff)/st(diff):            300000000 (   0)             300031000 (1000)
	ut(diff)/st(diff):            300001000 (1000)             300031000 (   0)
	ut(diff)/st(diff):            300002000 (1000)             300031000 (   0)
	ut(diff)/st(diff):            300003000 (1000)             300031000 (   0)
	ut(diff)/st(diff):            300004000 (1000)             300031000 (   0)
	ut(diff)/st(diff):            300005000 (1000)             300031000 (   0)
	ut(diff)/st(diff):            300006000 (1000)             300031000 (   0)
	ut(diff)/st(diff):            300007000 (1000)             300031000 (   0)
	ut(diff)/st(diff):            300008000 (1000)             300031000 (   0)
	ut(diff)/st(diff):            300009000 (1000)             300031000 (   0)

In addition, this patch has been running stably for 2 months and no problems have been found.

Signed-off-by: Ma Xing <maxing.lan@bytedance.com>
---
 include/linux/sched.h         |  2 ++
 include/linux/sched/cputime.h |  1 +
 kernel/sched/cputime.c        | 38 +++++++++++++++++++++++++----------
 3 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6d654eb4cabd..e1bac4ee48ba 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -326,6 +326,8 @@ struct prev_cputime {
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 	u64				utime;
 	u64				stime;
+	u64				utick;
+	u64				stick;
 	raw_spinlock_t			lock;
 #endif
 };
diff --git a/include/linux/sched/cputime.h b/include/linux/sched/cputime.h
index 5f8fd5b24a2e..855503bbd067 100644
--- a/include/linux/sched/cputime.h
+++ b/include/linux/sched/cputime.h
@@ -173,6 +173,7 @@ static inline void prev_cputime_init(struct prev_cputime *prev)
 {
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 	prev->utime = prev->stime = 0;
+	prev->utick = prev->stick = 0;
 	raw_spin_lock_init(&prev->lock);
 #endif
 }
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index af7952f12e6c..ee8084957578 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -559,6 +559,7 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
 		    u64 *ut, u64 *st)
 {
 	u64 rtime, stime, utime;
+	s64 delta_rtime, delta_stime, delta_utime;
 	unsigned long flags;
 
 	/* Serialize concurrent callers such that we can honour our guarantees */
@@ -579,22 +580,36 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
 	stime = curr->stime;
 	utime = curr->utime;
 
+
+	delta_rtime = rtime - prev->stime - prev->utime;
+	delta_stime = stime - prev->stick;
+	delta_utime = utime - prev->utick;
+
+	prev->stick = stime;
+	prev->utick = utime;
+
 	/*
 	 * If either stime or utime are 0, assume all runtime is userspace.
 	 * Once a task gets some ticks, the monotonicity code at 'update:'
 	 * will ensure things converge to the observed ratio.
 	 */
 	if (stime == 0) {
-		utime = rtime;
+		delta_utime = delta_rtime;
 		goto update;
 	}
 
 	if (utime == 0) {
-		stime = rtime;
+		delta_stime = delta_rtime;
 		goto update;
 	}
 
-	stime = mul_u64_u64_div_u64(stime, rtime, stime + utime);
+	if (delta_stime <= 0)
+		goto update;
+
+	if (delta_utime <= 0)
+		goto update;
+
+	delta_stime = mul_u64_u64_div_u64(delta_stime, delta_rtime, delta_stime + delta_utime);
 
 update:
 	/*
@@ -606,21 +621,22 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
 	 *            = (rtime_i+1 - rtime_i) + utime_i
 	 *            >= utime_i
 	 */
-	if (stime < prev->stime)
-		stime = prev->stime;
-	utime = rtime - stime;
+	if (delta_stime <= 0)
+		delta_stime = 0;
+	delta_utime = delta_rtime - delta_stime;
+
 
 	/*
 	 * Make sure utime doesn't go backwards; this still preserves
 	 * monotonicity for stime, analogous argument to above.
 	 */
-	if (utime < prev->utime) {
-		utime = prev->utime;
-		stime = rtime - utime;
+	if (delta_utime <= 0) {
+		delta_utime = 0;
+		delta_stime = delta_rtime;
 	}
 
-	prev->stime = stime;
-	prev->utime = utime;
+	prev->stime += delta_stime;
+	prev->utime += delta_utime;
 out:
 	*ut = prev->utime;
 	*st = prev->stime;
-- 
2.20.1

