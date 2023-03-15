Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46036BBBF0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjCOSUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbjCOSTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:19:52 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CC47E79F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:19:37 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id c19so17158849qtn.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678904376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6C875UW3frLz1lRISgaVupsCOUcY7ixEg8V710uhHfA=;
        b=DPSkv5UuukMQB08VeLhWDOZpTsKRs7XRm8Z7PYEO2J1A3Fp78UTsApYrFQwlOxMViU
         KlIZY+sUHHk4B22w99eFw5THO2D8yPtupryB73gk56KlbQQEhhQukLDCu+ytVgTy+DM+
         V819OE0WU+vOdwSGrLQboPd96Y//tbADX9h2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678904376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6C875UW3frLz1lRISgaVupsCOUcY7ixEg8V710uhHfA=;
        b=OIpQR+92zV2nGpuGOYG75tThZo6I4jsLZ7PbHnlKWtiMx3W2KKhrfVgGct2B6cfFts
         Aam1pgBfPMe/ChWgxMPmS3e+oA4fSu6sG58L4HWtLoYDgZMsYGgQiCsDquDHyLmM+3gt
         YqdyO8ToeQNPiz2sAmlK9ywyXTQpN9UCT2lAnvvEOKyfHVlQpULz8CEZA0USy/EXMIpC
         5mJd37JlWrTWR3GfDf8QVwqxb/AzDkXepYJ7ZtOUze8s6LUecq3dyS0V184ZGwCuRPUw
         7c/9xnnsQrrEr+jLiyNRcbq+Re09m057Xt/k27vWKXJzB+a6EB3fRseBxLhQ5i92Jo7w
         NpmA==
X-Gm-Message-State: AO0yUKXpINRJ4KpwdAdSOS0cA+nOjfuRMjPM0keG313Jf8QgnCfqlqBH
        24pP2D11bvX+Zg7jM9n2tfjK4w==
X-Google-Smtp-Source: AK7set/+DQUInzPQv7zg0jpqq9Z8pFaM3HKmCv83UgP5J0Ng/wXnoIoKyNsPk0qA4oLZ+MhQ5btm7Q==
X-Received: by 2002:a05:622a:14c8:b0:3d4:6185:72eb with SMTP id u8-20020a05622a14c800b003d4618572ebmr1282272qtx.34.1678904376337;
        Wed, 15 Mar 2023 11:19:36 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id v125-20020a379383000000b007458ae32290sm4113974qkd.128.2023.03.15.11.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 11:19:36 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/14] rcu/kvfree: Eliminate k[v]free_rcu() single argument macro
Date:   Wed, 15 Mar 2023 18:18:58 +0000
Message-Id: <20230315181902.4177819-11-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315181902.4177819-1-joel@joelfernandes.org>
References: <20230315181902.4177819-1-joel@joelfernandes.org>
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

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

The kvfree_rcu() and kfree_rcu() APIs are hazardous in that if you forget
the second argument, it works, but might sleep.  This sleeping can be a
correctness bug from atomic contexts, and even in non-atomic contexts it
might introduce unacceptable latencies.  This commit therefore removes the
single-argument kvfree_rcu() and kfree_rcu() macros.  Code that would have
previously used these single-argument kvfree_rcu() and kfree_rcu() macros
should instead use kvfree_rcu_mightsleep() or kfree_rcu_mightsleep().

[ paulmck: Apply Joel Fernandes feedback. ]

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/rcupdate.h | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 094321c17e48..7571dbfecb18 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -957,9 +957,8 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
 
 /**
  * kfree_rcu() - kfree an object after a grace period.
- * @ptr: pointer to kfree for both single- and double-argument invocations.
- * @rhf: the name of the struct rcu_head within the type of @ptr,
- *       but only for double-argument invocations.
+ * @ptr: pointer to kfree for double-argument invocations.
+ * @rhf: the name of the struct rcu_head within the type of @ptr.
  *
  * Many rcu callbacks functions just call kfree() on the base structure.
  * These functions are trivial, but their size adds up, and furthermore
@@ -982,26 +981,18 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
  * The BUILD_BUG_ON check must not involve any function calls, hence the
  * checks are done in macros here.
  */
-#define kfree_rcu(ptr, rhf...) kvfree_rcu(ptr, ## rhf)
+#define kfree_rcu(ptr, rhf) kvfree_rcu_arg_2(ptr, rhf)
+#define kvfree_rcu(ptr, rhf) kvfree_rcu_arg_2(ptr, rhf)
 
 /**
- * kvfree_rcu() - kvfree an object after a grace period.
- *
- * This macro consists of one or two arguments and it is
- * based on whether an object is head-less or not. If it
- * has a head then a semantic stays the same as it used
- * to be before:
- *
- *     kvfree_rcu(ptr, rhf);
- *
- * where @ptr is a pointer to kvfree(), @rhf is the name
- * of the rcu_head structure within the type of @ptr.
+ * kfree_rcu_mightsleep() - kfree an object after a grace period.
+ * @ptr: pointer to kfree for single-argument invocations.
  *
  * When it comes to head-less variant, only one argument
  * is passed and that is just a pointer which has to be
  * freed after a grace period. Therefore the semantic is
  *
- *     kvfree_rcu(ptr);
+ *     kfree_rcu_mightsleep(ptr);
  *
  * where @ptr is the pointer to be freed by kvfree().
  *
@@ -1010,13 +1001,9 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
  * annotation. Otherwise, please switch and embed the
  * rcu_head structure within the type of @ptr.
  */
-#define kvfree_rcu(...) KVFREE_GET_MACRO(__VA_ARGS__,		\
-	kvfree_rcu_arg_2, kvfree_rcu_arg_1)(__VA_ARGS__)
-
+#define kfree_rcu_mightsleep(ptr) kvfree_rcu_arg_1(ptr)
 #define kvfree_rcu_mightsleep(ptr) kvfree_rcu_arg_1(ptr)
-#define kfree_rcu_mightsleep(ptr) kvfree_rcu_mightsleep(ptr)
 
-#define KVFREE_GET_MACRO(_1, _2, NAME, ...) NAME
 #define kvfree_rcu_arg_2(ptr, rhf)					\
 do {									\
 	typeof (ptr) ___p = (ptr);					\
-- 
2.40.0.rc1.284.g88254d51c5-goog

