Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BD76C2696
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 01:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjCUAz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 20:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjCUAzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 20:55:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F59F34029
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 17:55:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F684618CF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:55:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E6DC433EF;
        Tue, 21 Mar 2023 00:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360118;
        bh=g+CxuiiM9x0+HVz5Xxk//DkI5BoRbQEaiqME9OD6zaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nh9KKRJwyBp3gm0NSmydGxa4d3wcOHUR5/n6H9p8GwRxjTToprCS7ZbruF1b75BBr
         78ju3ijSSShz6qCLOarQsM05sXD5kz71lg3LxNQ/sG9Orx/DZZ68jqRIHjIQfjbstq
         YDMdFAuflwjSNAMx5pLNe8wWeIaXdYGPiJSbgvjYAVAho+zDH4UA1XKTlRl4MrWDeZ
         XZ9Wybp8hD6JKn+3KM8mxCJeM/bhRUm9HR1dYPaBVvjoVVEoTcBgGNEjdznOhgr8Ak
         PcOliUp9PFkqRPatzfEgjbrXGf90iIySQ7+6sXABUDTVwvJyGrQ7YU0jooUo6YB+Ly
         mQNbNALXfaHBA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 605751540395; Mon, 20 Mar 2023 17:55:18 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@meta.com, rostedt@goodmis.org, jgross@suse.com,
        mingo@kernel.org, peterz@infradead.org, corbet@lwn.net,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH CSDlock 1/4] locking/csd_lock: Add Kconfig option for csd_debug default
Date:   Mon, 20 Mar 2023 17:55:13 -0700
Message-Id: <20230321005516.50558-1-paulmck@kernel.org>
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

The csd_debug kernel parameter works well, but is inconvenient in cases
where it is more closely associated with boot loaders or automation than
with a particular kernel version or release.  Thererfore, provide a new
CSD_LOCK_WAIT_DEBUG_DEFAULT Kconfig option that defaults csd_debug to
1 when selected and 0 otherwise, with this latter being the default.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Ingo Molnar <mingo@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 6 ++++--
 kernel/smp.c                                    | 2 +-
 lib/Kconfig.debug                               | 9 +++++++++
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6221a1d057dd..ce70777f5999 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -893,8 +893,10 @@
 			handling. When switched on, additional debug data is
 			printed to the console in case a hanging CPU is
 			detected, and that CPU is pinged again in order to try
-			to resolve the hang situation.
-			0: disable csdlock debugging (default)
+			to resolve the hang situation.  The default value of
+			this option depends on the CSD_LOCK_WAIT_DEBUG_DEFAULT
+			Kconfig option.
+			0: disable csdlock debugging
 			1: enable basic csdlock debugging (minor impact)
 			ext: enable extended csdlock debugging (more impact,
 			     but more data)
diff --git a/kernel/smp.c b/kernel/smp.c
index 06a413987a14..e2d558f5cef8 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -158,7 +158,7 @@ void __init call_function_init(void)
 
 #ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
 
-static DEFINE_STATIC_KEY_FALSE(csdlock_debug_enabled);
+static DEFINE_STATIC_KEY_MAYBE(CONFIG_CSD_LOCK_WAIT_DEBUG_DEFAULT, csdlock_debug_enabled);
 static DEFINE_STATIC_KEY_FALSE(csdlock_debug_extended);
 
 static int __init csdlock_debug(char *str)
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c8b379e2e9ad..e1b160a0474d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1480,6 +1480,15 @@ config CSD_LOCK_WAIT_DEBUG
 	  include the IPI handler function currently executing (if any)
 	  and relevant stack traces.
 
+config CSD_LOCK_WAIT_DEBUG_DEFAULT
+	bool "Default csd_lock_wait() debugging on at boot time"
+	depends on CSD_LOCK_WAIT_DEBUG
+	depends on 64BIT
+	default n
+	help
+	  This option causes the csdlock_debug= kernel boot parameter to
+	  default to 1 (basic debugging) instead of 0 (no debugging).
+
 endmenu # lock debugging
 
 config TRACE_IRQFLAGS
-- 
2.40.0.rc2

