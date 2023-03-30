Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8C16CFDAE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjC3IER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjC3IEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:04:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0117E6A54
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680163386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BmvkK8fYK4TJ5NfFumKVdlTRthgnv0I/fv0iMmHm2zA=;
        b=ASBY2Ca1P59Kk+DdbsVggqkapbHbMPf47kJHIEbOLOQzXPjm8FcX7JiKFaMO3nlyOt8WML
        EGCnUdxpg1KoNVeg8DLa0/9fLSdFy4dFzfxptlqzJYjCtXe67QwrQhVuothNgtSBSjvN+G
        EAL4Guz3h3jY8IYFxlkd0D8LyMOYHoY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-o3YimaWvPw6KPO48rEwK9A-1; Thu, 30 Mar 2023 04:03:03 -0400
X-MC-Unique: o3YimaWvPw6KPO48rEwK9A-1
Received: by mail-qt1-f198.google.com with SMTP id b11-20020ac87fcb000000b003e37d72d532so11880624qtk.18
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680163383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmvkK8fYK4TJ5NfFumKVdlTRthgnv0I/fv0iMmHm2zA=;
        b=D50XruEmixQy4ObzCf2g0JzdzRtvIQFUvwQL2wi2bqQlwk+sa2XbkF2qDaPWhgYZRj
         +W46mJf7R1WFK+XenSqcPrM3Y7pAAPRFmxKSDflONOFCF03tCnQqWskEYzQNYY4m9PR8
         spqyE/LJ38+gmiMpWtf9WaRr8DFZ2CpsanaSuN1mnKO76vClalyducIadTVcAQqTJpsC
         1+gMslhVIBcHyuSPRpWwICG/3fMFUcgQrGphOiJjpbRHlVYKGt5CNWA98dFBaXIOm2AH
         XJvPEPxpHJ/rcAoyFXky21Cub2SGhe01DhM7/YTWnheSy0moId8KXSDHyZ7k9cmdZTUc
         k7iA==
X-Gm-Message-State: AAQBX9dxZ4k6p4l5aRLD1WNNuo0rsZm+IyJlJ0QyhDNy797VI0PBcjMl
        ci0xhwJi/k3+vvf+Irt0RINwzkC/96cMNlQlu/zR2MlRkKQdEsUMtxF4y7CBGo9nV1mzJwgmc01
        /syq037vBuv55OxDqkUbYfbwt
X-Received: by 2002:ad4:5dcd:0:b0:5a9:c0a1:d31a with SMTP id m13-20020ad45dcd000000b005a9c0a1d31amr32511904qvh.49.1680163383481;
        Thu, 30 Mar 2023 01:03:03 -0700 (PDT)
X-Google-Smtp-Source: AKy350b/24uAmv6SuUb1n6/2cdmqOMqi4TQbiOPJWGZJaeeZPx69yK8YzSEPOHSxImFh4Y41wpxtEg==
X-Received: by 2002:ad4:5dcd:0:b0:5a9:c0a1:d31a with SMTP id m13-20020ad45dcd000000b005a9c0a1d31amr32511878qvh.49.1680163383217;
        Thu, 30 Mar 2023 01:03:03 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-130.retail.telecomitalia.it. [82.57.51.130])
        by smtp.gmail.com with ESMTPSA id mh2-20020a056214564200b005dd8b934582sm5197140qvb.26.2023.03.30.01.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 01:03:02 -0700 (PDT)
Date:   Thu, 30 Mar 2023 10:02:57 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        Bryan Tan <bryantan@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@sberdevices.ru,
        oxffffaa@gmail.com, pv-drivers@vmware.com
Subject: Re: [RFC PATCH v2 1/3] vsock: return errors other than -ENOMEM to
 socket
Message-ID: <p64mv3f2ujn4uokl5i7abhdbmed3zy2lrozqoam3llcf4r2qkv@gmyoyikbyiwj>
References: <60abc0da-0412-6e25-eeb0-8e32e3ec21e7@sberdevices.ru>
 <b910764f-a193-e684-a762-f941883a0745@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b910764f-a193-e684-a762-f941883a0745@sberdevices.ru>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 10:05:45AM +0300, Arseniy Krasnov wrote:
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

We should first make sure that all transports return the right value,
and then expose it to the user, so I would move this patch, after
patch 2.

Thanks,
Stefano

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 5f2dda35c980..413407bb646c 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -2043,7 +2043,7 @@ static int __vsock_stream_recvmsg(struct sock *sk, struct msghdr *msg,
>
> 		read = transport->stream_dequeue(vsk, msg, len - copied, flags);
> 		if (read < 0) {
>-			err = -ENOMEM;
>+			err = read;
> 			break;
> 		}
>
>@@ -2094,7 +2094,7 @@ static int __vsock_seqpacket_recvmsg(struct sock *sk, struct msghdr *msg,
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

