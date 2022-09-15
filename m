Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BFA5B99DB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiIOLln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiIOLkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:40:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D538052FD7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=i/KYE4ASCs+l+r/1pSA03LLegKU4fUGJ4neS2scNk+A=; b=eKx1LeEjMOCouYzFcRQmeSfBeJ
        5q7d1ZWtx1WcujYmqpyORJnZoXzuJO/4m48BkhIKqrvQsIzuoiq3KwVKKwhG5POwXDEABB4ZzSEjS
        lhlpkWPjk995hnXXsbGn1UCTqRgTqzgTZBdfe/gLXDLqChBmgTfcMhELLfg6LJ5AwSTgAi3TLSLwq
        uKsmL7EyfnpuiT3dudgeq0IIv6Ik9trf5iygJMn95Pgfn8uDHkEncbawnIhchdqLbZZJYyPBIcB3X
        NyPfnPs9MvxXHrlIHomD9vlCs2grxFkJozR7vQ7YQ0IJysnZuM0ui4BPD1bO7GZHEhgdHBZsMf539
        HhQLa/QA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYnDc-0012N5-D3; Thu, 15 Sep 2022 11:39:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D33E0302218;
        Thu, 15 Sep 2022 13:39:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 448F729AADBFB; Thu, 15 Sep 2022 13:39:39 +0200 (CEST)
Message-ID: <20220915111144.766564176@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Sep 2022 13:10:57 +0200
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
Subject: [PATCH v3 18/59] crypto: x86/sha256: Remove custom alignments
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

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/crypto/sha256-avx-asm.S   |    1 -
 arch/x86/crypto/sha256-avx2-asm.S  |    1 -
 arch/x86/crypto/sha256-ssse3-asm.S |    1 -
 arch/x86/crypto/sha256_ni_asm.S    |    1 -
 4 files changed, 4 deletions(-)

--- a/arch/x86/crypto/sha256-avx-asm.S
+++ b/arch/x86/crypto/sha256-avx-asm.S
@@ -347,7 +347,6 @@ a = TMP_
 ########################################################################
 .text
 SYM_FUNC_START(sha256_transform_avx)
-.align 32
 	pushq   %rbx
 	pushq   %r12
 	pushq   %r13
--- a/arch/x86/crypto/sha256-avx2-asm.S
+++ b/arch/x86/crypto/sha256-avx2-asm.S
@@ -524,7 +524,6 @@ STACK_SIZE	= _CTX      + _CTX_SIZE
 ########################################################################
 .text
 SYM_FUNC_START(sha256_transform_rorx)
-.align 32
 	pushq	%rbx
 	pushq	%r12
 	pushq	%r13
--- a/arch/x86/crypto/sha256-ssse3-asm.S
+++ b/arch/x86/crypto/sha256-ssse3-asm.S
@@ -356,7 +356,6 @@ a = TMP_
 ########################################################################
 .text
 SYM_FUNC_START(sha256_transform_ssse3)
-.align 32
 	pushq   %rbx
 	pushq   %r12
 	pushq   %r13
--- a/arch/x86/crypto/sha256_ni_asm.S
+++ b/arch/x86/crypto/sha256_ni_asm.S
@@ -96,7 +96,6 @@
  */
 
 .text
-.align 32
 SYM_FUNC_START(sha256_ni_transform)
 
 	shl		$6, NUM_BLKS		/*  convert to bytes */


