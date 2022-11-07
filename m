Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C11D61F55F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbiKGOSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiKGOQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:16:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51B01D0E5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:16:45 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667830604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=je6BJxg9zIGvpozBTcqdrPDtOdfb/xlqXdr2RuFn3Cs=;
        b=xStyNuRDwQZqAStcI5UdpJk/G1E5RxVmu6uOQl+HxB1LsyG+UGrqEo1GBdH5tNIsVYbp31
        0sGdsUMWqMJ/RIw/dqRua8mTPCiC2Bi6yXAUtwiWaId98XBGkDmKHPA2T1r7BIup48ey9t
        V9t+le50KAGrPTn4fCw91P4Os0mVXzm0RBzuzyUZYvXZ4/TFQS0VlpLfWhhNciYokn7bY0
        x6OS3kQVIDIkRsGimBU+tA3J0nxK/4cLvsdYUYYb7XEy3sJM89hJF40SlQ4jDenQhvJNj1
        T4y6vF+anyQgoWACwNMjdC5+tAh9Q1X1KynBM24kz9ifzeNZquHauzk0EDw2rQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667830604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=je6BJxg9zIGvpozBTcqdrPDtOdfb/xlqXdr2RuFn3Cs=;
        b=fU3tEDpTAS3rUjjLodJQU8W30Uff0X7RCSHHMp6eNmbUMCNdxpTq68atryVxFBzRoHmaAA
        LJxSkx1rw4wUSjBA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
Subject: [PATCH printk v3 09/40] um: kmsg_dump: use console_is_enabled()
Date:   Mon,  7 Nov 2022 15:22:07 +0106
Message-Id: <20221107141638.3790965-10-john.ogness@linutronix.de>
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

Replace (console->flags & CON_ENABLED) usage with console_is_enabled().

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 arch/um/kernel/kmsg_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
index 40abf1e9ccb1..f0233e2f8de0 100644
--- a/arch/um/kernel/kmsg_dump.c
+++ b/arch/um/kernel/kmsg_dump.c
@@ -32,7 +32,7 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
 		 * expected to output the crash information.
 		 */
 		if (strcmp(con->name, "ttynull") != 0 &&
-		    (con->flags & CON_ENABLED)) {
+		    console_is_enabled(con)) {
 			break;
 		}
 	}
-- 
2.30.2

