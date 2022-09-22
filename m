Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C07B5E5FEB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiIVKau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiIVKap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:30:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E6A2C10E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 03:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JEol0TzadpuaTgsFP42i/Q/SEPwFKjFkWt8B5Zm7ZQg=; b=VciR3aA67UsSlhfasaq2LgzSZS
        FjI4YjCDa9VlHC6e2yDZAEPvWQwGO3rkr/v4XBtwS70Zl6zud9RS+znRnAtdbzoqacXzmi1yCQ0En
        HrTZS8lLJOjBA/hZUENR+iKIF/6OXNmj3hQPD4N+TcPBVe+c0k5mVGIJdJv7zw5LaEf4vFnjHE3W/
        YkgEHxW/rO2/Qup0pMLr/ssJlYlxSlWFb39EfLuRdVEL+5HSnr9ZGO9zKPC6fYkd9c9fcwzKKVllc
        OXzcmp5nsFt6q2vytzOn4qzOoB708iMWPTjr/uOKRqHOLpNeNt7TqFhivHnVM6EtGxnVBW+THfxeu
        sAjZhgAw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1obJT2-00EwBm-Eb; Thu, 22 Sep 2022 10:30:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B67FD300074;
        Thu, 22 Sep 2022 12:29:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 872E52BB99C4A; Thu, 22 Sep 2022 12:29:58 +0200 (CEST)
Date:   Thu, 22 Sep 2022 12:29:58 +0200
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
Message-ID: <Yyw5JqLtiXcqid3K@hirez.programming.kicks-ass.net>
References: <20220915111039.092790446@infradead.org>
 <20220915111146.224130589@infradead.org>
 <20220922052750.wux3iykp2pfzi75k@desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922052750.wux3iykp2pfzi75k@desk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 10:27:50PM -0700, Pawan Gupta wrote:
> On Thu, Sep 15, 2022 at 01:11:11PM +0200, Peter Zijlstra wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > Allow STT_NOTYPE to tail-call into STT_FUNC, per definition STT_NOTYPE
> > is not a sub-function of the STT_FUNC.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  tools/objtool/check.c |   29 ++++++++++++++++++++---------
> >  1 file changed, 20 insertions(+), 9 deletions(-)
> > 
> > --- a/tools/objtool/check.c
> > +++ b/tools/objtool/check.c
> > @@ -1370,6 +1370,16 @@ static void add_return_call(struct objto
> >  
> >  static bool same_function(struct instruction *insn1, struct instruction *insn2)
> >  {
> > +	if (!insn1->func && !insn2->func)
> > +		return true;
> > +
> > +	/* Allow STT_NOTYPE -> STT_FUNC+0 tail-calls */
> > +	if (!insn1->func && insn1->func != insn2->func)
> > +		return false;
> 
> Looks like this check is triggering below warning:
> 
> vmlinux.o: warning: objtool: ftrace_replace_code.cold+0x0: unreachable instruction
> 

I managed to reproduce with 12.2.0 -- my 12.1.0 compiler didn't
reproduce.

$ ./scripts/objdump-func vmlinux.o ftrace_replace_code
0000 00000000001032f0 <ftrace_replace_code>:
0000   1032f0:	f3 0f 1e fa          	endbr64
0004   1032f4:	41 57                	push   %r15
0006   1032f6:	41 56                	push   %r14
0008   1032f8:	41 55                	push   %r13
000a   1032fa:	41 89 fd             	mov    %edi,%r13d
000d   1032fd:	41 54                	push   %r12
000f   1032ff:	55                   	push   %rbp
0010   103300:	53                   	push   %rbx
0011   103301:	48 83 ec 10          	sub    $0x10,%rsp
0015   103305:	65 48 8b 04 25 28 00 00 00 	mov    %gs:0x28,%rax
001e   10330e:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
0023   103313:	31 c0                	xor    %eax,%eax
0025   103315:	e8 00 00 00 00       	call   10331a <ftrace_replace_code+0x2a>	103316: R_X86_64_PLT32	ftrace_rec_iter_start-0x4
002a   10331a:	45 85 ed             	test   %r13d,%r13d
002d   10331d:	41 0f 95 c4          	setne  %r12b
0031   103321:	48 85 c0             	test   %rax,%rax
0034   103324:	0f 84 e1 00 00 00    	je     10340b <ftrace_replace_code+0x11b>
003a   10332a:	48 89 c3             	mov    %rax,%rbx
003d   10332d:	45 0f b6 e4          	movzbl %r12b,%r12d
0041   103331:	48 c7 c5 00 00 00 00 	mov    $0x0,%rbp	103334: R_X86_64_32S	.bss+0x16538
0048   103338:	48 89 df             	mov    %rbx,%rdi
004b   10333b:	e8 00 00 00 00       	call   103340 <ftrace_replace_code+0x50>	10333c: R_X86_64_PLT32	ftrace_rec_iter_record-0x4
0050   103340:	44 89 e6             	mov    %r12d,%esi
0053   103343:	48 89 c7             	mov    %rax,%rdi
0056   103346:	49 89 c6             	mov    %rax,%r14
0059   103349:	e8 00 00 00 00       	call   10334e <ftrace_replace_code+0x5e>	10334a: R_X86_64_PLT32	ftrace_test_record-0x4
005e   10334e:	83 f8 01             	cmp    $0x1,%eax
0061   103351:	0f 84 61 01 00 00    	je     1034b8 <ftrace_replace_code+0x1c8>
0067   103357:	83 e8 02             	sub    $0x2,%eax
006a   10335a:	83 f8 01             	cmp    $0x1,%eax
006d   10335d:	0f 87 94 00 00 00    	ja     1033f7 <ftrace_replace_code+0x107>
0073   103363:	4c 89 f7             	mov    %r14,%rdi
0076   103366:	49 c7 c7 00 00 00 00 	mov    $0x0,%r15	103369: R_X86_64_32S	.bss+0x16538
007d   10336d:	e8 00 00 00 00       	call   103372 <ftrace_replace_code+0x82>	10336e: R_X86_64_PLT32	ftrace_get_addr_curr-0x4
0082   103372:	49 8b 16             	mov    (%r14),%rdx
0085   103375:	c6 45 00 e8          	movb   $0xe8,0x0(%rbp)
0089   103379:	48 83 c2 05          	add    $0x5,%rdx
008d   10337d:	48 29 d0             	sub    %rdx,%rax
0090   103380:	89 45 01             	mov    %eax,0x1(%rbp)
0093   103383:	49 8b 36             	mov    (%r14),%rsi
0096   103386:	ba 05 00 00 00       	mov    $0x5,%edx
009b   10338b:	48 8d 7c 24 03       	lea    0x3(%rsp),%rdi
00a0   103390:	c7 44 24 03 00 00 00 00 	movl   $0x0,0x3(%rsp)
00a8   103398:	c6 44 24 07 00       	movb   $0x0,0x7(%rsp)
00ad   10339d:	e8 00 00 00 00       	call   1033a2 <ftrace_replace_code+0xb2>	10339e: R_X86_64_PLT32	copy_from_kernel_nofault-0x4
00b2   1033a2:	48 85 c0             	test   %rax,%rax
00b5   1033a5:	0f 85 3e 01 00 00    	jne    1034e9 <ftrace_replace_code+0x1f9>
00bb   1033ab:	41 8b 07             	mov    (%r15),%eax
00be   1033ae:	39 44 24 03          	cmp    %eax,0x3(%rsp)
00c2   1033b2:	74 38                	je     1033ec <ftrace_replace_code+0xfc>
00c4   1033b4:	4c 89 3d 00 00 00 00 	mov    %r15,0x0(%rip)        # 1033bb <ftrace_replace_code+0xcb>	1033b7: R_X86_64_PC32	ftrace_expected-0x4
00cb   1033bb:	0f 0b                	ud2
00cd   1033bd:	bf ea ff ff ff       	mov    $0xffffffea,%edi
00d2   1033c2:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
00d7   1033c7:	65 48 2b 04 25 28 00 00 00 	sub    %gs:0x28,%rax
00e0   1033d0:	0f 85 1f 01 00 00    	jne    1034f5 <ftrace_replace_code+0x205>
00e6   1033d6:	48 83 c4 10          	add    $0x10,%rsp
00ea   1033da:	4c 89 f6             	mov    %r14,%rsi
00ed   1033dd:	5b                   	pop    %rbx
00ee   1033de:	5d                   	pop    %rbp
00ef   1033df:	41 5c                	pop    %r12
00f1   1033e1:	41 5d                	pop    %r13
00f3   1033e3:	41 5e                	pop    %r14
00f5   1033e5:	41 5f                	pop    %r15
00f7   1033e7:	e9 00 00 00 00       	jmp    1033ec <ftrace_replace_code+0xfc>	1033e8: R_X86_64_PLT32	ftrace_bug-0x4
00fc   1033ec:	41 0f b6 47 04       	movzbl 0x4(%r15),%eax
0101   1033f1:	38 44 24 07          	cmp    %al,0x7(%rsp)
0105   1033f5:	75 bd                	jne    1033b4 <ftrace_replace_code+0xc4>
0107   1033f7:	48 89 df             	mov    %rbx,%rdi
010a   1033fa:	e8 00 00 00 00       	call   1033ff <ftrace_replace_code+0x10f>	1033fb: R_X86_64_PLT32	ftrace_rec_iter_next-0x4
010f   1033ff:	48 89 c3             	mov    %rax,%rbx
0112   103402:	48 85 c0             	test   %rax,%rax
0115   103405:	0f 85 2d ff ff ff    	jne    103338 <ftrace_replace_code+0x48>
011b   10340b:	e8 00 00 00 00       	call   103410 <ftrace_replace_code+0x120>	10340c: R_X86_64_PLT32	ftrace_rec_iter_start-0x4
0120   103410:	45 31 e4             	xor    %r12d,%r12d
0123   103413:	45 85 ed             	test   %r13d,%r13d
0126   103416:	49 c7 c5 00 00 00 00 	mov    $0x0,%r13	103419: R_X86_64_32S	.bss+0x16538
012d   10341d:	41 0f 95 c4          	setne  %r12b
0131   103421:	48 89 c3             	mov    %rax,%rbx
0134   103424:	48 85 c0             	test   %rax,%rax
0137   103427:	75 1a                	jne    103443 <ftrace_replace_code+0x153>
0139   103429:	eb 6a                	jmp    103495 <ftrace_replace_code+0x1a5>
013b   10342b:	85 c0                	test   %eax,%eax
013d   10342d:	0f 8f 91 00 00 00    	jg     1034c4 <ftrace_replace_code+0x1d4>
0143   103433:	48 89 df             	mov    %rbx,%rdi
0146   103436:	e8 00 00 00 00       	call   10343b <ftrace_replace_code+0x14b>	103437: R_X86_64_PLT32	ftrace_rec_iter_next-0x4
014b   10343b:	48 89 c3             	mov    %rax,%rbx
014e   10343e:	48 85 c0             	test   %rax,%rax
0151   103441:	74 52                	je     103495 <ftrace_replace_code+0x1a5>
0153   103443:	48 89 df             	mov    %rbx,%rdi
0156   103446:	e8 00 00 00 00       	call   10344b <ftrace_replace_code+0x15b>	103447: R_X86_64_PLT32	ftrace_rec_iter_record-0x4
015b   10344b:	44 89 e6             	mov    %r12d,%esi
015e   10344e:	48 89 c7             	mov    %rax,%rdi
0161   103451:	48 89 c5             	mov    %rax,%rbp
0164   103454:	e8 00 00 00 00       	call   103459 <ftrace_replace_code+0x169>	103455: R_X86_64_PLT32	ftrace_test_record-0x4
0169   103459:	83 f8 02             	cmp    $0x2,%eax
016c   10345c:	7e cd                	jle    10342b <ftrace_replace_code+0x13b>
016e   10345e:	83 f8 03             	cmp    $0x3,%eax
0171   103461:	75 d0                	jne    103433 <ftrace_replace_code+0x143>
0173   103463:	48 8b 35 00 00 00 00 	mov    0x0(%rip),%rsi        # 10346a <ftrace_replace_code+0x17a>	103466: R_X86_64_PC32	x86_nops+0x24
017a   10346a:	48 8b 7d 00          	mov    0x0(%rbp),%rdi
017e   10346e:	31 c9                	xor    %ecx,%ecx
0180   103470:	ba 05 00 00 00       	mov    $0x5,%edx
0185   103475:	e8 00 00 00 00       	call   10347a <ftrace_replace_code+0x18a>	103476: R_X86_64_PLT32	text_poke_queue-0x4
018a   10347a:	44 89 e6             	mov    %r12d,%esi
018d   10347d:	48 89 ef             	mov    %rbp,%rdi
0190   103480:	e8 00 00 00 00       	call   103485 <ftrace_replace_code+0x195>	103481: R_X86_64_PLT32	ftrace_update_record-0x4
0195   103485:	48 89 df             	mov    %rbx,%rdi
0198   103488:	e8 00 00 00 00       	call   10348d <ftrace_replace_code+0x19d>	103489: R_X86_64_PLT32	ftrace_rec_iter_next-0x4
019d   10348d:	48 89 c3             	mov    %rax,%rbx
01a0   103490:	48 85 c0             	test   %rax,%rax
01a3   103493:	75 ae                	jne    103443 <ftrace_replace_code+0x153>
01a5   103495:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
01aa   10349a:	65 48 2b 04 25 28 00 00 00 	sub    %gs:0x28,%rax
01b3   1034a3:	75 50                	jne    1034f5 <ftrace_replace_code+0x205>
01b5   1034a5:	48 83 c4 10          	add    $0x10,%rsp
01b9   1034a9:	5b                   	pop    %rbx
01ba   1034aa:	5d                   	pop    %rbp
01bb   1034ab:	41 5c                	pop    %r12
01bd   1034ad:	41 5d                	pop    %r13
01bf   1034af:	41 5e                	pop    %r14
01c1   1034b1:	41 5f                	pop    %r15
01c3   1034b3:	e9 00 00 00 00       	jmp    1034b8 <ftrace_replace_code+0x1c8>	1034b4: R_X86_64_PLT32	text_poke_finish-0x4
01c8   1034b8:	4c 8b 3d 00 00 00 00 	mov    0x0(%rip),%r15        # 1034bf <ftrace_replace_code+0x1cf>	1034bb: R_X86_64_PC32	x86_nops+0x24
01cf   1034bf:	e9 bf fe ff ff       	jmp    103383 <ftrace_replace_code+0x93>
01d4   1034c4:	48 89 ef             	mov    %rbp,%rdi
01d7   1034c7:	e8 00 00 00 00       	call   1034cc <ftrace_replace_code+0x1dc>	1034c8: R_X86_64_PLT32	ftrace_get_addr_new-0x4
01dc   1034cc:	48 8b 55 00          	mov    0x0(%rbp),%rdx
01e0   1034d0:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi	1034d3: R_X86_64_32S	.bss+0x16538
01e7   1034d7:	41 c6 45 00 e8       	movb   $0xe8,0x0(%r13)
01ec   1034dc:	48 83 c2 05          	add    $0x5,%rdx
01f0   1034e0:	48 29 d0             	sub    %rdx,%rax
01f3   1034e3:	41 89 45 01          	mov    %eax,0x1(%r13)
01f7   1034e7:	eb 81                	jmp    10346a <ftrace_replace_code+0x17a>
01f9   1034e9:	0f 0b                	ud2
01fb   1034eb:	bf f2 ff ff ff       	mov    $0xfffffff2,%edi
0200   1034f0:	e9 cd fe ff ff       	jmp    1033c2 <ftrace_replace_code+0xd2>
0205   1034f5:	e8 00 00 00 00       	call   1034fa <ftrace_replace_code+0x20a>	1034f6: R_X86_64_PLT32	__stack_chk_fail-0x4
020a   1034fa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
0210   103500:	90                   	nop
0211   103501:	90                   	nop
0212   103502:	90                   	nop
0213   103503:	90                   	nop
0214   103504:	90                   	nop
0215   103505:	90                   	nop
0216   103506:	90                   	nop
0217   103507:	90                   	nop
0218   103508:	90                   	nop
0219   103509:	90                   	nop
021a   10350a:	90                   	nop
021b   10350b:	90                   	nop
021c   10350c:	90                   	nop
021d   10350d:	90                   	nop
021e   10350e:	90                   	nop
021f   10350f:	90                   	nop
0000 0000000000012a83 <ftrace_replace_code.cold>:
0000    12a83:	48 89 de             	mov    %rbx,%rsi
0003    12a86:	89 c7                	mov    %eax,%edi
0005    12a88:	5b                   	pop    %rbx
0006    12a89:	5d                   	pop    %rbp
0007    12a8a:	41 5c                	pop    %r12
0009    12a8c:	41 5d                	pop    %r13
000b    12a8e:	41 5e                	pop    %r14
000d    12a90:	e9 62 fd ff ff       	jmp    127f7 <ftrace_bug>


Seems to suggest objtool is actually right; I cannot find a reference to
that cold symbol.
