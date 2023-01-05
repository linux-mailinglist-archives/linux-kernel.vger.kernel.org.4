Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B40965E181
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbjAEAXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbjAEAXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:23:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA4044375;
        Wed,  4 Jan 2023 16:23:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 281B6B81987;
        Thu,  5 Jan 2023 00:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0088C433F1;
        Thu,  5 Jan 2023 00:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672878187;
        bh=/ECD69jxcNYYwEATRT9YBzkdJrzTS32gHvcq9AJnndw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hpVqoG0SK7CXriUdM8F38SKoj35jgBFggQkLZaV6ufIyNqjzg43BGlmAO1vjkW3Xu
         p6MDNItrdzIYkideWsLk8WNQnvME6pEvPFc48WeLg/a8BpwEj++b9zoYql7/8Y4p0P
         KeJIOK2D7qRqMmsncrUmMlBFDlsKE+gP/KnpEsxsQAAgvqzGajZtPl0YRblraWwx5x
         kfoduOq4aEAYOv3iNyWRySbznB4eGJTilik0beQPzXhXio78iuM7VxnSV2XN282fN0
         li+3Ntqeo2uPkUJnLShuPPWyPfjfrE9hlsd2s30O6OFLurnP4ESyfD5js1LziGuD11
         iKu/42ZLAC2EA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 779BB5C08E5; Wed,  4 Jan 2023 16:23:07 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 03/10] rcu: Throttle callback invocation based on number of ready callbacks
Date:   Wed,  4 Jan 2023 16:22:58 -0800
Message-Id: <20230105002305.1768591-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105002257.GA1768487@paulmck-ThinkPad-P17-Gen-1>
References: <20230105002257.GA1768487@paulmck-ThinkPad-P17-Gen-1>
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

Currently, rcu_do_batch() sizes its batches based on the total number
of callbacks in the callback list.  This can result in some strange
choices, for example, if there was 12,800 callbacks in the list, but
only 200 were ready to invoke, RCU would invoke 100 at a time (12,800
shifted down by seven bits).

A more measured approach would use the number that were actually ready
to invoke, an approach that has become feasible only recently given the
per-segment ->seglen counts in ->cblist.

This commit therefore bases the batch limit on the number of callbacks
ready to invoke instead of on the total number of callbacks.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu_segcblist.c | 2 +-
 kernel/rcu/rcu_segcblist.h | 2 ++
 kernel/rcu/tree.c          | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index c54ea2b6a36bc..f71fac422c8f6 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -89,7 +89,7 @@ static void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
 }
 
 /* Get the length of a segment of the rcu_segcblist structure. */
-static long rcu_segcblist_get_seglen(struct rcu_segcblist *rsclp, int seg)
+long rcu_segcblist_get_seglen(struct rcu_segcblist *rsclp, int seg)
 {
 	return READ_ONCE(rsclp->seglen[seg]);
 }
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 431cee212467d..4fe877f5f6540 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -15,6 +15,8 @@ static inline long rcu_cblist_n_cbs(struct rcu_cblist *rclp)
 	return READ_ONCE(rclp->len);
 }
 
+long rcu_segcblist_get_seglen(struct rcu_segcblist *rsclp, int seg);
+
 /* Return number of callbacks in segmented callback list by summing seglen. */
 long rcu_segcblist_n_segment_cbs(struct rcu_segcblist *rsclp);
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d3b082233b74b..7d3a59d4f37ef 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2057,7 +2057,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	 */
 	rcu_nocb_lock_irqsave(rdp, flags);
 	WARN_ON_ONCE(cpu_is_offline(smp_processor_id()));
-	pending = rcu_segcblist_n_cbs(&rdp->cblist);
+	pending = rcu_segcblist_get_seglen(&rdp->cblist, RCU_DONE_TAIL);
 	div = READ_ONCE(rcu_divisor);
 	div = div < 0 ? 7 : div > sizeof(long) * 8 - 2 ? sizeof(long) * 8 - 2 : div;
 	bl = max(rdp->blimit, pending >> div);
-- 
2.31.1.189.g2e36527f23

