Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC1B6798E8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 14:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbjAXNHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 08:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbjAXNHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:07:15 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D52E2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 05:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=waxhbtfVtiprsRJ7oPC5wJuyHCFIEtZCYal4eJtNYx8=; b=AZBM0bdIsmr/Jkbqr43ewnJ4e0
        D9xAp+S4mb0qE1RgQp4TH5ykS/rAzKCr5KWA5cRF2XfC8Bj52qhqE7SmQwRTfGx9DSGxBTKGHJsUE
        rrOC/LQ8Aujlc23aIKBxJ6Mv5xk2UAEe6Nfmmn4xsQKeiGjyArOwbWoraknh0Vns7K5wQHVVOsa44
        hSWuhDU1kDSDtz/dbOMthP6l9EPAICG2vPUpqdZMy2K6DmGqIvC8nHprHu6yDUTJdxj9v8NNLKseQ
        Hm8lMbdLw2vN7ijGsFxa9Zr0yyw8Ifq5ksb+sLaN5ZR5CX8kldaIJ1k2+JYjgr7gL8CZMPckffGxI
        PZ2fGm5A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pKJ0J-001qrs-23;
        Tue, 24 Jan 2023 13:06:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CAA7D3002BF;
        Tue, 24 Jan 2023 14:06:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 907F22C19A9D3; Tue, 24 Jan 2023 14:06:49 +0100 (CET)
Date:   Tue, 24 Jan 2023 14:06:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        jpoimboe@kernel.org, jbaron@akamai.com, ardb@kernel.org,
        linux-kernel@vger.kernel.org, erhard_f@mailbox.org,
        ndesaulniers@google.com, mhiramat@kernel.org, sandipan.das@amd.com
Subject: Re: [PATCH 3/3] x86/static_call: Add support for Jcc tail-calls
Message-ID: <Y8/X6fdRT80jssIf@hirez.programming.kicks-ass.net>
References: <20230123205915.751729592@infradead.org>
 <20230123210607.173715335@infradead.org>
 <20230123174431.4421dfdf@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123174431.4421dfdf@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 05:44:31PM -0500, Steven Rostedt wrote:
> On Mon, 23 Jan 2023 21:59:18 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Clang likes to create conditional tail calls like:
> > 
> > 0000000000000350 <amd_pmu_add_event>:
> > 350:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1) 351: R_X86_64_NONE      __fentry__-0x4
> > 355:       48 83 bf 20 01 00 00 00         cmpq   $0x0,0x120(%rdi)
> > 35d:       0f 85 00 00 00 00       jne    363 <amd_pmu_add_event+0x13>     35f: R_X86_64_PLT32     __SCT__amd_pmu_branch_add-0x4
> > 363:       e9 00 00 00 00          jmp    368 <amd_pmu_add_event+0x18>     364: R_X86_64_PLT32     __x86_return_thunk-0x4
> > 
> 
> Just to confirm, as it's not clear if this is the static call site or one
> of the functions that is being called.

Ah, you've not looked at enough asm then? ;-) Yes this is the static
call site, see the __SCT_ target (instruction at 0x35d).

> I'm guessing that this is an issue because clang optimizes the static call
> site, right?

Specifically using Jcc (jne in this case) to tail-call the trampoline.

> > Teach the in-line static call text patching about this.
> > 
> > Notably, since there is no conditional-ret, in that caes patch the Jcc
> 
> 					      "in that case"

typing so hard.. :-)
