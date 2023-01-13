Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0A8669746
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241553AbjAMMfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240927AbjAMMcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:32:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17042AF1;
        Fri, 13 Jan 2023 04:31:12 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:31:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673613071;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/CrHO1LacD6CrltYYEx4DUqXH0tiHHBzGL1Jh1nRb+Y=;
        b=teo/VWiFKI2PfUKbpyQdNsT6llD8nPQrHDqZYTFSnvEvnRHYTg0Vr9CuohvupBU0QaPueG
        zRUkWhGy6OhYbBTJTH3iJq2kyN1Ft8OuhNOoYn3d1OKLjZWhdfqbO7te/qQ/rXmFzd5YhL
        oAHEAF0iwW/xOQlflCmIXpyZI5/9qeIUtevx4knY8OqqTTJgee+ioridZqHa5h2TCNIzC9
        slJHgHHp3qb8IS8XhiVlMfHyVvPJlBxEm9v0fxQrqsO+0fh28EUMID38rfbWjD4CiQKQu/
        wFNv1LkX34tpSkfm420zCixy4fm+d6H/nU01NB8yFd6LZqurkjw5xYzw+m4Bew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673613071;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/CrHO1LacD6CrltYYEx4DUqXH0tiHHBzGL1Jh1nRb+Y=;
        b=zJd/sjZWv20cwKS8YSqxCKAm9ViFj6Uegaf8oHoF3WiqEyVWR24qgZCWHBb2ylZn0IBD1x
        pslqemdHqAr+laDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] printk: Remove trace_.*_rcuidle() usage
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112195540.865735001@infradead.org>
References: <20230112195540.865735001@infradead.org>
MIME-Version: 1.0
Message-ID: <167361307001.4906.5484032353418766549.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     880970b56b732b158385991b232592144256f330
Gitweb:        https://git.kernel.org/tip/880970b56b732b158385991b232592144256f330
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Jan 2023 20:43:39 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 11:48:16 +01:00

printk: Remove trace_.*_rcuidle() usage

The problem, per commit fc98c3c8c9dc ("printk: use rcuidle console
tracepoint"), was printk usage from the cpuidle path where RCU was
already disabled.

Per the patches earlier in this series, this is no longer the case.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Petr Mladek <pmladek@suse.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230112195540.865735001@infradead.org
---
 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 7decf1e..1ab53dd 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2194,7 +2194,7 @@ static u16 printk_sprint(char *text, u16 size, int facility,
 		}
 	}
 
-	trace_console_rcuidle(text, text_len);
+	trace_console(text, text_len);
 
 	return text_len;
 }
