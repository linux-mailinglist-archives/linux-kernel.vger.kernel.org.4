Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1624746CAA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 11:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjGDJDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 05:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjGDJDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:03:20 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90470B3
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 02:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kN6YUmS95mMDX3jHzaNULXV86Y606o/iK0bsX45n37Y=; b=iQ8yUBUMLe40M2ZI9ZX7+Xrt0q
        rCQZbjtg0BcFwtbQqSrG3gFdHODPl8QifouWj5f3R3IYJV5wSc3F8Hk1fVdcRfMhBm1Jsd8ERZEhR
        XKhlWaXTn0P0+bnZhjpJaaKekHEr5PgctSr3oiBis0pjGa4ANz1s7cMc/GCXRwpOvdGHwZ7vDn9Sz
        VF+IPKiUzryZgyEi9HkchwAdes6RBMSMg0mzWmW2FFuGz9NkwkLkzAjWpeEKsSchvbyJfeHCTXPpO
        m2sTX+mHLWRsy5m4Sv1LnzzuqxYcuztWiuESCiQqC4krF4h0o0tHzsnlcAr+E5QURp1ia/T2X7BRA
        LK33Lj2g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qGbuf-00AonD-2s;
        Tue, 04 Jul 2023 09:03:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E3E293001E7;
        Tue,  4 Jul 2023 11:01:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CC14A2028FBD7; Tue,  4 Jul 2023 11:01:32 +0200 (CEST)
Date:   Tue, 4 Jul 2023 11:01:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>,
        Kishon VijayAbraham <Kishon.VijayAbraham@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/barrier: Do not serialize MSR accesses on AMD
Message-ID: <20230704090132.GP4253@hirez.programming.kicks-ass.net>
References: <20230622095212.20940-1-bp@alien8.de>
 <20230703125419.GJ4253@hirez.programming.kicks-ass.net>
 <20230704074631.GAZKPOV/9BfqP0aU8v@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704074631.GAZKPOV/9BfqP0aU8v@fat_crate.local>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 09:46:31AM +0200, Borislav Petkov wrote:
> On Mon, Jul 03, 2023 at 02:54:19PM +0200, Peter Zijlstra wrote:
> > So you're saying that AMD tsc_deadline and x2apic MSRs *do* imply
> > ordering constraints unlike the Intel ones?
> 
> Yah, that's the default situation. Only those two - TSC_DEADLINE and
> x2APIC MSRs - and on *Intel* are special.

So they are normal MSRs like all other? AMD doesn't have any exceptions
for MSRs, they all the same?

> > Both instructions are 3 bytes, a 6 byte nop would be better, no?
> 
> Why? You wanna save the branch insn when sending IPIs through the
> x2APIC? Does that really matter? I doubt it...

Dunno, code density, speculation, many raisons to avoid jumps :-)

> > 	asm volatile (ALTERNATIVE("mfence; lfence;", "", X86_FEATURE_AMD));
> 
> There's no X86_FEATURE_AMD :)

I know, but that's easily fixed.
