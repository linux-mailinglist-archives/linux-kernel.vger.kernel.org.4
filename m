Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7B869992C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 16:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjBPPpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 10:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjBPPpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 10:45:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546621BD8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 07:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vKirnekWaY/7YPqBImOqS8So3dx7/6DOy0i+rRDyZWU=; b=v4Efi6nPZA8YmfeKqb5WLenlFD
        0k/p7dZ0EdA4YcHjqljvXqOOGSthJzq++39zRp6/q2Fu4rML04k+dAt34kXAqraSx5+SMXuzcqQsy
        UqRfvsgKz+ns+xawbSRrvEqH2FL8wQw/a2euo4DuP0kKao3/m6HUeqG2HOLFnEz+essxCs3IK9fMo
        uXzSIf1j9gWIzAaDkTPeMbpnqt2dAqsOp5NQ2VRixq/5jMSgTzhQAV/Ozc5SeckJizTH65WZjobHc
        GsL2aTYFqint8RVP1arhPmGAA0U8cD3Uk++dP8hyMS3q3LIFjgWduyiTqRr6+sS5D3YudYdBxBLRG
        3NhSq/pQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSgRD-008WXZ-IG; Thu, 16 Feb 2023 15:44:47 +0000
Date:   Thu, 16 Feb 2023 15:44:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 26/35] mm: fall back to mmap_lock if vma->anon_vma is
 not yet set
Message-ID: <Y+5Pb4hGmV1YtNQp@casper.infradead.org>
References: <20230216051750.3125598-1-surenb@google.com>
 <20230216051750.3125598-27-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216051750.3125598-27-surenb@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 09:17:41PM -0800, Suren Baghdasaryan wrote:
> When vma->anon_vma is not set, page fault handler will set it by either
> reusing anon_vma of an adjacent VMA if VMAs are compatible or by
> allocating a new one. find_mergeable_anon_vma() walks VMA tree to find
> a compatible adjacent VMA and that requires not only the faulting VMA
> to be stable but also the tree structure and other VMAs inside that tree.
> Therefore locking just the faulting VMA is not enough for this search.
> Fall back to taking mmap_lock when vma->anon_vma is not set. This
> situation happens only on the first page fault and should not affect
> overall performance.

I think I asked this before, but don't remember getting an aswer.
Why do we defer setting anon_vma to the first fault?  Why don't we
set it up at mmap time?
