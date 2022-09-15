Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125FE5B99C5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiIOLkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIOLkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:40:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2FC31DEF
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=BJHqXamgAJqTcT2FFMKxQyrqmVcujF7M2+0CHXkEhUI=; b=W1b/8dE8UWoAn/AYQdcR3yl05T
        h/647vG5bqynMSGInS1aU7GoGZeEaiU+Xtwm8NYT/nVRcrZrJIcItKX8x6SP45W0mygOAF1H0iorj
        B0L5T6qo84/CxIrySSeEk27l08Rwt94+z5EiOLR3wGjlukBoEoTPxpm+vP72t+CVYdTCr3A94VfQ8
        iWFyQ0sZCRFRqAWWrcDVqbHujvzNc3g8Kammuszh7pOgOoHjbW+Pvq2mHoPyao1ZX7qMuvX3fMKx0
        QUxS6zf6l+Vzoo9d+Y/Z1g+h9mKoKwahBwiegqRirOEMPShkSKP4/sc9Oismv8N9PUicok0GSdRhh
        oLx1uFvw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYnDb-0012N0-PY; Thu, 15 Sep 2022 11:39:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CBBEF301D53;
        Thu, 15 Sep 2022 13:39:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 26AA329AADBF2; Thu, 15 Sep 2022 13:39:39 +0200 (CEST)
Message-ID: <20220915111144.248229966@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Sep 2022 13:10:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH v3 13/59] crypto: x86/camellia: Remove redundant alignments
References: <20220915111039.092790446@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

SYM_FUNC_START*() and friends already imply alignment, remove custom
alignment hacks to make code consistent. This prepares for future
function call ABI changes.

Also, with having pushed the function alignment to 16 bytes, this
custom alignment is completely superfluous.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/crypto/camellia-aesni-avx-asm_64.S  |    2 --
 arch/x86/crypto/camellia-aesni-avx2-asm_64.S |    4 ----
 2 files changed, 6 deletions(-)

--- a/arch/x86/crypto/camellia-aesni-avx-asm_64.S
+++ b/arch/x86/crypto/camellia-aesni-avx-asm_64.S
@@ -712,7 +712,6 @@ SYM_FUNC_END(roundsm16_x4_x5_x6_x7_x0_x1
 
 .text
 
-.align 8
 SYM_FUNC_START_LOCAL(__camellia_enc_blk16)
 	/* input:
 	 *	%rdi: ctx, CTX
@@ -799,7 +798,6 @@ SYM_FUNC_START_LOCAL(__camellia_enc_blk1
 	jmp .Lenc_done;
 SYM_FUNC_END(__camellia_enc_blk16)
 
-.align 8
 SYM_FUNC_START_LOCAL(__camellia_dec_blk16)
 	/* input:
 	 *	%rdi: ctx, CTX
--- a/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
+++ b/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
@@ -221,7 +221,6 @@
  * Size optimization... with inlined roundsm32 binary would be over 5 times
  * larger and would only marginally faster.
  */
-.align 8
 SYM_FUNC_START_LOCAL(roundsm32_x0_x1_x2_x3_x4_x5_x6_x7_y0_y1_y2_y3_y4_y5_y6_y7_cd)
 	roundsm32(%ymm0, %ymm1, %ymm2, %ymm3, %ymm4, %ymm5, %ymm6, %ymm7,
 		  %ymm8, %ymm9, %ymm10, %ymm11, %ymm12, %ymm13, %ymm14, %ymm15,
@@ -229,7 +228,6 @@ SYM_FUNC_START_LOCAL(roundsm32_x0_x1_x2_
 	RET;
 SYM_FUNC_END(roundsm32_x0_x1_x2_x3_x4_x5_x6_x7_y0_y1_y2_y3_y4_y5_y6_y7_cd)
 
-.align 8
 SYM_FUNC_START_LOCAL(roundsm32_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 	roundsm32(%ymm4, %ymm5, %ymm6, %ymm7, %ymm0, %ymm1, %ymm2, %ymm3,
 		  %ymm12, %ymm13, %ymm14, %ymm15, %ymm8, %ymm9, %ymm10, %ymm11,
@@ -748,7 +746,6 @@ SYM_FUNC_END(roundsm32_x4_x5_x6_x7_x0_x1
 
 .text
 
-.align 8
 SYM_FUNC_START_LOCAL(__camellia_enc_blk32)
 	/* input:
 	 *	%rdi: ctx, CTX
@@ -835,7 +832,6 @@ SYM_FUNC_START_LOCAL(__camellia_enc_blk3
 	jmp .Lenc_done;
 SYM_FUNC_END(__camellia_enc_blk32)
 
-.align 8
 SYM_FUNC_START_LOCAL(__camellia_dec_blk32)
 	/* input:
 	 *	%rdi: ctx, CTX


