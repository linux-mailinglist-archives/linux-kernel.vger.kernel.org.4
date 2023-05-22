Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC28670BA17
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 12:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbjEVK1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 06:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbjEVK12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 06:27:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91C013E;
        Mon, 22 May 2023 03:27:26 -0700 (PDT)
Date:   Mon, 22 May 2023 10:27:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684751245;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QyoEJscqttA4sWRI20/kiCjpEBVOAmv+DBGxIn4KKCA=;
        b=hdkdGh31dIvHo/ZCBJHJE1Rw+bbnVsvChIA6M2zpHxUGu6GiZ6amqMMnphXnN61C/ndE7N
        Ge5wn0zBAU+SqMiUww4vUCFENYoR+WhR3hTMsOygiZnVEdtIJJeHDLwdtmcKP+zaXaR1+G
        IiIyDztjlzuEtEbLghgREqoz8k/GjWskW0hCXhWKrz1FtsenzUcLFuPHE852/bBarLn2n2
        RfmuI0CUsUO5YlsOhckPLI5DtFXM0fpeMgtzsycz135F3B5g/awXcwsou4WqO0Nv+dGrsO
        IjHHpOBBfIKnJ1esf7XTTe7sVDr2HAnqDG0b/RQaUtOczqcWtS6Hi9+jRWCgDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684751245;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QyoEJscqttA4sWRI20/kiCjpEBVOAmv+DBGxIn4KKCA=;
        b=PA/grkZfwT3sf7vS5+jW0GqRNtjjE+cFvcyotJNdWrLKLly2kFyURnoGFwTtJ6f+UUJUjC
        5F4bNnfSDru4eqAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] s390/cpum_sf: Convert to cmpxchg128()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230515080554.657068280@infradead.org>
References: <20230515080554.657068280@infradead.org>
MIME-Version: 1.0
Message-ID: <168475124454.404.7157778737320291304.tip-bot2@tip-bot2>
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

Commit-ID:     3cf363a4daf359e8392b5048c619b7e9e429f122
Gitweb:        https://git.kernel.org/tip/3cf363a4daf359e8392b5048c619b7e9e429f122
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 15 May 2023 09:57:10 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 22 May 2023 10:49:51 +02:00

s390/cpum_sf: Convert to cmpxchg128()

Now that there is a cross arch u128 and cmpxchg128(), use those
instead of the custom CDSG helper.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Link: https://lore.kernel.org/r/20230515080554.657068280@infradead.org
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
