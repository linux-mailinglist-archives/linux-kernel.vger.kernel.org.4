Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A43A66BA58
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjAPJ34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbjAPJ2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:28:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB0A16AC4;
        Mon, 16 Jan 2023 01:28:53 -0800 (PST)
Date:   Mon, 16 Jan 2023 09:28:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673861332;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G5OPga9s9el+CHbJ947Z6+l1jBqfCaiyuLxg70TImQI=;
        b=mXgF/mdvSH/Q6YlDNvzjgbl5+BUz48NBSFltjq16o4dE9A5N909n/tT6vuxMCodrmPhiyA
        PFLopFJ6OY/j1jBDiXYJZG0zUxXgOZq0rsdnkk+ftZ+8JSZkbqFZZ4sOkdK6UprtxmbYgZ
        +F9S9e/fj9/fbTE4KR7ksAX0tOFotCrvYXjkCsr3x7kLD2+GMVJhDTpS6CdrW6J74xdaHo
        KH768kK+PDYHBwGFjtSCQDK1+6IkaowxJNavZy0JJ2jQLUJCCutTZRuDFypq6cRa6MRLAq
        remUama9eA3fuheTERoMI3qe1bcJdsuwCWUjJU+m5fZIv3C5Cpp7qrkl4OvrTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673861332;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G5OPga9s9el+CHbJ947Z6+l1jBqfCaiyuLxg70TImQI=;
        b=VQufeeKpZGn1kYgRPd4AKwfCq0hIRDSc47/Oz8WNSfT25i+HGUAF2uC/Fg26A9SBHNpLPv
        o/ph6TS07ugK64CA==
From:   "tip-bot2 for Yair Podemsky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] x86/aperfmperf: Erase stale arch_freq_scale
 values when disabling frequency invariance readings
Cc:     Yair Podemsky <ypodemsk@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230110160206.75912-1-ypodemsk@redhat.com>
References: <20230110160206.75912-1-ypodemsk@redhat.com>
MIME-Version: 1.0
Message-ID: <167386133169.4906.2168836143666979819.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     5f5cc9ed992cbab6361f198966f0edba5fc52688
Gitweb:        https://git.kernel.org/tip/5f5cc9ed992cbab6361f198966f0edba5fc52688
Author:        Yair Podemsky <ypodemsk@redhat.com>
AuthorDate:    Tue, 10 Jan 2023 18:02:06 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 16 Jan 2023 10:19:15 +01:00

x86/aperfmperf: Erase stale arch_freq_scale values when disabling frequency invariance readings

Once disable_freq_invariance_work is called the scale_freq_tick function
will not compute or update the arch_freq_scale values.
However the scheduler will still read these values and use them.
The result is that the scheduler might perform unfair decisions based on stale
values.

This patch adds the step of setting the arch_freq_scale values for all
cpus to the default (max) value SCHED_CAPACITY_SCALE, Once all cpus
have the same arch_freq_scale value the scaling is meaningless.

Signed-off-by: Yair Podemsky <ypodemsk@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230110160206.75912-1-ypodemsk@redhat.com
---
 arch/x86/kernel/cpu/aperfmperf.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index 1f60a2b..fdbb5f0 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -330,7 +330,16 @@ static void __init bp_init_freq_invariance(void)
 
 static void disable_freq_invariance_workfn(struct work_struct *work)
 {
+	int cpu;
+
 	static_branch_disable(&arch_scale_freq_key);
+
+	/*
+	 * Set arch_freq_scale to a default value on all cpus
+	 * This negates the effect of scaling
+	 */
+	for_each_possible_cpu(cpu)
+		per_cpu(arch_freq_scale, cpu) = SCHED_CAPACITY_SCALE;
 }
 
 static DECLARE_WORK(disable_freq_invariance_work,
