Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8505F5903
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 19:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJERS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 13:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiJERSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 13:18:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7606746857
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 10:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664990316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EQGZeMMosYwUdiU0OrsifprAdKF8zlo/1AkIo/J/cWU=;
        b=CQC02lrzZJLtnIDXu608v/TiWvqFKwNv+ehEioMnW1D062Tvn8/nJBtuZn/4kf8kjfmG8I
        Q7loWStUNmk7AGZ+4RnyMJvXTB6vtxSFk9ZmT1n7ZcvV6weGoH2oRmVqQ2vw9afDiwfLQR
        390VIELFQiwV2btbRQZVFH8cm3+azic=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-607-aqXj4L9DPCKfRxMHuB_WlA-1; Wed, 05 Oct 2022 13:18:35 -0400
X-MC-Unique: aqXj4L9DPCKfRxMHuB_WlA-1
Received: by mail-qt1-f198.google.com with SMTP id g6-20020ac84b66000000b0035cf832dec9so11560812qts.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 10:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=EQGZeMMosYwUdiU0OrsifprAdKF8zlo/1AkIo/J/cWU=;
        b=trr+MKhfTyIH6y9kiBpfP2VSjibVsyMJ1AjllJ+oj8h/0ofGDpf8t2CTm1UQYfOiCQ
         YM1iGvYatAL77dnrjbl31d+pW8eNIKVhPkrAD/Hz/j07cChzI6f+6asyxrLX3Gg1YC/V
         cP0Y6WXHgVyT4gFVHbaMpCnkg0kfogSEXH/BehfQ4Kqq0KQABQa7aYH50rBwTkVMpSJm
         UvvQ4FpfLSkHQHl9IHB03hGo1BJt9Z6Y8CxssTT9r5q9Es0a3JQP3vS4/O0bMiYEIGxS
         0ozUtUpsO2fIyPs5dSOZuBr/6ireJ/rwrFjnZhET0lsiZT8HaZM/SRZstjblBgtCkPxu
         w2fA==
X-Gm-Message-State: ACrzQf25yIrjdRdrEsOItnmYBlgjl+t2NJMkfXTzF1fi6Szej6aMfI66
        uO7Ffaz1IlYCes6xq2qQwGZajvGb0iPuBDrhGvVXu0tY4bOGIguAcdPSU+zaqwAdAhkLP9PM1OH
        XKQ+MNSZZ3cE9e/DSUOAfoXLX
X-Received: by 2002:a05:620a:2a02:b0:6ce:90fb:51b8 with SMTP id o2-20020a05620a2a0200b006ce90fb51b8mr486804qkp.460.1664990314781;
        Wed, 05 Oct 2022 10:18:34 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7aP3yRogasFXufFvt47NK7C57mBsP2uou9HRoFvjEEhQfi2tAKg2wbRInBFvXH0icM++ahPA==
X-Received: by 2002:a05:620a:2a02:b0:6ce:90fb:51b8 with SMTP id o2-20020a05620a2a0200b006ce90fb51b8mr486784qkp.460.1664990314537;
        Wed, 05 Oct 2022 10:18:34 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id x6-20020a37ae06000000b006b9c9b7db8bsm16665351qke.82.2022.10.05.10.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 10:18:34 -0700 (PDT)
Date:   Wed, 5 Oct 2022 13:18:32 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        johannes.thumshirn@wdc.com, bvanassche@acm.org,
        ming.lei@redhat.com, shinichiro.kawasaki@wdc.com,
        vincent.fu@samsung.com, yukuai3@huawei.com
Subject: Re: [PATCH 2/6] null_blk: allow write zeores on membacked
Message-ID: <Yz28aEOOUqrCUhe2@bfoster>
References: <20221005031701.79077-1-kch@nvidia.com>
 <20221005031701.79077-3-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005031701.79077-3-kch@nvidia.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 08:16:57PM -0700, Chaitanya Kulkarni wrote:
> Add a helper functions to enable the REQ_OP_WRITE_ZEROES operations
> when null_blk is configured with the membacked mode.
> 
> Since write-zeroes is a non-trivial I/O operation we need this to
> add a blktest so we can test the non-trivial I/O path from the
> application to the block layer.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/block/null_blk/main.c | 46 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index fc3e883f7b84..2d592b4eb815 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
...
> @@ -875,6 +877,24 @@ static void null_free_sector(struct nullb *nullb, sector_t sector,
>  	}
>  }
>  
> +static void null_zero_sector(struct nullb_device *d, sector_t sect,
> +			     sector_t nr_sects, bool cache)
> +{

Any reason to not just pass the tree root directly here instead of the
cache boolean? It might make the callers more readable and also
eliminates the need to pass the nullb_device.

Brian

> +	struct radix_tree_root *root = cache ? &d->cache : &d->data;
> +	struct nullb_page *t_page;
> +	unsigned int offset;
> +	void *dest;
> +
> +	t_page = radix_tree_lookup(root, sect >> PAGE_SECTORS_SHIFT);
> +	if (!t_page)
> +		return;
> +
> +	offset = (sect & SECTOR_MASK) << SECTOR_SHIFT;
> +	dest = kmap_atomic(t_page->page);
> +	memset(dest + offset, 0, SECTOR_SIZE * nr_sects);
> +	kunmap_atomic(dest);
> +}
> +
>  static struct nullb_page *null_radix_tree_insert(struct nullb *nullb, u64 idx,
>  	struct nullb_page *t_page, bool is_cache)
>  {
...

