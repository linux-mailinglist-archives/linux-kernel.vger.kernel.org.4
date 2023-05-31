Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89B5717F78
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbjEaMFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235797AbjEaMEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:04:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E07EE5;
        Wed, 31 May 2023 05:04:52 -0700 (PDT)
Date:   Wed, 31 May 2023 12:04:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685534691;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x5ysQQkdGevGAv6wscsWh4HWYGnVHylYMdBROc2L81M=;
        b=Kd+Q6SiDZ4PGP3i0nCn58EuIAJ+DclpEWfWJFzkaawL5GP20LDEFAKQTMQaUQEmYVc2OQj
        +jVJ29PeruBgPEl/XbLFYbyjkv/LhWYb6P9Ux7iGixo760jVTNir1lLe+DKJP+F5cultss
        5lS7+wTz4Nihr2DDgMgowiupxpSNSavNUcoiKiIc7e9i649D5H0lQxmXosAyd6Mrxj4gzI
        bYFgneDA0Gj5R36dpN62ciJ0psS2T+pK/DGjcsTwJzUKk8J9q1rElvzUPheZmMk6RrDZw5
        z1yNV87oDp9gx9TqzPLQDVW9/4WGRqLAWFRjZglZyLdi4sbfF4/25+isnl3XQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685534691;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x5ysQQkdGevGAv6wscsWh4HWYGnVHylYMdBROc2L81M=;
        b=5UDFISB8wekYIiYH+IgcPop0Bk83Q3/o9btxJy60y+MKjSF/sVlklVzhPwVoV2Ui++5+0F
        QbVc7tAOlGbtUUCA==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Add schedule_user() declaration
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230522195021.3456768-3-arnd@kernel.org>
References: <20230522195021.3456768-3-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <168553469067.404.16818081883671386985.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     378be384e01f13fc44d0adc70873de525586ad74
Gitweb:        https://git.kernel.org/tip/378be384e01f13fc44d0adc70873de525586ad74
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Mon, 22 May 2023 21:50:18 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 30 May 2023 22:46:25 +02:00

sched: Add schedule_user() declaration

The schedule_user() function is used on powerpc and sparc architectures, but
only ever called from assembler, so it has no prototype, causing a harmless W=1
warning:

kernel/sched/core.c:6730:35: error: no previous prototype for 'schedule_user' [-Werror=missing-prototypes]

Add a prototype in sched/sched.h to shut up the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20230522195021.3456768-3-arnd@kernel.org
---
 kernel/sched/sched.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6784462..192e781 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2376,6 +2376,7 @@ static inline struct cpuidle_state *idle_get_state(struct rq *rq)
 #endif
 
 extern void schedule_idle(void);
+asmlinkage void schedule_user(void);
 
 extern void sysrq_sched_debug_show(void);
 extern void sched_init_granularity(void);
