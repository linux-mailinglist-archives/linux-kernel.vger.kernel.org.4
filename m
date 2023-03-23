Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427416C65A9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 11:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjCWKuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 06:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjCWKuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:50:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CACF213B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 03:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679568485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eZmXocTVKetihT0r8O5N7xAJurjCNliQJkGA8ddiit8=;
        b=IaoLuc2YuTbRMc6E2O11R0Z9fZMfOco19OD7dxBcVtQyLCHbxeW1QVmpzyHBntE/EYjWpj
        45iJQAFbbvESrY3EsVqJ45zEe7epyfT7Jm7aGnWZDx6iZR2baPiPuLBHvLsULJpp/vuSAi
        oALl5rwpOHgTIMcBwtijItmuJo0VNJs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-pUVTHLPjNcKYGyLaLod-pA-1; Thu, 23 Mar 2023 06:48:04 -0400
X-MC-Unique: pUVTHLPjNcKYGyLaLod-pA-1
Received: by mail-wr1-f72.google.com with SMTP id j17-20020adfb311000000b002d660153278so1388755wrd.20
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 03:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679568483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZmXocTVKetihT0r8O5N7xAJurjCNliQJkGA8ddiit8=;
        b=GY9pb5gcY0lxubdamQ1pkU+ZEM5NY7d4wBCY5LZjFcBvqFRlpMPWK5qTtEEeS4QTvy
         xvlKleCCmHNrhoSVv76Z1D1HQNOoQJPZYNkotBXZJB6ZWnubdCOiLtmXWq/G/lvTmJPg
         BXIU31X5Ge6ql6Cwv50LOdbIFFi6V8TuhziaiOHfwwBEQ/FsfwFeATn3bIFseTU+ZaT3
         5mozzk6tFo7EOmjeIdpYBP9eS4hvj7bOQZ8kGHIStgXjUFmWg3U1CSY/epp9fOclxAD0
         Q1OjqmqPafO2fIMoCMP08VSpAqSoPCxp2zxXs+n4QrAg2/PqCG+Qqh5XsMXe5m3iiwPm
         rr1g==
X-Gm-Message-State: AO0yUKX4ECP46UNkpctLwrfcXhFve5/wdG/Viyn5EfxuOvFYziDbMr6p
        CrcfBuWf8vfKsxtyf4HFr8MrXXhLo3ReUvDbhMuLDRqEJPPu5sKh6GkQETV9qDoANF6PmPI6MYV
        7IKnz50pD1LKkexn0RukXq5yo
X-Received: by 2002:a1c:7310:0:b0:3ed:3522:689a with SMTP id d16-20020a1c7310000000b003ed3522689amr2020096wmb.7.1679568483452;
        Thu, 23 Mar 2023 03:48:03 -0700 (PDT)
X-Google-Smtp-Source: AK7set8bEI0jSdYbR5gbAZvyCtCLmXwY6ExIXLcczwR1j7zd0riDw0ijO9qGw68PRNC9fckrcMieyQ==
X-Received: by 2002:a1c:7310:0:b0:3ed:3522:689a with SMTP id d16-20020a1c7310000000b003ed3522689amr2020075wmb.7.1679568483209;
        Thu, 23 Mar 2023 03:48:03 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-98.retail.telecomitalia.it. [82.53.134.98])
        by smtp.gmail.com with ESMTPSA id u13-20020adfdb8d000000b002d2b117a6a6sm15874355wri.41.2023.03.23.03.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 03:48:02 -0700 (PDT)
Date:   Thu, 23 Mar 2023 11:48:00 +0100
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
Subject: Re: [RFC PATCH v5 0/2] allocate multiple skbuffs on tx
Message-ID: <20230323104800.odrkkiuxi3o2l37q@sgarzare-redhat>
References: <f0b283a1-cc63-dc3d-cc0c-0da7f684d4d2@sberdevices.ru>
 <2e06387d-036b-dde2-5ddc-734c65a2f50d@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2e06387d-036b-dde2-5ddc-734c65a2f50d@sberdevices.ru>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 01:01:40PM +0300, Arseniy Krasnov wrote:
>Hello Stefano,
>
>thanks for review!

You're welcome!

>
>Since both patches are R-b, i can wait for a few days, then send this
>as 'net-next'?

Yep, maybe even this series could have been directly without RFC ;-)

Thanks,
Stefano

