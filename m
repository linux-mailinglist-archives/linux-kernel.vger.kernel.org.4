Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A627C6DE86E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 02:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjDLAOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 20:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDLAOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 20:14:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CED12B;
        Tue, 11 Apr 2023 17:14:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F74A60F53;
        Wed, 12 Apr 2023 00:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7074FC433EF;
        Wed, 12 Apr 2023 00:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681258442;
        bh=6W2rcrD8kjfOhvq5OmNlnh08xgfnjOb2u9Qo/plRkHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EPbAMBkk1+ZZgldUlBivocfMvpFNYtEWnKUXpYbybhKgS4EnZxgB8AsfkIrM87qIe
         jDvcJHXIeMlxkP87FzE900yp1vY+W19MBi/377DtXf9Pgmpz5KMdES+xgQarB4G4Cc
         qEd6mbwAPSzCM2SqG12YnVry9Nu5FDgZ+51uVpw7Uup/n1AwEa9THh4YwwBePJRHNo
         Hc2lZPE84+HejtRmcPMlxgfI2uHXMdBGDbX8Ssd2zWq/Q+VkxcPUKmSTZzO7GbKO35
         EFNsUig1DV1SAnDA78U1VQuo5Vf4lYcMrD2Czm4tMpJF2JbygYaL4sL3Ru7yBSD62h
         ZzIFmsD12bMGA==
Date:   Tue, 11 Apr 2023 17:14:00 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the block tree
Message-ID: <20230412001400.yraku5fwsjdchxvk@treble>
References: <20230327120017.6bb826d7@canb.auug.org.au>
 <20230327162630.wmxpycxhllt4clpt@treble>
 <20230328104719.65133586@canb.auug.org.au>
 <20230412073416.73a8ea1a@canb.auug.org.au>
 <20230411215518.u2fgi7napfcwyuce@treble>
 <4959d0b8-96fe-7fe5-8b36-7e0a266d1d17@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4959d0b8-96fe-7fe5-8b36-7e0a266d1d17@kernel.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 04:39:39PM -0600, Jens Axboe wrote:
> >>>>> lib/iov_iter.o: warning: objtool: .altinstr_replacement+0x0: redundant UACCESS d
> >>>>> isable
> >>>>> lib/iov_iter.o: warning: objtool: iovec_from_user.part.0+0xc7: call to copy_comp
> >>>>> at_iovec_from_user.part.0() with UACCESS enabled
> >>>>> lib/iov_iter.o: warning: objtool: __import_iovec+0x21d: call to copy_compat_iovec_from_user.part.0() with UACCESS enabled
> >>>>>
> >>>>> Presumably introduced by commit
> >>>>>
> >>>>>   6376ce56feb6 ("iov_iter: import single vector iovecs as ITER_UBUF")    
> 
> lib/iov_iter.o attached, gzip'ed. NOTE: if you disable either of the
> copy_compat_iovec_from_user() as per diff below (commented out), then
> it doesn't complain. Is there some bug where it thinks we'll hit both?
> That should not be possible.

Yeah, the problem is an inter-procedural compiler optimization which
moves the user_access_begin() out of copy_compat_iovec_from_user() and
into its callers.

Which is fine, but objtool doesn't like it as it expects the uaccess
enable to not cross function boundaries.

Do the warnings go away if you make copy_compat_iovec_from_user()
non-static?

Peter, what do you think, should we make track uaccess state across
function boundaries?

Disassembly below:


0000000000000730 <copy_compat_iovec_from_user.part.0>:
     730:	48 85 d2             	test   %rdx,%rdx
     733:	74 45                	je     77a <copy_compat_iovec_from_user.part.0+0x4a>

     735:	45 31 c9             	xor    %r9d,%r9d
     738:	31 c0                	xor    %eax,%eax
     73a:	eb 1d                	jmp    759 <copy_compat_iovec_from_user.part.0+0x29>

     73c:	48 c1 e0 04          	shl    $0x4,%rax
     740:	41 83 c1 01          	add    $0x1,%r9d
     744:	48 01 f8             	add    %rdi,%rax
     747:	48 89 08             	mov    %rcx,(%rax)
     74a:	44 89 c1             	mov    %r8d,%ecx
     74d:	48 89 48 08          	mov    %rcx,0x8(%rax)
     751:	49 63 c1             	movslq %r9d,%rax
     754:	48 39 d0             	cmp    %rdx,%rax
     757:	73 21                	jae    77a <copy_compat_iovec_from_user.part.0+0x4a>

     759:	48 8d 0c c6          	lea    (%rsi,%rax,8),%rcx
     75d:	44 8b 41 04          	mov    0x4(%rcx),%r8d
     761:	8b 09                	mov    (%rcx),%ecx
     763:	89 c9                	mov    %ecx,%ecx
     765:	45 85 c0             	test   %r8d,%r8d
     768:	79 d2                	jns    73c <copy_compat_iovec_from_user.part.0+0xc>

     76a:	b8 ea ff ff ff       	mov    $0xffffffea,%eax
     76f:	90                   	nop
     770:	90                   	nop
     771:	90                   	nop
     772:	c3                   	ret    

     773:	b8 f2 ff ff ff       	mov    $0xfffffff2,%eax
     778:	eb f5                	jmp    76f <copy_compat_iovec_from_user.part.0+0x3f>

     77a:	31 c0                	xor    %eax,%eax
     77c:	eb f1                	jmp    76f <copy_compat_iovec_from_user.part.0+0x3f>

     77e:	66 90                	xchg   %ax,%ax

0000000000002380 <iovec_from_user.part.0>:
    2380:	41 56                	push   %r14
    2382:	45 89 c6             	mov    %r8d,%r14d
    2385:	41 55                	push   %r13
    2387:	49 89 fd             	mov    %rdi,%r13
    238a:	41 54                	push   %r12
    238c:	49 89 cc             	mov    %rcx,%r12
    238f:	55                   	push   %rbp
    2390:	48 89 cd             	mov    %rcx,%rbp
    2393:	53                   	push   %rbx
    2394:	48 89 f3             	mov    %rsi,%rbx
    2397:	48 83 ec 08          	sub    $0x8,%rsp
    239b:	48 39 f2             	cmp    %rsi,%rdx
    239e:	0f 82 bc 00 00 00    	jb     2460 <iovec_from_user.part.0+0xe0>
    23a4:	45 84 f6             	test   %r14b,%r14b
    23a7:	75 70                	jne    2419 <iovec_from_user.part.0+0x99>
    23a9:	48 89 da             	mov    %rbx,%rdx
    23ac:	48 c1 e2 04          	shl    $0x4,%rdx
    23b0:	48 81 fa ff ff ff 7f 	cmp    $0x7fffffff,%rdx
    23b7:	0f 87 98 00 00 00    	ja     2455 <iovec_from_user.part.0+0xd5>
    23bd:	4c 89 ee             	mov    %r13,%rsi
    23c0:	48 89 ef             	mov    %rbp,%rdi
    23c3:	e8 00 00 00 00       	call   23c8 <iovec_from_user.part.0+0x48>	23c4: R_X86_64_PLT32	_copy_from_user-0x4
    23c8:	48 85 c0             	test   %rax,%rax
    23cb:	0f 85 86 00 00 00    	jne    2457 <iovec_from_user.part.0+0xd7>
    23d1:	48 85 db             	test   %rbx,%rbx
    23d4:	75 0b                	jne    23e1 <iovec_from_user.part.0+0x61>
    23d6:	eb 78                	jmp    2450 <iovec_from_user.part.0+0xd0>
    23d8:	48 83 c0 01          	add    $0x1,%rax
    23dc:	48 39 c3             	cmp    %rax,%rbx
    23df:	74 6f                	je     2450 <iovec_from_user.part.0+0xd0>
    23e1:	48 89 c2             	mov    %rax,%rdx
    23e4:	48 c1 e2 04          	shl    $0x4,%rdx
    23e8:	48 83 7c 15 08 00    	cmpq   $0x0,0x8(%rbp,%rdx,1)
    23ee:	79 e8                	jns    23d8 <iovec_from_user.part.0+0x58>
    23f0:	b8 ea ff ff ff       	mov    $0xffffffea,%eax
    23f5:	48 98                	cltq   
    23f7:	4c 39 e5             	cmp    %r12,%rbp
    23fa:	74 10                	je     240c <iovec_from_user.part.0+0x8c>
    23fc:	48 89 ef             	mov    %rbp,%rdi
    23ff:	48 89 04 24          	mov    %rax,(%rsp)
    2403:	e8 00 00 00 00       	call   2408 <iovec_from_user.part.0+0x88>	2404: R_X86_64_PLT32	kfree-0x4
    2408:	48 8b 04 24          	mov    (%rsp),%rax
    240c:	48 83 c4 08          	add    $0x8,%rsp
    2410:	5b                   	pop    %rbx
    2411:	5d                   	pop    %rbp
    2412:	41 5c                	pop    %r12
    2414:	41 5d                	pop    %r13
    2416:	41 5e                	pop    %r14
    2418:	c3                   	ret    
    2419:	48 8d 14 dd 00 00 00 00 	lea    0x0(,%rbx,8),%rdx
    2421:	48 b8 00 f0 ff ff ff 7f 00 00 	movabs $0x7ffffffff000,%rax
    242b:	48 39 d0             	cmp    %rdx,%rax
    242e:	72 27                	jb     2457 <iovec_from_user.part.0+0xd7>
    2430:	48 29 d0             	sub    %rdx,%rax
    2433:	4c 39 e8             	cmp    %r13,%rax
    2436:	72 1f                	jb     2457 <iovec_from_user.part.0+0xd7>
    2438:	90                   	nop
    2439:	90                   	nop
    243a:	90                   	nop
    243b:	90                   	nop
    243c:	90                   	nop
    243d:	90                   	nop
    243e:	48 89 da             	mov    %rbx,%rdx
    2441:	4c 89 ee             	mov    %r13,%rsi
    2444:	48 89 ef             	mov    %rbp,%rdi
    2447:	e8 e4 e2 ff ff       	call   730 <copy_compat_iovec_from_user.part.0>
    244c:	85 c0                	test   %eax,%eax
    244e:	75 a5                	jne    23f5 <iovec_from_user.part.0+0x75>
    2450:	48 89 e8             	mov    %rbp,%rax
    2453:	eb b7                	jmp    240c <iovec_from_user.part.0+0x8c>
    2455:	0f 0b                	ud2    
    2457:	48 c7 c0 f2 ff ff ff 	mov    $0xfffffffffffffff2,%rax
    245e:	eb 97                	jmp    23f7 <iovec_from_user.part.0+0x77>
    2460:	48 89 f7             	mov    %rsi,%rdi
    2463:	48 89 f0             	mov    %rsi,%rax
    2466:	48 c1 e7 04          	shl    $0x4,%rdi
    246a:	48 c1 e8 3c          	shr    $0x3c,%rax
    246e:	75 16                	jne    2486 <iovec_from_user.part.0+0x106>
    2470:	be c0 0c 00 00       	mov    $0xcc0,%esi
    2475:	e8 00 00 00 00       	call   247a <iovec_from_user.part.0+0xfa>	2476: R_X86_64_PLT32	__kmalloc-0x4
    247a:	48 89 c5             	mov    %rax,%rbp
    247d:	48 85 c0             	test   %rax,%rax
    2480:	0f 85 1e ff ff ff    	jne    23a4 <iovec_from_user.part.0+0x24>
    2486:	48 c7 c0 f4 ff ff ff 	mov    $0xfffffffffffffff4,%rax
    248d:	e9 7a ff ff ff       	jmp    240c <iovec_from_user.part.0+0x8c>
    2492:	66 66 2e 0f 1f 84 00 00 00 00 00 	data16 cs nopw 0x0(%rax,%rax,1)
    249d:	0f 1f 00             	nopl   (%rax)

0000000000004910 <__import_iovec>:
    4910:	41 56                	push   %r14
    4912:	4d 89 ce             	mov    %r9,%r14
    4915:	41 55                	push   %r13
    4917:	41 89 fd             	mov    %edi,%r13d
    491a:	48 89 f7             	mov    %rsi,%rdi
    491d:	41 54                	push   %r12
    491f:	55                   	push   %rbp
    4920:	4c 89 c5             	mov    %r8,%rbp
    4923:	53                   	push   %rbx
    4924:	44 8b 44 24 30       	mov    0x30(%rsp),%r8d
    4929:	48 8b 5d 00          	mov    0x0(%rbp),%rbx
    492d:	83 fa 01             	cmp    $0x1,%edx
    4930:	0f 84 18 01 00 00    	je     4a4e <__import_iovec+0x13e>
    4936:	41 89 d4             	mov    %edx,%r12d
    4939:	4d 85 e4             	test   %r12,%r12
    493c:	0f 84 f7 00 00 00    	je     4a39 <__import_iovec+0x129>
    4942:	49 81 fc 00 04 00 00 	cmp    $0x400,%r12
    4949:	0f 87 ad 01 00 00    	ja     4afc <__import_iovec+0x1ec>
    494f:	89 ca                	mov    %ecx,%edx
    4951:	45 0f b6 c0          	movzbl %r8b,%r8d
    4955:	48 89 d9             	mov    %rbx,%rcx
    4958:	4c 89 e6             	mov    %r12,%rsi
    495b:	e8 20 da ff ff       	call   2380 <iovec_from_user.part.0>
    4960:	4d 89 e0             	mov    %r12,%r8
    4963:	31 c9                	xor    %ecx,%ecx
    4965:	41 ba 00 f0 ff 7f    	mov    $0x7ffff000,%r10d
    496b:	49 c1 e0 04          	shl    $0x4,%r8
    496f:	48 89 c3             	mov    %rax,%rbx
    4972:	48 bf 00 f0 ff ff ff 7f 00 00 	movabs $0x7ffffffff000,%rdi
    497c:	49 01 c0             	add    %rax,%r8
    497f:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
    4985:	0f 87 bb 00 00 00    	ja     4a46 <__import_iovec+0x136>
    498b:	48 8b 50 08          	mov    0x8(%rax),%rdx
    498f:	48 8b 30             	mov    (%rax),%rsi
    4992:	48 39 d7             	cmp    %rdx,%rdi
    4995:	72 0b                	jb     49a2 <__import_iovec+0x92>
    4997:	49 89 f9             	mov    %rdi,%r9
    499a:	49 29 d1             	sub    %rdx,%r9
    499d:	49 39 f1             	cmp    %rsi,%r9
    49a0:	73 29                	jae    49cb <__import_iovec+0xbb>
    49a2:	48 39 5d 00          	cmp    %rbx,0x0(%rbp)
    49a6:	74 08                	je     49b0 <__import_iovec+0xa0>
    49a8:	48 89 df             	mov    %rbx,%rdi
    49ab:	e8 00 00 00 00       	call   49b0 <__import_iovec+0xa0>	49ac: R_X86_64_PLT32	kfree-0x4
    49b0:	48 c7 45 00 00 00 00 00 	movq   $0x0,0x0(%rbp)
    49b8:	48 c7 c1 f2 ff ff ff 	mov    $0xfffffffffffffff2,%rcx
    49bf:	5b                   	pop    %rbx
    49c0:	48 89 c8             	mov    %rcx,%rax
    49c3:	5d                   	pop    %rbp
    49c4:	41 5c                	pop    %r12
    49c6:	41 5d                	pop    %r13
    49c8:	41 5e                	pop    %r14
    49ca:	c3                   	ret    
    49cb:	4c 89 d6             	mov    %r10,%rsi
    49ce:	48 29 ce             	sub    %rcx,%rsi
    49d1:	48 01 d1             	add    %rdx,%rcx
    49d4:	48 39 d6             	cmp    %rdx,%rsi
    49d7:	73 09                	jae    49e2 <__import_iovec+0xd2>
    49d9:	48 89 70 08          	mov    %rsi,0x8(%rax)
    49dd:	b9 00 f0 ff 7f       	mov    $0x7ffff000,%ecx
    49e2:	48 83 c0 10          	add    $0x10,%rax
    49e6:	49 39 c0             	cmp    %rax,%r8
    49e9:	75 a0                	jne    498b <__import_iovec+0x7b>
    49eb:	48 89 c8             	mov    %rcx,%rax
    49ee:	41 83 fd 01          	cmp    $0x1,%r13d
    49f2:	0f 87 5f 01 00 00    	ja     4b57 <__import_iovec+0x247>
    49f8:	31 d2                	xor    %edx,%edx
    49fa:	45 85 ed             	test   %r13d,%r13d
    49fd:	49 89 5e 10          	mov    %rbx,0x10(%r14)
    4a01:	49 89 46 18          	mov    %rax,0x18(%r14)
    4a05:	41 0f 95 46 02       	setne  0x2(%r14)
    4a0a:	31 c0                	xor    %eax,%eax
    4a0c:	66 41 89 16          	mov    %dx,(%r14)
    4a10:	41 c6 46 03 01       	movb   $0x1,0x3(%r14)
    4a15:	49 c7 46 08 00 00 00 00 	movq   $0x0,0x8(%r14)
    4a1d:	4d 89 66 20          	mov    %r12,0x20(%r14)
    4a21:	48 39 5d 00          	cmp    %rbx,0x0(%rbp)
    4a25:	48 0f 44 d8          	cmove  %rax,%rbx
    4a29:	48 89 c8             	mov    %rcx,%rax
    4a2c:	48 89 5d 00          	mov    %rbx,0x0(%rbp)
    4a30:	5b                   	pop    %rbx
    4a31:	5d                   	pop    %rbp
    4a32:	41 5c                	pop    %r12
    4a34:	41 5d                	pop    %r13
    4a36:	41 5e                	pop    %r14
    4a38:	c3                   	ret    
    4a39:	31 c0                	xor    %eax,%eax
    4a3b:	31 c9                	xor    %ecx,%ecx
    4a3d:	48 81 fb 00 f0 ff ff 	cmp    $0xfffffffffffff000,%rbx
    4a44:	76 a8                	jbe    49ee <__import_iovec+0xde>
    4a46:	48 89 d9             	mov    %rbx,%rcx
    4a49:	e9 b5 00 00 00       	jmp    4b03 <__import_iovec+0x1f3>
    4a4e:	45 84 c0             	test   %r8b,%r8b
    4a51:	0f 85 b9 00 00 00    	jne    4b10 <__import_iovec+0x200>
    4a57:	ba 10 00 00 00       	mov    $0x10,%edx
    4a5c:	48 89 df             	mov    %rbx,%rdi
    4a5f:	e8 00 00 00 00       	call   4a64 <__import_iovec+0x154>	4a60: R_X86_64_PLT32	_copy_from_user-0x4
    4a64:	48 85 c0             	test   %rax,%rax
    4a67:	0f 85 4b ff ff ff    	jne    49b8 <__import_iovec+0xa8>
    4a6d:	48 8b 43 08          	mov    0x8(%rbx),%rax
    4a71:	48 85 c0             	test   %rax,%rax
    4a74:	0f 88 d1 00 00 00    	js     4b4b <__import_iovec+0x23b>
    4a7a:	48 ba 00 f0 ff ff ff 7f 00 00 	movabs $0x7ffffffff000,%rdx
    4a84:	48 8b 0b             	mov    (%rbx),%rcx
    4a87:	48 29 c2             	sub    %rax,%rdx
    4a8a:	48 3d 00 f0 ff 7f    	cmp    $0x7ffff000,%rax
    4a90:	76 0f                	jbe    4aa1 <__import_iovec+0x191>
    4a92:	48 ba 00 00 00 80 ff 7f 00 00 	movabs $0x7fff80000000,%rdx
    4a9c:	b8 00 f0 ff 7f       	mov    $0x7ffff000,%eax
    4aa1:	48 39 ca             	cmp    %rcx,%rdx
    4aa4:	0f 82 0e ff ff ff    	jb     49b8 <__import_iovec+0xa8>
    4aaa:	41 83 fd 01          	cmp    $0x1,%r13d
    4aae:	0f 87 aa 00 00 00    	ja     4b5e <__import_iovec+0x24e>
    4ab4:	45 85 ed             	test   %r13d,%r13d
    4ab7:	49 c7 06 00 00 00 00 	movq   $0x0,(%r14)
    4abe:	49 89 46 18          	mov    %rax,0x18(%r14)
    4ac2:	49 89 4e 10          	mov    %rcx,0x10(%r14)
    4ac6:	49 c7 46 08 00 00 00 00 	movq   $0x0,0x8(%r14)
    4ace:	41 c6 06 05          	movb   $0x5,(%r14)
    4ad2:	41 c6 46 03 01       	movb   $0x1,0x3(%r14)
    4ad7:	49 c7 46 20 01 00 00 00 	movq   $0x1,0x20(%r14)
    4adf:	41 0f 95 46 02       	setne  0x2(%r14)
    4ae4:	48 c7 45 00 00 00 00 00 	movq   $0x0,0x0(%rbp)
    4aec:	49 8b 4e 18          	mov    0x18(%r14),%rcx
    4af0:	5b                   	pop    %rbx
    4af1:	5d                   	pop    %rbp
    4af2:	48 89 c8             	mov    %rcx,%rax
    4af5:	41 5c                	pop    %r12
    4af7:	41 5d                	pop    %r13
    4af9:	41 5e                	pop    %r14
    4afb:	c3                   	ret    
    4afc:	48 c7 c1 ea ff ff ff 	mov    $0xffffffffffffffea,%rcx
    4b03:	48 c7 45 00 00 00 00 00 	movq   $0x0,0x0(%rbp)
    4b0b:	e9 af fe ff ff       	jmp    49bf <__import_iovec+0xaf>
    4b10:	48 b8 f8 ef ff ff ff 7f 00 00 	movabs $0x7fffffffeff8,%rax
    4b1a:	48 39 f0             	cmp    %rsi,%rax
    4b1d:	0f 82 95 fe ff ff    	jb     49b8 <__import_iovec+0xa8>
    4b23:	90                   	nop
    4b24:	90                   	nop
    4b25:	90                   	nop
    4b26:	90                   	nop
    4b27:	90                   	nop
    4b28:	90                   	nop
    4b29:	ba 01 00 00 00       	mov    $0x1,%edx
    4b2e:	48 89 df             	mov    %rbx,%rdi
    4b31:	e8 fa bb ff ff       	call   730 <copy_compat_iovec_from_user.part.0>
    4b36:	48 63 c8             	movslq %eax,%rcx
    4b39:	48 85 c9             	test   %rcx,%rcx
    4b3c:	0f 85 7d fe ff ff    	jne    49bf <__import_iovec+0xaf>
    4b42:	48 8b 43 08          	mov    0x8(%rbx),%rax
    4b46:	e9 2f ff ff ff       	jmp    4a7a <__import_iovec+0x16a>
    4b4b:	48 c7 c1 ea ff ff ff 	mov    $0xffffffffffffffea,%rcx
    4b52:	e9 68 fe ff ff       	jmp    49bf <__import_iovec+0xaf>
    4b57:	0f 0b                	ud2    
    4b59:	e9 9a fe ff ff       	jmp    49f8 <__import_iovec+0xe8>
    4b5e:	0f 0b                	ud2    
    4b60:	e9 4f ff ff ff       	jmp    4ab4 <__import_iovec+0x1a4>
    4b65:	66 66 2e 0f 1f 84 00 00 00 00 00 	data16 cs nopw 0x0(%rax,%rax,1)

-- 
Josh
