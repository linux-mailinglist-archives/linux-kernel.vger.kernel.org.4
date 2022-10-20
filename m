Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E4760629B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 16:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiJTON6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 10:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJTONs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 10:13:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C071DCCD6;
        Thu, 20 Oct 2022 07:13:47 -0700 (PDT)
Date:   Thu, 20 Oct 2022 14:13:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666275225;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qX7WGaoSK1q1bdZUJXrK9ouuTl4TgOi1mdqqgTucn2k=;
        b=cd7dP5fp8sDtQOB+twZK82vxjWfqEO8aibIqgSIzB0mIh0ISFNjUH5WhLqJGW/ZAnjkF2E
        Slm8lvHw622y9NKbHZAdLOCV7K9U/03BnGMIS0htN4zbgkkLmh43X2CfOA+5WR68CK4lcW
        T7gMAtPQNGUoy1ZU5uMNN82DkA1n5njxNnu2p1a3nLbF49kUa6QCMv/FwtkvTru1euGfvD
        UY8gSOxJ0JO7glnzIm1WC0EnPs5JFPphwfBzVaP1qXlJhC2eohoaRQR8nkgT0mtQlIKqsU
        R1aGqWbrF+ob1pwnAdQ7xImxsQS2ffqFjumoLEjmSG0vduf3WIDWD73uNb9ETw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666275225;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qX7WGaoSK1q1bdZUJXrK9ouuTl4TgOi1mdqqgTucn2k=;
        b=1jkMuUvIQXnEpYGfe8qIXplrIFUXnNa72tQoaYE0sDn4H/J6ODNHgD7i4/v8jw2LOkmR0o
        G73Ww+k4jJxa9HDg==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/mtrr: Remove unused cyrix_set_all() function
Cc:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221004081023.32402-3-jgross@suse.com>
References: <20221004081023.32402-3-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <166627522453.401.11341421010355263315.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     04ba8747e1329fa9e274b4634d792f811a3b0677
Gitweb:        https://git.kernel.org/tip/04ba8747e1329fa9e274b4634d792f811a3b0677
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Tue, 04 Oct 2022 10:10:09 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 20 Oct 2022 15:58:11 +02:00

x86/mtrr: Remove unused cyrix_set_all() function

The Cyrix CPU specific MTRR function cyrix_set_all() will never be
called as the mtrr_ops->set_all() callback will only be called in the
use_intel() case, which would require the use_intel_if member of struct
mtrr_ops to be set, which isn't the case for Cyrix.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221004081023.32402-3-jgross@suse.com
---
 arch/x86/kernel/cpu/mtrr/cyrix.c | 34 +-------------------------------
 1 file changed, 34 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/cyrix.c b/arch/x86/kernel/cpu/mtrr/cyrix.c
index ca67091..c77d3b0 100644
--- a/arch/x86/kernel/cpu/mtrr/cyrix.c
+++ b/arch/x86/kernel/cpu/mtrr/cyrix.c
@@ -234,42 +234,8 @@ static void cyrix_set_arr(unsigned int reg, unsigned long base,
 	post_set();
 }
 
-typedef struct {
-	unsigned long	base;
-	unsigned long	size;
-	mtrr_type	type;
-} arr_state_t;
-
-static arr_state_t arr_state[8] = {
-	{0UL, 0UL, 0UL}, {0UL, 0UL, 0UL}, {0UL, 0UL, 0UL}, {0UL, 0UL, 0UL},
-	{0UL, 0UL, 0UL}, {0UL, 0UL, 0UL}, {0UL, 0UL, 0UL}, {0UL, 0UL, 0UL}
-};
-
-static unsigned char ccr_state[7] = { 0, 0, 0, 0, 0, 0, 0 };
-
-static void cyrix_set_all(void)
-{
-	int i;
-
-	prepare_set();
-
-	/* the CCRs are not contiguous */
-	for (i = 0; i < 4; i++)
-		setCx86(CX86_CCR0 + i, ccr_state[i]);
-	for (; i < 7; i++)
-		setCx86(CX86_CCR4 + i, ccr_state[i]);
-
-	for (i = 0; i < 8; i++) {
-		cyrix_set_arr(i, arr_state[i].base,
-			      arr_state[i].size, arr_state[i].type);
-	}
-
-	post_set();
-}
-
 static const struct mtrr_ops cyrix_mtrr_ops = {
 	.vendor            = X86_VENDOR_CYRIX,
-	.set_all	   = cyrix_set_all,
 	.set               = cyrix_set_arr,
 	.get               = cyrix_get_arr,
 	.get_free_region   = cyrix_get_free_region,
