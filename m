Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026A56259D6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbiKKLvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbiKKLu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:50:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7D027FDB
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 03:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y/QkBMzgycJwrEssTyDx8CzuoPwVb1Xx/ojdlSWC5vo=; b=mqg2L7iDNqY53KzKxNvNsUtT46
        gP8LYFDW9EPdEB3ez7Q8Tyls7+eez23kgfTzS8YbQEK3A5zCLpHlO6WB8z2I3Un2sqgLb6DzcrjaT
        LOiDjsFRVgL296ZTj4i9r8Nt0M++7rKake+KZBBeuyhgRAayAdfyGpXftu1vlpLk3BATSHG2W4MJC
        YRGKu2w1zIzdkS9ZWRa0P/tfWFhMPRX2XqLNmHRNbeD0QM/pPNBFiUv8ep4kMYeN/Q1nNVLRAFgUz
        O4ooE8VxqxYPnoon9A/kR6j+dZtngi8mQid9eQehJVGiQ5NoJHjtvoZtZNIdXIevJCw94EFDOdCas
        /8JSqd9Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1otSYg-00D12v-L2; Fri, 11 Nov 2022 11:50:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3712D30013F;
        Fri, 11 Nov 2022 12:50:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DF2C220831B8B; Fri, 11 Nov 2022 12:50:47 +0100 (CET)
Date:   Fri, 11 Nov 2022 12:50:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86@kernel.org, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, oliver.sang@intel.com
Subject: Re: [PATCH 1/4] x86/mm: Add a few comments
Message-ID: <Y243F+zR58pO0vCE@hirez.programming.kicks-ass.net>
References: <20221110125253.240704966@infradead.org>
 <20221110125544.460677011@infradead.org>
 <CAHk-=wg8UrshBBLioF0+FaJvAkSTRkH3-aqKT3eAWHtBp57hxw@mail.gmail.com>
 <Y208t7Lw9n+3CNz3@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y208t7Lw9n+3CNz3@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 07:02:31PM +0100, Peter Zijlstra wrote:

> > Do we need any of those alias passes at all for pure protection bit
> > changes? I thought we only did these because things like cacheability
> > bits have to be in sync due to machine checks etc?
> > 
> > Or am I missing some case where writability matters too?
> 
> I _think_, but I'm not actually sure, that it matters in exactly that
> case dhansen mentions, where we do a physical to virtual address
> translation and expect access to match whatever alias we originally came
> from.

That of course only covers the directmap; for giggles I did the below
patch on top of these and the testcase at hand boots and finishes just
fine...

So yeah, no sodding clue why we do that :/

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index f275605892df..c63e6117221a 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1656,7 +1676,7 @@ static int cpa_process_alias(struct cpa_data *cpa)
 			return ret;
 	}
 
-#ifdef CONFIG_X86_64
+#if 0 // def CONFIG_X86_64
 	/*
 	 * If the primary call didn't touch the high mapping already
 	 * and the physical address is inside the kernel map, we need

