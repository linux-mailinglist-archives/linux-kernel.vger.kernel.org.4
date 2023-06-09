Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C55729F67
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241918AbjFIP6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjFIP6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:58:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA632213C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686326242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+y+aveIxA7jLi8Qb8e+Oc4pjTAYvwXvNOc23v+nQ9Dc=;
        b=adbddcNmvblLb4OlXUAU3rwCf/K+Cfc42gqCngnHqaFREiLyhyEnRa4L9PHDwcyqkaHVNL
        7AaPbkfLdQ2fztXaihjZllWYf6pi8TVAhIxSdtrGvBkwcDO18vRirBCVx62sH6UB9x4XEB
        kVrY8aSd2VGqgBmARvXZx4ESLtbWQ0Q=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-7KZ-TphdNqyiVyDGimWCzA-1; Fri, 09 Jun 2023 11:57:21 -0400
X-MC-Unique: 7KZ-TphdNqyiVyDGimWCzA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4f621c76606so1409983e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 08:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686326240; x=1688918240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+y+aveIxA7jLi8Qb8e+Oc4pjTAYvwXvNOc23v+nQ9Dc=;
        b=Lgvi1eULGTphqS7Qh+zhER9BdYrqR5I9wXOTQqY77OMUrVkp7t2BbX16hIB07C1fib
         QcKc/FJ1VJw/kfDk3nX65+g5NUyWfmM7FSlC8UCTjhFEs8rSkj+fxeEEvuKqEyxCINR0
         Vu2E3BEnvHd5SKkn9ARcTidGhWyZBHiu8cvkyUKfz/KtjDqwpZDTwciBXdNFnyjlijTJ
         RGMrJxILmRHk0NzQ07UGANw0xg5kptFU2w97/Rc2qKYKCADlGE5wmPEIjb4BYyQLaVNP
         JnlKAOm0ggJfVWEaNGjvOgQI1CdGgXH514dLZIJg0MXG+aPfAM+DDXYqRHkQZzkn/E2V
         cR5A==
X-Gm-Message-State: AC+VfDyNYnQ+5vxhJJIHbW/p+gTm+U5q8zpNPeaprgzg2KNTKGJePdow
        nfG8tfx29BK+HobCVUgqf/gJgMmEMxhDn7NOadIK1qKEfvHSaP0IWnBMekPCctEi1ydaSr/AC24
        i7eLrEWrFqE0q9CLp88QdthTz
X-Received: by 2002:a19:f24f:0:b0:4f5:f736:cb9f with SMTP id d15-20020a19f24f000000b004f5f736cb9fmr989549lfk.67.1686326240278;
        Fri, 09 Jun 2023 08:57:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4/T5/nSOeffmIMMxsU83CU4sVcwwjp3dmRwDnOHHwbrP+YSlBuBwmQ6CY/6oW8GCAvWshWtA==
X-Received: by 2002:a19:f24f:0:b0:4f5:f736:cb9f with SMTP id d15-20020a19f24f000000b004f5f736cb9fmr989534lfk.67.1686326239964;
        Fri, 09 Jun 2023 08:57:19 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7403:2800:22a6:7656:500:4dab])
        by smtp.gmail.com with ESMTPSA id m7-20020a7bca47000000b003f80b96097esm415596wml.31.2023.06.09.08.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 08:57:19 -0700 (PDT)
Date:   Fri, 9 Jun 2023 11:57:16 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     arei.gonglei@huawei.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, amit@kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xianting Tian <tianxianting.txt@alibaba-inc.com>
Subject: Re: [PATCH 1/3] virtio-crypto: fixup potential cpu stall when free
 unused bufs
Message-ID: <20230609115617-mutt-send-email-mst@kernel.org>
References: <20230609131817.712867-1-xianting.tian@linux.alibaba.com>
 <20230609131817.712867-2-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609131817.712867-2-xianting.tian@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 09:18:15PM +0800, Xianting Tian wrote:
> From: Xianting Tian <tianxianting.txt@alibaba-inc.com>
> 
> Cpu stall issue may happen if device is configured with multi queues
> and large queue depth, so fix it.

What does "may happen" imply exactly?
was this observed?

> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> ---
>  drivers/crypto/virtio/virtio_crypto_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
> index 1198bd306365..94849fa3bd74 100644
> --- a/drivers/crypto/virtio/virtio_crypto_core.c
> +++ b/drivers/crypto/virtio/virtio_crypto_core.c
> @@ -480,6 +480,7 @@ static void virtcrypto_free_unused_reqs(struct virtio_crypto *vcrypto)
>  			kfree(vc_req->req_data);
>  			kfree(vc_req->sgs);
>  		}
> +		cond_resched();
>  	}
>  }
>  
> -- 
> 2.17.1

