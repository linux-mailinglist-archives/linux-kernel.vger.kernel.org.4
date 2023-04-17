Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5856E53BC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 23:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjDQVPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 17:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjDQVPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 17:15:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734AE44B7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 14:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681766063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sxnnHZDwZJJGWb/T5iJo27HHrfD/tsQknrCbU63tA4U=;
        b=GOzYcSsFcot/9DO/aKUg/NW+hcXnfEzmI7jtjvWgsQ3lbzWYiG5JdT1ZCTAFuU6lJxE/qx
        szwKDPHdej1v536urgwYbp5jr2luHllNdwqr0it3esGvTyXx4gukzIbddr+9vJ39cCEvNT
        hJJBL3so67bfoZAJoXMreqhRlf1fmVU=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-Q7GSYXhTNJqBRdNYD0hUEQ-1; Mon, 17 Apr 2023 17:14:22 -0400
X-MC-Unique: Q7GSYXhTNJqBRdNYD0hUEQ-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-b9266754251so70590276.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 14:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681766062; x=1684358062;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sxnnHZDwZJJGWb/T5iJo27HHrfD/tsQknrCbU63tA4U=;
        b=AgAZGAm7hGQMAhX8h5QNgax2FAMhR52H39xP3D1ndw5z7Oiy3hZhYptB6fkC04ombW
         TrFt6SndtcBlYpzQIqj4sAti9fMEx9sN2PKfghEU1htok4W3VjriPSTS1J0g5VoI50Bj
         rvpj5TH8zvML2E8e/z1ffRcGHfA7sv9FtSiQna57rGVtmO+bZhBMRCF6l5/5VQHtjTKR
         2uRQLjLiSVatK24nnLW0LdCTKgr8vz24pbs5TeYHxdkFVgGBkLnt3zFh64j2ypieUyIk
         YqbSU7Ttmn5cfeDh80KxmO+stFGb6530f84/Cs49jQ6+hnpcWkhLExnAT4iHEMqRMOFH
         LfBg==
X-Gm-Message-State: AAQBX9eeE659hGyJhZ3S1NV2LR7A4FEGfG2x3CQKCBz3aVdE3Silt5aq
        kWHnIfwffE04Bd0GGdK7jwyDpQzWWB3XpvuXKS3J4qKTjxLmDGlBXNWAXdh7xuLvSAxOp1zugc1
        jBrVhsrhqiQu2gK7CW5dziLfk
X-Received: by 2002:a81:f88:0:b0:54f:b503:6e69 with SMTP id 130-20020a810f88000000b0054fb5036e69mr10747148ywp.5.1681766061864;
        Mon, 17 Apr 2023 14:14:21 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zc4PjRQEW5uZIQQ0SScbuwxUtuQz06X2KxPomAXA0oAAk06pWNw1Uqh0wTchGQSDxe1XRs6A==
X-Received: by 2002:a81:f88:0:b0:54f:b503:6e69 with SMTP id 130-20020a810f88000000b0054fb5036e69mr10747125ywp.5.1681766061505;
        Mon, 17 Apr 2023 14:14:21 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id 141-20020a810393000000b0054fba955474sm3345769ywd.17.2023.04.17.14.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 14:14:20 -0700 (PDT)
Date:   Mon, 17 Apr 2023 17:14:19 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 1/1] mm: do not increment pgfault stats when page
 fault handler retries
Message-ID: <ZD22q95Vaex5dfU1@x1n>
References: <20230415000818.1955007-1-surenb@google.com>
 <ZD2gsbN2K66oXT69@x1n>
 <CAJuCfpFOSjES2hVM+zZX_i95JBBaZKr6zE9B8tWm_JqROJBPiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFOSjES2hVM+zZX_i95JBBaZKr6zE9B8tWm_JqROJBPiQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 01:29:45PM -0700, Suren Baghdasaryan wrote:
> On Mon, Apr 17, 2023 at 12:40 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Fri, Apr 14, 2023 at 05:08:18PM -0700, Suren Baghdasaryan wrote:
> > > If the page fault handler requests a retry, we will count the fault
> > > multiple times. This is a relatively harmless problem as the retry paths
> > > are not often requested, and the only user-visible problem is that the
> > > fault counter will be slightly higher than it should be.  Nevertheless,
> > > userspace only took one fault, and should not see the fact that the
> > > kernel had to retry the fault multiple times.
> > > Move page fault accounting into mm_account_fault() and skip incomplete
> > > faults which will be accounted upon completion.
> > >
> > > Fixes: d065bd810b6d ("mm: retry page fault when blocking on disk transfer")
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > >  mm/memory.c | 45 ++++++++++++++++++++++++++-------------------
> > >  1 file changed, 26 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 01a23ad48a04..c3b709ceeed7 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -5080,24 +5080,30 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
> > >   * updates.  However, note that the handling of PERF_COUNT_SW_PAGE_FAULTS should
> > >   * still be in per-arch page fault handlers at the entry of page fault.
> > >   */
> > > -static inline void mm_account_fault(struct pt_regs *regs,
> > > +static inline void mm_account_fault(struct mm_struct *mm, struct pt_regs *regs,
> > >                                   unsigned long address, unsigned int flags,
> > >                                   vm_fault_t ret)
> > >  {
> > >       bool major;
> > >
> > >       /*
> > > -      * We don't do accounting for some specific faults:
> > > -      *
> > > -      * - Unsuccessful faults (e.g. when the address wasn't valid).  That
> > > -      *   includes arch_vma_access_permitted() failing before reaching here.
> > > -      *   So this is not a "this many hardware page faults" counter.  We
> > > -      *   should use the hw profiling for that.
> > > -      *
> > > -      * - Incomplete faults (VM_FAULT_RETRY).  They will only be counted
> > > -      *   once they're completed.
> > > +      * Do not account for incomplete faults (VM_FAULT_RETRY). They will be
> > > +      * counted upon completion.
> > >        */
> > > -     if (ret & (VM_FAULT_ERROR | VM_FAULT_RETRY))
> > > +     if (ret & VM_FAULT_RETRY)
> > > +             return;
> > > +
> > > +     /* Register both successful and failed faults in PGFAULT counters. */

[1]

> > > +     count_vm_event(PGFAULT);
> > > +     count_memcg_event_mm(mm, PGFAULT);
> >
> > Is there reason on why vm events accountings need to be explicitly
> > different from perf events right below on handling ERROR?
> >
> > I get the point if this is to make sure ERROR accountings untouched for
> > these two vm events after this patch. IOW probably the only concern right
> > now is having RETRY counted much more than before (perhaps worse with vma
> > locking applied).
> >
> > But since we're on this, I'm wondering whether we should also align the two
> > events (vm, perf) so they represent in an aligned manner if we'll change it
> > anyway.  Any future reader will be confused on why they account
> > differently, IMHO, so if we need to differenciate we'd better add a comment
> > on why.
> >
> > I'm wildly guessing the error faults are indeed very rare and probably not
> > matter much at all.  I just think the code can be slightly cleaner if
> > vm/perf accountings match and easier if we treat everything the same. E.g.,
> > we can also drop the below "goto out"s too.  What do you think?
> 
> I think the rationale might be that vm accounting should account for
> *all* events, including failing page faults while for perf, the corner
> cases which rarely happen would not have tangible effect.

Note that it's not only for perf, but also task_struct.maj_flt|min_flt.

If we check the reasoning of "why ERROR shouldn't be accounted for perf
events", there're actually something valid in the comment:

	 * - Unsuccessful faults (e.g. when the address wasn't valid).  That
	 *   includes arch_vma_access_permitted() failing before reaching here.
	 *   So this is not a "this many hardware page faults" counter.  We
	 *   should use the hw profiling for that.

IMHO it suggests that if someone wants to trap either ERROR or RETRY one
can use the hardware counters instead.  The same reasoning just sounds
applicable to vm events too, because vm events are not special in this case
to me.

> I don't have a strong position on this issue and kept it as is to
> avoid changing the current accounting approach. If we are fine with
> such consolidation which would miss failing faults in vm accounting, I
> can make the change.

I don't have a strong opinion either.  We used to change this path before
for perf events and task events and no one complains with the change.  I'd
just bet the same to vm events:

https://lore.kernel.org/all/20200707225021.200906-1-peterx@redhat.com/

Please feel free to keep it as-is if you still feel unsafe on changing
ERROR handling.  If so, would you mind slightly modify [1] above explaining
why we need ERROR to be accounted for vm accountings with the reasoning?
Current comment only says "what it does" rather than why.

Thanks,

-- 
Peter Xu

