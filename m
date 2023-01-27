Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9A167E8E0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbjA0PDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbjA0PDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:03:31 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011217BE6E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:03:28 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id b10so4876295pjo.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n31FklM0OYREnHA1tP1e3LSdaHgDa9JeETQaAtpDNx0=;
        b=M6SSWaRKvHYyXnHeqRhKyDiua1oMz8Hd3PukoMuD6rBmopInZtl50XdRMj6ER5UXOv
         RLP15t2X51gbC98s/9gPou7TistUJOmaDVU6OqMgrl2l7qxgftafZmdGPY9Yz34GIPxP
         YK2CuOV46j3Vrbn9ayuLfteOAltptj+Xdk15vmSkmo902j9QETHVjAAF3k2EhL9N42kl
         qpUh3S4rTSAVhq3SbRFcf8jdAy9W+Cv9c8cITddHJQ9guoLJFU+82ncQiOYpnznCreHg
         4mfZmNYqI0wROQWoQy7otgEd9hr8NXVVRPBGip6GQMsadaSA5DfZrXOPILlXqAmCbiuV
         coPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n31FklM0OYREnHA1tP1e3LSdaHgDa9JeETQaAtpDNx0=;
        b=cTs80LtbdGR9wJIJfSiY/P606JaDBSwP4NQomBMBIZggg3vxfoSZOQrUucVeBZXVuT
         ypgoBrqJyf+gLGwZU/yr8t/uIMXU88QQB+Ul3ikk+q4Ftkj13zyOITvsLwujWRuq/sQ8
         KqxHtGQ5xOTpmbVZfOvDWZZwCKngSiixMLiBKWXgM6D0f5OxuiiTTOTApyO5NOrseP0Q
         uzmOFbbk0Z2nHocbvDH2ddsRLEznTnJEgc6GB9C9dRQkLER0jmLpM3M2tLAl8q1gcOdf
         PWi2MQIUuPxlgK8nT2TSLoFf6AFNG+wNIvav6cyYkpHQSbtiU3O6Z8fFpP27GuwGeBCA
         0wtw==
X-Gm-Message-State: AFqh2kogTQTM0n8uqr/hKDqdtts3yfyRZR65wSlIFqrrO3qOBNsjHthz
        OFUKUeZEYdn+qPx4WTL0u5U=
X-Google-Smtp-Source: AMrXdXu8fOFjL0+xdFqgqCe+WGF6zeplIVby1Vxp1yf0RzVYaCVenBITz8K3fDdfqv0cIcld35fvHw==
X-Received: by 2002:a17:903:124c:b0:194:d664:be3a with SMTP id u12-20020a170903124c00b00194d664be3amr36226903plh.16.1674831808380;
        Fri, 27 Jan 2023 07:03:28 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id t18-20020a1709028c9200b0017a032d7ae4sm2983879plo.104.2023.01.27.07.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 07:03:27 -0800 (PST)
Date:   Sat, 28 Jan 2023 00:03:19 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Hyunmin Lee <hn.min.lee@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] replace BUG_ON to WARN_ON
Message-ID: <Y9PntwfqtarxWFUq@hyeyoo>
References: <20230127115844.GA1124261@min-iamroot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127115844.GA1124261@min-iamroot>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Hyunmin.

the subject line could be "mm/vmalloc: replace BUG_ON() with WARN_ON()".

On Fri, Jan 27, 2023 at 08:58:44PM +0900, Hyunmin Lee wrote:
> Replace unnacessary BUG_ON to WARN_ON. These BUG_ONs verify aruguments of a function. Thus, the WARN_ONs return an EINVAL error when their condition is true.
> 
> Co-Developed-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Co-Developed-by: Jeungwoo Yoo <casionwoo@gmail.com>
> Co-Developed-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
> Signed-off-by: Hyunmin Lee <hn.min.lee@gmail.com>
> Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Signed-off-by: Jeungwoo Yoo <casionwoo@gmail.com>
> Signed-off-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>

could be rephrased a little, like:

"As per the coding standards, in the event of an abnormal condition that
should not occur under normal circumstances, the kernel should attempt
recovery and proceed with execution, rather than halting the machine.

Specifically, in the alloc_vmap_area() function, use WARN_ON()
and fail the request instead of using BUG_ON() to halt the machine."

> ---
>  mm/vmalloc.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 74afa2208558..9f9dba3132c5 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1587,9 +1587,14 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	int purged = 0;
>  	int ret;
>  
> -	BUG_ON(!size);
> -	BUG_ON(offset_in_page(size));
> -	BUG_ON(!is_power_of_2(align));
> +	if (WARN_ON(!size))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (WARN_ON(offset_in_page(size)))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (WARN_ON(!is_power_of_2(align)))
> +		return ERR_PTR(-EINVAL);
>  
>  	if (unlikely(!vmap_initialized))
>  		return ERR_PTR(-EBUSY);
> -- 
> 2.25.1

The code change itself looks fine to me.

Even if BUG*() -> WARN*() conversion may not be a high priority task,
I see no reason to reject such changes.

--
Thanks,
Hyeonggon
