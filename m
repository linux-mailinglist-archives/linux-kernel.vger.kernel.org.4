Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B2969E8B3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 20:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjBUT7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 14:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBUT66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 14:58:58 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27564693
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 11:58:56 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id f23so5643044vsa.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 11:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677009536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DF0KNJghjUV7wJh512cQZNMEw1nvR5xMFp/83eAe6+M=;
        b=O7FR1DNzUbas3YRCPSnDIgVMvpW4evNW+U818zCom4X2UeJi0dgPlpatukFFI2jHgl
         OLA0ICVxN68LNdowqQZRw6YHeqBtycyj86+YWkW+5KpqEnPFJt3igdN1lLkWng/LQsWW
         0BOp77eVuiaBlAdmzWVcN2/3QK2Xzc5aJcA97ywETPAbbzdXmNdDIyvPYqMo66Exdsw+
         5FQJdLLddxwcyJTQHWAU6PrsXeYpIZDtGdRow0xNfF47aCF4UvTARQb7JmKfrXpPIXtd
         BbMClX41M3PoQ5RIR/L+eneSMsgJLXAbsESqIUDraACr5YEtlUBpSBXTCaUdbVOXyawZ
         ze6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677009536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DF0KNJghjUV7wJh512cQZNMEw1nvR5xMFp/83eAe6+M=;
        b=BlqaJi7HW9zcHPSayakojhBr14LWIqzoelTQ1I+xjqVuXnk83g4pqYg06GPiuYQFbh
         XD7bI++o9i/L0CR8D0c5vF7ddbUn7XX5wwymoHuidxUjFaQIrhGx2nqZ6wd70nqEJSKj
         99JGdl7hcFEcEYQlctI6enFAjm6xxeHSBdj5RUNJImNofG6jMykBDOZ8/FFHX8x682qL
         IXQrR0ecxOED11M84NY3nSEJvT+k7OPhiEI2A/zwF48tjFS3osqjKs2ArgRbjSgnjPSk
         R6X1ay4GI8hxrqEeTEoEC0FyXvqUOGp09xd/g2iYHJUCPWPtCQTqlqmygwKlUHA6G79j
         f3sg==
X-Gm-Message-State: AO0yUKUTZuiLuGQg/UfOciwnz7aGUH4p1K0lImfTDlbxFLusxJQLi9DK
        nL/pu6QdXS7gFmw2DjgJ2xqiVck17cRWQnWpBd2NqQ==
X-Google-Smtp-Source: AK7set/OBfSTihP3rfzNxKV6mPiXYOTPbFTsjj4Q9W0m/pL2cgeM0fB1vkcpq/SRM9VoGG1lEOcmqmbxlnCbND7aURk=
X-Received: by 2002:a67:e081:0:b0:41e:910f:10ed with SMTP id
 f1-20020a67e081000000b0041e910f10edmr803070vsl.11.1677009535939; Tue, 21 Feb
 2023 11:58:55 -0800 (PST)
MIME-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
 <20230218002819.1486479-2-jthoughton@google.com> <CAHS8izM5Es+DMiOyPt93o6Xw+SeuOR45r+MMoeagiYN594NiyQ@mail.gmail.com>
 <CADrL8HWTe1b2UK4Ha6e=F_i+YSK_M4wXCQ-sxvYMkgR1EgaHpA@mail.gmail.com> <Y/UcorZlyHC44/T5@monkey>
In-Reply-To: <Y/UcorZlyHC44/T5@monkey>
From:   James Houghton <jthoughton@google.com>
Date:   Tue, 21 Feb 2023 11:58:19 -0800
Message-ID: <CADrL8HUXTOg+ZjOU=63M_iRn2Km0FVZ3atYBVsqaCap8ww8Sbg@mail.gmail.com>
Subject: Re: [PATCH v2 01/46] hugetlb: don't set PageUptodate for UFFDIO_CONTINUE
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Tue, Feb 21, 2023 at 11:34 AM Mike Kravetz <mike.kravetz@oracle.com> wro=
te:
>
> On 02/21/23 07:59, James Houghton wrote:
> > On Fri, Feb 17, 2023 at 4:42 PM Mina Almasry <almasrymina@google.com> w=
rote:
> > >
> > > On Fri, Feb 17, 2023 at 4:28=E2=80=AFPM James Houghton <jthoughton@go=
ogle.com> wrote:
> > > >
> > > > If would be bad if we actually set PageUptodate with UFFDIO_CONTINU=
E;
> > > > PageUptodate indicates that the page has been zeroed, and we don't =
want
> > > > to give a non-zeroed page to the user.
> > > >
> > > > The reason this change is being made now is because UFFDIO_CONTINUE=
s on
> > > > subpages definitely shouldn't set this page flag on the head page.
> > > >
> > > > Signed-off-by: James Houghton <jthoughton@google.com>
> > > >
> > > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > > index 07abcb6eb203..792cb2e67ce5 100644
> > > > --- a/mm/hugetlb.c
> > > > +++ b/mm/hugetlb.c
> > > > @@ -6256,7 +6256,16 @@ int hugetlb_mcopy_atomic_pte(struct mm_struc=
t *dst_mm,
> > > >          * preceding stores to the page contents become visible bef=
ore
> > > >          * the set_pte_at() write.
> > > >          */
> > > > -       __folio_mark_uptodate(folio);
> > > > +       if (!is_continue)
> > > > +               __folio_mark_uptodate(folio);
> > > > +       else if (!folio_test_uptodate(folio)) {
> > > > +               /*
> > > > +                * This should never happen; HugeTLB pages are alwa=
ys Uptodate
> > > > +                * as soon as they are allocated.
> > > > +                */
> > >
> > > if (is_continue) then we grab a page from the page cache, no? Are
> > > pages in page caches always uptodate? Why? I guess that means they're
> > > mapped hence uptodate?
> > >
> > > Also this comment should explain why pages in the page cache are
> > > always uptodate, no? Because this error branch is hit if (is_continue
> > > && !folio_test_uptodate()), not when pages are freshly allocated.
> >
> > There was some discussion about it here[1].
> >
> > Without even thinking about how the pages become uptodate, I think
> > this patch is justified like this: UFFDIO_CONTINUE =3D> we aren't
> > actually changing the contents of the page, so we shouldn't be
> > changing the uptodate-ness of the page.
>
> Agree!
>
> > HugeTLB pages in the page cache are always uptodate:
> > 1. fallocate -- the page is allocated, zeroed, marked as uptodate, and
> > then placed in the page cache.
> > 2. hugetlb_no_page -- same as above.
> >
> > So uptodate <=3D> "the page has been zeroed", so it would be very bad i=
f
> > we gave a !uptodate page to userspace via UFFDIO_CONTINUE.
> >
> > I'll update the comment to something like:
> >
> > "HugeTLB pages are always Uptodate as soon as they are added to the
> > page cache. Given that we aren't changing the contents of the page, we
> > shouldn't be updating the Uptodate-ness of the page."
>
> Perhaps a better way of saying is that hugetlb pages are marked uptodate
> shortly after allocation when their contents are initialized.  Initialize=
d
> data could be zero, or it could be contents copied from another location
> (such as in the UFFDIO_COPY case also handled in this routine).

I'll write something like this. Thank you!

>
> Saying "PageUptodate indicates that the page has been zeroed" as in the
> commit message is technically not correct.

And I'll make sure to update the commit description as well.

>
> Ack to the patch.

Thanks, Mike!
