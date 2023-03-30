Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FA46CFD9B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjC3IB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjC3IBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:01:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC1E5B92
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680163248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aKnf9talvaQpvRmivVJ+UtDT41SWYzLKCf+gopv+JXM=;
        b=S7TPESy34jkcaoU4FdXnSNnzTpLl6rXo73iWvx9N08rRzSz3ZItB1glF8iylCjrkrx5jFi
        eJ92UC4/CyNlkGx42vLs0Wa7GIm8hCVc/e0YcM7D/lPlWjz3zeajw3t1kryZ8JUawM2NBc
        i+Paqv06iIqETSEpoMBWbnst8SkG/Ss=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-QcRx3pXHPqGcU3ZrwxtK2g-1; Thu, 30 Mar 2023 04:00:46 -0400
X-MC-Unique: QcRx3pXHPqGcU3ZrwxtK2g-1
Received: by mail-qv1-f72.google.com with SMTP id j15-20020a0cc34f000000b005c824064b10so7857212qvi.17
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680163246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKnf9talvaQpvRmivVJ+UtDT41SWYzLKCf+gopv+JXM=;
        b=Qay56DLQPk5r89W7Qzg8acAFTFM6RikW2kvAlD7T9KfXTMK+lopDzw2yqWHouZXAAA
         jlhgz6PYqYhldcUHZeoExQ9V2JRsxlswpJRcRbqKT3ew8aSmjHGVX7Rwpq6/2pYday59
         FULI7qzSB5mr/UDqX69rjnMSmUF9mz5LFaCHtdEM2DZvcFFvs0duoSgYbi51v4E1GtZ/
         UpCVzC0KuIJ46DhQJX9o1Y5u+MWpoWU3KcfBQs4hBrYCCaw4C+acLTkVceeLoBpGpnFP
         ebto2WztfQ+ozEhTruLjeOeorSY5LV/Gms/wJZmKyRE1VOWkPZ7yGO4v+MDSDeVFM5+/
         vAug==
X-Gm-Message-State: AAQBX9cWWUf3wi1aPFZmbSK0TJ9qHLuNebgGct86UlMLzOtB+8XdknXF
        VZ3NG7hQzDPOBogNpSntq61jQGrsEFiXlu9T6i+t2XjcEqEl0VVSo6blm+bCmxQQzjRUB+jKelC
        rYfrg1Fw9xdm0dbNcX60K6yBC
X-Received: by 2002:a05:6214:21a8:b0:5e0:3bbf:78c5 with SMTP id t8-20020a05621421a800b005e03bbf78c5mr2381394qvc.37.1680163246464;
        Thu, 30 Mar 2023 01:00:46 -0700 (PDT)
X-Google-Smtp-Source: AKy350YFd/4+N/O9Q5uwc3AG+urPSvuo4JSxefwurWAaOedWAKnyL/UuyV9ifYC209uK3neiFHLf+g==
X-Received: by 2002:a05:6214:21a8:b0:5e0:3bbf:78c5 with SMTP id t8-20020a05621421a800b005e03bbf78c5mr2381363qvc.37.1680163246211;
        Thu, 30 Mar 2023 01:00:46 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-130.retail.telecomitalia.it. [82.57.51.130])
        by smtp.gmail.com with ESMTPSA id l4-20020ad44244000000b005dd8b9345cesm5192472qvq.102.2023.03.30.01.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 01:00:45 -0700 (PDT)
Date:   Thu, 30 Mar 2023 10:00:40 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Bobby Eshleman <bobby.eshleman@bytedance.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH net v3] virtio/vsock: fix leaks due to missing skb owner
Message-ID: <p6y6cwfywyi5apvn4cx5edob3n2zvyrmfvj6yss5szd24phgnt@gynsr43tsvan>
References: <20230327-vsock-fix-leak-v3-1-292cfc257531@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230327-vsock-fix-leak-v3-1-292cfc257531@bytedance.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 04:51:58PM +0000, Bobby Eshleman wrote:
>This patch sets the skb owner in the recv and send path for virtio.
>
>For the send path, this solves the leak caused when
>virtio_transport_purge_skbs() finds skb->sk is always NULL and therefore
>never matches it with the current socket. Setting the owner upon
>allocation fixes this.
>
>For the recv path, this ensures correctness of accounting and also
>correct transfer of ownership in vsock_loopback (when skbs are sent from
>one socket and received by another).
>
>Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>Reported-by: Cong Wang <xiyou.wangcong@gmail.com>
>Link: https://lore.kernel.org/all/ZCCbATwov4U+GBUv@pop-os.localdomain/
>---
>Changes in v3:
>- virtio/vsock: use skb_set_owner_sk_safe() instead of
>  skb_set_owner_{r,w}
>- virtio/vsock: reject allocating/receiving skb if sk_refcnt==0 and WARN_ONCE
>- Link to v2: https://lore.kernel.org/r/20230327-vsock-fix-leak-v2-1-f6619972dee0@bytedance.com
>
>Changes in v2:
>- virtio/vsock: add skb_set_owner_r to recv_pkt()
>- Link to v1: https://lore.kernel.org/r/20230327-vsock-fix-leak-v1-1-3fede367105f@bytedance.com
>---
> net/vmw_vsock/virtio_transport_common.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 957cdc01c8e8..c927dc302faa 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -94,6 +94,11 @@ virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
> 					 info->op,
> 					 info->flags);
>
>+	if (info->vsk && !skb_set_owner_sk_safe(skb, sk_vsock(info->vsk))) {
>+		WARN_ONCE(1, "failed to allocate skb on vsock socket with sk_refcnt == 0\n");
>+		goto out;
>+	}
>+
> 	return skb;
>
> out:
>@@ -1294,6 +1299,11 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> 		goto free_pkt;
> 	}
>
>+	if (!skb_set_owner_sk_safe(skb, sk)) {
>+		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
>+		goto free_pkt;
>+	}
>+

LGTM!

I would have put the condition inside WARN_ONCE() because I find it
more readable (e.g. WARN_ONCE(!skb_set_owner_sk_safe(skb, sk), ...),
but I don't have a strong opinion on that, so that's fine too:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

