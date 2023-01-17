Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F8A66DE5D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236943AbjAQNFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236788AbjAQNFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:05:50 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F1930EA3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 05:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jme9zz2lpphQFdQzWSwDey8PeXCFcOvKT0bkE6Mbk38=; b=Ba3guL0BWUgd+jP/llCnOAhXLF
        Hnv6WeFYTdqcpMKQlUG9YGrc0FO1Bv3t7ux7SiCcujeC1p1NOV6VZ0bNJpfJ7wT/j62DCMuGfUNFD
        RvkZjmcqXsXp5GGw/QCeOt+zQia8tysEgFE7TZQxtwXbqJp0F5I2HmEVxEuQdtdyX4DNpzrRHXCl7
        /CV2MTTSradvHELrV5oyiE2gadTyfn5NJiN3qbNHX0RzEqMh3z9BJFkQj3uqk/MFkolkUQ9TysK3+
        E64xzeM9j+54aHPwWsl41/OSc3ueHtPADUWus2j2m5f4zJe06yEMjdZfZs2t3IQqHReZRwPLFdNSx
        sJqMYJIA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pHleN-005wDX-0T;
        Tue, 17 Jan 2023 13:05:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A6581300094;
        Tue, 17 Jan 2023 14:05:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7A24B264FC770; Tue, 17 Jan 2023 14:05:22 +0100 (CET)
Date:   Tue, 17 Jan 2023 14:05:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
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
        Ashok Raj <ashok.raj@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv14 08/17] x86/mm: Reduce untagged_addr() overhead until
 the first LAM user
Message-ID: <Y8adEg2CYUSVpwtk@hirez.programming.kicks-ass.net>
References: <20230111123736.20025-1-kirill.shutemov@linux.intel.com>
 <20230111123736.20025-9-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111123736.20025-9-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 03:37:27PM +0300, Kirill A. Shutemov wrote:

>  #define __untagged_addr(untag_mask, addr)	({			\
>  	u64 __addr = (__force u64)(addr);				\
> -	s64 sign = (s64)__addr >> 63;					\
> -	__addr &= untag_mask | sign;					\
> +	if (static_branch_likely(&tagged_addr_key)) {			\
> +		s64 sign = (s64)__addr >> 63;				\
> +		__addr &= untag_mask | sign;				\
> +	}								\
>  	(__force __typeof__(addr))__addr;				\
>  })
>  
> #define untagged_addr(addr) __untagged_addr(current_untag_mask(), addr)

Is the compiler clever enough to put the memop inside the branch?
