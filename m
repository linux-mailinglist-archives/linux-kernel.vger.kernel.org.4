Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C5F721FDD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjFEHm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjFEHmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:42:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0478BA1;
        Mon,  5 Jun 2023 00:42:51 -0700 (PDT)
Date:   Mon, 05 Jun 2023 07:42:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685950969;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8T43z+bFqrRPOUXgVLPudvMYdsUzhzBF2ToF+rDkcbE=;
        b=k+JRjJWZYDHO8aSZk4mVFZs10Ppnu55n5ORmUKT3QxmKJ6gPFgDNZTCKoHgXjZEL4qRO6v
        xOeFWxWieviw497UuJ6pSqRdTkXF3vcLd5ZBtDXGV2HoahVrZtYbiE9uUrbbBcF7nOBW4h
        2jorB4PPC0xgU4z30gHxTRavuxDmR0O4Qqnu06nk84YCA/Ezzjjh+dhpb0qGfi0mZyYf7V
        7oHi3V08jXY9jfT+oiYrgCqdptmOh0OypGtxybcq9I0zUiK0NP/rWIke+2x5/Bb2ELBVqr
        5B2VlVF1im8cVdl7ABmjeXjlJAsQwmZfcCsOEnjxqRW9lK7U/HMdveDeCydJqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685950969;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8T43z+bFqrRPOUXgVLPudvMYdsUzhzBF2ToF+rDkcbE=;
        b=hppRXyoRQfwdRpJcCrmaHcvWhk/jGFRDDyLB9maJc1r7e8ayq3x2fmPB/dXMV3M/6ExQID
        RQEoCsLrPW+0CwBQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] s390/cpum_sf: Convert to cmpxchg128()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230531132324.058821078@infradead.org>
References: <20230531132324.058821078@infradead.org>
MIME-Version: 1.0
Message-ID: <168595096882.404.380408005160138313.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     497cc42bf53b55185ab3d39c634fbf09eb6681ae
Gitweb:        https://git.kernel.org/tip/497cc42bf53b55185ab3d39c634fbf09eb6681ae
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 31 May 2023 15:08:45 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 09:36:40 +02:00

s390/cpum_sf: Convert to cmpxchg128()

Now that there is a cross arch u128 and cmpxchg128(), use those
instead of the custom CDSG helper.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20230531132324.058821078@infradead.org
---
 arch/s390/include/asm/cpu_mf.h  |  2 +-
 arch/s390/kernel/perf_cpum_sf.c | 16 +++-------------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/s390/include/asm/cpu_mf.h b/arch/s390/include/asm/cpu_mf.h
index 7e417d7..a0de5b9 100644
--- a/arch/s390/include/asm/cpu_mf.h
+++ b/arch/s390/include/asm/cpu_mf.h
@@ -140,7 +140,7 @@ union hws_trailer_header {
 		unsigned int dsdes:16;	/* 48-63: size of diagnostic SDE */
 		unsigned long long overflow; /* 64 - Overflow Count   */
 	};
-	__uint128_t val;
+	u128 val;
 };
 
 struct hws_trailer_entry {
diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 7ef72f5..8ecfbce 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1271,16 +1271,6 @@ static void hw_collect_samples(struct perf_event *event, unsigned long *sdbt,
 	}
 }
 
-static inline __uint128_t __cdsg(__uint128_t *ptr, __uint128_t old, __uint128_t new)
-{
-	asm volatile(
-		"	cdsg	%[old],%[new],%[ptr]\n"
-		: [old] "+d" (old), [ptr] "+QS" (*ptr)
-		: [new] "d" (new)
-		: "memory", "cc");
-	return old;
-}
-
 /* hw_perf_event_update() - Process sampling buffer
  * @event:	The perf event
  * @flush_all:	Flag to also flush partially filled sample-data-blocks
@@ -1352,7 +1342,7 @@ static void hw_perf_event_update(struct perf_event *event, int flush_all)
 			new.f = 0;
 			new.a = 1;
 			new.overflow = 0;
-			prev.val = __cdsg(&te->header.val, old.val, new.val);
+			prev.val = cmpxchg128(&te->header.val, old.val, new.val);
 		} while (prev.val != old.val);
 
 		/* Advance to next sample-data-block */
@@ -1562,7 +1552,7 @@ static bool aux_set_alert(struct aux_buffer *aux, unsigned long alert_index,
 		}
 		new.a = 1;
 		new.overflow = 0;
-		prev.val = __cdsg(&te->header.val, old.val, new.val);
+		prev.val = cmpxchg128(&te->header.val, old.val, new.val);
 	} while (prev.val != old.val);
 	return true;
 }
@@ -1636,7 +1626,7 @@ static bool aux_reset_buffer(struct aux_buffer *aux, unsigned long range,
 				new.a = 1;
 			else
 				new.a = 0;
-			prev.val = __cdsg(&te->header.val, old.val, new.val);
+			prev.val = cmpxchg128(&te->header.val, old.val, new.val);
 		} while (prev.val != old.val);
 		*overflow += orig_overflow;
 	}
