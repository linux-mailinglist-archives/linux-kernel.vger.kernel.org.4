Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7B96AB4B6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 03:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjCFCpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 21:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCFCpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 21:45:14 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5B3EFB1
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 18:45:12 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id z5so8169371ljc.8
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 18:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678070711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkxVEOnLXdzZ8oxAMds+zBzrKmQ/RUz5Y0ymy8fjSrA=;
        b=HGDh2jGGctTOgHb/Q39GRM38SU7nBEdTwe+fvmwy0w8aUkYBmxGtNMUGn5Ri6WG1BM
         8F5Sei844wfe1Bl0iWqEbrbiTVuVjBLDig/bdKh8N6hlII/1/i1nYGvFi30Dqa6AkdKI
         dLxyJNfaQz+69th1K95kd4dObvSCCDWRJEfnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678070711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AkxVEOnLXdzZ8oxAMds+zBzrKmQ/RUz5Y0ymy8fjSrA=;
        b=d0s4pbMeL11WnjwYX0P3E5gG+qDGLOwjnmYne9m3aidfnLHz4/dghlMrttrm4jL8KS
         Yxgol0j2QVyXFllwIf7pXzz6SimKWrrVgAlj/woIE6wxE956afKYYz7qlEVWjr8DhTsK
         DB6mp9Z2BvPjyxmF14ajld+whtNiZHT1TzMTLwFpAdyDKvB/3Nm1BiFuWjgT0KAMS2WS
         Q3gTBSWQ8y8YhfWDB0c4eVBovOK2vaQWa6eMklx8EXV+p+WdPO9IXdz+nLEEzf7fPkIr
         FnyWxoJFSf4bYhWCCTXnC0M4G5BBQ5iLsm1b2bKOLvP3P1gH0g0OxMjoXEyYoFL+y/3n
         RAWg==
X-Gm-Message-State: AO0yUKVUPVBFGd2tp75rSVKKUzbmmS55TIaOQmB6/sfdHg8EMG3cTB76
        jvwCjCXTZcx2cDgWXyMYV1xAYkF6o0ZqchbsyG1jzQ==
X-Google-Smtp-Source: AK7set/6UwLe2xvdiAfPdHv93LUIof3Ti2CMS0E5ffkC1d0PMIO3LiOXGDCjMJOQUuPgXgEC4k0In8r3kwXQ6Pgh7qs=
X-Received: by 2002:a2e:a4b0:0:b0:295:b0cc:d99c with SMTP id
 g16-20020a2ea4b0000000b00295b0ccd99cmr2680702ljm.6.1678070710712; Sun, 05 Mar
 2023 18:45:10 -0800 (PST)
MIME-Version: 1.0
References: <20230217085439.2826375-1-stevensd@google.com> <ZAIT2YI4WrzZK5NK@x1n>
 <20230303145258.866b985b21b3ccd9bc41bc4b@linux-foundation.org>
In-Reply-To: <20230303145258.866b985b21b3ccd9bc41bc4b@linux-foundation.org>
From:   David Stevens <stevensd@chromium.org>
Date:   Mon, 6 Mar 2023 11:44:59 +0900
Message-ID: <CAD=HUj5Ygjyi9pNryH=VSKOUFCvvCcMFtRRAYM0Vdr9LP4mtaA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] mm/khugepaged: fix khugepaged+shmem races
To:     Andrew Morton <akpm@linux-foundation.org>,
        "jiaqiyan@google.com" <jiaqiyan@google.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        "Zach O'Keefe" <zokeefe@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 4, 2023 at 7:53=E2=80=AFAM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Fri, 3 Mar 2023 10:35:53 -0500 Peter Xu <peterx@redhat.com> wrote:
>
> > On Fri, Feb 17, 2023 at 05:54:36PM +0900, David Stevens wrote:
> > > From: David Stevens <stevensd@chromium.org>
> > >
> > > Fix two races in khugepaged+shmem that cause issues with userfaultfd =
and
> > > lseek, respectively.
> > >
> > > v3 -> v4:
> > >  - Base changes on mm-everything (fba720cb4dc0)
> > >  - Add patch to refactor error handling control flow in collapse_file
> > >  - Rebase userfaultfd patch with no significant logic changes
> > >  - Different approach for fixing lseek race
> >
> > I just noticed this one hasn't landed unstable, so I guess I just poste=
d a
> > trivial cleanup that can conflict with this so it won't apply cleanly..
> >
> > https://lore.kernel.org/r/20230303151218.311015-1-peterx@redhat.com
> >
> > The resolution will be fairly straightforward though, and I'm happy to
> > rebase that one to this since this targets a real bug so should have hi=
gher
> > priority.
>
> Even without the above patch ("mm/khugepaged: Cleanup memcg uncharge
> for failure path") I'm seeing a big reject in khugepaged.c.  Might be
> easily fixed, didn't look.
>
> > I guess it's possible Andrew thought the series has unsettled comment s=
o
> > Andrew could just have ignored that whole set in the mark ups.  A repos=
t
> > could possibly clarify that.
>
> Yes please.  Lets gather the acks thus far, rebase on
> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm's mm-unstable
> branch and resend?

This conflicts pretty heavily with the "Memory poison recovery in
khugepaged collapsing" series. This series was written on top of v9 of
that series, but it looks like v9 of that series was dropped and is
being replaced with v10. Which series should go in first? If we're
confident that v10 of that series won't also be dropped, then rebasing
this series onto v10 of that series should be pretty easy. Otherwise
we could try reworking things to minimize conflicts between the two
series (create a 0th refactoring series?). Andrew, what course would
you prefer?

-David

> > Again, it'll always great to get another eye on this slightly involved
> > series. Matthew / Yang were already on the list, also copying Zach for =
his
> > recent works on khugepaged just in case he spots anything wrong.
>
