Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC2466E194
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjAQPEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjAQPCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:02:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC531402DB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 07:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7mcvbJBSR6u09x7A6qVwIIU9taGlku+5WOymJeSEZwk=; b=Gv3i9AbRIJBg3eFPdyeLQDp5/S
        oVHwiq33nOrCpSS9rGbhxXSuKjKcA9FjiTmrpkl19v0GU3sB10oKC9ZLJ4sT6U8rhpTlVBWyv0U+o
        vbYILwFMjUybHxm/CvBkuz+tONRGhX7BFrCELsn3ZsxTj4y6zA8IRpJ6GgSZXHqGABamH6xamJ7h1
        2IFad2LNxBkKU771V8krXmPXSBF1UMcluuHquFANqOruYjXfs6qpQ59A2UP00an6JtjeKCc19XGga
        8yglf1JR6S8WgK7K3YoNYTjrOXbjlIs5Zb+M5bofQ+JRZr9VLV5y4HljOaAArETsEKST8beYrQDGo
        9yYQ5jLg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHnTi-009lfG-QP; Tue, 17 Jan 2023 15:02:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E90F1300137;
        Tue, 17 Jan 2023 16:02:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C51FB20B2BF0D; Tue, 17 Jan 2023 16:02:06 +0100 (CET)
Date:   Tue, 17 Jan 2023 16:02:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
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
        Ashok Raj <ashok.raj@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        ndesaulniers@google.com, joao@overdrivepizza.com
Subject: Re: [PATCHv14 08/17] x86/mm: Reduce untagged_addr() overhead until
 the first LAM user
Message-ID: <Y8a4bmCU9wsenvvF@hirez.programming.kicks-ass.net>
References: <20230111123736.20025-1-kirill.shutemov@linux.intel.com>
 <20230111123736.20025-9-kirill.shutemov@linux.intel.com>
 <Y8adEg2CYUSVpwtk@hirez.programming.kicks-ass.net>
 <20230117135703.voaumisreld7crfb@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117135703.voaumisreld7crfb@box>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 04:57:03PM +0300, Kirill A. Shutemov wrote:
> On Tue, Jan 17, 2023 at 02:05:22PM +0100, Peter Zijlstra wrote:
> > On Wed, Jan 11, 2023 at 03:37:27PM +0300, Kirill A. Shutemov wrote:
> > 
> > >  #define __untagged_addr(untag_mask, addr)
> > >  	u64 __addr = (__force u64)(addr);				\
> > > -	s64 sign = (s64)__addr >> 63;					\
> > > -	__addr &= untag_mask | sign;					\
> > > +	if (static_branch_likely(&tagged_addr_key)) {			\
> > > +		s64 sign = (s64)__addr >> 63;				\
> > > +		__addr &= untag_mask | sign;				\
> > > +	}								\
> > >  	(__force __typeof__(addr))__addr;				\
> > >  })
> > >  
> > > #define untagged_addr(addr) __untagged_addr(current_untag_mask(), addr)
> > 
> > Is the compiler clever enough to put the memop inside the branch?
> 
> Hm. You mean current_untag_mask() inside static_branch_likely()?
> 
> But it is preprocessor who does this, not compiler. So, yes, the memop is
> inside the branch.
> 
> Or I didn't understand your question.

Nah, call it a pre-lunch dip, I overlooked the whole CPP angle -- d'0h.

That said, I did just put it through a compiler to see wth it did and it
is pretty gross:

GCC-12.2:

0000 00000000000023b0 <write_ok_or_segv>:
0000     23b0:  48 89 fa                mov    %rdi,%rdx
0003     23b3:  eb 76                   jmp    242b <write_ok_or_segv+0x7b>
0005     23b5:  65 48 8b 0d 00 00 00 00         mov    %gs:0x0(%rip),%rcx        # 23bd <write_ok_or_segv+0xd>  23b9: R_X86_64_PC32     tlbstate_untag_mask-0x4
000d     23bd:  48 89 f8                mov    %rdi,%rax
0010     23c0:  48 c1 f8 3f             sar    $0x3f,%rax
0014     23c4:  48 09 c8                or     %rcx,%rax
0017     23c7:  48 21 f8                and    %rdi,%rax
001a     23ca:  48 b9 00 f0 ff ff ff 7f 00 00   movabs $0x7ffffffff000,%rcx
0024     23d4:  48 39 f1                cmp    %rsi,%rcx
0027     23d7:  72 14                   jb     23ed <write_ok_or_segv+0x3d>
0029     23d9:  48 29 f1                sub    %rsi,%rcx
002c     23dc:  be 01 00 00 00          mov    $0x1,%esi
0031     23e1:  48 39 c1                cmp    %rax,%rcx
0034     23e4:  72 07                   jb     23ed <write_ok_or_segv+0x3d>
0036     23e6:  89 f0                   mov    %esi,%eax
0038     23e8:  e9 00 00 00 00          jmp    23ed <write_ok_or_segv+0x3d>     23e9: R_X86_64_PLT32    __x86_return_thunk-0x4
003d     23ed:  65 48 8b 04 25 00 00 00 00      mov    %gs:0x0,%rax     23f2: R_X86_64_32S      pcpu_hot
0046     23f6:  48 89 90 68 0b 00 00    mov    %rdx,0xb68(%rax)
004d     23fd:  be 01 00 00 00          mov    $0x1,%esi
0052     2402:  bf 0b 00 00 00          mov    $0xb,%edi
0057     2407:  48 c7 80 78 0b 00 00 06 00 00 00        movq   $0x6,0xb78(%rax)
0062     2412:  48 c7 80 70 0b 00 00 0e 00 00 00        movq   $0xe,0xb70(%rax)
006d     241d:  e8 00 00 00 00          call   2422 <write_ok_or_segv+0x72>     241e: R_X86_64_PLT32    force_sig_fault-0x4
0072     2422:  31 f6                   xor    %esi,%esi
0074     2424:  89 f0                   mov    %esi,%eax
0076     2426:  e9 00 00 00 00          jmp    242b <write_ok_or_segv+0x7b>     2427: R_X86_64_PLT32    __x86_return_thunk-0x4
007b     242b:  48 89 f8                mov    %rdi,%rax
007e     242e:  eb 9a                   jmp    23ca <write_ok_or_segv+0x1a>

Note the stupid jump to the end and back. Not all sites do this mind
you, but a fair number seem to do it.

Let me try llvm to see if it is any smarter.

CLANG-16:

0000 0000000000002d50 <write_ok_or_segv>:
0000     2d50:	41 57                	push   %r15
0002     2d52:	41 56                	push   %r14
0004     2d54:	41 54                	push   %r12
0006     2d56:	53                   	push   %rbx
0007     2d57:	48 89 f3             	mov    %rsi,%rbx
000a     2d5a:	48 89 fa             	mov    %rdi,%rdx
000d     2d5d:	49 89 fe             	mov    %rdi,%r14
0010     2d60:	eb 15                	jmp    2d77 <write_ok_or_segv+0x27>
0012     2d62:	48 89 d0             	mov    %rdx,%rax
0015     2d65:	48 c1 f8 3f          	sar    $0x3f,%rax
0019     2d69:	65 4c 8b 35 00 00 00 00 	mov    %gs:0x0(%rip),%r14        # 2d71 <write_ok_or_segv+0x21>	2d6d: R_X86_64_PC32	tlbstate_untag_mask-0x4
0021     2d71:	49 09 c6             	or     %rax,%r14
0024     2d74:	49 21 d6             	and    %rdx,%r14
0027     2d77:	f3 0f 1e fa          	endbr64
002b     2d7b:	49 bf 00 f0 ff ff ff 7f 00 00 	movabs $0x7ffffffff000,%r15
0035     2d85:	4d 89 fc             	mov    %r15,%r12
0038     2d88:	49 29 dc             	sub    %rbx,%r12
003b     2d8b:	72 05                	jb     2d92 <write_ok_or_segv+0x42>
003d     2d8d:	4d 39 f4             	cmp    %r14,%r12
0040     2d90:	73 34                	jae    2dc6 <write_ok_or_segv+0x76>
0042     2d92:	65 48 8b 05 00 00 00 00 	mov    %gs:0x0(%rip),%rax        # 2d9a <write_ok_or_segv+0x4a>	2d96: R_X86_64_PC32	pcpu_hot-0x4
004a     2d9a:	48 c7 80 78 0b 00 00 06 00 00 00 	movq   $0x6,0xb78(%rax)
0055     2da5:	48 89 90 68 0b 00 00 	mov    %rdx,0xb68(%rax)
005c     2dac:	48 c7 80 70 0b 00 00 0e 00 00 00 	movq   $0xe,0xb70(%rax)
0067     2db7:	bf 0b 00 00 00       	mov    $0xb,%edi
006c     2dbc:	be 01 00 00 00       	mov    $0x1,%esi
0071     2dc1:	e8 00 00 00 00       	call   2dc6 <write_ok_or_segv+0x76>	2dc2: R_X86_64_PLT32	force_sig_fault-0x4
0076     2dc6:	4d 39 f4             	cmp    %r14,%r12
0079     2dc9:	0f 93 c1             	setae  %cl
007c     2dcc:	49 39 df             	cmp    %rbx,%r15
007f     2dcf:	0f 93 c0             	setae  %al
0082     2dd2:	20 c8                	and    %cl,%al
0084     2dd4:	5b                   	pop    %rbx
0085     2dd5:	41 5c                	pop    %r12
0087     2dd7:	41 5e                	pop    %r14
0089     2dd9:	41 5f                	pop    %r15
008b     2ddb:	e9 00 00 00 00       	jmp    2de0 <__pfx_get_gate_vma>	2ddc: R_X86_64_PLT32	__x86_return_thunk-0x4

Well, it got the untag right, but OMG.. :-( Joao, Sami, any idea why it
put an ENDBR in there?
