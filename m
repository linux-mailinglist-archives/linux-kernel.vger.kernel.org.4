Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE826A7266
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCARyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjCARyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:54:45 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F215E5258
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 09:54:43 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id x199so1189262ybg.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 09:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677693283;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyLNyIT7ZjoMQJW2GlCLIqOaY5bHOAo2jgEq4LLuoAE=;
        b=S7AKTOEG8ccSlllU33sd2udJ7o3wQuqONCNYCoGBbSWh5tr0AaYnW++oJMe5vlk20+
         uUbXs6bl24986BVLDkPr6wv98lmJPAPwLYXtTMwiwQiyoymLt4Z/YfFZ4skK7BbxuuMR
         F9CmS+EnZpmnXzBVvcQxPndeTx5qxU45adJREbgzRbmrtYpvdpXuOOeCVXwEBw2K/L/6
         ojIF2UM1kZuXihEL6ZTrfZpjbraZlQbN8F0sf6LeSa4QSirWHDrmBK7Qfp5sCXW3VIyo
         0exAISXBdjhEzA5pxBdbHkeZUas6B4H6F4XWu9FW3ZHAa2mrVJKAufXZq10iYoAC8rct
         ruDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677693283;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AyLNyIT7ZjoMQJW2GlCLIqOaY5bHOAo2jgEq4LLuoAE=;
        b=L3EYbZ5isZVHu88goQ++6gw/Jb7ueQS9NM5PK8WTvfDeCQxAMa7vuLe6Fc2x09MwJp
         12ZFucHd+TKjrmKfNdGI3zX9SHNcCsEaNUvDdwjG8qgOdfPwmCPxWnULjUscsHvQA4ay
         JEEdV5c5Wn0QKdl1EnB4i0iN684W/LWC0ywIGeSdJBnZczDF8FijiXX2NqdykAlR1KmI
         lg2yPDH/28tNCE6Yr2N1sbuurphmnVxmie7SrXCeAolyduBUzSBoG+UWJCuA5K2cUkDs
         wZFDwyrJ4XYyrAFP4maF0Y5KpQ8Gf5ubxWf3LylOeMvWncGCIuSYRQ3DR0b9Wlrvme9L
         oAGw==
X-Gm-Message-State: AO0yUKUkw8FISdfgQGylXHzT97yNVqDC+H0GJQhuk72IVG0Jgsom3R/v
        la0nXBNyL4c5JzHu/Hca8VMqtUoLUqhWk9r1x3318w==
X-Google-Smtp-Source: AK7set/dSnHhKx7xfru8h/OIpFh9QWVOIPiJTQjnvPHex+KDJnAwAPgPl5xSjjDBF4ljOMfSbewKYsv73I29zPJNkVs=
X-Received: by 2002:a05:6902:118c:b0:a06:538f:265f with SMTP id
 m12-20020a056902118c00b00a06538f265fmr14185596ybu.4.1677693282712; Wed, 01
 Mar 2023 09:54:42 -0800 (PST)
MIME-Version: 1.0
References: <20230301022720.1380780-1-surenb@google.com> <20230301141003.xh47kjle2lcezn55@revolver>
In-Reply-To: <20230301141003.xh47kjle2lcezn55@revolver>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 1 Mar 2023 09:54:31 -0800
Message-ID: <CAJuCfpFSbNRqT6svajkOQ=PXcsx-h4N5D8vrvk8F6h7w8EXpEw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/mmap: remove unnecessary vp->vma check in vma_prepare
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, sfr@canb.auug.org.au, error27@gmail.com,
        willy@infradead.org, david@redhat.com, jgg@ziepe.ca,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        mathieu.desnoyers@efficios.com, pasha.tatashin@soleen.com,
        laurent.dufour@fr.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 1, 2023 at 6:10=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracle=
.com> wrote:
>
> * Suren Baghdasaryan <surenb@google.com> [230228 21:27]:
> > vp->vma in vma_prepare() is always non-NULL, therefore checking it is
> > not necessary. Remove the extra check.
> >
> > Fixes: e8f071350ea5 ("mm/mmap: write-lock VMAs in vma_prepare before mo=
difying them")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <error27@gmail.com>
> > Link: https://lore.kernel.org/r/202302281802.J93Nma7q-lkp@intel.com/
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> > Fix cleanly apply over mm-unstable, SHA in "Fixes" is from that tree.
> >
> >  mm/mmap.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 0cd3714c2182..0759d53b470c 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -505,8 +505,7 @@ static inline void init_vma_prep(struct vma_prepare=
 *vp,
> >   */
> >  static inline void vma_prepare(struct vma_prepare *vp)
> >  {
> > -     if (vp->vma)
> > -             vma_start_write(vp->vma);
> > +     vma_start_write(vp->vma);
>
> Would a WARN_ON_ONCE() be worth it?  Maybe not since it will be detected
> rather quickly once we dereference it below, but it might make it more
> clear as to what happened?

WARN_ON_ONCE() seems like an overkill to me. It always follows after
init_multi_vma_prep()/init_vma_prep() both of which set the VMA. Risk
should be minimal here and as you said, misuse is easily discoverable.

>
> I'm happy either way.
>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>
> >       if (vp->adj_next)
> >               vma_start_write(vp->adj_next);
> >       /* vp->insert is always a newly created VMA, no need for locking =
*/
> > --
> > 2.39.2.722.g9855ee24e9-goog
> >
