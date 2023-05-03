Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE7C6F5744
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 13:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjECLh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 07:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjECLh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 07:37:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6706C55B8
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 04:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683113828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bIi8bY8IRLAsexxUq+ST9kZ+eooAdtb0UXZ2yaSI33A=;
        b=CMbw6wYuH/H2Sh/TMQvgTe8XFuyBaVizDFMgNbodJKcmKb/QxLMxiPzLimnMjRdUhJbgJ1
        2Cy1lC1Ve/bvA97bx4NjlBud1tMpx1n9Pgy5+ysiCH9hRG3/hWfRsWWcS8MMzMgMVzjsO6
        bUFlj0Fo4Kk/QDZSpLdDYSkWtKUbB3k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-LnRXnl52ND2tHgh8c1C3Zw-1; Wed, 03 May 2023 07:37:07 -0400
X-MC-Unique: LnRXnl52ND2tHgh8c1C3Zw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-30479b764f9so1437891f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 04:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683113826; x=1685705826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIi8bY8IRLAsexxUq+ST9kZ+eooAdtb0UXZ2yaSI33A=;
        b=eEL5OdoeMuKrX4pGWnABUlnV+vDoljQNSjqwYas/pV2Hbne83ELOfb5PsXu3jD0m9i
         KQMOc9rd4t0YsTlYVNATCMp/7QLSw6Gb9JjjzQaChWoOMH6kzNrw0ZJkoI9K3d2iq9MY
         SCGV7OA/CyaMWlmlLxQdQc+OraFRdfeAZq4Z4lyKFSAYB53e1jT4gzKL3eRwRN3XItVv
         6hBGk1ZKGpOMuw5y8LO+Kj+LaPzKWdVwiD24PbhrMoe2gUwwM92GxD1O5DOyFLxcLvgH
         +CXjpIsWR5DMDJofpeB/ekG1Lr3ZbVap2/gSMa6/6u5ssbuX/E/Ft4YXdPpArY3eN0K0
         z4EA==
X-Gm-Message-State: AC+VfDz9VT1WodTEBLTSunNBq6E2zN/bxeW9YoCzm1jQD+a16CUvqlKV
        0VbS61ihE3xzYGPrjj5cGi4nEOApLrstQkTfgHa523BNg06HGqZ1u/RaNbDhaT6nY4Vsfap9PfA
        bLTe9a+CBNZaPB8bGEAjDYS5U
X-Received: by 2002:adf:e4cb:0:b0:306:2de2:f583 with SMTP id v11-20020adfe4cb000000b003062de2f583mr6541273wrm.53.1683113826164;
        Wed, 03 May 2023 04:37:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7PPuhtQnzDd49eLyL+LKBBbg7YVhP2WcRbMovIP3Uq0JyM1N6Oj/UsS/45wviUPGjNlfNQKA==
X-Received: by 2002:adf:e4cb:0:b0:306:2de2:f583 with SMTP id v11-20020adfe4cb000000b003062de2f583mr6541253wrm.53.1683113825857;
        Wed, 03 May 2023 04:37:05 -0700 (PDT)
Received: from redhat.com ([31.187.78.112])
        by smtp.gmail.com with ESMTPSA id o11-20020a1c750b000000b003f1712b1402sm1630540wmc.30.2023.05.03.04.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 04:37:05 -0700 (PDT)
Date:   Wed, 3 May 2023 07:37:00 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+726dc8c62c3536431ceb@syzkaller.appspotmail.com>,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, olivia@selenic.com,
        syzkaller-bugs@googlegroups.com, Jason Wang <jasowang@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] hwrng: virtio - Fix race on data_avail and actual data
Message-ID: <20230503073220-mutt-send-email-mst@kernel.org>
References: <00000000000050327205f9d993b2@google.com>
 <CACT4Y+awU85RHZjf3+_85AvJOHghoOhH3c9E-70p+a=FrRDYkg@mail.gmail.com>
 <ZFI9bHr1o2Cvdebp@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFI9bHr1o2Cvdebp@gondor.apana.org.au>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 06:54:36PM +0800, Herbert Xu wrote:
> On Fri, Apr 21, 2023 at 04:52:13PM +0200, Dmitry Vyukov wrote:
> >
> > Here this:
> > 
> > size = min_t(unsigned int, size, vi->data_avail);
> > memcpy(buf, vi->data + vi->data_idx, size);
> > vi->data_idx += size;
> > vi->data_avail -= size;
> > 
> > runs concurrently with:
> > 
> > if (!virtqueue_get_buf(vi->vq, &vi->data_avail))
> >     return;
> > vi->data_idx = 0;
> > 
> > I did not fully grasp how/where vi->data is populated, but it looks
> > like it can lead to use of uninit/stale random data, or even to out of
> > bounds access, say if vi->data_avail is already updated, but
> > vi->data_idx is not yet reset to 0. Then concurrent reading will read
> > not where it's supposed to read.
> 
> Yes this is a real race.  This bug appears to have been around
> forever.
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
> Reported-by: syzbot+726dc8c62c3536431ceb@syzkaller.appspotmail.com
> Fixes: f7f510ec1957 ("virtio: An entropy device, as suggested by hpa.")
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
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

On the surface of it, it looks like you removed this store
which isn't described in the commit log.
I do not, offhand, remember why we stored 0 in data_idx here
when we also zero it in request_entropy.
It was added with


commit 5c8e933050044d6dd2a000f9a5756ae73cbe7c44
Author: Laurent Vivier <lvivier@redhat.com>
Date:   Thu Oct 28 12:11:10 2021 +0200

    hwrng: virtio - don't waste entropy
    
    if we don't use all the entropy available in the buffer, keep it
    and use it later.
    
    Signed-off-by: Laurent Vivier <lvivier@redhat.com>
    Link: https://lore.kernel.org/r/20211028101111.128049-4-lvivier@redhat.com
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>



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

