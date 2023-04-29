Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530366F224A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 03:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347147AbjD2B7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 21:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347375AbjD2B7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 21:59:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0756A44BE;
        Fri, 28 Apr 2023 18:59:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 886D864625;
        Sat, 29 Apr 2023 01:59:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8ABBC4339B;
        Sat, 29 Apr 2023 01:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682733547;
        bh=jvnL9nJ59DFNmrdN6Y6tqV1NmAFjnvOmzEZrnINq1RQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Tm19YA4xQz4dkxXCTHbQPdUC/gXclb2rjR3Me0OYroC4fev92p5dhSGzl3HRG9BIL
         ap9X63osrbe231eEoVpXZxQDNlDTArZxJ5RLCV1ZuQ8JaKA1edirs1yyLyehFmL7en
         0JNgJieErv+Ll8EMckW0Hq/jW2vewJCozdCEZROG4ZPJHXzAVw1iGTDliL41py0nxE
         bLXFiq+m1Xbu/QtfVW5geVgqX9w/2EDy/raIOV4zngBNxEotXLsUWFlkqcEQfRDV04
         EXINWfzkGxZXR0B29ftB0DgoipW17rpozbmFzvyRyBJQtjUh4rcHZnKDpKqxMNlcsQ
         RyyjFbNxRaVgg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sasha Levin <sashal@kernel.org>, dave@stgolabs.net,
        josh@joshtriplett.org, frederic@kernel.org,
        quic_neeraju@quicinc.com, rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 1/3] refscale: Move shutdown from wait_event() to wait_event_idle()
Date:   Fri, 28 Apr 2023 21:59:02 -0400
Message-Id: <20230429015904.3027337-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

[ Upstream commit 6bc6e6b27524304aadb9c04611ddb1c84dd7617a ]

The ref_scale_shutdown() kthread/function uses wait_event() to wait for
the refscale test to complete.  However, although the read-side tests
are normally extremely fast, there is no law against specifying a very
large value for the refscale.loops module parameter or against having
a slow read-side primitive.  Either way, this might well trigger the
hung-task timeout.

This commit therefore replaces those wait_event() calls with calls to
wait_event_idle(), which do not trigger the hung-task timeout.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/refscale.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 435c884c02b5c..d49a9d66e0000 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -795,7 +795,7 @@ ref_scale_cleanup(void)
 static int
 ref_scale_shutdown(void *arg)
 {
-	wait_event(shutdown_wq, shutdown_start);
+	wait_event_idle(shutdown_wq, shutdown_start);
 
 	smp_mb(); // Wake before output.
 	ref_scale_cleanup();
-- 
2.39.2

