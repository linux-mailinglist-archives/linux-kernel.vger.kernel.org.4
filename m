Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4256668C604
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 19:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjBFSmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 13:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBFSml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 13:42:41 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F092CC63
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 10:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1675708944; bh=EwXs/jy7qgWsP5jG0wksqu1PcOs1hmaF0jlonE09KTw=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To;
        b=DYwKNXU8lW7Itk1KxIupSb4I+CMGUb8JTh1JhRCwYj1sIiCX8Bq4AyLQ9XRPxHVSR
         pvYBuZk26K7PQBK9urljRuOBDeM+cVyEynZsS+rcl+pM9T444gc6nQvYuq0TiEDvUN
         qtAQcs24N8WyjFCdioeQmmUCUhxp8RGHOpyhebY4=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Mon,  6 Feb 2023 19:42:24 +0100 (CET)
X-EA-Auth: X5Xltbtqqf5tc8FJUeUZhlekEgROBmK6blXxKp89tuOlOy1hPJvnaRvqLlK7d2EJr4VQLYGQCgwYcanwqLbMfuuss9wGjl1Q
Date:   Tue, 7 Feb 2023 00:12:18 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Matthew Auld <matthew.auld@intel.com>
Cc:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH] drm/i915/gt: Avoid redundant pointer validity check
Message-ID: <Y+FKCth+0r/757Xu@ubun2204.myguest.virtualbox.org>
References: <Y91g081OauhQNxMe@ubun2204.myguest.virtualbox.org>
 <d58fff32-edad-4a7f-7409-7e57593df3ed@linux.intel.com>
 <aa8af778-2a40-7fe0-eb14-234469c74523@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa8af778-2a40-7fe0-eb14-234469c74523@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 10:33:13AM +0000, Matthew Auld wrote:
> On 06/02/2023 09:45, Tvrtko Ursulin wrote:
> > 
> > Hi,
> > 
> > Adding Matt & Thomas as potential candidates to review.
> > 
> > Regards,
> > 
> > Tvrtko
> > 
> > On 03/02/2023 19:30, Deepak R Varma wrote:
> > > The macro definition of gen6_for_all_pdes() expands to a for loop such
> > > that it breaks when the page table is null. Hence there is no need to
> > > again test validity of the page table entry pointers in the pde list.
> > > This change is identified using itnull.cocci semantic patch.
> > > 
> > > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > > ---
> > > Please note: Proposed change is compile tested only.
> > > 
> > >   drivers/gpu/drm/i915/gt/gen6_ppgtt.c | 5 ++---
> > >   1 file changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
> > > b/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
> > > index 5aaacc53fa4c..787b9e6d9f59 100644
> > > --- a/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
> > > +++ b/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
> > > @@ -258,8 +258,7 @@ static void gen6_ppgtt_free_pd(struct gen6_ppgtt
> > > *ppgtt)
> > >       u32 pde;
> > >       gen6_for_all_pdes(pt, pd, pde)
> > > -        if (pt)
> > > -            free_pt(&ppgtt->base.vm, pt);
> > > +        free_pt(&ppgtt->base.vm, pt);
> > >   }
> > >   static void gen6_ppgtt_cleanup(struct i915_address_space *vm)
> > > @@ -304,7 +303,7 @@ static void pd_vma_unbind(struct
> > > i915_address_space *vm,
> > >       /* Free all no longer used page tables */
> > >       gen6_for_all_pdes(pt, ppgtt->base.pd, pde) {
> > > -        if (!pt || atomic_read(&pt->used))
> > > +        if (atomic_read(&pt->used))
> 
> Wow, I was really confused trying to remember how this all works.
> 
> The gen6_for_all_pdes() does:
> 
> (pt = i915_pt_entry(pd, iter), true)
> 
> So NULL pt is expected, and does not 'break' here, since 'true' is always
> the value that decides whether to terminate the loop. So this patch would
> lead to NULL ptr deref, AFAICT.

Hello Matt,
I understand it now. I was misreading the true as part of the function argument.
Could you please also comment if the implementation of gen6_ppgtt_free_pd() in
the same file is safe? It doesn't appear to have an check on pt validity here.

Thank you,
deepak.

> 
> 
> 
> > >               continue;
> > >           free_pt(&ppgtt->base.vm, pt);


