Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17AA73E4C0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjFZQRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjFZQPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:15:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C642E4C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687796058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lAvdeHjRiEhExMf/8PkhS/lqlgbR8Yp8qV2L+W5RPMM=;
        b=b16c2Rv9kCAdt6Z4iEeBBpCohkilCNuwf9tj0W8B872mhpuZjd35NihhdbsbJURFxQd8Uy
        lFeq0GeTFEupaUpGpDqh76CqVpk05H3lmZcCAWSThctN9leI9Af/cu00sA8inaphKpOX9O
        AphRfmipxuKVA/3qqUgHfg5AHw8pjyA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-EioXiyc4O4OkIUC6_fIefA-1; Mon, 26 Jun 2023 12:14:17 -0400
X-MC-Unique: EioXiyc4O4OkIUC6_fIefA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-635984f84a9so20752346d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796054; x=1690388054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAvdeHjRiEhExMf/8PkhS/lqlgbR8Yp8qV2L+W5RPMM=;
        b=Pe4S5NiiBIieDBzuRudSSWgQBTtnlXzCQmAYuRxDkKJ4hD+sLPmIxN4B0GNHSivChg
         Y9rnwQY6+QhMI2JjF/NVjEVcr7Kd1ounvPSf/8167ShzB36m9oHQvtwBqMsiZ4FLX/Dw
         hgGACW/maievG1aFVxzrdHcbToUPqf4XgFuPIHbqx6lrZq2GSYZvaa9FAyUY4JA/Sk0G
         6/Ih/GIy/a+vpPS+csEpT936dWoikURvNkAA97Cy+RLpnpXsC35n6LpUpe3sim22so8J
         Elu/OYQoNLPQbFJsomIwfIpfMzWi42+nOVmQOVHOd8iUMAEEonMT7CfbJQ44Y92sB+Nl
         bnIw==
X-Gm-Message-State: AC+VfDxiMcmhHaHMzQNYxR/RLR1WVr6IiQgh0nM2z9cmURIo2pa7mGWz
        WDzuP5XP0oxnTZ9H+ar++F0UnUwPWbvKm5bzon2hUkhCMjL1C6KWUWtP4L8mIi3qMq8bUDN96vi
        +vDgm7gypzG3kZl+Ll8dU9x64
X-Received: by 2002:a05:6214:4015:b0:62d:d6e4:7ccf with SMTP id kd21-20020a056214401500b0062dd6e47ccfmr31955501qvb.40.1687796054279;
        Mon, 26 Jun 2023 09:14:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6dcXj93WXuU6BFIJYyBOMHVPNnCeqXrPEQR3X/qVTsVAuQorwHM7WjdhifsJqsX7Lt2y/AjA==
X-Received: by 2002:a05:6214:4015:b0:62d:d6e4:7ccf with SMTP id kd21-20020a056214401500b0062dd6e47ccfmr31955480qvb.40.1687796054044;
        Mon, 26 Jun 2023 09:14:14 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it. [87.11.6.160])
        by smtp.gmail.com with ESMTPSA id lw15-20020a05621457cf00b00626161ea7a3sm3349930qvb.2.2023.06.26.09.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:14:13 -0700 (PDT)
Date:   Mon, 26 Jun 2023 18:14:09 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, oxffffaa@gmail.com
Subject: Re: [RFC PATCH v4 12/17] vsock/loopback: support MSG_ZEROCOPY for
 transport
Message-ID: <lex6l5suez7azhirt22lidndtjomkbagfbpvvi5p7c2t7klzas@4l2qly7at37c>
References: <20230603204939.1598818-1-AVKrasnov@sberdevices.ru>
 <20230603204939.1598818-13-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230603204939.1598818-13-AVKrasnov@sberdevices.ru>
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

On Sat, Jun 03, 2023 at 11:49:34PM +0300, Arseniy Krasnov wrote:
>Add 'msgzerocopy_allow()' callback for loopback transport.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/vsock_loopback.c | 8 ++++++++
> 1 file changed, 8 insertions(+)
>
>diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
>index 5c6360df1f31..a2e4aeda2d92 100644
>--- a/net/vmw_vsock/vsock_loopback.c
>+++ b/net/vmw_vsock/vsock_loopback.c
>@@ -47,6 +47,7 @@ static int vsock_loopback_cancel_pkt(struct vsock_sock *vsk)
> }
>
> static bool vsock_loopback_seqpacket_allow(u32 remote_cid);
>+static bool vsock_loopback_msgzerocopy_allow(void);

I don't know why we did this for `vsock_loopback_seqpacket_allow`, but
can we just put the implementation here?

>
> static struct virtio_transport loopback_transport = {
> 	.transport = {
>@@ -92,11 +93,18 @@ static struct virtio_transport loopback_transport = {
> 		.notify_buffer_size       = virtio_transport_notify_buffer_size,
>
> 		.read_skb = virtio_transport_read_skb,
>+
>+		.msgzerocopy_allow        = vsock_loopback_msgzerocopy_allow,

Ditto the moving.

> 	},
>
> 	.send_pkt = vsock_loopback_send_pkt,
> };
>
>+static bool vsock_loopback_msgzerocopy_allow(void)
>+{
>+	return true;
>+}
>+
> static bool vsock_loopback_seqpacket_allow(u32 remote_cid)
> {
> 	return true;
>-- 
>2.25.1
>

