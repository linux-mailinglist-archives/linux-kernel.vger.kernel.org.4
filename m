Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F142628546
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237583AbiKNQ36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237519AbiKNQ3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:29:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3BC26B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:29:39 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668443377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eUV7NYFJOYRPWEVh0G/EU6zT1t7HGJ6qLPZoOxwFJX0=;
        b=hXrAuUk0veFL2Qfb6GL5q62iv8qbDJs1l0+JFrxmW/AwVib9zp2qJNhFunHfBfU9Zqg88+
        JTlaYWS7koTSowUankx8ymKJVaHyRcKqL0FQPxX2kJ3jy87p7JCO3vqBZ1Xg6IdsGqC/oT
        lfU3BO3xPx8wKUf74di2LOduzLl9D0hKHBnVEf1DeVGsqjTcFOWF1MSo2/PAMnLQL8uQN3
        VAD8oc3lspCaTS0b/swtjZpIdl7aAj3KT1/bn7t0kTKgCnK346lG/0P7emVoeyvNCFXDuy
        ffxx3KsbLdFJj2Cm/sFn07Hv/82wgyTbEOfHV2EOrBLqmpQmhXGCKMWHi2JSkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668443377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eUV7NYFJOYRPWEVh0G/EU6zT1t7HGJ6qLPZoOxwFJX0=;
        b=QxyEvyxZCYa8n5ddhd4y/3oG8Ik1RqNDjid21OVOW9aSygXYvipEI3nPBP20kFecVjgnoJ
        PQ89LtwsJTOe6+DQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
Subject: [PATCH printk v4 06/39] um: kmsg_dump: only dump when no output console available
Date:   Mon, 14 Nov 2022 17:34:59 +0106
Message-Id: <20221114162932.141883-7-john.ogness@linutronix.de>
In-Reply-To: <20221114162932.141883-1-john.ogness@linutronix.de>
References: <20221114162932.141883-1-john.ogness@linutronix.de>
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
Reviewed-by: Petr Mladek <pmladek@suse.com>
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

