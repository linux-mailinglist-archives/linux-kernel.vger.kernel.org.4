Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BDD729F73
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242017AbjFIP7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjFIP73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:59:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB69213C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686326320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZASR5/BmaalzeTJJhd66JJTvqi7hh0GteSbPgdTii+8=;
        b=H48faB5t5tEhHX/yED3fLibHOPnmtTMksZS44bInjOghXcQHPw+hRvUfWnB92bT+WoAir7
        Kn5HfuA2Sp0LMSpL8SoVzKHJaQbdiR59W2Tnhiwv/YsSAj+fMKbFB91CgEN1KwpBvRIT+R
        is5dFY52di+eOd5d3anU/wyEnHtyIak=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-CMrDPxgrP_K4u_wnzHLmmQ-1; Fri, 09 Jun 2023 11:58:39 -0400
X-MC-Unique: CMrDPxgrP_K4u_wnzHLmmQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f7ecc15771so9397565e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 08:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686326318; x=1688918318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZASR5/BmaalzeTJJhd66JJTvqi7hh0GteSbPgdTii+8=;
        b=hbqAJTj5H15ELVHy9/JE3iPA9lnZVlpEyez5dHM3I07U9yhvnRqmojAEGqet0jv8Y3
         BjJ6EKB10oe4vPcniNBDgtSQYUPnljAJZAIUGEJOvs0G8H+5EkOYqqJsDA6svvyndH62
         gNVktf6TGmBKq+p0nVkzus1/kLkV8pXlCWMMnfk/+whNRgKG7OGx3IARINDxGss0xoWP
         lpsw8Jj66teXO4VGVhlXnjw8LKfvdZX2Xvi3952Nzc8E4TUCBLMofSjo2yGUt+TMA7DE
         08m5gXKjGbdbl2oRjJREBjhcYmS2OvTXJ1wSIUB8xic9HrkCgYwIOpoa0zmXuO9vi5b1
         0Qww==
X-Gm-Message-State: AC+VfDzo5g9F+9jnfiEKlhU+48JjJYhOaHYqOHmavO6lfpphHC72z0ew
        +9zuNyFdoS8E81AT5XSApe/T1UHk4D/VKzO+coo3WLSLhqCo1FdVpHeRKNUxLgKW3Wmh6l8yqYK
        /WfamOL6PIVQU5MfQgCI5dJew
X-Received: by 2002:a05:600c:3547:b0:3f7:f589:b5ca with SMTP id i7-20020a05600c354700b003f7f589b5camr4162004wmq.15.1686326318091;
        Fri, 09 Jun 2023 08:58:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6OksjCtzrynIHd9z5LBpzNB7HtKW+xrrc3WbUfllkzb+rfhixTGuyBW8eVv2rOaSpPAX44dg==
X-Received: by 2002:a05:600c:3547:b0:3f7:f589:b5ca with SMTP id i7-20020a05600c354700b003f7f589b5camr4161975wmq.15.1686326317767;
        Fri, 09 Jun 2023 08:58:37 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7403:2800:22a6:7656:500:4dab])
        by smtp.gmail.com with ESMTPSA id y19-20020a05600c365300b003f7f60203ffsm3065248wmq.25.2023.06.09.08.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 08:58:37 -0700 (PDT)
Date:   Fri, 9 Jun 2023 11:58:34 -0400
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
Message-ID: <20230609115818-mutt-send-email-mst@kernel.org>
References: <20230609131817.712867-1-xianting.tian@linux.alibaba.com>
 <20230609131817.712867-2-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609131817.712867-2-xianting.tian@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
> 
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>

include a Fixes tag?

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

