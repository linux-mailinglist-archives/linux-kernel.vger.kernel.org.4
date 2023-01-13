Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF2466883B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 01:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240761AbjAMAM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 19:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240232AbjAMALn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 19:11:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24B51183D;
        Thu, 12 Jan 2023 16:11:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87B99B8203D;
        Fri, 13 Jan 2023 00:11:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EFCC43333;
        Fri, 13 Jan 2023 00:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673568695;
        bh=ayQf6/xuyFF/w9FwFq9nQMwEr/uyhaCZ6dQYnnXBdS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pu1GHzx6RhryUp+w67SMaQOzUnW4yEqUj5+ss639mrruDEt7nk5aGgfivBAZXPuwh
         SZe+c6EEGOHwFDTDNltElL2Y1p+dmq5X8mK8iL2SyOot0p3ZIsbTmeUfaKdxftZLTj
         jhG7k38wBltfpGOYJvIQH4EbgYfCOTxCn9zp0fhEnYI1LjaBCKA9OSAfT+Idq/LzJD
         Jd3Icev0UPGhGH3+0os5umGJbSOQCKZE5KvhUjYxOJZcP58yEfzNoPBUU4AkUDRmY0
         uA3MT8Drm3cQelgkC28D8Sj8VUgeVlkb/FRO1afsyepH7tW2N0hiSLFiFsEeqVz05G
         0azsh9dHR98xQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B2AD25C1C79; Thu, 12 Jan 2023 16:11:34 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Borislav Petkov <bp@suse.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        John Ogness <john.ogness@linutronix.de>
Subject: [PATCH rcu v2 15/20] kernel/notifier: Remove CONFIG_SRCU
Date:   Thu, 12 Jan 2023 16:11:27 -0800
Message-Id: <20230113001132.3375334-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230113001103.GA3374173@paulmck-ThinkPad-P17-Gen-1>
References: <20230113001103.GA3374173@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the SRCU Kconfig option is unconditionally selected, there is
no longer any point in conditional compilation based on CONFIG_SRCU.
Therefore, remove the #ifdef.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: Borislav Petkov <bp@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/notifier.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/notifier.c b/kernel/notifier.c
index ab75637fd904f..d353e4b5402d7 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -456,7 +456,6 @@ int raw_notifier_call_chain(struct raw_notifier_head *nh,
 }
 EXPORT_SYMBOL_GPL(raw_notifier_call_chain);
 
-#ifdef CONFIG_SRCU
 /*
  *	SRCU notifier chain routines.    Registration and unregistration
  *	use a mutex, and call_chain is synchronized by SRCU (no locks).
@@ -573,8 +572,6 @@ void srcu_init_notifier_head(struct srcu_notifier_head *nh)
 }
 EXPORT_SYMBOL_GPL(srcu_init_notifier_head);
 
-#endif /* CONFIG_SRCU */
-
 static ATOMIC_NOTIFIER_HEAD(die_chain);
 
 int notrace notify_die(enum die_val val, const char *str,
-- 
2.31.1.189.g2e36527f23

