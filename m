Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245FE709719
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 14:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjESMJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 08:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjESMJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 08:09:43 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE73192
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 05:09:39 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4eed764a10cso3679500e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 05:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684498178; x=1687090178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b7UdFp5GhAiSV0XORaYQNKiXNz/+Czt3HESIc1RiAg8=;
        b=SsTsyfOr21l+ewnUtIgEk7T27S/itlGotkVd0LvcJPueUZVCtnepavisOdEOzdjeXz
         hAg9fj7Vh0xUzAHeuuCRN8Lx1r0Fx6o1RbCZx5xblVRJTRMx4/zR2EJjUbOB+PRSXnXt
         uJLJssYxU3MxSSj+NjzRyk9tK3qomv+1GH45+LpYOImEIlmMcvL/RT0PJSzK3LQCvsY9
         iS3oXXMFXZCpVEZjpWnqy4zoJZzx1DR2qK3cr0gNTjN/qfD1XF2NpZ3OHiK0EWfarwcu
         wZNS0OXn0qAW8bafFMKhre7LZQxW92UIBUubNy7MRrDHP7CDhS+pgLthZ2w6ZCKVwmh5
         LCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684498178; x=1687090178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7UdFp5GhAiSV0XORaYQNKiXNz/+Czt3HESIc1RiAg8=;
        b=OQsnSgakfE75NVvrdjXgJrX8OA1AikJtugqeq6EJCD9j8L4Fgy9Vvny+eOmLakY2sA
         frRvdw/HSGGnwxyLEkmZXZqgJkZ2leGzhIHld4IIMeWj4jMCAWkfiMSVKp6ccBmzPyQO
         r1psRpz8hSOcjhjDQQpUiEcy6DImSJ4F+qrV9jE++cgs6rx3gqGDRf7djjSaY7LSi1vZ
         gSdQstwvlTp+I75FrmPQ7SYZPI1ZN2Yo+ikvJ14TRCxo2iWNA40PNK5R6poUZhJOZj81
         XnDZ32QuRykuBdvYPWumWiG6V/kQV0ne/6VKWWTKYze2RWVrR07HyY5bk9hAm7r//7nK
         8EdQ==
X-Gm-Message-State: AC+VfDwmox8NJSkKPLmp10dAXdheIM/LSGY5GIDLItw2iXMV5BEt4jI6
        oW4T5mR+IHykBbi3JoQ3wdo=
X-Google-Smtp-Source: ACHHUZ6chS+j6ik3EDwUZbqAeKYmkhlSk/4VlNyw4JPRLbolGOF1i2zWinXwEYOmyW0qHqk9zFDXSA==
X-Received: by 2002:ac2:5fe6:0:b0:4ed:c639:54cd with SMTP id s6-20020ac25fe6000000b004edc63954cdmr633908lfg.35.1684498177856;
        Fri, 19 May 2023 05:09:37 -0700 (PDT)
Received: from pc636 (host-90-235-19-70.mobileonline.telia.com. [90.235.19.70])
        by smtp.gmail.com with ESMTPSA id n7-20020ac242c7000000b004f24cb9ef14sm582963lfl.47.2023.05.19.05.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 05:09:37 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 19 May 2023 14:09:34 +0200
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        damon@lists.linux.dev, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 1/5] mm: vmalloc must set pte via arch code
Message-ID: <ZGdm/hz7HP5iJWny@pc636>
References: <20230518110727.2106156-1-ryan.roberts@arm.com>
 <20230518110727.2106156-2-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518110727.2106156-2-ryan.roberts@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 12:07:23PM +0100, Ryan Roberts wrote:
> It is bad practice to directly set pte entries within a pte table.
> Instead all modifications must go through arch-provided helpers such as
> set_pte_at() to give the arch code visibility and allow it to check
> (and potentially modify) the operation.
> 
> Fixes: 3e9a9e256b1e ("mm: add a vmap_pfn function")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Acked-by: Lorenzo Stoakes <lstoakes@gmail.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/vmalloc.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 9683573f1225..48202ec5f79a 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2899,10 +2899,16 @@ struct vmap_pfn_data {
>  static int vmap_pfn_apply(pte_t *pte, unsigned long addr, void *private)
>  {
>  	struct vmap_pfn_data *data = private;
> +	unsigned long pfn = data->pfns[data->idx];
> +	pte_t ptent;
>  
> -	if (WARN_ON_ONCE(pfn_valid(data->pfns[data->idx])))
> +	if (WARN_ON_ONCE(pfn_valid(pfn)))
>  		return -EINVAL;
> -	*pte = pte_mkspecial(pfn_pte(data->pfns[data->idx++], data->prot));
> +
> +	ptent = pte_mkspecial(pfn_pte(pfn, data->prot));
> +	set_pte_at(&init_mm, addr, pte, ptent);
> +
> +	data->idx++;
>  	return 0;
>  }
>  
> -- 
> 2.25.1
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki
