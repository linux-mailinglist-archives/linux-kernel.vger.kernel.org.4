Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFD1668839
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 01:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240324AbjAMAMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 19:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240200AbjAMALm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 19:11:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E469F5D8BF;
        Thu, 12 Jan 2023 16:11:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 917BB621FF;
        Fri, 13 Jan 2023 00:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD342C4333C;
        Fri, 13 Jan 2023 00:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673568695;
        bh=UDe46kmvGKh/94AkLoKQ4CWieFrtLxYGYLFUP7JKd6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IWRzNQlPaUoYAKDMYZDZlvXLhzA/Qy//sa6+Tw5eoeloWo4VasCNeE963jYxMVKNt
         c978Qdbz42BcLIuIQQkmfUUgwtdzVNOQCD/IXgbco8boOqeRy7f9ae9sCNLl8b3yeG
         5KR+4AiHPQvQh/0zfaFPjnjwngMjkgtgyvwlCyr+z98r080N3t0rPGlRLfTBZNMtFt
         C8dgV43+hL1AVRJAg0nVwqee5pXy5lo9Km97yoGBLPeBQjADztY4X3G7vwFplMaOsx
         qe+90GI+Dz95qcFbi0WT4mNX/bxlL9eCpB/eE71P9NhkogFrEZtrjCb9uR6stkpxpt
         1lEHPmpope+YA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BBF0A5C1CB1; Thu, 12 Jan 2023 16:11:34 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH rcu v2 20/20] rcu: Remove CONFIG_SRCU
Date:   Thu, 12 Jan 2023 16:11:32 -0800
Message-Id: <20230113001132.3375334-20-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230113001103.GA3374173@paulmck-ThinkPad-P17-Gen-1>
References: <20230113001103.GA3374173@paulmck-ThinkPad-P17-Gen-1>
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

Now that all references to CONFIG_SRCU have been removed, it is time to
remove CONFIG_SRCU itself.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/rcu/Kconfig                                          | 3 ---
 tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt | 4 ----
 2 files changed, 7 deletions(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index ab62074174c32..9071182b1284b 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -53,9 +53,6 @@ config RCU_EXPERT
 
 	  Say N if you are unsure.
 
-config SRCU
-	def_bool y
-
 config TINY_SRCU
 	bool
 	default y if TINY_RCU
diff --git a/tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt b/tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt
index 42acb1a64ce10..3f5fb66f16df7 100644
--- a/tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt
+++ b/tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt
@@ -71,9 +71,5 @@ CONFIG_TASKS_RCU
 
 	These are controlled by CONFIG_PREEMPT and/or CONFIG_SMP.
 
-CONFIG_SRCU
-
-	Selected by CONFIG_RCU_TORTURE_TEST, so cannot disable.
-
 
 boot parameters ignored: TBD
-- 
2.31.1.189.g2e36527f23

