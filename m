Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11AE5EFCA8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 20:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbiI2SHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 14:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234945AbiI2SHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 14:07:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F241BB201;
        Thu, 29 Sep 2022 11:07:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEF286212A;
        Thu, 29 Sep 2022 18:07:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1217BC433B5;
        Thu, 29 Sep 2022 18:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664474853;
        bh=uclQIQLTJ0Fjb3CMUb437WvxBUVstCALy43H9B1aM3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VN0iCDJk+EscJuOxBhF0itxf0wqtjB5HxrDz9dA63DNow+kYrSl+diHvpnuIKimii
         8SMKtPRHJkxKkyhJiLyFBy4nrN020LquBAWW/2mqbk9WjJ1RqbJZVNQ84uRjQL4sKP
         0/eXPB5NgyOTp/oChgJDUa/NN5BZTX4hmS3tjqhn6l7wXmSOXXZb8KJKUzge7JaRJM
         Qlpn6G6f9CSS0AA23BzqONxkVYZeYn8U+jYDf6Iz1inhXJFn8Sd/l3vnHH/qvHh1UR
         woWzO/X68nSDe3Z4W76KBXSPaEarm4/u59XQq4EIwR5dF35cdOQkCE8uRwiDicT6g6
         zKSeK9sOzQc0A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B07815C0C51; Thu, 29 Sep 2022 11:07:32 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH RFC v2 rcu 4/8] srcu: Check for consistent global per-srcu_struct NMI safety
Date:   Thu, 29 Sep 2022 11:07:27 -0700
Message-Id: <20220929180731.2875722-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
References: <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds runtime checks to verify that a given srcu_struct uses
consistent NMI-safe (or not) read-side primitives globally, but based
on the per-CPU data.  These global checks are made by the grace-period
code that must scan the srcu_data structures anyway, and are done only
in kernels built with CONFIG_PROVE_RCU=y.

Link: https://lore.kernel.org/all/20220910221947.171557773@linutronix.de/

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>
---
 kernel/rcu/srcutree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 09a11f2c2042..5772b8659c89 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -429,13 +429,18 @@ static unsigned long srcu_readers_lock_idx(struct srcu_struct *ssp, int idx)
 static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
 {
 	int cpu;
+	unsigned long mask = 0;
 	unsigned long sum = 0;
 
 	for_each_possible_cpu(cpu) {
 		struct srcu_data *cpuc = per_cpu_ptr(ssp->sda, cpu);
 
 		sum += atomic_long_read(&cpuc->srcu_unlock_count[idx]);
+		if (IS_ENABLED(CONFIG_PROVE_RCU))
+			mask = mask | READ_ONCE(cpuc->srcu_nmi_safety);
 	}
+	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && (mask & (mask >> 1)),
+		  "Mixed NMI-safe readers for srcu_struct at %ps.\n", ssp);
 	return sum;
 }
 
-- 
2.31.1.189.g2e36527f23

