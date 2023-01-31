Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257B4682E4C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjAaNqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjAaNqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:46:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90CA269F;
        Tue, 31 Jan 2023 05:46:10 -0800 (PST)
Date:   Tue, 31 Jan 2023 13:46:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675172768;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FrGh/ielC48S+Gvw31HMgddli84Gj0nnoXXL34oxP64=;
        b=RREFq43XjuybHalGAaEnRtYxFfTubbRjdwl1fMvaX0i5Arz0i5qXUoCwd6pB8ywt3uyXNB
        m9LjOBl1I0UjlGtmSgYKxzA2aFIScJrKd+py59cckSmgOjOBniBHUqac0dIaNZS+Jp+Oga
        QoIzc1cSXikSCA+5XrPMDPNWvY+XXzovKalG8HZfRZDa7IUjaZ4kjnpEw22B4/PGRSACEe
        sebyvVwEkJ+kU2s4QQVEtaRZn31BvAeGpWix3K/QCRwwudBOtnp6xUSBB0lCYkjFVigJ0p
        mNyVx6UgroI66VRWUJImePP1LNt5VAUe9enF7m/ZvhQgOwOoHr275f+pS2m15g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675172768;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FrGh/ielC48S+Gvw31HMgddli84Gj0nnoXXL34oxP64=;
        b=Pxsk8fReqP6/P+1BQW0jAWkYbY82gb31wI0BOEuJ8fnADd+aSbRDMaylpgkQA8vSoIEfFY
        rUrwIaPgzDqlY5BA==
From:   "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] vdso/bits.h: Add BIT_ULL() for the sake of consistency
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221128141003.77929-1-andriy.shevchenko@linux.intel.com>
References: <20221128141003.77929-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Message-ID: <167517276757.4906.5531673096269790656.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     cbdb1f163af2bb90d01be1f0263df1d8d5c9d9d3
Gitweb:        https://git.kernel.org/tip/cbdb1f163af2bb90d01be1f0263df1d8d5c9d9d3
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Mon, 28 Nov 2022 16:10:03 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 31 Jan 2023 14:42:10 +01:00

vdso/bits.h: Add BIT_ULL() for the sake of consistency

The minimization done in 3945ff37d2f4 ("linux/bits.h: Extract common header
for vDSO") was required to isolate the VDSO build from the larger kernel
header impact.

The split added some inconsistency since BIT() and BIT_ULL() are now
defined in the different files which confuses unprepared reader.

Move BIT_ULL() to vdso/bits.h. No functional change.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20221128141003.77929-1-andriy.shevchenko@linux.intel.com

---
 include/linux/bits.h | 1 -
 include/vdso/bits.h  | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 87d1126..7c0cf50 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -6,7 +6,6 @@
 #include <vdso/bits.h>
 #include <asm/bitsperlong.h>
 
-#define BIT_ULL(nr)		(ULL(1) << (nr))
 #define BIT_MASK(nr)		(UL(1) << ((nr) % BITS_PER_LONG))
 #define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
 #define BIT_ULL_MASK(nr)	(ULL(1) << ((nr) % BITS_PER_LONG_LONG))
diff --git a/include/vdso/bits.h b/include/vdso/bits.h
index 6d005a1..388b212 100644
--- a/include/vdso/bits.h
+++ b/include/vdso/bits.h
@@ -5,5 +5,6 @@
 #include <vdso/const.h>
 
 #define BIT(nr)			(UL(1) << (nr))
+#define BIT_ULL(nr)		(ULL(1) << (nr))
 
 #endif	/* __VDSO_BITS_H */
