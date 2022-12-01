Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE6063F789
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 19:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiLASfD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 1 Dec 2022 13:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiLASfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 13:35:00 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E56893A66;
        Thu,  1 Dec 2022 10:34:58 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 763a39c981a2d502; Thu, 1 Dec 2022 19:34:57 +0100
Received: from kreacher.localnet (unknown [213.134.188.161])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 4D76527C0F8F;
        Thu,  1 Dec 2022 19:34:56 +0100 (CET)
Authentication-Results: v370.home.net.pl; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: v370.home.net.pl; spf=fail smtp.mailfrom=rjwysocki.net
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Petr Mladek <pmladek@suse.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH v1 1/2] PM: sleep: Avoid using pr_cont() in the tasks freezing code
Date:   Thu, 01 Dec 2022 19:33:09 +0100
Message-ID: <4758119.GXAFRqVoOG@kreacher>
In-Reply-To: <4441789.LvFx2qVVIh@kreacher>
References: <4441789.LvFx2qVVIh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.188.161
X-CLIENT-HOSTNAME: 213.134.188.161
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrtdehgdduudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnheptddvfeegledvfedvveevhedvteeffeehvdeuiedukeeiledttefgvdeihffgteetnecukfhppedvudefrddufeegrddukeekrdduiedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekkedrudeiuddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigseifvghishhsshgthhhuhhdrnhgvthdprhgtphhtthhopehpmhhlrgguvghksehsuhhsvgdrtghomhdprhgtphhtthhopehluhhkrghsrdgs
 uhhlfigrhhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhovgesphgvrhgthhgvshdrtghomhdprhgtphhtthhopehtohguugdrvgdrsghrrghnughtsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Using pr_cont() in the tasks freezing code related to system-wide
suspend and hibernation is problematic, because the continuation
messages printed there are susceptible to interspersing with other
unrelated messages which results in output that is hard to
understand.

Address this issue by modifying try_to_freeze_tasks() to print
messages that don't require continuations and adjusting its
callers accordingly.

Reported-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/process.c |   21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

Index: linux-pm/kernel/power/process.c
===================================================================
--- linux-pm.orig/kernel/power/process.c
+++ linux-pm/kernel/power/process.c
@@ -27,6 +27,8 @@ unsigned int __read_mostly freeze_timeou
 
 static int try_to_freeze_tasks(bool user_only)
 {
+	const char *what = user_only ? "user space processes" :
+					"remaining freezable tasks";
 	struct task_struct *g, *p;
 	unsigned long end_time;
 	unsigned int todo;
@@ -36,6 +38,8 @@ static int try_to_freeze_tasks(bool user
 	bool wakeup = false;
 	int sleep_usecs = USEC_PER_MSEC;
 
+	pr_info("Freezing %s\n", what);
+
 	start = ktime_get_boottime();
 
 	end_time = jiffies + msecs_to_jiffies(freeze_timeout_msecs);
@@ -82,7 +86,6 @@ static int try_to_freeze_tasks(bool user
 	elapsed_msecs = ktime_to_ms(elapsed);
 
 	if (todo) {
-		pr_cont("\n");
 		pr_err("Freezing of tasks %s after %d.%03d seconds "
 		       "(%d tasks refusing to freeze, wq_busy=%d):\n",
 		       wakeup ? "aborted" : "failed",
@@ -101,8 +104,8 @@ static int try_to_freeze_tasks(bool user
 			read_unlock(&tasklist_lock);
 		}
 	} else {
-		pr_cont("(elapsed %d.%03d seconds) ", elapsed_msecs / 1000,
-			elapsed_msecs % 1000);
+		pr_info("Freezing %s completed (elapsed %d.%03d seconds)\n",
+			what, elapsed_msecs / 1000, elapsed_msecs % 1000);
 	}
 
 	return todo ? -EBUSY : 0;
@@ -130,14 +133,11 @@ int freeze_processes(void)
 		static_branch_inc(&freezer_active);
 
 	pm_wakeup_clear(0);
-	pr_info("Freezing user space processes ... ");
 	pm_freezing = true;
 	error = try_to_freeze_tasks(true);
-	if (!error) {
+	if (!error)
 		__usermodehelper_set_disable_depth(UMH_DISABLED);
-		pr_cont("done.");
-	}
-	pr_cont("\n");
+
 	BUG_ON(in_atomic());
 
 	/*
@@ -166,14 +166,9 @@ int freeze_kernel_threads(void)
 {
 	int error;
 
-	pr_info("Freezing remaining freezable tasks ... ");
-
 	pm_nosig_freezing = true;
 	error = try_to_freeze_tasks(false);
-	if (!error)
-		pr_cont("done.");
 
-	pr_cont("\n");
 	BUG_ON(in_atomic());
 
 	if (error)



