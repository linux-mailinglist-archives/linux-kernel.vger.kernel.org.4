Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0F0609548
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 19:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiJWRzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 13:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiJWRzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 13:55:11 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35E2B31EDD
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 10:55:07 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 1094C92009C; Sun, 23 Oct 2022 19:55:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 0010B92009B;
        Sun, 23 Oct 2022 18:55:04 +0100 (BST)
Date:   Sun, 23 Oct 2022 18:55:04 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v14 08/14] mm: multi-gen LRU: support page table walks
In-Reply-To: <CAHk-=wjrpH1+6cQQjTO6p-96ndBMiOnNH098vhS2jLybxD+7gA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2210211911390.50489@angie.orcam.me.uk>
References: <20220815071332.627393-1-yuzhao@google.com> <20220815071332.627393-9-yuzhao@google.com> <Y0go8wWtdcyH1+Ch@hirez.programming.kicks-ass.net> <CAOUHufa9+FTO3Pv-5jC-e3S5goPsUGu-5KcPVHa4bWb0X+d2ug@mail.gmail.com> <CAHk-=wj1rc2t5noMtVOgu8XXeTM4KiggEub9PdcexxeQrYPZvA@mail.gmail.com>
 <Y1FXpHdyvXjrjbLw@hirez.programming.kicks-ass.net> <CAHk-=whQchubuDpRGFabhmcZuzdt13OOF8wznXb+Dbi3GzBQhQ@mail.gmail.com> <Y1GZjPO+szk7X0wP@hirez.programming.kicks-ass.net> <CAHk-=wikUaRM5H_y1Bc+QyvGi40dKDL8fnCTyz7ECbwK7aHNPQ@mail.gmail.com>
 <Y1IUMDJFScAMrCS5@casper.infradead.org> <CAHk-=wjrpH1+6cQQjTO6p-96ndBMiOnNH098vhS2jLybxD+7gA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2022, Linus Torvalds wrote:

> > > We got rid of i386 support back in 2012. Maybe it's time to get rid of
> > > i486 support in 2022?
> >
> > Arnd suggested removing i486 last year and got a bit of pushback.
> > The most convincing to my mind was Maciej:
> 
> Hmm. Maciej added to the cc.

 Thanks!

> So I *really* don't think i486 class hardware is relevant any more.
> Yes, I'm sure it exists (Maciej being an example), but from a kernel
> development standpoint I don't think they are really relevant.
> 
> At some point, people have them as museum pieces. They might as well
> run museum kernels.
> 
> Moving up to requiring cmpxchg8b doesn't sound unreasonable to me.

 But is it really a problem?  I mean unlike MIPS R2000/R3000 class gear 
that has no atomics at all at the CPU level (SMP R3000 machines did exist 
and necessarily had atomics, actually via gating storage implemented by 
board hardware in systems we have never had support for even for UP) we 
have had atomics in x86 since forever.  Just not 64-bit ones.

 Given the presence of generic atomics we can emulate CMPXCHG8B easily 
LL/SC-style using a spinlock with XCHG even on SMP let alone UP.  So all 
the kernel code can just assume the presence of CMPXCHG8B, but any 
invocations of CMPXCHG8B would be diverted to the emulation, perhaps even 
at the assembly level via a GAS macro called `cmpxchg8b' (why not?).  All 
the maintenance burden is then shifted to that macro and said emulation 
code.

 Proof of concept wrapper:

#define LOCK_PREFIX ""

#define CC_SET(c) "\n\t/* output condition code " #c "*/\n"
#define CC_OUT(c) "=@cc" #c

#define unlikely(x) __builtin_expect(!!(x), 0)

__extension__ typedef unsigned long long __u64;
typedef unsigned int __u32;
typedef __u64 u64;
typedef __u32 u32;

typedef _Bool bool;

__asm__(
	".macro		cmpxchg8b arg\n\t"
	"pushl		%eax\n\t"
	"leal		\\arg, %eax\n\t"
	"xchgl		%eax, (%esp)\n\t"
	"call		cmpxchg8b_emu\n\t"
	".endm\n\t");

bool __try_cmpxchg64(volatile u64 *ptr, u64 *pold, u64 new)
{
	bool success;
	u64 old = *pold;
	asm volatile(LOCK_PREFIX "cmpxchg8b %[ptr]"
		     CC_SET(z)
		     : CC_OUT(z) (success),
		       [ptr] "+m" (*ptr),
		       "+A" (old)
		     : "b" ((u32)new),
		       "c" ((u32)(new >> 32))
		     : "memory");

	if (unlikely(!success))
		*pold = old;
	return success;
}

This assembles to:

cmpxchg8b.o:     file format elf32-i386

Disassembly of section .text:

00000000 <__try_cmpxchg64>:
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	89 d7                	mov    %edx,%edi
   7:	53                   	push   %ebx
   8:	89 c6                	mov    %eax,%esi
   a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
   d:	8b 02                	mov    (%edx),%eax
   f:	8b 5d 08             	mov    0x8(%ebp),%ebx
  12:	8b 52 04             	mov    0x4(%edx),%edx
  15:	50                   	push   %eax
  16:	8d 06                	lea    (%esi),%eax
  18:	87 04 24             	xchg   %eax,(%esp)
  1b:	e8 fc ff ff ff       	call   1c <__try_cmpxchg64+0x1c>
			1c: R_386_PC32	cmpxchg8b_emu
  20:	0f 94 c1             	sete   %cl
  23:	75 0b                	jne    30 <__try_cmpxchg64+0x30>
  25:	5b                   	pop    %ebx
  26:	88 c8                	mov    %cl,%al
  28:	5e                   	pop    %esi
  29:	5f                   	pop    %edi
  2a:	5d                   	pop    %ebp
  2b:	c3                   	ret    
  2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  30:	5b                   	pop    %ebx
  31:	89 07                	mov    %eax,(%edi)
  33:	5e                   	pop    %esi
  34:	89 57 04             	mov    %edx,0x4(%edi)
  37:	5f                   	pop    %edi
  38:	88 c8                	mov    %cl,%al
  3a:	5d                   	pop    %ebp
  3b:	c3                   	ret    

Of course there's a minor ABI nit for `cmpxchg8b_emu' to return a result 
in ZF and the wrapper relies on CONFIG_FRAME_POINTER for correct `arg' 
evaluation in all cases.  But that shouldn't be a big deal, should it?

 Then long-term maintenance would be minimal to nil and all the code 
except for the wrapper and the emulation handler need not be concerned 
about the 486 obscurity.  I can volunteer to maintain said wrapper and 
emulation (and for that matter generic 486 support) if that helped to keep 
the 486 alive.

 Eventually we may choose to drop 486 support after all, but CMPXCHG8B 
alone seems too small a reason to me for that to happen right now.

 NB MIPS R2000 dates back to 1985, solid 4 years before the 486, and we 
continue supporting it with minimal effort.  We do have atomic emulation 
for userland of course.

  Maciej
