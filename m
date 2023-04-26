Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0606EFC9B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 23:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbjDZVrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 17:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjDZVrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 17:47:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAA92117;
        Wed, 26 Apr 2023 14:47:04 -0700 (PDT)
Date:   Wed, 26 Apr 2023 21:47:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682545623;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KQuo3d4P5gQGjpvK7A0kC5EdnNgTBwyZ2BSsfJfvJlE=;
        b=PBgEjcrDsuP+n0l0xUptJQrkvf6eM/kkm0v6w+Sqp8gRhNiHSGM4MYD1mmSl68TRUXVvzo
        l7p0ikmWdndmrPa2121h0e7nBxU2ACYYegjSO13ocMc+PFFS+h2wU2RMaQC1fWmoBWNtDQ
        ODk/8aDzM4Aaqkm/lrspdHcKchKdxq9KYOXjQ03WipsauyNTnNBZCxITrXlwM7h4f39Iyi
        C/XTulSN/n6nPMn3aaoqjGVdFxh3bNAg7GA6UnbBO07PP8l3hDm0tJE1T/UeK/H/cdVmG5
        C6QQsUwqAEawk1botWaaCtBDrRAeTSOVwIxNXhxV4+94kkBXBWU0cnuKscpQYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682545623;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KQuo3d4P5gQGjpvK7A0kC5EdnNgTBwyZ2BSsfJfvJlE=;
        b=oTfFcwsmBbtezdILyL6GCuARK/2gLQMI0QHlAmDv/rC3dyj1z885lpWMHwj1NvaAEBP6c3
        xmgBP78uW9UPNDAA==
From:   "tip-bot2 for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Fix references to nonexistent
 ktime_get_fast_ns()
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C06df7b3cbd94f016403bbf6cd2b38e4368e7468f=2E16825?=
 =?utf-8?q?16546=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
References: =?utf-8?q?=3C06df7b3cbd94f016403bbf6cd2b38e4368e7468f=2E168251?=
 =?utf-8?q?6546=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
MIME-Version: 1.0
Message-ID: <168254562244.404.1273757431267749477.tip-bot2@tip-bot2>
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

Commit-ID:     158009f1b4a33bc0f354b994eea361362bd83226
Gitweb:        https://git.kernel.org/tip/158009f1b4a33bc0f354b994eea361362bd83226
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Wed, 26 Apr 2023 15:43:34 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 26 Apr 2023 23:43:16 +02:00

timekeeping: Fix references to nonexistent ktime_get_fast_ns()

There was never a function named ktime_get_fast_ns().
Presumably these should refer to ktime_get_mono_fast_ns() instead.

Fixes: c1ce406e80fb15fa ("timekeeping: Fix up function documentation for the NMI safe accessors")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/r/06df7b3cbd94f016403bbf6cd2b38e4368e7468f.1682516546.git.geert+renesas@glider.be

---
 kernel/time/timekeeping.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 5579ead..09d5949 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -526,7 +526,7 @@ EXPORT_SYMBOL_GPL(ktime_get_raw_fast_ns);
  * partially updated.  Since the tk->offs_boot update is a rare event, this
  * should be a rare occurrence which postprocessing should be able to handle.
  *
- * The caveats vs. timestamp ordering as documented for ktime_get_fast_ns()
+ * The caveats vs. timestamp ordering as documented for ktime_get_mono_fast_ns()
  * apply as well.
  */
 u64 notrace ktime_get_boot_fast_ns(void)
@@ -576,7 +576,7 @@ static __always_inline u64 __ktime_get_real_fast(struct tk_fast *tkf, u64 *mono)
 /**
  * ktime_get_real_fast_ns: - NMI safe and fast access to clock realtime.
  *
- * See ktime_get_fast_ns() for documentation of the time stamp ordering.
+ * See ktime_get_mono_fast_ns() for documentation of the time stamp ordering.
  */
 u64 ktime_get_real_fast_ns(void)
 {
