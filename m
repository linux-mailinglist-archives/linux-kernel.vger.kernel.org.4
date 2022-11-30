Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB6663DCD3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiK3SOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiK3SNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:13:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB69C880E0;
        Wed, 30 Nov 2022 10:13:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 464DF61D61;
        Wed, 30 Nov 2022 18:13:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E148C43153;
        Wed, 30 Nov 2022 18:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669832008;
        bh=NFAW1d1m+42EgepEaaKguo2hXsVIBXe6LMvkxK6/6ng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RrdwL+VEqHefMoZWMlt0MZVQrCX0hEEnO1UrqAtETnTeRw4rvuEZwfy/oai95PA2+
         w0YezOcB9Cjpxr+sGIwHjhI8eLE0QvwV45qGjqZFH8lPxtmaa5QVtGqedkfjk3pvU9
         1eysAwZV7m1EnR7tq7y463fBh+pZC3J6vwUcQ7ZAYAjDx2CrObhCSbr9ERPcZ6PUcT
         0lF0Oukih3H/9iX3Qt3h/iLuTOkw/TQPcsw+f5qfX/UetXEV42MG9xaB921OR770yq
         476dl+YbpwQOMrgDhR5g3uReIo1jn+IvkCBHnZP0Z+zpnqvLEJiomT3rTpc+fZy5jM
         SlCp+SoLxUY9A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 65B725C14C2; Wed, 30 Nov 2022 10:13:27 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 09/16] rcu/rcuscale: Use call_rcu_hurry() for async reader test
Date:   Wed, 30 Nov 2022 10:13:18 -0800
Message-Id: <20221130181325.1012760-9-paulmck@kernel.org>
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

rcuscale uses call_rcu() to queue async readers. With recent changes to
save power, the test will have fewer async readers in flight. Use the
call_rcu_hurry() API instead to revert to the old behavior.

[ paulmck: Apply s/call_rcu_flush/call_rcu_hurry/ feedback from Tejun Heo. ]

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcuscale.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 3baded807a616..91fb5905a008f 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -176,7 +176,7 @@ static struct rcu_scale_ops rcu_ops = {
 	.get_gp_seq	= rcu_get_gp_seq,
 	.gp_diff	= rcu_seq_diff,
 	.exp_completed	= rcu_exp_batches_completed,
-	.async		= call_rcu,
+	.async		= call_rcu_hurry,
 	.gp_barrier	= rcu_barrier,
 	.sync		= synchronize_rcu,
 	.exp_sync	= synchronize_rcu_expedited,
-- 
2.31.1.189.g2e36527f23

