Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572D360538B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiJSW67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiJSW6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:58:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DC31CC741;
        Wed, 19 Oct 2022 15:58:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32619619D6;
        Wed, 19 Oct 2022 22:58:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B38C4315E;
        Wed, 19 Oct 2022 22:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666220328;
        bh=vcOf9CMrU+6NN6qjpATXbQFTM1BXdbCbv7vFEbo3qjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tBBT+O+tdFhyraHK1mTg82F6rvkz9Afq3DB3uSS+If39hRs3+6Rwd6Ixl1N/VNOol
         DEBxL+oTy7c6xrpF/vTdn1VBUBX2MqOCLp91dt3myP+U6qlEBcwaW4QnhOMiBMum/c
         sWHM+yE/NMFPt6J6boNnvxQxbBD1bwuyubIAwqTl6dpze6T3hOxAyOHXVHHGerKGa0
         HRgPT4SGikXeEoUrsl8yuwJO8hzvrTNbn7xP9ItcNCgWeEGIWzV3wjEJa4iuV1s34n
         x7pAKLdDdeWMywbF12fYUNc9iGL7wV0fd47O7rSQsvkPOOzwAfOPFNYJXxMwor35oh
         VEIihypUyELbA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BB57A5C0BE8; Wed, 19 Oct 2022 15:58:47 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v3 rcu 09/11] srcu: Warn when NMI-unsafe API is used in NMI
Date:   Wed, 19 Oct 2022 15:58:44 -0700
Message-Id: <20221019225846.2501109-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221019225838.GA2500612@paulmck-ThinkPad-P17-Gen-1>
References: <20221019225838.GA2500612@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

Using the NMI-unsafe reader API from within an NMI handler is very likely
to be buggy for three reasons:

1) NMIs aren't strictly re-entrant (a pending nested NMI will execute at
   the end of the current one) so it should be fine to use a non-atomic
   increment here. However, breakpoints can still interrupt NMIs and if
   a breakpoint callback has a reader on that same ssp, a racy increment
   can happen.

2) If the only reader site for a given srcu_struct structure is in an
   NMI handler, then RCU should be used instead of SRCU.

3) Because of the previous reason (2), an srcu_struct structure having
   an SRCU read side critical section in an NMI handler is likely to
   have another one from a task context.

For all these reasons, warn if an NMI-unsafe reader API is used from an
NMI handler.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 87ae6f5c1edae..18bb696cff8ca 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -642,6 +642,8 @@ static void srcu_check_nmi_safety(struct srcu_struct *ssp, bool nmi_safe)
 
 	if (!IS_ENABLED(CONFIG_PROVE_RCU))
 		return;
+	/* NMI-unsafe use in NMI is a bad sign */
+	WARN_ON_ONCE(!nmi_safe && in_nmi());
 	sdp = raw_cpu_ptr(ssp->sda);
 	old_nmi_safe_mask = READ_ONCE(sdp->srcu_nmi_safety);
 	if (!old_nmi_safe_mask) {
-- 
2.31.1.189.g2e36527f23

