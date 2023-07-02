Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EDE7451FB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 22:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbjGBUBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 16:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjGBUBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 16:01:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C981BCC;
        Sun,  2 Jul 2023 12:58:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 920C660C87;
        Sun,  2 Jul 2023 19:57:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6B7C433C7;
        Sun,  2 Jul 2023 19:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688327866;
        bh=4y9MrXKgJtTEJJlZHSjciMrEjHEkk2Ac2XXS2rPb57c=;
        h=From:To:Cc:Subject:Date:From;
        b=BupqXY0Dk2PyEDkrfKpUdV6KkAMr/VP4DFTwyzIRLElMMEdoquPk9QaCyjHKC+k3s
         AUhhI5w8Dn+6to4+ItvOCDFW7XiN5za8UA0wQx2F+IOoSUBlFfP+Ue0VPjF8VKxngm
         sMGQhqD0scpwikgVUcb/wDwA1+lZT9bLyNJgkF0WjRcK+LhMovNzZErABOAvMcc168
         5JTsbz1xIQqdHNS5hWlqX4eGf3HZd+CSxbfqHz71EuZlEluvZ0s07pk/wJI5JyJa8g
         EFs/cvyV/9tRzvfwsDp+LzUr1E3VQGeMTHnzmqNdAWECB8o7pGYkByixxWFsaEIvVU
         93aDY0kgmiS9A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shigeru Yoshida <syoshida@redhat.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Sasha Levin <sashal@kernel.org>, frederic@kernel.org,
        quic_neeraju@quicinc.com, joel@joelfernandes.org,
        josh@joshtriplett.org, boqun.feng@gmail.com, rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 1/4] rcu-tasks: Avoid pr_info() with spin lock in cblist_init_generic()
Date:   Sun,  2 Jul 2023 15:57:39 -0400
Message-Id: <20230702195743.1793074-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.1
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shigeru Yoshida <syoshida@redhat.com>

[ Upstream commit 5fc8cbe4cf0fd34ded8045c385790c3bf04f6785 ]

pr_info() is called with rtp->cbs_gbl_lock spin lock locked.  Because
pr_info() calls printk() that might sleep, this will result in BUG
like below:

[    0.206455] cblist_init_generic: Setting adjustable number of callback queues.
[    0.206463]
[    0.206464] =============================
[    0.206464] [ BUG: Invalid wait context ]
[    0.206465] 5.19.0-00428-g9de1f9c8ca51 #5 Not tainted
[    0.206466] -----------------------------
[    0.206466] swapper/0/1 is trying to lock:
[    0.206467] ffffffffa0167a58 (&port_lock_key){....}-{3:3}, at: serial8250_console_write+0x327/0x4a0
[    0.206473] other info that might help us debug this:
[    0.206473] context-{5:5}
[    0.206474] 3 locks held by swapper/0/1:
[    0.206474]  #0: ffffffff9eb597e0 (rcu_tasks.cbs_gbl_lock){....}-{2:2}, at: cblist_init_generic.constprop.0+0x14/0x1f0
[    0.206478]  #1: ffffffff9eb579c0 (console_lock){+.+.}-{0:0}, at: _printk+0x63/0x7e
[    0.206482]  #2: ffffffff9ea77780 (console_owner){....}-{0:0}, at: console_emit_next_record.constprop.0+0x111/0x330
[    0.206485] stack backtrace:
[    0.206486] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.19.0-00428-g9de1f9c8ca51 #5
[    0.206488] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-1.fc36 04/01/2014
[    0.206489] Call Trace:
[    0.206490]  <TASK>
[    0.206491]  dump_stack_lvl+0x6a/0x9f
[    0.206493]  __lock_acquire.cold+0x2d7/0x2fe
[    0.206496]  ? stack_trace_save+0x46/0x70
[    0.206497]  lock_acquire+0xd1/0x2f0
[    0.206499]  ? serial8250_console_write+0x327/0x4a0
[    0.206500]  ? __lock_acquire+0x5c7/0x2720
[    0.206502]  _raw_spin_lock_irqsave+0x3d/0x90
[    0.206504]  ? serial8250_console_write+0x327/0x4a0
[    0.206506]  serial8250_console_write+0x327/0x4a0
[    0.206508]  console_emit_next_record.constprop.0+0x180/0x330
[    0.206511]  console_unlock+0xf7/0x1f0
[    0.206512]  vprintk_emit+0xf7/0x330
[    0.206514]  _printk+0x63/0x7e
[    0.206516]  cblist_init_generic.constprop.0.cold+0x24/0x32
[    0.206518]  rcu_init_tasks_generic+0x5/0xd9
[    0.206522]  kernel_init_freeable+0x15b/0x2a2
[    0.206523]  ? rest_init+0x160/0x160
[    0.206526]  kernel_init+0x11/0x120
[    0.206527]  ret_from_fork+0x1f/0x30
[    0.206530]  </TASK>
[    0.207018] cblist_init_generic: Setting shift to 1 and lim to 1.

This patch moves pr_info() so that it is called without
rtp->cbs_gbl_lock locked.

Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
Tested-by: "Zhang, Qiang1" <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/tasks.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 5f4fc8184dd0b..65df1aaf0ce9b 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -241,7 +241,6 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 	if (rcu_task_enqueue_lim < 0) {
 		rcu_task_enqueue_lim = 1;
 		rcu_task_cb_adjust = true;
-		pr_info("%s: Setting adjustable number of callback queues.\n", __func__);
 	} else if (rcu_task_enqueue_lim == 0) {
 		rcu_task_enqueue_lim = 1;
 	}
@@ -272,6 +271,10 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 		raw_spin_unlock_rcu_node(rtpcp); // irqs remain disabled.
 	}
 	raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
+
+	if (rcu_task_cb_adjust)
+		pr_info("%s: Setting adjustable number of callback queues.\n", __func__);
+
 	pr_info("%s: Setting shift to %d and lim to %d.\n", __func__, data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim));
 }
 
-- 
2.39.2

