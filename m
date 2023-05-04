Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610FB6F6462
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 07:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjEDF33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 01:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjEDF32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 01:29:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B4F1BEB
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 22:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683178118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rknz9rWFTYmTSoqDehsopyM4J34RAfhCmfEUYFTI4vk=;
        b=Wn/pnQbMFk/Jz6CJI0KR0xZRG3gOaTvWlKZ2M86eHzPKCjwoSq9Hz+o+rPJW8bkJI66TxL
        +lLmW2HOoMbHpW3AXWK9oy/9+YE1dxeyrc1bmofb50aH1zJzeWGDURTRuVMmSXB1YHTir1
        yNTS+IOAUqPTvGD1D8q4cDmqFzeb200=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-IJpQgbRGPRWdAyK1Z7Nx4w-1; Thu, 04 May 2023 01:28:36 -0400
X-MC-Unique: IJpQgbRGPRWdAyK1Z7Nx4w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f21e35dc08so39315e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 22:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683178115; x=1685770115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rknz9rWFTYmTSoqDehsopyM4J34RAfhCmfEUYFTI4vk=;
        b=jfBAofl4aVAziAZVEyaK0oP2mw/ZUsecuULdtUOlMsFDLFttIbhCdrqJRh4OAxOg03
         wSWBmVdiu0DBbMRMuB86DgYDZogHO2AvtWeEtk4+eQ/lFhNwDHIQc3ee0kzokPo5Wbf1
         THqg/nOqU2b8ePgisAgY9wz9FmzE9AM/eYXqzU3fsijxmh+Pf5ZbfeHRzVrLyh5T1rCx
         Q4SashmaocTIj6whPtpVm69ft0KXMqI5Ka2+DVlbyA0Zlk9bZlo/81Ernl20WzXfdU0P
         IpLWwJazH7OkXobz1X8kVo4V5S6XX2nlA1uuLVhwBwNSf94OU8fu+oDRmf8TcvipGYVC
         5RjQ==
X-Gm-Message-State: AC+VfDyVYq7c4YeA+5Up/5xToOLNzt4y/O1nNfdLzudGrcTpA+VJKH1H
        XNV/pHBqxkXG/gYIP9Xo3LIY4cETA6drS4zKfVkPuEEYthRe7RtfYVruGqfQeTXXbVV6A5ZM53x
        fkn6Ym3rpDkcKpmIvgP7E3BRa
X-Received: by 2002:a7b:ce8b:0:b0:3f1:6faa:d94c with SMTP id q11-20020a7bce8b000000b003f16faad94cmr16392043wmj.16.1683178115457;
        Wed, 03 May 2023 22:28:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6POiYPPqmIlSPfpvcMsDXK5aF0I0YO5IEpOhc6/XuSAbh//EpUFBgAgN7y/MN/MRyTPhiCQA==
X-Received: by 2002:a7b:ce8b:0:b0:3f1:6faa:d94c with SMTP id q11-20020a7bce8b000000b003f16faad94cmr16392033wmj.16.1683178115152;
        Wed, 03 May 2023 22:28:35 -0700 (PDT)
Received: from redhat.com ([31.187.78.120])
        by smtp.gmail.com with ESMTPSA id x16-20020a05600c21d000b003f318be9442sm3682466wmj.40.2023.05.03.22.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 22:28:34 -0700 (PDT)
Date:   Thu, 4 May 2023 01:28:30 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+726dc8c62c3536431ceb@syzkaller.appspotmail.com>,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, olivia@selenic.com,
        syzkaller-bugs@googlegroups.com, Jason Wang <jasowang@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [v2 PATCH] hwrng: virtio - Fix race on data_avail and actual data
Message-ID: <20230504012732-mutt-send-email-mst@kernel.org>
References: <00000000000050327205f9d993b2@google.com>
 <CACT4Y+awU85RHZjf3+_85AvJOHghoOhH3c9E-70p+a=FrRDYkg@mail.gmail.com>
 <ZFI9bHr1o2Cvdebp@gondor.apana.org.au>
 <20230503073220-mutt-send-email-mst@kernel.org>
 <ZFMtpC18ykLd/jf2@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFMtpC18ykLd/jf2@gondor.apana.org.au>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 11:59:32AM +0800, Herbert Xu wrote:
> On Wed, May 03, 2023 at 07:37:00AM -0400, Michael S. Tsirkin wrote:
> >
> > On the surface of it, it looks like you removed this store
> > which isn't described in the commit log.
> > I do not, offhand, remember why we stored 0 in data_idx here
> > when we also zero it in request_entropy.
> > It was added with
> 
> Yes I removed because it's redundant.  But you're right I'll add
> a note about it in the log:
> 
> ---8<---
> The virtio rng device kicks off a new entropy request whenever the
> data available reaches zero.  When a new request occurs at the end
> of a read operation, that is, when the result of that request is
> only needed by the next reader, then there is a race between the
> writing of the new data and the next reader.
> 
> This is because there is no synchronisation whatsoever between the
> writer and the reader.
> 
> Fix this by writing data_avail with smp_store_release and reading
> it with smp_load_acquire when we first enter read.  The subsequent
> reads are safe because they're either protected by the first load
> acquire, or by the completion mechanism.
> 
> Also remove the redundant zeroing of data_idx in random_recv_done
> (data_idx must already be zero at this point) and data_avail in
> request_entropy (ditto).
> 
> Reported-by: syzbot+726dc8c62c3536431ceb@syzkaller.appspotmail.com
> Fixes: f7f510ec1957 ("virtio: An entropy device, as suggested by hpa.")
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

feel free ro merge, thanks!

> 
> diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
> index f7690e0f92ed..e41a84e6b4b5 100644
> --- a/drivers/char/hw_random/virtio-rng.c
> +++ b/drivers/char/hw_random/virtio-rng.c
> @@ -4,6 +4,7 @@
>   *  Copyright (C) 2007, 2008 Rusty Russell IBM Corporation
>   */
>  
> +#include <asm/barrier.h>
>  #include <linux/err.h>
>  #include <linux/hw_random.h>
>  #include <linux/scatterlist.h>
> @@ -37,13 +38,13 @@ struct virtrng_info {
>  static void random_recv_done(struct virtqueue *vq)
>  {
>  	struct virtrng_info *vi = vq->vdev->priv;
> +	unsigned int len;
>  
>  	/* We can get spurious callbacks, e.g. shared IRQs + virtio_pci. */
> -	if (!virtqueue_get_buf(vi->vq, &vi->data_avail))
> +	if (!virtqueue_get_buf(vi->vq, &len))
>  		return;
>  
> -	vi->data_idx = 0;
> -
> +	smp_store_release(&vi->data_avail, len);
>  	complete(&vi->have_data);
>  }
>  
> @@ -52,7 +53,6 @@ static void request_entropy(struct virtrng_info *vi)
>  	struct scatterlist sg;
>  
>  	reinit_completion(&vi->have_data);
> -	vi->data_avail = 0;
>  	vi->data_idx = 0;
>  
>  	sg_init_one(&sg, vi->data, sizeof(vi->data));
> @@ -88,7 +88,7 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
>  	read = 0;
>  
>  	/* copy available data */
> -	if (vi->data_avail) {
> +	if (smp_load_acquire(&vi->data_avail)) {
>  		chunk = copy_data(vi, buf, size);
>  		size -= chunk;
>  		read += chunk;
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

