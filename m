Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756B85BBDBB
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 14:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiIRMRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 08:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiIRMRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 08:17:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445AD26566
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 05:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663503464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YIbilycgQyjenY282EZwIsPOR3PFZL895xpYAyq5afo=;
        b=YERIaMD3wuYcnSSHE5rUpWiQjkG8gGRR1lrtqwN26ySuPA3SXyOQXrtzXfk6ZlP/qdL2zq
        Wi8TSV4I/i5XFho/xPp5yJ51WtA/+yetS5HTmPeOqMVq2AQh4d2sAzk1UrI/UTaUTIJmFJ
        UAemRQH+Sj8Bz5IoUntKUlqtiwZCbBI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-132-j7yNnWd_NC-lZvpwcK1dog-1; Sun, 18 Sep 2022 08:17:42 -0400
X-MC-Unique: j7yNnWd_NC-lZvpwcK1dog-1
Received: by mail-wm1-f70.google.com with SMTP id 185-20020a1c02c2000000b003b4be28d7e3so2320661wmc.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 05:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=YIbilycgQyjenY282EZwIsPOR3PFZL895xpYAyq5afo=;
        b=fE8PzRbZuxDXpvk9sr2fxsRtobGiqzz0TjbLAO+hBs4XENlH6MaIG/QqWXuXUR1h8N
         G2NrFmqlAjNPZ6cchwaa7yFYwBbRClYvwwn2BPymVpTZHPaOBRadIMuEAQtH/QgyoAo2
         7nfcK8gYVJ7HG7d9DY6weId1zhqQfsRvuErgZ1iCwhY5NHZnU5lZlpMHQh8cr477iFzy
         /2fR479G8TTFE5lUBIM/SOjhvGQLAmtqgq11K+4l6rdKTUJpZ9OjiGclhyQvYan0dzUg
         kR3RrJ20ydph9ykHLL9aN4WyXM6Nsm4aAeANVV9pIVzDLrngQUF8D7pcbVRs2XqpBDko
         OLVw==
X-Gm-Message-State: ACrzQf3XmEscnjBYOCxY/d//LAzvYC7RgLNh0lgDNgBoHx0mWZfTA/0X
        pXH9NIIGDBGR1bBSGv/rq4mR/eV/DwMnTYA4mG2YoSxFfWJ0+fjoZGQm2DW2bynKDKts69Sptmm
        li16y4cnsj45loB1zN0fBTci5
X-Received: by 2002:a5d:4742:0:b0:22a:3a88:d9e6 with SMTP id o2-20020a5d4742000000b0022a3a88d9e6mr8183470wrs.438.1663503461619;
        Sun, 18 Sep 2022 05:17:41 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6OgKAiHsRIMsNcvcQlSELq9pAaD49wvj8xve/5Xz8Q2YgoqvtA0Jk9oZfbBvYoMf3nUdnFOQ==
X-Received: by 2002:a5d:4742:0:b0:22a:3a88:d9e6 with SMTP id o2-20020a5d4742000000b0022a3a88d9e6mr8183456wrs.438.1663503461375;
        Sun, 18 Sep 2022 05:17:41 -0700 (PDT)
Received: from redhat.com ([2.52.4.6])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c354700b003b4cba4ef71sm4421682wmq.41.2022.09.18.05.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 05:17:40 -0700 (PDT)
Date:   Sun, 18 Sep 2022 08:17:36 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Junbo <junbo4242@gmail.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] Do not name control queue for virtio-net
Message-ID: <20220918081713-mutt-send-email-mst@kernel.org>
References: <20220917092857.3752357-1-junbo4242@gmail.com>
 <20220918025033-mutt-send-email-mst@kernel.org>
 <CACvn-oGUj0mDxBO2yV1mwvz4PzhN3rDnVpUh12NA5jLKTqRT3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACvn-oGUj0mDxBO2yV1mwvz4PzhN3rDnVpUh12NA5jLKTqRT3A@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2022 at 05:00:20PM +0800, Junbo wrote:
> hi Michael
> 
> in virtio-net.c
>     /* Parameters for control virtqueue, if any */
>     if (vi->has_cvq) {
>         callbacks[total_vqs - 1] = NULL;
>         names[total_vqs - 1] = "control";
>     }
> 
> I think the Author who write the code

wait, that was not you?

> maybe want to name the control queue to
> 'virtioX-control', but it never worked, we can see the name still be
> 'virtioX-config' in /proc/interrupts, for example 
>  43:          0          0          0          0          0          0        
>  0          0   PCI-MSI-edge      virtio0-config
>  44:         64          0          0          0          0          0      
> 1845          0   PCI-MSI-edge      virtio0-input.0
>  45:          1          0          0          0          0          0        
>  0          0   PCI-MSI-edge      virtio0-output.0
> 
> Because in function vp_request_msix_vectors, it just allocate 'xxxx-config' to
> every virtio devices, even the virtio device do not need it. in /proc/
> interrupts, we can see that each virtio device's first interrupt always named
> 'virtioX-config'.
> 
> So I think it's better to not explicitly give the "control" here, it's
> useless...  
> 
> 
> Michael S. Tsirkin <mst@redhat.com> 于2022年9月18日周日 14:56写道：
> 
>     On Sat, Sep 17, 2022 at 09:28:57AM +0000, junbo4242@gmail.com wrote:
>     > From: Junbo <junbo4242@gmail.com>
>     >
>     > In virtio drivers, the control queue always named <virtioX>-config.
>     >
>     > Signed-off-by: Junbo <junbo4242@gmail.com>
> 
>     I don't think that's right. config is the config interrupt.
> 
> 
> 
>     > ---
>     >  drivers/net/virtio_net.c | 3 ++-
>     >  1 file changed, 2 insertions(+), 1 deletion(-)
>     >
>     > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>     > index 9cce7dec7366..0b3e74cfe201 100644
>     > --- a/drivers/net/virtio_net.c
>     > +++ b/drivers/net/virtio_net.c
>     > @@ -3469,7 +3469,8 @@ static int virtnet_find_vqs(struct virtnet_info
>     *vi)
>     >       /* Parameters for control virtqueue, if any */
>     >       if (vi->has_cvq) {
>     >               callbacks[total_vqs - 1] = NULL;
>     > -             names[total_vqs - 1] = "control";
>     > +             /* control virtqueue always named <virtioX>-config */
>     > +             names[total_vqs - 1] = "";
>     >       }
>     > 
>     >       /* Allocate/initialize parameters for send/receive virtqueues */
>     > --
>     > 2.31.1
> 
> 

