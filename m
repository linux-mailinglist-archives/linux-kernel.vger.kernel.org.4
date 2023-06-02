Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96CC71F90E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 05:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjFBD7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 23:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjFBD7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 23:59:15 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BF8194
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 20:59:13 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3f6affdb6ddso16339001cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 20:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685678352; x=1688270352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6z0pOwW+tzc6u3dQO09lUEAzP/cM45yNrex7nu7vvs=;
        b=BELBIGFRJ9f9hjm+T7CxnQxnjgbCYKIp+P5u8N616hIvSPC9IAfXUGQ9kMkCQH00mi
         QX8nx71Zt+iFS7h0BFWanE6Nuplrf6q8AfldzNcYbEPIRGbadURu7Wh+96VQ6YmeRw/U
         hN2Z3MZbVOeJiGQQJ45k+nwOau5x4Y0eB5GHyEuD7ddslmuy/p2GKvEYvubylnW4x97R
         q1EVu3G12YRRsbV0/bsuXVq+6aL6UMfLgGLvdvnS8pC4L+cBDHAIDRr0I0j4wdCDFROc
         887MvHaIsxAzfYLrQqSzBi5re3uaPnG3tflAl3oCBIPZ+vwGAKI5Fvgi34EHiqCcNjYH
         xNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685678352; x=1688270352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6z0pOwW+tzc6u3dQO09lUEAzP/cM45yNrex7nu7vvs=;
        b=eI8hyaIC0tYXAzNtCL1Nws/CuZGtg7nVXjft+kUjGS99NqllDXXUGdheTfY69RjvIL
         VvxL4xvFYBjtD1ft1yjIqh4HoI6VA7ayzwHRMM9rHnuTHlDaUrgTkE6aQ6HZo9J+TALG
         acU0jpPYsBIfYWHw1yXMKXR8EUtMQJPH5efJNF6MquI4Sc1unrtYAXXsvyE8c1auCoby
         VVlakQUkrX03suePtZJ17qyhJlg6gPt5r+aWpfyZn0dXQX0OgWUgt6o6FnrWlOUc9n2U
         DGhVpXrUnFO+bx1Bs3jNBZ0AZ6fMgnwzRl9b9AdvqdNbvrrCd31QuBR2JtQ6q4vdKRKs
         fltQ==
X-Gm-Message-State: AC+VfDyQqsT9eEry/2htEuYQonN10G9W2SgGjONdMCiWJTas8T/XnnYf
        rcr50f4OKgV3EnLjJqKbYHK5Ks2DuI+y3GTEdztwMbgQ
X-Google-Smtp-Source: ACHHUZ6kDuCppx03TXN8lAXx23C3PZQDmt0gWzCClgDfSZEBsDU7b6eAcCl66q4t0bXJfYb90UxXyxizjKK3erSBdeE=
X-Received: by 2002:a05:622a:1454:b0:3f6:bb5b:8111 with SMTP id
 v20-20020a05622a145400b003f6bb5b8111mr15420315qtx.60.1685678352143; Thu, 01
 Jun 2023 20:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221217001554.554913-1-lstoakes@gmail.com> <Y51L496TjNuiSxsG@casper.infradead.org>
 <Y51/Mt70d++6Zzzq@lucifer> <20221219100734.jag6zejp4tug77yq@techsingularity.net>
 <CAA5enKbsmy99-GCNuVcDRbjESZaLuE4=s8+6PzWP8J-wmOZwEg@mail.gmail.com>
 <CAHbLzkoSC7Q+xAMaSoNihn2eww-+5RZADxe5h7_FidGHELE3BQ@mail.gmail.com> <20230601091002.zl3udcqxmb3tjtri@techsingularity.net>
In-Reply-To: <20230601091002.zl3udcqxmb3tjtri@techsingularity.net>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 1 Jun 2023 20:59:00 -0700
Message-ID: <CAHbLzkp3T==kHPq2f562YFdzDMXjZm3ts=V3iPHx6RSZs8ywtA@mail.gmail.com>
Subject: Re: [PATCH] mm: remove unused alloc_pages_bulk_list()
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Marco Elver <elver@google.com>,
        Michal Hocko <mhocko@suse.com>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 1, 2023 at 2:10=E2=80=AFAM Mel Gorman <mgorman@techsingularity.=
net> wrote:
>
> On Wed, May 31, 2023 at 02:29:01PM -0700, Yang Shi wrote:
> > On Wed, May 31, 2023 at 8:24???AM Lorenzo Stoakes <lstoakes@gmail.com> =
wrote:
> > >
> > > On Mon, 19 Dec 2022 at 10:07, Mel Gorman <mgorman@techsingularity.net=
> wrote:
> > > >
> > > > On Sat, Dec 17, 2022 at 08:34:58AM +0000, Lorenzo Stoakes wrote:
> > > > I reckon we should give it another few months until May. There has =
been
> > > > one user recently that tried to use list but it turned out arrays w=
ere
> > > > more appropriate.
> > > >
> > >
> > > It being May 31st, it feels appropriate to chase this up :)
> > >
> > > David's series at [0] did initially use this function, before
> > > switching to the _array() variant. Other than that it seems that it
> > > remains unused.
> >
> > Thanks for following this up. My patchset (use bulk allocator for
> > dm-crypt) also switched from list API to a new callback API suggested
> > by Mel. But I haven't heard anything back from Mel about it yet. I
> > forgot to follow up due to too many distractions.
> >
>
> It needs a follow-up. My various inboxes that I get cc'd on currently exc=
eed
> 1000 mails due to being offline a lot during the last few months so there
> could be a lot hiding in there. Conceptually at least I don't recall havi=
ng
> any problem with the callback patches as long as the dm-crypt people are
> happy. I vaguely recall a review disappeared off into the weeds talking
> about maybe using physically contiguous pages (missing the point of using
> the bulk allocator at all and ignoring fragmentation concerns affecting
> allocation success rates) but I'm not certain.

Yes, other than that someone also complained the changeset is too big,
and suggested just try to allocate compound page and fallback to the
mempool allocator if that fails instead of creating a dedicated
mempool API.

Do you prefer follow up in that v2 thread or I send a new v3
(basically same with v2, just rebased on the latest mm-unstable)?

>
> --
> Mel Gorman
> SUSE Labs
