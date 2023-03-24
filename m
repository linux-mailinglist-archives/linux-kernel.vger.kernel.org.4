Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447C96C7481
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 01:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjCXAUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 20:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjCXAT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 20:19:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B843C23C6A;
        Thu, 23 Mar 2023 17:19:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B50C2B822B7;
        Fri, 24 Mar 2023 00:19:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A558EC433B0;
        Fri, 24 Mar 2023 00:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679617181;
        bh=NdzYQ3Je9Z5Q5tvkS8TNBgXRfqR10wf6pC1f2vVyHzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AQhNQzGkkOYUSB/savXCPXJ8MgV7N9T2fyxbdc9gzd9ikLSLEs3D1Ly2vM+MM3+Cb
         9tnt+pjS5xOBBR7aQZVhhhZk7zEM07G7yj8EjuLe0fVSXgE5X8RBwnMp+63VtGJ7L+
         qRNfjhgeQzwG8Aoq/8xeEzPczsdjs+fckzmnxrewG5hv9XifBT0L20qG3FCSqwn9Kw
         ILowEqFrJyc8seOceGXFEZZM9uwq7s0NfSYiIFNzWI0wCdcnnm1eRIWiTkrubKjhzX
         3OJtTeKMOWkJZbayyPKsuiiXHjyVmIVTV/YC7zYqGLBW7sWsN1ikMnizPP6r7flX5/
         XU8DlBMFWsvpw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BD6EE15403A8; Thu, 23 Mar 2023 17:19:40 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC rcu 15/19] srcu: Fix long lines in srcu_get_delay()
Date:   Thu, 23 Mar 2023 17:19:34 -0700
Message-Id: <20230324001938.3443499-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <3db82572-f156-4a5d-b711-841aa28bd996@paulmck-laptop>
References: <3db82572-f156-4a5d-b711-841aa28bd996@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit creates an srcu_usage pointer named "sup" as a shorter
synonym for the "ssp->srcu_sup" that was bloating several lines of code.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
---
 kernel/rcu/srcutree.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 22dc266d2090..f6bb9fbe1b9c 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -616,17 +616,18 @@ static unsigned long srcu_get_delay(struct srcu_struct *ssp)
 	unsigned long gpstart;
 	unsigned long j;
 	unsigned long jbase = SRCU_INTERVAL;
+	struct srcu_usage *sup = ssp->srcu_sup;
 
-	if (ULONG_CMP_LT(READ_ONCE(ssp->srcu_sup->srcu_gp_seq), READ_ONCE(ssp->srcu_sup->srcu_gp_seq_needed_exp)))
+	if (ULONG_CMP_LT(READ_ONCE(sup->srcu_gp_seq), READ_ONCE(sup->srcu_gp_seq_needed_exp)))
 		jbase = 0;
-	if (rcu_seq_state(READ_ONCE(ssp->srcu_sup->srcu_gp_seq))) {
+	if (rcu_seq_state(READ_ONCE(sup->srcu_gp_seq))) {
 		j = jiffies - 1;
-		gpstart = READ_ONCE(ssp->srcu_sup->srcu_gp_start);
+		gpstart = READ_ONCE(sup->srcu_gp_start);
 		if (time_after(j, gpstart))
 			jbase += j - gpstart;
 		if (!jbase) {
-			WRITE_ONCE(ssp->srcu_sup->srcu_n_exp_nodelay, READ_ONCE(ssp->srcu_sup->srcu_n_exp_nodelay) + 1);
-			if (READ_ONCE(ssp->srcu_sup->srcu_n_exp_nodelay) > srcu_max_nodelay_phase)
+			WRITE_ONCE(sup->srcu_n_exp_nodelay, READ_ONCE(sup->srcu_n_exp_nodelay) + 1);
+			if (READ_ONCE(sup->srcu_n_exp_nodelay) > srcu_max_nodelay_phase)
 				jbase = 1;
 		}
 	}
-- 
2.40.0.rc2

