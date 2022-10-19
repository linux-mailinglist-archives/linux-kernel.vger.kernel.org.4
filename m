Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969C3605372
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiJSWwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbiJSWvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:51:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6BF190477;
        Wed, 19 Oct 2022 15:51:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADC9DB824C1;
        Wed, 19 Oct 2022 22:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1877CC4314A;
        Wed, 19 Oct 2022 22:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666219907;
        bh=uyDGWyzfPaiQ/+Iwibul18/2tA5ta5E2a9H+CSNE/yA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FOIF4YT+jBvQCcjeX7q5P1woLdrAJJIJMkH/cVsGSyyZwzbRa3M4Cp3SUpwH1c/cd
         YzuPiSfWWB+c3rbYEIP6mZ15C58H0GHc2rkupVlCC/i9TojgYm1epLbEM6olCoMdH+
         pVdGyxu1y73xPhJ1G+TE9NTs0WJvimU3uTnJB1qMAdDygUb1t3K/jlTq+Z02QxwegQ
         9rv1YLiBVL+7WUbosqD/JsMq8be8XghLcaOIzRSlsAWtRO5YNTkfBff2hihW6nEdk4
         g7JAbuGEsmC6T48BPyC2dZ7vUEBw/R6wA0dycUCiHf8x1W3Fo+n3cbUInLm0yDPKSp
         icbz2T/6l7wOA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 860145C0BE8; Wed, 19 Oct 2022 15:51:46 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 09/14] rcu/sync: Use call_rcu_flush() instead of call_rcu
Date:   Wed, 19 Oct 2022 15:51:39 -0700
Message-Id: <20221019225144.2500095-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221019225138.GA2499943@paulmck-ThinkPad-P17-Gen-1>
References: <20221019225138.GA2499943@paulmck-ThinkPad-P17-Gen-1>
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

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

call_rcu() changes to save power will slow down rcu sync. Use the
call_rcu_flush() API instead which reverts to the old behavior.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
index 5cefc702158fe..bdce3b5d7f714 100644
--- a/kernel/rcu/sync.c
+++ b/kernel/rcu/sync.c
@@ -44,7 +44,7 @@ static void rcu_sync_func(struct rcu_head *rhp);
 
 static void rcu_sync_call(struct rcu_sync *rsp)
 {
-	call_rcu(&rsp->cb_head, rcu_sync_func);
+	call_rcu_flush(&rsp->cb_head, rcu_sync_func);
 }
 
 /**
-- 
2.31.1.189.g2e36527f23

