Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BD46CB8D9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 09:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjC1H64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 03:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbjC1H6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:58:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D62440CA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679990287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zX64wamSvcuBg/+n8EW5C/QE8JCYba2x9NZLoF8LKOI=;
        b=QructXApXTiSuLD9AMSFAiTXvHMzTX7Piz/Io9gUT2Y0O7H0LDUKMKV6LQjk8wHa/LbZZC
        VmSK4Jzq5rOAMv2pnDBHHCtp7ELseboumrDmc6Bwn4K3/OyNH+UVp3yWtcns4yQEw0XjXK
        h5C9BUiNHZM4LWyx/UqeaE2IFCtmQ4g=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-JRmGf73mNXaSDMjG2sn17Q-1; Tue, 28 Mar 2023 03:58:06 -0400
X-MC-Unique: JRmGf73mNXaSDMjG2sn17Q-1
Received: by mail-qv1-f69.google.com with SMTP id l18-20020ad44bd2000000b005a9cf5f609eso4694683qvw.15
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679990285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zX64wamSvcuBg/+n8EW5C/QE8JCYba2x9NZLoF8LKOI=;
        b=XVYseOwuTxbHmjvbldMy6KA0dyTLyJYUPjWsMeU8zxmf8VtnUQOgHhkmgDY99s6D7Z
         zcUzOOptcEPbNo1wE2I+8PBc5s/l+6Zf91OM7wSByH3ZVKviBhsNT3tonTrirTh824LK
         l9afqOHo0C1YgsZIBq1nIwnnPDoiNdjoNEadjGW7CqnL8M2yccSOlSQbNSFyunT023Kk
         OO2sXocHTlAXE9ejHOj5Cvs610vJJiNN/yMtcZqsDxDLcsvXIZp28gc+E8g290u6uSHF
         6ewi0EEFblsNK9rU8SiOGRBeOU4KsWYIGZR28Riaa7/l3Usv5ZKxCXVg9+3qSsIF7e1G
         3pJQ==
X-Gm-Message-State: AO0yUKXRKu/Z5ClIEDI3wAeX+9Uf6Nzw5MH7ae+lpi1AFxd+gq4kEC4K
        Fby56KxX13dePRIpC2dKRs7tVTebi8tP9ZuH3zMa2qxdDH02HTWYp6/SKtZlyaSEESsm0GPsQSF
        bNn5R8Sectcpht7wPEA2vrPwL
X-Received: by 2002:ac8:584e:0:b0:3d3:95fd:9085 with SMTP id h14-20020ac8584e000000b003d395fd9085mr25956584qth.42.1679990285644;
        Tue, 28 Mar 2023 00:58:05 -0700 (PDT)
X-Google-Smtp-Source: AKy350a8LN3HbXJ4yvKz19Oadd4R8pyBHJFdmxnmtbIae9l3nU8wgRH2HBkaFmqmIFsJT4IA1NyyBw==
X-Received: by 2002:ac8:584e:0:b0:3d3:95fd:9085 with SMTP id h14-20020ac8584e000000b003d395fd9085mr25956565qth.42.1679990285424;
        Tue, 28 Mar 2023 00:58:05 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-98.retail.telecomitalia.it. [82.53.134.98])
        by smtp.gmail.com with ESMTPSA id h20-20020ac85154000000b003e4e1dbdcc3sm2122686qtn.47.2023.03.28.00.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 00:58:05 -0700 (PDT)
Date:   Tue, 28 Mar 2023 09:58:00 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Bobby Eshleman <bobby.eshleman@bytedance.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH net] virtio/vsock: fix leak due to missing skb owner
Message-ID: <jinx5oduhddyyaxnreey2riem3s7ju5zuszddmoiie6dcnyiiy@fr4cg33vi7aq>
References: <20230327-vsock-fix-leak-v1-1-3fede367105f@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230327-vsock-fix-leak-v1-1-3fede367105f@bytedance.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 10:01:05PM +0000, Bobby Eshleman wrote:
>This patch sets the owner for the skb when being sent from a socket and
>so solves the leak caused when virtio_transport_purge_skbs() finds
>skb->sk is always NULL and therefore never matches it with the current
>socket. Setting the owner upon allocation fixes this.
>
>Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>Reported-by: Cong Wang <xiyou.wangcong@gmail.com>
>Link: https://lore.kernel.org/all/ZCCbATwov4U+GBUv@pop-os.localdomain/
>---
> net/vmw_vsock/virtio_transport_common.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 957cdc01c8e8..2a2f0c1a9fbd 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -94,6 +94,9 @@ virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
> 					 info->op,
> 					 info->flags);
>
>+	if (info->vsk)
>+		skb_set_owner_w(skb, sk_vsock(info->vsk));
>+

Should we do the same also in virtio_transport_recv_pkt()?

The skb in that cases is allocated in drivers/vhost/vsock.c and
net/vmw_vsock/virtio_transport.c using directly
virtio_vsock_alloc_skb(), because we don't know in advance which socket
it belongs to.

Then in virtio_transport_recv_pkt() we look for the socket and queue it
up. This should also solve the problem in vsock_loopback.c where we move
skb from one socket to another.

Thanks,
Stefano

