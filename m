Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879406C1B9D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjCTQaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjCTQ34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:29:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E03DBE1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679329261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E4L6DVT+Pk28ITSy1tgi6rl1jBkKGjMU3pOGcr32oZA=;
        b=QzDnX/t1WnOll0LtzVqzK0CIluygmTgQnIBWsUzGr6oPY/YId6bRvU8NUWR2u0ZXfRbmcK
        kzTabNCo/B5Xg8dQTsQ+wjRqGwJvrp3o/qDSpELSgfQt01y9zYR15j82KRO8v9vzLQDFyr
        WRj2oTx0Zy+fy3bLDkQh04jFriGL+Zw=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-0OBdX_jmMKmVBQzU0b6DHw-1; Mon, 20 Mar 2023 12:20:58 -0400
X-MC-Unique: 0OBdX_jmMKmVBQzU0b6DHw-1
Received: by mail-io1-f72.google.com with SMTP id r3-20020a6b5d03000000b007530ad88769so6426261iob.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:20:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679329258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4L6DVT+Pk28ITSy1tgi6rl1jBkKGjMU3pOGcr32oZA=;
        b=vUKdxmWxnZMbJuRsjjYAMTlHfvugXs4aNaKx7fPFpSoJKIqxA0h3Tha/OP0X/di65y
         PSiD1aZZB7OfPtrM6gKhWYxWNK+gwy/DHDJSsNw2XiuUWop6TWOPOIoGFkyvj7zLRGvN
         7WfeLP28dDpMYko75/jVi6yoQ1d+Qjwxut3XF+6tHQnylEwWs3DJJqCTLqpHD96KKLQI
         RyPtwUUc6B0lFTo2jSPFNRX8HRF59gqFYLRuqDMwRojwT555Zqu6XeKZv0wAmC4DVRea
         1hFNPvpSG2Ngcm65s8sF55RH+rb601icH3IU+Ian3hOcVIhGPJCgIpkL2lCUNqRNG68A
         Mz+Q==
X-Gm-Message-State: AO0yUKXYB7ob4PRIj189bFm7ZKt/lXGYyLZSlc/M6Oru5gwFpVG2l+t0
        ckGK5mdgNx+aoWACHX45CuCHGbEMY1TPN8vrkCcrSj7nNfbmfbS5CqxXA2IiNCOHI/Wm0rxCa/M
        4XjsOEAjMWI14XdietGjQuhjd
X-Received: by 2002:a6b:5b10:0:b0:74c:c47e:e338 with SMTP id v16-20020a6b5b10000000b0074cc47ee338mr128171ioh.1.1679329258342;
        Mon, 20 Mar 2023 09:20:58 -0700 (PDT)
X-Google-Smtp-Source: AK7set97GHkYl2layDS31jJOAtlRGfxngf7zDEp2X1/Dqkij6Q0vtlnDp1hQ4qhoR9DYj5Ifg0fn+w==
X-Received: by 2002:a6b:5b10:0:b0:74c:c47e:e338 with SMTP id v16-20020a6b5b10000000b0074cc47ee338mr128146ioh.1.1679329258095;
        Mon, 20 Mar 2023 09:20:58 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id 124-20020a021182000000b00404b939d865sm3373857jaf.147.2023.03.20.09.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 09:20:57 -0700 (PDT)
Date:   Mon, 20 Mar 2023 10:20:56 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Lizhe <sensor1010@163.com>, wintera@linux.ibm.com,
        wenjia@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] net/iucv: Remove redundant driver match function
Message-ID: <20230320102056.1be1fcf7.alex.williamson@redhat.com>
In-Reply-To: <ZBdtn0wFunrkvml9@osiris>
References: <20230319050840.377727-1-sensor1010@163.com>
        <ZBdtn0wFunrkvml9@osiris>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Mar 2023 21:16:31 +0100
Heiko Carstens <hca@linux.ibm.com> wrote:

> On Sun, Mar 19, 2023 at 01:08:40PM +0800, Lizhe wrote:
> > If there is no driver match function, the driver core assumes that each
> > candidate pair (driver, device) matches, see driver_match_device().
> > 
> > Drop the bus's match function that always returned 1 and so
> > implements the same behaviour as when there is no match function  
> ...
> > 
> > Signed-off-by: Lizhe <sensor1010@163.com>
> > ---
> >  net/iucv/iucv.c | 6 ------
> >  1 file changed, 6 deletions(-)  
> ...
> > -static int iucv_bus_match(struct device *dev, struct device_driver *drv)
> > -{
> > -	return 0;  
>         ^^^^^^^^
> 
> If I'm not wrong then 0 != 1.
> 

Seems like an unchecked patch bot, proposed an identical bad patch for
vfio/mdev.  Thanks,

Alex

