Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29C56CBA77
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjC1JYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjC1JYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:24:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91C55BA1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679995403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FlyvMdw2nhPSREcgm2mQMSn2Bg5EDd8FhpiFHg5I85g=;
        b=U2UQqI9hvzBmCId2321DGltf6q7/vTvZdTe10uVqS0lT8l+oNLpV8Xr2YkZNpY5HpLbidH
        Pn6T25rbl77jdki48LtSJ4S+SG/mfXZ1t6YFP4QfTSK/Z+ehDsF/qcxP0dYzW3kUxfDSvX
        XrpwjwWzZ5l3md2l0BwEtgjg+kWA2cA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-kPZPh7TcPXOgcX6dFvYcTw-1; Tue, 28 Mar 2023 05:23:22 -0400
X-MC-Unique: kPZPh7TcPXOgcX6dFvYcTw-1
Received: by mail-qk1-f197.google.com with SMTP id 198-20020a370bcf000000b007468cffa4e2so5337462qkl.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679995402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlyvMdw2nhPSREcgm2mQMSn2Bg5EDd8FhpiFHg5I85g=;
        b=XwfYv92cNgbI+wdNGRd/8tphh+3ETCQ8hoNfp35P264/o+fh63xgTc5rl+OOzIIm3O
         QQDFaQt8FlRxY3TDpwgYLi6tTXMNcmpgxi3NhvM1Ferv7CM3voTyYDW6NtdSqqj9Tmp6
         aDppFe8B2qvhcaXfK+5B4vebsNCXMHof2tFfhh7WaLHCMbzhQs1/ZUSu2lVYe6kI15Vb
         K5iLxW7IfZVT7q7Neox/EfrV0Vfrk0bzohZmnb4aqZyAOJX9QNFGb3Ce0rcBPoavHmjT
         aXK+VuikxRR9ULbCKKmIFggi4fRpmETl3mXZK/PyDeH0zNEdC3U23fO5bhe+mmYpNNkz
         K+9A==
X-Gm-Message-State: AAQBX9dZL6FcjYQxJvPJ7C/1RYeBn8qQP9OEQK6+2ae5C51DY6H58w6/
        TqaoSEjdQncO3ZiS8IanDXlIsWyEzv5UGB3lLSEgOyohxiy/RTpBhOMoT581OTs+JJVpSd4ght8
        HjN9zOGFw3Lc4eeRkFKcIc+Kt
X-Received: by 2002:a05:6214:27c6:b0:56e:a9d4:429b with SMTP id ge6-20020a05621427c600b0056ea9d4429bmr23339840qvb.1.1679995402136;
        Tue, 28 Mar 2023 02:23:22 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yjyndn+8JhX5yEkfDB1ZbfV1IVX73FEzKiCbPGXb88TQ6qGch6AlQQ3iq9fmV5EH8VUrZ2rQ==
X-Received: by 2002:a05:6214:27c6:b0:56e:a9d4:429b with SMTP id ge6-20020a05621427c600b0056ea9d4429bmr23339828qvb.1.1679995401919;
        Tue, 28 Mar 2023 02:23:21 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-98.retail.telecomitalia.it. [82.53.134.98])
        by smtp.gmail.com with ESMTPSA id l7-20020a0cc207000000b005dd8b9345d0sm3588061qvh.104.2023.03.28.02.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 02:23:21 -0700 (PDT)
Date:   Tue, 28 Mar 2023 11:23:16 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, oxffffaa@gmail.com
Subject: Re: [RFC PATCH v2 1/3] virtio/vsock: fix header length on skb merging
Message-ID: <yi6goqhyxkh4slmje6a37vlrxby2qmzg66wgdzrzgt55wgpvdy@d3b7jucayzxv>
References: <728181e9-6b35-0092-3d01-3d7aff4521b6@sberdevices.ru>
 <b5d31a81-a089-146b-d04f-569710e6b14b@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b5d31a81-a089-146b-d04f-569710e6b14b@sberdevices.ru>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 01:08:22AM +0300, Arseniy Krasnov wrote:
>This fixes appending newly arrived skbuff to the last skbuff of the
>socket's queue. Problem fires when we are trying to append data to skbuff
>which was already processed in dequeue callback at least once. Dequeue
>callback calls function 'skb_pull()' which changes 'skb->len'. In current
>implementation 'skb->len' is used to update length in header of the last
>skbuff after new data was copied to it. This is bug, because value in
>header is used to calculate 'rx_bytes'/'fwd_cnt' and thus must be not
>be changed during skbuff's lifetime.
>
>Bug starts to fire since:
>
>commit 077706165717
>("virtio/vsock: don't use skbuff state to account credit")
>
>It presents before, but didn't triggered due to a little bit buggy
>implementation of credit calculation logic. So use Fixes tag for it.
>
>Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/virtio_transport_common.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 7fc178c3ee07..b9144af71553 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1101,7 +1101,7 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> 			memcpy(skb_put(last_skb, skb->len), skb->data, skb->len);
> 			free_pkt = true;
> 			last_hdr->flags |= hdr->flags;
>-			last_hdr->len = cpu_to_le32(last_skb->len);
>+			le32_add_cpu(&last_hdr->len, len);
> 			goto out;
> 		}
> 	}
>-- 
>2.25.1
>

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

