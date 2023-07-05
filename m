Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09AE748FB8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 23:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjGEV3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 17:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbjGEV3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 17:29:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4710519B2;
        Wed,  5 Jul 2023 14:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cgSmgMJRLpJHBRFXoz8XxIGxxvj9mwwGxUoWKCRz164=; b=JQSE5WDOUg+gd658BVvKQIfUJx
        7+D9YjlvW/5ZdTkkdlgIZC9IGZPyKyRHXjjOb8q/jh5PmElpP+i3F9XT41LmI11uzY1s8TvsrVSrm
        z3uM3r5sbTJ4cM5ZRnNkkZGx6v0W/gRkeUqED2U7YOs9tImfsNX54mawLDAXpsjDTSzXdKv8Z/x7m
        2xLdDpqpRys0F5YliCsoIA51JpPo1NBbtwuHvv+Y7tGGarmBBGMA1XN+U3b/kWOZLCdLZrgHoBr2F
        JHYxA6l//VaGn4uU7dk2N2KmByd3hmLW/vFq2OqrXzxTyJpGMFQAiqi4pL5gDbK074CzFLXzMgcFu
        0v6eLb1g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qHA2W-00ARLH-7a; Wed, 05 Jul 2023 21:27:56 +0000
Date:   Wed, 5 Jul 2023 22:27:56 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        David Hildenbrand <david@redhat.com>,
        akpm@linux-foundation.org, jirislaby@kernel.org,
        jacobly.alt@gmail.com, holger@applied-asynchrony.com,
        hdegoede@redhat.com, michel@lespinasse.org, jglisse@google.com,
        mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
        liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        chriscli@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, rppt@kernel.org, jannh@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mm: disable CONFIG_PER_VMA_LOCK until its fixed
Message-ID: <ZKXgXFfrBzUjfkDN@casper.infradead.org>
References: <20230705171213.2843068-1-surenb@google.com>
 <20230705171213.2843068-3-surenb@google.com>
 <3cdaa7d4-1293-3806-05ce-6b7fc4382458@redhat.com>
 <CAJuCfpGTNF9BWBxZoqYKSDrtq=iJoN1n8oTc=Yu0pPzW8cs8rQ@mail.gmail.com>
 <ZKXRsQC8ufiebDGu@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKXRsQC8ufiebDGu@x1n>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 04:25:21PM -0400, Peter Xu wrote:
> There'll still try to be a final fix, am I right?  As IIRC allowing page
> faults during fork() is one of the major goals of vma lock.

Good grief, no.  Why would we want to optimise something that happens
so rarely?  The goal is, as usual, more performance.  Satisfying page
faults while mmap()/munmap()/mprotect() are happening is worthwhile.
Those happen a lot more than fork().

In this case though, there's also a priority-inversion problem that
we're trying to solve where process A (high priority) calls mmap() while
process B (low priority) is reading /proc/$pid/smaps and now (because
rwsems are fair), none of process A's other threads can satisy any page
faults until process B is scheduled.

Where on earth did you get the idea that we cared even a little bit
about the performance of page fault during fork()?
