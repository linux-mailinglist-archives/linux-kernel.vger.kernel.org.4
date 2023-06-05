Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D7B722F8E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbjFETQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbjFETQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:16:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A87F3;
        Mon,  5 Jun 2023 12:16:21 -0700 (PDT)
Date:   Mon, 05 Jun 2023 19:16:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685992579;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hCTYfnfFpap/ITRxHBpO+C77CiSgkQTh0GUA+Fz24sg=;
        b=BKbW3HxMh1s40DOkQzwd6T71jPjAFzZ1ycnM2AxSFULfLdqQb4tEKZtfVWNDKpG4v5conq
        1YSpENPks1v53GFOJPhVrKzq981MtD6Qyzf9Ey2o+nkuSyxlXh5XYq61wehF6Lb6zLtAaP
        rvLm+qCeASthh9VnAkBHNblEg9Aq2gJ22GCr1Cdjm4lx/aJGdnodwyhhg1XDPF0cfS7BSn
        kXUOUwItvp2oWpiXkGKEsiV/vffsA/uw6QXRUlU/oh678zdDWUQNlqmJkvis3W630Oi387
        PKSmM1ewRAPhnip85fJm1hOhpXS73e2OkVSzg1X1IJwVV83yZDmv/ruLCxCdcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685992579;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hCTYfnfFpap/ITRxHBpO+C77CiSgkQTh0GUA+Fz24sg=;
        b=u+MkFapRkIK4OfDdCNQ7g5/a2nabdid3QFahJVRqAWT1TmcaN5unLXJhAj2VyvHgEGi8ID
        AxVzU+sC08LrpcAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] arm64/io: Always inline all of __raw_{read,write}[bwlq]()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230519102715.368919762@infradead.org>
References: <20230519102715.368919762@infradead.org>
MIME-Version: 1.0
Message-ID: <168599257910.404.12784163711469772427.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c1d26c0f0295953d35307f9ee07f3e5295741315
Gitweb:        https://git.kernel.org/tip/c1d26c0f0295953d35307f9ee07f3e5295741315
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 19 May 2023 12:21:01 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 21:11:04 +02:00

arm64/io: Always inline all of __raw_{read,write}[bwlq]()

The next patch will want to use __raw_readl() from a noinstr section
and as such that needs to be marked __always_inline to avoid the
compiler being a silly bugger.

Turns out it already is, but its siblings are not. Finish the work
started in commit e43f1331e2ef913b ("arm64: Ask the compiler to
__always_inline functions used by KVM at HYP") for consistenies sake.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>  # Hyper-V
Link: https://lore.kernel.org/r/20230519102715.368919762@infradead.org
---
 arch/arm64/include/asm/io.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 877495a..51d92ab 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -22,13 +22,13 @@
  * Generic IO read/write.  These perform native-endian accesses.
  */
 #define __raw_writeb __raw_writeb
-static inline void __raw_writeb(u8 val, volatile void __iomem *addr)
+static __always_inline void __raw_writeb(u8 val, volatile void __iomem *addr)
 {
 	asm volatile("strb %w0, [%1]" : : "rZ" (val), "r" (addr));
 }
 
 #define __raw_writew __raw_writew
-static inline void __raw_writew(u16 val, volatile void __iomem *addr)
+static __always_inline void __raw_writew(u16 val, volatile void __iomem *addr)
 {
 	asm volatile("strh %w0, [%1]" : : "rZ" (val), "r" (addr));
 }
@@ -40,13 +40,13 @@ static __always_inline void __raw_writel(u32 val, volatile void __iomem *addr)
 }
 
 #define __raw_writeq __raw_writeq
-static inline void __raw_writeq(u64 val, volatile void __iomem *addr)
+static __always_inline void __raw_writeq(u64 val, volatile void __iomem *addr)
 {
 	asm volatile("str %x0, [%1]" : : "rZ" (val), "r" (addr));
 }
 
 #define __raw_readb __raw_readb
-static inline u8 __raw_readb(const volatile void __iomem *addr)
+static __always_inline u8 __raw_readb(const volatile void __iomem *addr)
 {
 	u8 val;
 	asm volatile(ALTERNATIVE("ldrb %w0, [%1]",
@@ -57,7 +57,7 @@ static inline u8 __raw_readb(const volatile void __iomem *addr)
 }
 
 #define __raw_readw __raw_readw
-static inline u16 __raw_readw(const volatile void __iomem *addr)
+static __always_inline u16 __raw_readw(const volatile void __iomem *addr)
 {
 	u16 val;
 
@@ -80,7 +80,7 @@ static __always_inline u32 __raw_readl(const volatile void __iomem *addr)
 }
 
 #define __raw_readq __raw_readq
-static inline u64 __raw_readq(const volatile void __iomem *addr)
+static __always_inline u64 __raw_readq(const volatile void __iomem *addr)
 {
 	u64 val;
 	asm volatile(ALTERNATIVE("ldr %0, [%1]",
