Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA3F70D4E2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjEWHZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjEWHZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:25:51 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C3A133
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:25:30 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f607839b89so11280555e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684826728; x=1687418728;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hh1M/PyhqnPF3gHXcsPzIKqPXVy0TQ5XWDVGt8r34Cw=;
        b=MbWTUJK0onitNaT4PQy7LWYs3/eCrjGWOztlNDkwLuKrPc2NB3ITFEKXZNPSCQBVkm
         IsDCDKehWZ8npbFaRSGkKIfRvHD8P75fyk5si+zzsFeFE8w/tJz3S7O1mOUp7Mt7HTdT
         r6LF5FjChUepkHIWCN4SCllJcZNcSGNLmnC3zqHu1xZ7+jWeJ7IYlfbR7gxLtDkH4JKX
         mxay8Vb1CJPUnjMgALNdyy5NHyJTWR0JvVa/hBUlmukAz3edKWeYRZ8sytnO6b0QbvCw
         JlsLc6mnPtF81xYjLlCDrGVNDeM1Zij5DB32GhWHgEDPh620Z76Sx5nLWt4mZOCnoR8i
         ZMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684826728; x=1687418728;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hh1M/PyhqnPF3gHXcsPzIKqPXVy0TQ5XWDVGt8r34Cw=;
        b=HY7PmOtMH+k2OIZHmntzE6QayedIxALB08rnj3c1gVxwKjFFoJC+/4k1PrngahnRRJ
         aXKA3FleobdR/ugvCzi47C9Pt6kWz3NOLdBsTLat1qPvvId01zrTrhAoC3oQ9Lvs6KND
         8dZG84Z8How7LUC8FcmV0NcNJxE+erbjqorAfghtIAHWqHg/4GBa+T5VLuVYlLK8JHTu
         nlqp4EEH+CGxzgFOYTqGk4JvYM94hhRsOgBz1z1ptPZ/sehmZeKuT1/vnnK9RJUr9uIr
         H1ufxgWS34pqcTj/K9cHdIYLauEovhnlnnU0ZdRuf8n5TJubm/QNZHkldNtg/lB6YJhD
         Tsfg==
X-Gm-Message-State: AC+VfDyO5b6ig3kIPe3QGvsMmxFGEnvp+j6KLsT32xGMEXpZqFmQxMfx
        rZ8WyAU9bGmBWnf+5+innoM=
X-Google-Smtp-Source: ACHHUZ6TvcH4VxLvgQZWHCNak2I8mUxXM2ty6AS9EVucuJhjX5yJLuwW0XNYUI3IR6a9XcTU9oOJTg==
X-Received: by 2002:a1c:4c10:0:b0:3f4:5058:a033 with SMTP id z16-20020a1c4c10000000b003f45058a033mr9372191wmf.24.1684826728204;
        Tue, 23 May 2023 00:25:28 -0700 (PDT)
Received: from localhost (host81-154-179-160.range81-154.btcentralplus.com. [81.154.179.160])
        by smtp.gmail.com with ESMTPSA id h1-20020a1ccc01000000b003eddc6aa5fasm13988260wmb.39.2023.05.23.00.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 00:25:27 -0700 (PDT)
Date:   Tue, 23 May 2023 08:25:26 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Xiaoming Ding <xiaoming.ding@mediatek.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, fei.xu@mediatek.com,
        srv_heupstream@mediatek.com, linux-mm@kvack.org
Subject: Re: FOLL_LONGTERM vs FOLL_EPHEMERAL Re: [PATCH] tee: add
 FOLL_LONGTERM for CMA case when alloc shm
Message-ID: <106e7886-ef02-4979-b96d-66d33cfa119c@lucifer.local>
References: <CAFA6WYO+AvnbuAdWyBAQ8HkLaOno7PXdsPb9SubxrGNvAm4UnQ@mail.gmail.com>
 <ZGSLiiK/JzD5KMd7@infradead.org>
 <CAFA6WYPOMwmrA3J84AHzoD2eAtNkpMxr754qHpc-j6XRkgFFvQ@mail.gmail.com>
 <ZGSgCZrg+RjAbGO1@infradead.org>
 <CAFA6WYO+EpiECFxdVgmd-Ey9jq1Ybt78WupK_bW5+oDcW-soVQ@mail.gmail.com>
 <d4773626-6cf0-c929-c775-a84ac41fd719@redhat.com>
 <ZGWnq/dAYELyKpTy@infradead.org>
 <CAFA6WYPgvifYcj_MT7BBcC0BtQDWXV0u+HY8qv0M9nNyiCgkow@mail.gmail.com>
 <8b898768-a3c0-198d-a70c-9aa96b7f4a29@redhat.com>
 <1ced7f32-553e-2a5b-eec9-f794d7983d56@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ced7f32-553e-2a5b-eec9-f794d7983d56@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 06:54:29PM -0700, John Hubbard wrote:
> On 5/18/23 06:56, David Hildenbrand wrote:
> > On 18.05.23 08:08, Sumit Garg wrote:
> > > On Thu, 18 May 2023 at 09:51, Christoph Hellwig <hch@infradead.org> wrote:
> > > >
> > > > On Wed, May 17, 2023 at 08:23:33PM +0200, David Hildenbrand wrote:
> > > > > In general: if user space controls it -> possibly forever -> long-term. Even
> > > > > if in most cases it's a short delay: there is no trusting on user space.
> > > > >
> > > > > For example, iouring fixed buffers keep pages pinned until user space
> > > > > decides to unregistered the buffers -> long-term.
> > > > >
> > > > > Short-term is, for example, something like O_DIRECT where we pin -> DMA ->
> > > > > unpin in essentially one operation.
> > > >
> > > > Btw, one thing that's been on my mind is that I think we got the
> > > > polarity on FOLL_LONGTERM wrong.  Instead of opting into the long term
> > > > behavior it really should be the default, with a FOLL_EPHEMERAL flag
> > > > to opt out of it.  And every users of this flag is required to have
> > > > a comment explaining the life time rules for the pin..

I couldn't agree more, based on my recent forays into GUP the interface
continues to strike me as odd:-

- FOLL_GET is a wing and a prayer that nothing that
  [folio|page]_maybe_dma_pinned() prevents happens in the brief period the
  page is pinned/manipulated. So agree completely with David's concept of
  unexporting that and perhaps carefully considering our use of
  it. Obviously the comments around functions like gup_remote() make clear
  that 'this page not be what you think it is' but I wonder whether many
  callers of GUP _truly_ take that on board.

- FOLL_LONGTERM is entirely optional for PUP and you can just go ahead and
  fragment page blocks to your heart's content. Of course this would be an
  abuse, but abuses happen.

- With the recent change to PUP/FOLL_LONGTERM disallowing dirty tracked
  file-backed mappings we're now really relying on this flag indicating a
  _long term_ pin semantically. By defaulting to this being switched on, we
  avoid cases of callers who might end up treating the won't
  reclaim/etc. aspect of PUP as all they care about while ignoring the
  MIGRATE_MOVABLE aspect.

>
> I see maybe 10 or 20 call sites today. So it is definitely feasible to add
> documentation at each, explaining the why it wants a long term pin.
>

Yeah, my efforts at e.g. dropping vmas has been eye-opening in actually
quite how often a refactoring like this often ends up being more
straightforward than you might imagine.

> > >
> > > It does look like a better approach to me given the very nature of
> > > user space pages.
> >
> > Yeah, there is a lot of historical baggage. For example, FOLL_GET should be inaccessible to kernel modules completely at one point, to be only used by selected core-mm pieces.
>
> Yes. When I first mass-converted call sites from gup to pup, I just
> preserved FOLL_GET behavior in order to keep from changing too much at
> once. But I agree that that it would be nice to make FOLL_GET an
> mm internal-only flag like FOLL_PIN.

Very glad you did that work! And totally understandable as to you being
conservative with that, but I think we're at a point where there's more
acceptance of incremental improvements to GUP as a whole.

I have another patch series saved up for _yet more_ changes on this. But
mindful of churn I am trying to space them out... until Jason nudges me of
course :)

>
> >
> > Maybe we should even disallow passing in FOLL_LONGTERM as a flag and only provide functions like pin_user_pages() vs. pin_user_pages_longterm(). Then, discussions about conditional flag-setting are no more :)
> >
> > ... or even use pin_user_pages_shortterm() vs. pin_user_pages() ... to make the default be longterm.
> >
>
> Yes, it is true that having most gup flags be internal to mm does tend
> to avoid some bugs. But it's also a lot of churn. I'm still on the fence
> as to whether it's really a good move to do this for FOLL_LONGTERM or
> not. But it's really easy to push me off of fences. :)

*nudge* ;)

>
> thanks,
> --
> John Hubbard
> NVIDIA
>

Looking at non-fast, non-FOLL_LONGTERM PUP callers (forgive me if I missed any):-

- pin_user_pages_remote() in process_vm_rw_single_vec() for the
  process_vm_access functionality.

- pin_user_pages_remote() in user_event_enabler_write() in
  kernel/trace/trace_events_user.c.

- pin_user_pages_unlocked() in ivtv_udma_setup() in
  drivers/media/pci/ivtv/ivtv-udma.c and ivtv_yuv_prep_user_dma() in ivtv-yuv.c.

And none that actually directly invoke PUP without FOLL_LOGNTERM... That
suggests that we could simply disallow non-FOLL_LONGTERM non-fast PUP calls
altogether and move to pin_user_pages_longterm() [I'm happy to write a
patch series doing this].

The ivtv callers look like they really actually want FOLL_LONGTERM unless
I'm missing something so we should probably change that too?

I haven't surveyed the fast versions, but I think defaulting to
FOLL_LONGTERM on them also makes sense.
