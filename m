Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA69374C094
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 05:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjGIDRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 23:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGIDRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 23:17:52 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A6A194
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 20:17:50 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-345a8a78bcfso11761655ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 20:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688872670; x=1691464670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pajua8DTHe0LU0NvKmaZNmhsvntfPsVegLLIN6qeonw=;
        b=c2WG6gTaY4IteKtOpXpcjKS+BWSbpB5O8qaTASoNGNpKHf4J2nfK53/4KW3Vi2zvLA
         7wD47mrT9oa7hQcWeWBQMzYPiZts9cZnCXhN8ljXD00i4raGQxdys7Wf5uMh3xmcWYiz
         Lv5+IVU5ccxnf9A/rjj6QLTAX0Q1noWmFrPuLSFxMCVHaAvk8ELh3oWpOgnQRj5ZP6/j
         mDy+zlAZSGXll8kmqnbeeOkX7qWDeIa+b/fm1hfxz+NpxW4Xdu67cz3aw5XYs+d+iYCL
         XPwZPM7JRrYPsoBUAdIIxhnBzvJdGZfdzP7Vh2TXi1yq1Wr96KYw8rpePMpk4eSLNBVg
         pjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688872670; x=1691464670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pajua8DTHe0LU0NvKmaZNmhsvntfPsVegLLIN6qeonw=;
        b=XTEWQ4hjccDDDYbRS+dJWfTG7A8BmnksmALwFZwWQpm0W6GDElMB702N3On4CUBCW0
         0jiBcoVAAQAXqfmz1/zkeBBloxgM2ocAcESY+ylchG5XO2gGMm55dQA7jbkwNER6UwL2
         Rz0nQfSM0khvYoJMAYO/zaYDfCOjPSpPBK8NKkdiicKHlg3i2IY4aHLoqKe0vl43WrMT
         q+QQJLuwBSLTNdeKpu+z4ZmtpQnyrwjeUlATciU9vyI4E9dpkaJp/6C0N7qQWiHf1FrK
         RzP5h3Ss98eqTnUvvaJftaDTRb5iCgCW1pBZ3q2mInUPfYG2fNPNqI5EKHR6s0h9zb0P
         g07g==
X-Gm-Message-State: ABy/qLZfYzy8+WMD4NZ/Iq3WnxSO87C+a3XqdO9eC1mNKsYs3l3O84NI
        ZzTmKDAA9NDOCi/Ghi/aIUOWY4NQHFxQOc5ZJeI=
X-Google-Smtp-Source: APBJJlFT7whb+5VDOt40wDM/7VHrKni1kUHfulszhQQyIXD3338u/uzr61koCtRt8FNo9kBQszPUshUc0Wgb+vvYBag=
X-Received: by 2002:a5e:c103:0:b0:783:43f2:1b4b with SMTP id
 v3-20020a5ec103000000b0078343f21b4bmr8925237iol.6.1688872670180; Sat, 08 Jul
 2023 20:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230709025817.3842416-1-senozhatsky@chromium.org>
In-Reply-To: <20230709025817.3842416-1-senozhatsky@chromium.org>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Sat, 8 Jul 2023 20:17:38 -0700
Message-ID: <CAKEwX=NRS0wa1NToNyA2=F_D3pK5BLeV7Up6PJUpag=Dy8psdQ@mail.gmail.com>
Subject: Re: [PATCH] zsmalloc: remove obj_tagged()
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 8, 2023 at 7:58=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> obj_tagged() is not needed at this point, because objects can
> only have one tag: OBJ_ALLOCATED_TAG. We needed obj_tagged()
> for the zsmalloc LRU implementation, which has now been
> removed. Simplify zsmalloc code and revert to the previous
> implementation that was in place before the zsmalloc LRU series.
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  mm/zsmalloc.c | 29 +++++++----------------------
>  1 file changed, 7 insertions(+), 22 deletions(-)
>
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 84beadc088b8..32f5bc4074df 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -795,8 +795,8 @@ static unsigned long handle_to_obj(unsigned long hand=
le)
>         return *(unsigned long *)handle;
>  }
>
> -static bool obj_tagged(struct page *page, void *obj, unsigned long *phan=
dle,
> -               int tag)
> +static inline bool obj_allocated(struct page *page, void *obj,
> +                                unsigned long *phandle)
>  {
>         unsigned long handle;
>         struct zspage *zspage =3D get_zspage(page);
> @@ -807,7 +807,7 @@ static bool obj_tagged(struct page *page, void *obj, =
unsigned long *phandle,
>         } else
>                 handle =3D *(unsigned long *)obj;
>
> -       if (!(handle & tag))
> +       if (!(handle & OBJ_ALLOCATED_TAG))
>                 return false;
>
>         /* Clear all tags before returning the handle */
> @@ -815,11 +815,6 @@ static bool obj_tagged(struct page *page, void *obj,=
 unsigned long *phandle,
>         return true;
>  }
>
> -static inline bool obj_allocated(struct page *page, void *obj, unsigned =
long *phandle)
> -{
> -       return obj_tagged(page, obj, phandle, OBJ_ALLOCATED_TAG);
> -}
> -
>  static void reset_page(struct page *page)
>  {
>         __ClearPageMovable(page);
> @@ -1551,11 +1546,11 @@ static void zs_object_copy(struct size_class *cla=
ss, unsigned long dst,
>  }
>
>  /*
> - * Find object with a certain tag in zspage from index object and
> + * Find alloced object in zspage from index object and
>   * return handle.
>   */
> -static unsigned long find_tagged_obj(struct size_class *class,
> -                                       struct page *page, int *obj_idx, =
int tag)
> +static unsigned long find_alloced_obj(struct size_class *class,
> +                                     struct page *page, int *obj_idx)
>  {
>         unsigned int offset;
>         int index =3D *obj_idx;
> @@ -1566,7 +1561,7 @@ static unsigned long find_tagged_obj(struct size_cl=
ass *class,
>         offset +=3D class->size * index;
>
>         while (offset < PAGE_SIZE) {
> -               if (obj_tagged(page, addr + offset, &handle, tag))
> +               if (obj_allocated(page, addr + offset, &handle))
>                         break;
>
>                 offset +=3D class->size;
> @@ -1580,16 +1575,6 @@ static unsigned long find_tagged_obj(struct size_c=
lass *class,
>         return handle;
>  }
>
> -/*
> - * Find alloced object in zspage from index object and
> - * return handle.
> - */
> -static unsigned long find_alloced_obj(struct size_class *class,
> -                                       struct page *page, int *obj_idx)
> -{
> -       return find_tagged_obj(class, page, obj_idx, OBJ_ALLOCATED_TAG);
> -}
> -
>  static void migrate_zspage(struct zs_pool *pool, struct zspage *src_zspa=
ge,
>                            struct zspage *dst_zspage)
>  {
> --
> 2.41.0.255.g8b1d071c50-goog
>
>

LGTM! This was only introduced for the (temporary) deferred tag.
We've removed it so this should go away too.

Acked-by: Nhat Pham <nphamcs@gmail.com>
