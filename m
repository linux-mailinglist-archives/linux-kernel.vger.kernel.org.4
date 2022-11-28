Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666C763A3BA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 09:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiK1I44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 03:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiK1I4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 03:56:53 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2C213F9D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 00:56:51 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id s5so14422612edc.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 00:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GayucSwjXWyD6TV/kxm2u2wBavJA3ia7DZeWYkCZKOw=;
        b=by6nBjiXr9NZh8kyPhKz/QR5ZDh+Mr6rd8SZDiWMrpQwfDjq50XZ5M8w7bj1PvwuXn
         kLkTx7A4ur7lbkYVx6axrDESX+rGk1rmxp2uzRJp0E85uaCMYFTHvsVEip/Ap9RC3SiD
         fpJiyTPqz1ccLG964MJ0C8yB5VPBwkMbhooH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GayucSwjXWyD6TV/kxm2u2wBavJA3ia7DZeWYkCZKOw=;
        b=SgtOZTBDxfqBkfHwPwHbJ1MCNo00fbm6S+3H7EQTiwJ1oR6N7V07NEbwJwr8nfmld6
         c8hXu+Rg9eYvMvpZEb/zipYy5ut08XtNx7AXS1+OkKQW+f7v9qq5meRphxvXjKOdLIuh
         F8mvEpHIeOTG7r3P68mf0HdDZo3UJLmoz2nnkbYAcbwG2pA/KaIcey3NoqnoYGQiQp9+
         anHoEHmP46Ki6UgQbQYmWmy00HbsuVzi8Yz8YweLV1Tt0EUFrCWPkPe9LerkRsnXo7H1
         f1q9pWXHpIraWpTmyvWFLRo1T/XQJyKXtu/XU9MYuk66Wk5qhCbjgy14sU+ZDCuWjsbC
         g/6g==
X-Gm-Message-State: ANoB5pmZhVTpA2VNIQ7wOLPyMZdtYJdRpVQaQUU/8dLXxwUPJ4um88cZ
        r9o0jNaKfnY+lW60vXhO/td1JvNmoNDisQ==
X-Google-Smtp-Source: AA0mqf6DHpH8yxxBDtjFlmk6Q1VqPqwioa0cWolFw2dy0e1b04a4u8CcO8eGcT+xbFPfda1OjYU13A==
X-Received: by 2002:aa7:c585:0:b0:46b:635a:ed8f with SMTP id g5-20020aa7c585000000b0046b635aed8fmr83431edq.406.1669625810247;
        Mon, 28 Nov 2022 00:56:50 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id o19-20020aa7c7d3000000b00461bacee867sm4235994eds.25.2022.11.28.00.56.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 00:56:49 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id fy37so23965360ejc.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 00:56:49 -0800 (PST)
X-Received: by 2002:a17:906:a889:b0:7ad:bd02:f491 with SMTP id
 ha9-20020a170906a88900b007adbd02f491mr43999728ejb.703.1669625809184; Mon, 28
 Nov 2022 00:56:49 -0800 (PST)
MIME-Version: 1.0
References: <9d559d56-b042-9955-f7d1-20c50c2c8e03@xs4all.nl>
In-Reply-To: <9d559d56-b042-9955-f7d1-20c50c2c8e03@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 28 Nov 2022 17:56:37 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CUd0Opn=qAj89eiqcuuBH+=Sor1iYKZBGKS5Ba233uiA@mail.gmail.com>
Message-ID: <CAAFQd5CUd0Opn=qAj89eiqcuuBH+=Sor1iYKZBGKS5Ba233uiA@mail.gmail.com>
Subject: Re: [PATCH RESEND] media: videobuf2: revert "get_userptr: buffers are
 always writable"
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Hirokazu Honda <hiroh@chromium.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 5:24 PM Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
>
> Commit 707947247e95 ("media: videobuf2-vmalloc: get_userptr: buffers are
> always writable") caused problems in a corner case (passing read-only
> shmem memory as a userptr). So revert this patch.
>
> The original problem for which that commit was originally made is
> something that I could not reproduce after reverting it. So just go
> back to the way it was for many years, and if problems arise in
> the future, then another approach should be taken to resolve it.
>
> This patch is based on a patch from Hirokazu.
>
> Fixes: 707947247e95 ("media: videobuf2-vmalloc: get_userptr: buffers are always writable")
> Signed-off-by: Hirokazu Honda <hiroh@chromium.org>
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> ---
> CCed also to Andrew, linux-mm and linux-kernel. This patch is meant to be
> first in David Hildenbrand's 'remove FOLL_FORCE' series to ensure that it
> will be easy to backport this fix to older kernels without introducing new
> merge conflicts.
>
> Hans
> ---
>  drivers/media/common/videobuf2/frame_vector.c         | 10 +++++++---
>  drivers/media/common/videobuf2/videobuf2-dma-contig.c |  3 ++-
>  drivers/media/common/videobuf2/videobuf2-dma-sg.c     |  4 +++-
>  drivers/media/common/videobuf2/videobuf2-memops.c     |  6 ++++--
>  drivers/media/common/videobuf2/videobuf2-vmalloc.c    |  4 +++-
>  include/media/frame_vector.h                          |  2 +-
>  include/media/videobuf2-memops.h                      |  3 ++-
>  7 files changed, 22 insertions(+), 10 deletions(-)
>

Thanks!

Acked-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz

> diff --git a/drivers/media/common/videobuf2/frame_vector.c b/drivers/media/common/videobuf2/frame_vector.c
> index 542dde9d2609..aad72640f055 100644
> --- a/drivers/media/common/videobuf2/frame_vector.c
> +++ b/drivers/media/common/videobuf2/frame_vector.c
> @@ -14,6 +14,7 @@
>   * get_vaddr_frames() - map virtual addresses to pfns
>   * @start:     starting user address
>   * @nr_frames: number of pages / pfns from start to map
> + * @write:     the mapped address has write permission
>   * @vec:       structure which receives pages / pfns of the addresses mapped.
>   *             It should have space for at least nr_frames entries.
>   *
> @@ -32,7 +33,7 @@
>   *
>   * This function takes care of grabbing mmap_lock as necessary.
>   */
> -int get_vaddr_frames(unsigned long start, unsigned int nr_frames,
> +int get_vaddr_frames(unsigned long start, unsigned int nr_frames, bool write,
>                      struct frame_vector *vec)
>  {
>         struct mm_struct *mm = current->mm;
> @@ -40,6 +41,7 @@ int get_vaddr_frames(unsigned long start, unsigned int nr_frames,
>         int ret_pin_user_pages_fast = 0;
>         int ret = 0;
>         int err;
> +       unsigned int gup_flags = FOLL_FORCE | FOLL_LONGTERM;
>
>         if (nr_frames == 0)
>                 return 0;
> @@ -49,8 +51,10 @@ int get_vaddr_frames(unsigned long start, unsigned int nr_frames,
>
>         start = untagged_addr(start);
>
> -       ret = pin_user_pages_fast(start, nr_frames,
> -                                 FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM,
> +       if (write)
> +               gup_flags |= FOLL_WRITE;
> +
> +       ret = pin_user_pages_fast(start, nr_frames, gup_flags,
>                                   (struct page **)(vec->ptrs));
>         if (ret > 0) {
>                 vec->got_ref = true;
> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> index 678b359717c4..8e55468cb60d 100644
> --- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> +++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> @@ -603,7 +603,8 @@ static void *vb2_dc_get_userptr(struct vb2_buffer *vb, struct device *dev,
>         buf->vb = vb;
>
>         offset = lower_32_bits(offset_in_page(vaddr));
> -       vec = vb2_create_framevec(vaddr, size);
> +       vec = vb2_create_framevec(vaddr, size, buf->dma_dir == DMA_FROM_DEVICE ||
> +                                              buf->dma_dir == DMA_BIDIRECTIONAL);
>         if (IS_ERR(vec)) {
>                 ret = PTR_ERR(vec);
>                 goto fail_buf;
> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> index fa69158a65b1..099693e42bc6 100644
> --- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> +++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> @@ -241,7 +241,9 @@ static void *vb2_dma_sg_get_userptr(struct vb2_buffer *vb, struct device *dev,
>         buf->size = size;
>         buf->dma_sgt = &buf->sg_table;
>         buf->vb = vb;
> -       vec = vb2_create_framevec(vaddr, size);
> +       vec = vb2_create_framevec(vaddr, size,
> +                                 buf->dma_dir == DMA_FROM_DEVICE ||
> +                                 buf->dma_dir == DMA_BIDIRECTIONAL);
>         if (IS_ERR(vec))
>                 goto userptr_fail_pfnvec;
>         buf->vec = vec;
> diff --git a/drivers/media/common/videobuf2/videobuf2-memops.c b/drivers/media/common/videobuf2/videobuf2-memops.c
> index 9dd6c27162f4..f9a4ec44422e 100644
> --- a/drivers/media/common/videobuf2/videobuf2-memops.c
> +++ b/drivers/media/common/videobuf2/videobuf2-memops.c
> @@ -26,6 +26,7 @@
>   * vb2_create_framevec() - map virtual addresses to pfns
>   * @start:     Virtual user address where we start mapping
>   * @length:    Length of a range to map
> + * @write:     Should we map for writing into the area
>   *
>   * This function allocates and fills in a vector with pfns corresponding to
>   * virtual address range passed in arguments. If pfns have corresponding pages,
> @@ -34,7 +35,8 @@
>   * failure. Returned vector needs to be freed via vb2_destroy_pfnvec().
>   */
>  struct frame_vector *vb2_create_framevec(unsigned long start,
> -                                        unsigned long length)
> +                                        unsigned long length,
> +                                        bool write)
>  {
>         int ret;
>         unsigned long first, last;
> @@ -47,7 +49,7 @@ struct frame_vector *vb2_create_framevec(unsigned long start,
>         vec = frame_vector_create(nr);
>         if (!vec)
>                 return ERR_PTR(-ENOMEM);
> -       ret = get_vaddr_frames(start & PAGE_MASK, nr, vec);
> +       ret = get_vaddr_frames(start & PAGE_MASK, nr, write, vec);
>         if (ret < 0)
>                 goto out_destroy;
>         /* We accept only complete set of PFNs */
> diff --git a/drivers/media/common/videobuf2/videobuf2-vmalloc.c b/drivers/media/common/videobuf2/videobuf2-vmalloc.c
> index 948152f1596b..67d0b89e701b 100644
> --- a/drivers/media/common/videobuf2/videobuf2-vmalloc.c
> +++ b/drivers/media/common/videobuf2/videobuf2-vmalloc.c
> @@ -85,7 +85,9 @@ static void *vb2_vmalloc_get_userptr(struct vb2_buffer *vb, struct device *dev,
>         buf->dma_dir = vb->vb2_queue->dma_dir;
>         offset = vaddr & ~PAGE_MASK;
>         buf->size = size;
> -       vec = vb2_create_framevec(vaddr, size);
> +       vec = vb2_create_framevec(vaddr, size,
> +                                 buf->dma_dir == DMA_FROM_DEVICE ||
> +                                 buf->dma_dir == DMA_BIDIRECTIONAL);
>         if (IS_ERR(vec)) {
>                 ret = PTR_ERR(vec);
>                 goto fail_pfnvec_create;
> diff --git a/include/media/frame_vector.h b/include/media/frame_vector.h
> index bfed1710dc24..541c71a2c7be 100644
> --- a/include/media/frame_vector.h
> +++ b/include/media/frame_vector.h
> @@ -16,7 +16,7 @@ struct frame_vector {
>  struct frame_vector *frame_vector_create(unsigned int nr_frames);
>  void frame_vector_destroy(struct frame_vector *vec);
>  int get_vaddr_frames(unsigned long start, unsigned int nr_pfns,
> -                    struct frame_vector *vec);
> +                    bool write, struct frame_vector *vec);
>  void put_vaddr_frames(struct frame_vector *vec);
>  int frame_vector_to_pages(struct frame_vector *vec);
>  void frame_vector_to_pfns(struct frame_vector *vec);
> diff --git a/include/media/videobuf2-memops.h b/include/media/videobuf2-memops.h
> index cd4a46331531..4b5b84f93538 100644
> --- a/include/media/videobuf2-memops.h
> +++ b/include/media/videobuf2-memops.h
> @@ -34,7 +34,8 @@ struct vb2_vmarea_handler {
>  extern const struct vm_operations_struct vb2_common_vm_ops;
>
>  struct frame_vector *vb2_create_framevec(unsigned long start,
> -                                        unsigned long length);
> +                                        unsigned long length,
> +                                        bool write);
>  void vb2_destroy_framevec(struct frame_vector *vec);
>
>  #endif
> --
> 2.35.1
>
