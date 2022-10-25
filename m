Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52ED360C174
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiJYBxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiJYBxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:53:46 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34B1BF54
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 18:53:45 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id e4so6619964pfl.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 18:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SxEDdrI3hG+3w7IQNJoTP680/J7pecyDNQ+fXuXkvxc=;
        b=lvthVIgC1NtFIR4sPKrIoZwiG9zP5R6DWNjRaGZ7js6qWVwfYYYLxW5Vha+2T/Tu40
         srgZ1HmT934KOevMHcaVYnL45zY870tJhTlsKSoiPTvdk9RA3ObqBiD3zbev7oAnkPFc
         U5tjB7IzZBU3Pu98pZJX+7vrpVW2LrMihQDT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxEDdrI3hG+3w7IQNJoTP680/J7pecyDNQ+fXuXkvxc=;
        b=EGMCIA7h3BA/3hSgDfv360VYxdP1zNwc+JmR0fyoHQTHETPcndj7YR2dzjngKRS7bm
         GHg2AY6HBzCnLgTSCsK0M4vCMrT/0RVGovSP9hqI2AhPY3ZLRyIlPyZktmH2UNL0VE+/
         hvOwLUlaT+OptOtFyx21n4lBHHCHxmuLiYrUvOdodFKwZwtn+TUmRweca9/XUzuxqMpm
         waf/+KxkLwnXMpKcyBByWKnSpWlLKwHsT5hsIXE7ia/SFSdNtq0XNhU9hjUmXIEGpvmK
         4cEJ4Muc9lAjWWt+Iu2qoT2fN805ay4Y9/FYSI5yX5BeLF7ux0NeU1DRMk75Q0GyYZ30
         Dkzw==
X-Gm-Message-State: ACrzQf2ljXpiHN5UOSDySZhB68Ad9E+f56HZGTpEUxE6oV/qDgGVrtzY
        WLOQXgnaeJd+1pTz3AzoiQvJs9TlzCK2bw==
X-Google-Smtp-Source: AMsMyM6Vv3O1q9mWvI+nbcBXaj0JCZ/oPUmPNvPTwSWJ2ZRat2qEgAB1QrCGVz9afYd9QX9Fe2yakQ==
X-Received: by 2002:a63:a509:0:b0:46e:e85f:fb8 with SMTP id n9-20020a63a509000000b0046ee85f0fb8mr11346959pgf.519.1666662825385;
        Mon, 24 Oct 2022 18:53:45 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:c493:65a6:2d64:1325])
        by smtp.gmail.com with ESMTPSA id z11-20020a17090a8b8b00b0020aaa678098sm453963pjn.49.2022.10.24.18.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 18:53:44 -0700 (PDT)
Date:   Tue, 25 Oct 2022 10:53:40 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Alexey Romanov <avromanov@sberdevices.ru>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, ngupta@vflare.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@sberdevices.ru
Subject: Re: [PATCH v1] zram: add size class equals check into recompression
Message-ID: <Y1dBpLDf+mRH6cLf@google.com>
References: <20221024120942.13885-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024120942.13885-1-avromanov@sberdevices.ru>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/10/24 15:09), Alexey Romanov wrote:
> It makes no sense for us to recompress the object if it will
> be in the same size class. We anyway don't get any memory gain.
> But, at the same time, we get a CPU time overhead when inserting
> this object into zspage and decompressing it afterwards.

Sounds reasonable.

In my synthetic recompression test I saw only 5 objects that landed
in the same class after recompression; but this, as always, depends
on data patterns and compression algorithms being used.

[..]
> +	class_size_prev = zs_get_class_size(zram->mem_pool, comp_len_prev);
> +	class_size_next = zs_get_class_size(zram->mem_pool, comp_len_next);
>  	/*
>  	 * Either a compression error or we failed to compressed the object
>  	 * in a way that will save us memory. Mark the object so that we
> @@ -1663,6 +1667,7 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
>  	 */
>  	if (comp_len_next >= huge_class_size ||
>  	    comp_len_next >= comp_len_prev ||
> +	    class_size_next == class_size_prev ||

Let's use >= here, what Andrew has suggested.

>  	    ret) {
>  		zram_set_flag(zram, index, ZRAM_RECOMP_SKIP);
>  		zram_clear_flag(zram, index, ZRAM_IDLE);
> diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
> index 2a430e713ce5..75dcbafd5f36 100644
> --- a/include/linux/zsmalloc.h
> +++ b/include/linux/zsmalloc.h
> @@ -56,4 +56,6 @@ unsigned long zs_get_total_pages(struct zs_pool *pool);
>  unsigned long zs_compact(struct zs_pool *pool);

[..]

> +/**
> + * zs_get_class_size() - Returns the size (in bytes) of the
> + * zsmalloc &size_class into which the object with specified
> + * size will be inserted or already inserted.
> + *
> + * @pool: zsmalloc pool to use
> + *
> + * Context: Any context.
> + *
> + * Return: the size (in bytes) of the zsmalloc &size_class into which
> + * the object with specified size will be inserted.
> + */

Can't think of a btter way of doing it. On one hand we probably don't want
to expose the object size to class size mapping outside of zsmalloc, but on
the other hand we sort of already do so: zs_huge_class_size().

> +unsigned int zs_get_class_size(struct zs_pool *pool, unsigned int size)
> +{
> +	struct size_class *class = pool->size_class[get_size_class_index(size)];
> +
> +	return class->size;
> +}
> +EXPORT_SYMBOL_GPL(zs_get_class_size);

I'll kindly ask for v2. This conflicts with configurable zspage order
patch set which I posted last night. get_size_class_index() now takes
the pool parameter.
