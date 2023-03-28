Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F0C6CB983
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjC1IfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbjC1Iew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:34:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6E349FA;
        Tue, 28 Mar 2023 01:34:51 -0700 (PDT)
Date:   Tue, 28 Mar 2023 08:34:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679992488;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6gKvxFcvri+uJgjsNs13jjfDwNVN9Rvd9wPogP5FUgY=;
        b=q6tbYMY9B2dy51AejWp6J0Reu7yYpuR5FAFSz1HS+Fa8S+i6uuWbmLkxZ7Mnd12sNHl91D
        9mnc8DNAXAyqTtyzeImoObOHqXBpWduWfrbal3G7ZhHR0peVLFaWo3BkJgAxAs2BMhk60l
        WstYijBN6k1WBRw10LUQDMYRn082ny8ddJXT6Vo+B2NhZaFdNYVSVPo+pO7e1xht/hF2tv
        wjpfWtmrwIvpx1LqsyBM1v4H5l4CUiE33/4HTt4bPPZOFSWeAU1u6wpgCvnsOJn493vK0l
        6W948Yp57dFULCAv05/DEe0XMJ4Vi6O9M5DjD5bVeHcByVOqJysbW5kvLnV2yQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679992488;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6gKvxFcvri+uJgjsNs13jjfDwNVN9Rvd9wPogP5FUgY=;
        b=URCvw3Y3O56XksshsrflZMVbgJ1N4bjLN5ZmgdYXIg9CsR1/6YYwCKzRUUawXcOUi3woqu
        +3H0BtTJqu2NoPBw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] locking/csd_lock: Add Kconfig option for csd_debug default
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230321005516.50558-1-paulmck@kernel.org>
References: <20230321005516.50558-1-paulmck@kernel.org>
MIME-Version: 1.0
Message-ID: <167999248761.5837.5758345327502379976.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     c52198601695851622f361d3f16456e9fc857629
Gitweb:        https://git.kernel.org/tip/c52198601695851622f361d3f16456e9fc857629
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 20 Mar 2023 17:55:13 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 24 Mar 2023 11:01:25 +01:00

locking/csd_lock: Add Kconfig option for csd_debug default

The csd_debug kernel parameter works well, but is inconvenient in cases
where it is more closely associated with boot loaders or automation than
with a particular kernel version or release.  Thererfore, provide a new
CSD_LOCK_WAIT_DEBUG_DEFAULT Kconfig option that defaults csd_debug to
1 when selected and 0 otherwise, with this latter being the default.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20230321005516.50558-1-paulmck@kernel.org
---
 Documentation/admin-guide/kernel-parameters.txt |  6 ++++--
 kernel/smp.c                                    |  2 +-
 lib/Kconfig.debug                               |  9 +++++++++
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6221a1d..ce70777 100644
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
index 06a4139..e2d558f 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -158,7 +158,7 @@ void __init call_function_init(void)
 
 #ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
 
-static DEFINE_STATIC_KEY_FALSE(csdlock_debug_enabled);
+static DEFINE_STATIC_KEY_MAYBE(CONFIG_CSD_LOCK_WAIT_DEBUG_DEFAULT, csdlock_debug_enabled);
 static DEFINE_STATIC_KEY_FALSE(csdlock_debug_extended);
 
 static int __init csdlock_debug(char *str)
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c8b379e..e1b160a 100644
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
