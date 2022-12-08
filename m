Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3AE64684F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 05:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiLHEma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 23:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiLHEmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 23:42:16 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF6E98950
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 20:42:14 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id n7so231174wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 20:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/PvhyblV7HKQCmFJuCM8xjUeOCgi9qEWjiHxHwW/fc=;
        b=bxVEtj9id7NYGZWl5RP1fEHo9S7pZWpFPtW459Zq4i26NcLBhq4fFkGimTzsXqYGV9
         tqNGoSWXTYlF+aqK4r6Omvq4Ib/HxORussF8BE3wjR8tq6P8l8V9Fbr7f+Ns74bWujMd
         3QmmNRJFzhdXPv3LhqvcQYFz6sHimKnVddADlr2EJjzLFWBjvygGaq19JE8Dp+L6f9xQ
         fmE/4OzaFfvYI6vxGf8O2gAvuaE3olog9u4xBtqZ6pR70UYIzySiyX1FQmrM8zahKoMR
         J6F2a/dEejDoy33GLBsD0+9GmLMt869CQVSribquFY0OCEfDWvRp6ph2s8NOpijF9Jxa
         OF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/PvhyblV7HKQCmFJuCM8xjUeOCgi9qEWjiHxHwW/fc=;
        b=wj3cFJR0kKfUDuRHTwVuQoBXiw2yb6lz4ceyqCHWqI68HIcpBZVxui1pqNeDxYIqr9
         Hq7JBmBtfV9hborwZey/kLEsIqwzRfWn1H1gdjrw5TUZsefzjQOj8eNiUzSXqnbgYhC2
         JEwLFjUEDkSav2SrhbijclUTVTJdaETGTImDGeb8TtRyibO+xJUcqVAinQAiMi27CWcn
         OjbaSYRc+75YiFYs1iRi2C1GtnFtVhPflqpX1aRxhevAscaVyT2W+i5q9aaaFfqB3VOk
         4uZ7xKBhHAMI6b7nWrSyW0bWPAftMg/650YrYUgmvpSJQXmmrtvKDxqpKvIeGI3Z5IdG
         3lmw==
X-Gm-Message-State: ANoB5pnM8dsvDN/irJs5ftfffWAhnsVzsCof6dAq2ZMePiEr5XmxtZon
        EFQbrekswt/AS28Y5iHWP+Au8QrcShxedjBj76hJew==
X-Google-Smtp-Source: AA0mqf5joQloInZ0rfKwtDbqKUhM24CtsHzxr6in5aTp1K+dJQf69rQD0uBdSPPGaJ6lI9cJRyd9PXeHD1p3Y3YLvtM=
X-Received: by 2002:a05:600c:4b1b:b0:3d1:d771:373 with SMTP id
 i27-20020a05600c4b1b00b003d1d7710373mr9524251wmp.18.1670474533107; Wed, 07
 Dec 2022 20:42:13 -0800 (PST)
MIME-Version: 1.0
References: <20221207223731.32784-1-sidhartha.kumar@oracle.com>
 <92965844-c430-8b8e-d9f1-705d7578bceb@nvidia.com> <ec8f46ca-9ea6-4567-2038-22f6d3000ed5@oracle.com>
 <d17530ad-8e12-8069-d619-a2d72fe80e15@nvidia.com>
In-Reply-To: <d17530ad-8e12-8069-d619-a2d72fe80e15@nvidia.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 8 Dec 2022 12:41:36 +0800
Message-ID: <CAMZfGtU7ktsz9VnQ5A0j+yx9irXyRLqyAkMxrjxnG=A62=WHaA@mail.gmail.com>
Subject: Re: [PATCH mm-unstable] mm: clarify folio_set_compound_order() zero support
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>, willy@infradead.org,
        tsahu@linux.ibm.com, David Hildenbrand <david@redhat.com>,
        muchun.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 8, 2022 at 10:27 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 12/7/22 17:42, Sidhartha Kumar wrote:
> >> Wouldn't it be better to instead just create a new function for that
> >> case, such as:
> >>
> >>      dissolve_large_folio()
> >>
> >
> > Prior to the folio conversion, the helper function __destroy_compound_g=
igantic_page() did:
> >
> >      set_compound_order(page, 0);
> > #ifdef CONFIG_64BIT
> >      page[1].compound_nr =3D 0;
> > #endif
> >
> > as part of dissolving the page. My goal for this patch was to create a =
function that would encapsulate that segment of code with a single call of =
folio_set_compound_order(folio, 0). set_compound_order() does not set compo=
und_nr to 0 when 0 is passed in to the order argument so explicitly setting=
 it is required. I don't think a separate dissolve_large_folio() function f=
or the hugetlb case is needed as __destroy_compound_gigantic_folio() is pre=
tty concise as it is.
> >
>
> Instead of "this is abusing function X()" comments, we should prefer
> well-named functions that do something understandable. And you can get
> that by noticing that folio_set_compound_order() collapses down to
> nearly nothing in the special "order 0" case. So just inline that code
> directly into __destroy_compound_gigantic_folio(), taking a moment to
> fill in and consolidate the CONFIG_64BIT missing parts in mm.h.
>
> And now you can get rid of this cruft and "abuse" comment, and instead
> just end up with two simple lines of code that are crystal clear--as
> they should be, in a "__destroy" function. Like this:
>
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 105878936485..cf227ed00945 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1754,6 +1754,7 @@ static inline void set_page_links(struct page *page=
, enum zone_type zone,
>   #endif
>   }
>
> +#ifdef CONFIG_64BIT
>   /**
>    * folio_nr_pages - The number of pages in the folio.
>    * @folio: The folio.
> @@ -1764,13 +1765,32 @@ static inline long folio_nr_pages(struct folio *f=
olio)
>   {
>         if (!folio_test_large(folio))
>                 return 1;
> -#ifdef CONFIG_64BIT
>         return folio->_folio_nr_pages;
> +}
> +
> +static inline void folio_set_nr_pages(struct folio *folio, long nr_pages=
)

I like this approach and helper name since it is more consistent
with folio_nr_pages.

> +{
> +       folio->_folio_nr_pages =3D nr_pages;
> +}
>   #else
> +/**
> + * folio_nr_pages - The number of pages in the folio.
> + * @folio: The folio.
> + *
> + * Return: A positive power of two.
> + */
> +static inline long folio_nr_pages(struct folio *folio)
> +{
> +       if (!folio_test_large(folio))
> +               return 1;
>         return 1L << folio->_folio_order;
> -#endif
>   }
>
> +static inline void folio_set_nr_pages(struct folio *folio, long nr_pages=
)
> +{
> +}
> +#endif
> +
>   /**
>    * folio_next - Move to the next physical folio.
>    * @folio: The folio we're currently operating on.
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index e3500c087893..b507a98063e6 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1344,7 +1344,8 @@ static void __destroy_compound_gigantic_folio(struc=
t folio *folio,
>                         set_page_refcounted(p);
>         }
>
> -       folio_set_compound_order(folio, 0);
> +       folio->_folio_order =3D 0;

I suggest not touch _folio_order directly, we can introduce another helper =
like
folio_sert_order to set -> _folio_order pairing with folio_order.

Thanks.

> +       folio_set_nr_pages(folio, 0);
>         __folio_clear_head(folio);
>   }
>
>
> Yes?
>
> thanks,
> --
> John Hubbard
> NVIDIA
