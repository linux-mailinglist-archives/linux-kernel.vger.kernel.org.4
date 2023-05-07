Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3CA6F971D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 08:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjEGGAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 02:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEGGAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 02:00:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C783D11D86
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 22:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683439183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f3vnav72jiBSDlUv6QQjHr2dDSLqhQhKBN44HYd9MYY=;
        b=V6yiGzwKQRHbxyDoAKV4RMaRREhkIoAMSc+Fq7m/x/THyHx+wPVO1xSIeUaxynPRvaj9t/
        CJX6JBrqckFAofviaid+Ptmumsve3XbiKWfeSCGT7fSYEhPP19yDy3mXy5OCZ+HkD9h0z2
        fRpbdWxye5uetHHqOcH+WX/c0JeC93I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-ms1R44aONqGtFIkwVGzzRA-1; Sun, 07 May 2023 01:59:42 -0400
X-MC-Unique: ms1R44aONqGtFIkwVGzzRA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f321e60feaso12380615e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 22:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683439181; x=1686031181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3vnav72jiBSDlUv6QQjHr2dDSLqhQhKBN44HYd9MYY=;
        b=YbkH7NNRezg9QGp4kr7wkuJLd98ItCqN3VvOBnqPxqcSIjwkiZtDhGcu27nvtYhVi6
         OmndoOw6SwB02gYdbXkwD/Z/4IhPS4arMt+jaykmSwUacSvy8X9iFeA3saqWhPBdvqcp
         dJ4YwS5e/M5Q2RZ+703OevHOnM/X28G4UsRZBSWVLvDCViKlokUBlgxDMyX5YAy6rnUv
         T9Rijc7A9R/OaBYBupIWkdeLx11XPbCP0SeOg/XDmbTTUC0Fj4lyb8gJRD/xCuD97mlw
         3UiDv0xBRki6UgWMF4yIuctsQ2zAXG5D5aiW9rYykJLcQrt5pjRNuZRkPq5dA1k35D/c
         43vw==
X-Gm-Message-State: AC+VfDyJ11nPl5Slnqxzr/0WmiW4mrH09SHz2n2PMrbPL0YjEDqS3AHn
        FpTp/5a3rXpKD1ESZ4E4ne0SKcB/jjOL5c8cPVjoz660tnSolj/OiQeptJC//NiWNXcKFv88+oR
        3Xiy1uV5PWx7OJztEsRmWMlxA
X-Received: by 2002:a7b:c3cf:0:b0:3f4:21cf:b4a4 with SMTP id t15-20020a7bc3cf000000b003f421cfb4a4mr793832wmj.20.1683439181082;
        Sat, 06 May 2023 22:59:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5DUhiBqArpzzgosy6y74xywVU2Y2452GBQMAxT+LK1BKQwrXh1Hycvooc6PGiDtpgWSWRPyQ==
X-Received: by 2002:a7b:c3cf:0:b0:3f4:21cf:b4a4 with SMTP id t15-20020a7bc3cf000000b003f421cfb4a4mr793825wmj.20.1683439180804;
        Sat, 06 May 2023 22:59:40 -0700 (PDT)
Received: from redhat.com ([2.52.158.28])
        by smtp.gmail.com with ESMTPSA id k22-20020a05600c0b5600b003f40049a65bsm11545710wmr.21.2023.05.06.22.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 22:59:40 -0700 (PDT)
Date:   Sun, 7 May 2023 01:59:35 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Hao Chen <chenh@yusur.tech>
Cc:     Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, huangml@yusur.tech,
        zy@yusur.tech
Subject: Re: [PATCH] virtio_net: set default mtu to 1500 when 'Device maximum
 MTU' bigger than 1500
Message-ID: <20230507015819-mutt-send-email-mst@kernel.org>
References: <20230506021529.396812-1-chenh@yusur.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230506021529.396812-1-chenh@yusur.tech>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 06, 2023 at 10:15:29AM +0800, Hao Chen wrote:
> When VIRTIO_NET_F_MTU(3) Device maximum MTU reporting is supported.
> If offered by the device, device advises driver about the value of its
> maximum MTU. If negotiated, the driver uses mtu as the maximum
> MTU value. But there the driver also uses it as default mtu,
> some devices may have a maximum MTU greater than 1500, this may
> cause some large packages to be discarded, so I changed the MTU to a more
> general 1500 when 'Device maximum MTU' bigger than 1500.
> 
> Signed-off-by: Hao Chen <chenh@yusur.tech>

I don't see why not use the maximum. Bigger packets = better
performance.

> ---
>  drivers/net/virtio_net.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8d8038538fc4..e71c7d1b5f29 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4040,7 +4040,10 @@ static int virtnet_probe(struct virtio_device *vdev)
>  			goto free;
>  		}
>  
> -		dev->mtu = mtu;
> +		if (mtu > 1500)
> +			dev->mtu = 1500;
> +		else
> +			dev->mtu = mtu;
>  		dev->max_mtu = mtu;
>  	}
>  
> -- 
> 2.27.0

