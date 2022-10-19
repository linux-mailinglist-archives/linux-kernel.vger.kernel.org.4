Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF83760535C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiJSWrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiJSWrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:47:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBEE17C167;
        Wed, 19 Oct 2022 15:47:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 928ED619E9;
        Wed, 19 Oct 2022 22:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC272C43470;
        Wed, 19 Oct 2022 22:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666219621;
        bh=+mIw1jy8wj3gxm+o9ZlbmvXenuiwqx+JElmYZGbXaeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jZ9Z0O4bxNI1YlzPyEqaNEYwOgorClEeEvpkHvp2pmO6GzXevqCV3HxCsEQqCysOu
         bmpwnxQkAHY3unTeNRtyIKVQfx5peSYFKdS3cri2lzyajtFdxKd1Sy8izG2XH0tEfT
         DxQ/ZPj+Q0TRLxJCPp2RHrMk//Q8/2JZTfYObUG4EhM1yL+w0aGD5BMW07/pLaSWu+
         ihoL++h+iI9JvfAYPU4ifHt13KidQ6HWdyj0+w9H4FrRSepBvE3fDIUCa9EHYZ5pbj
         sTOvJlTYpyQeR8xJSK16uUQV3qWt6w3SVDmE3Pz2U3wMDeiYgBraK7p+EGRFse76Ab
         PHR0j5Jf0qN5A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AB23C5C0920; Wed, 19 Oct 2022 15:47:00 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/8] rcu: Use READ_ONCE() for lockless read of rnp->qsmask
Date:   Wed, 19 Oct 2022 15:46:55 -0700
Message-Id: <20221019224659.2499511-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221019224652.GA2499358@paulmck-ThinkPad-P17-Gen-1>
References: <20221019224652.GA2499358@paulmck-ThinkPad-P17-Gen-1>
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

The rnp->qsmask is locklessly accessed from rcutree_dying_cpu(). This
may help avoid load tearing due to concurrent access, KCSAN
issues, and preserve sanity of people reading the mask in tracing.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0ca21ac0f0648..5ec97e3f7468f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2106,7 +2106,7 @@ int rcutree_dying_cpu(unsigned int cpu)
 	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
 		return 0;
 
-	blkd = !!(rnp->qsmask & rdp->grpmask);
+	blkd = !!(READ_ONCE(rnp->qsmask) & rdp->grpmask);
 	trace_rcu_grace_period(rcu_state.name, READ_ONCE(rnp->gp_seq),
 			       blkd ? TPS("cpuofl-bgp") : TPS("cpuofl"));
 	return 0;
-- 
2.31.1.189.g2e36527f23

