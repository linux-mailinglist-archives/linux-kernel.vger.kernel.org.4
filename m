Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FF4678930
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 22:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbjAWVHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 16:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjAWVHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 16:07:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD7130EA2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 13:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=/FCuGsFHP8h1o3jLXAdPuiCn2YaK3Z2EA/HYKgflCd4=; b=Scw69z188z5U9ca/nvjFeycnxn
        Hcm1XgNaqDzaknTjChLGgjnv3eKib+iPl2n0cr3/x7H0ei94DMih94kJszIWT6DVLQM1mUuDNqsht
        IiVu+aUpTq0bm0ECXDJP1xrA6WPsSOmNBdUO/2uFs5igmY30u5ZqsIUACWcqUA4hcdo8maTZ81fBy
        VJfw072fSYjreryNDwR5YGJrQ/AgABViMyoOQFaa/rN+rh6WsZBJC5YsPk+9o0ck2eLJSqRn00uqN
        fkseM+RBUP49gaIjd65pKjL69MawmYvrPMqrbLbeLJvzfPycSveR1VYi/w0i7tlDDizg16MLxZPpq
        F5cwNM7w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pK41f-004Wrb-BM; Mon, 23 Jan 2023 21:06:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5FE3E3002BF;
        Mon, 23 Jan 2023 22:06:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 25A57201DD9B0; Mon, 23 Jan 2023 22:06:45 +0100 (CET)
Message-ID: <20230123205915.751729592@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 23 Jan 2023 21:59:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, peterz@infradead.org,
        jpoimboe@kernel.org, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, linux-kernel@vger.kernel.org,
        erhard_f@mailbox.org, ndesaulniers@google.com, mhiramat@kernel.org,
        sandipan.das@amd.com
Subject: [PATCH 0/3] static_call/x86: Handle clang's conditional tail calls
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Erhard reported boot fails on this AMD machine when using clang and bisected it
to a commit introducing a few static_call()s. Turns out that when using clang
with -Os it it very likely to generate conditional tail calls like:

  0000000000000350 <amd_pmu_add_event>:
  350:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1) 351: R_X86_64_NONE      __fentry__-0x4
  355:       48 83 bf 20 01 00 00 00         cmpq   $0x0,0x120(%rdi)
  35d:       0f 85 00 00 00 00       jne    363 <amd_pmu_add_event+0x13>     35f: R_X86_64_PLT32     __SCT__amd_pmu_branch_add-0x4
  363:       e9 00 00 00 00          jmp    368 <amd_pmu_add_event+0x18>     364: R_X86_64_PLT32     __x86_return_thunk-0x4

And our inline static_call() patching code can't deal with those and BUG
happens -- really early.

These patches borrow the kprobe Jcc emulation to implement text_poke_bp() Jcc
support, which is then used to teach inline static_call() about this form.

---
 arch/x86/include/asm/text-patching.h | 31 ++++++++++++++++++
 arch/x86/kernel/alternative.c        | 62 +++++++++++++++++++++++++++---------
 arch/x86/kernel/kprobes/core.c       | 38 +++++-----------------
 arch/x86/kernel/static_call.c        | 50 +++++++++++++++++++++++++++--
 4 files changed, 133 insertions(+), 48 deletions(-)

