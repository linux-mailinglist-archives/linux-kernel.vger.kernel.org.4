Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D823B69A97E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 11:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjBQK5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 05:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjBQK45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 05:56:57 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C5F5383B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:56:56 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id r11so275224pgu.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1676631415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=szUhwp36rcjb9tm6Fq6IRBOldXj/Qr9+MV3mTH4JZqc=;
        b=Sl/gWwXYliiGzO1kxdx4PEwWlOhqHX2W21cS5077geTdVD28AFldoZT39SLz+XS03r
         Si5wG9hNaGdAQtfHmMoqEcQXSXFB6qjkweOY7lGiItuM0iURGyua2F7i0iXoa6SGj6lB
         amqHIAbEdliUgxwDFB3YipJlwWI+9JmjoQ5PZ+aCokky4Neh9fOC6lGt5NtxMfrBXktr
         Edtt/PC2kbU9tQvdODI0fIFa7FTBDCE60kBB+sYgtGgigQYfYCFn9sn13Xm3XJZSEysA
         MEVuw3DORANo/FGKKuWTsnx3sX3Olyzp7kb24TF9EDqA37kDWqijMmNK0VlIpBI6KsM8
         noiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676631415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=szUhwp36rcjb9tm6Fq6IRBOldXj/Qr9+MV3mTH4JZqc=;
        b=LZAa9ufdTjeSbxdB8X5w4hBBXLYVvQfU7yLMpiW2UBOHw7Lmvy/zDE16nY+zgxbuRE
         3R0CGicQD4+KwpYv1kjl9YXtemIpRNtVFiSx+jycqJtyO+Gn7aRx9WnCVIv2k/d+CTRw
         fnTcO5vNXQ2kgSD4ubF0gp89Pkf4blHgxAsFjF1ZmwedyO6MjHchGOLeT5VV35EPQ8DQ
         gjFKX1ZYelN5f9YDZPKVuM41BZHTnYXh0L8fn5E0x/bOR/Oe8PgaS7geQl/L6qNmaA/y
         HAYEWML+rqwkdQhvjgiVUuFlKGj+mVYgQ+ycZJegj2CIxMBJYMTfUzxlkVXnCAu0ha/A
         P9Gg==
X-Gm-Message-State: AO0yUKVhCDxcQxD4gx/Rb6AQi9BuqjnWxrRk0HzDWPU9xaWPCRpsKLUU
        hsxoe9mSXufhBo8MtTNs21dPYU2jKbRNLbllk2TwWg==
X-Google-Smtp-Source: AK7set9nL74tFK1Sxv7hRt+wGq8ZRPEIHYTChESsds6ZxneeX3u1CkXORrg6bZkJ+nCm/EYFXia/2yuxMofU5j4BVYI=
X-Received: by 2002:aa7:95a9:0:b0:5a8:ba5b:575 with SMTP id
 a9-20020aa795a9000000b005a8ba5b0575mr1435521pfk.40.1676631415538; Fri, 17 Feb
 2023 02:56:55 -0800 (PST)
MIME-Version: 1.0
References: <20230217083005.128668-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230217083005.128668-1-yang.lee@linux.alibaba.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 17 Feb 2023 11:56:18 +0100
Message-ID: <CAPDyKFoUJ-j9NocWTiTVHSRBQ1YAtM2TH1SrCHByh911Jaa1UA@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: meson-gx: Use devm_platform_get_and_ioremap_resource()
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Feb 2023 at 09:30, Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/meson-gx-mmc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 079c52dbeca6..a5a9a19a9a42 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -1204,8 +1204,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
>         if (ret)
>                 return dev_err_probe(&pdev->dev, ret, "device reset failed\n");
>
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       host->regs = devm_ioremap_resource(&pdev->dev, res);
> +       host->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>         if (IS_ERR(host->regs))
>                 return PTR_ERR(host->regs);
>
> --
> 2.20.1.7.g153144c
>
