Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AF374E7C0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 09:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjGKHQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 03:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjGKHQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 03:16:01 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378B0CE;
        Tue, 11 Jul 2023 00:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D1feG0Fl8Ee5zOZsG9SoHYFaCih6ELEpGN3iRZJVOFg=; b=gDZT9RmLvSO1CvAo1lU3Xb9avP
        wN6Fj+1OypxPuebGwVQuLwC86cK8TdM0Qfe2uEFlAj8tOasF1fbRN55NP0KGuJ7eBbZrT2+tRjfwO
        bUl98gyWzzynSouQLcbY8ST95PAKZZuufV/AaetCK4pfzEOR7+11xFsjiNg1d/PuSMjKR4Bn2LvX/
        PhSRb5jXGsgclFfWntShP/WeATSfFPJg93HLvePV8wlEyYmMtVyj0dNbEi0/dLpQAZDrNn14g8U4H
        uT5jFaViHz5D7kTxelj4zp0z2IYZoK7lQGBdbiMtbxiaAPoWjmOE+JSgcIgIswWJ4N+pMu0oCG1Ov
        Yd8yYyOA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJ7b4-002How-0E;
        Tue, 11 Jul 2023 07:15:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BDBF23002B1;
        Tue, 11 Jul 2023 09:15:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A67B6240EBDA9; Tue, 11 Jul 2023 09:15:40 +0200 (CEST)
Date:   Tue, 11 Jul 2023 09:15:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Petr Pavlu <petr.pavlu@suse.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] x86/kprobes: Prohibit probing on compiler
 generated CFI checking code
Message-ID: <20230711071540.GC3062772@hirez.programming.kicks-ass.net>
References: <168899125356.80889.17967397360941194229.stgit@devnote2>
 <168899127520.80889.15418363018799407058.stgit@devnote2>
 <20230710161643.GB3040258@hirez.programming.kicks-ass.net>
 <20230711085837.fac80c964ea7667cb75bd6e5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711085837.fac80c964ea7667cb75bd6e5@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 08:58:37AM +0900, Masami Hiramatsu wrote:

> > Hmm, so I was thinking something like the below, which also catches
> > things when we rewrite kCFI to FineIBT, except I don't think we care if
> > the FineIBT callsite gets re-written. FineIBT only relies on the __cfi_
> > symbol not getting poked at (which the previous patches should ensure).
> 
> Oh, is FineIBT different from kCFI? I thought those are same. But anyway
> for kCFI=y && FineIBT=n case, I think this code still needed.

Ah, I forgot to answer your other question; FineIBT is dynamically
patched since it relies on optional hardware features, only if the
hardware has IBT support can FineIBT work.

So yeah, your check is definitely needed. And I think it'll 'gracefully'
fail when FineIBT is patched in because the instructions aren't exactly
the same.

And since FineIBT has most of the magic in the __cfi_ prefix, which
isn't patched per the previous patch, I think we're good on the call-site.

> > So I tihnk I'm ok with the above, just adding the below for reference
> > (completely untested and everything).
> 
> I wonder the distance can be used outside of x86. CFI implementation
> depends on the arch?

Currently only arm64 and x86_64 have CFI, and while the particulars are a
little different, they do have a lot in common, including the reporting.
IIRC the arm64 variant is a little simpler because of fixed instruction
size. There is no worry someone will jump in the middle of an
instruction stream.

