Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BD7609BBA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiJXHnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiJXHnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:43:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEF261D69
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 00:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+551nFdjjNaKRc+YIKdcJO5CC2i49qM0eCgIvtnclt4=; b=vXs4iumQwL9vOvLZ8n4ahUE/gE
        EKbIJp2yUJD/zPchHVRDlqTebA5NXnpDa1G0EM+HrHCG0dhbuqar3EzxY2+YPVGGuef1PXLziHFch
        cNtEC0yEti2lp0rUXo6vC2efmfzwj8asQQ/hhAJEoCwJqzS2BkZESzPjfjXLJTkeczcneWiTjXCxz
        u7MeQ6hrQafOrNFpmPkpqhNdZe73lUsDDfU6z5BM6ysSnmKkTgumNJ4+Gpm7h21PzGgUTchfTwkMh
        gvm5IyBRMes9RGXRFhgpIg5nNiPSllTZsNNjuoeJuDrCi21f3kTtxYBZ/IuoXs71aFjTL7nD6dYfk
        s5Ppn7hQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oms6Z-00FG4i-Si; Mon, 24 Oct 2022 07:42:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 81579300445;
        Mon, 24 Oct 2022 09:42:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6219D2C2328BB; Mon, 24 Oct 2022 09:42:33 +0200 (CEST)
Date:   Mon, 24 Oct 2022 09:42:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Will Deacon <will@kernel.org>, x86@kernel.org, willy@infradead.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        jroedel@suse.de, ubizjak@gmail.com
Subject: Re: [PATCH 07/13] mm/gup: Fix the lockless PMD access
Message-ID: <Y1ZB6QeuzIk0W9m6@hirez.programming.kicks-ass.net>
References: <20221022111403.531902164@infradead.org>
 <20221022114424.906110403@infradead.org>
 <796cff9b-8eb8-8c53-9127-318d30618952@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <796cff9b-8eb8-8c53-9127-318d30618952@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 05:42:18PM -0700, Hugh Dickins wrote:
> On Sat, 22 Oct 2022, Peter Zijlstra wrote:
> 
> > On architectures where the PTE/PMD is larger than the native word size
> > (i386-PAE for example), READ_ONCE() can do the wrong thing. Use
> > pmdp_get_lockless() just like we use ptep_get_lockless().
> 
> I thought that was something Will Deacon put a lot of effort
> into handling around 5.8 and 5.9: see "strong prevailing wind" in
> include/asm-generic/rwonce.h, formerly in include/linux/compiler.h.
> 
> Was it too optimistic?  Did the wind drop?
> 
> I'm interested in the answer, but I've certainly no objection
> to making this all more obviously robust - thanks.

READ_ONCE() can't do what the hardware can't do. There is absolutely no
way i386 can do an atomic 64bit load without resorting to cmpxchg8b.

Also see the comment that goes with compiletime_assert_rwonce_type(). It
explicitly allows 64bit because there's just too much stuff that does
that (and there's actually 32bit hardware that *can* do it).

But it's still very wrong.
