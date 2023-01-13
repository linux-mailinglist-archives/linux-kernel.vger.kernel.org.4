Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5775D669807
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbjAMNHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjAMNGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:06:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175F477D0C;
        Fri, 13 Jan 2023 04:53:53 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:53:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673614431;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=uo4Pn34x3mARkiqqYbo0hcHiXCD+oJvRBLIoK4xAgHk=;
        b=rBevJTUPS7iy3wUmslENJSCuD3oHuKLmnPDbHfoME+hRNRiKa+AZYhQDNVZs/HtRJlyqpR
        ciSNjYkcLzmRY7r8K270moGNkw6augD/Pqgk7vpd6vhKunXg4lqgJPRFxXbcH067E9EZr4
        oABlox9fJ7XYAWK+yjZXa29lf/5Sd/b55EO6dTkrTZlqO7znsuD50oG3TUXr8cCZqwnjjv
        3Y6I+aVF2dpDiEJn/+x/V66gmgnm+XNCY4zhBCVEUF7bcIpcJ5XLx2BfMDQpZt0osue1Bm
        clgNog8A1+X5wd9vrOEAnVRDLcmoxjOQrQxOAitjsCuNSWLsv8aakAkEVfBmZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673614431;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=uo4Pn34x3mARkiqqYbo0hcHiXCD+oJvRBLIoK4xAgHk=;
        b=n3aNAPVHEm/Ogb1Le9xEcHRdK28QzTTsHodedYe3h46mXZQKjRBKshUBZUU0b44esEgMet
        rPQgNsIAskPkCcBA==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/gsseg: Add the new <asm/gsseg.h> header to
 <asm/asm-prototypes.h>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org
MIME-Version: 1.0
Message-ID: <167361443119.4906.4984894590925431359.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     e12ad468c22065a2826b2fc4c11d2113a7975301
Gitweb:        https://git.kernel.org/tip/e12ad468c22065a2826b2fc4c11d2113a7975301
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 13 Jan 2023 13:43:20 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 13:43:20 +01:00

x86/gsseg: Add the new <asm/gsseg.h> header to <asm/asm-prototypes.h>

Module build needs to be able to pick up the C prototype:

  WARNING: modpost: EXPORT symbol "asm_load_gs_index" [vmlinux] version generation failed, symbol will not be versioned.
  Is "asm_load_gs_index" prototyped in <asm/asm-prototypes.h>?

Fixes: ae53fa187030 ("x86/gsseg: Move load_gs_index() to its own new header file")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/asm-prototypes.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index 8f80de6..b1a98fa 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -12,6 +12,7 @@
 #include <asm/special_insns.h>
 #include <asm/preempt.h>
 #include <asm/asm.h>
+#include <asm/gsseg.h>
 
 #ifndef CONFIG_X86_CMPXCHG64
 extern void cmpxchg8b_emu(void);
