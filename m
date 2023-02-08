Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9E468F8D6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 21:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjBHU35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 15:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBHU34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 15:29:56 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AF51E9DD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 12:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HwZMJ8KpVMQ/wRTBu670+AYpqfGO89cXpzxKZbFOT4s=; b=l3CVN0W6gRs0IlA0HCGuVk6ZBj
        RMZyD4DGZVlfWEeV8N+pAxUg8dxyE6Amrn6dEy1r+SkoVyKo3e6NR0I4rDEXISj4xizBMJmsvjqol
        BJuZwOsMo1wFhXyC1sQOY72AAJH3kk+VGfg6VDF8YzTsx2ZG5BFdvaquKEW1LUlszdofhR+8Htz4z
        Uj+qXgxWZhreFkDVOCmfTLR5agug+d2s+6MbUfdwKQhXhZ3ACv6B/KrM/SSeOJwfh8e8ahpj/BOTD
        hb45tw9W3WV7zh8suj7J+N4uT/i58JRJLBjhsN8WUzLxME4GUQn6sIZA0yW7+iAC1haZ6xVt19NUt
        bBzpMtWA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pPr3d-007ZyU-19;
        Wed, 08 Feb 2023 20:28:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 285A7300446;
        Wed,  8 Feb 2023 21:29:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0982C20F05D4E; Wed,  8 Feb 2023 21:29:23 +0100 (CET)
Date:   Wed, 8 Feb 2023 21:29:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew.Cooper3@citrix.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        kirill.shutemov@linux.intel.com, jpoimboe@redhat.com
Subject: Re: [PATCH v3 3/4] x86/alternative: Rewrite optimize_nops() some
Message-ID: <Y+QGIiOupDKxlKKR@hirez.programming.kicks-ass.net>
References: <20230208171050.490809180@infradead.org>
 <20230208171431.373412974@infradead.org>
 <f0b54521-26cf-ed38-d805-3a8eef3b3103@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0b54521-26cf-ed38-d805-3a8eef3b3103@citrix.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 07:52:04PM +0000, Andrew.Cooper3@citrix.com wrote:
> On 08/02/2023 5:10 pm, Peter Zijlstra wrote:
> > This rewrite address two issues:
> >
> >  - it no longer hard requires single byte nop runs, it now accepts
> >    any NOP and NOPL encoded instruction (but not the more complicated
> >    32bit NOPs).
> >
> >  - it writes a single 'instruction' replacement.
> >
> > Specifically, ORC unwinder relies on the tail NOP of an alternative to
> > be a single instruction, in particular it relies on the inner bytes
> > not being executed.
> >
> > Once we reach the max supported NOP length (currently 8, could easily
> > be extended to 11 on x86_64), switches to JMP.d8 and INT3 padding to
> > achieve the same result.
> >
> > The ORC unwinder uses this guarantee in the analysis of
> > alternative/overlapping CFI state,
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> How lucky are you feeling for your game of performance roulette?

Yeah, not very lucky.. I've been talking about this with Boris for a bit
already.

> Unconditional jmps cost branch prediction these days, and won't be
> successfully predicted until taken.

IKR, insane, but that's what it is.

> There is a point after which a jmp is more efficient that brute forcing
> through a line of nops, and where this point is is very uarch specific,
> but it's not a single nop...

Yeah, I know, even very big nops. $I prefetch is good at straight lines
etc..

> Whether you care or not is a different matter, but at least be aware
> doing a jmp like this instead of e.g. 2 or 3 nops, is contrary to the
> prior advice given by the architects.

So, it is either this, or make the CFI conflict analysis done by objtool
a lot more 'interesting'. I figured I'd try this first.

As is this is actually a correctness issue, not a performance issue.
Goes hand in hand with the patches:

  https://lkml.kernel.org/r/20230208172245.711471461@infradead.org
  https://lkml.kernel.org/r/20230208172245.783099843@infradead.org

Specifically, for short alternatives objtool adds a single nop of
size difference size at the end. The advantage is that you only get one
CFI entry for that thing and so don't have potential conflict for any of
the inner bytes.

The alternative is making it multiple NOPs and ensuring objtool and the
kernel both agree on the length of them.

As is, there were only a hand full of NOPs that turned into this jmp.d8
thing on the defconfig+kvm_guest.config I build to test this -- it is by
no means a common thing. And about half of them would be gone by
extending the max nop length to at least 10 or so.

In fact, I did that patch once, lemme see if I still have it...
