Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3658161F53A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbiKGORL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbiKGOQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:16:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC151CFF1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:16:45 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667830603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6/paKzOHPdL7LtYxjVc5vEnqdv9ZQ5lgTtMtTQHWNnQ=;
        b=kgfOV8TY/LzEY5UzgRdT3BlvUS4J1DgI43rtqiBP9Hat6fe0tbknUSa2d0RAAIOO+gTscI
        9gmZ/Oe5VTwP6nr6aI5cirDD8ru3D4TaVVzQzcKFr/nXfUWAbIm76g0tG7oACi1zAypM21
        wSACcAaMqT+08PtymJMHqyyKDvN6rE0eGaya9a2kYmWdI+WL8S/v3bS5NYBqugmdS4eUgw
        2PBFr7mml7AoQQIqx6L9iXf/WfFvtkQbEyOJtpgmt4m1tvzCh+5Ks6dDOcremWNzfpqzKp
        9uTWvROhtIUwlxLIz7tHhRdcrNZtybOB6R8xqouGyYP+HcGLH3dnVTezBOcTHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667830603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6/paKzOHPdL7LtYxjVc5vEnqdv9ZQ5lgTtMtTQHWNnQ=;
        b=vWS9R1RBOLVJYj2nIE+UOu47k28bDRXb6conZQphvOjHz1Y9ErtSJTCEnA7Fn3BAEIUYkJ
        oQTGziecwCDdfmAQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
Subject: [PATCH printk v3 06/40] um: kmsg_dump: only dump when no output console available
Date:   Mon,  7 Nov 2022 15:22:04 +0106
Message-Id: <20221107141638.3790965-7-john.ogness@linutronix.de>
In-Reply-To: <20221107141638.3790965-1-john.ogness@linutronix.de>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial intention of the UML kmsg_dumper is to dump the kernel
buffers to stdout if there is no console available to perform the
regular crash output.

However, if ttynull was registered as a console, no crash output was
seen. Commit e23fe90dec28 ("um: kmsg_dumper: always dump when not tty
console") tried to fix this by performing the kmsg_dump unless the
stdio console was behind /dev/console or enabled. But this allowed
kmsg dumping to occur even if other non-stdio consoles will output
the crash output. Also, a console being the driver behind
/dev/console has nothing to do with a crash scenario.

Restore the initial intention by dumping the kernel buffers to stdout
only if a non-ttynull console is registered and enabled. Also add
detailed comments so that it is clear why these rules are applied.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 arch/um/kernel/kmsg_dump.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
index 0224fcb36e22..40abf1e9ccb1 100644
--- a/arch/um/kernel/kmsg_dump.c
+++ b/arch/um/kernel/kmsg_dump.c
@@ -17,13 +17,22 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
 	unsigned long flags;
 	size_t len = 0;
 
-	/* only dump kmsg when no console is available */
+	/*
+	 * If no consoles are available to output crash information, dump
+	 * the kmsg buffer to stdout.
+	 */
+
 	if (!console_trylock())
 		return;
 
 	for_each_console(con) {
-		if(strcmp(con->name, "tty") == 0 &&
-		   (con->flags & (CON_ENABLED | CON_CONSDEV)) != 0) {
+		/*
+		 * The ttynull console and disabled consoles are ignored
+		 * since they cannot output. All other consoles are
+		 * expected to output the crash information.
+		 */
+		if (strcmp(con->name, "ttynull") != 0 &&
+		    (con->flags & CON_ENABLED)) {
 			break;
 		}
 	}
-- 
2.30.2

