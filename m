Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA0868F8E5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 21:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjBHUgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 15:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjBHUgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 15:36:49 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD363A87
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 12:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UhCqbjmutMOLc4n9BwNPODO+rcSew/EeSwGbEuxV5kw=; b=VyJ628LlxNwd4ah3kHSCaoFM4y
        0GfNWleeoWxUP7niEtvMuEz5mjvOscJA5c6DMfnNaLS/JXKwwQMIFjh858u9HUMta79XTIPVo3qLj
        fzwxaYnW3yruKGqJIk+HfDTQVofLOK+nGzk2SiNjVAnvz4CfiWoPH8a/cBV441kdgmF8n40TrDMx4
        PXi7gv2tdyAA+/tT47TUEfrIGuX67stM3hnDAyvLKNuNdEUNsQEj3tE0Qz2moPACRS7HYmRC+qiWz
        YLJaOLiaoveYWtHHosCl/79IiqUFMEC4lhsfoj89kv50WUtCbtVQyI5/T/UFWzIlI3yIUVGeOzPjq
        j580eYrA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pPrAP-007aAH-2f;
        Wed, 08 Feb 2023 20:35:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 54AAE300129;
        Wed,  8 Feb 2023 21:36:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 351E020321D61; Wed,  8 Feb 2023 21:36:24 +0100 (CET)
Date:   Wed, 8 Feb 2023 21:36:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew.Cooper3@citrix.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        kirill.shutemov@linux.intel.com, jpoimboe@redhat.com
Subject: Re: [PATCH v3 3/4] x86/alternative: Rewrite optimize_nops() some
Message-ID: <Y+QHyF5K5hSN0ziP@hirez.programming.kicks-ass.net>
References: <20230208171050.490809180@infradead.org>
 <20230208171431.373412974@infradead.org>
 <f0b54521-26cf-ed38-d805-3a8eef3b3103@citrix.com>
 <Y+QGIiOupDKxlKKR@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+QGIiOupDKxlKKR@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 09:29:23PM +0100, Peter Zijlstra wrote:

> As is, there were only a hand full of NOPs that turned into this jmp.d8
> thing on the defconfig+kvm_guest.config I build to test this -- it is by
> no means a common thing. And about half of them would be gone by
> extending the max nop length to at least 10 or so.
> 
> In fact, I did that patch once, lemme see if I still have it...

Even still applies too, lemme go test that.

Also, there's a bunch of alternatives() where we explicitly put in that
short jmp instead of taking the nops, see for example:

  $ git grep -i "alternative.*jmp" arch/x86/

---
Subject: x86_64: Longer NOPs
From: Peter Zijlstra <peterz@infradead.org>


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/nops.h   |   13 +++++++++++--
 arch/x86/kernel/alternative.c |    8 ++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/nops.h
+++ b/arch/x86/include/asm/nops.h
@@ -34,6 +34,8 @@
 #define BYTES_NOP7	0x8d,0xb4,0x26,0x00,0x00,0x00,0x00
 #define BYTES_NOP8	0x3e,BYTES_NOP7
 
+#define ASM_NOP_MAX 8
+
 #else
 
 /*
@@ -47,6 +49,8 @@
  * 6: osp nopl 0x00(%eax,%eax,1)
  * 7: nopl 0x00000000(%eax)
  * 8: nopl 0x00000000(%eax,%eax,1)
+ * 9: cs nopl 0x00000000(%eax,%eax,1)
+ * 10: osp cs nopl 0x00000000(%eax,%eax,1)
  */
 #define BYTES_NOP1	0x90
 #define BYTES_NOP2	0x66,BYTES_NOP1
@@ -56,6 +60,13 @@
 #define BYTES_NOP6	0x66,BYTES_NOP5
 #define BYTES_NOP7	0x0f,0x1f,0x80,0x00,0x00,0x00,0x00
 #define BYTES_NOP8	0x0f,0x1f,0x84,0x00,0x00,0x00,0x00,0x00
+#define BYTES_NOP9	0x2e,BYTES_NOP8
+#define BYTES_NOP10	0x66,BYTES_NOP9
+
+#define ASM_NOP9  _ASM_BYTES(BYTES_NOP9)
+#define ASM_NOP10 _ASM_BYTES(BYTES_NOP10)
+
+#define ASM_NOP_MAX 10
 
 #endif /* CONFIG_64BIT */
 
@@ -68,8 +79,6 @@
 #define ASM_NOP7 _ASM_BYTES(BYTES_NOP7)
 #define ASM_NOP8 _ASM_BYTES(BYTES_NOP8)
 
-#define ASM_NOP_MAX 8
-
 #ifndef __ASSEMBLY__
 extern const unsigned char * const x86_nops[];
 #endif
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -86,6 +86,10 @@ static const unsigned char x86nops[] =
 	BYTES_NOP6,
 	BYTES_NOP7,
 	BYTES_NOP8,
+#ifdef CONFIG_64BIT
+	BYTES_NOP9,
+	BYTES_NOP10,
+#endif
 };
 
 const unsigned char * const x86_nops[ASM_NOP_MAX+1] =
@@ -99,6 +103,10 @@ const unsigned char * const x86_nops[ASM
 	x86nops + 1 + 2 + 3 + 4 + 5,
 	x86nops + 1 + 2 + 3 + 4 + 5 + 6,
 	x86nops + 1 + 2 + 3 + 4 + 5 + 6 + 7,
+#ifdef CONFIG_64BIT
+	x86nops + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8,
+	x86nops + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8 + 9,
+#endif
 };
 
 /* Use this to add nops to a buffer, then text_poke the whole buffer. */
