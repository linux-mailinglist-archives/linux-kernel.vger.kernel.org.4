Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB5D68657D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 12:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjBALlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 06:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBALlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 06:41:42 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C2A474D6
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 03:41:40 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id l4-20020a17090a850400b0023013402671so1853542pjn.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 03:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5bXvsgoiR+l3eWpgXtRlq4Hbq0hyNkL1nv2x5YPzs4o=;
        b=T3X2hrM0WKKoWJ6KGYHnf0BQr7JyLhIQDVWxq9npfd8Jhsz05Es81zwx3TIatEp+/f
         9dUbTZKL9Dz3QQ7ckwYcbsjJgA1pvVDqFoi+4R71yEtafoawRnlsX56lMTnbJt0dzKPb
         CblfL85QAG+GiWIsWpoGImzHp6E0sKC+QK4mPEKg5YySGbzPKQijLSeFnC34WR0LD6sH
         5kfK5kfP+6h08UsUlW6X3pDhqc7lFtJveKKTIB3mcMtM5402ZvURzAjREEGdfZvQROUA
         UE/yU4x82yUhahakcHKjlHkt0jUnC+OgGwgWFKzN01PPF174MAPTGprDOLAkQr4Cae+0
         6Uuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5bXvsgoiR+l3eWpgXtRlq4Hbq0hyNkL1nv2x5YPzs4o=;
        b=3IlKfXiQZrEzXQcWvIxpdraKw0L5mgkNyAxEoH9dMs4Bhx4yWCoetrlZbvuCHc0BTB
         wqde/JvY9rU3+tb6LOy4ROHQZ8kD2OzXgdBPzneIENpFYl3ygFvMwniULw4vRsTWvzRd
         5xWlGhGEZyGw6y5QPovSGvCh/5IOPyRmdzEFp4cX0jgKr7aX1tMOpQI97UXAum9sAI+u
         a2RKSP6FZxVGjLjJD+DfgGu4jmAW15tX94a9CNfMnWe8/xR4r+D7Pu3wWhPUCiotCJF7
         KGVxtveT2DyoBbZp6A8TCT0cCrxHPkKy/BQVJDqPrUBrhbBrm0hw7EhSHOzMz/uIT4iT
         /LXw==
X-Gm-Message-State: AO0yUKXNE2dDdtU67tDwpkFOCEeimYedpNDHe8xGTCvLbqp9cD6du5TK
        W5C0VcdwOAxhfFzbZW/zNkjMc5BEgaG2Rg==
X-Google-Smtp-Source: AK7set94acvRQfUPbtBsFbvSUn3Lw6SO1V5JWqbdMVT2dTr90tfbsG7QXf7bNN5/G4ePIBhaDW9u0g==
X-Received: by 2002:a17:902:c943:b0:196:5787:d73a with SMTP id i3-20020a170902c94300b001965787d73amr2848104pla.53.1675251700015;
        Wed, 01 Feb 2023 03:41:40 -0800 (PST)
Received: from min-iamroot ([210.91.70.133])
        by smtp.gmail.com with ESMTPSA id ay2-20020a1709028b8200b0019468fe44d3sm11476329plb.25.2023.02.01.03.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 03:41:39 -0800 (PST)
Date:   Wed, 1 Feb 2023 20:41:34 +0900
From:   Hyunmin Lee <hn.min.lee@gmail.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Jeungwoo Yoo <casionwoo@gmail.com>,
        Sangyun Kim <sangyun.kim@snu.ac.kr>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH v3] mm/vmalloc: replace BUG_ON to a simple if statement
Message-ID: <20230201114134.GA6060@min-iamroot>
References: <20230201101152.GA5535@min-iamroot>
 <9f507a28-bbe3-7ebd-6e32-b5dc046c310d@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f507a28-bbe3-7ebd-6e32-b5dc046c310d@csgroup.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 10:37:19AM +0000, Christophe Leroy wrote:
> 
> 
> Le 01/02/2023 à 11:11, Hyunmin Lee a écrit :
> > [Vous ne recevez pas souvent de courriers de hn.min.lee@gmail.com. D?couvrez pourquoi ceci est important ? https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > As per the coding standards, in the event of an abnormal condition that
> > should not occur under normal circumstances, the kernel should attempt
> > recovery and proceed with execution, rather than halting the machine.
> > 
> > Specifically, in the alloc_vmap_area() function, use a simple if()
> > instead of using BUG_ON() halting the machine.
> > 
> > Co-Developed-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> > Co-Developed-by: Jeungwoo Yoo <casionwoo@gmail.com>
> > Co-Developed-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
> > Signed-off-by: Hyunmin Lee <hn.min.lee@gmail.com>
> > Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> > Signed-off-by: Jeungwoo Yoo <casionwoo@gmail.com>
> > Signed-off-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
> > Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > ---
> > v1->v2 : Add commit description
> > v2->v3 : Change WARN_ON() to if()
> > ---
> >   mm/vmalloc.c | 11 ++++++++---
> >   1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 74afa2208558..52a346bc02a1 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -1587,9 +1587,14 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
> >          int purged = 0;
> >          int ret;
> > 
> > -       BUG_ON(!size);
> > -       BUG_ON(offset_in_page(size));
> > -       BUG_ON(!is_power_of_2(align));
> > +       if (unlikely(!size))
> > +               return ERR_PTR(-EINVAL);
> > +
> > +       if (unlikely(offset_in_page(size)))
> > +               return ERR_PTR(-EINVAL);
> > +
> > +       if (unlikely(!is_power_of_2(align)))
> > +               return ERR_PTR(-EINVAL);
> 
> I would have written it more compact. When using BUG_ON or WARN_ON it is 
> interesting to have three separate lines because you get the line number 
> in the Oops message, but here you are just returning the exact same 
> error code, so it could be:
> 
> 	if (unlikely(!size || offset_in_page(size) || !is_power_of_2(align)))
> 		return ERR_PTR(-EINVAL);
> 
> > 
> >          if (unlikely(!vmap_initialized))
> >                  return ERR_PTR(-EBUSY);
> > --
> > 2.25.1
> > 
> > 
Hi Christophe,

Thanks for your comment.
I will send new patch.

Best,
Min
