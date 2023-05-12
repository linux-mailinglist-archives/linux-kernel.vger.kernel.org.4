Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6313700192
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 09:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240176AbjELHgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 03:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239965AbjELHgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 03:36:20 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4086C30F1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 00:36:19 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-55a44a2637bso141870377b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 00:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683876978; x=1686468978;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tncq8rfyUORTEsPTT3s+fxb4TbHZLX39y7YOezqrzs0=;
        b=fL3tkpkY3e7x9wRiZaKP69lP/XH/CkvQXuknKF1weIZyaprC1jdHBaFpHdwBdJvDre
         jGLDvxXIFbizwtpTftLiNpX69nau/Q1K4PrCyTc17PG6qclSaKeBwaPKzHk4ySkBuZTO
         48sDt977LNwmmWi3wyorLUvr0h1CR6i4yGdqZycwiu/57CpKnbuiFsjmRWrljd4dOyFE
         xbCJocOc2aAATilkd2Akea7ZsEhQ4Ilav0HkAOI8pw34riGDwk6KEa9C22ygZmRbRZoz
         aQ7/LX6WazuUhXRw3ufkfLePclrQbEQtwMckpwCc/8t0fyQC5Nu2RoP3TNWKWuehchyM
         w86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683876978; x=1686468978;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tncq8rfyUORTEsPTT3s+fxb4TbHZLX39y7YOezqrzs0=;
        b=Gb6oDCtcr6aXVX5Ia0KfaguqiWjMADY5Ut7IXF2zHmCuaYdW+9fh6N0to8FFL5/6i6
         75WGFdHBZXargBQrCglXh3DILgYVphHWXjERkjizh1nHAvfUSSiHygQTfLt8FgTXJEW7
         0XNeng2/EuY/aui+4Dc3aqsnPDsyYuHxEwzy3wF53rBmWq4bA2FcAOifusR6uWKJiusw
         0UomotrficYdt6sJZbVMtJOzTe3M2Ndrn6x9/OJ0upu4Nev3Tx85pm0LHZ+/zf5iPtq5
         yw0X2bwcafyF/isbrQF8wWUvP99pvE3q9KXIibn9AKfjWAhmEeqORWcBBXQycDp4/Vfo
         SLig==
X-Gm-Message-State: AC+VfDxb4nWZNW9eEnkm+JI/FVjrVuXR8dQwG86xVa8590/0ElR/wanA
        oo4epMhPqUNgzHdttt2t0A3y0LV2dvgg2GMqlUXoOQ==
X-Google-Smtp-Source: ACHHUZ59nmfYULt99BcAd1fsiRehSxiNwq4WR0XL7rzfga36xwxlT8G2hlKjI4WZ7FjamYLHleaRunmdnysnlp+tB1A=
X-Received: by 2002:a81:c24c:0:b0:55a:6e23:1a82 with SMTP id
 t12-20020a81c24c000000b0055a6e231a82mr22237820ywg.52.1683876978444; Fri, 12
 May 2023 00:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
In-Reply-To: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 12 May 2023 09:35:42 +0200
Message-ID: <CAPDyKFrD5HihGzH17HHd9NP5SoH73prmsuK1NCHg-a62dbH_fA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: sdhci-of-dwcmshc: Add runtime PM operations
 for BlueField-3
To:     Liming Sun <limings@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        David Thompson <davthompson@nvidia.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2023 at 21:03, Liming Sun <limings@nvidia.com> wrote:
>
> This commit implements the runtime PM operations for BlueField-3 SoC
> to disable eMMC card clock when idle.
>
> Reviewed-by: David Thompson <davthompson@nvidia.com>
> Signed-off-by: Liming Sun <limings@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 76 ++++++++++++++++++++++++++++-
>  1 file changed, 74 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index e68cd87998c8..19ce058fc5f0 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/reset.h>
>  #include <linux/sizes.h>
>
> @@ -542,8 +543,10 @@ static int dwcmshc_probe(struct platform_device *pdev)
>         }
>
>  #ifdef CONFIG_ACPI
> -       if (pltfm_data == &sdhci_dwcmshc_bf3_pdata)
> +       if (pltfm_data == &sdhci_dwcmshc_bf3_pdata) {
>                 sdhci_enable_v4_mode(host);
> +               pm_runtime_enable(dev);

Why make this ACPI specific? Wouldn't other platforms benefit from
this change too?

[...]

Kind regards
Uffe
