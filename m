Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D726960013B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 18:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiJPQX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 12:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiJPQXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 12:23:42 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362F83CBFC
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 09:23:37 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id f22so6495996qto.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 09:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZziBLLlKHVzOSjc34J63Rv49GuOQiJ4SzWGeYcNVKSE=;
        b=o6NYymtWFFRcLKV9JGD5gsps1y6NUcfW3Qzq/Gg3Yy9WqLVAYmQJiUhHhH5CPhF1zT
         jD1drN+HTN1kjbs9R/euhIkLJH4lJwAj2TE2k+jfgEO5Ur65OpUgLvUANNWx1opLesWd
         Wld0TrKwgvAVFfLEx4dsPDGhvzbHH2nbeQwaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZziBLLlKHVzOSjc34J63Rv49GuOQiJ4SzWGeYcNVKSE=;
        b=UP6WTTD7SDqoHo9RYoOFG++jMXMCVlgy0yplu1hnFLzDCMLf4q4q6kpo+Uqzk9ugWb
         HXAIZYx1OZfTRe9jvQ7+/Y3lxAO7qStUXx+qIQfizcyG4UYwYCuJwracQ6nxKzAeFd74
         nu1uBlxS8UKL6QI2bgib+XBH7jUYJ8nQWrUVTSF/cZh20saxgh9Zm+k15SkZtFLXhzz0
         2mPwpk0PoOT8flzAjmY7moCYjqOrbZZjgipBPwrM6PKbYaMqxxhn+FJMDxSwKFBVISW7
         pCAkOKfvVKZfas+pnsMSzdecBp6hzuwR+Y0GGNeNdi65wSCT5v6a/PqnLEh0JT2wVc+m
         z2pA==
X-Gm-Message-State: ACrzQf3Z7NF2qA+o3Iqi5pSV3T/Rw42jPvkXAksQs7wEuOIwpqbiGtvX
        8K/GvUkXKN0tNbznNFIdnmP7xHwNrAdlaA==
X-Google-Smtp-Source: AMsMyM6BpO5nJQWqvmtG5gYtmpUCnZfEfU4OBQ3KZPiWvRfXnvnofryXy47gwmof+ExXw5hThAdqhQ==
X-Received: by 2002:a05:622a:283:b0:39c:d772:7e02 with SMTP id z3-20020a05622a028300b0039cd7727e02mr5663660qtw.369.1665937416460;
        Sun, 16 Oct 2022 09:23:36 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id x19-20020ac87ed3000000b003436103df40sm6001207qtj.8.2022.10.16.09.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 09:23:36 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, frederic@kernel.org,
        paulmck@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v9 03/13] rcu: Refactor code a bit in rcu_nocb_do_flush_bypass()
Date:   Sun, 16 Oct 2022 16:22:55 +0000
Message-Id: <20221016162305.2489629-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221016162305.2489629-1-joel@joelfernandes.org>
References: <20221016162305.2489629-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This consolidates the code a bit and makes it cleaner. Functionally it
is the same.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree_nocb.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index ab9ce0ebec23..717c0591c037 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -327,10 +327,11 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
  *
  * Note that this function always returns true if rhp is NULL.
  */
-static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
+static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp_in,
 				     unsigned long j, bool lazy)
 {
 	struct rcu_cblist rcl;
+	struct rcu_head *rhp = rhp_in;
 
 	WARN_ON_ONCE(!rcu_rdp_is_offloaded(rdp));
 	rcu_lockdep_assert_cblist_protected(rdp);
@@ -345,16 +346,16 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 
 	/*
 	 * If the new CB requested was a lazy one, queue it onto the main
-	 * ->cblist so we can take advantage of a sooner grade period.
+	 * ->cblist so that we can take advantage of the grace-period that will
+	 * happen regardless. But queue it onto the bypass list first so that
+	 * the lazy CB is ordered with the existing CBs in the bypass list.
 	 */
 	if (lazy && rhp) {
-		rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, NULL);
-		rcu_cblist_enqueue(&rcl, rhp);
-		WRITE_ONCE(rdp->lazy_len, 0);
-	} else {
-		rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
-		WRITE_ONCE(rdp->lazy_len, 0);
+		rcu_cblist_enqueue(&rdp->nocb_bypass, rhp);
+		rhp = NULL;
 	}
+	rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
+	WRITE_ONCE(rdp->lazy_len, 0);
 
 	rcu_segcblist_insert_pend_cbs(&rdp->cblist, &rcl);
 	WRITE_ONCE(rdp->nocb_bypass_first, j);
-- 
2.38.0.413.g74048e4d9e-goog

