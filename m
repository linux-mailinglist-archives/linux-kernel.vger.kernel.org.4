Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93A35FD93D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 14:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiJMMeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 08:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJMMef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 08:34:35 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA39DED1D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 05:34:34 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id h13so1812682pfr.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 05:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=APvObyH7Yxci3JC4nOwMrJjuBylthay0v3CgCOkmbX8=;
        b=B+ibmN/g+mZp20zCK5FLPpxB9fs1HPP+TPkGjqE2JglZgP79Rk8ZKknxxkYqaYv3n2
         mhnO3P4lIrXR1nPrzJ0TD5FjGIMMXmrbfzPsuHVrEi0DRVgA+IpqTsgJIQSVlEQPeoP2
         ao7mZQzNQZXUVAShA1RddUFD9znh89ueyXXGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APvObyH7Yxci3JC4nOwMrJjuBylthay0v3CgCOkmbX8=;
        b=RE8NkwAjtIQ4maKZZcD6HJuPtqawKDsn1m8OWqyxi6C+FtjHEK/tXCMVrhhZWqgtiD
         ET2+cILMdasrLblv3UXManLDfmN09uUEaLyLILxAdNS8JSjaanFcJ6WgUyM5GrtQF4zt
         SszQjIFMcYQxqGGlRvXpCc7SAj50EmyH7zqcdn/XtK5yQz0cpW1AYu6A4ysC5S5/yQh3
         wRYgHEYV/IR8z34Vuk0QXFytCqkZvRNGD8FGz7Nx9OL3dM98rv670p5N+gX/ogVR56yb
         ys9bcMFgwThisNB6IpGAf1A6A2v+T1B0fayFYpooBqftn9+JKtol+qB1aVp87K+Ocnk8
         9rhQ==
X-Gm-Message-State: ACrzQf2H5kXv5KiuvSuu67Do5zPZedzR8H7bY3ELjUc64efoNqWsRr7a
        xpambHBIxVH+na+Huj3ighEcRg==
X-Google-Smtp-Source: AMsMyM6zFl7HUELQyzdf5QZKzojt2du14cXdUpm68Yb20UupNgFgDxw29LoiBbzZN0gIA2+kbmatXA==
X-Received: by 2002:a63:1326:0:b0:439:40b5:77cc with SMTP id i38-20020a631326000000b0043940b577ccmr30621188pgl.473.1665664474025;
        Thu, 13 Oct 2022 05:34:34 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:633d:4747:63f5:81b6])
        by smtp.gmail.com with ESMTPSA id u3-20020a170902e5c300b0017f592a7eccsm12498152plf.298.2022.10.13.05.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 05:34:33 -0700 (PDT)
Date:   Thu, 13 Oct 2022 21:34:29 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Romanov <avromanov@sberdevices.ru>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, ngupta@vflare.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@sberdevices.ru
Subject: Re: [PATCH v1] zsmalloc: zs_destroy_pool: add size_class NULL check
Message-ID: <Y0gF1S4bjjNIE/68@google.com>
References: <20221013112825.61869-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013112825.61869-1-avromanov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/10/13 14:28), Alexey Romanov wrote:
> Inside the zs_destroy_pool() function, there can still
> be NULL size_class pointers: if when the next size_class is
> allocated, inside zs_create_pool() function, kzalloc will
> return NULL and handling the error condition, zs_create_pool()
> will call zs_destroy_pool().
> 
> Fixes: f24263a5a076 ("zsmalloc: remove unnecessary size_class NULL check")
> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
> ---
>  mm/zsmalloc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 525758713a55..d03941cace2c 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -2311,6 +2311,9 @@ void zs_destroy_pool(struct zs_pool *pool)
>  		int fg;
>  		struct size_class *class = pool->size_class[i];
>  
> +		if (!class)
> +			continue;
> +
>  		if (class->index != i)
>  			continue;

Yeah, OK... And totally my fault! I think, I, personally, am done
with the "remove if" patches at this point, they are too painful.

Alexey, is there anything else we missed?

FWIW,
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Andrew,
The allocation in question should be of a "too small to fail"
size, below PAGE_ALLOC_COSTLY_ORDER. So unless that unspoken
rule has changed, we should be "fine", since that kmalloc()
simply should not fail. It still makes sense to have that
particular check in place, just in case. Can you please pull
this patch in? And, like I said, I'm going to NAK all future
micro-optimizations.
