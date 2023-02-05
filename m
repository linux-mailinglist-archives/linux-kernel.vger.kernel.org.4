Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEB368B239
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 23:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjBEWnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 17:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjBEWni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 17:43:38 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6021B55C
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 14:43:37 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id e22so158033ejb.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 14:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/esgXyXTTPxQhwv1dQWaspfNIbrAOoa4gfi3afJxYbI=;
        b=saj4RMnp18qzp3YrMX0TvOgrT4AhT+MZWfVpznyOwkspaZ7mHFNPNL8wgFYJ8UpNe2
         QsY1OW+ovidQImrOqpQ9IrUAxLltUpGfv2ST1CYutfGFZTPFpK0gMsqLjI5o3qVXQI5h
         ln17Y+sihiyTJ8pTngx/S0qj64QlZp29zrWuMc3rJaM49/yX+pZMq+oiCpT+g5Y5iwmC
         xgNjXnKZiJ1E6Ek+5FOptZFgcUIrSP/isqFSGiFWhR8FQEruttKhC2prknON/QJ5Vzmu
         nYiG57CCGb+nhFsyRnztxW8+ojJKINiXYn/irMUP+pNILIMlZVC8q1JNwUKGVOTZJyZG
         Kimg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/esgXyXTTPxQhwv1dQWaspfNIbrAOoa4gfi3afJxYbI=;
        b=8IZb2VLAuK+zGtyKN3/oQVor0INGUBbIQoMk3eOiYsawhpbhwP2b2tLcsHrBT85fK6
         2UOmVSgNY3pvblsb6ZXwqGBd02bo8zPrviiVrclPUkTQ8mv0ZWMZn8UGGjnBcRXhdnTY
         krLEVIzvIv5TQoJH/cPGqGVRW15+WUjVy7m4U5P8IMoX+OQcnKVpEGEpHLFlFh+MSGX4
         zqyC41Kvm7Bf9CqxUKOzx0gROe57lGKf+70uJbPpZ4UchR/xf7bIW4HRMCKlAuLQhjxS
         hlVNVJhLXCHC94tEqMb9LwWRERKWGuBcQrHmoVC2JOB4Jid24lo+KNIO+j3RUOFz5tqd
         mRwQ==
X-Gm-Message-State: AO0yUKXaR+MlOSF/UuKlSTHLzRzDVyoldl0f4YfWo3tE6ImgvEbyRKMi
        jSCeHPMFaSlKgGkv5Ob9cGAoag==
X-Google-Smtp-Source: AK7set9x6yzo6Wo4YON2oMsfFHFTT1az+lMFwyR2a9shTwnRZ2GKEOSxqwMEwjj2XLAUjhkQEsfMjg==
X-Received: by 2002:a17:906:4c84:b0:88a:da35:dd51 with SMTP id q4-20020a1709064c8400b0088ada35dd51mr17534300eju.14.1675637015794;
        Sun, 05 Feb 2023 14:43:35 -0800 (PST)
Received: from localhost.localdomain (host86-163-35-10.range86-163.btcentralplus.com. [86.163.35.10])
        by smtp.gmail.com with ESMTPSA id m15-20020a1709061ecf00b0087bd2924e74sm4550779ejj.205.2023.02.05.14.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 14:43:35 -0800 (PST)
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v2 3/3] sched/tp: Add new tracepoint to track compute energy computation
Date:   Sun,  5 Feb 2023 22:43:18 +0000
Message-Id: <20230205224318.2035646-4-qyousef@layalina.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230205224318.2035646-1-qyousef@layalina.io>
References: <20230205224318.2035646-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was useful to track feec() placement decision and debug the spare
capacity and optimization issues vs uclamp_max.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 include/trace/events/sched.h | 4 ++++
 kernel/sched/core.c          | 1 +
 kernel/sched/fair.c          | 7 ++++++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index fbb99a61f714..20cc884f72ff 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -735,6 +735,10 @@ DECLARE_TRACE(sched_update_nr_running_tp,
 	TP_PROTO(struct rq *rq, int change),
 	TP_ARGS(rq, change));
 
+DECLARE_TRACE(sched_compute_energy_tp,
+	TP_PROTO(struct task_struct *p, int dst_cpu, unsigned long energy),
+	TP_ARGS(p, dst_cpu, energy));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4580fe3e1d0c..5f6dde9b892b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -110,6 +110,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a8c3d92ff3f6..801e903c4307 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7295,11 +7295,16 @@ compute_energy(struct energy_env *eenv, struct perf_domain *pd,
 {
 	unsigned long max_util = eenv_pd_max_util(eenv, pd_cpus, p, dst_cpu);
 	unsigned long busy_time = eenv->pd_busy_time;
+	unsigned long energy;
 
 	if (dst_cpu >= 0)
 		busy_time = min(eenv->pd_cap, busy_time + eenv->task_busy_time);
 
-	return em_cpu_energy(pd->em_pd, max_util, busy_time, eenv->cpu_cap);
+	energy = em_cpu_energy(pd->em_pd, max_util, busy_time, eenv->cpu_cap);
+
+	trace_sched_compute_energy_tp(p, dst_cpu, energy);
+
+	return energy;
 }
 
 /*
-- 
2.25.1

