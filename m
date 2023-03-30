Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5180F6D1292
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjC3WtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjC3WsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:48:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE4810D;
        Thu, 30 Mar 2023 15:47:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A93CB82A64;
        Thu, 30 Mar 2023 22:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2721AC4339B;
        Thu, 30 Mar 2023 22:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680216449;
        bh=b6bjB25MmPt0K7AqRbN3VyoVhq1Q+MBc4F0mj39Eq+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kGpLiTL7Ra+oH3XkAYQirDufFcvhcz8FZTPmIca8UoHhoYcQCCWMdWvv1JEQk4IWw
         zq6o6j3z60LAuO5Xo0/cGbs464IjYTdi6TmNewgihH2jql4Wm82Y77oZK/EDooOGlB
         eMGc2kiaSaf2xB1afPNemrcDPrsfQSicoGt/sRLqFfqrNA/4Nd9fHa3WUaCnwsyWFD
         mxFLGAo1Q90p1rrCGEnhV+lpecMdJsmVH4zQnUw+UJqlQUJZTCtcxlx1Fn99LndgIO
         h0DC/DikuaHHF5DVTtOqFE1iQbx8jU5MSZAiwZezlRclQDzSsVgbdDpe+3PK5US/Gg
         4EY12OzMHKtsA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 37532154048D; Thu, 30 Mar 2023 15:47:28 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: [PATCH rcu 17/20] srcu: Fix long lines in srcu_get_delay()
Date:   Thu, 30 Mar 2023 15:47:23 -0700
Message-Id: <20230330224726.662344-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
References: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
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
Tested-by: Sachin Sant <sachinp@linux.ibm.com>
Tested-by: "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc: Christoph Hellwig <hch@lst.de>
---
 kernel/rcu/srcutree.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index f9dd6ed5503e..9699bcab7215 100644
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

