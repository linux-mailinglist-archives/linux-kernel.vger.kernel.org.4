Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F1A5F28DC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 08:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiJCG5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 02:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJCG5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 02:57:21 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F483B3
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 23:57:19 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id nb11so20109642ejc.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 23:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=/1Kjm+tlGvTFEl2ExNhozH8lcuXI6M+d4lR60oFBYPY=;
        b=AwzKwhX9x4Yjc9haniR/rahUAxhObz4WWpbKmDsQJFtYTWYjud6EIXN0a16X/ZAYyF
         7qotqFzbCOP3Xvcc2ToRTpraOm1QEXGrpuw5hT0ffe9kK1T7eDAD9+1RmXFuytVmcfPK
         dprc9JqQL8M2obHbszNmRyoHq+7QBUUth9lVR/015GUp1OTjbQOfQaDYIK2uJKXnckU8
         lzIWFvCKgXYp+pgmCGHAPfaLY2LQK2XJZyBjWcr+qWVvwksOnAtAwehpwiO7yHQrKKWN
         PtDzhSk/8v/0Y6Xbrrtd9FDPVPnL75559cLY7hefuYX3rpVpyWO3BO9tvBvuqWOAKhah
         OJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/1Kjm+tlGvTFEl2ExNhozH8lcuXI6M+d4lR60oFBYPY=;
        b=T2qSfjB8x3wz3gyoMgOpk60ALaNETItI2xRnj9dFMgdvZXR8FWgHnB5kDLwHgF3ZVA
         RYmfqmNKklSn4LRho9UfmtXLvnA92CYOjre5ajjakxogzauDqtPRRg+OXe7cEq/l3cmp
         4YFixxJXYepR8B5YohQ3z+vn/M8tVrxK3zlsHcPNZsN3A9ed1T1OThqPDOR52d+B0osa
         2jOeZYIcAISECxp9nrVJEGkNoy6YZ+aXYJAnQujtR0RcSxAeIilg0T589z3gbJ2vl6DH
         vzMWuPWlCrLd52V/ysaPepOjIcqtSPYoAlNtLeeldgx3T2Qz0l22EnKv//omxBj8qtup
         PDDg==
X-Gm-Message-State: ACrzQf1BW56KvdM558df68F0JRRJeeGQare93Snyt4sSo+Nd+qVVFf0U
        YUEdMGU2WE1sl3ufsTsLVpLvp4fmH2AacE9WCLVe0g==
X-Google-Smtp-Source: AMsMyM5FQ+w+b43fu1d2E5z9n2EJdkuBjnXBhBiEEM6h0EjD1QSp1uuUgMt5/A/KCI9Ly/ibFGu516iRajZAjCiJmRw=
X-Received: by 2002:a17:907:8a17:b0:782:6e72:7aba with SMTP id
 sc23-20020a1709078a1700b007826e727abamr14424481ejc.474.1664780238397; Sun, 02
 Oct 2022 23:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221002002326.946620-1-ira.weiny@intel.com> <20221002002326.946620-3-ira.weiny@intel.com>
In-Reply-To: <20221002002326.946620-3-ira.weiny@intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 3 Oct 2022 12:27:07 +0530
Message-ID: <CAFA6WYOGT1sJLA4c_B88NaXgxv4fm-idi5QMYvXdXB0acCF3sw@mail.gmail.com>
Subject: Re: [PATCH 2/4] tee: Remove vmalloc page support
To:     ira.weiny@intel.com
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Phil Chang <phil.chang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Phil

Hi Ira,

On Sun, 2 Oct 2022 at 05:53, <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> The kernel pages used by shm_get_kernel_pages() are allocated using
> GFP_KERNEL through the following call stack:
>
> trusted_instantiate()
>         trusted_payload_alloc() -> GFP_KERNEL
>         <trusted key op>
>                 tee_shm_register_kernel_buf()
>                         register_shm_helper()
>                                 shm_get_kernel_pages()
>
> Where <trusted key op> is one of:
>
>         trusted_key_unseal()
>         trusted_key_get_random()
>         trusted_key_seal()
>
> Remove the vmalloc page support from shm_get_kernel_pages().  Replace
> with a warn on once.
>
> Cc: Jens Wiklander <jens.wiklander@linaro.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>
> ---
> Jens I went with the suggestion from Linus and Christoph and rejected
> vmalloc addresses.  I did not hear back from you regarding Linus'
> question if the vmalloc page support was required by an up coming patch
> set or not.  So I assumed it was something out of tree.

It looks like I wasn't CC'd to that conversation. IIRC, support for
vmalloc addresses was added recently by Phil here [1]. So I would like
to give him a chance if he is planning to post a corresponding kernel
driver upstream.

[1] https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/thread/M7HI3P2M66V27SK35CGQRICZ7DJZ5J2W/

-Sumit

> ---
>  drivers/tee/tee_shm.c | 36 ++++++++++++------------------------
>  1 file changed, 12 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 27295bda3e0b..527a6eabc03e 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -24,37 +24,25 @@ static void shm_put_kernel_pages(struct page **pages, size_t page_count)
>  static int shm_get_kernel_pages(unsigned long start, size_t page_count,
>                                 struct page **pages)
>  {
> +       struct kvec *kiov;
>         size_t n;
>         int rc;
>
> -       if (is_vmalloc_addr((void *)start)) {
> -               struct page *page;
> -
> -               for (n = 0; n < page_count; n++) {
> -                       page = vmalloc_to_page((void *)(start + PAGE_SIZE * n));
> -                       if (!page)
> -                               return -ENOMEM;
> -
> -                       get_page(page);
> -                       pages[n] = page;
> -               }
> -               rc = page_count;
> -       } else {
> -               struct kvec *kiov;
> -
> -               kiov = kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
> -               if (!kiov)
> -                       return -ENOMEM;
> +       if (WARN_ON_ONCE(is_vmalloc_addr((void *)start)))
> +               return -EINVAL;
>
> -               for (n = 0; n < page_count; n++) {
> -                       kiov[n].iov_base = (void *)(start + n * PAGE_SIZE);
> -                       kiov[n].iov_len = PAGE_SIZE;
> -               }
> +       kiov = kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
> +       if (!kiov)
> +               return -ENOMEM;
>
> -               rc = get_kernel_pages(kiov, page_count, 0, pages);
> -               kfree(kiov);
> +       for (n = 0; n < page_count; n++) {
> +               kiov[n].iov_base = (void *)(start + n * PAGE_SIZE);
> +               kiov[n].iov_len = PAGE_SIZE;
>         }
>
> +       rc = get_kernel_pages(kiov, page_count, 0, pages);
> +       kfree(kiov);
> +
>         return rc;
>  }
>
> --
> 2.37.2
>
