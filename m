Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5F960F1D2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 10:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbiJ0IG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 04:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbiJ0IGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:06:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED90367B7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 01:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+zECNnKHvQf1A6kHuAwhB50ffkPqGeMPvlWKtaCiAiE=; b=YPLisVZwst9EFxI0gcuUY+NUOK
        NRYAPfyNsuUDhRh2Vc9/2DiifXwycOGdA1g7mRfVdeglLv3Ck3LYNb45dW0S1PjHpT1kTmAwaFD8a
        dmTJcENucPuyQ4gwgGt6ALvgRQm21WR7yjhtH7REW4fASRpkZMaXAPciocqgVAnijJXl0o+eLNm6T
        55UQYf15xXrcXSr6Edj2x+eutqAK3aMV8lEVqcCeZz2oQiFNJFbI6upWpMIV3+Gww+qlob+XR43j9
        doFyX+Kevribl8RQt/zYE8vDgdyPbNikz7Sy7zX5ie6UFIgne6j1TtMvWhCeqB+eTPEcxQul4UC95
        bOKk7gKw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onxth-0002LC-Ff; Thu, 27 Oct 2022 08:05:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3473930029C;
        Thu, 27 Oct 2022 10:05:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1A6DD2012B90F; Thu, 27 Oct 2022 10:05:47 +0200 (CEST)
Date:   Thu, 27 Oct 2022 10:05:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org
Subject: Re: [PATCH] x86/uaccess: instrument copy_from_user_nmi()
Message-ID: <Y1o72704bVK0FgCr@hirez.programming.kicks-ass.net>
References: <20221025221755.3810809-1-glider@google.com>
 <Y1j+Tt9mnMDU0zO+@hirez.programming.kicks-ass.net>
 <CAG_fn=XDeghFBGXT37Mc-ky-8NaPaMmCLdo3Par=xh92Fk_CAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=XDeghFBGXT37Mc-ky-8NaPaMmCLdo3Par=xh92Fk_CAQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 11:38:53AM -0700, Alexander Potapenko wrote:
> A bigger issue from the NMI perspective is probably
> having __msan_poison_alloca() inserted in every non-noinstr kernel
> function, because that hook may acquire the stackdepot lock.

*urgghhh* that's broken, that must not be. There is a *TON* of NMI
functions that are non-noinstr.

What's worse, it seems to do a memory allocation as well, and that's out
the window with PREEMPT_RT where you can't do even GFP_ATOMIC from
regular IRQ context.

That function is wholly unacceptable to be added to every kernel
function.

