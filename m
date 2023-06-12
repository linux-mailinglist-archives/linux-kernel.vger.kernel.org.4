Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CC172CB0D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjFLQJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFLQJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:09:18 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA1B187
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:09:17 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-55b2fb308bbso2339310eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686586157; x=1689178157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krHnCQ5CZRMKrSb8ha+/q1/CNtxY7fdiNeyXa88Ch7U=;
        b=z3EBHkglWnm5rnLT98HaYaM+oGWcCAOyxvug81oE2bBZpjVKxBgN29HUk1J+lwiLiZ
         HsDVo1ETVzGu1HECjVIGZHpZCo21qG7E2DidskRGb9L67JJFLSKyZl45k4uZssKrn2K0
         22ddrL24eEE9G4l8BbFRK+rUzlepuWNLezx5wqPj6QgDytdO1RvOQUV8oYgoVtfucW9M
         bVrdjiGepr6ge7nbMw65RIYrDhIRac6HeFNdCeJMiaea2G8vm0olD15rTk/lWCWaqa7L
         dnQq8z6sBAw12YOiMmgwwo7FThPlMXhO0rreAEAlcVOsqt8UuSWBug+vF4r8zpSiVX0I
         c2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686586157; x=1689178157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krHnCQ5CZRMKrSb8ha+/q1/CNtxY7fdiNeyXa88Ch7U=;
        b=kkw5DrrRXSI+Vg0tmLR2yQwa39/rogrG6X/URH9lbEAmi9RI/1xz1rvWYQtZ76TWJQ
         2dD+rl8HnYAsJLVsz/m7zE4F25EV9ywze3gdDlyZjUK+dg6fVrgksNoqh4X+WjslcBLT
         vNuB/3P5Vk7X142OjKt62na05OQ6w9XZ2yDGNeK6GtNji9ke//W6DuBniBbatYn02sfP
         HXaDtLAJfIHwxbbARqZx4G2ABgEDYXqub269EqncqfVZOXvVzauSUzdJ+WfBJrUQ1gIA
         kuDf7NL4Mvr6cNmnNy8YXhLKS6FBcvuPVkKerNDhtrpwvyOYhEhGMP+/WUTqjGbhplRO
         ipcg==
X-Gm-Message-State: AC+VfDyFKiLxcE+DJJnUdrVqTQTq3yRVWO45aPVv398VT1YhAAhYhKRS
        oWEOrq9eX/ETQf+QPSkagaDaFZhky52cRxwBBlCSNA==
X-Google-Smtp-Source: ACHHUZ4D0xPfFFsu+KArW+MWCrof3osUM2WtDYERfGMacYWgjQS8tjR/ytuDZp0rHDkHYrXTiPuEqxVBQnbyJDiu9gU=
X-Received: by 2002:a05:6359:ba3:b0:12b:d6bf:7ac8 with SMTP id
 gf35-20020a0563590ba300b0012bd6bf7ac8mr635970rwb.29.1686586156856; Mon, 12
 Jun 2023 09:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230609005158.2421285-1-surenb@google.com> <20230609005158.2421285-3-surenb@google.com>
 <ZIOKxoTlRzWQtQQR@x1n> <ZIONJQGuhYiDnFdg@casper.infradead.org>
 <ZIOPeNAy7viKNU5Z@x1n> <CAJuCfpFAh2KOhpCQ-4b+pzY+1GxOGk=eqj6pBj04gc_8eqB6QQ@mail.gmail.com>
 <ZIcktx8DPYxtV2Sd@x1n>
In-Reply-To: <ZIcktx8DPYxtV2Sd@x1n>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 12 Jun 2023 09:09:06 -0700
Message-ID: <CAJuCfpFJwDc8po3Ar1JsU8nGZUdCeiBNniQkp909dAC_fc8Kvw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] mm: handle swap page faults under VMA lock if page
 is uncontended
To:     Peter Xu <peterx@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@suse.com, josef@toxicpanda.com,
        jack@suse.cz, ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 6:59=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Jun 09, 2023 at 03:34:34PM -0700, Suren Baghdasaryan wrote:
> > On Fri, Jun 9, 2023 at 1:45=E2=80=AFPM Peter Xu <peterx@redhat.com> wro=
te:
> > >
> > > On Fri, Jun 09, 2023 at 09:35:49PM +0100, Matthew Wilcox wrote:
> > > > On Fri, Jun 09, 2023 at 04:25:42PM -0400, Peter Xu wrote:
> > > > > >  bool __folio_lock_or_retry(struct folio *folio, struct mm_stru=
ct *mm,
> > > > > >                    unsigned int flags)
> > > > > >  {
> > > > > > + /* Can't do this if not holding mmap_lock */
> > > > > > + if (flags & FAULT_FLAG_VMA_LOCK)
> > > > > > +         return false;
> > > > >
> > > > > If here what we need is the page lock, can we just conditionally =
release
> > > > > either mmap lock or vma lock depending on FAULT_FLAG_VMA_LOCK?
> > > >
> > > > See patch 5 ...
> > >
> > > Just reaching.. :)
> > >
> > > Why not in one shot, then?
> >
> > I like small incremental changes, but I can squash them if that helps
> > in having a complete picture.
>
> Yes that'll be appreciated.  IMHO keeping changing semantics of
> FAULT_FLAG_VMA_LOCK for the folio lock function in the same small series =
is
> confusing.

Ack. Thanks for the feedback!

>
> --
> Peter Xu
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
