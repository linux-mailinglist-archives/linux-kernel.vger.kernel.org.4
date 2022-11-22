Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2535F6331D2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 02:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbiKVBFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 20:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiKVBE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 20:04:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BA51E3C8;
        Mon, 21 Nov 2022 17:04:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2C31B818BC;
        Tue, 22 Nov 2022 01:04:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2792FC43153;
        Tue, 22 Nov 2022 01:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669079063;
        bh=tEjic2DFB31t8ylkVSWil0ue1UwVOCBgRrj8WJMVg8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RZFElDl2xa4aU5vs66KvPsfhJM1wHZrsTZBTpjiD4mvRVzWPd/qFRpvxjTHLDtbpR
         81R58GX8DRLeUP4eWFKGcCWLVnO3hj4SovbJDEh92KpZlSlmDtI9pvZzAxG20JMlG9
         Y2iuiCPzH+qhERyfj4mAo6wFBtjvY9uYJAPqRXqpovdimnt9NhP4ByYdTZWy4USGMC
         BgdSNXKfQ64/8o92FmI0Ep069lODyXBJqCbHSBnGp5hY2GUWFneAMvJVet4vivyAsQ
         FBZBvm4LvG4XrYDxOEC5lZbtq8JWMq4MXt78BrPxWo+G1xzax7oRkLe9zOLFvusB8M
         HrsI8JtVdB9oQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 837DC5C146A; Mon, 21 Nov 2022 17:04:22 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 rcu 10/16] rcu/rcuscale: Use call_rcu_flush() for async reader test
Date:   Mon, 21 Nov 2022 17:04:15 -0800
Message-Id: <20221122010421.3799681-10-paulmck@kernel.org>
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

rcuscale uses call_rcu() to queue async readers. With recent changes to
save power, the test will have fewer async readers in flight. Use the
call_rcu_flush() API instead to revert to the old behavior.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcuscale.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 3baded807a616..3b149e745a0f6 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -176,7 +176,7 @@ static struct rcu_scale_ops rcu_ops = {
 	.get_gp_seq	= rcu_get_gp_seq,
 	.gp_diff	= rcu_seq_diff,
 	.exp_completed	= rcu_exp_batches_completed,
-	.async		= call_rcu,
+	.async		= call_rcu_flush,
 	.gp_barrier	= rcu_barrier,
 	.sync		= synchronize_rcu,
 	.exp_sync	= synchronize_rcu_expedited,
-- 
2.31.1.189.g2e36527f23

