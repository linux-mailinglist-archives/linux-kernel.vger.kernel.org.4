Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E9C6CBB18
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbjC1Jcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbjC1Jca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:32:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328977ECF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679995767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2MTYkIHhyDg1tSTjOD+oc1eBs9Ie8OrzP6nP660U11M=;
        b=EdMCRJr+/SCHybhvnJ8gOL96yqmt2TVh+xw9FxYPrYvT//1HZcxddMEd1WsN9Q2NM0pP1D
        GuEEFwwV8MjHHDIXt8LtEb3vcy/D4clDb20wseaD4q8W72afEBDpje+DXeOiFviqpsNurz
        hvItRfeQbyF5ijJ7KAxzsVUcHVAkkFo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-gzb81avmMBGQZ3wZeplN3w-1; Tue, 28 Mar 2023 05:29:19 -0400
X-MC-Unique: gzb81avmMBGQZ3wZeplN3w-1
Received: by mail-qt1-f199.google.com with SMTP id v10-20020a05622a130a00b003e4ee70e001so1811670qtk.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679995758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MTYkIHhyDg1tSTjOD+oc1eBs9Ie8OrzP6nP660U11M=;
        b=M5jrtyDDIxv+UEALUoa4z0dTEMFza61kttJgg5yLEbuX+fFM4tTltIBc8EynR2PNgT
         riV0zxGAhWFOedFC4OUWeEjDX+84CcOFLe4VGW8tVu1i+zm0M+6kp7Jmqob01MsclF/S
         raD1HretgsRfrvBUXWNeW/MnTKygRsVq0XWjNfykKWswgzldWFP8BBxQoZGniNvtNnLy
         vzBLBOdBk4Gsg/6W/2GmDlQU4GkU/Y0UN7UVcdNCR6JEUY5C+VbK22qm2rlYQW1ArR2T
         xvGX2OXrmVZbZGi6/idCu8Qeo35LGW6dDSsYoppWjhTemoz/RrsUxu89z0ghZF/mPrs6
         WT3g==
X-Gm-Message-State: AAQBX9dONgCZAcANjVAjPxjnJrAJ3uzTjfNdsfIE9VJcQWFGmdxtQIb2
        H3KBovtljvO5uTGFStAWueiarbzspKeLSCNX+Ytf/X5/ShKrh6ZcstBzwbBQ+4aFCmro17TKzd5
        fJRLfTZTmD+J0FD/4JOTWwyjJ
X-Received: by 2002:a05:6214:260f:b0:56b:fb58:c350 with SMTP id gu15-20020a056214260f00b0056bfb58c350mr23964673qvb.26.1679995758201;
        Tue, 28 Mar 2023 02:29:18 -0700 (PDT)
X-Google-Smtp-Source: AKy350YbQdtTvthYdS2lSVNkd7CIQnOjtbLTtQpWx6BoakwOHWkvtaIfcNuo2kDx2/O8wrbZT546kA==
X-Received: by 2002:a05:6214:260f:b0:56b:fb58:c350 with SMTP id gu15-20020a056214260f00b0056bfb58c350mr23964649qvb.26.1679995757971;
        Tue, 28 Mar 2023 02:29:17 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-98.retail.telecomitalia.it. [82.53.134.98])
        by smtp.gmail.com with ESMTPSA id z9-20020a376509000000b0074283b87a4esm10340876qkb.90.2023.03.28.02.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 02:29:17 -0700 (PDT)
Date:   Tue, 28 Mar 2023 11:29:12 +0200
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
Subject: Re: [RFC PATCH v2 2/3] virtio/vsock: WARN_ONCE() for invalid state
 of socket
Message-ID: <lgpswwclsuiukh2q5couf33jytf6abneazmwkty6fevoxcgh5p@3dzfbmenjhco>
References: <728181e9-6b35-0092-3d01-3d7aff4521b6@sberdevices.ru>
 <30aa2604-77c0-322e-44fd-ff99fc25e388@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <30aa2604-77c0-322e-44fd-ff99fc25e388@sberdevices.ru>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 01:09:25AM +0300, Arseniy Krasnov wrote:
>This adds WARN_ONCE() and return from stream dequeue callback when
>socket's queue is empty, but 'rx_bytes' still non-zero.

Nit: I would explain why we add this, for example:

This allows the detection of potential bugs due to packet merging
(see previous patch).

>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/virtio_transport_common.c | 7 +++++++
> 1 file changed, 7 insertions(+)

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index b9144af71553..ad70531de133 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -398,6 +398,13 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 	u32 free_space;
>
> 	spin_lock_bh(&vvs->rx_lock);
>+
>+	if (WARN_ONCE(skb_queue_empty(&vvs->rx_queue) && vvs->rx_bytes,
>+		      "No skbuffs with non-zero 'rx_bytes'\n")) {

Nit: I would rephrase it this way:
"rx_queue is empty, but rx_bytes is non-zero"

>+		spin_unlock_bh(&vvs->rx_lock);
>+		return err;
>+	}
>+
> 	while (total < len && !skb_queue_empty(&vvs->rx_queue)) {
> 		skb = skb_peek(&vvs->rx_queue);
>
>-- 
>2.25.1
>

Anyway the patch LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

