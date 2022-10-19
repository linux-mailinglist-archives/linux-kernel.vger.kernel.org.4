Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0968604A6B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbiJSPEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbiJSPEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:04:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0088332AB8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:58:34 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666191366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zWMphmFfDq8OlVxrrPCchY88v/O4bwRw57cpKirymSQ=;
        b=v9YrdXBBO/q6meOVsORl10DT9g8/uzZ23xImHaforLllPZJe1CnX//gDt3Ecm5guuqQ/so
        MACoct9zfApolTJ+v1FVD1h0RLDBoFkoLZNYKGiJ0DsuUqHcw+0rDpb9ZIPgagNu7Zgs+O
        gkRSYUFmeL4JqdZ1XKjm0OXKoaL+fnuYiiqcJ5sO4+rKUKDp2WLocmXDuVBuX2NTl2a3rl
        siY+No+tFyVN4CEiREVMo2jTwrxQd9bAZzkxg/EMqT9C3vVARDmTRLPn53t0VEHW9z18bu
        LhmZykhol1iWGLRrhrVr7+PEuWsHDTLrcyEQ2JthQ9gAU5biH4l812fGFSJhAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666191366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zWMphmFfDq8OlVxrrPCchY88v/O4bwRw57cpKirymSQ=;
        b=Gq8pSMFow1Bxe2k6NvWVnYMVnjoP0hDNZGICKaqxJBt6kO5QnCEPHVFaH8KueqPAfoWClB
        v8NwqRojtfnaGHCQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
Subject: [PATCH printk v2 07/38] um: kmsg_dump: use console_is_enabled()
Date:   Wed, 19 Oct 2022 17:01:29 +0206
Message-Id: <20221019145600.1282823-8-john.ogness@linutronix.de>
In-Reply-To: <20221019145600.1282823-1-john.ogness@linutronix.de>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
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
 arch/um/kernel/kmsg_dump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
index 0224fcb36e22..3a3bbbb22090 100644
--- a/arch/um/kernel/kmsg_dump.c
+++ b/arch/um/kernel/kmsg_dump.c
@@ -22,8 +22,8 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
 		return;
 
 	for_each_console(con) {
-		if(strcmp(con->name, "tty") == 0 &&
-		   (con->flags & (CON_ENABLED | CON_CONSDEV)) != 0) {
+		if (strcmp(con->name, "tty") == 0 &&
+		    (console_is_enabled(con) || (con->flags & CON_CONSDEV))) {
 			break;
 		}
 	}
-- 
2.30.2

