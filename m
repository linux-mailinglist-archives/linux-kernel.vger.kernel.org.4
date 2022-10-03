Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BEB5F289D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 08:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJCGlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 02:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJCGlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 02:41:46 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700CD3AE72
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 23:41:44 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id l12so8916204pjh.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 23:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ScdaBgFXaRs1eyoBsVV/91rx258ROb5jgVthd9W2/J8=;
        b=DlFF2Ar21f3FNeiCL9SCozGNsnkd9hYvXZfj+9n44a6RCBUTzL602lvQsvDplZvHHX
         ybk9hLAenBFNHiOymfzg+5VtD7XaklM5U9TaBzOzzELVHFfY2wgjEigUltyQZvqXws1l
         xK5CZHKnEkLT5zowBm732obuo7DVbUf6qgQA5089cHMV+5gZpO0aziXW74H60Jth06Qb
         TNt0mz/pGr+VcGpIWRG+BYL2Gb4uR7NwiFicQFVVP2FeQfFSM8mOGH8YuEu9NTnPjkfS
         jbMfazfBF/imqPMpxrCKBBOsK8QxnOFj6siWQS1EIQwuEFaUmyXpgPE3vECeJf3prxXX
         hExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ScdaBgFXaRs1eyoBsVV/91rx258ROb5jgVthd9W2/J8=;
        b=Fa58AM4uxzGtEYF3KTDjsTpuvVtAwQrzmWKXNVq+KleKphos7uAmAR/PI4RwnESGrj
         17r16rl2eK2pEQEMY+QTqhxTwctqi27ZgtehdkEsR5+wdZBQ0NtqS/VHpCiAGsSB43OY
         Ea35G88+01MDYLQh9WTWkZA7uHp3bEtKSMPIyd1E/ChSeetLSfYfW6iaC8Fzr0sR27e2
         +z/oUSgH0GFzi+N1iaNMKbYnUHtNor1yBZwAXNv8++svrvh3N+RiYpcCxZLKS+OL0xkA
         R4CYKLsomUK5/Gf+e1n1dZO5uOB23bJudiJx2+OGNzz5riwP10Z426XX85TTq3Ig/b6P
         9GvA==
X-Gm-Message-State: ACrzQf0RiSRt0Q+CkvJTDZQyBuU/i4TnUR17VB1LvXbYsPNLfDPQ0usX
        sfM+XcnKvd9XJJcgWm3wL7WtDjj2VQe7gk/qUpYkVA==
X-Google-Smtp-Source: AMsMyM4mfa3XZLqdg492URjcVsH7rT6K1G8Xq4IJJbfmqDqVxmbS7hvkxYwDKhQ104Av+emUnEnfR1thSbTlYv2mNLM=
X-Received: by 2002:a17:90b:4b88:b0:202:e381:e643 with SMTP id
 lr8-20020a17090b4b8800b00202e381e643mr10508198pjb.148.1664779303942; Sun, 02
 Oct 2022 23:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <20221002002326.946620-1-ira.weiny@intel.com> <20221002002326.946620-3-ira.weiny@intel.com>
In-Reply-To: <20221002002326.946620-3-ira.weiny@intel.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 3 Oct 2022 08:41:33 +0200
Message-ID: <CAHUa44FeMb09_ix0p+cQsZdch1TO3zWi3yVYG6=4TQyP3bmm7w@mail.gmail.com>
Subject: Re: [PATCH 2/4] tee: Remove vmalloc page support
To:     ira.weiny@intel.com
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ira,

On Sun, Oct 2, 2022 at 2:23 AM <ira.weiny@intel.com> wrote:
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

Yes, that's correctly assumed, sorry for not confirming that earlier.

Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>

Thanks,
Jens

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
