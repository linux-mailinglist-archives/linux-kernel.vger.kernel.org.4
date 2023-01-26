Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980DA67D33D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 18:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjAZRdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 12:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjAZRc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:32:57 -0500
Received: from outbound-smtp10.blacknight.com (outbound-smtp10.blacknight.com [46.22.139.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4743C11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 09:32:48 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp10.blacknight.com (Postfix) with ESMTPS id 233151C3780
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 17:32:47 +0000 (GMT)
Received: (qmail 32726 invoked from network); 26 Jan 2023 17:32:46 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 26 Jan 2023 17:32:46 -0000
Date:   Thu, 26 Jan 2023 17:32:45 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, dave@stgolabs.net, willy@infradead.org,
        liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
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
Subject: Re: [PATCH v3 6/7] mm: introduce mod_vm_flags_nolock and use it in
 untrack_pfn
Message-ID: <20230126173245.cf3jcfw5s2a77s5v@techsingularity.net>
References: <20230125233554.153109-1-surenb@google.com>
 <20230125233554.153109-7-surenb@google.com>
 <20230126154740.j3a3lu4x557c56yi@techsingularity.net>
 <CAJuCfpHP6hQAWZr2exZEXOzLbMNU_c9qNNc7pa2NYAhYLe=EKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAJuCfpHP6hQAWZr2exZEXOzLbMNU_c9qNNc7pa2NYAhYLe=EKQ@mail.gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 08:18:31AM -0800, Suren Baghdasaryan wrote:
> On Thu, Jan 26, 2023 at 7:47 AM Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > On Wed, Jan 25, 2023 at 03:35:53PM -0800, Suren Baghdasaryan wrote:
> > > In cases when VMA flags are modified after VMA was isolated and mmap_lock
> > > was downgraded, flags modifications would result in an assertion because
> > > mmap write lock is not held.
> >
> > Add note that it's also used during exit when the locking of the VMAs
> > becomes irrelevant (mm users is 0, should be no VMA modifications taking
> > place other than zap).
> 
> Ack.
> 
> >
> > The typical naming pattern when a caller either knows it holds the necessary
> > lock or knows it does not matter is __mod_vm_flags()
> 
> Ok. It sounds less explicit but plenty of examples, so I'm fine with
> such rename. Will apply in the next version.
> 

It might be a personal thing. nolock to me is ambigious because it might
mean "lock is already held", "no lock is necessary" or "no lock is acquired"
where as *for me*, calling foo vs __foo *usually* means "direct callers of
__foo take care of the locking, memory ordering, per-cpu pinning details etc"
depending on the context. Of course, this convention is not universally true.

> > > Pass a hint to untrack_pfn to conditionally use mod_vm_flags_nolock for
> > > flags modification and to avoid assertion.
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >
> > Patch itself looks ok. It strays close to being "conditional locking"
> > though which might attract some complaints.
> 
> The description seems to accurately describe what's done here but I'm
> open to better suggestions.

I don't have alternative suggestions but if someone else reads the patch and
says "this is conditional locking", you can at least claim that someone
else considered "conditional locking" and didn't think it was a major
problem in this specific patch.

-- 
Mel Gorman
SUSE Labs
