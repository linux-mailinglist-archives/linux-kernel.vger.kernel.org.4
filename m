Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC7266E66E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 19:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbjAQSuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 13:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbjAQSsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 13:48:39 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8FE4DCC6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kjzPtu3zrCJ7LGN8rTmaJPE6Mz4bv33wdR1lSV8x46Y=; b=FpCwn17IJKT76tn1oBj68F9qvT
        OjxGi/x1in4z37b9B+lVy0CNficyOfMmlE9g1rYdRRG1lTlmSEguXX5yxat4nL9STqETp6AJ6F69/
        a/6HCtP2NNfgcV86cPQ4fijJtySW/24ehKr9nhK4DHtOFKw4+utyw5DWfkUvhNUUVENjufX119qHC
        JsHbdataE92XKLCPH2/FlxWYMURhOVS8ZzUb98kN+5H+P1z2JVNl5YTUwWKaZ02HJsZFkq9XvQMG0
        kMDkLFN3j1excScPTSTM603ZRkLG3wZ7n/XRPRhWAiRkfsm0L1AMi3lrAHYzqnfV0DEmv6YEXwWdE
        FaB4n93w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pHqU0-0060fj-1T;
        Tue, 17 Jan 2023 18:14:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AEFD93002BF;
        Tue, 17 Jan 2023 19:14:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9A12D202203E9; Tue, 17 Jan 2023 19:14:59 +0100 (CET)
Date:   Tue, 17 Jan 2023 19:14:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        ndesaulniers@google.com, joao@overdrivepizza.com
Subject: Re: [PATCHv14 08/17] x86/mm: Reduce untagged_addr() overhead until
 the first LAM user
Message-ID: <Y8blowOi0AfbdUbF@hirez.programming.kicks-ass.net>
References: <20230111123736.20025-1-kirill.shutemov@linux.intel.com>
 <20230111123736.20025-9-kirill.shutemov@linux.intel.com>
 <Y8adEg2CYUSVpwtk@hirez.programming.kicks-ass.net>
 <20230117135703.voaumisreld7crfb@box>
 <Y8a4bmCU9wsenvvF@hirez.programming.kicks-ass.net>
 <CAHk-=wiwiA7FdSww9fTg59r5S7G-DZHtzAcq9u5zBJKYXc1agQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiwiA7FdSww9fTg59r5S7G-DZHtzAcq9u5zBJKYXc1agQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 09:18:01AM -0800, Linus Torvalds wrote:

> The reason clang seems to generate saner code is that clang seems to
> largely ignore the whole "__builtin_expect()", at least not to the
> point where it tries to make the unlikely case be out-of-line.

So in this case there is only a 'likely' hint, we're explicitly trying
to keep the thing in-line so we can jump over it.

It is GCC that generated an implicit else (and marked it 'unlikely' --
which we didn't ask for), but worse, it failed to spot the else case is
in fact shared with the normal case and it could've simply lifted that
mov instruction.

That is, instead of this:

0003     23b3:  eb 76                   jmp    242b <write_ok_or_segv+0x7b>
0005     23b5:  65 48 8b 0d 00 00 00 00         mov    %gs:0x0(%rip),%rcx        # 23bd <write_ok_or_segv+0xd>  23b9: R_X86_64_PC32     tlbstate_untag_mask-0x4
000d     23bd:  48 89 f8                mov    %rdi,%rax
0010     23c0:  48 c1 f8 3f             sar    $0x3f,%rax
0014     23c4:  48 09 c8                or     %rcx,%rax
0017     23c7:  48 21 f8                and    %rdi,%rax

001a     23ca:  48 b9 00 f0 ff ff ff 7f 00 00   movabs $0x7ffffffff000,%rcx

007b     242b:  48 89 f8                mov    %rdi,%rax
007e     242e:  eb 9a                   jmp    23ca <write_ok_or_segv+0x1a>

It could've just done:

0003     48 89 f8                mov    %rdi,%rax
0006     eb 76                   jmp    +18
0008     65 48 8b 0d 00 00 00 00         mov    %gs:0x0(%rip),%rcx        # 23bd <write_ok_or_segv+0xd>  23b9: R_X86_64_PC32     tlbstate_untag_mask-0x4
0010     48 c1 f8 3f             sar    $0x3f,%rax
0014     48 09 c8                or     %rcx,%rax
0017     48 21 f8                and    %rdi,%rax

001a     48 b9 00 f0 ff ff ff 7f 00 00   movabs $0x7ffffffff000,%rcx

and everything would've been good. In all the cases I've seen it do
this, it was the same, it has this silly move out of line that's also
part of the regular branch.

That is, I like __builtin_expect() to be a strong hint. If I don't want
things out of line, I shouldn't have put unlikely on it. What I don't
like is that implicit else branches get the opposite strong hint.

What I like even less is that it found it needed that else branch at
all.
