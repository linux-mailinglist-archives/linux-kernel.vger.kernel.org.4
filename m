Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0D25F4533
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiJDOLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiJDOLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:11:41 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388426069C;
        Tue,  4 Oct 2022 07:11:39 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id mx8so2375936qvb.8;
        Tue, 04 Oct 2022 07:11:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EnBu8K7AOZssFSbSI2QGdkhNZmJjOZGjT3MpjFppNq0=;
        b=OIN3dvz15VXlMpu4yHWg/MnW7ax+ZEXtP12bZ7tV3vgwAS49lPfgXPWRO65KuoT5zL
         H2qqHVAeuvW06+u+H2ymTOTpBKhtkCIJRxIr6/Nb5K5FsVIhpH1N5dFQwooP6Rg7gb1n
         d6q81/m3u9+ijuATaKio+3H2U88UtyNGpEjUtAp+vPiYr+gSER7v2zscJdpPYlLUM8rQ
         YckS5ZhQiEPSk4bXNakQE3WXxQQ6bU5eKquAUm8YLslyxjeoT4kWFBJmLBKnsWnMxLAJ
         CdPAgKF7nKEs82hg20hmXfHPOVNHWgcCluV35unuAYI+t9V/AE1LoBBH9s8XJoPiy1fa
         GVUA==
X-Gm-Message-State: ACrzQf0ux/S4ygmS4PWxmIjoqDXG3nXsBkO3URZrEICH8yJxXsJnr6NV
        6XnZ3T8goySYcxVgJXp/jZQEBH2XFPo8vgZ92Q9vtMlZ
X-Google-Smtp-Source: AMsMyM4OUKDamdB7dsx92fVIhxHYNjPPPNJWLJ8rypOA5LGNRT7ramr/4nkjgI6EJrWmZgltp8HhRspGKUMJr2/RVdg=
X-Received: by 2002:ad4:5beb:0:b0:4af:96ab:21e5 with SMTP id
 k11-20020ad45beb000000b004af96ab21e5mr20002445qvc.85.1664892698328; Tue, 04
 Oct 2022 07:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <20221004122636.61755-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221004122636.61755-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 4 Oct 2022 16:11:27 +0200
Message-ID: <CAJZ5v0j-V3gG3ADr9OigPsK0Rf9Ygd4KdEAkW=re3sd2gf_Awg@mail.gmail.com>
Subject: Re: [resend, PATCH v1 1/1] platform/x86: int3472: Don't leak
 reference on error
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 4, 2022 at 2:26 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The for_each_acpi_consumer_dev() takes a reference to the iterator
> and if we break a loop we must drop that reference. This usually
> happens when error handling is involved. However it's not the case
> for skl_int3472_fill_clk_pdata().
>
> Don't leak reference on error by dropping it properly.
>
> Fixes: 43cf36974d76 ("platform/x86: int3472: Support multiple clock consumers")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>
> resent to include Rafael and linux-acpi@ to the Cc list
>
>  drivers/platform/x86/intel/int3472/tps68470.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/x86/intel/int3472/tps68470.c b/drivers/platform/x86/intel/int3472/tps68470.c
> index f83e9c393f31..5b8d1a9620a5 100644
> --- a/drivers/platform/x86/intel/int3472/tps68470.c
> +++ b/drivers/platform/x86/intel/int3472/tps68470.c
> @@ -128,15 +128,15 @@ skl_int3472_fill_clk_pdata(struct device *dev, struct tps68470_clk_platform_data
>         for_each_acpi_consumer_dev(adev, consumer) {
>                 sensor_name = devm_kasprintf(dev, GFP_KERNEL, I2C_DEV_NAME_FORMAT,
>                                              acpi_dev_name(consumer));
> -               if (!sensor_name)
> +               if (!sensor_name) {
> +                       acpi_dev_put(consumer);
>                         return -ENOMEM;
> +               }
>
>                 (*clk_pdata)->consumers[i].consumer_dev_name = sensor_name;
>                 i++;
>         }
>
> -       acpi_dev_put(consumer);
> -
>         return n_consumers;
>  }
>
> --

Applied, thanks!
