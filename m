Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C57A6BBE66
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 22:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjCOVDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 17:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbjCOVDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:03:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29666A2193;
        Wed, 15 Mar 2023 14:02:35 -0700 (PDT)
Date:   Wed, 15 Mar 2023 21:01:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678914086;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rQDe+aTeE4qENndIwz1O+WFE52XvI5+P/zTU+CioWGI=;
        b=3tmcIHL9ZgTfFFqhjE6SYTd6+fF6JZsHb0OjbEOwgxVlKac159KtqjoIKTvvkNuLjopUOj
        IoCsy0t7jVy638x1LW4fjWzM/KiNbDKNU8mJe5G/8V3ZZAJ5qFRGwut2mqIboW7RSaU/HS
        L+0G4ArNziCU9KHYJetNwTlmGWYJcND8XJFZuN9GEF1cWUvJi8Xruag6kSF7BNGyj2S4iR
        AH9x/gOl0+AberMiTRdXmq0QYZfMZTWxL7DxWg8HHlijAcSvVTrP25INMKtSKaDGyB9Z16
        pixa5moefti9ynWTlIB6503ZEsC6074uVGDupdDuQG2rNXYv5kcCB8Mvy/lKvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678914086;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rQDe+aTeE4qENndIwz1O+WFE52XvI5+P/zTU+CioWGI=;
        b=oaO34zHgrXlq27uIrPDl2B4fNXAHj/KEA03NTcDMPBFo27ul9nd8Ub+HLgfruzL4FhhB4U
        FhGAYuDsql9I9WCA==
From:   "tip-bot2 for Budimir Markovic" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Fix check before add_event_to_groups() in
 perf_group_detach()
Cc:     Budimir Markovic <markovicbudimir@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <ZBFzvQV9tEqoHEtH@gentoo>
References: <ZBFzvQV9tEqoHEtH@gentoo>
MIME-Version: 1.0
Message-ID: <167891408482.5837.1916820071250811928.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     fd0815f632c24878e325821943edccc7fde947a2
Gitweb:        https://git.kernel.org/tip/fd0815f632c24878e325821943edccc7fde947a2
Author:        Budimir Markovic <markovicbudimir@gmail.com>
AuthorDate:    Wed, 15 Mar 2023 00:29:01 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Mar 2023 21:49:47 +01:00

perf: Fix check before add_event_to_groups() in perf_group_detach()

Events should only be added to a groups rb tree if they have not been
removed from their context by list_del_event(). Since remove_on_exec
made it possible to call list_del_event() on individual events before
they are detached from their group, perf_group_detach() should check each
sibling's attach_state before calling add_event_to_groups() on it.

Fixes: 2e498d0a74e5 ("perf: Add support for event removal on exec")
Signed-off-by: Budimir Markovic <markovicbudimir@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/ZBFzvQV9tEqoHEtH@gentoo
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 52b4aa0..fb3e436 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2163,7 +2163,7 @@ static void perf_group_detach(struct perf_event *event)
 		/* Inherit group flags from the previous leader */
 		sibling->group_caps = event->group_caps;
 
-		if (!RB_EMPTY_NODE(&event->group_node)) {
+		if (sibling->attach_state & PERF_ATTACH_CONTEXT) {
 			add_event_to_groups(sibling, event->ctx);
 
 			if (sibling->state == PERF_EVENT_STATE_ACTIVE)
