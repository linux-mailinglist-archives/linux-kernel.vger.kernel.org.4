Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6577482CC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 13:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjGELRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 07:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjGELRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 07:17:09 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61405DC
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 04:17:08 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4036e428de0so14116561cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 04:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688555826; x=1691147826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLYbyyTNl2Zb/qjIIe6Qi+9jxk/pFwwBytcz2lbXZbY=;
        b=n9q+aZJ92FmViihc3PgbYyXboMxqgX5yjUrMehgL2YkOKQS8Q124VGBlFT6SrvnHQ+
         FablCQ64bt4FPIsq+6T+zM1U2uSZk+mykldx4YDRN4HB7hyl7mrTutmoG2joPgBVdX6S
         LqgbcrUJ30u/txmD+jETyZSSFXwImstD/opJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688555826; x=1691147826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLYbyyTNl2Zb/qjIIe6Qi+9jxk/pFwwBytcz2lbXZbY=;
        b=HbR0ANxXz9xe03ImJamEoXVK14piyNu/wSfEKX9V9LyxqRooUW4tzTJi1bggk++bmW
         OvlbtNoyv9xWP2u2v5v/GCHw7CKgFj7qI9xmaFzUOj2EniKOiPEbEOfg3RDMcrOzGUYl
         JTcesKlVGSKezXseKd6SoEqLE4KN5SjmXaWVimuXY8d3lqRUuw2ziQvRQSVDXpSP/O/2
         nnSQ1op0MKs+mjIL7o49ChrG+J/NDQy9CwXX9x3epQk1xS4b2xN4AV/4TzT8+YFf3u/J
         H4D+bJAb9DrNdzyLHHwKhABoNhqrbHNaRz6S9fz+RA3midA8SIp330NWaStWqMJsazHZ
         yqEg==
X-Gm-Message-State: AC+VfDwckDlTzdUpM0/la4QgG1gqaAtGXcVYh39qw8gXdSDGQdg0Q0zO
        O0GR2KEEZ/l2GnLM5iNgjTPhc1KU3MaWhASGJ3u5vw==
X-Google-Smtp-Source: ACHHUZ5fwQQF45Y5hzePWZxszxmSa0RPyqOVUSz+GDKt3fTdsuZFAVNt2st4Hoy3JpuxEN6bq5PnrA==
X-Received: by 2002:ac8:5e48:0:b0:3ff:2cc2:3f54 with SMTP id i8-20020ac85e48000000b003ff2cc23f54mr19210287qtx.9.1688555825892;
        Wed, 05 Jul 2023 04:17:05 -0700 (PDT)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com. [209.85.219.47])
        by smtp.gmail.com with ESMTPSA id g11-20020ac8580b000000b003f3937c16c4sm2522989qtg.5.2023.07.05.04.17.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 04:17:05 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6348a8045a2so45407926d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 04:17:05 -0700 (PDT)
X-Received: by 2002:a05:6214:15ce:b0:626:2e65:cb2b with SMTP id
 p14-20020a05621415ce00b006262e65cb2bmr15434310qvz.4.1688555824535; Wed, 05
 Jul 2023 04:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210301085236.947011-1-hch@lst.de> <20210301085236.947011-4-hch@lst.de>
 <94d4b082-7b08-82e0-bb42-6ac36821ea61@arm.com>
In-Reply-To: <94d4b082-7b08-82e0-bb42-6ac36821ea61@arm.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 5 Jul 2023 20:16:54 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AeoRwuXo9j0=AK-eBhUQx-S8qvJVHDoOf0=B+20FAn9g@mail.gmail.com>
Message-ID: <CAAFQd5AeoRwuXo9j0=AK-eBhUQx-S8qvJVHDoOf0=B+20FAn9g@mail.gmail.com>
Subject: Re: [PATCH 3/6] dma-mapping: add a dma_alloc_noncontiguous API
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Sergey Senozhatsky <senozhatsky@google.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        iommu@lists.linux-foundation.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 2:21=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> [Archaeology ensues...]
>
> On 2021-03-01 08:52, Christoph Hellwig wrote:
> [...]
> > +static struct sg_table *alloc_single_sgt(struct device *dev, size_t si=
ze,
> > +             enum dma_data_direction dir, gfp_t gfp)
> > +{
> > +     struct sg_table *sgt;
> > +     struct page *page;
> > +
> > +     sgt =3D kmalloc(sizeof(*sgt), gfp);
> > +     if (!sgt)
> > +             return NULL;
> > +     if (sg_alloc_table(sgt, 1, gfp))
> > +             goto out_free_sgt;
> > +     page =3D __dma_alloc_pages(dev, size, &sgt->sgl->dma_address, dir=
, gfp);
> > +     if (!page)
> > +             goto out_free_table;
> > +     sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
> > +     sg_dma_len(sgt->sgl) =3D sgt->sgl->length;
> > +     return sgt;
> > +out_free_table:
> > +     sg_free_table(sgt);
> > +out_free_sgt:
> > +     kfree(sgt);
> > +     return NULL;
> > +}
> > +
> > +struct sg_table *dma_alloc_noncontiguous(struct device *dev, size_t si=
ze,
> > +             enum dma_data_direction dir, gfp_t gfp, unsigned long att=
rs)
> > +{
> > +     const struct dma_map_ops *ops =3D get_dma_ops(dev);
> > +     struct sg_table *sgt;
> > +
> > +     if (WARN_ON_ONCE(attrs & ~DMA_ATTR_ALLOC_SINGLE_PAGES))
> > +             return NULL;
> > +
> > +     if (ops && ops->alloc_noncontiguous)
> > +             sgt =3D ops->alloc_noncontiguous(dev, size, dir, gfp, att=
rs);
> > +     else
> > +             sgt =3D alloc_single_sgt(dev, size, dir, gfp);
> > +
> > +     if (sgt) {
> > +             sgt->nents =3D 1;
> > +             debug_dma_map_sg(dev, sgt->sgl, sgt->orig_nents, 1, dir);
>
> It turns out this is liable to trip up DMA_API_DEBUG_SG (potentially
> even in the alloc_single_sgt() case), since we've filled in sgt without
> paying attention to the device's segment boundary/size parameters.
>
> Now, it would be entirely possible to make the allocators "properly"
> partition the pages into multiple segments per those constraints, but
> given that there's no actual dma_map_sg() operation involved, and AFAIR
> the intent here is really only to describe a single DMA-contiguous
> buffer as pages, rather than represent a true scatter-gather operation,

Yeah, the name noncontiguous comes from potentially allocating
non-contiguous physical pages, which based on a few people I talked
with, ended up being quite confusing, but I can't really think of a
better name either.

Do we know how common devices with segment boundary/size constraints
are and how likely they are to use this API?

> I'm now wondering whether it makes more sense to just make dma-debug a
> bit cleverer instead. Any other opinions?

If we could assume that drivers for those devices shouldn't use this
API, we could just fail if the segment boundary/size are set to
something other than unlimited.

Best regards,
Tomasz

>
> Thanks,
> Robin.
>
> > +     }
> > +     return sgt;
> > +}
