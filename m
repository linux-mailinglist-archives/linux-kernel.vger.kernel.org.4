Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4BC5EFA71
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236247AbiI2Q1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235373AbiI2Q0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:26:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C2F7969B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 09:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664468722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wP+ERui3HiyMQ5txVX6VKAqSsbRuHdNYsyw/tUJPBgg=;
        b=AHanH7k7Vcw7WU8JZm1cyPESs0Q90jD80nFzx6IBZT0butQU9fUuQ5aDKwR0y7TXclTWYL
        CqDtYwIJ3u4iQboQcsG95euefjQDzeexiAJ87uwXLEPGlvocIRaRCUj3CoXg+414ocgdLa
        oXls4ohpBuboNDBEq72s3E3YQIEPHxU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-582-uNb1MhfCPWuNc6MiOEOD8A-1; Thu, 29 Sep 2022 12:25:20 -0400
X-MC-Unique: uNb1MhfCPWuNc6MiOEOD8A-1
Received: by mail-wr1-f70.google.com with SMTP id l12-20020adfa38c000000b0022cceed465dso725598wrb.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 09:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=wP+ERui3HiyMQ5txVX6VKAqSsbRuHdNYsyw/tUJPBgg=;
        b=gRjb+Vfl+3rk/4+Exozw1TRdZABooVHbMYLs/8nA1+qfCH9cKqtgXXR1mghcEdRnAU
         P18e1/aUp+CvNn108nyKgxX/wkgjJgtj6wsrxM8rYcCvpWZ7/m9hSiPCK81xpaXyxmgh
         TJ9ZvZHR6XNKHNe9fyM0Hz+BFXSG6+RzVm3YRYV3t2u5vvOsm3+wToXLMQ3JR8nUM9Ar
         a1pgfOhz/r5iPuRAJ/6BCKY5NihboNpzhgIxiMv/ZwQi165oKp/nzpYQIiwHdjAQmVzx
         egzf14/0f4Zp/KDUsrps5tu4LtFeBwQe1tQ3yo/g1FipnBaBbnnenNXKJl0vuoaTOQ3Y
         /hMw==
X-Gm-Message-State: ACrzQf1lyqnNmnSUtQCUNBy3MxJEF/if00DA7xbIaTDptRQk1Apaanez
        ETEbWgYe07NXgXJ2tJDhdizaNgbl9953daclQNvVuKRMJn7uglXoq0CZym3fibisFFiRpTQ/Saj
        lvZkjJJEjpMOLLA1MwRaV2+Pn
X-Received: by 2002:a05:600c:3205:b0:3b3:3813:ae3f with SMTP id r5-20020a05600c320500b003b33813ae3fmr3196826wmp.158.1664468719680;
        Thu, 29 Sep 2022 09:25:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7GXSxx1LBarzR7zq6U/e87GpBhC/rEY4V4sODPzyAV8maunzFx+24hSqCxT0BLh73br06cHw==
X-Received: by 2002:a05:600c:3205:b0:3b3:3813:ae3f with SMTP id r5-20020a05600c320500b003b33813ae3fmr3196805wmp.158.1664468719486;
        Thu, 29 Sep 2022 09:25:19 -0700 (PDT)
Received: from redhat.com ([2.55.17.78])
        by smtp.gmail.com with ESMTPSA id t18-20020adfe452000000b00228cd9f6349sm7243877wrm.106.2022.09.29.09.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 09:25:18 -0700 (PDT)
Date:   Thu, 29 Sep 2022 12:25:14 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Stefano Garzarella <sgarzare@redhat.com>,
        Junichi Uekawa =?utf-8?B?KCDkuIrlt53ntJTkuIAp?= 
        <uekawa@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
        netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
        kvm@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        linux-kernel@vger.kernel.org,
        Bobby Eshleman <bobby.eshleman@gmail.com>
Subject: Re: [PATCH] vhost/vsock: Use kvmalloc/kvfree for larger packets.
Message-ID: <20220929122444-mutt-send-email-mst@kernel.org>
References: <20220928064538.667678-1-uekawa@chromium.org>
 <20220928082823.wyxplop5wtpuurwo@sgarzare-redhat>
 <20220928052738-mutt-send-email-mst@kernel.org>
 <20220928151135.pvrlsylg6j3hzh74@sgarzare-redhat>
 <CADgJSGHxPWXJjbakEeWnqF42A03yK7Dpw6U1SKNLhk+B248Ymg@mail.gmail.com>
 <20220929031419-mutt-send-email-mst@kernel.org>
 <20220929074606.yqzihpcc7cl442c5@sgarzare-redhat>
 <20220929034807-mutt-send-email-mst@kernel.org>
 <20220929090731.27cda58c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929090731.27cda58c@kernel.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 09:07:31AM -0700, Jakub Kicinski wrote:
> On Thu, 29 Sep 2022 03:49:18 -0400 Michael S. Tsirkin wrote:
> > net tree would be preferable, my pull for this release is kind of ready ... kuba?
> 
> If we're talking about 6.1 - we can take it, no problem.

I think they want it in 6.0 as it fixes a crash.

