Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E183672DCF6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240560AbjFMIsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbjFMIsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:48:41 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A55C0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:48:39 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-43b5882f945so309060137.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686646118; x=1689238118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+moT08wPsJXStgU7vMdHROE2qSZd8ki23/kaFbG+8IY=;
        b=ErwzaYxz4Bp9CQ96lMEydtXpgOFdCh7wlLrgOvSNsLImmkePJEHijWTLhcRn+hAmis
         dlrSa2gO2vtYGdk46wdYv8fx4LHu7cR2ieuAlObzziFtM+r/p1V4KLRkdM6YEixoSxov
         ee41NZPG05/ZbJ6YuBgfNWLpMvL4reNL08FT2ccHk4fR4DdIDBLyqxsvG079slfWh/YU
         4Vowa3gYhguYwGMWJoTeAYBPSrbdoQ7vtC7F76+ptZDj1QWdENWImyk071utAYcxSDqP
         vYK48cx/c3fYEPawKr1JoLUzRm2HxiwotvJ440dUEEy2LQbjdrppT9Ur0jagj4QFrNW6
         FIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686646118; x=1689238118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+moT08wPsJXStgU7vMdHROE2qSZd8ki23/kaFbG+8IY=;
        b=GPw20ZnR+dW8sgGSt7PEvwiGnqYCTjgenOhSjyzLinv7ZBhuFPYBWDLHEtJlh24lsW
         CxH+/NEOD+zCQikOtytBbtf2STWCSUzt2xFPjscmgXHta1q0i7K+Nl0ys8tWygWyI3cw
         0EQCxL/Y7jsLKcNcve8JsH71RpRbNgM15oX8n5iSM+OYWGLObckd8bKqw2/aoPIVkLqm
         fLCZjqXUJkQhOW+xbZofcnhJkkOSkicAoE5M17lemYxk95HIjWeLBA/t1whTATZSiM2Y
         EzOSy4+hvv+fD4M9NjKYSBcK7iyjAVtd6YfcIvwQLUZ220CkAygGfgv1dyxTbkeU/jRC
         6LKw==
X-Gm-Message-State: AC+VfDzM1zM9s+tfltJmxuT0v0Uz+o7UvW/WwZX7n54kC3aDebtXZC4K
        4joDxzls8ue/7vXhe9kxFFyss5/iOh048vBV+bvJn5SYZR9uxBcHnpM=
X-Google-Smtp-Source: ACHHUZ5z48J7c1Hn2zzF7MPqVJPcmVwjrmcj6TW3W2znJMoNGF2OjYpOPFKoZpQX7oA/IWduT0SdafIEL6t+JjkCWXM=
X-Received: by 2002:a67:fa46:0:b0:43c:886a:f0c9 with SMTP id
 j6-20020a67fa46000000b0043c886af0c9mr5439707vsq.5.1686646118541; Tue, 13 Jun
 2023 01:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAFA6WYO+AvnbuAdWyBAQ8HkLaOno7PXdsPb9SubxrGNvAm4UnQ@mail.gmail.com>
 <ZGSLiiK/JzD5KMd7@infradead.org> <CAFA6WYPOMwmrA3J84AHzoD2eAtNkpMxr754qHpc-j6XRkgFFvQ@mail.gmail.com>
 <ZGSgCZrg+RjAbGO1@infradead.org> <CAFA6WYO+EpiECFxdVgmd-Ey9jq1Ybt78WupK_bW5+oDcW-soVQ@mail.gmail.com>
 <d4773626-6cf0-c929-c775-a84ac41fd719@redhat.com> <ZGWnq/dAYELyKpTy@infradead.org>
 <CAFA6WYPgvifYcj_MT7BBcC0BtQDWXV0u+HY8qv0M9nNyiCgkow@mail.gmail.com>
 <8b898768-a3c0-198d-a70c-9aa96b7f4a29@redhat.com> <1ced7f32-553e-2a5b-eec9-f794d7983d56@nvidia.com>
 <106e7886-ef02-4979-b96d-66d33cfa119c@lucifer.local> <acc5f89dee4426e8c8953eabc65e932f22dde169.camel@mediatek.com>
In-Reply-To: <acc5f89dee4426e8c8953eabc65e932f22dde169.camel@mediatek.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 13 Jun 2023 14:18:27 +0530
Message-ID: <CAFA6WYN-jj-FsL1h8prvs4XZssQ=mppbPGoQHfzzdjK4cV1XzA@mail.gmail.com>
Subject: Re: FOLL_LONGTERM vs FOLL_EPHEMERAL Re: [PATCH] tee: add
 FOLL_LONGTERM for CMA case when alloc shm
To:     =?UTF-8?B?WGlhb21pbmcgRGluZyAo5LiB5pmT5piOKQ==?= 
        <Xiaoming.Ding@mediatek.com>
Cc:     "lstoakes@gmail.com" <lstoakes@gmail.com>,
        "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "hch@infradead.org" <hch@infradead.org>,
        =?UTF-8?B?RmVpIFh1ICjlvpDpo54p?= <Fei.Xu@mediatek.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "david@redhat.com" <david@redhat.com>,
        "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>,
        "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023 at 11:00, Xiaoming Ding (=E4=B8=81=E6=99=93=E6=98=8E)
<Xiaoming.Ding@mediatek.com> wrote:
>
> So do we have a conclution about this patch?  or need more time to
> study the possible risks

Please avoid top posting. As already discussed here [1],
RLIMIT_MEMLOCK checks have to be implemented if we switch to
FOLL_LONGTERM.

[1] https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfir=
mware.org/message/UEOMNYLDFHDFQNLODGCJVFDOQBR723EQ/

-Sumit

>
> On Tue, 2023-05-23 at 08:25 +0100, Lorenzo Stoakes wrote:
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >
> >
> > On Mon, May 22, 2023 at 06:54:29PM -0700, John Hubbard wrote:
> > > On 5/18/23 06:56, David Hildenbrand wrote:
> > > > On 18.05.23 08:08, Sumit Garg wrote:
> > > > > On Thu, 18 May 2023 at 09:51, Christoph Hellwig <
> > > > > hch@infradead.org> wrote:
> > > > > >
> > > > > > On Wed, May 17, 2023 at 08:23:33PM +0200, David Hildenbrand
> > > > > > wrote:
> > > > > > > In general: if user space controls it -> possibly forever
> > > > > > > -> long-term. Even
> > > > > > > if in most cases it's a short delay: there is no trusting
> > > > > > > on user space.
> > > > > > >
> > > > > > > For example, iouring fixed buffers keep pages pinned until
> > > > > > > user space
> > > > > > > decides to unregistered the buffers -> long-term.
> > > > > > >
> > > > > > > Short-term is, for example, something like O_DIRECT where
> > > > > > > we pin -> DMA ->
> > > > > > > unpin in essentially one operation.
> > > > > >
> > > > > > Btw, one thing that's been on my mind is that I think we got
> > > > > > the
> > > > > > polarity on FOLL_LONGTERM wrong.  Instead of opting into the
> > > > > > long term
> > > > > > behavior it really should be the default, with a
> > > > > > FOLL_EPHEMERAL flag
> > > > > > to opt out of it.  And every users of this flag is required
> > > > > > to have
> > > > > > a comment explaining the life time rules for the pin..
> >
> > I couldn't agree more, based on my recent forays into GUP the
> > interface
> > continues to strike me as odd:-
> >
> > - FOLL_GET is a wing and a prayer that nothing that
> >   [folio|page]_maybe_dma_pinned() prevents happens in the brief
> > period the
> >   page is pinned/manipulated. So agree completely with David's
> > concept of
> >   unexporting that and perhaps carefully considering our use of
> >   it. Obviously the comments around functions like gup_remote() make
> > clear
> >   that 'this page not be what you think it is' but I wonder whether
> > many
> >   callers of GUP _truly_ take that on board.
> >
> > - FOLL_LONGTERM is entirely optional for PUP and you can just go
> > ahead and
> >   fragment page blocks to your heart's content. Of course this would
> > be an
> >   abuse, but abuses happen.
> >
> > - With the recent change to PUP/FOLL_LONGTERM disallowing dirty
> > tracked
> >   file-backed mappings we're now really relying on this flag
> > indicating a
> >   _long term_ pin semantically. By defaulting to this being switched
> > on, we
> >   avoid cases of callers who might end up treating the won't
> >   reclaim/etc. aspect of PUP as all they care about while ignoring
> > the
> >   MIGRATE_MOVABLE aspect.
> >
> > >
> > > I see maybe 10 or 20 call sites today. So it is definitely feasible
> > > to add
> > > documentation at each, explaining the why it wants a long term pin.
> > >
> >
> > Yeah, my efforts at e.g. dropping vmas has been eye-opening in
> > actually
> > quite how often a refactoring like this often ends up being more
> > straightforward than you might imagine.
> >
> > > > >
> > > > > It does look like a better approach to me given the very nature
> > > > > of
> > > > > user space pages.
> > > >
> > > > Yeah, there is a lot of historical baggage. For example, FOLL_GET
> > > > should be inaccessible to kernel modules completely at one point,
> > > > to be only used by selected core-mm pieces.
> > >
> > > Yes. When I first mass-converted call sites from gup to pup, I just
> > > preserved FOLL_GET behavior in order to keep from changing too much
> > > at
> > > once. But I agree that that it would be nice to make FOLL_GET an
> > > mm internal-only flag like FOLL_PIN.
> >
> > Very glad you did that work! And totally understandable as to you
> > being
> > conservative with that, but I think we're at a point where there's
> > more
> > acceptance of incremental improvements to GUP as a whole.
> >
> > I have another patch series saved up for _yet more_ changes on this.
> > But
> > mindful of churn I am trying to space them out... until Jason nudges
> > me of
> > course :)
> >
> > >
> > > >
> > > > Maybe we should even disallow passing in FOLL_LONGTERM as a flag
> > > > and only provide functions like pin_user_pages() vs.
> > > > pin_user_pages_longterm(). Then, discussions about conditional
> > > > flag-setting are no more :)
> > > >
> > > > ... or even use pin_user_pages_shortterm() vs. pin_user_pages()
> > > > ... to make the default be longterm.
> > > >
> > >
> > > Yes, it is true that having most gup flags be internal to mm does
> > > tend
> > > to avoid some bugs. But it's also a lot of churn. I'm still on the
> > > fence
> > > as to whether it's really a good move to do this for FOLL_LONGTERM
> > > or
> > > not. But it's really easy to push me off of fences. :)
> >
> > *nudge* ;)
> >
> > >
> > > thanks,
> > > --
> > > John Hubbard
> > > NVIDIA
> > >
> >
> > Looking at non-fast, non-FOLL_LONGTERM PUP callers (forgive me if I
> > missed any):-
> >
> > - pin_user_pages_remote() in process_vm_rw_single_vec() for the
> >   process_vm_access functionality.
> >
> > - pin_user_pages_remote() in user_event_enabler_write() in
> >   kernel/trace/trace_events_user.c.
> >
> > - pin_user_pages_unlocked() in ivtv_udma_setup() in
> >   drivers/media/pci/ivtv/ivtv-udma.c and ivtv_yuv_prep_user_dma() in
> > ivtv-yuv.c.
> >
> > And none that actually directly invoke PUP without FOLL_LOGNTERM...
> > That
> > suggests that we could simply disallow non-FOLL_LONGTERM non-fast PUP
> > calls
> > altogether and move to pin_user_pages_longterm() [I'm happy to write
> > a
> > patch series doing this].
> >
> > The ivtv callers look like they really actually want FOLL_LONGTERM
> > unless
> > I'm missing something so we should probably change that too?
> >
> > I haven't surveyed the fast versions, but I think defaulting to
> > FOLL_LONGTERM on them also makes sense.
>
