Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08916704A8A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbjEPK3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbjEPK25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:28:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702525261;
        Tue, 16 May 2023 03:28:50 -0700 (PDT)
Date:   Tue, 16 May 2023 10:28:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684232929;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hr5bExCKZxqebJdRuLy60M/3NBxhUajsShV67vDRyu0=;
        b=gERDV1aove6Qn14UaJfZ9AOBFlHXwkapZoPBlJOOvev+r8xSttLjhBQHXJQCGPguE6v28O
        v6YPh6ZPigTcsnYlFOunmtrrTypCda9hf6CJ0ydPn5DHXEKA4s0JLEJqIjIE+iC+/9VWuT
        60KajN9AQulup2yfVIn+WkcZi4uW819UZKfW03fXVQnZDHVOio1xkAHtnqe+nq/eW4kcJn
        Iq+rtb0z9X6xrUCX5Dzk7rxg5NpYKZ1UqKWrM/9bREgwiXkpSLLcg7ihz/2rT14FruYDkS
        XCqsXYZKZdM3n14FwNaGg3DuXKIeXm6YuFiIdY5IvuRCtxWJ4vDI14ggNwIl6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684232929;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hr5bExCKZxqebJdRuLy60M/3NBxhUajsShV67vDRyu0=;
        b=hNMAta5HiFICdruoPlVPVB+3uP/fnCPOD3Z3etG/zpQuNNPfUKy810X1DA2EuYwTZg/Z8N
        g4w3V7Lj4TEKhABQ==
From:   "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/MCE: Check a hw error's address to determine
 proper recovery action
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230322005131.174499-1-tony.luck@intel.com>
References: <20230322005131.174499-1-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <168423292833.404.13379284574944485895.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     e40879b6d7d858b03813cd53c17dfef9c297f525
Gitweb:        https://git.kernel.org/tip/e40879b6d7d858b03813cd53c17dfef9c297f525
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Fri, 08 Jan 2021 04:00:35 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 16 May 2023 12:16:22 +02:00

x86/MCE: Check a hw error's address to determine proper recovery action

Make sure that machine check errors with a usable address are properly
marked as poison.

This is needed for errors that occur on memory which have
MCG_STATUS[RIPV] clear - i.e., the interrupted process cannot be
restarted reliably. One example is data poison consumption through the
instruction fetch units on AMD Zen-based systems.

The MF_MUST_KILL flag is passed to memory_failure() when
MCG_STATUS[RIPV] is not set. So the associated process will still be
killed.  What this does, practically, is get rid of one more check to
kill_current_task with the eventual goal to remove it completely.

Also, make the handling identical to what is done on the notifier path
(uc_decode_notifier() does that address usability check too).

The scenario described above occurs when hardware can precisely identify
the address of poisoned memory, but execution cannot reliably continue
for the interrupted hardware thread.

  [ bp: Massage commit message. ]

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/20230322005131.174499-1-tony.luck@intel.com
---
 arch/x86/kernel/cpu/mce/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2eec60f..22dfcb2 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1533,7 +1533,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		/* If this triggers there is no way to recover. Die hard. */
 		BUG_ON(!on_thread_stack() || !user_mode(regs));
 
-		if (kill_current_task)
+		if (!mce_usable_address(&m))
 			queue_task_work(&m, msg, kill_me_now);
 		else
 			queue_task_work(&m, msg, kill_me_maybe);
