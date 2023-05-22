Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368C570B6A2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjEVHgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbjEVHgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:36:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D479E;
        Mon, 22 May 2023 00:36:21 -0700 (PDT)
Date:   Mon, 22 May 2023 07:36:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684740979;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HclomYqxXBZ3OnkgIaxRM8YAcyCDYke5WBWeP1ix/lw=;
        b=Qc0MfG3X1248XuNE9WaDt+x2HX8f8rrqlsmFdQIZ7KsasEq5rIHW7wm0JrJCtIo58yxs+G
        XkFMpTLtgqE5PnwxuPCYZ3Kli1N1dD6DinY80wDxdpCSo2MwSnijRIIZ/EIbVgs8QLtykT
        W8XgklWYRLiXE3XCbs6i5XFY/hLz0AAq1rVegQrq5fcbSt+z2FtAHJDDzQij/I8BJtveAa
        TNWAFth4Y7o/vxVgc1cF9rtVma32IS4KFFgo2VkOTZTu7B6/TWLeEhA6Bk38jZ2G6GNdeF
        t/NQRXvxIETVviINl2M6yp5M2DA6JDOqaCOPmXUIh0m5L6AoIOECvhmNr2TeTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684740979;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HclomYqxXBZ3OnkgIaxRM8YAcyCDYke5WBWeP1ix/lw=;
        b=T+QkETzs/yzNykD1Z+lT2Uw6kLU6zf0dPIdZQVGAXZpfG2BlFuNUsgbHdKW+IGaEiWSVTI
        eHTL3cpGR8ZKSOCA==
From:   "tip-bot2 for Yang Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/psi: Avoid resetting the min update period
 when it is unnecessary
Cc:     Yang Yang <yang.yang29@zte.com.cn>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230514163338.834345-1-surenb@google.com>
References: <20230514163338.834345-1-surenb@google.com>
MIME-Version: 1.0
Message-ID: <168474097813.404.1664592171771825825.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e2a1f85bf9f509afd09b5d3308e3489b65845c28
Gitweb:        https://git.kernel.org/tip/e2a1f85bf9f509afd09b5d3308e3489b65845c28
Author:        Yang Yang <yang.yang29@zte.com.cn>
AuthorDate:    Sun, 14 May 2023 09:33:38 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 20 May 2023 12:53:16 +02:00

sched/psi: Avoid resetting the min update period when it is unnecessary

Psi_group's poll_min_period is determined by the minimum window size of
psi_trigger when creating new triggers. While destroying a psi_trigger,
there is no need to reset poll_min_period if the psi_trigger being
destroyed did not have the minimum window size, since in this condition
poll_min_period will remain the same as before.

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Suren Baghdasaryan <surenb@google.com>
Link: https://lkml.kernel.org/r/20230514163338.834345-1-surenb@google.com
---
 kernel/sched/psi.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index b49af59..81fca77 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1407,11 +1407,16 @@ void psi_trigger_destroy(struct psi_trigger *t)
 			group->rtpoll_nr_triggers[t->state]--;
 			if (!group->rtpoll_nr_triggers[t->state])
 				group->rtpoll_states &= ~(1 << t->state);
-			/* reset min update period for the remaining triggers */
-			list_for_each_entry(tmp, &group->rtpoll_triggers, node)
-				period = min(period, div_u64(tmp->win.size,
-						UPDATES_PER_WINDOW));
-			group->rtpoll_min_period = period;
+			/*
+			 * Reset min update period for the remaining triggers
+			 * iff the destroying trigger had the min window size.
+			 */
+			if (group->rtpoll_min_period == div_u64(t->win.size, UPDATES_PER_WINDOW)) {
+				list_for_each_entry(tmp, &group->rtpoll_triggers, node)
+					period = min(period, div_u64(tmp->win.size,
+							UPDATES_PER_WINDOW));
+				group->rtpoll_min_period = period;
+			}
 			/* Destroy rtpoll_task when the last trigger is destroyed */
 			if (group->rtpoll_states == 0) {
 				group->rtpoll_until = 0;
