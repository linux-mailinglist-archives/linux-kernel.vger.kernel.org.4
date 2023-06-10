Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA55572AB5C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 14:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjFJMHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 08:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjFJMHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 08:07:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D762D41;
        Sat, 10 Jun 2023 05:07:53 -0700 (PDT)
Date:   Sat, 10 Jun 2023 12:07:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686398871;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dqhTjGJVv+sS1VkVG+X2pGcGQAgiVCBQXPAZBUMN6Ao=;
        b=Y15D8tDnkyRCi3gXRU1vsorwYCgpjMCrR73BurxgdazLR/hDzBeHaMFkyhuNkbfSeXByz6
        ei8AVkGKGgXgFdBq4LOocb24vLEj88FRbzhRURNKZowDJzJJEirolzCg33TcMheFiI9YPD
        ut29OEgjGNMyrGh7M2JnJd+M1q18q8o58dIuXT9IUKvwa4tX++UtzVweGMRRB5YivZStbm
        dU8NK6euIF8abAnPuMbvRKijh1hdaP46E5/ZBTJ7oy2JGcGjD6LLiK2oQl3+lF6RnuBqsl
        BEWMH/1SZIZNqj9HhOH90wwdJZmSlwWlDbGRKhWME/DCA4rBrrPKXZxuu+LxZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686398871;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dqhTjGJVv+sS1VkVG+X2pGcGQAgiVCBQXPAZBUMN6Ao=;
        b=b/6Rw6CMoR6krTYPNhe515S7zZ6SVtnX5+7ZNtVUCnD0ewBI0t0m9OQe0O2R+0bgIDMP/N
        I0HEPzo/oO+3jSAw==
From:   "tip-bot2 for Lukas Bulwahn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Refer properly to CONFIG_HIGH_RES_TIMERS
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230609094643.26253-1-lukas.bulwahn@gmail.com>
References: <20230609094643.26253-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Message-ID: <168639887089.404.4739586245713692955.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     0babddc4977904509287719c1314b9e04bec2307
Gitweb:        https://git.kernel.org/tip/0babddc4977904509287719c1314b9e04bec2307
Author:        Lukas Bulwahn <lukas.bulwahn@gmail.com>
AuthorDate:    Fri, 09 Jun 2023 11:46:43 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 10 Jun 2023 13:58:35 +02:00

posix-timers: Refer properly to CONFIG_HIGH_RES_TIMERS

Commit c78f261e5dcb ("posix-timers: Clarify posix_timer_fn() comments")
turns an ifdef CONFIG_HIGH_RES_TIMERS into an conditional on
"IS_ENABLED(CONFIG_HIGHRES_TIMERS)"; note that the new conditional refers
to "HIGHRES_TIMERS" not "HIGH_RES_TIMERS" as before.

Fix this typo introduced in that refactoring.

Fixes: c78f261e5dcb ("posix-timers: Clarify posix_timer_fn() comments")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230609094643.26253-1-lukas.bulwahn@gmail.com

---
 kernel/time/posix-timers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 8bb0dcf..17fff68 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -356,7 +356,7 @@ static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
 			 * enabled as the periodic tick based timers are
 			 * automatically aligned to the next tick.
 			 */
-			if (IS_ENABLED(CONFIG_HIGHRES_TIMERS)) {
+			if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS)) {
 				ktime_t kj = TICK_NSEC;
 
 				if (timr->it_interval < kj)
