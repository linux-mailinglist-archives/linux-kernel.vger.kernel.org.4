Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB856995FE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjBPNlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjBPNlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:41:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABDE474D5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 05:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676554845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y98TLzC7T3MjlRAfco0hk5x9PJvmulya2RupI5c7FMk=;
        b=IBJcg2OT2zY/8BdsyqyR5rGYAMbv1H7TalSG0ax3sIGv+mHtubMiXm9Tlpb0lj07k8/kEO
        rp+wkyoWPSf9MWbEZHh3gYt7+pL1yGodAACs5Mdlp7NvBso8zG4r9XfpmGOw0fVlqohzwu
        3aUX0wwG/bEfh6YifuA1/4nv7pQr13E=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-652-Uwn3kE2aO9mzLekQcZgC6g-1; Thu, 16 Feb 2023 08:40:44 -0500
X-MC-Unique: Uwn3kE2aO9mzLekQcZgC6g-1
Received: by mail-qv1-f70.google.com with SMTP id i7-20020a056214020700b004ffce246a2bso1087512qvt.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 05:40:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y98TLzC7T3MjlRAfco0hk5x9PJvmulya2RupI5c7FMk=;
        b=7wYScND/Ns+EXONDffUQcnHiaK9d0segDBdIy1uirjbmlve/YzAXGMLMDJZYBFJbFK
         TgYvZQGM8JaL9bBi9IWXY1ZTKrXH7MsjpwOZ5MRwFB66uJzUcby09gbDH2NrduQEPyfI
         qLdfgvuuQUNiE/Aud/fhWZ+ysOzIo1kp3kQ0hof+0vAqqHbgnw4RkW5aFuzGKB9G88Us
         10xk4V+8FoDeEcftq4DY0kYWBMrjIXdZahcI++E6HAPItKiC7jMMFQ1KCaNFpru2+b4Y
         EDrEDF6QCrCwSpu2quKS2a2Ka47hHAhiP8YyD0skbyjRsoO1sZg9gzP2wFJXWgssY0fY
         CSIQ==
X-Gm-Message-State: AO0yUKUWIxBizhVZTL9awMDW9GfffWQs7yt+iGKb+PamLZ8cChGEFx3e
        EIYQg60ripvh0heHoiP4vO/yJmTAf1AxnKv5qHk72oqY3sufrg1gZC0aKlhMNabAxW05GmbPK7O
        33ACxHewUxMzifEmk754yyTQi
X-Received: by 2002:ac8:5c8a:0:b0:3b6:36a0:adbe with SMTP id r10-20020ac85c8a000000b003b636a0adbemr9858801qta.6.1676554844468;
        Thu, 16 Feb 2023 05:40:44 -0800 (PST)
X-Google-Smtp-Source: AK7set+u2XfrViYGYBUOAnQ+C6klosItAnWhnmgPEyZDck8HDSLvs4kyoFZDdTEvpoeeeF5P7hlYrA==
X-Received: by 2002:ac8:5c8a:0:b0:3b6:36a0:adbe with SMTP id r10-20020ac85c8a000000b003b636a0adbemr9858769qta.6.1676554844177;
        Thu, 16 Feb 2023 05:40:44 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-167.retail.telecomitalia.it. [82.57.51.167])
        by smtp.gmail.com with ESMTPSA id z143-20020a376595000000b0073ba211e765sm228285qkb.19.2023.02.16.05.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 05:40:43 -0800 (PST)
Date:   Thu, 16 Feb 2023 14:40:39 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krasnov Arseniy <oxffffaa@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [RFC PATCH v1 01/12] vsock: check error queue to set EPOLLERR
Message-ID: <20230216134039.rgnb2hnzgme2ve76@sgarzare-redhat>
References: <0e7c6fc4-b4a6-a27b-36e9-359597bba2b5@sberdevices.ru>
 <17a276d3-1112-3431-2a33-c17f3da67470@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <17a276d3-1112-3431-2a33-c17f3da67470@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 06:53:22AM +0000, Arseniy Krasnov wrote:
>If socket's error queue is not empty, EPOLLERR must be set.

Could this patch go regardless of this series?

Can you explain (even in the commit message) what happens without this
patch?

Thanks,
Stefano

>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/af_vsock.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 19aea7cba26e..b5e51ef4a74c 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1026,7 +1026,7 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
> 	poll_wait(file, sk_sleep(sk), wait);
> 	mask = 0;
>
>-	if (sk->sk_err)
>+	if (sk->sk_err || !skb_queue_empty_lockless(&sk->sk_error_queue))
> 		/* Signify that there has been an error on this socket. */
> 		mask |= EPOLLERR;
>
>-- 
>2.25.1

