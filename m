Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418746C5778
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 21:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjCVU01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 16:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjCVU0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 16:26:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5D75AB74;
        Wed, 22 Mar 2023 13:16:14 -0700 (PDT)
Date:   Wed, 22 Mar 2023 20:14:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679516094;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=TErJKltRRstNh1nsERKmjUwCIWoOFhKcp8MuDg4CLfI=;
        b=Kgg7TCMUj05ZnWczCzjkfiokximoI9V8+46Lx+ASSnZpAUZq9A+VYpdqdpXgoiNEPQ7qH1
        MuLnzq1f6h3K1zwRME3tQOoEUY9gY4hImGylCbpQWBPB3fXAc81I80UbkyjJzymOUTo7jo
        gjYrl4raU0JUEfOIbOxNStjEP274vAUrJOGhDDWGrlGKuR3ciL+Ne+zrBTl3N5lAnoetpC
        s2gsN8KzbwX+YnFCICmFbhivlPm7ivBhpUpp96Tqd067HP0xPSwv4edK6EW/+aB02rasbi
        sDIwJpCubWB59HtDBFjZvgkzu62qTXFbNQKn+7gQ2ZZb8UfYF6IPTPvygo1s3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679516094;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=TErJKltRRstNh1nsERKmjUwCIWoOFhKcp8MuDg4CLfI=;
        b=BR3Se9awzv0EntM16dQ5Q4RMpZiUowgzlacasZwrm0AGCYznWJlgkwtXu+asjjIIdb0/cY
        iKTN+dh2nGXz2KDg==
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/arch_prctl: Add AMX feature numbers as ABI constants
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167951609395.5837.17233221474519558802.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     a03c376ebaf38394a63a75292329f38a47520c2c
Gitweb:        https://git.kernel.org/tip/a03c376ebaf38394a63a75292329f38a47520c2c
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Fri, 20 Jan 2023 16:18:58 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 22 Mar 2023 13:02:33 -07:00

x86/arch_prctl: Add AMX feature numbers as ABI constants

Each distinct XSAVE feature has a number assigned to it.  Among other
things, the number determines the ordering of features in the XSAVE
buffer and is also used to generate XSAVE bitmasks like the value
for XCR0.

AMX state is dynamically enabled by the architecture-specific prctl().
This prctl() takes one XSAVE feature number as an argument.  However, the
feature numbers are not defined in any readily available userspace headers.
The means that each userspace app trying to use dynamic feature prctl()s
will likely end up defining their own constants for each feature.

Since these feature numbers are a part of the uabi, expose them in the
prctl() uabi header.  Save everyone the trouble of looking them up and
defining their own.

[ dhansen: expand changelog a bit ]

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/all/20230121001900.14900-3-chang.seok.bae%40intel.com
---
 arch/x86/include/uapi/asm/prctl.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 500b96e..f298c77 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -16,6 +16,9 @@
 #define ARCH_GET_XCOMP_GUEST_PERM	0x1024
 #define ARCH_REQ_XCOMP_GUEST_PERM	0x1025
 
+#define ARCH_XCOMP_TILECFG		17
+#define ARCH_XCOMP_TILEDATA		18
+
 #define ARCH_MAP_VDSO_X32		0x2001
 #define ARCH_MAP_VDSO_32		0x2002
 #define ARCH_MAP_VDSO_64		0x2003
