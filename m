Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB86734368
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 22:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbjFQUAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 16:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjFQUAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 16:00:40 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAED83
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 13:00:38 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f909853509so2434665e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 13:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687032037; x=1689624037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rjQBbhtm5eFOCdJt5kp50w9SBFIRdDI6B5ZIGzHw3zg=;
        b=djJC0NR1UN7CPeXIMuuinoOO5NNoUqSqSzxWupXz5tWWxLRpZ98D+frbgyQCqMMQ7D
         B/u9IFUiIYOBwdcMYM4gBk6uuyMHswAlgQwT91JXhTocGHuRxC2W5G8KNAdXfXorbL90
         g08DDN7BY7ArbgyElxg8hdOqV4VxPS6SuzT0D90Mrpa7dbzhfHYN87M+cAsqCLaS6EJJ
         +ykE3PG42Z4xH+gHe0wyLR0tJGI3z7lqjIHwQgNy6scOrPhHsgHg4Sjd1r9EHTj10YeY
         YDrP7BLluZhGHdrniP2379nfLd2fjZHpU8b89PX5EA15IrLbZhkuhodhG4kuxgA5GfOx
         EWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687032037; x=1689624037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjQBbhtm5eFOCdJt5kp50w9SBFIRdDI6B5ZIGzHw3zg=;
        b=GdJF+BhNoF407/SgFxufrHmpdUXXGMVzdSIGqlbSGHn2Qdh37VB7U85b2gIjkGYSLM
         nV42BiEgZpIXk+2D6CGpSidDsdeJZALUGyr05ouqLOZnL9HoJ0L4C+HpiqVmYkEPcgpS
         K7gpQKmlwPTzOhvW61/qEr4PRq7tuEFHl+V1o/o0Bl2Gg9eIbyHnjvPaga2PnWQN05mp
         pCzp0hRwi4jSBJS6kZAyWtZ/S80HSPhZayaC0jd5yUL0nxt6RoI29y7aPXnRlUcwYrIA
         3aJmXqlhiW9Pf2f9ZyvLbjHjjgFj5EYgnE/dbBrELyChd97+KM16obJXwtcwxb+2v3Av
         7zMQ==
X-Gm-Message-State: AC+VfDzK5m3jWOmMx/wyATtjfMkUjOFMkUc1bdg7Q2OgykFA/FHEA0x+
        xjoyhukZBmxkT3znJA9sSmgIAUkplhQ=
X-Google-Smtp-Source: ACHHUZ4iaQZPLPAEHNuODHsC/grrxgljsjJ+UnDI65fvNlOzgHePOg/aJkZLS9ticiCBESSKzPzx6g==
X-Received: by 2002:a05:600c:214d:b0:3f9:ad7:ae86 with SMTP id v13-20020a05600c214d00b003f90ad7ae86mr225704wml.37.1687032036550;
        Sat, 17 Jun 2023 13:00:36 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id c25-20020a05600c0ad900b003f18b942338sm5891713wmr.3.2023.06.17.13.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 13:00:35 -0700 (PDT)
Date:   Sat, 17 Jun 2023 21:00:34 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Peter Xu <peterx@redhat.com>
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
Message-ID: <5886f78c-3ff8-4b64-9aa6-027c22e7d5fc@lucifer.local>
References: <20230613215346.1022773-1-peterx@redhat.com>
 <20230613215346.1022773-6-peterx@redhat.com>
 <f4087efd-36c3-4e3a-96ce-44dbd1a0b5d7@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4087efd-36c3-4e3a-96ce-44dbd1a0b5d7@lucifer.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 08:48:38PM +0100, Lorenzo Stoakes wrote:
> On Tue, Jun 13, 2023 at 05:53:44PM -0400, Peter Xu wrote:
> > The only path that doesn't use generic "**pages" handling is the gate vma.
> > Make it use the same path, meanwhile tune the next_page label upper to
> > cover "**pages" handling.  This prepares for THP handling for "**pages".
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  mm/gup.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 8d59ae4554e7..a2d1b3c4b104 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -1135,7 +1135,7 @@ static long __get_user_pages(struct mm_struct *mm,
> >  			if (!vma && in_gate_area(mm, start)) {
> >  				ret = get_gate_page(mm, start & PAGE_MASK,
> >  						gup_flags, &vma,
> > -						pages ? &pages[i] : NULL);
> > +						pages ? &page : NULL);
>
> Good spot... ugh that we handled this differently.
>
> >  				if (ret)
> >  					goto out;
> >  				ctx.page_mask = 0;
>
> We can drop this line now right? As the new next_page block will duplicate
> this.

OK I can see why you left this in given the last patch in the series :)
Please disregard.

>
> > @@ -1205,19 +1205,18 @@ static long __get_user_pages(struct mm_struct *mm,
> >  				ret = PTR_ERR(page);
> >  				goto out;
> >  			}
> > -
> > -			goto next_page;
>
> This is neat, we've already checked if pages != NULL so the if (pages)
> block at the new next_page label will not be run.
>
> >  		} else if (IS_ERR(page)) {
> >  			ret = PTR_ERR(page);
> >  			goto out;
> >  		}
> > +next_page:
> >  		if (pages) {
> >  			pages[i] = page;
> >  			flush_anon_page(vma, page, start);
> >  			flush_dcache_page(page);
>
> I guess there's no harm that we now flush here, though it seems to me to be
> superfluous, it's not a big deal I don't think.
>
> >  			ctx.page_mask = 0;
> >  		}
> > -next_page:
> > +
> >  		page_increm = 1 + (~(start >> PAGE_SHIFT) & ctx.page_mask);
> >  		if (page_increm > nr_pages)
> >  			page_increm = nr_pages;
> > --
> > 2.40.1
> >
>
> Other than that, LGTM,
>
> Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
