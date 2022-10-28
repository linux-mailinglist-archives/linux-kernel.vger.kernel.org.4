Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A0C610A80
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJ1GnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiJ1GmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:42:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5993772944;
        Thu, 27 Oct 2022 23:42:10 -0700 (PDT)
Date:   Fri, 28 Oct 2022 06:42:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666939329;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BW/you8f4rr1QL7qlbbGTKZ06UNE5o72CVPnOcTmcC4=;
        b=kxyxDGB9rzHFwGeYlce1wsPsTYgZvZw9uzjaB+QsDGJENhFyPOl26R9f6UTjLZPZLIQ3Ct
        OdtmVYUiKiM2UXrjVpTSB2VpJ2jt0hPQJBHSOuxVXFO0/ASZiH2Hh37+M8RrSrION0F6Zl
        x6d4ay2ekRZ0oUOvau5mqzJIMtgDf/i8aTpOk5jkMqOzcs4Wh+vJG5/1f66/64NPjpZn+/
        4BsG29AHK+CU3NqE4ZxGGmxiSkyzb5F7itFNulllvTzHggqP4oz43g4CBv7CErJFhwx15T
        vF5Qs3EwICkaN7l7zRzf6qX+DIx1nwFMvCeTsjp2D4EvvlQSOrMkEVDRbcIeHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666939329;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BW/you8f4rr1QL7qlbbGTKZ06UNE5o72CVPnOcTmcC4=;
        b=I7tSQmooMDFNRvIKzI4UxybyepbXwuMyg6eZSV77rXKWA0UkeussstDo3DeusP1gk5UDiu
        Typw2bEXVa/tKTBA==
From:   "tip-bot2 for Hao Lee" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/psi: Fix possible missing or delayed pending event
Cc:     Hao Lee <haolee.swjtu@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220919072356.GA29069@haolee.io>
References: <20220919072356.GA29069@haolee.io>
MIME-Version: 1.0
Message-ID: <166693932772.29415.5875809571556519018.tip-bot2@tip-bot2>
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

Commit-ID:     c36eae5a86d15a694968be35d7ff056854997a72
Gitweb:        https://git.kernel.org/tip/c36eae5a86d15a694968be35d7ff056854997a72
Author:        Hao Lee <haolee.swjtu@gmail.com>
AuthorDate:    Mon, 19 Sep 2022 07:23:56 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 27 Oct 2022 11:01:23 +02:00

sched/psi: Fix possible missing or delayed pending event

When a pending event exists and growth is less than the threshold, the
current logic is to skip this trigger without generating event. However,
from e6df4ead85d9 ("psi: fix possible trigger missing in the window"),
our purpose is to generate event as long as pending event exists and the
rate meets the limit, no matter what growth is.
This patch handles this case properly.

Fixes: e6df4ead85d9 ("psi: fix possible trigger missing in the window")
Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Suren Baghdasaryan <surenb@google.com>
Link: https://lore.kernel.org/r/20220919072356.GA29069@haolee.io
---
 kernel/sched/psi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index f4cdf6f..dbaeac9 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -554,10 +554,12 @@ static u64 update_triggers(struct psi_group *group, u64 now)
 
 			/* Calculate growth since last update */
 			growth = window_update(&t->win, now, total[t->state]);
-			if (growth < t->threshold)
-				continue;
+			if (!t->pending_event) {
+				if (growth < t->threshold)
+					continue;
 
-			t->pending_event = true;
+				t->pending_event = true;
+			}
 		}
 		/* Limit event signaling to once per window */
 		if (now < t->last_event_time + t->win.size)
