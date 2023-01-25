Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DC967B92B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 19:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbjAYSUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 13:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235854AbjAYSUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:20:05 -0500
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D553A5A340
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 10:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:Content-Type
        :MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-ID:Content-Description;
        bh=Tz5MdvnicuIK5Oled/YbXmo8a4UUPo0fLXYCdr9Nq2I=; b=f4jwihs7fgXpeYQNJNaP9wivXf
        dUR3g5PdGBl4Qij8GMJhgX4A0oUY555jNmvh9dBwdZMGe97E4uNycBKanZQra/PVs6epTowdNEIXC
        Zgv+LbGQBH4m5+o4lFa5YIg+m7kKKZvPfdsRyIrT/i9A4NxjBCtnX6eZpWlHFMZsJ+WpEXqNsBgKR
        fwU2SY5B2cZcUF0Do/pRhJP10ylkmKGLGH9dd1MhvZ1DG+/F3mX6HzNbgxmj4y2uAhpKW448JExhT
        Yk3iW9xLm2Paj4kxqO7o4tBcnceLoAY6kLDi3LyaD+yo03dGvevaj/HJBJI6eX+6MOWXs9mctyuoy
        jto4BgHg==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <anuradha@debian.org>)
        id 1pKkMn-001ZS8-DP; Wed, 25 Jan 2023 18:19:25 +0000
From:   Anuradha Weeraman <anuradha@debian.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     anuradha@debian.org
Subject: [PATCH v2] sched/rt: Fix unused-const-variable W=1 warning and style issue
Date:   Wed, 25 Jan 2023 23:49:10 +0530
Message-Id: <20230125181911.464272-1-anuradha@debian.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230124190638.124a1c7a@gandalf.local.home>
References: <20230124190638.124a1c7a@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1205; i=anuradha@debian.org; h=from:subject; bh=rBpOXPu4D0m0c/zpViqEbKcN4Jix1OjTWh9PHnAjvpY=; b=owEBbQKS/ZANAwAKAWNttaHZGGD9AcsmYgBj0XKcPV7a4x7/pnsmBwDBCmaCR/tpyfkbt9pZtsiK eTce+f+JAjMEAAEKAB0WIQT1a48U4BTN710Ef8FjbbWh2Rhg/QUCY9FynAAKCRBjbbWh2Rhg/UIbD/ 9C6vV3WQCktg/ukiGpVb+AWiqB8pp1lW+bEXUHDgkhExr9An8oFV+TRA+VCSk6VWXh0Xqg0+TEVrPs 9mi+XzqgnEVVrTKS4mP24dnjCiSEr9gmnow0k14syxwqmWchdaqHc2/ECVdGGc8p0seVi4JCkiAb1d RrYJaqRVk97w+AyKthRZBzPLnm5zY+ZZCR9xF9H8jccZjep7xkoCyjJ/44eed7vbEBYxz+iatP/zeC 5s7tDE7FR3jgcuTc2qGXl0x0e12V4G0j9pI5zNyV2ozN+qAVLGqzEBmDLODrz5MD6D62g3nD5wJjQ7 hLRkbC920XoWDaUSUYAt7VpElG3kAsCvQ9etW5sTFO4WsQvZnU++j0sVOgfGyqR1jsetI/8YRJ6ibP tW9U7//9dNxkJC9Fo3WKQQzNhsm6KDklYO9THyDGc/h8ZqJpCSb9HD+wmsxP6AjKbe1ZmE6d5wO/1N lPcfR7Xd1BP7wIVOtdNDVXPlkPVV/wyVPqziI2ghnXvG9oxK94G5jJqRvB0v6c9jNLB3LP/KopYMUA puFn/HZKxOhdW0DXhHxc7IQ+fcU1BFRNecWExdvhHSMmu4dWTB7NR/JEoaf8a/IImvQlCJIr1Z7Vu8 C6yMIZfpQrh/I14Om3IMyoXU41IenKSh/9WhYU/4D1pHs4Lw6e6DnkNx3Utw==
X-Developer-Key: i=anuradha@debian.org; a=openpgp; fpr=F56B8F14E014CDEF5D047FC1636DB5A1D91860FD
Content-Transfer-Encoding: 8bit
X-Debian-User: anuradha
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiler warning with W=1 due to unused constant in
    kernel/sched/rt.c:9:18: warning: ‘max_rt_runtime’ defined but not used

Fix by adding __maybe_unused attribute to max_rt_runtime.

Also, fix style issue for "else should follow close brace '}'".

Signed-off-by: Anuradha Weeraman <anuradha@debian.org>
---
 kernel/sched/rt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index ed2a47e4ddae..8cd2e1203a81 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -6,7 +6,7 @@
 
 int sched_rr_timeslice = RR_TIMESLICE;
 /* More than 4 hours if BW_SHIFT equals 20. */
-static const u64 max_rt_runtime = MAX_BW;
+static const u64 __maybe_unused max_rt_runtime = MAX_BW;
 
 static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun);
 
@@ -604,8 +604,7 @@ static void sched_rt_rq_dequeue(struct rt_rq *rt_rq)
 		dequeue_top_rt_rq(rt_rq, rt_rq->rt_nr_running);
 		/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
 		cpufreq_update_util(rq_of_rt_rq(rt_rq), 0);
-	}
-	else if (on_rt_rq(rt_se))
+	} else if (on_rt_rq(rt_se))
 		dequeue_rt_entity(rt_se, 0);
 }
 
-- 
2.39.0

