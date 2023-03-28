Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F186C6CBB46
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjC1Jkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjC1Jkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:40:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A459610CA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679996384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SwPWb91WcUx6K1IICpQUovViuiJcsfmj59FF6gVXRXI=;
        b=AkiCWCRHUo+WggOBsd0IrS34XFABPTg5EpxpJEuJfmhxLX19Kst96uRbylnxVDR1j+cVFu
        HjKzMXqboxUUOrw3uObtQ844IJnz53cKoenifrnxMDVbwrxzf4oNX/reOw+OzfrYl5UEjo
        nQAeQdQdmdzr6pPxnPDpPVQ37NRg7EQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-v4TARQU_N3yRIRgoF0YXow-1; Tue, 28 Mar 2023 05:39:41 -0400
X-MC-Unique: v4TARQU_N3yRIRgoF0YXow-1
Received: by mail-qk1-f198.google.com with SMTP id 72-20020a37064b000000b007467c5d3abeso5339082qkg.19
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679996381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwPWb91WcUx6K1IICpQUovViuiJcsfmj59FF6gVXRXI=;
        b=xMQZMfMHbRu3kW5m3Mb66rPYK1inZ2nYpPG3hpmDhIbNG7gjtYAyeZfZNnSUB3Ry8u
         lyX/LMFpguTPEVTSJ+fcrdXtgXFM7tgXcoaPVtW0pJyvoy2J+nCVda9Ze4YfAVAdRV+b
         egVn6itXBKzs1Aa/dbjLm5JzVq7GMEq3KEatx6gAqL/dnJhqw/9DMpon20BOW4ePXCxw
         mc5y0rlFsRBgf/C8FdmAJltgmBzWkwotIeDcoMwHbUG3Eenx0I919rFpXUdvV8+vIcBd
         +HVdumRhtUzRLZued4u3JGmxR6H0jPyOheMKFYxDuYVPD62xmkrVij335PATUulOAdK8
         /OXg==
X-Gm-Message-State: AAQBX9f8n8k7Y/AzO8PDiKI8wlvzUHwCIluKzeqLABKzJFnaHlUnjMYk
        QrmWs6ntb75CGNDpzmZfRgLnWBPkD8wOqWxQcnc8/AetdSJVLhjvKs1az+FJ1shrOCM6W999uNk
        +AztiJ5VXe15k02JKGa3KbaVL
X-Received: by 2002:a05:6214:518b:b0:5bb:eefc:1623 with SMTP id kl11-20020a056214518b00b005bbeefc1623mr21401851qvb.42.1679996381318;
        Tue, 28 Mar 2023 02:39:41 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZvqOhRxjuWkb/qDRFEYG95lVTMqkyN1lH2NCL72/Gi430kGp8+0vpnXNL4RhABqLUioJi5lA==
X-Received: by 2002:a05:6214:518b:b0:5bb:eefc:1623 with SMTP id kl11-20020a056214518b00b005bbeefc1623mr21401832qvb.42.1679996381014;
        Tue, 28 Mar 2023 02:39:41 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-98.retail.telecomitalia.it. [82.53.134.98])
        by smtp.gmail.com with ESMTPSA id pe6-20020a056214494600b005dd8b9345a4sm3590288qvb.60.2023.03.28.02.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 02:39:40 -0700 (PDT)
Date:   Tue, 28 Mar 2023 11:39:35 +0200
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
Subject: Re: [RFC PATCH v1 1/2] vsock: return errors other than -ENOMEM to
 socket
Message-ID: <itjmw7vh3a7ggbodsu4mksu2hqbpdpxmu6cpexbra66nfhsw4x@hzpuzwldkfx5>
References: <97f19214-ba04-c47e-7486-72e8aa16c690@sberdevices.ru>
 <99da938b-3e67-150c-2f74-41d917a95950@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <99da938b-3e67-150c-2f74-41d917a95950@sberdevices.ru>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 01:13:11AM +0300, Arseniy Krasnov wrote:
>This removes behaviour, where error code returned from any transport
>was always switched to ENOMEM. This works in the same way as:
>commit
>c43170b7e157 ("vsock: return errors other than -ENOMEM to socket"),
>but for receive calls.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/af_vsock.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 19aea7cba26e..9262e0b77d47 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -2007,7 +2007,7 @@ static int __vsock_stream_recvmsg(struct sock *sk, struct msghdr *msg,
>
> 		read = transport->stream_dequeue(vsk, msg, len - copied, flags);

In vmci_transport_stream_dequeue() vmci_qpair_peekv() and
vmci_qpair_dequev() return VMCI_ERROR_* in case of errors.

Maybe we should return -ENOMEM in vmci_transport_stream_dequeue() if
those functions fail to keep the same behavior.

CCing Bryan, Vishnu, and pv-drivers@vmware.com

The other transports seem okay to me.

Thanks,
Stefano

> 		if (read < 0) {
>-			err = -ENOMEM;
>+			err = read;
> 			break;
> 		}
>
>@@ -2058,7 +2058,7 @@ static int __vsock_seqpacket_recvmsg(struct sock *sk, struct msghdr *msg,
> 	msg_len = transport->seqpacket_dequeue(vsk, msg, flags);
>
> 	if (msg_len < 0) {
>-		err = -ENOMEM;
>+		err = msg_len;
> 		goto out;
> 	}
>
>-- 
>2.25.1
>

