Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BBA65268A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 19:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbiLTSq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 13:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbiLTSqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 13:46:42 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06071A818
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 10:45:59 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id b3so20008421lfv.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 10:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P0pOPORY+qRKc7qIBI9apT/+V75LgK69tvfX3g/aAOk=;
        b=l5Xuhabwxl+ax7j7oOZm2urN5TX9XdKhTjFnMa1QYSWpmt0H5LTmJr4fl8jwFzlZJc
         w+5yg5cpBZ6lHLyXj8Xg+6AYnQmjwdFe9Tf5Zn4SUP2M2s8n7F52fi+bx70W4NIoFSbQ
         vwkW5MKGWI/v8zN3G1YIvN+2luCBaieNsFgonLXBWm7uACrJpoUsBIs0u/+1kEG1FBp5
         p+fd48olRi8wubGM5vHxj9pIq4o/j0UQNI6iM8FnIoNk8OSfckSzZELl9m6uKqCa+7Mx
         lrFjcarPZjCg2JzF3pjhstAgNyr5C49jMSVIp7of2DEUQ2UqL/eA2Yf4KYDfMPFOknCD
         I5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0pOPORY+qRKc7qIBI9apT/+V75LgK69tvfX3g/aAOk=;
        b=WF/q2fYfscnCketmBmS+6nxKDZrsZqMnlu5kcRnT0CvrsEWuX/PnnMFF6sFReRbdgW
         j0HOgis8jnSP+EnWKJoBUVfSBIzjjnq66dMYF5FO+IHQ6HZRDT5TEXTHAMtxb4Eze6D8
         0ikUb8W8ibp/vX4dWhc13q7p2nhe7a6lQfVPg59CtoNzxzJZLUNiCcQqP7kZd8QVar9G
         xgfVMTns+RQsG2IIN/Qu9nY8UY4Xq+5oepyk9+/buGLCJ9hV3QSUpKRHGxX66xtL35+M
         +GgZn++21gD+UQdLH95hpob0X7eLrvlgObmtAz/3f5v99msb3lVu6XFvzZtXPwmB8Bfs
         Nv7A==
X-Gm-Message-State: ANoB5pmMLdtq6PILLcjlvCQt7VPBO9XdNU1uEWYQrgXRUb68VFHsAF2S
        nUoM/x7Zy+ln2rT7716DJuU=
X-Google-Smtp-Source: AA0mqf7T5mTJQw4vTmOR34eNSjEsanhw41FpDkl95TDje2TE2qmbZf/bwHEbXSM0IiKfpq0TqYm78Q==
X-Received: by 2002:a05:6512:2256:b0:4b6:f1b4:b845 with SMTP id i22-20020a056512225600b004b6f1b4b845mr13515696lfu.65.1671561957921;
        Tue, 20 Dec 2022 10:45:57 -0800 (PST)
Received: from pc636 (host-90-233-218-120.mobileonline.telia.com. [90.233.218.120])
        by smtp.gmail.com with ESMTPSA id a12-20020a056512200c00b004b580a526c3sm1547828lfb.295.2022.12.20.10.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 10:45:57 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 20 Dec 2022 19:45:55 +0100
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/2] mm: vmalloc: Replace BUG_ON() by WARN_ON_ONCE()
Message-ID: <Y6IC49WT1Zz+wyWK@pc636>
References: <20221220182704.181657-1-urezki@gmail.com>
 <20221220182704.181657-2-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220182704.181657-2-urezki@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 07:27:04PM +0100, Uladzislau Rezki (Sony) wrote:
> Currently a vm_unmap_ram() functions triggers a BUG() if an area
> is not found. Replace it by the WARN_ON_ONCE() error message and
> keep machine alive instead of stopping it.
> 
> The worst case is a memory leaking.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 0fc38c36e0df..e05a0dc79ac5 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2255,10 +2255,12 @@ void vm_unmap_ram(const void *mem, unsigned int count)
>  	}
>  
>  	va = find_unlink_vmap_area(addr);
> -	BUG_ON(!va);
> -	debug_check_no_locks_freed((void *)va->va_start,
> -				    (va->va_end - va->va_start));
> -	free_unmap_vmap_area(va);
> +
> +	if (!WARN_ON_ONCE(!va)) {
> +		debug_check_no_locks_freed((void *)va->va_start,
> +			(va->va_end - va->va_start));
> +		free_unmap_vmap_area(va);
> +	}
>  }
>  EXPORT_SYMBOL(vm_unmap_ram);
>  
> -- 
> 2.30.2
> 
Will send a v2.

--
Uladzislau Rezki
