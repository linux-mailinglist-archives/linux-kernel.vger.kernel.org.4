Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B74729FA0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241205AbjFIQGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjFIQGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:06:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBB630D6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 09:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686326764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+M7az6Jbp6Oqou6iuD63oUNoAb5aXxDturRi9Hwe0gE=;
        b=dpPcOUdr2vjeymZGEeYaRwHYQJyZ4sb6aAnOT5udyhYlGYWtiPwItGyCsDSNRjIDlGYXpH
        p12cen3t0qkpW0tAkXFZXXfz1zSJuDVJzJfazrUV8TxZNLPTVeqGUg2NkL7bpd31UIvNyk
        u5IUX2WeXaIYzv0xTAa3YDRPsC6Elvg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-4495n50dP4ePM7qZRw4kng-1; Fri, 09 Jun 2023 12:05:55 -0400
X-MC-Unique: 4495n50dP4ePM7qZRw4kng-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30b218c0bbbso749304f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 09:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686326754; x=1688918754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+M7az6Jbp6Oqou6iuD63oUNoAb5aXxDturRi9Hwe0gE=;
        b=RkL88BjDJnq2A83m6K0zqoNauuJkHjWQ/49roCPjl1CcU/EZestXAOF9kAs198FVDi
         VVchh9dnu96vlSfJ0i7vlhhvMfs6Yb3sYtRcY6T6ydXRXj/oKsZXHJX32Zo6RZw5lpS4
         wmF7HxkSo6Ck78TqghcLePFNW9DdAVKdu0olEhverU0g6SPQ7ht1JqGbwXkYjrqQsfaL
         bK+uAYhTELTAW3ZwdsmjMoSCOOEXv4t0qKbk66sKp9yTVicmlCYgcVh2yo8QUfPY1o0t
         RntqAolE5OUVqHfnP5+IPQKHA7QXsNsDIvoGc40+sBXzmoaAQEWIcgg/FyngudNXFGTd
         0kvA==
X-Gm-Message-State: AC+VfDwCpSTXhXFLLOuIRb6q/54Z7E2QCyZzMsM9o0vvz+QZPZaFjG4P
        0IsZFJDEvmVb1tftijc1sY8W4mIKER1PbXy3RREmTitsPS7eItebeS80fiSKntI1UUIAUPntcAq
        0zUY0bPnIKmegKsHkvBX1cqd5
X-Received: by 2002:a5d:4e88:0:b0:309:41d8:eec4 with SMTP id e8-20020a5d4e88000000b0030941d8eec4mr1062150wru.39.1686326754291;
        Fri, 09 Jun 2023 09:05:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ70iwfwN+298k3OOZDF7xlgm6Z2CMUhRp6FaLoDmzGdsg4L4C82nksLMOKVyP8jx0VshOn9wQ==
X-Received: by 2002:a5d:4e88:0:b0:309:41d8:eec4 with SMTP id e8-20020a5d4e88000000b0030941d8eec4mr1062133wru.39.1686326753971;
        Fri, 09 Jun 2023 09:05:53 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7403:2800:22a6:7656:500:4dab])
        by smtp.gmail.com with ESMTPSA id p13-20020a5d4e0d000000b002fb60c7995esm4841314wrt.8.2023.06.09.09.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 09:05:53 -0700 (PDT)
Date:   Fri, 9 Jun 2023 12:05:50 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     arei.gonglei@huawei.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, amit@kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] virtio_console: fixup potential cpu stall when free
 unused bufs
Message-ID: <20230609120332-mutt-send-email-mst@kernel.org>
References: <20230609131817.712867-1-xianting.tian@linux.alibaba.com>
 <20230609131817.712867-3-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609131817.712867-3-xianting.tian@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 09:18:16PM +0800, Xianting Tian wrote:
> Cpu stall issue may happen if device is configured with multi queues
> and large queue depth, so fix it.

"may happen" is ambigous.

So is this: "for virtio-net we were getting
stall on CPU was observed message, this driver is similar
so theoretically the same logic applies"

or is this

"the following error occured: ..... "

?


> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> ---
>  drivers/char/virtio_console.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index b65c809a4e97..5ec4cf4ea919 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1935,6 +1935,7 @@ static void remove_vqs(struct ports_device *portdev)
>  		flush_bufs(vq, true);
>  		while ((buf = virtqueue_detach_unused_buf(vq)))
>  			free_buf(buf, true);
> +		cond_resched();
>  	}
>  	portdev->vdev->config->del_vqs(portdev->vdev);
>  	kfree(portdev->in_vqs);
> -- 
> 2.17.1

