Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F4672285C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbjFEOJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjFEOIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:08:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DC0113;
        Mon,  5 Jun 2023 07:08:18 -0700 (PDT)
Date:   Mon, 05 Jun 2023 14:08:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685974095;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dkszJiQUc19TYyvNgf2X+55+itRvbG21PgPWoGQFrV0=;
        b=LVD0wn/UZQy0PSSc4bR249DJRbyR6sQZphRbLC9u/ieiDrcyFlUAqm1PHvD0gY0tZvxF7N
        szRJjFHvhJE67E07gSL+E42xJVoymmQlXVPUzlDdxEzPaXBugT7kXx9CyFPBnFb2Z38Z7g
        EXYKxcsPbJo/Ufo2glLcX3fwke65UEdZdkngH/ZwBkMp6I92JYu4Ojgn0KLE690bWLgyrh
        jO5OMsFT+tNn5mAPNo6g5W4uHQeTcTxRI0Tfz/EcYTed76eSoZ+vpoquljvvnwIIcUNjZp
        BDj8Sqog16c19PAQn6wHkAnP59FG+d5ONCFCIfRJq4FogC9G6kE632+uc/yYpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685974095;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dkszJiQUc19TYyvNgf2X+55+itRvbG21PgPWoGQFrV0=;
        b=nh14nP0AE31w6XbaEJGFup5Q3OCU3Z1TGSEnAiwBvRRIxt/q4Pr0mX8MJzLOd1BwShr7lV
        BrM/vrNzc0Re36Cg==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mtrr] x86/mtrr: Add get_effective_type() service function
Cc:     Juergen Gross <jgross@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Michael Kelley <mikelley@microsoft.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230502120931.20719-11-jgross@suse.com>
References: <20230502120931.20719-11-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <168597409499.404.18296081560876564264.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mtrr branch of tip:

Commit-ID:     1ca12099040fec8c6bbcd9fabf37f04ac0d08e48
Gitweb:        https://git.kernel.org/tip/1ca12099040fec8c6bbcd9fabf37f04ac0d08e48
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Tue, 02 May 2023 14:09:25 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 01 Jun 2023 15:04:33 +02:00

x86/mtrr: Add get_effective_type() service function

Add a service function for obtaining the effective cache mode of
overlapping MTRR registers.

Make use of that function in check_type_overlap().

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lore.kernel.org/r/20230502120931.20719-11-jgross@suse.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/mtrr/generic.c | 39 ++++++++++++++---------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 4d8ca62..b944271 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -80,31 +80,30 @@ static u64 get_mtrr_size(u64 mask)
 	return size;
 }
 
+static u8 get_effective_type(u8 type1, u8 type2)
+{
+	if (type1 == MTRR_TYPE_UNCACHABLE || type2 == MTRR_TYPE_UNCACHABLE)
+		return MTRR_TYPE_UNCACHABLE;
+
+	if ((type1 == MTRR_TYPE_WRBACK && type2 == MTRR_TYPE_WRTHROUGH) ||
+	    (type1 == MTRR_TYPE_WRTHROUGH && type2 == MTRR_TYPE_WRBACK))
+		return MTRR_TYPE_WRTHROUGH;
+
+	if (type1 != type2)
+		return MTRR_TYPE_UNCACHABLE;
+
+	return type1;
+}
+
 /*
  * Check and return the effective type for MTRR-MTRR type overlap.
- * Returns 1 if the effective type is UNCACHEABLE, else returns 0
+ * Returns true if the effective type is UNCACHEABLE, else returns false
  */
-static int check_type_overlap(u8 *prev, u8 *curr)
+static bool check_type_overlap(u8 *prev, u8 *curr)
 {
-	if (*prev == MTRR_TYPE_UNCACHABLE || *curr == MTRR_TYPE_UNCACHABLE) {
-		*prev = MTRR_TYPE_UNCACHABLE;
-		*curr = MTRR_TYPE_UNCACHABLE;
-		return 1;
-	}
-
-	if ((*prev == MTRR_TYPE_WRBACK && *curr == MTRR_TYPE_WRTHROUGH) ||
-	    (*prev == MTRR_TYPE_WRTHROUGH && *curr == MTRR_TYPE_WRBACK)) {
-		*prev = MTRR_TYPE_WRTHROUGH;
-		*curr = MTRR_TYPE_WRTHROUGH;
-	}
+	*prev = *curr = get_effective_type(*curr, *prev);
 
-	if (*prev != *curr) {
-		*prev = MTRR_TYPE_UNCACHABLE;
-		*curr = MTRR_TYPE_UNCACHABLE;
-		return 1;
-	}
-
-	return 0;
+	return *prev == MTRR_TYPE_UNCACHABLE;
 }
 
 /**
