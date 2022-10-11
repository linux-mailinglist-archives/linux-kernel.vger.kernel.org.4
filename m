Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5809A5FBA0A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiJKSCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiJKSCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:02:12 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD7669198
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:02:11 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id w3so996950qtv.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhrU25MZyXkPboJ3l5140dRpbDasFmkEEXoWImTO9UA=;
        b=N5Xo3Xm/o16rsQm6cMjs2RXvWJiJkfMf681C8sDsuEs0kLCkpb1ivla4yZbmoNctMg
         8D17AbXbVme6drCjePTWOgZ30BRV5SRXqa1d7ImvjfbsaipIG6Yex81HLafx2EkIAryY
         iMxVujhiqpkyw/hC7zmbec/DNSq8YWKhse0LY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhrU25MZyXkPboJ3l5140dRpbDasFmkEEXoWImTO9UA=;
        b=02QPzNTz63QsFmlCwTrXVH/D3ZnvYQN9cbHf5mPM9kwZyfzsI+zAIWtrzBLnSIjV3B
         7A4yUQODe7akZHOiKfry8DB5YNUrK4OqJ5T/c+fy3l/uWmP/880oiy2zt52odDS4lK1w
         lnHBFrTBUS1OAr707oxrTIbNNn3VMFiONPYMHeoWtDIKCk5rNI6bEBihSorp2u0oR4vY
         BRp7iqT8ujoGxLegYds52KzAP70OoI3vc3+zOJnVSRKe7aq2iqCVkqGH7nXA1uzvhKLO
         vEV4ZMEzmtI5yHjkVNo0Pnl6WroR+wA/xct8U401BEofBJnqm+MveBImWp4d6KWpov7C
         Sj7A==
X-Gm-Message-State: ACrzQf2PYQixWH22TeailAGJ5YKq13zfDNM5gAK6JEyp9SZ/sMXxRf52
        IzZ5YiKxw1RaiKwU/GpWdj/rbA==
X-Google-Smtp-Source: AMsMyM4yZwIaKvlR/XhxQcnN46OF0zY+EfEbrTHf65qIenfOjqbu7WpnQOoCxZinGxhtc0x41Kkzwg==
X-Received: by 2002:a05:622a:1651:b0:38f:2829:a1fe with SMTP id y17-20020a05622a165100b0038f2829a1femr20435697qtj.173.1665511330743;
        Tue, 11 Oct 2022 11:02:10 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id w22-20020a05620a425600b006cbc00db595sm13464375qko.23.2022.10.11.11.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 11:02:10 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v8 03/13] rcu: Refactor code a bit in rcu_nocb_do_flush_bypass()
Date:   Tue, 11 Oct 2022 18:01:32 +0000
Message-Id: <20221011180142.2742289-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221011180142.2742289-1-joel@joelfernandes.org>
References: <20221011180142.2742289-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index e852c060d4e3..5ce66f9f4a98 100644
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
2.38.0.rc1.362.ged0d419d3c-goog

