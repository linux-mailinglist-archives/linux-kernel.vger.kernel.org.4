Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26A96FE303
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbjEJRGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236114AbjEJRGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:06:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF96840DC;
        Wed, 10 May 2023 10:06:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B1D963F38;
        Wed, 10 May 2023 17:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9803CC4339C;
        Wed, 10 May 2023 17:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683738370;
        bh=H90atByaaZG57Ja5si+08MrZWAJclHUD/Fm7cc4BBy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zb5FyCgFyVq9kEZcciczkbQBiJssX9KxpfXgBdP7Op/QoO5qstS/dC0UqXuOLZHB5
         Q2cmdAtVzBAV29p+W15urN4LldqNFusI3zwWFg2ZSsuRkrqjIpn4K5nMUpobeldqQ+
         hsTmP1GiQKHjCWnmgHSXuTm5ikzekrNyBtDvlo8FlfmdpUQZh+fMS8kaw+GZ3ccx5C
         QDmGfsJvStbf8ONS6KNNdOmMbhqsfMBvvJRjT6oU2d7v/+Fv0qlZbiyR2WgneJRrPf
         PMxcff/79aG4EXbUpvTbIra9xrpDZFKhQGbhYl6oPh7eGiHmHmKT+sOL9sdUwq8qHm
         c3sHKU5324qZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 32131CE127F; Wed, 10 May 2023 10:06:10 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/4] rcu/nocb: Recheck lazy callbacks under the ->nocb_lock from shrinker
Date:   Wed, 10 May 2023 10:06:06 -0700
Message-Id: <20230510170607.2187978-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <9c5fae22-e25e-4548-b6e9-117495b29e62@paulmck-laptop>
References: <9c5fae22-e25e-4548-b6e9-117495b29e62@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

The ->lazy_len is only checked locklessly. Recheck again under the
->nocb_lock to avoid spending more time on flushing/waking if not
necessary. The ->lazy_len can still increment concurrently (from 1 to
infinity) but under the ->nocb_lock we at least know for sure if there
are lazy callbacks at all (->lazy_len > 0).

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_nocb.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index c321fce2af8e..dfa9c10d6727 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1358,12 +1358,20 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 		if (!rcu_rdp_is_offloaded(rdp))
 			continue;
 
-		_count = READ_ONCE(rdp->lazy_len);
-
-		if (_count == 0)
+		if (!READ_ONCE(rdp->lazy_len))
 			continue;
 
 		rcu_nocb_lock_irqsave(rdp, flags);
+		/*
+		 * Recheck under the nocb lock. Since we are not holding the bypass
+		 * lock we may still race with increments from the enqueuer but still
+		 * we know for sure if there is at least one lazy callback.
+		 */
+		_count = READ_ONCE(rdp->lazy_len);
+		if (!_count) {
+			rcu_nocb_unlock_irqrestore(rdp, flags);
+			continue;
+		}
 		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false));
 		rcu_nocb_unlock_irqrestore(rdp, flags);
 		wake_nocb_gp(rdp, false);
-- 
2.40.1

