Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391436BBD80
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjCOTpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjCOTom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:44:42 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D513F12CC9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:44:33 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id x1so1751749qtr.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678909473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzLowNCggdMuHVa7t9ihdZAmx6P+qhTQOwYOWCMVniY=;
        b=X5E0FVsOr52URNj8IKnNJAMyRNN6iAb0W+Te/IP/Rkl5Hpf1U/QqPijvWm3XlbaicC
         3mlCYV4ql1Go4r8wPQCmoR9J9NpghgNsyUoeZ8oRouPfvr2gPKGhgdMmlX/lLdQcMHMI
         R6nYUPAL6WViNKApXzNGke+SYrLWQYJ/Zfe8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678909473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzLowNCggdMuHVa7t9ihdZAmx6P+qhTQOwYOWCMVniY=;
        b=MoF+9rFbgSIukMwMLn7DKceq3rtqfdMOTB+7Z/uEVPTeFo7wmYLr1JKP6jHKOTSCfq
         ONOnHQhs3gIRPrZfPu+pdESz+1G5DejmbuBw50T7M81HNslDALtpF9dSELYXN9EM8eKs
         iauxFf1qtiYtNXpQg2v9Xh0DpGN6s6JOU8I90yI3QXI8UVY7Yi4nxclWiSRSajXM0yq7
         iWWCX4ikcIfztVB+ttTwTOz3mQ7DVIKMtVwWapJ0s7ueIrQv+3NzTowxNtWIXsKeYaka
         6KlJ1qiiPD9MyDz7PfXLsnq9enD0xch+iikpyZoOly0yQOkJCRgQYN9cfISQKemmOLbx
         XN1A==
X-Gm-Message-State: AO0yUKVvKLzPMVkBAZhTwGkI8iseB+mux3nfz20ibhbIEVWzI9yrZbzp
        e8E6QkTJhQk0BajnxGmeFBC38pogqqCZZk+n9pQ=
X-Google-Smtp-Source: AK7set9UP2Vz06UydD43DMA5XM+4jGd4zT8Fi3xXIs0gA1il9wwSDKIsH1/iOjul9KKptIOJ9gLXqQ==
X-Received: by 2002:ac8:5886:0:b0:3bd:16cf:2f33 with SMTP id t6-20020ac85886000000b003bd16cf2f33mr1586127qta.63.1678909472162;
        Wed, 15 Mar 2023 12:44:32 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id c15-20020ac8660f000000b003b86b088755sm4346666qtp.15.2023.03.15.12.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 12:44:31 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Zqiang <qiang1.zhang@intel.com>, rcu@vger.kernel.org
Subject: [PATCH 4/9] rcu: Register rcu-lazy shrinker only for CONFIG_RCU_LAZY=y kernels
Date:   Wed, 15 Mar 2023 19:43:44 +0000
Message-Id: <20230315194349.10798-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315194349.10798-1-joel@joelfernandes.org>
References: <20230315194349.10798-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang1.zhang@intel.com>

The lazy_rcu_shrink_count() shrinker function is registered even in
kernels built with CONFIG_RCU_LAZY=n, in which case this function
uselessly consumes cycles learning that no CPU has any lazy callbacks
queued.

This commit therefore registers this shrinker function only in the kernels
built with CONFIG_RCU_LAZY=y, where it might actually do something useful.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree_nocb.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 9e1c8caec5ce..f2280616f9d5 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1312,6 +1312,7 @@ int rcu_nocb_cpu_offload(int cpu)
 }
 EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
 
+#ifdef CONFIG_RCU_LAZY
 static unsigned long
 lazy_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 {
@@ -1360,6 +1361,7 @@ static struct shrinker lazy_rcu_shrinker = {
 	.batch = 0,
 	.seeks = DEFAULT_SEEKS,
 };
+#endif // #ifdef CONFIG_RCU_LAZY
 
 void __init rcu_init_nohz(void)
 {
@@ -1391,8 +1393,10 @@ void __init rcu_init_nohz(void)
 	if (!rcu_state.nocb_is_setup)
 		return;
 
+#ifdef CONFIG_RCU_LAZY
 	if (register_shrinker(&lazy_rcu_shrinker, "rcu-lazy"))
 		pr_err("Failed to register lazy_rcu shrinker!\n");
+#endif // #ifdef CONFIG_RCU_LAZY
 
 	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
 		pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
-- 
2.40.0.rc1.284.g88254d51c5-goog

