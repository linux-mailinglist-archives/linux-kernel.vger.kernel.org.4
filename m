Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F57C6011DD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJQO4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiJQOyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:54:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5D269189;
        Mon, 17 Oct 2022 07:53:54 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:53:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018422;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UBncsy5uYRiVGI8l5tIwwcEesmWr7npCVGsdQkuHF8g=;
        b=GrRqWyDRqUCS7nc/6mqCcqkaf3a4T+qKBWvPR8ZzFfiGB4+7lW3RCRVhJJjk207wWDIZSu
        oaN3m4WdaL3Klo5yJ8HDGyiad7aSCkBt84Xmfetqwl17N6wOzNojIafMvpElCfLF8Q5W7J
        60eW/heN1UkuycHnOI1OAnNsn4osYjZ2LaUowBnuFNcsBN0WYm5eT6xP3EumOH9Y52LUpE
        R+SIjxHAkovme4gLeR6yUIG643Q75RIMj2tPZB8/Zef97Y8XApA9WQXLpFohOdEoN8GfFY
        Prxwjkhyg87o9Pa2YgPLWIKZnNmxgcxNCOsEwQaDUz7NcK1mWPo47QK6ZM5icg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018422;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UBncsy5uYRiVGI8l5tIwwcEesmWr7npCVGsdQkuHF8g=;
        b=zUUBZzsyIQRHULEL/I8TWe4+NGxEGCM1pzFrSMzwQSGRI8LBxki9ux5dz84kvXxSa+dLXg
        wR/gRm0rgSpW5yAA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/asm: Provide ALTERNATIVE_3
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111147.787711192@infradead.org>
References: <20220915111147.787711192@infradead.org>
MIME-Version: 1.0
Message-ID: <166601842167.401.14452628913738376761.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     52354973573cc260ff2fc661cb28ff8eaa7b879b
Gitweb:        https://git.kernel.org/tip/52354973573cc260ff2fc661cb28ff8eaa7b879b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 15 Sep 2022 13:11:26 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:14 +02:00

x86/asm: Provide ALTERNATIVE_3

Fairly straight forward adaptation/extention of ALTERNATIVE_2.

Required for call depth tracking.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111147.787711192@infradead.org
---
 arch/x86/include/asm/alternative.h | 33 ++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index ef007fa..4c416b2 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -364,6 +364,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 #define old_len			141b-140b
 #define new_len1		144f-143f
 #define new_len2		145f-144f
+#define new_len3		146f-145f
 
 /*
  * gas compatible max based on the idea from:
@@ -371,7 +372,8 @@ static inline int alternatives_text_reserved(void *start, void *end)
  *
  * The additional "-" is needed because gas uses a "true" value of -1.
  */
-#define alt_max_short(a, b)	((a) ^ (((a) ^ (b)) & -(-((a) < (b)))))
+#define alt_max_2(a, b)		((a) ^ (((a) ^ (b)) & -(-((a) < (b)))))
+#define alt_max_3(a, b, c)	(alt_max_2(alt_max_2(a, b), c))
 
 
 /*
@@ -383,8 +385,8 @@ static inline int alternatives_text_reserved(void *start, void *end)
 140:
 	\oldinstr
 141:
-	.skip -((alt_max_short(new_len1, new_len2) - (old_len)) > 0) * \
-		(alt_max_short(new_len1, new_len2) - (old_len)),0x90
+	.skip -((alt_max_2(new_len1, new_len2) - (old_len)) > 0) * \
+		(alt_max_2(new_len1, new_len2) - (old_len)),0x90
 142:
 
 	.pushsection .altinstructions,"a"
@@ -401,6 +403,31 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	.popsection
 .endm
 
+.macro ALTERNATIVE_3 oldinstr, newinstr1, feature1, newinstr2, feature2, newinstr3, feature3
+140:
+	\oldinstr
+141:
+	.skip -((alt_max_3(new_len1, new_len2, new_len3) - (old_len)) > 0) * \
+		(alt_max_3(new_len1, new_len2, new_len3) - (old_len)),0x90
+142:
+
+	.pushsection .altinstructions,"a"
+	altinstruction_entry 140b,143f,\feature1,142b-140b,144f-143f
+	altinstruction_entry 140b,144f,\feature2,142b-140b,145f-144f
+	altinstruction_entry 140b,145f,\feature3,142b-140b,146f-145f
+	.popsection
+
+	.pushsection .altinstr_replacement,"ax"
+143:
+	\newinstr1
+144:
+	\newinstr2
+145:
+	\newinstr3
+146:
+	.popsection
+.endm
+
 /* If @feature is set, patch in @newinstr_yes, otherwise @newinstr_no. */
 #define ALTERNATIVE_TERNARY(oldinstr, feature, newinstr_yes, newinstr_no) \
 	ALTERNATIVE_2 oldinstr, newinstr_no, X86_FEATURE_ALWAYS,	\
