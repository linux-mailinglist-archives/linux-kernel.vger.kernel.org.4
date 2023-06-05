Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D877722F89
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbjFETQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235375AbjFETQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:16:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741A411C;
        Mon,  5 Jun 2023 12:16:20 -0700 (PDT)
Date:   Mon, 05 Jun 2023 19:16:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685992577;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FMX6sR8OxV/nwgtO7yn/9mSy9vbpf2bOB1RbjuWlFxo=;
        b=RZxM2IXjySZMgAMkTewcVxm3amb3KIc+jZ7JR3S8D1AwSzixnX+Xc3IphevYkj563HJ78z
        bHMaMvA1MQ0mtrkPGQMobHNLWzDHQobtcxD0EFbgAzTO2V27ulMK2je1Yb1MK54LT7BbWn
        E4hWATg8IOmEKkBmo6rdcDgKajrdAwCKWHotenoW5/T2OfNWC99nY43G6NodFc3ewhLnkB
        eV69k45Vr2gT84mbrRMjRw4mwcv7ayiXiMk8VzVk6lyMC9AQvOK5vbSXcTBLgr0NrEVjBE
        7vhM2OMsRKiklbq5W5vZ3IqqGBk6XcP9hkifi3AiMWTKofepKoTpLe2wVC6iig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685992577;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FMX6sR8OxV/nwgtO7yn/9mSy9vbpf2bOB1RbjuWlFxo=;
        b=osgQWA9Br4UsojCMx5GHRabjycQLS4avE8r1FsKpB2F8g5cak7bCisJx1QN/VWi/WYOhU1
        0xw0YXmJUZpNMxAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] x86/vdso: Fix gettimeofday masking
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230519102715.704767397@infradead.org>
References: <20230519102715.704767397@infradead.org>
MIME-Version: 1.0
Message-ID: <168599257719.404.819319672226097594.tip-bot2@tip-bot2>
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

Commit-ID:     77750f78b0b3247c64b9821b49158cafe0506880
Gitweb:        https://git.kernel.org/tip/77750f78b0b3247c64b9821b49158cafe0506880
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 19 May 2023 12:21:06 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 21:11:07 +02:00

x86/vdso: Fix gettimeofday masking

Because of how the virtual clocks use U64_MAX as an exception value
instead of a valid time, the clocks can no longer be assumed to wrap
cleanly. This is then compounded by arch_vdso_cycles_ok() rejecting
everything with the MSB/Sign-bit set.

Therefore, the effective mask becomes S64_MAX, and the comment with
vdso_calc_delta() that states the mask is U64_MAX and isn't optimized
out is just plain silly.

Now, the code has a negative filter -- to deal with TSC wobbles:

	if (cycles > last)

which is just plain wrong, because it should've been written as:

	if ((s64)(cycles - last) > 0)

to take wrapping into account, but per all the above, we don't
actually wrap on u64 anymore.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>  # Hyper-V
Link: https://lore.kernel.org/r/20230519102715.704767397@infradead.org
---
 arch/x86/include/asm/vdso/gettimeofday.h | 39 ++++++++++++++++-------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index 4cf6794..0badf0a 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -231,14 +231,17 @@ static u64 vread_pvclock(void)
 		ret = __pvclock_read_cycles(pvti, rdtsc_ordered());
 	} while (pvclock_read_retry(pvti, version));
 
-	return ret;
+	return ret & S64_MAX;
 }
 #endif
 
 #ifdef CONFIG_HYPERV_TIMER
 static u64 vread_hvclock(void)
 {
-	return hv_read_tsc_page(&hvclock_page);
+	u64 ret = hv_read_tsc_page(&hvclock_page);
+	if (likely(ret != U64_MAX))
+		ret &= S64_MAX;
+	return ret;
 }
 #endif
 
@@ -246,7 +249,7 @@ static inline u64 __arch_get_hw_counter(s32 clock_mode,
 					const struct vdso_data *vd)
 {
 	if (likely(clock_mode == VDSO_CLOCKMODE_TSC))
-		return (u64)rdtsc_ordered();
+		return (u64)rdtsc_ordered() & S64_MAX;
 	/*
 	 * For any memory-mapped vclock type, we need to make sure that gcc
 	 * doesn't cleverly hoist a load before the mode check.  Otherwise we
@@ -284,6 +287,9 @@ static inline bool arch_vdso_clocksource_ok(const struct vdso_data *vd)
  * which can be invalidated asynchronously and indicate invalidation by
  * returning U64_MAX, which can be effectively tested by checking for a
  * negative value after casting it to s64.
+ *
+ * This effectively forces a S64_MAX mask on the calculations, unlike the
+ * U64_MAX mask normally used by x86 clocksources.
  */
 static inline bool arch_vdso_cycles_ok(u64 cycles)
 {
@@ -303,18 +309,29 @@ static inline bool arch_vdso_cycles_ok(u64 cycles)
  * @last. If not then use @last, which is the base time of the current
  * conversion period.
  *
- * This variant also removes the masking of the subtraction because the
- * clocksource mask of all VDSO capable clocksources on x86 is U64_MAX
- * which would result in a pointless operation. The compiler cannot
- * optimize it away as the mask comes from the vdso data and is not compile
- * time constant.
+ * This variant also uses a custom mask because while the clocksource mask of
+ * all the VDSO capable clocksources on x86 is U64_MAX, the above code uses
+ * U64_MASK as an exception value, additionally arch_vdso_cycles_ok() above
+ * declares everything with the MSB/Sign-bit set as invalid. Therefore the
+ * effective mask is S64_MAX.
  */
 static __always_inline
 u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
 {
-	if (cycles > last)
-		return (cycles - last) * mult;
-	return 0;
+	/*
+	 * Due to the MSB/Sign-bit being used as invald marker (see
+	 * arch_vdso_cycles_valid() above), the effective mask is S64_MAX.
+	 */
+	u64 delta = (cycles - last) & S64_MAX;
+
+	/*
+	 * Due to the above mentioned TSC wobbles, filter out negative motion.
+	 * Per the above masking, the effective sign bit is now bit 62.
+	 */
+	if (unlikely(delta & (1ULL << 62)))
+		return 0;
+
+	return delta * mult;
 }
 #define vdso_calc_delta vdso_calc_delta
 
