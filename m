Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79776650F37
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbiLSPq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbiLSPpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:45:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F42512625
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 07:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kI4Lo2eTc7TViP7CmNTlVP4L2d4aRAIDxWiWnUYFIrU=; b=TG+tRuZcAz321fdSqW97adMUwL
        HIY5nwQZlLSyPYxBtLON/dOfKneHU1UU/qafcRRw+ZTy8prlDqBqUmiRfgx6AY2FB/tnAcXgvRwZB
        yHgk8bbwb5M48UBYbfjELFnhqWC4ZzOS7xcUXm0fKg5WCvr4HsUdp1xoz4AJWAPQHlH2u6dffpnia
        6zb+XnRuQds3i/kR3xpQYuFb3UXMB4hqcCDo4XufEikWVD+UmcNozhGCQKGXp33kdtLW9eApWCqxU
        w1kn2UylJJioSvJavNfPUrpC3hxkYuPII/RnGF8UdlfNxe0EHv+EkXggNHc1SjakcNi9w+7cns9h8
        OTVQ9iFg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7IJo-000r9D-BN; Mon, 19 Dec 2022 15:44:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D8385300193;
        Mon, 19 Dec 2022 16:44:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C82F7201A8ADD; Mon, 19 Dec 2022 16:44:33 +0100 (CET)
Date:   Mon, 19 Dec 2022 16:44:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        willy@infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        jroedel@suse.de
Subject: Re: [PATCH 11/13] x86_64: Remove pointless set_64bit() usage
Message-ID: <Y6CG4e6JteXc8ih5@hirez.programming.kicks-ass.net>
References: <20221022111403.531902164@infradead.org>
 <20221022114425.168036718@infradead.org>
 <Y2QR/BRHjjYUNszh@dev-arch.thelio-3990X>
 <CAFULd4bkn3i0ds1ywhxAZBQH+1O-zbPWscUqjoEcv4xvnxOnSw@mail.gmail.com>
 <Y2QYHZsZNs33NXZB@dev-arch.thelio-3990X>
 <CAHk-=wjCBOwSWec+=h08q3Gbr4UjSfX46GrQjzHZLFokziS7nA@mail.gmail.com>
 <Y2U3WdU61FvYlpUh@hirez.programming.kicks-ass.net>
 <CAHk-=wggJFQJmWtvsFVt69hzRXW3zD5+9q-1Laz=NoZQ8Fy9Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wggJFQJmWtvsFVt69hzRXW3zD5+9q-1Laz=NoZQ8Fy9Ag@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 10:15:08AM -0700, Linus Torvalds wrote:
> On Fri, Nov 4, 2022 at 9:01 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > So cmpxchg_double() does a cmpxchg on a double long value and is
> > currently supported by: i386, x86_64, arm64 and s390.
> >
> > On all those, except i386, two longs are u128.
> >
> > So how about we introduce u128 and cmpxchg128 -- then it directly
> > mirrors the u64 and cmpxchg64 usage we already have. It then also
> > naturally imposses the alignment thing.
> 
> Ack

Out now: https://lkml.kernel.org/r/20221219153525.632521981@infradead.org
