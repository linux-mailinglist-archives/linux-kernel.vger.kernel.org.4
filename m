Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4583566E699
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjAQTKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbjAQTHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:07:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F695A371
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=unmKUMBNwOXHvAndehV7v/2JxDCOLUZsRo+qdzYFj6A=; b=n0jfxOM3FQiFZJqzalSvUFm+hO
        ZhdQcBgFrC4WuybQ7vqhCBQ5vnriNnOBC/Wf/3VU4G/PLdgtCKjQ8p8fJlwFrxjFnucdKs2jBoOh6
        +8khK/X161uXMNtiyqPYR7y12+s5aXi2Cuo4kyY+2/meTLEenKUBekl05VIcOKI4jwPy4cVLAgBo+
        sdt5uFvqPtGv/w9QX6Pn0BUf09bGuLbg4lQK8E7xz8jjhimia8STgLuXB5yqUj3Avpzqc0b2W5ILV
        nj1xiC7F/2/+yi9kHLyVI88rH2A6PRWQFt+apqQLA81gb9d03HuPEEQYwEe4x/OfxXtjUrghi9gR4
        nabVIXkw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHqaT-009u5G-JV; Tue, 17 Jan 2023 18:21:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B0A9E30030F;
        Tue, 17 Jan 2023 19:21:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 98FCC210FFF6D; Tue, 17 Jan 2023 19:21:18 +0100 (CET)
Date:   Tue, 17 Jan 2023 19:21:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
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
        Ashok Raj <ashok.raj@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        ndesaulniers@google.com, joao@overdrivepizza.com
Subject: Re: [PATCHv14 08/17] x86/mm: Reduce untagged_addr() overhead until
 the first LAM user
Message-ID: <Y8bnHnLe2a+vzHDd@hirez.programming.kicks-ass.net>
References: <20230111123736.20025-1-kirill.shutemov@linux.intel.com>
 <20230111123736.20025-9-kirill.shutemov@linux.intel.com>
 <Y8adEg2CYUSVpwtk@hirez.programming.kicks-ass.net>
 <20230117135703.voaumisreld7crfb@box>
 <Y8a4bmCU9wsenvvF@hirez.programming.kicks-ass.net>
 <CAHk-=wiwiA7FdSww9fTg59r5S7G-DZHtzAcq9u5zBJKYXc1agQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiwiA7FdSww9fTg59r5S7G-DZHtzAcq9u5zBJKYXc1agQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 09:18:01AM -0800, Linus Torvalds wrote:

> But maybe even those aren't worth worrying about. At least they do the
> unmasking outside the loop - although then in the case of execve(),
> the string copies themselves are obviously done in a loop anyway.
> 
> Kirill, do you have clear numbers for that static key being a noticeable win?

Numbers would be good; I think this all started as a precaution, but
clearly that's not really working out so well :/
