Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA495F5350
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 13:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiJEL0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 07:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJEL0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 07:26:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9716715E;
        Wed,  5 Oct 2022 04:26:45 -0700 (PDT)
Date:   Wed, 05 Oct 2022 11:26:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664969204;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sfr7N/gg/WvlqiHgA41Nb5x088okuEFeoadABhpbunM=;
        b=RH6huhXa5cZb45VhpA4PhlL6KAu6FTBwq5KE/XK299mpjBKTdJB9Xa96ecTewHQ0fMdOSz
        qj7usnPbo7z5rIJla7pmPZroaImWrgn2Yp9ntvki2vFoAfLzAuLd20CKR86XDRq5StNMI+
        rW+pi5rmMjdD5D/Q5YCdsvdq+jgsvQDIt47hWN8YNEu7f3HawV5Y6Vw8E3Nks5cTnm4MBl
        ZudAK/bSxeI6A/taoJ02KYzzKPatz9QvOFeVBmMwXjcF2Zgx3e3WfAt06N2F0C7jHR6FAl
        IEUd8/uAxgtqdi1RWwREk2QmB0NW7jHGcLbmHiPyRDTpTfCkmxcWXK59aJbGEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664969204;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sfr7N/gg/WvlqiHgA41Nb5x088okuEFeoadABhpbunM=;
        b=D5RDCdkZAESi6K7zaDa4JqIf16/8vCkbLfGMlmBPXTwUjmDahagTqV0qHnGerruDJN66vJ
        rZR/GZl670kHPfAA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Fix lockdep_assert_event_ctx()
Cc:     Borislav Petkov <bp@alien8.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YvvIWmDBWdIUCMZj@FVFF77S0Q05N>
References: <YvvIWmDBWdIUCMZj@FVFF77S0Q05N>
MIME-Version: 1.0
Message-ID: <166496920282.401.10655141862829069246.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     0ce38047e82a02017839b6cae837f13a1383a3a0
Gitweb:        https://git.kernel.org/tip/0ce38047e82a02017839b6cae837f13a1383a3a0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 04 Oct 2022 10:46:58 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 04 Oct 2022 13:32:08 +02:00

perf: Fix lockdep_assert_event_ctx()

I'm a flamin' moron; because even after Mark told me it should be '&&'
I still got it wrong in the final commit.

Fixes: f3c0eba28704 ("perf: Add a few assertions")
Reported-by: Borislav Petkov <bp@alien8.de>
Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Borislav Petkov <bp@alien8.de>
Link: https://lkml.kernel.org/r/YvvIWmDBWdIUCMZj@FVFF77S0Q05N
---
 include/linux/perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e9b151c..853f64b 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -644,7 +644,7 @@ struct pmu_event_list {
 #ifdef CONFIG_PROVE_LOCKING
 #define lockdep_assert_event_ctx(event)				\
 	WARN_ON_ONCE(__lockdep_enabled &&			\
-		     (this_cpu_read(hardirqs_enabled) ||	\
+		     (this_cpu_read(hardirqs_enabled) &&	\
 		      lockdep_is_held(&(event)->ctx->mutex) != LOCK_STATE_HELD))
 #else
 #define lockdep_assert_event_ctx(event)
