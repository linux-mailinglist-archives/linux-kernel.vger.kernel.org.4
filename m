Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F005735DD6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 21:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjFSTTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 15:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjFSTTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 15:19:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577A2E5C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 12:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687202297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xsIBCnHr4DaWqSJb6zhumnwbJfejyz9/hGIX739o62I=;
        b=d96EwpyLFeOWq78bP74wJCzmJIdqAFtbpiRzoYL5pQf9dYxQi1bfzNLO8fYQ9+vkysdF6c
        tzUnyG2qrTPVoo77jZiXhr34le1goiizDVdz8nMrVlGNT03mawBLw/fXO5cjonvCYVJKBy
        QAsWp8PzPqMiJazTPtJqnnTbhLMr98k=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-HCBbQQdyNsGSXgq-IyTLMQ-1; Mon, 19 Jun 2023 15:18:16 -0400
X-MC-Unique: HCBbQQdyNsGSXgq-IyTLMQ-1
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-471603b2e6dso121859e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 12:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687202295; x=1689794295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsIBCnHr4DaWqSJb6zhumnwbJfejyz9/hGIX739o62I=;
        b=HdEkNhpAqoPR2vSdLYqcMZB9QvY6LpMAm1uL6XOSv8KFdFsfHBF+Npb9XCTYEEfFCn
         MpsBBEeokQE/vDttPXIgT2hv50sFDZiwwq8EuL6trnHMxA5rPTCWxYNVQKzQ5T+Nwue2
         /qMesi8NuUVDXpQ6f2LX1gEm729QTe9/8l5ihByXhHqwWhVub6crmzRG/AyPRV8TxgTO
         8hyq6mucJpLuq4VA7/EnuxOaTvroP6NUkXlIl5SZOI4W7UFtiXqeTVGCVNJFz3SiBD9v
         fwsFHvSH9KmeS9n8izrJY3UvsB55i4x7oQCRQzzhau0pFq3jGKVQHTeqi084KuIgvnkD
         5d9A==
X-Gm-Message-State: AC+VfDy7QRSCAxeZZEHMbPWooV1Y2IQ6iNuk+yzGalxmzCBabO7u152H
        WISB3uzU//vhUQcmLM1M8wI6H1ALYPNmQi6nJmkaPGa2TpHeOj5yULy6Fb+U1igbavj5iMwO2FS
        mE4QvkNnod7mmViXYHJZr8J5R
X-Received: by 2002:a05:6102:2924:b0:440:a800:c005 with SMTP id cz36-20020a056102292400b00440a800c005mr2117948vsb.1.1687202295434;
        Mon, 19 Jun 2023 12:18:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4sKJJix/7pu6y3jAziZG2YsnBRDijpBnhMwlZLNMyr2x2ZEEF57I1Q9nvSMkv3Frdyrl0w9g==
X-Received: by 2002:a05:6102:2924:b0:440:a800:c005 with SMTP id cz36-20020a056102292400b00440a800c005mr2117931vsb.1.1687202295153;
        Mon, 19 Jun 2023 12:18:15 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id h17-20020ae9ec11000000b0074def53eca5sm240162qkg.53.2023.06.19.12.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 12:18:14 -0700 (PDT)
Date:   Mon, 19 Jun 2023 15:18:13 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 5/7] mm/gup: Cleanup next_page handling
Message-ID: <ZJCp9aBS8INMkehh@x1n>
References: <20230613215346.1022773-1-peterx@redhat.com>
 <20230613215346.1022773-6-peterx@redhat.com>
 <f4087efd-36c3-4e3a-96ce-44dbd1a0b5d7@lucifer.local>
 <5886f78c-3ff8-4b64-9aa6-027c22e7d5fc@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5886f78c-3ff8-4b64-9aa6-027c22e7d5fc@lucifer.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 09:00:34PM +0100, Lorenzo Stoakes wrote:
> On Sat, Jun 17, 2023 at 08:48:38PM +0100, Lorenzo Stoakes wrote:
> > On Tue, Jun 13, 2023 at 05:53:44PM -0400, Peter Xu wrote:
> > > The only path that doesn't use generic "**pages" handling is the gate vma.
> > > Make it use the same path, meanwhile tune the next_page label upper to
> > > cover "**pages" handling.  This prepares for THP handling for "**pages".
> > >
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  mm/gup.c | 7 +++----
> > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/mm/gup.c b/mm/gup.c
> > > index 8d59ae4554e7..a2d1b3c4b104 100644
> > > --- a/mm/gup.c
> > > +++ b/mm/gup.c
> > > @@ -1135,7 +1135,7 @@ static long __get_user_pages(struct mm_struct *mm,
> > >  			if (!vma && in_gate_area(mm, start)) {
> > >  				ret = get_gate_page(mm, start & PAGE_MASK,
> > >  						gup_flags, &vma,
> > > -						pages ? &pages[i] : NULL);
> > > +						pages ? &page : NULL);
> >
> > Good spot... ugh that we handled this differently.
> >
> > >  				if (ret)
> > >  					goto out;
> > >  				ctx.page_mask = 0;
> >
> > We can drop this line now right? As the new next_page block will duplicate
> > this.
> 
> OK I can see why you left this in given the last patch in the series :)
> Please disregard.

Yes the other "page_mask=0" will be removed in the next (not last) patch.

> 
> >
> > > @@ -1205,19 +1205,18 @@ static long __get_user_pages(struct mm_struct *mm,
> > >  				ret = PTR_ERR(page);
> > >  				goto out;
> > >  			}
> > > -
> > > -			goto next_page;
> >
> > This is neat, we've already checked if pages != NULL so the if (pages)
> > block at the new next_page label will not be run.

Yes.

> >
> > >  		} else if (IS_ERR(page)) {
> > >  			ret = PTR_ERR(page);
> > >  			goto out;
> > >  		}
> > > +next_page:
> > >  		if (pages) {
> > >  			pages[i] = page;
> > >  			flush_anon_page(vma, page, start);
> > >  			flush_dcache_page(page);
> >
> > I guess there's no harm that we now flush here, though it seems to me to be
> > superfluous, it's not a big deal I don't think.

I'd say GUP on gate vma page should be so rare so yeah I think it shouldn't
be a big deal.  Even iiuc vsyscall=xonly should be the default, so gup may
have already failed on a gate vma page even trying to read-only..

> >
> > >  			ctx.page_mask = 0;
> > >  		}
> > > -next_page:
> > > +
> > >  		page_increm = 1 + (~(start >> PAGE_SHIFT) & ctx.page_mask);
> > >  		if (page_increm > nr_pages)
> > >  			page_increm = nr_pages;
> > > --
> > > 2.40.1
> > >
> >
> > Other than that, LGTM,
> >
> > Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>

Thanks for looking!

-- 
Peter Xu

