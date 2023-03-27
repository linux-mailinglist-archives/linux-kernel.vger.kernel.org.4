Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F086CA76F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjC0OXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbjC0OW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:22:58 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17C99036
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:21:08 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id ay14so6430925uab.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679926866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKuYK5+jf7T9DqJhXJ+JZ0y4y7qMH/VbKO9qqnuAuxs=;
        b=kh8lDOAMxoc8av1ujJE3/dVuW9b06WGtGOYaMdKwBgfI81BHN/dxXhhjCGwGPZxXel
         tH1fwtZn5Pfe1c0u/978UxCIF9mZzvzDp7PUJDiKr9tVfeFzBTFkFgZHSgeOPPagKSrZ
         77E8aOOdUpfVtoyp20YievgUOUZNDmdoUtPDU1cjaeT5XiCFGvW6R2VYPKIhkYNk1uET
         E+6Gb8jLprgwrYuM7FcO+NX9oOTEr8ITuQ3l4fSof4+4BbsuIY2tBGh7NcXLaTwVQx3F
         M0S/QgZfPymneMo+87Ac7gfGRbVEMFd7Ub41DLNYUmhr738qvpfThOLo5jrKZxlP+qBI
         7jLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679926866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKuYK5+jf7T9DqJhXJ+JZ0y4y7qMH/VbKO9qqnuAuxs=;
        b=AheAeFEwMDzNdg6eCynGN0wHpkFz7e8ukgJEHN19Vla8sNTXq0n7DupLkFBM+guoo6
         vPcW+VWFRSyCVTZY8zbsQ7REAKHZ/QxX8WmKRczodSyNi+ETLH/wjfIviMdnCFHtXeFS
         ZL1qeM0SqrL9khiWK8OI8YEcE+t6I9Hw7cZ/vhNYX0MfZl4gABENH791t6whV/5wojt9
         TUF6I4JEfPBd9bWrzX0eIxVZXxk3fz3oRZ3HcdKSbIS5LYJepCyFYlcFLfCHao8V4jt5
         6Zeyeg1yOK3QltlFNar1jBbnm48bS1gkWgUCu79lq30syXIwmeuyNzmGgUPRWXduwIGG
         Z4Eg==
X-Gm-Message-State: AAQBX9djl1tJf/FwzjoGrp9CT9j6u/UqlsZZq9yf/v1vUfuDsrDKJECk
        gJBsoMRcIjffE3OyB4hmIs/0SM4sEhiyNj2+sVLY9w==
X-Google-Smtp-Source: AKy350YGrRXdDIBJI1h0+0VBcocr9glOAaxUqLR4hx/SQuOoG3aNn7vr1ctr/We8GQ4wbatp8WmkO+phRKABFGww2Sw=
X-Received: by 2002:a05:6130:c11:b0:687:afc8:ffb9 with SMTP id
 cg17-20020a0561300c1100b00687afc8ffb9mr8516907uab.2.1679926866107; Mon, 27
 Mar 2023 07:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230113193006.1320379-1-bgeffon@google.com> <20230302171348.3601107-1-bgeffon@google.com>
 <ZBx8KEuVtIbqkeq1@google.com>
In-Reply-To: <ZBx8KEuVtIbqkeq1@google.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Mon, 27 Mar 2023 10:20:14 -0400
Message-ID: <CADyq12xaOaOu_5OXRm=YRhYVPmw72d4RQie3b3hHp=-YXoDhAg@mail.gmail.com>
Subject: Re: [PATCH v3] PM: hibernate: don't store zero pages in the image file.
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Mar 23, 2023 at 12:19=E2=80=AFPM Matthias Kaehlcke <mka@chromium.or=
g> wrote:
>

Hi Matthias,
Thanks for taking a look.

> On Thu, Mar 02, 2023 at 12:13:48PM -0500, Brian Geffon wrote:
> > On ChromeOS we've observed a considerable number of in-use pages filled=
 with
> > zeros. Today with hibernate it's entirely possible that saveable pages =
are just
> > zero filled. Since we're already copying pages word-by-word in do_copy_=
page it
> > becomes almost free to determine if a page was completely filled with z=
eros.
> >
> > This change introduces a new bitmap which will track these zero pages. =
If a page
> > is zero it will not be included in the saved image, instead to track th=
ese zero
> > pages in the image file we will introduce a new flag which we will set =
on the
> > packed PFN list. When reading back in the image file we will detect the=
se zero
> > page PFNs and rebuild the zero page bitmap.
> >
> > When the image is being loaded through calls to write_next_page if we e=
ncounter
> > a zero page we will silently memset it to 0 and then continue on to the=
 next
> > page. Given the implementation in snapshot_read_next/snapshot_write_nex=
t this
> > change  will be transparent to non-compressed/compressed and swsusp mod=
es of
> > operation.
> >
> > To provide some concrete numbers from simple ad-hoc testing, on a devic=
e which
> > was lightly in use we saw that:
> >
> >   PM: hibernation: Image created (964408 pages copied, 548304 zero page=
s)
> >
> > Of the approximately 6.2GB of saveable pages 2.2GB (36%) were just zero=
 filled
> > and could be tracked entirely within the packed PFN list. The savings w=
ould
> > obviously be much lower for lzo compressed images, but even in the case=
 of
> > compression not copying pages across to the compression threads will st=
ill
> > speed things up. It's also possible that we would see better overall co=
mpression
> > ratios as larger regions of "real data" would improve the compressibili=
ty.
> >
> > Finally, such an approach could dramatically improve swsusp performance
> > as each one of those zero pages requires a write syscall to reload, by
> > handling it as part of the packed PFN list we're able to fully avoid
> > that.
> >
> >  Patch v2 -> v3:
> >    - Use nr_zero_pages rather than walking each pfn to count.
> >    - Make sure zero_bm is allocated in safe pages on resume.
> >      When reading in the pfn list and building the zero page bm
> >      we don't know which pages are unsafe yet so we will need to
> >      copy this bm to safe pages after the metadata has been read.
> >
> >  Patch v1 -> v2:
> >    - minor code mistake from rebasing corrected.
> >
> > Signed-off-by: Brian Geffon <bgeffon@google.com>
> > ---
> >  kernel/power/snapshot.c | 169 +++++++++++++++++++++++++++++++---------
> >  1 file changed, 133 insertions(+), 36 deletions(-)
> >
> > diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> > index cd8b7b35f1e8b..a2c4fe17f9067 100644
> > --- a/kernel/power/snapshot.c
> > +++ b/kernel/power/snapshot.c
>
> ...
>
> > @@ -1371,14 +1381,18 @@ static unsigned int count_data_pages(void)
> >
> >  /*
> >   * This is needed, because copy_page and memcpy are not usable for cop=
ying
> > - * task structs.
> > + * task structs. Returns 1 if a page was filled with only zeros, other=
wise 0.
>
> nit: s/a page/the page/

Ack. will fix in follow up version.

>
> >   */
> > -static inline void do_copy_page(long *dst, long *src)
> > +static inline int do_copy_page(long *dst, long *src)
> >  {
> >       int n;
> > +     long z =3D 0;
> >
> > -     for (n =3D PAGE_SIZE / sizeof(long); n; n--)
> > +     for (n =3D PAGE_SIZE / sizeof(long); n; n--) {
> > +             z |=3D *src;
> >               *dst++ =3D *src++;
> > +     }
> > +     return !z;
> >  }
>
> ...
>
> > -static inline void copy_data_page(unsigned long dst_pfn, unsigned long=
 src_pfn)
> > +static inline int copy_data_page(unsigned long dst_pfn, unsigned long =
src_pfn)
> >  {
> > -     safe_copy_page(page_address(pfn_to_page(dst_pfn)),
> > +     return safe_copy_page(page_address(pfn_to_page(dst_pfn)),
> >                               pfn_to_page(src_pfn));
> >  }
> >  #endif /* CONFIG_HIGHMEM */
> >
> >  static void copy_data_pages(struct memory_bitmap *copy_bm,
> > -                         struct memory_bitmap *orig_bm)
> > +                         struct memory_bitmap *orig_bm,
> > +                         struct memory_bitmap *zero_bm,
> > +                         unsigned int *zero_count)
> >  {
> >       struct zone *zone;
> > -     unsigned long pfn;
> > +     unsigned long pfn, copy_pfn;
> >
> >       for_each_populated_zone(zone) {
> >               unsigned long max_zone_pfn;
> > @@ -1462,11 +1482,20 @@ static void copy_data_pages(struct memory_bitma=
p *copy_bm,
> >       }
> >       memory_bm_position_reset(orig_bm);
> >       memory_bm_position_reset(copy_bm);
> > +     copy_pfn =3D memory_bm_next_pfn(copy_bm);
> >       for(;;) {
> >               pfn =3D memory_bm_next_pfn(orig_bm);
> >               if (unlikely(pfn =3D=3D BM_END_OF_MAP))
> >                       break;
> > -             copy_data_page(memory_bm_next_pfn(copy_bm), pfn);
> > +             if (copy_data_page(copy_pfn, pfn)) {
> > +                     memory_bm_set_bit(zero_bm, pfn);
> > +                     if (zero_count)
>
> This check is not needed. The function is called only once, with a pointe=
r. The kernel
> trusts itself if the pointer is supposed to be always !=3D NULL.
>
> Or better: use a local counter and have copy_data_pages() return the numb=
er of pages
> that were actually copied, which is what the caller is interested in.

That makes a lot of sense, I'll switch to this approach in next iteration.

>
> > +                             (*zero_count)++;
> > +
> > +                     /* We will reuse this copy_pfn for a real 'nonzer=
o' page. */
> > +                     continue;
> > +             }
> > +             copy_pfn =3D memory_bm_next_pfn(copy_bm);
> >       }
> >  }
>
> ...
>
> > @@ -2247,24 +2299,34 @@ static int load_header(struct swsusp_info *info=
)
> >   * unpack_orig_pfns - Set bits corresponding to given PFNs in a memory=
 bitmap.
> >   * @bm: Memory bitmap.
> >   * @buf: Area of memory containing the PFNs.
> > + * @zero_bm: Memory bitmap which will be populated with the PFNs of ze=
ro pages.
> >   *
> >   * For each element of the array pointed to by @buf (1 page at a time)=
, set the
> > - * corresponding bit in @bm.
> > + * corresponding bit in @bm. If the the page was originally populated =
with only
> > + * zeros then a corresponding bit will also be set in @zero_bm.
>
> s/the the/the/

Ack.

>
> ...
>
> > @@ -2486,6 +2548,7 @@ static inline void free_highmem_data(void) {}
> >   * prepare_image - Make room for loading hibernation image.
> >   * @new_bm: Uninitialized memory bitmap structure.
> >   * @bm: Memory bitmap with unsafe pages marked.
> > + * @zero_bm: Memory bitmap containing the zero pages.
>
> That sounds as if the memory bitmap actually contained zero pages. I sugg=
est to
> change it to something like the comment for 'bm' above, i.e. "... with ze=
ro
> pages marked"

Sure that makes sense, will reword it.

>
> >   *
> >   * Use @bm to mark the pages that will be overwritten in the process o=
f
> >   * restoring the system memory state from the suspend image ("unsafe" =
pages)
> > @@ -2496,8 +2559,12 @@ static inline void free_highmem_data(void) {}
> >   * pages will be used for just yet.  Instead, we mark them all as allo=
cated and
> >   * create a lists of "safe" pages to be used later.  On systems with h=
igh
> >   * memory a list of "safe" highmem pages is created too.
> > + *
> > + * Because we didn't know which pages were unsafe when we created the =
zero bm we
> > + * will make a copy of it and recreate it within safe pages.
>
> nit: s/we will make/we make/

Ack.

>
> >   */
> > -static int prepare_image(struct memory_bitmap *new_bm, struct memory_b=
itmap *bm)
> > +static int prepare_image(struct memory_bitmap *new_bm, struct memory_b=
itmap *bm,
> > +             struct memory_bitmap *zero_bm)
> >  {
> >       unsigned int nr_pages, nr_highmem;
> >       struct linked_page *lp;
> > @@ -2516,6 +2583,20 @@ static int prepare_image(struct memory_bitmap *n=
ew_bm, struct memory_bitmap *bm)
> >
> >       duplicate_memory_bitmap(new_bm, bm);
> >       memory_bm_free(bm, PG_UNSAFE_KEEP);
> > +     error =3D memory_bm_create(bm, GFP_ATOMIC, PG_ANY);
> > +     if (error)
> > +             goto Free;
> > +
> > +     /* use bm as storage while we rebuild zero_bm using safe pages */
>
> Re-using the 'bm' parameter is confusing, it should be avoided IMO unless=
 there
> is a real benefit. struct memory_bitmap isn't that big, why not create a =
local
> variable 'zero_mb_tmp' or similar as a temporary store for the zero page =
bitmap?

Sure, I'll send an updated patch which does that.

>
> > +     duplicate_memory_bitmap(bm, zero_bm);
> > +     memory_bm_free(zero_bm, PG_UNSAFE_KEEP);
> > +     error =3D memory_bm_create(zero_bm, GFP_ATOMIC, PG_SAFE);
> > +     if (error)
> > +             goto Free;
> > +     duplicate_memory_bitmap(zero_bm, bm);
> > +     memory_bm_free(bm, PG_UNSAFE_KEEP);
> > +     /* at this point zero_bm is in safe pages and we can use it while=
 restoring */
> > +
> >       if (nr_highmem > 0) {
> >               error =3D prepare_highmem_image(bm, &nr_highmem);
> >               if (error)
