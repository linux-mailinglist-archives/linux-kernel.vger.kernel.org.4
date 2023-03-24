Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECCA6C8716
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 21:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjCXUw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 16:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbjCXUwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:52:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0838E1F921;
        Fri, 24 Mar 2023 13:52:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DB3A62CBB;
        Fri, 24 Mar 2023 20:52:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCAC2C4339C;
        Fri, 24 Mar 2023 20:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679691170;
        bh=xIAddEU+WGJoAW1SFrSP2UY+CCmqTszBpgMeGVI0lfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L4/mf/Vz1MXwNW+y2oksjjjQ0HcTksqllOBJR7WW0rohnVh76lN9INkPCzhDyuh6A
         mDZ31Le3u7n6QTM0ayeQoEFvkJk+3W6xJfMh2XIHDnD66dCxVpSOuKpMXWE2ADHdd8
         9pQW/G37rCsWIxvwFHhJtihwXeUooPa+A1gWkvkh0eb2KAdiOG5UDR4oaSO4SOEsEt
         2g9AV/Nm9kLRTHl1PSvOrTaSJzawFSIQYG8t61X+hDh1NJqNks0oUyY5GMIszTeE70
         7hSviQWJWB0CiHo+CXElGzovu0nu6E0Ods8JJKz+qC0MPiwv1PuLvw6yttlwIOP9E7
         XXS9dwbvJkJLw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 590BB1540437; Fri, 24 Mar 2023 13:52:50 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH rcu v3 4/4] rcu: Remove CONFIG_SRCU
Date:   Fri, 24 Mar 2023 13:52:49 -0700
Message-Id: <20230324205249.3700408-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <8ae81b0e-2e03-4f83-aa3d-c7a0b96c8045@paulmck-laptop>
References: <8ae81b0e-2e03-4f83-aa3d-c7a0b96c8045@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
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
index ab62074174c3..9071182b1284 100644
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
index 42acb1a64ce1..3f5fb66f16df 100644
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
2.40.0.rc2

