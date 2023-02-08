Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE2168F8FD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 21:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjBHUoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 15:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjBHUoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 15:44:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5912202B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 12:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AIHbyBc7GwEccvQkj+vV89TBTcmgQlsZxBPcbursF4I=; b=VVGUyelaHcs9Cpeye9L3GzfxoC
        6+NR6D0hRNA7LRaH/RmFUQbz6egieh9so+lRzPtU8In2ycUTkloc4Bxbdp13LSOt+BAhWTM4wXLLX
        RZBMGegIOCmYD6vzOecuk89F/D9nXzNtNVQ2Uvzm7SG54t80qnum25p2/+L075GPbhMU5HSoD3iSv
        n/v9PffhIk+6EZlDgDvUIKCk0Y1mb0IF2s9zSjrwNKfYbmCbWhh4K56t0WdEohHBpQllbTdDPRXOn
        jk0zgjsRNRwcW7umshyeqOR6scGToTj56CcP6RjVNJs8Pt5zlBLmxws1/cpY7t82cdx3ylPxanBtL
        BiJfGQOw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPrIS-001XBa-FB; Wed, 08 Feb 2023 20:44:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3F500300129;
        Wed,  8 Feb 2023 21:44:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1FE2D2083586E; Wed,  8 Feb 2023 21:44:04 +0100 (CET)
Date:   Wed, 8 Feb 2023 21:44:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew.Cooper3@citrix.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        kirill.shutemov@linux.intel.com, jpoimboe@redhat.com
Subject: Re: [PATCH v3 3/4] x86/alternative: Rewrite optimize_nops() some
Message-ID: <Y+QJlK637EYg/Zst@hirez.programming.kicks-ass.net>
References: <20230208171050.490809180@infradead.org>
 <20230208171431.373412974@infradead.org>
 <f0b54521-26cf-ed38-d805-3a8eef3b3103@citrix.com>
 <Y+QGIiOupDKxlKKR@hirez.programming.kicks-ass.net>
 <Y+QHyF5K5hSN0ziP@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+QHyF5K5hSN0ziP@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 09:36:24PM +0100, Peter Zijlstra wrote:
> On Wed, Feb 08, 2023 at 09:29:23PM +0100, Peter Zijlstra wrote:
> 
> > As is, there were only a hand full of NOPs that turned into this jmp.d8
> > thing on the defconfig+kvm_guest.config I build to test this -- it is by
> > no means a common thing. And about half of them would be gone by
> > extending the max nop length to at least 10 or so.
> > 
> > In fact, I did that patch once, lemme see if I still have it...
> 
> Even still applies too, lemme go test that.

Works as advertised. Next up are 8 12 byte nopes and 8 13 byte nops,
after that we're left with:

[   11.584069] SMP alternatives: ffffffff82000095: [0:20) optimized NOPs: eb 12 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
[   11.588621] SMP alternatives: ffffffff810026dc: [0:44) optimized NOPs: eb 2a cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cccc cc cc cc cc cc cc cc cc
[   11.590068] SMP alternatives: ffffffff820001f3: [0:20) optimized NOPs: eb 12 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
[   11.720069] SMP alternatives: ffffffff8200189f: [0:20) optimized NOPs: eb 12 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
[   11.731069] SMP alternatives: ffffffff820019ae: [0:20) optimized NOPs: eb 12 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
[   11.738069] SMP alternatives: ffffffff82001a4a: [0:20) optimized NOPs: eb 12 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
[   11.746069] SMP alternatives: ffffffff82001b2d: [0:20) optimized NOPs: eb 12 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
[   11.766069] SMP alternatives: ffffffff82001d14: [0:20) optimized NOPs: eb 12 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
[   11.770069] SMP alternatives: ffffffff82001dd5: [0:20) optimized NOPs: eb 12 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
[   11.779069] SMP alternatives: ffffffff82001f35: [0:20) optimized NOPs: eb 12 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc

Which is all pretty big...

GNU as seems to go to .nops 12. 13 gives me a single byte nop and a 12.
That's also exactly the 3 prefix limit, after which some uarchs start
taking heavy decode penalties.

Let me go extend that patch of mine to cover 12. Also, instead of
printing hex addresses, lemme go print symbol+off things.
