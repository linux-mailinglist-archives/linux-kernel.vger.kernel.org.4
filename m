Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104B272774C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 08:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbjFHGe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 02:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234801AbjFHGeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 02:34:14 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA342719
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 23:33:47 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-39a505b901dso210753b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 23:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686206026; x=1688798026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kiXdCNBs7MsEGE9ZtEtEzwmLWhy0ZFEY2zGjq+a+7k=;
        b=jBkNXenyS2kesryvPlWkaWLS6/2hC0E5zpnPzGiZAkjy5PFLGag4X3ont4bH5nuZAq
         p0pDXr9UB2FswInisj31y5c9UkqT2PTWuVe1s/YuTiNCACmqk+qff9W2Rwq8IZYPHzk3
         VWuGlhpMWNVW5HMrhjaUcXt98p0p7GXoRv96opweum/QZINdNhwi32zKChp+68FV+VUl
         EMBTiQAfPF9QVZPdSknLTKpmKsmAgdB4bztPvgfFbgNq/s+qDi9E7eaZ9VoEZH4n7Kvx
         bo5wAhz5kqfxUaaY+x98n7BotZ4tswgKAM8h+NDzsFB0J51Oslpie6APjkoEqpcE/FRs
         qEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686206026; x=1688798026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/kiXdCNBs7MsEGE9ZtEtEzwmLWhy0ZFEY2zGjq+a+7k=;
        b=fRlmZXL+7omOoYXt3mM65ALqqQYmsr0wXlBO7LxSi0or5X9pKqDjjhqx/I6UrRRR39
         S69HHXsv9UrMLkcbrAZFYtDpwGy1hFHVONZ+r7c/Kw2tx4u4UXdmEmqQOqjLHM6MbWSg
         4dY4qG1hwlsEoRQIr54exsh8tvG5PMEkO3YsUSzgXkNFUugsMT/j3jSI6xGCbMGASgAo
         rUH02TFSULj16LIcpJX7gZQorAHKY+fVOk+yHAhzdQkTiuMQAwcNPUSBBL46JTRQNTQV
         Pwc/Y+rDeuOXW4QUwlMwjWTOhwInKA7J7k8nLjkLG0xwWrw2Fn92wtcuAxP/ofANjytA
         qjTQ==
X-Gm-Message-State: AC+VfDwXZrQFT8Vfb388efKasQfYiaXifGeVhcLgR8RDvZxoYrht5vFs
        DoRRevxI5p4Zivlbc3r83b4Z6w==
X-Google-Smtp-Source: ACHHUZ6/LV/RADn2G+JJgrD8Z8aD2ZxU6Ozfo+so2z7Yyb0W0BrKEs1dVmgV+YUtzfocST7a+yOJwg==
X-Received: by 2002:a05:6808:a88:b0:39a:98c3:f268 with SMTP id q8-20020a0568080a8800b0039a98c3f268mr7254306oij.49.1686206026388;
        Wed, 07 Jun 2023 23:33:46 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id c15-20020a17090abf0f00b0025645d118adsm542039pjs.14.2023.06.07.23.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 23:33:46 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH v4 3/4] sched/core: Avoid multiple calling update_rq_clock() in __cfsb_csd_unthrottle()
Date:   Thu,  8 Jun 2023 14:33:11 +0800
Message-Id: <20230608063312.79440-4-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230608063312.79440-1-jiahao.os@bytedance.com>
References: <20230608063312.79440-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 8ad075c2eb1f ("sched: Async unthrottling for cfs
bandwidth"), we may update the rq clock multiple times in the loop of
__cfsb_csd_unthrottle(). At that time the following warning will be
triggered.
------------[ cut here ]------------
rq->clock_update_flags & RQCF_UPDATED
WARNING: CPU: 54 PID: 0 at kernel/sched/core.c:741
update_rq_clock+0xaf/0x180
Call Trace:
 <TASK>
 unthrottle_cfs_rq+0x4b/0x300
 __cfsb_csd_unthrottle+0xe0/0x100
 __flush_smp_call_function_queue+0xaf/0x1d0
 flush_smp_call_function_queue+0x49/0x90
 do_idle+0x17c/0x270
 cpu_startup_entry+0x19/0x20
 start_secondary+0xfa/0x120
 secondary_startup_64_no_verify+0xce/0xdb

Before the loop starts, we update the rq clock once and call
rq_clock_start_loop_update() to prevent updating the rq clock
multiple times. And call rq_clock_stop_loop_update() After
the loop to clear rq->clock_update_flags.

Fixes: 8ad075c2eb1f ("sched: Async unthrottling for cfs bandwidth")

Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c  |  9 +++++++++
 kernel/sched/sched.h | 21 +++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 373ff5f55884..af9604f4b135 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5576,6 +5576,14 @@ static void __cfsb_csd_unthrottle(void *arg)
 
 	rq_lock(rq, &rf);
 
+	/*
+	 * Iterating over the list can trigger several call to
+	 * update_rq_clock() in unthrottle_cfs_rq().
+	 * Do it once and skip the potential next ones.
+	 */
+	update_rq_clock(rq);
+	rq_clock_start_loop_update(rq);
+
 	/*
 	 * Since we hold rq lock we're safe from concurrent manipulation of
 	 * the CSD list. However, this RCU critical section annotates the
@@ -5595,6 +5603,7 @@ static void __cfsb_csd_unthrottle(void *arg)
 
 	rcu_read_unlock();
 
+	rq_clock_stop_loop_update(rq);
 	rq_unlock(rq, &rf);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ec7b3e0a2b20..50446e401b9f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1546,6 +1546,27 @@ static inline void rq_clock_cancel_skipupdate(struct rq *rq)
 	rq->clock_update_flags &= ~RQCF_REQ_SKIP;
 }
 
+/*
+ * During cpu offlining and rq wide unthrottling, we can trigger
+ * an update_rq_clock() for several cfs and rt runqueues (Typically
+ * when using list_for_each_entry_*)
+ * rq_clock_start_loop_update() can be called after updating the clock
+ * once and before iterating over the list to prevent multiple update.
+ * After the iterative traversal, we need to call rq_clock_stop_loop_update()
+ * to clear RQCF_ACT_SKIP of rq->clock_update_flags.
+ */
+static inline void rq_clock_start_loop_update(struct rq *rq)
+{
+	lockdep_assert_rq_held(rq);
+	rq->clock_update_flags |= RQCF_ACT_SKIP;
+}
+
+static inline void rq_clock_stop_loop_update(struct rq *rq)
+{
+	lockdep_assert_rq_held(rq);
+	rq->clock_update_flags &= ~RQCF_ACT_SKIP;
+}
+
 struct rq_flags {
 	unsigned long flags;
 	struct pin_cookie cookie;
-- 
2.37.0 (Apple Git-136)

