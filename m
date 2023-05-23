Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8195D70D9B3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbjEWJ6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236342AbjEWJ63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:58:29 -0400
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACA213E
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:58:23 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2af7081c9ebso29717231fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684835842; x=1687427842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=edwWrDcvxwOBnRngZUhvK+9rBRKB1nAa+UUBR0uzu3Q=;
        b=RUgvWVxBrN/R6ZuIQbV6wY8ghqqsoVxOK0JTpAYxXpoNZiGgFhP01/NEKe47sBpe8w
         IMk2y67i1dKZKXfjOSdxtgXfFCdzajrk/ppKMiW3F+3jXU0sNKZECycLCQeDMdBTkKtU
         XEz8JZ3cad2qCmXkN7B4RDvWuvjQEXj3mXRBB1B3CIDvpDLeZyoaiooHdOZ/lJtPCLWt
         7enhUv2Bmxep08dWEWyAIQ/8Q74408iFJ0k53/lra5+kpG3toVn9zbfXn8HggYq/GUPL
         1/q8JTtd0UzBcCLpwZxhh38FATr1vF7ShurNLef24X6pu4vfvcYLfhgSWiquVydPs4Xm
         L7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684835842; x=1687427842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edwWrDcvxwOBnRngZUhvK+9rBRKB1nAa+UUBR0uzu3Q=;
        b=A3ACpgj5nEwyXHRyIJwVKLLjk1b/3KQBoHgHUPZLzyTnCgPoPb3xAR8lxveAwo70xS
         JHE+BpFUtYOq+7nnLB2AYO1snQYXlOh3MduQNb3d9tOS1acbO4WZalZy7lnMUgj2BA/7
         ZkimoDeZN9rrpBz3/A3L3KN8rXhILEhlRIBxn40kwZsxdL8vwGOlvZIJFxi7OAJlLI67
         tkdVksuN2Z4NbG+mwyAD3cmwPX8EVXIYIFv7AUv73zqR5sVutu+O6kY7reTMpNOxcgFa
         O6p4ORe/qemE2QyGg+lMnKpn8FaKwWn5UXnWxZ+wytvSTGI2327L1w9rs5PrkN7PVRcd
         TT0g==
X-Gm-Message-State: AC+VfDxQuBaOTvnfCQ7BxpS5HLZCAo9tvL8q4dDN1cx21q8wqte4solG
        xLyXcfDN29kWvF7vgIshdT0=
X-Google-Smtp-Source: ACHHUZ7VKnVl193QCDrumEy5QAvhXE2ODuhaJW6NhWViSdqptbnWYjnWuh7L5mxC1c1ISmdFDZsxow==
X-Received: by 2002:a2e:9117:0:b0:2ad:af50:6ecb with SMTP id m23-20020a2e9117000000b002adaf506ecbmr5135063ljg.14.1684835841510;
        Tue, 23 May 2023 02:57:21 -0700 (PDT)
Received: from pc636 (host-90-235-19-70.mobileonline.telia.com. [90.235.19.70])
        by smtp.gmail.com with ESMTPSA id q16-20020a2e9150000000b002ac871d0207sm1558123ljg.88.2023.05.23.02.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 02:57:21 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 23 May 2023 11:57:17 +0200
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/9] mm: vmalloc: Add va_alloc() helper
Message-ID: <ZGyN/XRu779eglnk@pc636>
References: <20230522110849.2921-1-urezki@gmail.com>
 <20230522110849.2921-2-urezki@gmail.com>
 <ZGxXxcQ1FOvJY/73@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGxXxcQ1FOvJY/73@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 11:05:57PM -0700, Christoph Hellwig wrote:
> On Mon, May 22, 2023 at 01:08:41PM +0200, Uladzislau Rezki (Sony) wrote:
> > Currently __alloc_vmap_area() function contains an open codded
> > logic that finds and adjusts a VA based on allocation request.
> > 
> > Introduce a va_alloc() helper that adjusts found VA only. It
> > will be used later at least in two places.
> > 
> > There is no a functional change as a result of this patch.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  mm/vmalloc.c | 41 ++++++++++++++++++++++++++++-------------
> >  1 file changed, 28 insertions(+), 13 deletions(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 31ff782d368b..409285b68a67 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -1482,6 +1482,32 @@ adjust_va_to_fit_type(struct rb_root *root, struct list_head *head,
> >  	return 0;
> >  }
> >  
> > +static unsigned long
> > +va_alloc(struct vmap_area *va,
> > +	struct rb_root *root, struct list_head *head,
> > +	unsigned long size, unsigned long align,
> > +	unsigned long vstart, unsigned long vend)
> 
> Prototype continuations don't use a single tab indent.  Either two
> tabs (my preference) or after the opening brace.  I.e.:
> 
Will go with two tabs.

> static unsigned long
> va_alloc(struct vmap_area *va, struct rb_root *root, struct list_head *head,
> 		unsigned long size, unsigned long align, unsigned long vstart,
> 		unsigned long vend)
> 
> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
Added.

Appreciate you look at it!

--
Uladizislau Rezki
