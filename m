Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4DB6CB975
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjC1Ieu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjC1Ies (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:34:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2A0420A;
        Tue, 28 Mar 2023 01:34:47 -0700 (PDT)
Date:   Tue, 28 Mar 2023 08:34:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679992485;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JwnODAabhQth5uPvugI0OVmAVkGREG74VHgJRy0IVJk=;
        b=OOdP35I/3UcZDG6TUGzUxPHPbHwqQ19fkFhusHa3gjLbmHzF6SxN9NgqCL6+XxDnK+lqIa
        xHzr47pV1J0D4GEGWa7uXINGb0OIVuciXF40hR3V4i15LlAMtVCKmCwZerLxte7Dw43hiD
        JCYPJZicV3akjEXhYEbCJNvF2CxwpSWTsbjgMnNBPc4ER+EhCRbM3rjIODUujBYqBZckQb
        an6YaGjonGD0obc6xWgbSdJFmZtAJeo4vSFQ89/xUpqsMTlVVG8RehMk31iJFp23GQensj
        Thh3TPpVCLM4CWecvljGiF6lcPeLQPl6QZ3p2kL1eeYhlVOL0FmcQgpH0BV1LQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679992485;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JwnODAabhQth5uPvugI0OVmAVkGREG74VHgJRy0IVJk=;
        b=/IcDuLfFtcmOyg0aOFo84DfrAuTROQ2Z0lLprU4egfclBPSyNOFPRsuR4Kl92GceVu48qy
        LYJNkPbp8XD1xaDA==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] smp: reword smp call IPI comment
Cc:     Valentin Schneider <vschneid@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230307143558.294354-7-vschneid@redhat.com>
References: <20230307143558.294354-7-vschneid@redhat.com>
MIME-Version: 1.0
Message-ID: <167999248523.5837.16636131269794439264.tip-bot2@tip-bot2>
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

Commit-ID:     253a0fb4c62827cdcaf43afcea5d675507eaf7a3
Gitweb:        https://git.kernel.org/tip/253a0fb4c62827cdcaf43afcea5d675507eaf7a3
Author:        Valentin Schneider <vschneid@redhat.com>
AuthorDate:    Tue, 07 Mar 2023 14:35:57 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 24 Mar 2023 11:01:28 +01:00

smp: reword smp call IPI comment

Accessing the call_single_queue hasn't involved a spinlock since 2014:

  6897fc22ea01 ("kernel: use lockless list for smp_call_function_single")

The llist operations (namely cmpxchg() and xchg()) provide similar ordering
guarantees, update the comment to lessen confusion.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230307143558.294354-7-vschneid@redhat.com
---
 kernel/smp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 03e6d57..6bbfabb 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -312,9 +312,10 @@ static DEFINE_PER_CPU_SHARED_ALIGNED(call_single_data_t, csd_data);
 void __smp_call_single_queue(int cpu, struct llist_node *node)
 {
 	/*
-	 * The list addition should be visible before sending the IPI
-	 * handler locks the list to pull the entry off it because of
-	 * normal cache coherency rules implied by spinlocks.
+	 * The list addition should be visible to the target CPU when it pops
+	 * the head of the list to pull the entry off it in the IPI handler
+	 * because of normal cache coherency rules implied by the underlying
+	 * llist ops.
 	 *
 	 * If IPIs can go out of order to the cache coherency protocol
 	 * in an architecture, sufficient synchronisation should be added
