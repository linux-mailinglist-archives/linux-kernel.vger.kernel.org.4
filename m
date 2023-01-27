Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08ED67F23C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 00:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjA0X1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 18:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjA0X12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 18:27:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEDA8242F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 15:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Vihkrb/8ANYH1iNq91cTcIbYX7mO3m/5JUyTib5RU5Y=; b=ZpNA9pM7rggKdAVK5gNlhc+sqr
        01/yb2KQYHe6I0NkLIx6BEvNI8ay8afAm7heB8PJvmd95lyUpT/T0QijDh0j6UxOkdP6aXbKlXUL4
        PzR+wk6qMZKvfPA0cZVX2jLjNnOz+pJlrxw3cfiFLJS5MjzL/AhhdAujmZu+BWxTaLFQ4VsFS5Wfc
        CQKJ4gesuFMUJC03n5N6MeeoXRdYZbEsx+/bHN5Tx16+41owCj6ekkrhHuZJ5S2xXlBUtA5XYqtZh
        EeFR5zlhwHlFQnn2Wx0v/cuyb8DUliBuurHPCmE5mhYJpg4ym3huRP1QyGuSBpgiwrlwo/j/+s+Xl
        2Vqh0F0g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLY6t-0088UT-Lz; Fri, 27 Jan 2023 23:26:19 +0000
Date:   Fri, 27 Jan 2023 23:26:19 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 00/33] Per-VMA locks
Message-ID: <Y9Rdmy5h2F1z5yR3@casper.infradead.org>
References: <20230127194110.533103-1-surenb@google.com>
 <20230127145138.8cc44bf00ebf289dffec0975@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230127145138.8cc44bf00ebf289dffec0975@linux-foundation.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 02:51:38PM -0800, Andrew Morton wrote:
> On Fri, 27 Jan 2023 11:40:37 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> 
> > Per-vma locks idea that was discussed during SPF [1] discussion at LSF/MM
> > last year [2], which concluded with suggestion that “a reader/writer
> > semaphore could be put into the VMA itself; that would have the effect of
> > using the VMA as a sort of range lock. There would still be contention at
> > the VMA level, but it would be an improvement.” This patchset implements
> > this suggested approach.
> 
> I think I'll await reviewer/tester input for a while.
> 
> > The patchset implements per-VMA locking only for anonymous pages which
> > are not in swap and avoids userfaultfs as their implementation is more
> > complex. Additional support for file-back page faults, swapped and user
> > pages can be added incrementally.
> 
> This is a significant risk.  How can we be confident that these as yet
> unimplemented parts are implementable and that the result will be good?

They don't need to be implementable for this patchset to be evaluated
on its own terms.  This patchset improves scalability for anon pages
without making file/swap/uffd pages worse (or if it does, I haven't
seen the benchmarks to prove it).

That said, I'm confident that I have a good handle on how to make
file-backed page faults work under RCU.
