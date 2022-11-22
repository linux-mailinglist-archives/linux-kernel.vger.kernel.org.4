Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27716336DF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbiKVIRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbiKVIRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:17:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678DE2DE8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lIi8jGVlGgg3eoghMdWB24FsEaTDuVeoT2XtEbvFFeA=; b=Uv9mfyPjPFdm8yWdptqC184WOl
        fBactgl0mrx1SaquuJNxkFOnHP7tE1LR9UjwbxaVwYFGO7Tr578XbCJOisROXMG6bcXHOIfTYXqU4
        zgslwlWRHuiRwRSKTC28l6xGPdiv1b0l7U62AzwvEIwZDzs0xPh/9O0qEX/r7Yrg/IxaoP6Wp8rt/
        QYHlmdkiBM0eZ6lfRzTNefSYUJNoC19UJO1VBuh6lTs9QQH7MrJHRSS4moM5pQbIxwKC8McwAlhF7
        hqOIbg1wKYKq4wbFYt/i5zLRcu01y53c1I4hnluvc1E5szdPR/eCr85q4K/BkC5wdoGFvQRyKav6P
        KB9iO0vQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxOT8-0066XW-Rb; Tue, 22 Nov 2022 08:17:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F0FC5300282;
        Tue, 22 Nov 2022 09:17:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CF1832D65BCD9; Tue, 22 Nov 2022 09:17:18 +0100 (CET)
Date:   Tue, 22 Nov 2022 09:17:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] x86: suppress KMSAN reports in arch_within_stack_frames()
Message-ID: <Y3yFjm98nqQEsnVN@hirez.programming.kicks-ass.net>
References: <20221118172305.3321253-1-glider@google.com>
 <Y3tRgGUKCxUoLeM8@hirez.programming.kicks-ass.net>
 <CAG_fn=Wpy8KA0cLBHapd7BdtnPHsRTpYip+z9TjfB1aUHUGH3g@mail.gmail.com>
 <Y3tjJPtzyi9PD9VD@hirez.programming.kicks-ass.net>
 <CAG_fn=WMivfVzE35=LH5y1OeO=_FvnfRkybvE15EaOL2yH0y0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=WMivfVzE35=LH5y1OeO=_FvnfRkybvE15EaOL2yH0y0g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 03:27:49PM +0100, Alexander Potapenko wrote:

> In other words, for normal instrumentation:
>  - locals are explicitly marked as uninitialized;
>  - shadow values are calculated for arithmetic operations based on their inputs;
>  - shadow values are checked for branches, pointer dereferences, and
> before passing them as function arguments;
>  - memory stores update shadow for affected variables.
> 
> For __no_kmsan_checks:
>  - locals are explicitly marked as initialized;
>  - no instrumentation is added for arithmetic operations, branches,
> pointer dereferences;
>  - all function arguments are marked as initialized;
>  - stores always mark memory as initialized.
> 
> For __no_sanitize_memory:
>  - no instrumentation for locals (they may end up being initialized or
> uninitialized - doesn't matter, because their shadow values are never
> used);
>  - no instrumentation for arithmetic operations, branches, pointer dereferences;
>  - no instrumentation for function calls (an instrumented function
> will receive garbage shadow values from a non-instrumented one);
>  - no instrumentation for stores (initialization done in these
> functions is invisible).

Thanks! That is a great summary.
