Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BDF6CF868
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 02:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjC3A6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 20:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjC3A6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 20:58:41 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6574ED4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 17:58:40 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id w9so70343345edc.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 17:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680137918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=su0gIjKrNXbtaF8LQ8xZK0mtSIWjgnLtGXQ4zlfGIYQ=;
        b=WEXfDUGXYmXh859yKLvna3F3O6cnWUDpZexV58P6WEGdNfB5Nd4xfh3zdYamjP67bX
         6EfYoqmHRSU4Vaoo15AYIf0CnX1lcS/BHfKE1WA150zf8OCJGmueOZD4iCwZRysujJfI
         rpL8b1EhGGmItvwfEs5V5ZK36C92Ae7tm/pkG6YaPVavMos4drXFJGrL6qguaSFhwUEE
         ltz1iJr2Bgd3zPjgIt7F5E4BGm7u5phTfDS+rEjoSnWhOGp/W9zJewhi/Cl3IxzBh377
         AEYgIOneC29WK6ZuASSG4nBdWXYudwhG0Nk8fM+EnjS95zu2DJBZamrb5LEIuZRaOf8x
         0CNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680137918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=su0gIjKrNXbtaF8LQ8xZK0mtSIWjgnLtGXQ4zlfGIYQ=;
        b=qhhtGGcnlUl/aZXnco2mEAoQqS8xTsqfmtCyTdypdiyFVmPH43Xl0t9XdYd76zPo92
         mfxQRAcyK8VExlzo4eQCFfoZCqA2bDQO25io3CVJH/OzCRJxCF573plovW2Fph90F5H8
         t9qvESAt2c4MyNwzObTqVeMm+HYV+iEwCKnlOEJ2injCXim6C3pFg+/Ym8OSjtuNfVSZ
         u8YUyeXNhPlAa7hKgEH5Oo6sxozsMZM4+cF8pfcUcxslRxyI1zxRVAOOSVQRXUjkMnDK
         PTexVRNkXOxgWd/HAzVflMhlv4GOPkQNMqQpuVLVYZp3yvb+pVkccvXZzg73q0MUGdYZ
         khiQ==
X-Gm-Message-State: AAQBX9eTDDYD28HrKT8bh8l6NYDfARN6YnWS5ySi/rJg4JSV1W9/Xsrj
        fbB88Wj3R3w1gvZexVUzrzysGbpXSxZ6CGh+H990SA==
X-Google-Smtp-Source: AKy350b53e6+XRogiX+Qi8FwDcW8/73RPONebml/PIb/IzEz/4R5hJRzEC0HD1YmwJoodG2Cjd5GvTqDGOGIz6a/GDM=
X-Received: by 2002:a17:907:d412:b0:930:310:abbf with SMTP id
 vi18-20020a170907d41200b009300310abbfmr10584206ejc.11.1680137918431; Wed, 29
 Mar 2023 17:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230329145330.23191-1-ivan.orlov0322@gmail.com>
 <20230329145304.66add47ba9b9fafb71b1e13d@linux-foundation.org> <CAHbLzko=aWBPk5a1P2fgR9yAgc52WG-HX_OBV8=iWFy_D4_eNQ@mail.gmail.com>
In-Reply-To: <CAHbLzko=aWBPk5a1P2fgR9yAgc52WG-HX_OBV8=iWFy_D4_eNQ@mail.gmail.com>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Wed, 29 Mar 2023 17:58:01 -0700
Message-ID: <CAAa6QmQx6QrC451QqC2KQx+XUU5mFuWbzR07cosHFsrr6W-hvw@mail.gmail.com>
Subject: Re: [PATCH] mm: khugepaged: Fix kernel BUG in hpage_collapse_scan_file
To:     Yang Shi <shy828301@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ivan Orlov <ivan.orlov0322@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, himadrispandya@gmail.com,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+9578faa5475acb35fa50@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 5:14=E2=80=AFPM Yang Shi <shy828301@gmail.com> wrot=
e:
>
> On Wed, Mar 29, 2023 at 2:53=E2=80=AFPM Andrew Morton <akpm@linux-foundat=
ion.org> wrote:
> >
> > On Wed, 29 Mar 2023 18:53:30 +0400 Ivan Orlov <ivan.orlov0322@gmail.com=
> wrote:
> >
> > > Syzkaller reported the following issue:
> > >
> > > ...
> > >
> > > The 'xas_store' call during page cache scanning can potentially
> > > translate 'xas' into the error state (with the reproducer provided
> > > by the syzkaller the error code is -ENOMEM). However, there are no
> > > further checks after the 'xas_store', and the next call of 'xas_next'
> > > at the start of the scanning cycle doesn't increase the xa_index,
> > > and the issue occurs.
> > >
> > > This patch will add the xarray state error checking after the
> > > 'xas_store' and the corresponding result error code.
> > >
> > > Tested via syzbot.
> > >
> > > Reported-by: syzbot+9578faa5475acb35fa50@syzkaller.appspotmail.com
> > > Link: https://syzkaller.appspot.com/bug?id=3D7d6bb3760e026ece7524500f=
e44fb024a0e959fc
> > > Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> > > ---
> > >  mm/khugepaged.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > index 92e6f56a932d..4d9850d9ea7f 100644
> > > --- a/mm/khugepaged.c
> > > +++ b/mm/khugepaged.c
> > > @@ -55,6 +55,7 @@ enum scan_result {
> > >       SCAN_CGROUP_CHARGE_FAIL,
> > >       SCAN_TRUNCATED,
> > >       SCAN_PAGE_HAS_PRIVATE,
> > > +     SCAN_STORE_FAILED,
> > >  };
> > >
> > >  #define CREATE_TRACE_POINTS
> > > @@ -1840,6 +1841,15 @@ static int collapse_file(struct mm_struct *mm,=
 unsigned long addr,
> > >                                       goto xa_locked;
> > >                               }
> > >                               xas_store(&xas, hpage);
> > > +                             if (xas_error(&xas)) {
> > > +                                     /* revert shmem_charge performe=
d
> > > +                                      * in the previous condition
> > > +                                      */
> > > +                                     mapping->nrpages--;
> > > +                                     shmem_uncharge(mapping->host, 1=
);
> > > +                                     result =3D SCAN_STORE_FAILED;
> > > +                                     goto xa_locked;
> > > +                             }
> > >                               nr_none++;
> > >                               continue;
> > >                       }
> >
> > Needs this, I assume.
> >
> > --- a/include/trace/events/huge_memory.h~mm-khugepaged-fix-kernel-bug-i=
n-hpage_collapse_scan_file-fix
> > +++ a/include/trace/events/huge_memory.h
> > @@ -36,7 +36,8 @@
> >         EM( SCAN_ALLOC_HUGE_PAGE_FAIL,  "alloc_huge_page_failed")      =
 \
> >         EM( SCAN_CGROUP_CHARGE_FAIL,    "ccgroup_charge_failed")       =
 \
> >         EM( SCAN_TRUNCATED,             "truncated")                   =
 \
> > -       EMe(SCAN_PAGE_HAS_PRIVATE,      "page_has_private")            =
 \
> > +       EM( SCAN_PAGE_HAS_PRIVATE,      "page_has_private")            =
 \
> > +       EMe(SCAN_STORE_FAILED,          "store_failed")
>
> I'm a little bit reluctant to make the error code list longer, can we
> just return SCAN_FAIL? IIUC this issue should happen very rarely,
> maybe not worth a new error code.
>
> Basically the rollback approach makes sense to me. IIRC Zach was
> looking into the same problem, loop him in. He may share some
> thoughts.

Thanks Yang, appreciate being brought into the loop. One of the things
I plan to do during paternity leave is update my email filters so I
don't miss things like this.

Coincidentally, Hugh also just brought this to my attention. Looks to
be the syzkaller report posted a few weeks ago[1].

Given there are two series munging with this path right now (or were),
I was trying to find time to first review said series, then post a fix
on top, if necessary (or it could have been incorporated into David
Stevens' "mm/khugepaged: fix khugepaged+shmem races" series).

But, I'm perennially behind and haven't been able to find time to do
those reviews, and so my "fix" attempt has sat. Thanks, Ivan, for
picking up the slack.

So, I did test this patch with the syzbot reproducer, and everything
looked good :) Thank you.

I have similar reservations about increasing the error code list
longer, unless there is opportunity to combine other failure sites
under a common umbrella. For example, I was debating if a SCAN_OOM
error was worthy of inclusion, which we could use in
__collapse_huge_page_swapin() on VM_FAULT_OOM. I personally went the
route of saying, "no, just use SCAN_FAIL".

There also ought to be some comments, somewhere (either in code, or
commit description) about why this is the only xas_store() site that
deserves special error handling. I was planning on suggesting to
sprinkle in a few VM_BUG_ON()'s after some of these sites, with a
comment, just in case the implementation of xarray changes and
operations which previously didn't require allocating memory now do
so. At least to me, it took work to sort it out, so I don't think it's
obvious.

Now, as mentioned, I'm headed on paternity leave starting Friday,
until July 12. So, if there is a v2, I'm likely to miss it, and even
Cc'ing me isn't likely to get a response :) As such, feel free to have
my

Tested-by: Zach O'Keefe <zokeefe@google.com>

now, since I've validated it works. My understanding is that no other
callsites need attention, so I believe this bug is "fixed" -- all that
remains is dealing with the error codes, comments, assertions, etc.

Thanks again, Ivan,

Best,
Zach

[1] https://lore.kernel.org/linux-mm/000000000000226a6105f6954b47@google.co=
m/

> >
> >  #undef EM
> >  #undef EMe
> > _
> >
> >
