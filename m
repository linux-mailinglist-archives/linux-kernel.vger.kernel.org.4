Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5F9642A00
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 15:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbiLEOAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 09:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiLEOAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 09:00:44 -0500
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BFE101D5
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 06:00:44 -0800 (PST)
Received: by mail-qv1-f45.google.com with SMTP id r15so8217624qvm.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 06:00:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2HeP4Gq9iePUAAwN/nwhoe/kXwXOTGiK8aWNG/ekMY8=;
        b=ZpNx3/0IR9ZB5F7pWtQ6Pz/mThsqu3/h8VfUVfgrtadf6Mn/lrqiz/as8Ue+h5BBrF
         3E7NP13PqJln+OoD0i+Sd/6Qut1wvgMMFnlgyGVPwM/AogRpB7ddBdnvtfsOoAzrcPi8
         fZS93/Od5HpixHOexJnWIRN5u11ylefVieKqlad8woMdwhcQt2VJnRKIzHYXbdQtEFB9
         1AR8k0Y+do0IHlNyUqQ0kCAQb9QeaezdgZFyyWDEdT7Ol872EZDbFbQnlLUqochfvbFH
         uYXT78G4ObaXEZBfFD20X7f9UfcOnjel0wYn9gfgJ8D+0qQVy7D0eG5EIqXwYCDlAlFD
         Ne4g==
X-Gm-Message-State: ANoB5plalJlPiRYwWM06L9NFQ7U9rfGRoLnagbxrljFH001RTB7YMedV
        JCq8r2sVP/zxHQ1qr6JysKmGd4lUrPSb/BIW5ag=
X-Google-Smtp-Source: AA0mqf5Dlz0sdL86dkpmSQ1SlPvj0kk6E/Yc2eEVNBUeNHOdoIDtRGZaTN3BY3gMZSk29L9uX7DDdA4rfY+twohO6tY=
X-Received: by 2002:a0c:c589:0:b0:4b1:a9ac:21de with SMTP id
 a9-20020a0cc589000000b004b1a9ac21demr57261682qvj.119.1670248843231; Mon, 05
 Dec 2022 06:00:43 -0800 (PST)
MIME-Version: 1.0
References: <20221205121206.166576-1-gregkh@linuxfoundation.org> <20221205121206.166576-2-gregkh@linuxfoundation.org>
In-Reply-To: <20221205121206.166576-2-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 5 Dec 2022 15:00:28 +0100
Message-ID: <CAJZ5v0iFsYFw=aY6cc+0y0M8TApC5YphUr_XpxUP_PBc2tZb1g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] device.h: move kobj_to_dev() to use container_of_const()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 5, 2022 at 1:12 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Instead of rolling our own const-checking logic, use the newly
> introduced container_of_const() to handle it all for us automatically.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
> v2: - respin with changed container_of_const() parameters
>
>  include/linux/device.h | 21 +--------------------
>  1 file changed, 1 insertion(+), 20 deletions(-)
>
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 84ae52de6746..8d172d06b8c1 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -680,26 +680,7 @@ struct device_link {
>         bool supplier_preactivated; /* Owned by consumer probe. */
>  };
>
> -static inline struct device *__kobj_to_dev(struct kobject *kobj)
> -{
> -       return container_of(kobj, struct device, kobj);
> -}
> -
> -static inline const struct device *__kobj_to_dev_const(const struct kobject *kobj)
> -{
> -       return container_of(kobj, const struct device, kobj);
> -}
> -
> -/*
> - * container_of() will happily take a const * and spit back a non-const * as it
> - * is just doing pointer math.  But we want to be a bit more careful in the
> - * driver code, so manually force any const * of a kobject to also be a const *
> - * to a device.
> - */
> -#define kobj_to_dev(kobj)                                      \
> -       _Generic((kobj),                                        \
> -                const struct kobject *: __kobj_to_dev_const,   \
> -                struct kobject *: __kobj_to_dev)(kobj)
> +#define kobj_to_dev(__kobj)    container_of_const(__kobj, struct device, kobj)
>
>  /**
>   * device_iommu_mapped - Returns true when the device DMA is translated
> --
> 2.38.1
>
