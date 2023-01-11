Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8F066560D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 09:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjAKI1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 03:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238055AbjAKI1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 03:27:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710A9658E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 00:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673425520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z9BqbleyIskxpRXIgDkvfJFpA17h9Qu7BSswmKTjpxs=;
        b=Vp011uveWAFidbpxSQeikU0aUoLMQDXzeHzV9YnDW10AFzZnYisWLkZCAkHFsyTQ2BKb7I
        X08wKZtGA4zSb5bMM8AwzaUiQ6eFSagl+06OLST1hyi5ZEmBhWHU4gNSGQdqlNfZqKEn+a
        vhqRB04VUqPK/ER2V4qgD/62H1D2mek=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-150-sJyZqrNgOx2xgTKau7XgYQ-1; Wed, 11 Jan 2023 03:25:19 -0500
X-MC-Unique: sJyZqrNgOx2xgTKau7XgYQ-1
Received: by mail-qk1-f199.google.com with SMTP id bk24-20020a05620a1a1800b006ffcdd05756so10596191qkb.22
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 00:25:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9BqbleyIskxpRXIgDkvfJFpA17h9Qu7BSswmKTjpxs=;
        b=79brLWLocIMw5aAiJIB2KjdzaCNAnkOpqQcKHfv4frfNYRpT038ChZB10LY6zqU5fp
         GWoeRlHwpCBBqfkY9mlxeuGESvg3fweE40PbyV418K6bNI9WYG7uu9lkEQRs7Crse01t
         KFXmvRZac9fR4G/KInlde+Kk9tMG9AHmRtRwdpCEeJV/izlMaDm5cRHU0WgBv0woIz2+
         OAiUPlqEqMIXEtHyFQz8kb4t9TelXOKuWqqwBhen2iYH9KWukp66tGle0JzcjskLD/B2
         PMtSi0VtwSTMQYSeBSSA4KAlWhTiXDetY+MP6VnWQ3QBEj1Buz6jl571chWSsO1zjivj
         8Smg==
X-Gm-Message-State: AFqh2kpTkDKZeUhG4jP993yDQpvjrlm41hLxsVL6FR9Y2qt3A0RCu50v
        zxFyOVQCrOgq7fuSlZ48y8JmdAtDB47MkfCpAjJ1zPYFMSbEy/9Srp0q8gvkAmevqQH7wjeCJri
        5ITAxjbS8vu9Xvpb3XCmqyIo5
X-Received: by 2002:ac8:6f19:0:b0:3a9:84bd:7cc5 with SMTP id bs25-20020ac86f19000000b003a984bd7cc5mr109481134qtb.39.1673425518776;
        Wed, 11 Jan 2023 00:25:18 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvypWklvz3km9uYoBB0qv32xq21YlcTjpjh3KzgK6avNFjv4jYlLRNPx/BLDFKbo966A5oWEQ==
X-Received: by 2002:ac8:6f19:0:b0:3a9:84bd:7cc5 with SMTP id bs25-20020ac86f19000000b003a984bd7cc5mr109481108qtb.39.1673425518406;
        Wed, 11 Jan 2023 00:25:18 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-244.retail.telecomitalia.it. [79.46.200.244])
        by smtp.gmail.com with ESMTPSA id c8-20020ac86608000000b003a4f435e381sm7226084qtp.18.2023.01.11.00.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 00:25:17 -0800 (PST)
Date:   Wed, 11 Jan 2023 09:25:13 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     liming.wu@jaguarmicro.com
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, 398776277@qq.com
Subject: Re: [PATCH] vhost: remove unused paramete
Message-ID: <20230111082513.weu6go5k2nyfvkjh@sgarzare-redhat>
References: <20230110024445.303-1-liming.wu@jaguarmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230110024445.303-1-liming.wu@jaguarmicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 10:44:45AM +0800, liming.wu@jaguarmicro.com wrote:
>From: Liming Wu <liming.wu@jaguarmicro.com>
>
>"enabled" is defined in vhost_init_device_iotlb,
>but it is never used. Let's remove it.
>
>Signed-off-by: Liming Wu <liming.wu@jaguarmicro.com>
>---
> drivers/vhost/net.c   | 2 +-
> drivers/vhost/vhost.c | 2 +-
> drivers/vhost/vhost.h | 2 +-
> drivers/vhost/vsock.c | 2 +-
> 4 files changed, 4 insertions(+), 4 deletions(-)

Little typo in the title s/paramete/parameter.

A part of that, the patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

