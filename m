Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7AB6FEFCA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 12:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237480AbjEKKS0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 11 May 2023 06:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjEKKSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 06:18:24 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B991B558F
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 03:18:23 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-50a20bfe366so2165914a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 03:18:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683800302; x=1686392302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HP+Cpoo9zLukv11/WFYzra5FPdxL5BNvlBgYeO1J/5A=;
        b=W4wqrO+Bs+ZWu+lWP1mIuXLuKdBYqpPEAOv1xNY1Jb8b12+mzhk0WEUA98pTQP0xXt
         pcFL4uMVgrZXJq5khmlRfZk5885X5p00i11ptT8Zp80Rveil0ufv2NCVR9SJtqhLvddD
         KbqG0D6rQzV0CeG7VDGzfDQyF+9q8nS87Pv6dwbT5uW2s31CWr+b2vnhy/g+PG2ZK/5C
         lhRYAxwTyOgUm1gMEekI4F6BEIoxFgrE1ZA1daq9wPB+VPuFU0YKLKgYpbGSLHqfH4oT
         z8Qmy1yleq4IDO0kCfLD+TGvOXR9cpJ4R9IY6Kx7n8gO2CPh7cidcuRS1Ly7yvGFvCv5
         d9wg==
X-Gm-Message-State: AC+VfDxJFyIeswoVixxaafQ7cEaeRTdOcYlfr/pXxh+q1lywzhAYP6AL
        EdY4grHEvwfyIaFTiPYCyuBMlbKbWusbQ+Cqm5o=
X-Google-Smtp-Source: ACHHUZ7tWAJBsqgFja6XrJ9bgARb539/07MVZjnQjes8mh4VhypFbc8+VVAssxfuxZBJ4jRI5OGxZP1wqEUP4i1TaSk=
X-Received: by 2002:a17:906:217:b0:965:d0b1:b72f with SMTP id
 23-20020a170906021700b00965d0b1b72fmr14793312ejd.1.1683800302103; Thu, 11 May
 2023 03:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230511073428.10264-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230511073428.10264-1-u.kleine-koenig@pengutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 11 May 2023 12:18:09 +0200
Message-ID: <CAJZ5v0gNPt=rq+pQtmoGL5nxzDQboOK4d6h7=NoY=LueVhZjAQ@mail.gmail.com>
Subject: Re: [PATCH] driver core: Call pm_runtime_put_sync() only after device_remove()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 9:34 AM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
>
> Many drivers that use runtime PM call pm_runtime_get_sync() or one of
> its variants in their remove callback. So calling pm_runtime_put_sync()
> directly before calling the remove callback results (under some
> conditions) in the driver's suspend routine being called just to resume
> it again afterwards.
>
> So delay the pm_runtime_put_sync() call until after device_remove().
>
> Confirmed on a stm32mp157a that doing
>
>         echo 4400e000.can > /sys/bus/platform/drivers/m_can_platform/unbind
>
> (starting with a runtime-pm suspended 4400e000.can) results in one call
> less of m_can_runtime_resume() and m_can_runtime_suspend() each after
> this change was applied.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

I'm not against this change, although I kind of expect it to trigger
some fallout that will need to be addressed.  So caveat emtor.

Anyway

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
> Hello,
>
> side note: To test I added a dev_info() to m_can_runtime_resume() and
> m_can_runtime_suspend(). I was surprised that directly after boot I had:
>
>         # dmesg | grep -E '4400e000.can: m_can_runtime_(resume|suspend)' | wc -l
>         15
>
> I didn't go down that rabbit hole to debug this.
>
> Best regards
> Uwe
>
>  drivers/base/dd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 9c09ca5c4ab6..d97f6b1486d1 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -1267,10 +1267,10 @@ static void __device_release_driver(struct device *dev, struct device *parent)
>
>                 bus_notify(dev, BUS_NOTIFY_UNBIND_DRIVER);
>
> -               pm_runtime_put_sync(dev);
> -
>                 device_remove(dev);
>
> +               pm_runtime_put_sync(dev);
> +
>                 if (dev->bus && dev->bus->dma_cleanup)
>                         dev->bus->dma_cleanup(dev);
>
> --
> 2.39.2
>
