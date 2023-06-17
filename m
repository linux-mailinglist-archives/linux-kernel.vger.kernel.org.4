Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FE673435F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 21:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346345AbjFQTtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 15:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbjFQTsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 15:48:50 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEAD1982
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 12:48:42 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f906d8fca3so4253035e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 12:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687031321; x=1689623321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jlLud9fUjWTG1BAYyfaScj42f1iE+kplSpMj/YmXmBc=;
        b=KhnI54STxI15hEJpXsh/ENw0PqfyO9C/kPIsaZXVMi/uN5t5h8CDd00otWlOi74H79
         +j3gT+rjwymjKQp4D0lpy8BjV5SwT0r0+HUS8bFwp4NxAD4csfPjvzf4KlDzKdGFG0Mv
         rkHHtzPBD18oUAEImBCfWOpVEozyCmhs6PuTj7DHo2V12g8/wMTMNdjnkzWQUhtu/3Qw
         oclL8EqitZdAuYA4a1NrWvt00SmPAs7k7M4lvSrOYeXRkKsYz0oPU1agkKmBrulzgNRY
         FpweJn3bo1lEr5iMFC89f/2jNNcxCoimEDqL1u8reMUTqsPRJpHocN1NPxVFLK8Q+y2/
         kWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687031321; x=1689623321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlLud9fUjWTG1BAYyfaScj42f1iE+kplSpMj/YmXmBc=;
        b=NvA+PLphki6lU5BiWsm3veki3benBZtiJgy2DPLaMO/3yB1k4E67LQ/0+2hw6bjrNL
         tWjyfNyBP9oIDlXzLxHwGJiVAZCSZzz681DiGInsGg/0c+PmhAdTPGWPoRACPi5hppjs
         xxR8pOgKFB3av7gXzK8aqEk2+ml6eOFQYjmKHMnQLdBpu+ke4lKUPdw6aMgJab37lOwR
         OuUOvgnI5w2iaxA9jiG2sIhGCeS3y4WYxCGSrlA+bFviuZMTzibqyv1SbQ0I1HLS5hGX
         yI1nL5wmICK7s3RipaBRVP4KouhOnHIpNMsnrsoLvAW8ocPb/1YvEJSsmShHVOSr9T1r
         Gy3Q==
X-Gm-Message-State: AC+VfDwb7jvc73CPoj/03IbzY/iTmwBfgnb7r5jfzLUf1vwv+TQwiS5s
        5a83ANQq7ZEvPqLu8r9S0yjjN8xCoiQ=
X-Google-Smtp-Source: ACHHUZ4E6pjgtV/NPkGE1Sb8nK9sAmKY2Q2xyz3vXVK+XTnHnC4yHwPgKyIOlkNrnl3ncCII/AyJ0w==
X-Received: by 2002:a1c:7c17:0:b0:3f9:aca:48c3 with SMTP id x23-20020a1c7c17000000b003f90aca48c3mr237960wmc.0.1687031320771;
        Sat, 17 Jun 2023 12:48:40 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id h12-20020adffd4c000000b0031130b9b173sm1675719wrs.34.2023.06.17.12.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 12:48:39 -0700 (PDT)
Date:   Sat, 17 Jun 2023 20:48:38 +0100
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
Message-ID: <f4087efd-36c3-4e3a-96ce-44dbd1a0b5d7@lucifer.local>
References: <20230613215346.1022773-1-peterx@redhat.com>
 <20230613215346.1022773-6-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613215346.1022773-6-peterx@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 05:53:44PM -0400, Peter Xu wrote:
> The only path that doesn't use generic "**pages" handling is the gate vma.
> Make it use the same path, meanwhile tune the next_page label upper to
> cover "**pages" handling.  This prepares for THP handling for "**pages".
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/gup.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/mm/gup.c b/mm/gup.c
> index 8d59ae4554e7..a2d1b3c4b104 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1135,7 +1135,7 @@ static long __get_user_pages(struct mm_struct *mm,
>  			if (!vma && in_gate_area(mm, start)) {
>  				ret = get_gate_page(mm, start & PAGE_MASK,
>  						gup_flags, &vma,
> -						pages ? &pages[i] : NULL);
> +						pages ? &page : NULL);

Good spot... ugh that we handled this differently.

>  				if (ret)
>  					goto out;
>  				ctx.page_mask = 0;

We can drop this line now right? As the new next_page block will duplicate
this.

> @@ -1205,19 +1205,18 @@ static long __get_user_pages(struct mm_struct *mm,
>  				ret = PTR_ERR(page);
>  				goto out;
>  			}
> -
> -			goto next_page;

This is neat, we've already checked if pages != NULL so the if (pages)
block at the new next_page label will not be run.

>  		} else if (IS_ERR(page)) {
>  			ret = PTR_ERR(page);
>  			goto out;
>  		}
> +next_page:
>  		if (pages) {
>  			pages[i] = page;
>  			flush_anon_page(vma, page, start);
>  			flush_dcache_page(page);

I guess there's no harm that we now flush here, though it seems to me to be
superfluous, it's not a big deal I don't think.

>  			ctx.page_mask = 0;
>  		}
> -next_page:
> +
>  		page_increm = 1 + (~(start >> PAGE_SHIFT) & ctx.page_mask);
>  		if (page_increm > nr_pages)
>  			page_increm = nr_pages;
> --
> 2.40.1
>

Other than that, LGTM,

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
