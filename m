Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7916C025A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 15:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjCSOTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 10:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjCSOS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 10:18:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09741ACD9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 07:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679235493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6aFNRO2JT6HAWO7tCApABxmO5PTROa8NFsgv1LNIMDU=;
        b=HYMeXDK+hywSVGOzPfjtuUDOnsYKa+juZB+Agp+W536jO9C3wo+fHSTxTfQoxsE3a/tCt7
        hKhfcFWP08ekscOUMCiVDJB5kZuasCWVh1krg0dYjBeb1E5r+Zj17wOJlkBzE7hhnP3zzd
        61eS1ZdtJwZe66UqdhfYnOwR5UZRVTI=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-ScpGSZ8FP6CfiCZkaxCNEQ-1; Sun, 19 Mar 2023 10:18:08 -0400
X-MC-Unique: ScpGSZ8FP6CfiCZkaxCNEQ-1
Received: by mail-io1-f71.google.com with SMTP id t15-20020a5d848f000000b00750c83214cbso4844635iom.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 07:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679235487;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6aFNRO2JT6HAWO7tCApABxmO5PTROa8NFsgv1LNIMDU=;
        b=5eXhgo0nzjzc5JAK/KJq+HhH6AJ5y8vtc+sjw4xIPR/VKcYEQ3uz0+1fCycYfRF0g8
         fiFukVH1sAwocBJ3wEUxkYPIGth3b1TzGIlMW+xUJdf81rSeU5DposO0ti8FpYaLNfdf
         Dk25KQX2DnLR3lRIQe6k4Ws+3vcF7Nd03JvkZrU/FF5cphzVLHFCLQzB/aBpDIU3GSRK
         6yrfrnKFWPKLaFBR2LbT0nZ5fESYIIJjrqjxZazV9l91CMT/7lpfGECd/sKt9x+VcHXi
         j5LMCtE+E+JBPJhK1xLRRr7iy6teCrzGJ928VGF2tmuMCT9KqzfkZ3hwfKqA6mhax4mW
         NRkQ==
X-Gm-Message-State: AO0yUKXVEW6NNVdjuHqzEVHP/olTsyllLUQF+8clQCPwCJXyoDfaCmsQ
        YQxOMDdi1sba1UX0j+9ZOP52VqJ9TrlCDZ2Z43aEUj0PwKFp674l4GmtCcfPS/IhQJdcvRRLCCx
        rhnS8GdACF48ZuqXteA/Bj7Zca2yo9cHF
X-Received: by 2002:a5e:a60c:0:b0:753:42d:25ec with SMTP id q12-20020a5ea60c000000b00753042d25ecmr2756564ioi.20.1679235487358;
        Sun, 19 Mar 2023 07:18:07 -0700 (PDT)
X-Google-Smtp-Source: AK7set8vXhp+C5HN6FcO/dlNnK7JU9SNlPq1VXxLva12OLzXK/lnt/uPEDGwqX1OpgZ0JRScOscdvA==
X-Received: by 2002:a5e:a60c:0:b0:753:42d:25ec with SMTP id q12-20020a5ea60c000000b00753042d25ecmr2756558ioi.20.1679235487070;
        Sun, 19 Mar 2023 07:18:07 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id w4-20020a6b4a04000000b0073fe9d412fasm2115727iob.33.2023.03.19.07.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 07:18:06 -0700 (PDT)
Date:   Sun, 19 Mar 2023 08:18:05 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Lizhe <sensor1010@163.com>
Cc:     kwankhede@nvidia.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] vfio/mdev: Remove redundant driver match function
Message-ID: <20230319081805.487b1fd6.alex.williamson@redhat.com>
In-Reply-To: <20230319050130.360515-1-sensor1010@163.com>
References: <20230319050130.360515-1-sensor1010@163.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Mar 2023 13:01:30 +0800
Lizhe <sensor1010@163.com> wrote:

> If there is no driver match function, the driver core assumes that each
> candidate pair (driver, device) matches, see driver_match_device().
> 
> Drop the bus's match function that always returned 1 and so
> implements the same behaviour as when there is no match function.

The removed function returns 0, not 1, so this is replacing the
functionality with something that does exactly the opposite of the
current behavior.  Please explain.  Thanks,

Alex
 
> Signed-off-by: Lizhe <sensor1010@163.com>
> ---
>  drivers/vfio/mdev/mdev_driver.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/vfio/mdev/mdev_driver.c b/drivers/vfio/mdev/mdev_driver.c
> index 7825d83a55f8..fafa4416aad9 100644
> --- a/drivers/vfio/mdev/mdev_driver.c
> +++ b/drivers/vfio/mdev/mdev_driver.c
> @@ -31,20 +31,10 @@ static void mdev_remove(struct device *dev)
>  		drv->remove(to_mdev_device(dev));
>  }
>  
> -static int mdev_match(struct device *dev, struct device_driver *drv)
> -{
> -	/*
> -	 * No drivers automatically match. Drivers are only bound by explicit
> -	 * device_driver_attach()
> -	 */
> -	return 0;
> -}
> -
>  struct bus_type mdev_bus_type = {
>  	.name		= "mdev",
>  	.probe		= mdev_probe,
>  	.remove		= mdev_remove,
> -	.match		= mdev_match,
>  };
>  
>  /**

