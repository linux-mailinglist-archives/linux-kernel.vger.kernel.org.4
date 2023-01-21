Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9AF676578
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 10:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjAUJtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 04:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjAUJtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 04:49:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988545B583;
        Sat, 21 Jan 2023 01:49:31 -0800 (PST)
Date:   Sat, 21 Jan 2023 09:49:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674294566;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mfrLJyMBkaRI6H6cVutMt0zaXG1NINzdVqr4ThIHN8I=;
        b=sADAgCbN51yo59tw3V+tbQqCLqN4LZyzvZCVt/FtEYx7KseGoMvVthcEG6xaUZG5V4rMLZ
        1AQIwE9MTHTBB3S9GegnYY3kS4e7SIvo+7c9R2T1IP9Z6RpLmPOZmeQNS/KK73oveitoWh
        m92QoD0aWbkUHhROT2tYpKmu+iPXs+N3T4f6YdplRd6xV88gCw6ERfk9jxiNxQolgZZbk3
        luXsxWWz+hmuKTZrcSBPSxfCLBtfg3qwJmrt6PV8mjH4hkjQ+PJo1F74WDZi+gGeew99IB
        wRMnx04oPbgFBKijML9KHQO8f6WQVA2u2p1OAVvpRiJGK48HjzLJLfnj8hBBBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674294566;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mfrLJyMBkaRI6H6cVutMt0zaXG1NINzdVqr4ThIHN8I=;
        b=HH1fe88Ax063Us42OSAXPMUEZKQT/tYkZf8iTUXPiJR8QDDYIG5XoIXhQfClqEZYIlA0T2
        KLm98h9XPbOqmdCQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/uncore: Don't WARN_ON_ONCE() for a broken
 discovery table
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Petlan <mpetlan@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112200105.733466-6-kan.liang@linux.intel.com>
References: <20230112200105.733466-6-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <167429456532.4906.14087166098724750776.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     5d515ee40cb57ea5331998f27df7946a69f14dc3
Gitweb:        https://git.kernel.org/tip/5d515ee40cb57ea5331998f27df7946a69f14dc3
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 12 Jan 2023 12:01:05 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 21 Jan 2023 00:06:13 +01:00

perf/x86/uncore: Don't WARN_ON_ONCE() for a broken discovery table

The kernel warning message is triggered, when SPR MCC is used.

[   17.945331] ------------[ cut here ]------------
[   17.946305] WARNING: CPU: 65 PID: 1 at
arch/x86/events/intel/uncore_discovery.c:184
intel_uncore_has_discovery_tables+0x4c0/0x65c
[   17.946305] Modules linked in:
[   17.946305] CPU: 65 PID: 1 Comm: swapper/0 Not tainted
5.4.17-2136.313.1-X10-2c+ #4

It's caused by the broken discovery table of UPI.

The discovery tables are from hardware. Except for dropping the broken
information, there is nothing Linux can do. Using WARN_ON_ONCE() is
overkilled.

Use the pr_info() to replace WARN_ON_ONCE(), and specify what uncore unit
is dropped and the reason.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Petlan <mpetlan@redhat.com>
Link: https://lore.kernel.org/r/20230112200105.733466-6-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_discovery.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index abb5119..cb488e4 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -128,13 +128,21 @@ uncore_insert_box_info(struct uncore_unit_discovery *unit,
 	unsigned int *box_offset, *ids;
 	int i;
 
-	if (WARN_ON_ONCE(!unit->ctl || !unit->ctl_offset || !unit->ctr_offset))
+	if (!unit->ctl || !unit->ctl_offset || !unit->ctr_offset) {
+		pr_info("Invalid address is detected for uncore type %d box %d, "
+			"Disable the uncore unit.\n",
+			unit->box_type, unit->box_id);
 		return;
+	}
 
 	if (parsed) {
 		type = search_uncore_discovery_type(unit->box_type);
-		if (WARN_ON_ONCE(!type))
+		if (!type) {
+			pr_info("A spurious uncore type %d is detected, "
+				"Disable the uncore type.\n",
+				unit->box_type);
 			return;
+		}
 		/* Store the first box of each die */
 		if (!type->box_ctrl_die[die])
 			type->box_ctrl_die[die] = unit->ctl;
@@ -169,8 +177,12 @@ uncore_insert_box_info(struct uncore_unit_discovery *unit,
 		ids[i] = type->ids[i];
 		box_offset[i] = type->box_offset[i];
 
-		if (WARN_ON_ONCE(unit->box_id == ids[i]))
+		if (unit->box_id == ids[i]) {
+			pr_info("Duplicate uncore type %d box ID %d is detected, "
+				"Drop the duplicate uncore unit.\n",
+				unit->box_type, unit->box_id);
 			goto free_ids;
+		}
 	}
 	ids[i] = unit->box_id;
 	box_offset[i] = unit->ctl - type->box_ctrl;
