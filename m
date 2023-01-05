Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DB265E197
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbjAEAct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235582AbjAEAcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:32:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B35C4FCE2;
        Wed,  4 Jan 2023 16:28:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA139B81983;
        Thu,  5 Jan 2023 00:28:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E574C433F1;
        Thu,  5 Jan 2023 00:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672878534;
        bh=Ha2dM3gCkM55/S1n8yiTSEQTQ/eXUzvcppYZQNnro2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BQcuSLm3QV+zcN9Fj7bxsvWjBoK/SP/cR7hoEXV65A0bvBLtqSAs07ukClZvjxc+Q
         XfquZRqty8QtYDsy4G822O4ho8aLZqOuw/Ru6kds+9CEf+UZiA0Jp4T9bhkc9BbBHI
         l0RdCCNEWGX6SPWgGA3+G3AZyeLsK2KDLP2jR98ipG8pleLMrGofOnOOSkOHF+GCwq
         QDnSxK2/DE3OaEpZ1YCpvDLjU1U3H61W2DWiPxgPtalUXSYb8kLhqHjYkK+A1xmkHQ
         WC9nTKDeD6hvHFrdv0qmS/h1Th/Vec5fD7qu32LcPpfoB1RD7srNuz4GcuxO5KIU7a
         Jen1il+/VIe8g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4AEA45C1456; Wed,  4 Jan 2023 16:28:54 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Pingfan Liu <kernelfans@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH rcu 4/9] srcu: Fix the comparision in srcu_invl_snp_seq()
Date:   Wed,  4 Jan 2023 16:28:48 -0800
Message-Id: <20230105002853.1769401-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105002845.GA1769240@paulmck-ThinkPad-P17-Gen-1>
References: <20230105002845.GA1769240@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pingfan Liu <kernelfans@gmail.com>

A grace-period sequence number contains two fields: counter and
state.  SRCU_SNP_INIT_SEQ provides a guaranteed invalid value for
grace-period sequence numbers in newly allocated srcu_node structures'
->srcu_have_cbs[] and ->srcu_gp_seq_needed_exp fields.  The point of the
comparison in srcu_invl_snp_seq() is not to detect invalid grace-period
sequence numbers in general, but rather to detect a newly allocated
srcu_node structure whose ->srcu_have_cbs[] and ->srcu_gp_seq_needed_exp
fields need to be brought into line with the srcu_struct structure's
->srcu_gp_seq field.

This commit therefore causes srcu_invl_snp_seq() to compare both fields
of the specified grace-period sequence number.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: <rcu@vger.kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 16953784a0bdf..6af0312005801 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -154,7 +154,7 @@ static void init_srcu_struct_data(struct srcu_struct *ssp)
  */
 static inline bool srcu_invl_snp_seq(unsigned long s)
 {
-	return rcu_seq_state(s) == SRCU_SNP_INIT_SEQ;
+	return s == SRCU_SNP_INIT_SEQ;
 }
 
 /*
-- 
2.31.1.189.g2e36527f23

