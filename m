Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B61622297
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 04:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiKID3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 22:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiKID3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 22:29:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76E823EB3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 19:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667964535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vD224Hogxka5wNQa91Zymh6Ygmv+WpD4Z+GDd/Nec64=;
        b=V3juxFVuGEJHf/bS3/DHOMDIyh1qnJYhQ28drjtFqQKq07137+nMovEBFR79A9OvKyGZTg
        F6pOxv5sJnesbPpOQ8OnK7cMzEvHsUCaw9M1SRQ6QCmOPOlmO+X7lI7p/NXsQxSUNsOt4J
        S9BBKpoJSUFKKGsLTDJsSIgn35fVNjk=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-433-XWMe1VMjPfeiszd5ufy0bQ-1; Tue, 08 Nov 2022 22:28:54 -0500
X-MC-Unique: XWMe1VMjPfeiszd5ufy0bQ-1
Received: by mail-oi1-f199.google.com with SMTP id bj30-20020a056808199e00b0035a0734664bso5985853oib.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 19:28:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vD224Hogxka5wNQa91Zymh6Ygmv+WpD4Z+GDd/Nec64=;
        b=lO2qXuhy/eRlSfH2vvqqdqCQHqkiWsyu0Z9UG/HAgTcsd3u8Cx8R4Jspno2fFvZayJ
         9qqRlnNJkZji4LeDoflx8EiMQxtkGINj8E7UfQmFY9/bTkqcIjmAle2Lx8v/EM6FE73g
         WmVs56stQuAAS5ohaEeGd2fDHk7YrW5q69dEtA37sey0urFWLYJzJt5yJtZYmWp8QZ3V
         Myfr4/ANo2O0Npb9dnn9E+lmG48QI5YknFflWINtjnp/QdXY8S7ZtHTncmRA7jlARQkI
         0psRvvTnor2pVyBhKi2Tr0fSjD2UienI1MkUNTvKjmCNiPgEAKmmOwnCvuKokcuuN/cG
         UVGQ==
X-Gm-Message-State: ACrzQf1cIFqdpmnn1CZp5Dxzh+oOMHF20DxBznp9dSLjelNNL+VwjLTH
        gooTD3gBryFgoTyQH2S+aSYP7EVSfIRc+k54VmrTX16A49jjbEafT9nHUUmvdIxEsE4zbqfqvQo
        SRJ43RFgJaAMlaXJYQ1au2G+KXnVkm4V4kFLYjQN7
X-Received: by 2002:a4a:2ccf:0:b0:49e:b502:3a2b with SMTP id o198-20020a4a2ccf000000b0049eb5023a2bmr9793073ooo.57.1667964533309;
        Tue, 08 Nov 2022 19:28:53 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7F+ESUW02GevhFXeHeZiWN+C8qmGvnQrxAgchRgTHWuxrTWr/5I2RPYR7pW6CVQHNQHYEXuWSbcbl1kJXQxyk=
X-Received: by 2002:a4a:2ccf:0:b0:49e:b502:3a2b with SMTP id
 o198-20020a4a2ccf000000b0049eb5023a2bmr9793067ooo.57.1667964533083; Tue, 08
 Nov 2022 19:28:53 -0800 (PST)
MIME-Version: 1.0
References: <20221108103437.105327-1-sgarzare@redhat.com> <20221108103437.105327-3-sgarzare@redhat.com>
In-Reply-To: <20221108103437.105327-3-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 9 Nov 2022 11:28:41 +0800
Message-ID: <CACGkMEuRnqxESo=V2COnfUjP5jGLTXzNRt3=Tp2x-9jsS-RNGQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] vhost: fix range used in translate_desc()
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 8, 2022 at 6:34 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> vhost_iotlb_itree_first() requires `start` and `last` parameters
> to search for a mapping that overlaps the range.
>
> In translate_desc() we cyclically call vhost_iotlb_itree_first(),
> incrementing `addr` by the amount already translated, so rightly
> we move the `start` parameter passed to vhost_iotlb_itree_first(),
> but we should hold the `last` parameter constant.
>
> Let's fix it by saving the `last` parameter value before incrementing
> `addr` in the loop.
>
> Fixes: 0bbe30668d89 ("vhost: factor out IOTLB")
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>
> I'm not sure about the fixes tag. On the one I used this patch should
> apply cleanly, but looking at the latest stable (4.9), maybe we should
> use
>
> Fixes: a9709d6874d5 ("vhost: convert pre sorted vhost memory array to interval tree")

I think this should be the right commit to fix.

Other than this

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> Suggestions?
> ---
>  drivers/vhost/vhost.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 40097826cff0..3c2359570df9 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2053,7 +2053,7 @@ static int translate_desc(struct vhost_virtqueue *vq, u64 addr, u32 len,
>         struct vhost_dev *dev = vq->dev;
>         struct vhost_iotlb *umem = dev->iotlb ? dev->iotlb : dev->umem;
>         struct iovec *_iov;
> -       u64 s = 0;
> +       u64 s = 0, last = addr + len - 1;
>         int ret = 0;
>
>         while ((u64)len > s) {
> @@ -2063,7 +2063,7 @@ static int translate_desc(struct vhost_virtqueue *vq, u64 addr, u32 len,
>                         break;
>                 }
>
> -               map = vhost_iotlb_itree_first(umem, addr, addr + len - 1);
> +               map = vhost_iotlb_itree_first(umem, addr, last);
>                 if (map == NULL || map->start > addr) {
>                         if (umem != dev->iotlb) {
>                                 ret = -EFAULT;
> --
> 2.38.1
>

