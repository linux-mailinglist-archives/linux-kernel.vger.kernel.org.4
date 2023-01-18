Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFB967114C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 03:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjARCpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 21:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjARCpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 21:45:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DBF4FC14
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MGpdnLSCsy4iJTcYeMqTf0hkShjXgJaZl556rybxYcc=; b=LgtkpNzsFyaJdmFoM4zFTvjFAt
        Ao0YdH63TZt9RuzJ6Jp2atj9NKcViphPYwdS+B9R56VTZ6LdgTBITlFfMh6TzB/XcRGNXjsOOtgu6
        aIPuxzOdZSS0yVjg747/T0PwNU+0/508fiqbDMy2yO/t7mf0IfznrHag7q8RjS5XJVA4VMfqYuwl0
        ulHk6RyXVZHBP8284w9PmU5Ys9jP5MaL1tYqADfmpXKvKQXHiR+iAXVdGRcYnzrfwH8PupJzp9apk
        +hGZy6biK6xGQhULog6BkfaGpEdf2xnt5Y/7Oy5OU1xCO7Ns1R6g+Y5KfUc2AdfpOCbogT6bTwOeC
        bnYjNyHg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHyRY-00AHX7-0B; Wed, 18 Jan 2023 02:44:52 +0000
Date:   Wed, 18 Jan 2023 02:44:51 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        michel@lespinasse.org, jglisse@google.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 28/41] mm: introduce lock_vma_under_rcu to be used from
 arch-specific code
Message-ID: <Y8ddI7vcKw8oecsr@casper.infradead.org>
References: <20230109205336.3665937-1-surenb@google.com>
 <20230109205336.3665937-29-surenb@google.com>
 <Y8bDAVC/aiL9tCyz@dhcp22.suse.cz>
 <CAJuCfpHRRsUMNHp2H3UiB4EZbe9CXTVcAC+oOR1dscENjp1Jbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHRRsUMNHp2H3UiB4EZbe9CXTVcAC+oOR1dscENjp1Jbw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 05:06:57PM -0800, Suren Baghdasaryan wrote:
> On Tue, Jan 17, 2023 at 7:47 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 09-01-23 12:53:23, Suren Baghdasaryan wrote:
> > > Introduce lock_vma_under_rcu function to lookup and lock a VMA during
> > > page fault handling. When VMA is not found, can't be locked or changes
> > > after being locked, the function returns NULL. The lookup is performed
> > > under RCU protection to prevent the found VMA from being destroyed before
> > > the VMA lock is acquired. VMA lock statistics are updated according to
> > > the results.
> > > For now only anonymous VMAs can be searched this way. In other cases the
> > > function returns NULL.
> >
> > Could you describe why only anonymous vmas are handled at this stage and
> > what (roughly) has to be done to support other vmas? lock_vma_under_rcu
> > doesn't seem to have any anonymous vma specific requirements AFAICS.
> 
> TBH I haven't spent too much time looking into file-backed page faults
> yet but a couple of tasks I can think of are:
> - Ensure that all vma->vm_ops->fault() handlers do not rely on
> mmap_lock being read-locked;

I think this way lies madness.  There are just too many device drivers
that implement ->fault.  My plan is to call the ->map_pages() method
under RCU without even read-locking the VMA.  If that doesn't satisfy
the fault, then drop all the way back to taking the mmap_sem for read
before calling into ->fault.

