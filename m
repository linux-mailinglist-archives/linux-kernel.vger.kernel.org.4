Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56B3702501
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239973AbjEOGj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjEOGjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:39:23 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A718E71
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:39:19 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1aad5245632so87563485ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684132758; x=1686724758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GG9RKNGEffPgJfkkoC15/sIpfFivs7YSYRYo8JcS/I=;
        b=Xuhak8QGNB33HHyzbiwgrCV89M2svRMI6Jf52IB8n8T5s8wXKOilZvXZ3d/cSfkxuN
         OWhrkIKBMoBo1k3RRIeZ77OrAQQPnYZUFL6aCT9CKsxHAAqsnmr0zw1jpmq85hm9Kdd4
         9kmDYLhxzH7NOXhqOJ0lgiX4tDrm7fr/rwnt2RscD+qOBb6X7ZN5PAbPIMf8k7qF6/3W
         Muo7TR0hIDqc4dQlSnRXu9x2TSdSQhKts86LJp6jgUKvbfRiOHk1yAUFzSnVAW9QYVZ8
         YVoAVALb5uc40s3m8AouRH5/bPXI/sLGqAka/NJWI/CQiD3qBS42eMmyB7c+sVqa+mqU
         IjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684132758; x=1686724758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GG9RKNGEffPgJfkkoC15/sIpfFivs7YSYRYo8JcS/I=;
        b=DnEMj3HItDBBTsxIj55wdkyJK0Ab/OMRj/SSnjTQEwl4qNsmems5OjQEOJkc4cug42
         TbVBHJRPJfJOusnoEhx62fqGAbMB4XvyKesGnZ8pzSYHIltuDkTEkQvFxJVzXS7ZfPCb
         dRtQFtj/lGzY/fHi2OFHvFB26Lp1btDUaEeGdSmU9vbZQslsCBPgZPSV4tTbf6BdSOra
         2h3kNhK0jcDy5GDfwUNjSsb2niNCJ0E7tY0z5moawmQgwGk1HwxyXirGfITNk3FURh8g
         jUGP7V2/jpkrzb/U8ywBU+Hzl/hnVlnQ+ou81JL+dEYOew31ZDvL7K3MxUvKo7StUc1k
         A9Tg==
X-Gm-Message-State: AC+VfDwjsfeJdXb4rWUvshAxgnwNAhLyZa4l/YWoPiuutXHSGEQLeXj5
        en/EC1kmYy0GoieWN0OCBrRqAA==
X-Google-Smtp-Source: ACHHUZ72xHsVZE+7CgN1Pe08ggwXYc0BPp8ctpYj9D8f3sbkYlANoOGCfnn9pMOmI+qwdUYiM93RPw==
X-Received: by 2002:a17:902:f9cd:b0:1a5:1e7:86d7 with SMTP id kz13-20020a170902f9cd00b001a501e786d7mr30320465plb.52.1684132758643;
        Sun, 14 May 2023 23:39:18 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id t1-20020a170902a5c100b001ab01598f40sm12608543plq.173.2023.05.14.23.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 23:39:18 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH v3 3/4] sched/core: Avoid multiple calling update_rq_clock() in __cfsb_csd_unthrottle()
Date:   Mon, 15 May 2023 14:38:47 +0800
Message-Id: <20230515063848.77947-4-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230515063848.77947-1-jiahao.os@bytedance.com>
References: <20230515063848.77947-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
2.37.0

