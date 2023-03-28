Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C966CB98C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbjC1IfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjC1Ieu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:34:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD473C33;
        Tue, 28 Mar 2023 01:34:49 -0700 (PDT)
Date:   Tue, 28 Mar 2023 08:34:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679992486;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jixwpSRz1aSQSeW9HfObnYv+cJLGJzWBbyq5GbH54MA=;
        b=455QzYkf03UjCoEiPoySRVRcE55U8aEbbqOorPN8l/E3v6+L/v8RQL2kjYcHUnfVGk4/N1
        VeuBxwsj3X5QitzGcV9qgF0m/8EgFhm4W+QVpxLzBIYHSC6OwI9kyXIyHHoPd8kS58ALsd
        tBtQD/kkaY0I+pbJr2WmWUPBdB5CgO6l8yva26C7O+lxGC15yQTAkht72BSoExxX3ViWG2
        Yops1GrmcC21Tf+KpwNL+CReDepwxuU2ry/L78aZb+iYjE11fwNT9MLNDweWo6LjdGAAfk
        YGxxbN0ppI3WUCutSJl7ecUNA33oMsGA7wMRwWkIAyg/Uy+XLV5aNRk9MtVT/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679992486;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jixwpSRz1aSQSeW9HfObnYv+cJLGJzWBbyq5GbH54MA=;
        b=suUy2pFanNy0/KW2MZKMIRSCD1Eg+C18TpvXE0ynLp/0VGw9pLclfi1G9KcWBDHzW2psr/
        JdYQQ4wlH9DYSVBA==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] smp: Trace IPIs sent via arch_send_call_function_ipi_mask()
Cc:     Valentin Schneider <vschneid@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230307143558.294354-4-vschneid@redhat.com>
References: <20230307143558.294354-4-vschneid@redhat.com>
MIME-Version: 1.0
Message-ID: <167999248607.5837.3688560536662044560.tip-bot2@tip-bot2>
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

Commit-ID:     08407b5f61c1bbd4ebb26a76474df4354fd76fb7
Gitweb:        https://git.kernel.org/tip/08407b5f61c1bbd4ebb26a76474df4354fd76fb7
Author:        Valentin Schneider <vschneid@redhat.com>
AuthorDate:    Tue, 07 Mar 2023 14:35:54 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 24 Mar 2023 11:01:27 +01:00

smp: Trace IPIs sent via arch_send_call_function_ipi_mask()

This simply wraps around the arch function and prepends it with a
tracepoint, similar to send_call_function_single_ipi().

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Link: https://lore.kernel.org/r/20230307143558.294354-4-vschneid@redhat.com
---
 kernel/smp.c |  9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 770e879..03e6d57 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -103,6 +103,13 @@ void __init call_function_init(void)
 	smpcfd_prepare_cpu(smp_processor_id());
 }
 
+static __always_inline void
+send_call_function_ipi_mask(struct cpumask *mask)
+{
+	trace_ipi_send_cpumask(mask, _RET_IP_, NULL);
+	arch_send_call_function_ipi_mask(mask);
+}
+
 #ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
 
 static DEFINE_STATIC_KEY_MAYBE(CONFIG_CSD_LOCK_WAIT_DEBUG_DEFAULT, csdlock_debug_enabled);
@@ -762,7 +769,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 		if (nr_cpus == 1)
 			send_call_function_single_ipi(last_cpu);
 		else if (likely(nr_cpus > 1))
-			arch_send_call_function_ipi_mask(cfd->cpumask_ipi);
+			send_call_function_ipi_mask(cfd->cpumask_ipi);
 	}
 
 	if (run_local && (!cond_func || cond_func(this_cpu, info))) {
