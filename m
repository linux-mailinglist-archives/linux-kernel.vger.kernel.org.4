Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66905694BD0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjBMPzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjBMPzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:55:12 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A221BFC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:55:03 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id lf10so1144385ejc.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pb12TVHhTBmQoUBWGqJrq866wTmloiZUeGlXVcoFPk4=;
        b=GCtIup5AQnFv/SJXGOtGB8g2XjK12qz683Tl5tUsyWknO+lQ1jPtoOEc7FBGL498tk
         HUJceFDqTi7COx6559CFbmd25618Y747+qBhqrWDcFmVVknD2n3VGfLj/ltzfnYA/QYu
         T6E6kfOUkXUid2wyA8EQSsLIZT00JnUWI5mgO3Mp/15+NsI98XL+dR+sG4u2WbMJ3+/k
         YNRVfYoH1VuvVZkS3QMb1tap1/QYr98liEho6NLSuO51MB/hFG522psYLMU6e+SsWYUn
         elLIL5csZK5DUdzK6rLE8r+zYPURwSISQLx37DY4eEvjUztIIB9WIT/W53cVUd3ZhlEL
         VFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pb12TVHhTBmQoUBWGqJrq866wTmloiZUeGlXVcoFPk4=;
        b=PoF/4Q55rT2m87FshgsjCbDQUXQqPz259XxjK26Y0MdIT4awektHfUmQP6D988PqUf
         BE+5nM4fiVxp5SFQ/qBraYtIU2RT+N6Z+fnX4XYiUaZdl9574ttfGfCGZYvbG6PJqeEA
         /HqWx9o4/38LGtHrmQInDAG5DLz1i8tdxUi8JxS8mmlzERVo6x8jdZXfA+3sY9qewcas
         Uamhf9JdwrHyur9NLavo6IdFKrUDBLX/ItnIaEjhgbdAybD1LQ0MI7CCz/AZd6U5HApU
         E/IM/icMKyYu3ewxsMEMJv8sq+RZjNG6dG74UddwBF/O6ImIavnePAb2HhuyzKdtdjgQ
         8cwg==
X-Gm-Message-State: AO0yUKVkQUfN/DDMetj+lGkXdLgeBUq5Gnj2lzTHOwSexXhgFQy+Whaq
        7uMl7xTB/Bn+GYNH9YflpG5IWQ==
X-Google-Smtp-Source: AK7set+0pq6n0aTwl+Oavu3dvKR0wuGItIJ5scypKS6u3+HcvuhdauDs4BFr4vfBpMMpApk1TYxJSg==
X-Received: by 2002:a17:907:7e9d:b0:8af:2a9f:31e9 with SMTP id qb29-20020a1709077e9d00b008af2a9f31e9mr19844019ejc.31.1676303702508;
        Mon, 13 Feb 2023 07:55:02 -0800 (PST)
Received: from jade (h-46-59-78-111.A175.priv.bahnhof.se. [46.59.78.111])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709060ec900b008aac35b1c2esm7057298eji.173.2023.02.13.07.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 07:55:02 -0800 (PST)
Date:   Mon, 13 Feb 2023 16:55:00 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-mm@kvack.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 3/4] tee: Remove call to get_kernel_pages()
Message-ID: <Y+pdVMV5h6XaeCt2@jade>
References: <20230203-get_kernel_pages-v2-0-f1dc4af273f1@intel.com>
 <20230203-get_kernel_pages-v2-3-f1dc4af273f1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230203-get_kernel_pages-v2-3-f1dc4af273f1@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 08:06:34PM -0800, Ira Weiny wrote:
> The kernel pages used by shm_get_kernel_pages() are allocated using
> GFP_KERNEL through the following call stack:
> 
> trusted_instantiate()
> 	trusted_payload_alloc() -> GFP_KERNEL
> 	<trusted key op>
> 		tee_shm_register_kernel_buf()
> 			register_shm_helper()
> 				shm_get_kernel_pages()
> 
> Where <trusted key op> is one of:
> 
> 	trusted_key_unseal()
> 	trusted_key_get_random()
> 	trusted_key_seal()
> 
> Because the pages can't be from highmem get_kernel_pages() boils down to
> a get_page() call.
> 
> Remove the get_kernel_pages() call and open code the get_page().
> 
> In case a highmem page does slip through warn on once for a kmap'ed
> address.
> 
> Cc: Jens Wiklander <jens.wiklander@linaro.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from v1:
> 	Al/Christoph: Remove kiov altogether
> ---
>  drivers/tee/tee_shm.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)

Added to https://git.linaro.org/people/jens.wiklander/linux-tee.git/log/?h=get_kernel_pages-for-v6.4

Thanks,
Jens

> 
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 527a6eabc03e..b1c6231defad 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -11,6 +11,7 @@
>  #include <linux/tee_drv.h>
>  #include <linux/uaccess.h>
>  #include <linux/uio.h>
> +#include <linux/highmem.h>
>  #include "tee_private.h"
>  
>  static void shm_put_kernel_pages(struct page **pages, size_t page_count)
> @@ -24,26 +25,20 @@ static void shm_put_kernel_pages(struct page **pages, size_t page_count)
>  static int shm_get_kernel_pages(unsigned long start, size_t page_count,
>  				struct page **pages)
>  {
> -	struct kvec *kiov;
> +	struct page *page;
>  	size_t n;
> -	int rc;
>  
> -	if (WARN_ON_ONCE(is_vmalloc_addr((void *)start)))
> +	if (WARN_ON_ONCE(is_vmalloc_addr((void *)start) ||
> +			 is_kmap_addr((void *)start)))
>  		return -EINVAL;
>  
> -	kiov = kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
> -	if (!kiov)
> -		return -ENOMEM;
> -
> +	page = virt_to_page(start);
>  	for (n = 0; n < page_count; n++) {
> -		kiov[n].iov_base = (void *)(start + n * PAGE_SIZE);
> -		kiov[n].iov_len = PAGE_SIZE;
> +		pages[n] = page + n;
> +		get_page(pages[n]);
>  	}
>  
> -	rc = get_kernel_pages(kiov, page_count, 0, pages);
> -	kfree(kiov);
> -
> -	return rc;
> +	return page_count;
>  }
>  
>  static void release_registered_pages(struct tee_shm *shm)
> 
> -- 
> 2.39.1
