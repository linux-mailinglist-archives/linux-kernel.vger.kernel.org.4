Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E64601128
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiJQObK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiJQObI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:31:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EAE659DE;
        Mon, 17 Oct 2022 07:31:05 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:31:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666017063;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o1vuoWLh9v44oGvxqgENx+Nmjiw2B1fjs3Rt8xCgrIk=;
        b=E4NRedXH2wU2cPOWvvx26if+JOXY4JfPjL2zaLtOnQRvWEGrEpKfm7XfD1UR+pugpY1oQR
        7s0IeJ8cyVAauBzlzQ7FF59GBQbFQyhExjJRI6m0QfEgXpXTRlc+pY6THUIOiN4K8Zm9mJ
        0VI1OFnzExj/tc4EKzytdruLM4L3w2ZL2/0QrBqbuAQb2MrSzW08Jbg6inHMcMkErJVJVA
        WiLlP8F1XQQODpWMOU3ZzzdOcMaeFmR4ndypMiOStV3xO1r/MPFT4FlCVbW4WFqb32794U
        bOo/4DTXozHR0o1ULg1JcET41rAOIkawCzDVdNnxOvwrSjLEB08otU8TkK3KXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666017063;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o1vuoWLh9v44oGvxqgENx+Nmjiw2B1fjs3Rt8xCgrIk=;
        b=HJURYBK9KeHmrK+iWmO9FZdiBDeH/NiHRH0aSE3ri9WSRPYf9GTY+kgukKxrP6FA9fWPkz
        mhRVQogSpufMLuDQ==
From:   "tip-bot2 for Chen Lifu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/tsc: Make art_related_clocksource static
Cc:     Chen Lifu <chenlifu@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220823021821.3052159-1-chenlifu@huawei.com>
References: <20220823021821.3052159-1-chenlifu@huawei.com>
MIME-Version: 1.0
Message-ID: <166601706216.401.10492698208850639850.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     3548eda8ae284d6d412d59f11cd20fc7df05362b
Gitweb:        https://git.kernel.org/tip/3548eda8ae284d6d412d59f11cd20fc7df05362b
Author:        Chen Lifu <chenlifu@huawei.com>
AuthorDate:    Tue, 23 Aug 2022 10:18:21 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Oct 2022 16:20:48 +02:00

x86/tsc: Make art_related_clocksource static

The symbol is not used outside of the file, so mark it static.

Fixes the following warning:

arch/x86/kernel/tsc.c:53:20: warning:
	symbol 'art_related_clocksource' was not declared. Should it be static?

Signed-off-by: Chen Lifu <chenlifu@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20220823021821.3052159-1-chenlifu@huawei.com

---
 arch/x86/kernel/tsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index cafacb2..a78e73d 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -51,7 +51,7 @@ int tsc_clocksource_reliable;
 static u32 art_to_tsc_numerator;
 static u32 art_to_tsc_denominator;
 static u64 art_to_tsc_offset;
-struct clocksource *art_related_clocksource;
+static struct clocksource *art_related_clocksource;
 
 struct cyc2ns {
 	struct cyc2ns_data data[2];	/*  0 + 2*16 = 32 */
