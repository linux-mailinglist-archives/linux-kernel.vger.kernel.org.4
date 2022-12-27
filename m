Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1F6656ABA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 13:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbiL0MPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 07:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbiL0MOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 07:14:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CCADFF;
        Tue, 27 Dec 2022 04:13:52 -0800 (PST)
Date:   Tue, 27 Dec 2022 12:13:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672143229;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=368eU1mZ65Uq85cJsmJl+WRGtJcEnaYUkhUke21f2Pg=;
        b=m2N/wkY7531/5bBoAzjxqCeRd5w//uCmI0Nq2KRtCqTP4zd2lNuL9ffpfetBJsVaVOjyTe
        A8cmfHC0b+HbnYaIDww3smy+khFukbCrSmsSiru1BmkULcVyYnXKxGFP+76xiT98aA//Kb
        ZvmROY70eDwxxjclI80EvXFviXmFbjRaI9JMUOssm4Mt9S+Bxe9awZu3Oj7QRr9zVzK69j
        M/nyRDLJ5DuEHLOs0bc8AOllzjxdCGfpN7S6BnPZJPdDlsltmo1rcDT8gTu6sogeEZ5wph
        6DRU3Jigo83jIANgPApKfxbrVGWtVe6D4RuawK1Aws4h3Wt9MyMQqvGJkSmmJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672143229;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=368eU1mZ65Uq85cJsmJl+WRGtJcEnaYUkhUke21f2Pg=;
        b=pBPHhGNA48MocS4bS/bKoTGmXnjlfYbp96FecDv+o01eKz6/n0guclYMR+U0AC04aNmOeB
        0NP1lvWcf3sl1ZDw==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] tracing/rseq: Add mm_cid field to rseq_update
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221122203932.231377-22-mathieu.desnoyers@efficios.com>
References: <20221122203932.231377-22-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <167214322913.4906.16315668635920081365.tip-bot2@tip-bot2>
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

Commit-ID:     14a8644d4f76fb4afdfcc46e9193af867241bd42
Gitweb:        https://git.kernel.org/tip/14a8644d4f76fb4afdfcc46e9193af867241bd42
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Tue, 22 Nov 2022 15:39:23 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 27 Dec 2022 12:52:15 +01:00

tracing/rseq: Add mm_cid field to rseq_update

Add the mm_cid field to the rseq_update event, allowing tracers to
follow which mm_cid is observed by user-space, and whether negative
mm_cid values are visible in case of internal scheduler implementation
issues.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20221122203932.231377-22-mathieu.desnoyers@efficios.com
---
 include/trace/events/rseq.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/rseq.h b/include/trace/events/rseq.h
index dde7a35..823b47d 100644
--- a/include/trace/events/rseq.h
+++ b/include/trace/events/rseq.h
@@ -17,14 +17,17 @@ TRACE_EVENT(rseq_update,
 	TP_STRUCT__entry(
 		__field(s32, cpu_id)
 		__field(s32, node_id)
+		__field(s32, mm_cid)
 	),
 
 	TP_fast_assign(
 		__entry->cpu_id = raw_smp_processor_id();
 		__entry->node_id = cpu_to_node(__entry->cpu_id);
+		__entry->mm_cid = task_mm_cid(t);
 	),
 
-	TP_printk("cpu_id=%d node_id=%d", __entry->cpu_id, __entry->node_id)
+	TP_printk("cpu_id=%d node_id=%d mm_cid=%d", __entry->cpu_id,
+		  __entry->node_id, __entry->mm_cid)
 );
 
 TRACE_EVENT(rseq_ip_fixup,
