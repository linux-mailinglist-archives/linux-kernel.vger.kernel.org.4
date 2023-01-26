Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EB667D325
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 18:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjAZR1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 12:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjAZR1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:27:41 -0500
Received: from outbound-smtp28.blacknight.com (outbound-smtp28.blacknight.com [81.17.249.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2761728C8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 09:27:05 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp28.blacknight.com (Postfix) with ESMTPS id 0AFB0CCB32
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 17:27:02 +0000 (GMT)
Received: (qmail 17492 invoked from network); 26 Jan 2023 17:27:01 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 26 Jan 2023 17:27:01 -0000
Date:   Thu, 26 Jan 2023 17:26:57 +0000
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
Subject: Re: [PATCH v3 4/7] mm: replace vma->vm_flags direct modifications
 with modifier calls
Message-ID: <20230126172657.bmga5hy74ifsbhun@techsingularity.net>
References: <20230125233554.153109-1-surenb@google.com>
 <20230125233554.153109-5-surenb@google.com>
 <20230126151015.ru2m26jkhwib6x6u@techsingularity.net>
 <CAJuCfpEzAbpy9rZ5KeZXQsqFTPOGYv6CZQfP9SHqcqFi0s7neg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAJuCfpEzAbpy9rZ5KeZXQsqFTPOGYv6CZQfP9SHqcqFi0s7neg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 08:10:26AM -0800, Suren Baghdasaryan wrote:
> On Thu, Jan 26, 2023 at 7:10 AM Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > On Wed, Jan 25, 2023 at 03:35:51PM -0800, Suren Baghdasaryan wrote:
> > > Replace direct modifications to vma->vm_flags with calls to modifier
> > > functions to be able to track flag changes and to keep vma locking
> > > correctness.
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > Acked-by: Michal Hocko <mhocko@suse.com>
> >
> > Acked-by: Mel Gorman <mgorman@techsingularity.net>
> >
> > Minor comments that are safe to ignore.
> >
> > I think a better name for mod_vm_flags is set_clear_vm_flags to hint that
> > the first flags are to be set and the second flags are to be cleared.
> > For this patch, it doesn't matter, but it might avoid accidental swapping
> > in the future.
> >
> > reset_vm_flags might also be better named as reinit_vma_flags (or
> > vma_flags_reinit). Maybe also encourage the use of [set|clear_mod]_vm_flags
> > where possible in the comment to track exactly what is changing and
> > why. Some cases like userfaultfd just want to clear __VM_UFFD_FLAGS but
> > altering the flow in this patch is inappropriate and error prone. Others
> > such as the infiniband changes and madvise are a lot more complex.
> 
> That's a good point, but I don't want people to use mod_vm_flags() for
> the cases when the order of set/clear really matters. In such cases
> set_vm_flags() and clear_vm_flags() should be explicitly used. Maybe
> to make that clear I should add a comment and rewrite the functions
> as:
> 
> void mod_vm_flags(vma, set, clear) {
>     vma.vm_flags = vma.vm_flags | set & clear;
> }
> 

Offhand, I'm not thinking of a case where that really matters and as they
are not necessarily ordered, it's raising a read flag so yes, it definitely
it needs a comment if the ordering matters.

> In this patchset it's not that obvious but mod_vm_flags() was really
> introduced in the original per-VMA lock patchset for efficiency to
> avoid taking extra per-VMA locks. A combo of
> set_vm_flags()+clear_vm_flags() would try to retake the same per-VMA
> lock in the second call while mod_vm_flags() takes the lock only once
> and does both operations.

Ok, that seems fair but still needs a comment on why a mod_vm_flags is
not necessarily equivalent to a set_vm_flags + clear_vm_flags in terms of
correctness if that is indeed the case.

> Not a huge overhead because we check if the
> lock is already taken and bail out early but still...
> So, would the above modification to mod_vm_flags() address your concern?
> 

My concerns are entirely with the callers, not the implementation. If
someone is modifying a call site using mod_vm_flags, they have to read
through all the preceding logic to ensure the final combination of flags
is valid.  It's a code maintenance issue, not a correctness issue.

-- 
Mel Gorman
SUSE Labs
