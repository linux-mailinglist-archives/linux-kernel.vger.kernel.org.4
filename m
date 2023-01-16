Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F9166BC8F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjAPLNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjAPLNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:13:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF7C1C33A
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673867534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xk0ru0w9+e9EAkvTNXaYhN64TcjBSGHtatyySaOd8KM=;
        b=YQIT1efElICsjZff5Tkzo6Pc1Zj+u9kb4jbdLLhsdLU2AEpSBatEYcZm2fMfi5uP2NW7si
        NpOBprpJDGC82OtC342OAaydJAONkDTP5ickep41brS1zJNgOiKfldeekKLzT01TOzckck
        NrdfiEyrFyg5I32aH86lU0H8uGXeBq0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-672-qdybCmuqO3OR3eNedgUzSQ-1; Mon, 16 Jan 2023 06:12:13 -0500
X-MC-Unique: qdybCmuqO3OR3eNedgUzSQ-1
Received: by mail-qk1-f199.google.com with SMTP id m9-20020a05620a290900b0070596994c7eso20530766qkp.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:12:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xk0ru0w9+e9EAkvTNXaYhN64TcjBSGHtatyySaOd8KM=;
        b=sdadv0ZK5r7xREMCBL7z3oRcBF5HGiRa8+T4MFuAtKB7vTplZ6IfS6jP5CcJ7/hshK
         kozuccl8TKZ11cRzKHWbA2sJm05NmY4233SxwjVpE1lU+iVYFN/YpwyixvNUWM1hI2W4
         G45I0HSWQYzZQ9F1X6y26/NmddrpMDoHaajE7wfVnzmxT0lFGinx9Clp7/jvBaL+4XIG
         2DyysjbzhCOTsuji4L89u6OiLfvrDHQ0cM33zJMR8wbNs8qyjuFbQRbUx2QzVnMt1GxQ
         3HlUMyuQI4Lz+gLT6w9aQUn6gyds1/ZbaNMEx56lmUnOvOgfTJYVDqsvoCctOj6LpSeK
         N7hg==
X-Gm-Message-State: AFqh2kpjBcRWDUnMiC4rVaQq+7rzQJ86YHFF2+wGkfqEIeddWAtEh8BO
        fjXLYuvCYEmvKJTerDHAhWoD9verWCabZaVAN6mj34UUDpNmczmL27hAfvb1/oDb3tc/U5SLZaV
        9Rt+f0yYkfi3XbC/LGw+OVbQH
X-Received: by 2002:a05:622a:4a15:b0:3af:b6bd:aba7 with SMTP id fv21-20020a05622a4a1500b003afb6bdaba7mr35212433qtb.43.1673867533201;
        Mon, 16 Jan 2023 03:12:13 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvUnYT51VUVH61+cDwTfIaOq8om38/xZLMDlzmwknNhKAsbceeU8IOMbufPUB8nUrZ/3z1C8A==
X-Received: by 2002:a05:622a:4a15:b0:3af:b6bd:aba7 with SMTP id fv21-20020a05622a4a1500b003afb6bdaba7mr35212399qtb.43.1673867532964;
        Mon, 16 Jan 2023 03:12:12 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-72.retail.telecomitalia.it. [79.46.200.72])
        by smtp.gmail.com with ESMTPSA id do26-20020a05620a2b1a00b0070648cf78bdsm3938908qkb.54.2023.01.16.03.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 03:12:12 -0800 (PST)
Date:   Mon, 16 Jan 2023 12:12:07 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Bobby Eshleman <bobby.eshleman@bytedance.com>
Cc:     Bobby Eshleman <bobbyeshleman@gmail.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v10] virtio/vsock: replace virtio_vsock_pkt with
 sk_buff
Message-ID: <20230116111207.yxlwh4jlejtn4ple@sgarzare-redhat>
References: <20230113222137.2490173-1-bobby.eshleman@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230113222137.2490173-1-bobby.eshleman@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 10:21:37PM +0000, Bobby Eshleman wrote:
>This commit changes virtio/vsock to use sk_buff instead of
>virtio_vsock_pkt. Beyond better conforming to other net code, using
>sk_buff allows vsock to use sk_buff-dependent features in the future
>(such as sockmap) and improves throughput.
>
>This patch introduces the following performance changes:
>
>Tool: Uperf
>Env: Phys Host + L1 Guest
>Payload: 64k
>Threads: 16
>Test Runs: 10
>Type: SOCK_STREAM
>Before: commit b7bfaa761d760 ("Linux 6.2-rc3")
>
>Before
>------
>g2h: 16.77Gb/s
>h2g: 10.56Gb/s
>
>After
>-----
>g2h: 21.04Gb/s
>h2g: 10.76Gb/s
>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>
>---
>Changes in v10:
>- vhost/vsock: use virtio_vsock_skb_dequeue()
>- vhost/vsock: remove extra iov_length() call
>- vhost/vsock: also consider hdr when evaluating that incoming size is
>  valid
>- new uperf data

Tests seem fine!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

