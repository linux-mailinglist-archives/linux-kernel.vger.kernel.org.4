Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DF160B554
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiJXSV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiJXSUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:20:50 -0400
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A63C1382D2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:02:06 -0700 (PDT)
Received: by mail-pg1-f175.google.com with SMTP id f193so9210170pgc.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cf/TLxQsRJaAY7fW9M9+2EYkzBjkKpnwfAzuDgLjY4Q=;
        b=JWeSK8iZYV2seOAkO2x6r3ABcPOeF7dTfmj0NbC4evJkg/saE5oZ76XmQfrG0439BG
         kiSXdaopPM+F4R5lLKwwGGH4TU0UMsqZ+UXPNQOKzq4KzTSjF982YXLfkkeNMxmuZJTh
         hffcFAxCTJHQccbIVMBMjRQZHtIeWrV4C0EpsN2rvBvCImYq2KsgMvg7bPAe7qUl20Of
         DX1hQkwW6HdNPklh8q8gbosiNA7iBxO8TrZ2exoHYs9mFe0V3VLq3js18Hqqd+Bs6iyh
         5Rv5W3z/NflL/i9r0nkoTBFA5fOHA8xo3JmeynTdVIF+4S+xxIbzBOI+yyhGkNhutn4p
         yrxg==
X-Gm-Message-State: ACrzQf2fKWFnZx04g8i1/fI6LVQWph7uwlqdcHrrIQoZdhKX3taKCtiW
        Ji8/nkQwoHH2b8XEnWMNZ8c=
X-Google-Smtp-Source: AMsMyM4gKJpuD0QQTvrs1NIr7py9UPRLcUMEZTkGNLj5y1BXHCzxdHlVoStAQ87RXqzr/YQ6bnZWuw==
X-Received: by 2002:a63:5643:0:b0:44d:b691:1da1 with SMTP id g3-20020a635643000000b0044db6911da1mr29665429pgm.450.1666630841929;
        Mon, 24 Oct 2022 10:00:41 -0700 (PDT)
Received: from fedora (136-24-99-118.cab.webpass.net. [136.24.99.118])
        by smtp.gmail.com with ESMTPSA id i4-20020a1709026ac400b00186a68ec086sm1936026plt.193.2022.10.24.10.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 10:00:41 -0700 (PDT)
Date:   Mon, 24 Oct 2022 10:00:38 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH 6/8] mm/percpu.c: remove the lcm code since block size is
 fixed at page size
Message-ID: <Y1bEtuGKvJffAAIU@fedora>
References: <20221024081435.204970-1-bhe@redhat.com>
 <20221024081435.204970-7-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024081435.204970-7-bhe@redhat.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 04:14:33PM +0800, Baoquan He wrote:
> Since commit b239f7daf553 ("percpu: set PCPU_BITMAP_BLOCK_SIZE to
> PAGE_SIZE"), the PCPU_BITMAP_BLOCK_SIZE has been set to page size
> fixedly. So the lcm code in pcpu_alloc_first_chunk() doesn't make
> sense any more, clean it up.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/percpu.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 954abf916c7d..96191f7b61ba 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -72,7 +72,6 @@
>  #include <linux/cpumask.h>
>  #include <linux/memblock.h>
>  #include <linux/err.h>
> -#include <linux/lcm.h>
>  #include <linux/list.h>
>  #include <linux/log2.h>
>  #include <linux/mm.h>
> @@ -1347,7 +1346,7 @@ static struct pcpu_chunk * __init pcpu_alloc_first_chunk(unsigned long tmp_addr,
>  							 int map_size)
>  {
>  	struct pcpu_chunk *chunk;
> -	unsigned long aligned_addr, lcm_align;
> +	unsigned long aligned_addr;
>  	int start_offset, offset_bits, region_size, region_bits;
>  	size_t alloc_size;
>  
> @@ -1355,14 +1354,7 @@ static struct pcpu_chunk * __init pcpu_alloc_first_chunk(unsigned long tmp_addr,
>  	aligned_addr = tmp_addr & PAGE_MASK;
>  
>  	start_offset = tmp_addr - aligned_addr;
> -
> -	/*
> -	 * Align the end of the region with the LCM of PAGE_SIZE and
> -	 * PCPU_BITMAP_BLOCK_SIZE.  One of these constants is a multiple of
> -	 * the other.
> -	 */
> -	lcm_align = lcm(PAGE_SIZE, PCPU_BITMAP_BLOCK_SIZE);
> -	region_size = ALIGN(start_offset + map_size, lcm_align);
> +	region_size = ALIGN(start_offset + map_size, PAGE_SIZE);
>  
>  	/* allocate chunk */
>  	alloc_size = struct_size(chunk, populated,
> -- 
> 2.34.1
> 
> 

Acked-by: Dennis Zhou <dennis@kernel.org>

Thanks,
Dennis
