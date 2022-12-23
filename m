Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E836552E5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 17:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiLWQl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 11:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiLWQly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 11:41:54 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F44D219B
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 08:41:53 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 1so7713677lfz.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 08:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MmhfakGpyVCikNZqo5vA4AVAUNDRZRX05/SqVLdJr/8=;
        b=VwscvEKSkFwYmOi31z1ts+1/id4+H2UeVemaweigQNsCyC69YoLeOAXw6m4PwBY/83
         0UXzpJe+RGOWVJVPos5lj74DqYcPoQ4Hsz71hvvIxuu8FBi4Q2IO9wHaEkYHNT2zXiaY
         Z3DeFY7WrNHSg6xpcY2z+BsvH3LmqSEggPI7aVR7ZVVBjATyljCTg75ma3mTx0fCBAdZ
         2i/Rqk87kcnPLFJW6jpjd6ddFQZqls4k0UW2ucVIJ/CIswN4IlyI+KVUgSHOwNRLrNwG
         BMPGZ4FaGIKNtVlL1u1UCdU3pC7PSe8Iv5dIb91adP+sohb1M+8vTqMR6k8YvGPlMIUU
         GxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmhfakGpyVCikNZqo5vA4AVAUNDRZRX05/SqVLdJr/8=;
        b=Ta5plTpM5oQSjSICU+0fHjQizwkQrFU7mdnt3E9uIQPh4Rq6ZFfX6aZCwN2e1NOLCS
         gpmDT3jI1MWLZx0ZwpHYmXuU1O0EUR8gznhLEsTq4tz3OwyvGakWXwdEvoY6u6EjBESb
         dq5s/Kl5pJHtu46h+7CUFFg1RvuPaXMvI0Wxc4BnTv9Z8RK9ST8GO8WxnfFtkyXVdKJF
         36cFGlVVqHGunWTB7Cn9D/AjnZ9NobA2IRYDDz16VSZx3PWfiTMHQdWQ8rXozCS0xmo6
         hRkhHHO6buy57dDEsz4crksxHzKjlwZxm6Ml/UidvpCEJdMIoQ5LX8t4pzEK3KHrpc5c
         DqwA==
X-Gm-Message-State: AFqh2ko1HVwsR/njtecpSDHilW3wSPsJlq4ATzEo5amkutxjpmYGlLqB
        PUqGwbyk6dniZLCJ7TAVc1M=
X-Google-Smtp-Source: AMrXdXu9m9TkG5fdOfvdxJzH4AT1SJRyP9f37iVtxBdUn2ja7OctXgAcq1RTtEEgAap+SQmQRsybiQ==
X-Received: by 2002:a05:6512:2624:b0:4b5:8e1e:867b with SMTP id bt36-20020a056512262400b004b58e1e867bmr3377028lfb.59.1671813711494;
        Fri, 23 Dec 2022 08:41:51 -0800 (PST)
Received: from pc636 (host-90-233-218-120.mobileonline.telia.com. [90.233.218.120])
        by smtp.gmail.com with ESMTPSA id a16-20020a2e9810000000b0027997d00fc2sm500724ljj.21.2022.12.23.08.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 08:41:51 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 23 Dec 2022 17:41:48 +0100
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 2/3] mm: vmalloc: Switch to find_unlink_vmap_area() in
 vm_unmap_ram()
Message-ID: <Y6XaTM+xSlGNjo0e@pc636>
References: <20221222190022.134380-1-urezki@gmail.com>
 <20221222190022.134380-2-urezki@gmail.com>
 <Y6VlA8Mbbv7Ug6tW@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6VlA8Mbbv7Ug6tW@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Dec 22, 2022 at 08:00:21PM +0100, Uladzislau Rezki (Sony) wrote:
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2252,7 +2252,7 @@ void vm_unmap_ram(const void *mem, unsigned int count)
> >  		return;
> >  	}
> >  
> > -	va = find_vmap_area(addr);
> > +	va = find_unlink_vmap_area(addr);
> >  	BUG_ON(!va);
> >  	debug_check_no_locks_freed((void *)va->va_start,
> >  				    (va->va_end - va->va_start));
> 
> Don't we also need to remove the manual unlink that was done
> here previously?   Actually it seems like that manual unlink is missing
> after patch 1, creating a bisection hazard.  So either add it there,
> or just fold this patch into the previous one.
>
Right. In terms of bisection it is not so good. I think folding is the
best.

Andrew, could you please fold this patch into the:

[PATCH v3 1/3] mm: vmalloc: Avoid calling __find_vmap_area() twice in __vunmap() ?

or should i send a v4 instead?

Thank you in advance!

--
Uladzislau Rezki
