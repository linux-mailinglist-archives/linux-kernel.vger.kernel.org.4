Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9405BE8C8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiITOYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiITOYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:24:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B63F75;
        Tue, 20 Sep 2022 07:23:53 -0700 (PDT)
Date:   Tue, 20 Sep 2022 14:23:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663683831;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4uxuoF8Uw0qvEP0RIZT7AOvKpjNaNw2+Q8dKYwQem8A=;
        b=QCeQuPlY3Clm/dg27QA3ou7Xn16ytwfXImpdJMsAGolMZz5vnfkxJF5XlTPeggerO+YmP0
        ZhPFzeS9FJmHjzeP+o5B+Uvt627amEtwiBQYpOJ0So8udG7eXJzK76qM4oaQaMKdt4UouD
        LeXHtp5Mx4lNY7TpwRlE7/0NgDV2qW/36BoXOhrwVnWX02dUSDBMz/UAL1PBfGCCz7gXQ+
        MQ+UWx7fKZJ0BnzqLLIT+M1uR6ZpEt0DzJYVvoDubdJonkBcDjszaiDo637KKxOeR3co3J
        wjBHjTYwhi4pCXICbfN9+KsI6/pBCjD14CK4CHCCS1mj4Gq9PcVgchCPg6DMIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663683831;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4uxuoF8Uw0qvEP0RIZT7AOvKpjNaNw2+Q8dKYwQem8A=;
        b=4mZq1S5w1RPwEQozFG9ekhT8xWfhTvJIovDwivbZeZu10z1ZBuIwua1LfBhlv34ulaBzuK
        PPRONMLPLN9EZJBA==
From:   "tip-bot2 for Jiri Slaby" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/dumpstack: Don't mention RIP in "Code: "
Cc:     Jiri Slaby <jslaby@suse.cz>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <b772c39f-c5ae-8f17-fe6e-6a2bc4d1f83b@kernel.org>
References: <b772c39f-c5ae-8f17-fe6e-6a2bc4d1f83b@kernel.org>
MIME-Version: 1.0
Message-ID: <166368382994.401.4342298770580161949.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     5258b80e60da6d8908ae2846b234ed8d9d9d4a19
Gitweb:        https://git.kernel.org/tip/5258b80e60da6d8908ae2846b234ed8d9d9d4a19
Author:        Jiri Slaby <jslaby@suse.cz>
AuthorDate:    Tue, 06 Sep 2022 09:11:23 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 20 Sep 2022 16:11:54 +02:00

x86/dumpstack: Don't mention RIP in "Code: "

Commit

  238c91115cd0 ("x86/dumpstack: Fix misleading instruction pointer error message")

changed the "Code:" line in bug reports when RIP is an invalid pointer.
In particular, the report currently says (for example):

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  ...
  RIP: 0010:0x0
  Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.

That

  Unable to access opcode bytes at RIP 0xffffffffffffffd6.

is quite confusing as RIP value is 0, not -42. That -42 comes from
"regs->ip - PROLOGUE_SIZE", because Code is dumped with some prologue
(and epilogue).

So do not mention "RIP" on this line in this context.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/b772c39f-c5ae-8f17-fe6e-6a2bc4d1f83b@kernel.org
---
 arch/x86/kernel/dumpstack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index afae4dd..b3dba35 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -128,7 +128,7 @@ void show_opcodes(struct pt_regs *regs, const char *loglvl)
 		/* No access to the user space stack of other tasks. Ignore. */
 		break;
 	default:
-		printk("%sCode: Unable to access opcode bytes at RIP 0x%lx.\n",
+		printk("%sCode: Unable to access opcode bytes at 0x%lx.\n",
 		       loglvl, prologue);
 		break;
 	}
