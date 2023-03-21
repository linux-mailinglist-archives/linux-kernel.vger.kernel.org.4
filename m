Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C136C2695
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 01:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCUAzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 20:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjCUAzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 20:55:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AF33430C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 17:55:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89333618F4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:55:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6FB6C4339C;
        Tue, 21 Mar 2023 00:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360118;
        bh=x3dYREr13qysgzwTS5v6Z35aAfe/WZzlbYN9SMZ6zZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dq4vUy8ghBwgdglCk3r1bXCg9XrfkbsEECqD02CDoEEewVlBvPDfAqHXWcRNsByw0
         ay17aMja0BFHQc5YZ0YXKLWtZIGZpOfcw7RJYuWwPToQhtesjTwL21w79ybsRQ7EKv
         JZepj8uP1M9PH0KI/++R7ne3+XnzlcuT/10ptmLus9VgI8K7593s/5n1OVYNIK3mmX
         QGf+Azfj+5jt5dwqoZpXLjQXAoaX+SPehIT5Tb7vZ/CLCtfs9aP8MaYqOLEvpGfD9h
         gWuBr+bK4IdzpUbcks1/ZVuhLq0kU9k/emPv4vQKk6/svBwEpgLbfySNkyu9DT3NUH
         ovF/bX/zGs+ag==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 75E81154039F; Mon, 20 Mar 2023 17:55:18 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@meta.com, rostedt@goodmis.org, jgross@suse.com,
        mingo@kernel.org, peterz@infradead.org, corbet@lwn.net,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: [PATCH CSDlock 4/4] kernel/smp: Make csdlock_debug= resettable
Date:   Mon, 20 Mar 2023 17:55:16 -0700
Message-Id: <20230321005516.50558-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <0c368b66-71b2-442f-a8f7-e6decc4be2d6@paulmck-laptop>
References: <0c368b66-71b2-442f-a8f7-e6decc4be2d6@paulmck-laptop>
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

It is currently possible to set the csdlock_debug_enabled static
branch, but not to reset it.  This is an issue when several different
entities supply kernel boot parameters and also for kernels built with
CONFIG_CSD_LOCK_WAIT_DEBUG_DEFAULT=y.

Therefore, make the csdlock_debug=0 kernel boot parameter turn off
debugging.  Last one wins!

Reported-by: Jes Sorensen <Jes.Sorensen@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 13 +++++++------
 kernel/smp.c                                    | 11 ++++++++---
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b15198a85acb..5f2ec4b0f927 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -889,12 +889,13 @@
 	cs89x0_media=	[HW,NET]
 			Format: { rj45 | aui | bnc }
 
-	csdlock_debug=	[KNL] Enable debug add-ons of cross-CPU function call
-			handling. When switched on, additional debug data is
-			printed to the console in case a hanging CPU is
-			detected, and that CPU is pinged again in order to try
-			to resolve the hang situation.  The default value of
-			this option depends on the CSD_LOCK_WAIT_DEBUG_DEFAULT
+	csdlock_debug=	[KNL] Enable or disable debug add-ons of cross-CPU
+			function call handling. When switched on,
+			additional debug data is printed to the console
+			in case a hanging CPU is detected, and that
+			CPU is pinged again in order to try to resolve
+			the hang situation.  The default value of this
+			option depends on the CSD_LOCK_WAIT_DEBUG_DEFAULT
 			Kconfig option.
 
 	dasd=		[HW,NET]
diff --git a/kernel/smp.c b/kernel/smp.c
index 7a85bcddd9dc..298ba7570621 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -116,11 +116,16 @@ static DEFINE_STATIC_KEY_MAYBE(CONFIG_CSD_LOCK_WAIT_DEBUG_DEFAULT, csdlock_debug
  */
 static int __init csdlock_debug(char *str)
 {
+	int ret;
 	unsigned int val = 0;
 
-	get_option(&str, &val);
-	if (val)
-		static_branch_enable(&csdlock_debug_enabled);
+	ret = get_option(&str, &val);
+	if (ret) {
+		if (val)
+			static_branch_enable(&csdlock_debug_enabled);
+		else
+			static_branch_disable(&csdlock_debug_enabled);
+	}
 
 	return 1;
 }
-- 
2.40.0.rc2

