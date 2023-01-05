Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED9965E1A8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbjAEAee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240764AbjAEAdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:33:52 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40434FD40;
        Wed,  4 Jan 2023 16:29:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 32357CE1934;
        Thu,  5 Jan 2023 00:28:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE60C433A4;
        Thu,  5 Jan 2023 00:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672878534;
        bh=5vxYK89j5YHZsxfS7wUlDVPwottBntvIs8Ry6959CXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BMI3YdMe4ld43vl64CAmjxCRj9DZLg3Mei2P2/Zd3Cz5nSOMMuqWdA0o3/0fJCBIi
         iZ18cmqtU07LtxFzmxjCiqNjkvzi1sQRr2lejr1wKZXgV3kPbi8ERwVttXV8GArmK6
         y1ISvfbgtUAvHqmpKpXXg1MpsgpSR4O/EM/0bLiO+GgwWp4Ba6EBwtC0a2BTXvB8br
         D2BaJww9OukS9YJzopMYrCZHgYgHRXIzZMSGy1j7/MorE28s2aFPFbcE22KJL3OfiT
         DxET4eOqCkd6kJEUZPIftqpkWLM7U3YE3FbB66gKmk8D71v+7rXo1S+TntF2zje+EO
         kEIJ+9KLfpH8A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4EE8A5C1ADF; Wed,  4 Jan 2023 16:28:54 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 6/9] rcu: Add test code for semaphore-like SRCU readers
Date:   Wed,  4 Jan 2023 16:28:50 -0800
Message-Id: <20230105002853.1769401-6-paulmck@kernel.org>
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

This commit adds trivial test code for srcu_down_read() and
srcu_up_read().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/update.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index a5b4abbee6439..a72f98c120f09 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -555,9 +555,12 @@ struct early_boot_kfree_rcu {
 static void early_boot_test_call_rcu(void)
 {
 	static struct rcu_head head;
+	int idx;
 	static struct rcu_head shead;
 	struct early_boot_kfree_rcu *rhp;
 
+	idx = srcu_down_read(&early_srcu);
+	srcu_up_read(&early_srcu, idx);
 	call_rcu(&head, test_callback);
 	early_srcu_cookie = start_poll_synchronize_srcu(&early_srcu);
 	call_srcu(&early_srcu, &shead, test_callback);
-- 
2.31.1.189.g2e36527f23

