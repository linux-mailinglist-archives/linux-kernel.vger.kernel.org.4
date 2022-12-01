Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307F063EC32
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiLAJTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiLAJTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:19:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FAE8325A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 01:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669886303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vIuTEZiHlEaLkOOiRuwwN1u46N3S1zvX6DQsFHhXfNs=;
        b=AfXSWL67snkm4M82sIByiI8ykwg9ZMzvikcMFz99XZMMAzxCIFPqvDljA5aX47/Avl5lRj
        Hla6PSshpZnvubAdRYBUu4b5pq8z0gzzxreqVN0kHn44OE9UINhIijQ5A2OPI0v55DsFQB
        OQKp9exiy8kxN/zPSd5A7jpHAYYkA4A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-169-a-KuZ15SPXylS9GcFH-Lmw-1; Thu, 01 Dec 2022 04:18:17 -0500
X-MC-Unique: a-KuZ15SPXylS9GcFH-Lmw-1
Received: by mail-wm1-f70.google.com with SMTP id bi19-20020a05600c3d9300b003cf9d6c4016so2267218wmb.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 01:18:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIuTEZiHlEaLkOOiRuwwN1u46N3S1zvX6DQsFHhXfNs=;
        b=sn9DH5xFOmOeDNUBqtbOpa54P1mfbu9mN2YHvsFQTpfeF208vBehbsxPTcP9Sqmr58
         PuRZXvTd8LNa1/2OOuo7TvINtqk2U/5cDAlXyreC2NxvKU2Or7WL9bpkgPdPbOUHJ7ye
         o9dk8ZKT/wAhJmZqeidD2g9gueEWtcTwEP2vB3a7zRQSvHmNmvIIcnYGstEgDeaOBsXm
         wqCq1JD6lQ+33HFWpceqzj3Bq+YxIyvg209dGDLe1eiJrrUhMu1C4NdIu2sRz85epImI
         oemPW1NPMgtHOWDTxn5pvt7p9KLP2sLXmpGmW5h/pdrJSJajE+96vEEWSlbkqmvLHJh3
         z7cg==
X-Gm-Message-State: ANoB5pkG4tXYm0dz6v8pokp2FRVOsPfnXTdCqxqO9BkEfB7no2UQONTU
        KZFchr+1AnJtYmzjndbZyC4qqyDCpyWAjrhD+/frhC/HYyTPBynmVawSmyWDTIOYvDN+GQpV9PB
        44dszSFJqlLTNBPSo1AqUDHfw
X-Received: by 2002:a5d:5948:0:b0:241:e929:fc44 with SMTP id e8-20020a5d5948000000b00241e929fc44mr25586481wri.27.1669886296307;
        Thu, 01 Dec 2022 01:18:16 -0800 (PST)
X-Google-Smtp-Source: AA0mqf56QBIAqebrTf81srtx8Wms1KunBwXJwbQrplf/Bwb4UBr5M9FHfw01rhXcxCuBcF+looDkuA==
X-Received: by 2002:a5d:5948:0:b0:241:e929:fc44 with SMTP id e8-20020a5d5948000000b00241e929fc44mr25586457wri.27.1669886296097;
        Thu, 01 Dec 2022 01:18:16 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it. [82.53.134.234])
        by smtp.gmail.com with ESMTPSA id n22-20020a7bc5d6000000b003c6c5a5a651sm4692542wmk.28.2022.12.01.01.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 01:18:15 -0800 (PST)
Date:   Thu, 1 Dec 2022 10:17:22 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     "David S. Miller" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Bryan Tan <bryantan@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>,
        Krasnov Arseniy <oxffffaa@gmail.com>,
        Bobby Eshleman <bobby.eshleman@gmail.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [RFC PATCH v2 1/6] vsock: return errors other than -ENOMEM to
 socket
Message-ID: <20221201091722.p7fth4vkbbpq2zx4@sgarzare-redhat>
References: <9d96f6c6-1d4f-8197-b3bc-8957124c8933@sberdevices.ru>
 <84f44358-dd8b-de8f-b782-7b6f03e0a759@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <84f44358-dd8b-de8f-b782-7b6f03e0a759@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 05:03:06PM +0000, Arseniy Krasnov wrote:
>From: Bobby Eshleman <bobby.eshleman@bytedance.com>
>
>This removes behaviour, where error code returned from any
>transport was always switched to ENOMEM.
>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/af_vsock.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

This patch LGTM, but I would move after the 2 patches that change vmci 
and hyperv transports.

First we should fix the transports by returning the error we think is 
right, and then expose it to the user.

Thanks,
Stefano

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 884eca7f6743..61ddab664c33 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1862,8 +1862,9 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
> 			written = transport->stream_enqueue(vsk,
> 					msg, len - total_written);
> 		}
>+
> 		if (written < 0) {
>-			err = -ENOMEM;
>+			err = written;
> 			goto out_err;
> 		}
>
>-- 
>2.25.1

