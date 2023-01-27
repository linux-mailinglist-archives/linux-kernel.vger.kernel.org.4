Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A81D67EC90
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 18:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbjA0Rfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 12:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjA0Rfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 12:35:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37AB7C700;
        Fri, 27 Jan 2023 09:35:49 -0800 (PST)
Date:   Fri, 27 Jan 2023 17:35:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674840947;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=hDCVHcgK+5QGw3h4UBTActHtpbx6bnknI7Ks7TAo3Vo=;
        b=fKEsIHJXHjDUvuIAv0mQerG9U1D6vyc/omJ+p6hLpNwU+kbp302Y9DAr0BCfZ9O6eGcOFL
        RA0WF8mqt5EmBAJoO4S9UbuoTdueFO3y+gOjAji4WpTwNu5CY7PLQ5PlLpq4BRhrNZSA99
        TfUhqrovp3mYX/Tmv10AMpJZXeBgVWkvMQpQ24U9RGczD4gNnzCXxyGNrHeApxVP79F4zm
        IHB+w52uSHD49CeHilB3NlzSZ2YD5hOXmZo9pjNLxmYHqN3RhX8Ur5ZmFsNepQLTjtC82t
        wIXKOyIj9t45sijHwMzj0dzbdaKvh+dSs2gAB/WTOxoGrjThUpUfcX0ouuWWPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674840947;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=hDCVHcgK+5QGw3h4UBTActHtpbx6bnknI7Ks7TAo3Vo=;
        b=nLzW51Q9QhCzPYVN7OmuzGC8D0SG+ZnwNTwWB6FeHcdOw9dhmoQmy2ofQPLCVPZweddOHb
        c7ldt6dG2cp9aDCQ==
From:   "tip-bot2 for Alexander Potapenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86: Suppress KMSAN reports in arch_within_stack_frames()
Cc:     Alexander Potapenko <glider@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eric Biggers <ebiggers@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167484094672.4906.1078127795504041641.tip-bot2@tip-bot2>
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

Commit-ID:     ce3ba2af9695e4bd64d797e0026321e5dca29dd3
Gitweb:        https://git.kernel.org/tip/ce3ba2af9695e4bd64d797e0026321e5dca29dd3
Author:        Alexander Potapenko <glider@google.com>
AuthorDate:    Fri, 18 Nov 2022 18:23:05 +01:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 27 Jan 2023 09:00:56 -08:00

x86: Suppress KMSAN reports in arch_within_stack_frames()

arch_within_stack_frames() performs stack walking and may confuse
KMSAN by stepping on stale shadow values. To prevent false positive
reports, disable KMSAN checks in this function.

This fixes KMSAN's interoperability with CONFIG_HARDENED_USERCOPY.

Signed-off-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Eric Biggers <ebiggers@google.com>
Link: https://github.com/google/kmsan/issues/89
Link: https://lore.kernel.org/lkml/Y3b9AAEKp2Vr3e6O@sol.localdomain/
Link: https://lore.kernel.org/all/20221118172305.3321253-1-glider%40google.com
---
 arch/x86/include/asm/thread_info.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index f0cb881..f1cccba 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -163,7 +163,12 @@ struct thread_info {
  *	GOOD_FRAME	if within a frame
  *	BAD_STACK	if placed across a frame boundary (or outside stack)
  *	NOT_STACK	unable to determine (no frame pointers, etc)
+ *
+ * This function reads pointers from the stack and dereferences them. The
+ * pointers may not have their KMSAN shadow set up properly, which may result
+ * in false positive reports. Disable instrumentation to avoid those.
  */
+__no_kmsan_checks
 static inline int arch_within_stack_frames(const void * const stack,
 					   const void * const stackend,
 					   const void *obj, unsigned long len)
