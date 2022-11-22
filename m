Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7190E6331D3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 02:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbiKVBFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 20:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbiKVBE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 20:04:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CB81E711;
        Mon, 21 Nov 2022 17:04:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0FB8B818E7;
        Tue, 22 Nov 2022 01:04:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6D6C43152;
        Tue, 22 Nov 2022 01:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669079063;
        bh=uyDGWyzfPaiQ/+Iwibul18/2tA5ta5E2a9H+CSNE/yA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CFD1MnASm3nHVWtRNYrL1YNSkJ5NsCu6EMrtc9wT9RYHFupnOEhBIAelJJBkbzfGL
         seRGP7i+PbVg1o0P3F1yYAPd3lyPeCP89i7G3HCyh1Yv2OdZmtWtWY2D7lQ6m2ik6S
         tTy8OF9izkP9LALFdQy2sxTkMETa6y9JhV0xijdnV7JSV0nk1zGEAM4OispMp4zXi2
         20ag4F1cNLMmHLWWwfLlY+W9hIoK+z4kDZR0I9gS0SoA9wxDdH6r7XvH6mtchSbpcD
         DKKtg8DLBSgLnq7hdM6bn6h1dGUIgGSqhWoppMo0DBYToKWLv5JVS5Z2JO1tePUUKi
         cwSGc+lBsYzHg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 814A35C1409; Mon, 21 Nov 2022 17:04:22 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 rcu 09/16] rcu/sync: Use call_rcu_flush() instead of call_rcu
Date:   Mon, 21 Nov 2022 17:04:14 -0800
Message-Id: <20221122010421.3799681-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221122010408.GA3799268@paulmck-ThinkPad-P17-Gen-1>
References: <20221122010408.GA3799268@paulmck-ThinkPad-P17-Gen-1>
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

