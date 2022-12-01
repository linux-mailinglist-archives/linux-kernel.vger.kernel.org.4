Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EF563F787
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 19:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiLASfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 13:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiLASe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 13:34:58 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FEF8C690;
        Thu,  1 Dec 2022 10:34:57 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id b412ff0d46b34b5f; Thu, 1 Dec 2022 19:34:55 +0100
Received: from kreacher.localnet (unknown [213.134.188.161])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id BD88427C0F8F;
        Thu,  1 Dec 2022 19:34:54 +0100 (CET)
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
Subject: [PATCH v1 2/2] PM: sleep: Refine error message in try_to_freeze_tasks()
Date:   Thu, 01 Dec 2022 19:34:44 +0100
Message-ID: <2122394.irdbgypaU6@kreacher>
In-Reply-To: <4441789.LvFx2qVVIh@kreacher>
References: <4441789.LvFx2qVVIh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.188.161
X-CLIENT-HOSTNAME: 213.134.188.161
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrtdehgdduudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppedvudefrddufeegrddukeekrdduiedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekkedrudeiuddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigseifvghishhsshgthhhuhhdrnhgvthdprhgtphhtthhopehpmhhlrgguvghksehsuhhsvgdrtghomhdprhgtphhtthhopehluhhkrghsrdgs
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

A previous change amended try_to_freeze_tasks() with the "what"
variable pointing to a string describing the group of tasks subject to
the freezing which may be used in the error message in there too, so
make that happen.

Accordingly, update sleepgraph.py to catch the modified error message
as appropriate.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/process.c             |    4 ++--
 tools/power/pm-graph/sleepgraph.py |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-pm/kernel/power/process.c
===================================================================
--- linux-pm.orig/kernel/power/process.c
+++ linux-pm/kernel/power/process.c
@@ -86,8 +86,8 @@ static int try_to_freeze_tasks(bool user
 	elapsed_msecs = ktime_to_ms(elapsed);
 
 	if (todo) {
-		pr_err("Freezing of tasks %s after %d.%03d seconds "
-		       "(%d tasks refusing to freeze, wq_busy=%d):\n",
+		pr_err("Freezing %s %s after %d.%03d seconds "
+		       "(%d tasks refusing to freeze, wq_busy=%d):\n", what,
 		       wakeup ? "aborted" : "failed",
 		       elapsed_msecs / 1000, elapsed_msecs % 1000,
 		       todo - wq_busy, wq_busy);
Index: linux-pm/tools/power/pm-graph/sleepgraph.py
===================================================================
--- linux-pm.orig/tools/power/pm-graph/sleepgraph.py
+++ linux-pm/tools/power/pm-graph/sleepgraph.py
@@ -1462,7 +1462,7 @@ class Data:
 		'TIMEOUT' : r'(?i).*\bTIMEOUT\b.*',
 		'ABORT'   : r'(?i).*\bABORT\b.*',
 		'IRQ'     : r'.*\bgenirq: .*',
-		'TASKFAIL': r'.*Freezing of tasks *.*',
+		'TASKFAIL': r'.*Freezing .*after *.*',
 		'ACPI'    : r'.*\bACPI *(?P<b>[A-Za-z]*) *Error[: ].*',
 		'DISKFULL': r'.*\bNo space left on device.*',
 		'USBERR'  : r'.*usb .*device .*, error [0-9-]*',



