Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD386B6E46
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 05:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCMEEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 00:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCMEEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 00:04:37 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633973402C
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 21:04:36 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id ix20so5016454plb.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 21:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678680276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8qbl7x2pB/09MjxekB80x9wWAT0xwVvCbkaBOhOVemI=;
        b=XStVyyO/wt//1PUG/CeLDL4HWiWpfAOoMzu7SDg3MKWfuIhLs5AUL+NeppH2fdcdHL
         xy8+LUMaqZjJvWib9JiG/0w3ys2TsK3+pnXoc9b/DSYVYVQUAWXz+lTnozUY/FK9dRvW
         xp9VSkoAdOte6zCCk6nfiDF5Kd3E12VyuNiGlf7wGSb40xNAidOdRtquLvE3DdW+U2l5
         GqNu54AjwGAyMad64Y3xiBRPfzBBv7GtDuRD0AXgQnOflvWhCmJt1p338oR6nSo0zJys
         T3NsPmm1FhDJmkKHPMO4/FwaWDhVNGkVU4harEg/20l08WU+Xm81oBCKCYM3r3Y06I2e
         T09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678680276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qbl7x2pB/09MjxekB80x9wWAT0xwVvCbkaBOhOVemI=;
        b=XYYjoOO/ITwpRm1KyF0Lw+eytGbuSxCTF8yGS79OV70ISjPG4tYypENfjkzXmXWB2s
         dHl4EnqhHZeHNfMZqz6w0/2NWns1xDb8sWuIsSyIklI99HjJAK/XjmnPXmB9d6cQzQI9
         Qo24w/lFr+m7h6oMKQTOwCwd/pAhKJwRI9wiZIkogssU4OoNC3oQwWEzFB47/mb8wJZt
         H1oClPtK04dt/qrRnwavmo8lgkuf5XZNzJ5gLOiQDo6xdWEfdbHkY2xl54PmW46rItgF
         5D685wljBuLUlCw9rv4qvwtMDFm+mcEBwR9YMhenB4J2LDFiZDOOeM8ECHOcqgZKLQ1m
         X9BQ==
X-Gm-Message-State: AO0yUKUUzQ7vRmJYZ6fWy1MdWeKtn7V9rSqRkjujVTteE6IsJKb4zy1Z
        tgOI79OYXsH7TBFWf7TRIdw=
X-Google-Smtp-Source: AK7set+7owPg6x0qyqB//s8JmhavhyEZRQGdqXnQF4iPlYJ5j1nIrmcHHFuA1wjElHXxodvi8DfzBw==
X-Received: by 2002:a05:6a20:3542:b0:d3:bb4a:a830 with SMTP id f2-20020a056a20354200b000d3bb4aa830mr4539252pze.56.1678680275661;
        Sun, 12 Mar 2023 21:04:35 -0700 (PDT)
Received: from localhost ([2400:8902::f03c:93ff:fe27:642a])
        by smtp.gmail.com with ESMTPSA id n13-20020a635c4d000000b00477bfac06b7sm3537950pgm.34.2023.03.12.21.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 21:04:34 -0700 (PDT)
Date:   Mon, 13 Mar 2023 04:04:29 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Thorsten Scherer <t.scherer@eckelmann.de>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yury Norov <yury.norov@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab: Adjust comment after refactoring of gfp.h
Message-ID: <ZA6gzTvu6M/JQof4@localhost>
References: <20230312122315.3562-1-t.scherer@eckelmann.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230312122315.3562-1-t.scherer@eckelmann.de>
X-Spam-Status: No, score=3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2023 at 01:23:15PM +0100, Thorsten Scherer wrote:
> Reflect the change from the commit below.
> 
> Fixes: cb5a065b4ea9 ("headers/deps: mm: Split <linux/gfp_types.h> out of <linux/gfp.h>")
> Signed-off-by: Thorsten Scherer <t.scherer@eckelmann.de>
> ---
>  include/linux/slab.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 45af70315a94..87d687c43d8c 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -526,7 +526,7 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node) __assume_page_align
>   * to be at least to the size.
>   *
>   * The @flags argument may be one of the GFP flags defined at
> - * include/linux/gfp.h and described at
> + * include/linux/gfp_types.h and described at
>   * :ref:`Documentation/core-api/mm-api.rst <mm-api-gfp-flags>`

Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

>   *
>   * The recommended usage of the @flags is described at
> -- 
> 2.38.0
> 
