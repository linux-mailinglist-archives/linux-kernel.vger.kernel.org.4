Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767FC63DCDC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiK3SOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiK3SNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:13:32 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF24880E6;
        Wed, 30 Nov 2022 10:13:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0CC9ECE1AD0;
        Wed, 30 Nov 2022 18:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEA6C4314D;
        Wed, 30 Nov 2022 18:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669832008;
        bh=MK8lzAbrXYSo4oOc8yMliggTzQ2OiQszviHhFcYo3R0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FjfU2kltztzGEEUXpT6+A2WCfTFbhIFo9O3pV8l+Ck6OClIeYBR8pxnnK7hu8gWgy
         rioIlnCjCJP9JdqMpzTz41HVKQWT/xosRznfzCu6P1//+IAtZrjDhSYUZoHCNrLsDi
         LTmAE61tiDqfFpQfQlPD14AYIrt/oMrqt8fTYdNITNJog2uWgxA1aATWO9MX5u31tZ
         Lit0BwOw+OzHWwRMlNZBCU83hD4khg4XDZC2KxSvQ85bUzremDXiPde7Pzpwzpzs0c
         7SN1iHzydYSrmNjtY7UvAsNuiyc7FbcqK9nhpjYCIIs5/4KGrz55k15Ru/9BY3ogon
         4LhQG/tfGAwVw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 63FAA5C14B8; Wed, 30 Nov 2022 10:13:27 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 08/16] rcu/sync: Use call_rcu_hurry() instead of call_rcu
Date:   Wed, 30 Nov 2022 10:13:17 -0800
Message-Id: <20221130181325.1012760-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221130181316.GA1012431@paulmck-ThinkPad-P17-Gen-1>
References: <20221130181316.GA1012431@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

call_rcu() changes to save power will slow down rcu sync. Use the
call_rcu_hurry() API instead which reverts to the old behavior.

[ paulmck: Apply s/call_rcu_flush/call_rcu_hurry/ feedback from Tejun Heo. ]

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
index 5cefc702158fe..e550f97779b8d 100644
--- a/kernel/rcu/sync.c
+++ b/kernel/rcu/sync.c
@@ -44,7 +44,7 @@ static void rcu_sync_func(struct rcu_head *rhp);
 
 static void rcu_sync_call(struct rcu_sync *rsp)
 {
-	call_rcu(&rsp->cb_head, rcu_sync_func);
+	call_rcu_hurry(&rsp->cb_head, rcu_sync_func);
 }
 
 /**
-- 
2.31.1.189.g2e36527f23

