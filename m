Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F24D73484B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 22:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjFRUuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 16:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjFRUt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 16:49:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9061B123;
        Sun, 18 Jun 2023 13:49:57 -0700 (PDT)
Date:   Sun, 18 Jun 2023 20:49:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687121395;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9NKlCjYYtsYEMjkky+I/67VkCfEEfQE7QK6wpqKMOlA=;
        b=rYwDR51KUwq9OCjUYHjQbLwtq1B2O2E/NLeo15lXHhEVnqP1AEp6feZABsf2SVGJ5h8WRe
        55iyO9Yodb2rTAfTpMSRwkQ7pEUPXTf9XdaDx4HEEmdeXphodBrY4MDt0CgQJH+ih71xbg
        j8SogqgQ7OuPGejvpNd6j1uLw1u+BQ4UvLnLP820FQKEf5yTI/iIKNV9MyDNquAophBGEV
        +vJC7C5BQ8a25iXfDSikGg4oJL1KmIPTDTWRUfc+/CsJaF7BNsOuG5ZOHK6VIsPTCgSZGg
        RBGucH4Z+Bg+YNq2FFUz7Y3BIvATk0fQ4VWEGVs2apuhWTeE2qXp8qE6kQzAgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687121395;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9NKlCjYYtsYEMjkky+I/67VkCfEEfQE7QK6wpqKMOlA=;
        b=X8/BUldorilHZ6M9r/BYdJLrvKK6ENfiZqhvIqCEBN7oAVpZAaRfDP4EmHSTbhnsTOhBPD
        h3CDG7gIfCbI8CAA==
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
Message-ID: <168712139525.404.13303439009029401314.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b9a40f24d8ea86f89f1299a3f2dccd601febe3e5
Gitweb:        https://git.kernel.org/tip/b9a40f24d8ea86f89f1299a3f2dccd601febe3e5
Author:        Lukas Bulwahn <lukas.bulwahn@gmail.com>
AuthorDate:    Fri, 09 Jun 2023 11:46:43 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 18 Jun 2023 22:41:53 +02:00

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
index e3cddd5..b924f0f 100644
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
