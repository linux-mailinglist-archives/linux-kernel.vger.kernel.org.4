Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B3665E1F3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjAEAs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjAEAsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:48:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA6F30543;
        Wed,  4 Jan 2023 16:45:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4B736189A;
        Thu,  5 Jan 2023 00:45:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D39C43392;
        Thu,  5 Jan 2023 00:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879503;
        bh=bsB5dxI29c3QNEaB4l1cl2DOXyvWSbIPCGoroiZvYMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bhANtMsA9RsT0hm3RhSk6Nk27I3yIQpk0zTwJgLZOymKm/HRxRCkvmLaC5baJKeVJ
         S32SqHWbJ4wV1M+Q5CVpQgBYsSyFwGlpZ3BbxptzM/nSdc5o7gO6skKD1uToCae+vh
         TMfQAxM4GXtxTFjacJxj+BaH+QtpnLQEgEAv1c7UR3Xua8d8eG3dzrJdPfTdDESrdL
         8Fm+2zLa8GBqaNHwFv5XQZu5mk+FT27Z7Xsy67SsOSbr+WPDaSaJCoCs6On97jgMMY
         F0ThLq8zu57KI1x37uViYVJHEeLwlGI+zKRkxXrkI1kCoIXINc26WPEHIsBaPwsMDI
         GmA7lbQeW9Abw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DF4195C1456; Wed,  4 Jan 2023 16:45:02 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/7] refscale: Provide for initialization failure
Date:   Wed,  4 Jan 2023 16:44:52 -0800
Message-Id: <20230105004501.1771332-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105004454.GA1771168@paulmck-ThinkPad-P17-Gen-1>
References: <20230105004454.GA1771168@paulmck-ThinkPad-P17-Gen-1>
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

Current tests all have init() functions that are guaranteed to succeed.
But upcoming tests will need to allocate memory, thus possibly failing.
This commit therefore handles init() function failure.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refscale.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 435c884c02b5c..7f12168627a1f 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -124,7 +124,7 @@ static int exp_idx;
 
 // Operations vector for selecting different types of tests.
 struct ref_scale_ops {
-	void (*init)(void);
+	bool (*init)(void);
 	void (*cleanup)(void);
 	void (*readsection)(const int nloops);
 	void (*delaysection)(const int nloops, const int udl, const int ndl);
@@ -162,8 +162,9 @@ static void ref_rcu_delay_section(const int nloops, const int udl, const int ndl
 	}
 }
 
-static void rcu_sync_scale_init(void)
+static bool rcu_sync_scale_init(void)
 {
+	return true;
 }
 
 static struct ref_scale_ops rcu_ops = {
@@ -315,9 +316,10 @@ static struct ref_scale_ops refcnt_ops = {
 // Definitions for rwlock
 static rwlock_t test_rwlock;
 
-static void ref_rwlock_init(void)
+static bool ref_rwlock_init(void)
 {
 	rwlock_init(&test_rwlock);
+	return true;
 }
 
 static void ref_rwlock_section(const int nloops)
@@ -351,9 +353,10 @@ static struct ref_scale_ops rwlock_ops = {
 // Definitions for rwsem
 static struct rw_semaphore test_rwsem;
 
-static void ref_rwsem_init(void)
+static bool ref_rwsem_init(void)
 {
 	init_rwsem(&test_rwsem);
+	return true;
 }
 
 static void ref_rwsem_section(const int nloops)
@@ -833,7 +836,10 @@ ref_scale_init(void)
 		goto unwind;
 	}
 	if (cur_ops->init)
-		cur_ops->init();
+		if (!cur_ops->init()) {
+			firsterr = -EUCLEAN;
+			goto unwind;
+		}
 
 	ref_scale_print_module_parms(cur_ops, "Start of test");
 
-- 
2.31.1.189.g2e36527f23

