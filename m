Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1FA5EA9C0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbiIZPJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235638AbiIZPJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:09:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F96217586
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664199749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FmwtN+NyrhixAl+NaySPGi8yrkPzbP4TeUvnBlgzaxk=;
        b=gThVPn7z77OWMYQCPvRvYNfKyegFPp53ExnTFbi0u0zXB/pM0pnB27IFDZOWGa7Pkj1bWp
        A9YOKsVmfVqoRaN8/8/S61cueZXmjn6Egyu6Mf7krUXI19yUAvl8HowLADnNyETRAJKV7o
        t/uMHqExGCO13mER2xaUNJkDfkJRGVw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-151-rm9DtXSVNtqF9PFwkP9ZKA-1; Mon, 26 Sep 2022 09:42:27 -0400
X-MC-Unique: rm9DtXSVNtqF9PFwkP9ZKA-1
Received: by mail-qk1-f197.google.com with SMTP id az15-20020a05620a170f00b006cece4cd0beso4986480qkb.22
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:42:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=FmwtN+NyrhixAl+NaySPGi8yrkPzbP4TeUvnBlgzaxk=;
        b=jLgTmyPdykwlrXvMgQN1VRf+8kN2a7511lstOQi1/uQYtayDUowKd5IXlJguozjOcZ
         tFxaeYVnEWgkXsXSDzc/bWtc2xFCZtXT/3+0PG+6HpWB2DvVBI0KRAn7Ypr/WbHeOgyY
         zgcBuUASplaB18TY9+C3N+N8GiS6lnMfip7h8RUk97mCp7aPd4IIkyPyaDdAzPYOE/J8
         b/6gM9JktEuphp2LaGCAJkBwiL0C2GdXQ6osccoIyT7+nFPfJ3qqWfuEQg/HgGIsmrpn
         P+fnokwj+ULmC75dxgbWzRjv0GbLIsr23/AVvuF0FuijhIhVRYppBKkwqNtctPCpZzj0
         J6nw==
X-Gm-Message-State: ACrzQf0JFJWTqfsOiau+0i9UKKtvBPrawGdnDe/D5feWNJR5Sr428cG3
        ufy7zZG300dSvejuBSCltDFSVTIArY4PWOLCsgb0cn+kXueYJW2zUV46iipuKUZCdfnvaQGfdfE
        lJ3pG1B/wwGAw17rXRq+X/iKz
X-Received: by 2002:a05:620a:3711:b0:6ce:e7b3:d91b with SMTP id de17-20020a05620a371100b006cee7b3d91bmr13773031qkb.428.1664199746834;
        Mon, 26 Sep 2022 06:42:26 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM48rV68CI6BIVBegZsCpLRad8XltAIyLSTgKKG3vra2SE+tRk0FWFyXXO/Eu5qJt2XZgTxJpQ==
X-Received: by 2002:a05:620a:3711:b0:6ce:e7b3:d91b with SMTP id de17-20020a05620a371100b006cee7b3d91bmr13773011qkb.428.1664199746543;
        Mon, 26 Sep 2022 06:42:26 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-222.retail.telecomitalia.it. [79.46.200.222])
        by smtp.gmail.com with ESMTPSA id d7-20020a05620a240700b006cede93c765sm11947587qkn.28.2022.09.26.06.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 06:42:25 -0700 (PDT)
Date:   Mon, 26 Sep 2022 15:42:19 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Bobby Eshleman <bobby.eshleman@gmail.com>
Cc:     Bobby Eshleman <bobbyeshleman@gmail.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Jiang Wang <jiang.wang@bytedance.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 0/6] virtio/vsock: introduce dgrams, sk_buff, and qdisc
Message-ID: <20220926134219.sreibsw2rfgw7625@sgarzare-redhat>
References: <cover.1660362668.git.bobby.eshleman@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <cover.1660362668.git.bobby.eshleman@bytedance.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 15, 2022 at 10:56:03AM -0700, Bobby Eshleman wrote:
>Hey everybody,
>
>This series introduces datagrams, packet scheduling, and sk_buff usage
>to virtio vsock.

Just a reminder for those who are interested, tomorrow Sep 27 @ 16:00 
UTC we will discuss more about the next steps for this series in this 
room: https://meet.google.com/fxi-vuzr-jjb
(I'll try to record it and take notes that we will share)

Bobby, thank you so much for working on this! It would be great to solve 
the fairness issue and support datagram!

I took a look at the series, left some comments in the individual 
patches, and add some advice here that we could pick up tomorrow:
- it would be nice to run benchmarks (e.g., iperf-vsock, uperf, etc.) to
   see how much the changes cost (e.g. sk_buff use)
- we should take care also of other transports (i.e. vmci, hyperv), the 
   uAPI should be as close as possible regardless of the transport

About the use of netdev, it seems the most controversial point and I 
understand Jakub and Michael's concerns. Tomorrow would be great if you 
can update us if you have found any way to avoid it, just reusing a 
packet scheduler somehow.
It would be great if we could make it available for all transports (I'm 
not asking you to implement it for all, but to have a generic api that 
others can use).

But we can talk about that tomorrow!
Thanks,
Stefano

>
>The usage of struct sk_buff benefits users by a) preparing vsock to use
>other related systems that require sk_buff, such as sockmap and qdisc,
>b) supporting basic congestion control via sock_alloc_send_skb, and c)
>reducing copying when delivering packets to TAP.
>
>The socket layer no longer forces errors to be -ENOMEM, as typically
>userspace expects -EAGAIN when the sk_sndbuf threshold )s reached and
>messages are being sent with option MSG_DONTWAIT.
>
>The datagram work is based off previous patches by Jiang Wang[1].
>
>The introduction of datagrams creates a transport layer fairness issue
>where datagrams may freely starve streams of queue access. This happens
>because, unlike streams, datagrams lack the transactions necessary for
>calculating credits and throttling.
>
>Previous proposals introduce changes to the spec to add an additional
>virtqueue pair for datagrams[1]. Although this solution works, using
>Linux's qdisc for packet scheduling leverages already existing systems,
>avoids the need to change the virtio specification, and gives additional
>capabilities. The usage of SFQ or fq_codel, for example, may solve the
>transport layer starvation problem. It is easy to imagine other use
>cases as well. For example, services of varying importance may be
>assigned different priorities, and qdisc will apply appropriate
>priority-based scheduling. By default, the system default pfifo qdisc is
>used. The qdisc may be bypassed and legacy queuing is resumed by simply
>setting the virtio-vsock%d network device to state DOWN. This technique
>still allows vsock to work with zero-configuration.
>
>In summary, this series introduces these major changes to vsock:
>
>- virtio vsock supports datagrams
>- virtio vsock uses struct sk_buff instead of virtio_vsock_pkt
>  - Because virtio vsock uses sk_buff, it also uses sock_alloc_send_skb,
>    which applies the throttling threshold sk_sndbuf.
>- The vsock socket layer supports returning errors other than -ENOMEM.
>  - This is used to return -EAGAIN when the sk_sndbuf threshold is
>    reached.
>- virtio vsock uses a net_device, through which qdisc may be used.
> - qdisc allows scheduling policies to be applied to vsock flows.
>  - Some qdiscs, like SFQ, may allow vsock to avoid transport layer congestion. That is,
>    it may avoid datagrams from flooding out stream flows. The benefit
>    to this is that additional virtqueues are not needed for datagrams.
>  - The net_device and qdisc is bypassed by simply setting the
>    net_device state to DOWN.
>
>[1]: https://lore.kernel.org/all/20210914055440.3121004-1-jiang.wang@bytedance.com/
>
>Bobby Eshleman (5):
>  vsock: replace virtio_vsock_pkt with sk_buff
>  vsock: return errors other than -ENOMEM to socket
>  vsock: add netdev to vhost/virtio vsock
>  virtio/vsock: add VIRTIO_VSOCK_F_DGRAM feature bit
>  virtio/vsock: add support for dgram
>
>Jiang Wang (1):
>  vsock_test: add tests for vsock dgram
>
> drivers/vhost/vsock.c                   | 238 ++++----
> include/linux/virtio_vsock.h            |  73 ++-
> include/net/af_vsock.h                  |   2 +
> include/uapi/linux/virtio_vsock.h       |   2 +
> net/vmw_vsock/af_vsock.c                |  30 +-
> net/vmw_vsock/hyperv_transport.c        |   2 +-
> net/vmw_vsock/virtio_transport.c        | 237 +++++---
> net/vmw_vsock/virtio_transport_common.c | 771 ++++++++++++++++--------
> net/vmw_vsock/vmci_transport.c          |   9 +-
> net/vmw_vsock/vsock_loopback.c          |  51 +-
> tools/testing/vsock/util.c              | 105 ++++
> tools/testing/vsock/util.h              |   4 +
> tools/testing/vsock/vsock_test.c        | 195 ++++++
> 13 files changed, 1176 insertions(+), 543 deletions(-)
>
>-- 
>2.35.1
>

