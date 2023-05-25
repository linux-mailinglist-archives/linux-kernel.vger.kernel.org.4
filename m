Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FA27117CD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 22:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241383AbjEYUEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 16:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239074AbjEYUEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 16:04:32 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA95E7
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 13:04:25 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5112cae8d82so4384269a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 13:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685045064; x=1687637064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GenWYLPOmh/DxUR71oJ2OvVJUeCOFtnm9yoLhzSJ/E=;
        b=NKPfoDYrdLeFmk2aRdYPxqPS5pW5Nof94OU1LE1k7d3n4+RuYbf3dtZX81FOmgTzK/
         sLqfSBI/22EKUNuB9g5jJppihQiMCTHpCAjwXsmhXtkj7d+i9yGG1LSsR6AgbrBB5UXT
         e0zmsgoIEjRNkt2fkd4ya7KKCjNLr9lg8cN+F2jG/l1XD59r5DafHGcOQ51T9kbH5vkY
         mj2noB7t5Dc2KaLxoFwmA9wSI1RWdtvYDd6NF50EgdGVbU5BpSTgKMATR8gkiK1H/GOe
         Ti89wsXJSop7ACz+Fo5qcA5ZcWuH8SO+wbchq1LkFwAqIwPAdo6dkpOPQubVVV5qemGi
         fH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685045064; x=1687637064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GenWYLPOmh/DxUR71oJ2OvVJUeCOFtnm9yoLhzSJ/E=;
        b=YvCNxSXNC9BD5uF8gOjm8JQOiJHQ6RxNrRMTIxVzwZDLMsNZfV0qD/uNNudJZhC06o
         gcSK7uefVuaRWm23iwCv67U9YuOYJow4pGEjbhA1QC7r/FIbaqmfqrNcLhMFooSQLX9l
         gHq8s6igv2kUbQRvC8I3BHB/GxROqtOIfX/NVSe9P8ln0Q25//GKpEsdD8JN8IVJBfa6
         UgqY2DEO+GEWnlbq0B5sz7M+B0dPBgX6dzlpsu/WJ5IcGeSHULuGs6BrEm7ockRvLXeR
         lMxniqJJb7mK+oNza3QyvgGfrxv3pI/uCDnaectfr1LBf9XhW5pJ4EVY+wzbclYWsTQO
         K+FQ==
X-Gm-Message-State: AC+VfDyBje/C7uXtmf3jYre1YbS26m+UQERkBH+FV4CSeAhdUTLioib+
        YMtn9424X4QTJI+0cpkhD40ETkAjGmRv0Y5Hp+iM+xXJ9mc=
X-Google-Smtp-Source: ACHHUZ4fIXNm9bRQLhHZGBF1EIJH0qiIX6N+tTNSqcp/PEm4yQlaqSucY+RtlrFXB1XPuhcL8aIs5zRM9ZqVQLiLwhc=
X-Received: by 2002:aa7:cd79:0:b0:513:53f7:8ca2 with SMTP id
 ca25-20020aa7cd79000000b0051353f78ca2mr6245246edb.9.1685045063476; Thu, 25
 May 2023 13:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230524082424.10022-1-lstoakes@gmail.com>
In-Reply-To: <20230524082424.10022-1-lstoakes@gmail.com>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Thu, 25 May 2023 22:04:11 +0200
Message-ID: <CA+KHdyVSD=vHh-WQxS_PrJ8GnBQZGFPgcS5AkmkyoUxpe_ziEw@mail.gmail.com>
Subject: Re: [PATCH] lib/test_vmalloc.c: avoid garbage in page array
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 10:24=E2=80=AFAM Lorenzo Stoakes <lstoakes@gmail.co=
m> wrote:
>
> It turns out that alloc_pages_bulk_array() does not treat the page_array
> parameter as an output parameter, but rather reads the array and skips an=
y
> entries that have already been allocated.
>
> This is somewhat unexpected and breaks this test, as we allocate the page=
s
> array uninitialised on the assumption it will be overwritten.
>
> As a result, the test was referencing uninitialised data and causing the
> PFN to not be valid and thus a WARN_ON() followed by a null pointer deref
> and panic.
>
> In addition, this is an array of pointers not of struct page objects, so =
we
> need only allocate an array with elements of pointer size.
>
> We solve both problems by simply using kcalloc() and referencing
> sizeof(struct page *) rather than sizeof(struct page).
>
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  lib/test_vmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
> index 9dd9745d365f..3718d9886407 100644
> --- a/lib/test_vmalloc.c
> +++ b/lib/test_vmalloc.c
> @@ -369,7 +369,7 @@ vm_map_ram_test(void)
>         int i;
>
>         map_nr_pages =3D nr_pages > 0 ? nr_pages:1;
> -       pages =3D kmalloc(map_nr_pages * sizeof(struct page), GFP_KERNEL)=
;
> +       pages =3D kcalloc(map_nr_pages, sizeof(struct page *), GFP_KERNEL=
);
>         if (!pages)
>                 return -1;
>
> --
> 2.40.1
>
Uh.. :)

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki
