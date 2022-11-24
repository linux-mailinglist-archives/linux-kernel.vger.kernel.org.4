Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3FC63756B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiKXJnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiKXJnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:43:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50183D2DF9;
        Thu, 24 Nov 2022 01:43:06 -0800 (PST)
Date:   Thu, 24 Nov 2022 09:43:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669282985;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zith/c1gooq49wXBjsCVTEvk/wM7F85VYzolXP/wniw=;
        b=JQliAv7K+a3B7CEqR4w6tsOhyXD+4ysfQUklbqzzrHaotdkNYOcZBmin43+EW2X+EVDDU5
        hp62S/oI4xDJ3C/MfGC+2glPSO1WE1Lx7fuYAVxtN+a2mbP0jj9CJl6GPSB3cosxkMe/No
        xyJ/3VuQDG+U2da29csROVuomnArCCl0Bek7KF/xkOJ0idk65KRbAE3sBsNiZVbNCt0LfU
        katevl2o8KVoB1bnUCWLUJOrNYg5zgnclrgLhZivBV5Sb7anLtXg8ZL5wUmoZTK2VDdebB
        IPTE4UU10iWPBMX1J1/HhEHFulgksdORwZZx7sY1B0994pZf/v7CDy5NQMDM4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669282985;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zith/c1gooq49wXBjsCVTEvk/wM7F85VYzolXP/wniw=;
        b=p/wPFPuF+7dv27n5SNFE4nSYcR+9HVz9lZW9XRoqKdDe6iESKWDRLX6AMLRkhE403mNsVg
        s1nMxlyvrfB1K/DA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Fixup SIGTRAP and sample_flags interaction
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166928298371.4906.16784064084816616923.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     af169b7759a9b9369b5106cd07a25c57ce60119e
Gitweb:        https://git.kernel.org/tip/af169b7759a9b9369b5106cd07a25c57ce60119e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 21 Nov 2022 15:57:44 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 24 Nov 2022 10:12:23 +01:00

perf: Fixup SIGTRAP and sample_flags interaction

The perf_event_attr::sigtrap functionality relies on data->addr being
set. However commit 7b0846301531 ("perf: Use sample_flags for addr")
changed this to only initialize data->addr when not 0.

Fixes: 7b0846301531 ("perf: Use sample_flags for addr")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/Y3426b4OimE%2FI5po%40hirez.programming.kicks-ass.net
---
 kernel/events/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8848714..f2bb27e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9328,7 +9328,10 @@ static int __perf_event_overflow(struct perf_event *event,
 			 */
 			WARN_ON_ONCE(event->pending_sigtrap != pending_id);
 		}
-		event->pending_addr = data->addr;
+
+		event->pending_addr = 0;
+		if (data->sample_flags & PERF_SAMPLE_ADDR)
+			event->pending_addr = data->addr;
 		irq_work_queue(&event->pending_irq);
 	}
 
