Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020C1694BD2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjBMPz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjBMPzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:55:46 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9E91F5C3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:55:31 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id sa10so32946805ejc.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vuapDqdagNGnFpo6uhL7k0neEZp9M4gz2OrukVtMrUk=;
        b=K4Iqa4GhRfHb+pDFe/SkIa74T/KmapgIhH5krvXfe49NjyMplxwmP1Jsm78gwC7DT3
         Sr1nbbEwQiVx8nDHf36NzuQiJt5WZJIA3T3D/7yVgkQ5nP+EeN8WhSFi0HeosPqTQdFH
         SjYQ5cPJlPdIrHefP4dhusrlHj5hNMS0rg17EY4sSNtXeUhJuPmqrxy9dU80hnPJe/1o
         ofg2h8s78dWEY60ka1hrYajZj4b4nO4TMCCurU3nLecnJMJv4MV13wd6DcNsUAWi0Ows
         /DLLWB+3NqnUQ/UE8p9ppHnqVaP2VNK0pTlHJeBZupCquC/HsC0NI13ez846N3V7WJ0E
         bRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuapDqdagNGnFpo6uhL7k0neEZp9M4gz2OrukVtMrUk=;
        b=C8QF0DvcWOtRR7rTYIGmkY4IznPdMfva1QaXrhwak84SzUSRi35FyYytzqiAQ3nTuy
         GL2XI3Tz611DRoGKieRcYSQSs7w/ZgJcmcMP3RFD/Nqt6oYKmow3MCkbZDXEERF8K26S
         joHD5dK2SW9/Yt0rRnuGyGfducwSPHFHVcHDX4vmQNBgLHAVSTyo63LqC1WFMvDLTHfj
         IV8iZr5aN2ia5SmstoRsrX8gyHmZhsD2abGQhKpGghv/M0A/GjgqAWI5qNe803ZdkDBy
         fHPXp6QoG9ShfZOrxTsELHya4hdGaK9IU6UKtiEwejqfPfeCPvYI3QDGqqs3YsfkDGvf
         P6xg==
X-Gm-Message-State: AO0yUKXnMF41ytHmIAmPPEv1OUcvvcN4KzSBCVdQGDmNqveL1jv7+/Fr
        F1eCv4GjUdVnN7sRWpc1+Lo+PxeL+kIdhg8BfRa0zg==
X-Google-Smtp-Source: AK7set9U1akcHIKuL0+KX0vTYez7hYPW+SEKgxRVoV8Zx2osQnaDonnagZ++a1daYV4ESYRduLdCKQ==
X-Received: by 2002:a17:907:168e:b0:8b0:23a6:c491 with SMTP id hc14-20020a170907168e00b008b023a6c491mr11788390ejc.31.1676303730005;
        Mon, 13 Feb 2023 07:55:30 -0800 (PST)
Received: from jade (h-46-59-78-111.A175.priv.bahnhof.se. [46.59.78.111])
        by smtp.gmail.com with ESMTPSA id n8-20020a1709065e0800b0087fa83790d8sm7045465eju.13.2023.02.13.07.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 07:55:29 -0800 (PST)
Date:   Mon, 13 Feb 2023 16:55:27 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-mm@kvack.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH v2 4/4] mm: Remove get_kernel_pages()
Message-ID: <Y+pdbyqLVxZp4vYk@jade>
References: <20230203-get_kernel_pages-v2-0-f1dc4af273f1@intel.com>
 <20230203-get_kernel_pages-v2-4-f1dc4af273f1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230203-get_kernel_pages-v2-4-f1dc4af273f1@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 08:06:35PM -0800, Ira Weiny wrote:
> The only caller to get_kernel_pages() [shm_get_kernel_pages()] has been
> updated to not need it.
> 
> Remove get_kernel_pages().
> 
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Acked-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  include/linux/mm.h |  2 --
>  mm/swap.c          | 30 ------------------------------
>  2 files changed, 32 deletions(-)

Added to https://git.linaro.org/people/jens.wiklander/linux-tee.git/log/?h=get_kernel_pages-for-v6.4

Thanks,
Jens

> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 8f857163ac89..2041e6d4fa27 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2095,8 +2095,6 @@ int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
>  			struct task_struct *task, bool bypass_rlim);
>  
>  struct kvec;
> -int get_kernel_pages(const struct kvec *iov, int nr_pages, int write,
> -			struct page **pages);
>  struct page *get_dump_page(unsigned long addr);
>  
>  bool folio_mark_dirty(struct folio *folio);
> diff --git a/mm/swap.c b/mm/swap.c
> index 70e2063ef43a..4c03ecab698e 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -158,36 +158,6 @@ void put_pages_list(struct list_head *pages)
>  }
>  EXPORT_SYMBOL(put_pages_list);
>  
> -/*
> - * get_kernel_pages() - pin kernel pages in memory
> - * @kiov:	An array of struct kvec structures
> - * @nr_segs:	number of segments to pin
> - * @write:	pinning for read/write, currently ignored
> - * @pages:	array that receives pointers to the pages pinned.
> - *		Should be at least nr_segs long.
> - *
> - * Returns number of pages pinned. This may be fewer than the number requested.
> - * If nr_segs is 0 or negative, returns 0.  If no pages were pinned, returns 0.
> - * Each page returned must be released with a put_page() call when it is
> - * finished with.
> - */
> -int get_kernel_pages(const struct kvec *kiov, int nr_segs, int write,
> -		struct page **pages)
> -{
> -	int seg;
> -
> -	for (seg = 0; seg < nr_segs; seg++) {
> -		if (WARN_ON(kiov[seg].iov_len != PAGE_SIZE))
> -			return seg;
> -
> -		pages[seg] = kmap_to_page(kiov[seg].iov_base);
> -		get_page(pages[seg]);
> -	}
> -
> -	return seg;
> -}
> -EXPORT_SYMBOL_GPL(get_kernel_pages);
> -
>  typedef void (*move_fn_t)(struct lruvec *lruvec, struct folio *folio);
>  
>  static void lru_add_fn(struct lruvec *lruvec, struct folio *folio)
> 
> -- 
> 2.39.1
