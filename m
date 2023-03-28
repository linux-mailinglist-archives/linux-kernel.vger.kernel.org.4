Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530DF6CB984
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbjC1IfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjC1Iew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:34:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197ED49EA;
        Tue, 28 Mar 2023 01:34:51 -0700 (PDT)
Date:   Tue, 28 Mar 2023 08:34:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679992487;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fqdx7ou+Hs1BavNnec0YpUem7ASgByo9kJ9hlLvNmaE=;
        b=j+I9Q0L+E0H9pZyLZlbbm5EDdguLC2hKg0W6UrV2LMq1gNOjTZgXjJRblYxspHNd3iA7SC
        gcIIU0C2QpgfEnOxjcC9m6oCFBL8j/TAwaccBW6rZdDCcuK1nzoNV/tzqW0mGrs36VSWIa
        hw6DZvuznb/TnxKfa/Z6gT/uBgMezzC6E/zgdz2R2KKDhg+3LLqs0PohyBFCuTnWslyB6O
        hG+rariN6/zLXacVucvlKi1mQ6mvAVNH+xQ+WMaUl5J67vA04YQiRqbf+AOKj1zW8lZdma
        SRCcIntGd/e3lykkVhAewLoCCawVqTP2RZYL5t3+WmAQNR5w8HbJj12AirUm0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679992487;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fqdx7ou+Hs1BavNnec0YpUem7ASgByo9kJ9hlLvNmaE=;
        b=8n61ATQ7hj18ftaWbbe3UHYstEQL1CasZe5Q1thu0yteS9KcRQ9efVf/H+fhB9Da0UdLab
        A6BPwlJd7YBTLpAg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] kernel/smp: Make csdlock_debug= resettable
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230321005516.50558-4-paulmck@kernel.org>
References: <20230321005516.50558-4-paulmck@kernel.org>
MIME-Version: 1.0
Message-ID: <167999248681.5837.4240401894848544789.tip-bot2@tip-bot2>
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

Commit-ID:     203e435844734cfa503cd1755f35db2514db5cca
Gitweb:        https://git.kernel.org/tip/203e435844734cfa503cd1755f35db2514db5cca
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 20 Mar 2023 17:55:16 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 24 Mar 2023 11:01:26 +01:00

kernel/smp: Make csdlock_debug= resettable

It is currently possible to set the csdlock_debug_enabled static
branch, but not to reset it.  This is an issue when several different
entities supply kernel boot parameters and also for kernels built with
CONFIG_CSD_LOCK_WAIT_DEBUG_DEFAULT=y.

Therefore, make the csdlock_debug=0 kernel boot parameter turn off
debugging.  Last one wins!

Reported-by: Jes Sorensen <Jes.Sorensen@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20230321005516.50558-4-paulmck@kernel.org
---
 Documentation/admin-guide/kernel-parameters.txt | 13 +++++++------
 kernel/smp.c                                    | 11 ++++++++---
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b15198a..5f2ec4b 100644
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
index 7a85bcd..298ba75 100644
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
