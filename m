Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91ACC5E6360
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiIVNQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiIVNPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:15:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE22D1E86
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 06:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XHyghKGtI4v3UTAcXn1s1n9lUM+p+EqkAzneDWv+Ydg=; b=QAeMSdKGDtpbenKzyosuXAfmSI
        rnBM4IyVh18GiTkvwtWfXjvDQbkoeHGkG/nbRcTHtCrsW7BOm24q+pXV5IAVl3DnmlLfSKaSu0hkj
        ow2GKPX8RsKg77KJOf2bApJmIUkrE7yXwKuQomgH/i7dpavZUnIQ2sSInECZtITZRiElDPA7/BN5o
        P9ZvqUcO0yg1voKxI+/RzlEV6G17RP6uTRnZSM0+noc5kTK5KKIOR1E70EmYs0/oUjl5LsBzkCcVd
        2No2SUH889Q5ASS9sbXHE0KPdoujePrwz5LAp70bXA9cJ7kM2eHvEmrztMeONXmuc0SpQGnQ9lRHT
        tbSxGQ/Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1obM2t-0070iu-03; Thu, 22 Sep 2022 13:15:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 25DF3300023;
        Thu, 22 Sep 2022 15:15:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 06FF42B663B80; Thu, 22 Sep 2022 15:15:09 +0200 (CEST)
Date:   Thu, 22 Sep 2022 15:15:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
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
Subject: Re: [PATCH v3 32/59] objtool: Allow STT_NOTYPE -> STT_FUNC+0
 tail-calls
Message-ID: <Yyxf3eIF5hY7DHUh@hirez.programming.kicks-ass.net>
References: <20220915111039.092790446@infradead.org>
 <20220915111146.224130589@infradead.org>
 <20220922052750.wux3iykp2pfzi75k@desk>
 <Yyw5JqLtiXcqid3K@hirez.programming.kicks-ass.net>
 <Yyw9Pvo7/7YWoKds@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yyw9Pvo7/7YWoKds@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 12:47:26PM +0200, Peter Zijlstra wrote:
> On Thu, Sep 22, 2022 at 12:29:58PM +0200, Peter Zijlstra wrote:
> > I managed to reproduce with 12.2.0 -- my 12.1.0 compiler didn't
> > reproduce.
> > 
> > $ ./scripts/objdump-func vmlinux.o ftrace_replace_code
> 
> > 0000 0000000000012a83 <ftrace_replace_code.cold>:
> > 0000    12a83:	48 89 de             	mov    %rbx,%rsi
> > 0003    12a86:	89 c7                	mov    %eax,%edi
> > 0005    12a88:	5b                   	pop    %rbx
> > 0006    12a89:	5d                   	pop    %rbp
> > 0007    12a8a:	41 5c                	pop    %r12
> > 0009    12a8c:	41 5d                	pop    %r13
> > 000b    12a8e:	41 5e                	pop    %r14
> > 000d    12a90:	e9 62 fd ff ff       	jmp    127f7 <ftrace_bug>
> > 
> > 
> > Seems to suggest objtool is actually right; I cannot find a reference to
> > that cold symbol.
> 
> Ohhhh, ftrace_replace_cold is a weak function, so it could be the
> original weak symbol had a reference to the cold thing.
> 
> We have some code to deal with crap like that, lemme try and figure out
> what went wrong.

The original weak function:

  $ ./scripts/objdump-func kernel/trace/ftrace.o ftrace_replace_code
  0000 0000000000003bc0 <ftrace_replace_code>:
  0000     3bc0:  f3 0f 1e fa             endbr64
  0004     3bc4:  8b 15 00 00 00 00       mov    0x0(%rip),%edx        # 3bca <ftrace_replace_code+0xa>   3bc6: R_X86_64_PC32     .data..read_mostly+0xc
  000a     3bca:  41 56                   push   %r14
  000c     3bcc:  41 55                   push   %r13
  000e     3bce:  41 89 fd                mov    %edi,%r13d
  0011     3bd1:  41 54                   push   %r12
  0013     3bd3:  41 83 e5 02             and    $0x2,%r13d
  0017     3bd7:  55                      push   %rbp
  0018     3bd8:  53                      push   %rbx
  0019     3bd9:  85 d2                   test   %edx,%edx
  001b     3bdb:  75 67                   jne    3c44 <ftrace_replace_code+0x84>
  001d     3bdd:  4c 8b 35 00 00 00 00    mov    0x0(%rip),%r14        # 3be4 <ftrace_replace_code+0x24>  3be0: R_X86_64_PC32     .bss+0x54
  0024     3be4:  41 89 fc                mov    %edi,%r12d
  0027     3be7:  41 83 e4 01             and    $0x1,%r12d
  002b     3beb:  4d 85 f6                test   %r14,%r14
  002e     3bee:  74 54                   je     3c44 <ftrace_replace_code+0x84>
  0030     3bf0:  41 8b 46 10             mov    0x10(%r14),%eax
  0034     3bf4:  31 ed                   xor    %ebp,%ebp
  0036     3bf6:  85 c0                   test   %eax,%eax
  0038     3bf8:  7f 0b                   jg     3c05 <ftrace_replace_code+0x45>
  003a     3bfa:  eb 40                   jmp    3c3c <ftrace_replace_code+0x7c>
  003c     3bfc:  83 c5 01                add    $0x1,%ebp
  003f     3bff:  41 39 6e 10             cmp    %ebp,0x10(%r14)
  0043     3c03:  7e 37                   jle    3c3c <ftrace_replace_code+0x7c>
  0045     3c05:  48 63 dd                movslq %ebp,%rbx
  0048     3c08:  48 c1 e3 04             shl    $0x4,%rbx
  004c     3c0c:  49 03 5e 08             add    0x8(%r14),%rbx
  0050     3c10:  f6 43 0b 02             testb  $0x2,0xb(%rbx)
  0054     3c14:  75 e6                   jne    3bfc <ftrace_replace_code+0x3c>
  0056     3c16:  44 89 e6                mov    %r12d,%esi
  0059     3c19:  48 89 df                mov    %rbx,%rdi
  005c     3c1c:  e8 3f fb ff ff          call   3760 <__ftrace_replace_code>
  0061     3c21:  85 c0                   test   %eax,%eax
  0063     3c23:  0f 85 00 00 00 00       jne    3c29 <ftrace_replace_code+0x69>  3c25: R_X86_64_PC32     .text.unlikely+0x368

Jumps to the cold subfunction right here ^

  0069     3c29:  45 85 ed                test   %r13d,%r13d
  006c     3c2c:  74 ce                   je     3bfc <ftrace_replace_code+0x3c>
  006e     3c2e:  e8 00 00 00 00          call   3c33 <ftrace_replace_code+0x73>  3c2f: R_X86_64_PLT32    __SCT__cond_resched-0x4
  0073     3c33:  83 c5 01                add    $0x1,%ebp
  0076     3c36:  41 39 6e 10             cmp    %ebp,0x10(%r14)
  007a     3c3a:  7f c9                   jg     3c05 <ftrace_replace_code+0x45>
  007c     3c3c:  4d 8b 36                mov    (%r14),%r14
  007f     3c3f:  4d 85 f6                test   %r14,%r14
  0082     3c42:  75 ac                   jne    3bf0 <ftrace_replace_code+0x30>
  0084     3c44:  5b                      pop    %rbx
  0085     3c45:  5d                      pop    %rbp
  0086     3c46:  41 5c                   pop    %r12
  0088     3c48:  41 5d                   pop    %r13
  008a     3c4a:  41 5e                   pop    %r14
  008c     3c4c:  e9 00 00 00 00          jmp    3c51 <ftrace_replace_code+0x91>  3c4d: R_X86_64_PLT32    __x86_return_thunk-0x4
  0091     3c51:  66 66 2e 0f 1f 84 00 00 00 00 00        data16 cs nopw 0x0(%rax,%rax,1)
  009c     3c5c:  0f 1f 40 00             nopl   0x0(%rax)
  00a0     3c60:  90                      nop
  00a1     3c61:  90                      nop
  00a2     3c62:  90                      nop
  00a3     3c63:  90                      nop
  00a4     3c64:  90                      nop
  00a5     3c65:  90                      nop
  00a6     3c66:  90                      nop
  00a7     3c67:  90                      nop
  00a8     3c68:  90                      nop
  00a9     3c69:  90                      nop
  00aa     3c6a:  90                      nop
  00ab     3c6b:  90                      nop
  00ac     3c6c:  90                      nop
  00ad     3c6d:  90                      nop
  00ae     3c6e:  90                      nop
  00af     3c6f:  90                      nop
  0000 000000000000036c <ftrace_replace_code.cold>:
  0000  36c:      48 89 de                mov    %rbx,%rsi
  0003  36f:      89 c7                   mov    %eax,%edi
  0005  371:      5b                      pop    %rbx
  0006  372:      5d                      pop    %rbp
  0007  373:      41 5c                   pop    %r12
  0009  375:      41 5d                   pop    %r13
  000b  377:      41 5e                   pop    %r14
  000d  379:      e9 62 fd ff ff          jmp    e0 <ftrace_bug>

And yes, you're right this patch broke it.

Because the weak function symbol gets deleted by the linker, these
instructions will belong to no function and insn->func will be NULL.

Then the new: STT_NOTYPE -> STT_FUNC+0 logic kicks in and turns this
into a tail-call.

That means insn->jump_dest is unset in favour of insn->call_dest, and
then the unreachable logic falls on it's face because that doesn't deal
with call_dest.

Ho-Humm.. let me find a non hacky solution.
