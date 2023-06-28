Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A385A740AD2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbjF1IKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbjF1IGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:06:15 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F04D2D71
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:05:10 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-57040e313c5so11132147b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687939509; x=1690531509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phnago+xzA34WP8EE3UKK7H8eHuABENEW5hNL2bsXgo=;
        b=lgduq78LkAMrzvr83a67QU1KFpuAZGleik/n7g9zzeAOia+JOhVCbZ3JFVCBZ3Uedz
         nAmo053uHZqLxN4n4FnGOlpQ8csi4Y/o6mbFv/u2kHE04hUtRDGyjJ1fYByDBjFQaL7C
         /tFktJK/HHTpYDI/JFn1YvGwEPtcOMUzD2GvwuVY7JL5zTQHvbNaU6/RGXmvGDB3nSA/
         jBrnTAAsNguo1qy+2tC2uXZYx1BJuvtUsD76izhz/P98zb8hsZTNapBns2a2p7WpDm6z
         Py1Oxeph2jk31Xf0M5xi9Sl4sfAFfE6nhnom76bOWpzjB9LraIsnLlilyzb9a8S04HQA
         1tEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687939509; x=1690531509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phnago+xzA34WP8EE3UKK7H8eHuABENEW5hNL2bsXgo=;
        b=bghhzjQGAhZT9aAtwJKyghJZ0uFrYslkHWWLg1roDumsMwjW+zuPS6APA7BBP7HLLU
         xxKqWmZXHAJ0vfR6rVp6eDdeYWHcCihk6exDLdCDOMjYp4kMUUrVvJ6Nn6OYQSit8qGg
         WbpkB49sLVrFVBHq8OQwMMunLj5q7RYNJKxr64svmxvQ33h8rDa/cpmkAtMVNdqXxjL1
         h4S5pUm0XAjJf+jZuvxynqtmjgVaKfKwWHsoR28xTK+EE7XygQSo5GEcIbPECNtA/QJ+
         7LKNqgu94h/v+SJlPDwN7NjiGKM2eK4DwfS/YaB1OKwjNyPVMPjJoZv4Gx0ZxnjZdiJ6
         AJnw==
X-Gm-Message-State: ABy/qLaMVDkb4wcsfYvjSrNwbGylfdjRkAj8/P0zTyqZ0rogdnD5n+Zl
        S2TK7/EL6S/hsWIcXVYauIT8d3n9CjU=
X-Google-Smtp-Source: ACHHUZ6d3pfVKObgk4siK5Lfysl0LC//sE6BdgoH94VJaOHujpnL0KaZh3s8HVVzfMUVJL14DMjXOg==
X-Received: by 2002:a05:6a20:7d9a:b0:12b:d525:2cac with SMTP id v26-20020a056a207d9a00b0012bd5252cacmr705356pzj.17.1687933786661;
        Tue, 27 Jun 2023 23:29:46 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id z19-20020aa785d3000000b00666e649ca46sm748799pfn.101.2023.06.27.23.29.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Jun 2023 23:29:46 -0700 (PDT)
Date:   Wed, 28 Jun 2023 14:38:30 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        huyue2@coolpad.com
Subject: Re: [PATCH 2/2] erofs: simplify z_erofs_transform_plain()
Message-ID: <20230628143830.0000186f.zbestahu@gmail.com>
In-Reply-To: <20230627161240.331-2-hsiangkao@linux.alibaba.com>
References: <20230627161240.331-1-hsiangkao@linux.alibaba.com>
        <20230627161240.331-2-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2023 00:12:40 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Use memcpy_to_page() instead of open-coding them.
> 
> In addition, add a missing flush_dcache_page() even though almost all
> modern architectures clear `PG_dcache_clean` flag for new file cache
> pages so that it doesn't change anything in practice.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
> preliminary tested with silesia dataset.
> 
>  fs/erofs/decompressor.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index ad53cf52d899..cfad1eac7fd9 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -328,7 +328,7 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
>  	const unsigned int lefthalf = rq->outputsize - righthalf;
>  	const unsigned int interlaced_offset =
>  		rq->alg == Z_EROFS_COMPRESSION_SHIFTED ? 0 : rq->pageofs_out;
> -	unsigned char *src, *dst;
> +	u8 *src;
>  
>  	if (outpages > 2 && rq->alg == Z_EROFS_COMPRESSION_SHIFTED) {
>  		DBG_BUGON(1);
> @@ -341,22 +341,19 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
>  	}
>  
>  	src = kmap_local_page(rq->in[inpages - 1]) + rq->pageofs_in;
> -	if (rq->out[0]) {
> -		dst = kmap_local_page(rq->out[0]);
> -		memcpy(dst + rq->pageofs_out, src + interlaced_offset,
> -		       righthalf);
> -		kunmap_local(dst);
> -	}
> +	if (rq->out[0])
> +		memcpy_to_page(rq->out[0], rq->pageofs_out,
> +			       src + interlaced_offset, righthalf);
>  
>  	if (outpages > inpages) {
>  		DBG_BUGON(!rq->out[outpages - 1]);
>  		if (rq->out[outpages - 1] != rq->in[inpages - 1]) {
> -			dst = kmap_local_page(rq->out[outpages - 1]);
> -			memcpy(dst, interlaced_offset ? src :
> -					(src + righthalf), lefthalf);
> -			kunmap_local(dst);
> +			memcpy_to_page(rq->out[outpages - 1], 0, src +
> +					(interlaced_offset ? 0 : righthalf),
> +				       lefthalf);
>  		} else if (!interlaced_offset) {
>  			memmove(src, src + righthalf, lefthalf);
> +			flush_dcache_page(rq->in[inpages - 1]);
>  		}
>  	}
>  	kunmap_local(src);

