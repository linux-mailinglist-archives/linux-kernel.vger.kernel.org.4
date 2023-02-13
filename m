Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D85E694BC5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjBMPx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBMPxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:53:54 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698061A964
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:53:32 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id lf10so1132929ejc.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ErP9Hj2AwOIstoW4LCGtWgkfr95nFgcjNc3X3BVDtg8=;
        b=ESqpZ2SyACH+rx3ficRZwkEfOXx4Z38f23MnpKfiCXinSXOrrxE2kfXFiT1vpt2tkz
         Uv749H46y54fUqa7WB+QgIg3VI0bdJwDOhOXe4+fTk5s7ERzsQ6cPlWaz8td0aL3jSmv
         YYKmajPm4PLoU3oQcXs0ZKPSXhKVo3wbLPp2+Vb4M0v8jMG7UQFzr8kSo0ORvKGWuw/s
         RoppqjMF/xS9oQZRzooIZ2qgsTqnz9BXCNTPLlBteZCPP+U1AyvgmiBEQG1Jn7zV42w3
         GXv6HxVemoKUcX+Kza8ANrqymV1QfahGPwGFXYoUAGxENsAkJ4w0t9FCqdDrK/LQieZm
         IXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErP9Hj2AwOIstoW4LCGtWgkfr95nFgcjNc3X3BVDtg8=;
        b=RH48ycEwGWVQC+Pe9sQ4EAN3xqV87Ml1srUeCjY4w322MipFGkYJIzVpJzHIxmt6HW
         STYWVoFkEiX0EzLBY3SrzO9ZdzxgSXPybLuPU9N3O1HeNa/aZ1g/vbR9q9fbK0c2qpar
         8SL2SAJCOYT2luQuzWV+paGl8IDz3egoJXpRqyE8rtPTW0ZWl+3H7Xp8IaA0OhoQQu0B
         1jVp00cC4uQn5q10iL4L/zdbdO5qTW3oim26SmzQsrogZ1DDZ/gyxOFl4Ccm6EP/Mjfs
         MpTBO3IAYBup0mH9X/Sx20b1nSglnvCFYYZRgEL1pVwy1R0BTSTLXU9iwXaJLKHyQS0C
         y1dA==
X-Gm-Message-State: AO0yUKVCqPJcgQMcx7gp69FbTBe21SoE7+Uc2j8EC+v0qFfafJRtgxLt
        wtdwfD2e2l7XmwCNjvn6yzTfvg==
X-Google-Smtp-Source: AK7set9mYJtrUKijJxj85pueN8QYB7Ucy/bsLKu+MCUB6RMXL6TmXygXX/dqmUMT9vRfQ824aMfw9Q==
X-Received: by 2002:a17:906:30d9:b0:882:e975:2fd5 with SMTP id b25-20020a17090630d900b00882e9752fd5mr23762877ejb.26.1676303610644;
        Mon, 13 Feb 2023 07:53:30 -0800 (PST)
Received: from jade (h-46-59-78-111.A175.priv.bahnhof.se. [46.59.78.111])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906319200b0084d3bf4498csm7024642ejy.140.2023.02.13.07.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 07:53:30 -0800 (PST)
Date:   Mon, 13 Feb 2023 16:53:28 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-mm@kvack.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 1/4] highmem: Enhance is_kmap_addr() to check
 kmap_local_page() mappings
Message-ID: <Y+pc+AZ22Tflnpuk@jade>
References: <20230203-get_kernel_pages-v2-0-f1dc4af273f1@intel.com>
 <20230203-get_kernel_pages-v2-1-f1dc4af273f1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230203-get_kernel_pages-v2-1-f1dc4af273f1@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 08:06:32PM -0800, Ira Weiny wrote:
> is_kmap_addr() is only looking at the kmap() address range which may
> cause check_heap_object() to miss checking an overflow on a
> kmap_local_page() page.
> 
> Add a check for the kmap_local_page() address range to is_kmap_addr().
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  include/linux/highmem-internal.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Added to https://git.linaro.org/people/jens.wiklander/linux-tee.git/log/?h=get_kernel_pages-for-v6.4

Thanks,
Jens

> diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
> index e098f38422af..a3028e400a9c 100644
> --- a/include/linux/highmem-internal.h
> +++ b/include/linux/highmem-internal.h
> @@ -152,7 +152,10 @@ static inline void totalhigh_pages_add(long count)
>  static inline bool is_kmap_addr(const void *x)
>  {
>  	unsigned long addr = (unsigned long)x;
> -	return addr >= PKMAP_ADDR(0) && addr < PKMAP_ADDR(LAST_PKMAP);
> +
> +	return (addr >= PKMAP_ADDR(0) && addr < PKMAP_ADDR(LAST_PKMAP)) ||
> +		(addr >= __fix_to_virt(FIX_KMAP_END) &&
> +		 addr < __fix_to_virt(FIX_KMAP_BEGIN));
>  }
>  #else /* CONFIG_HIGHMEM */
>  
> 
> -- 
> 2.39.1
