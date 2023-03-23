Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8593D6C67C8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjCWMNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjCWMNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:13:41 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99691EFF4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:13:32 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id i6so24502680ybu.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679573612;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DrtQ8CwDcwRA/DKiIVaGSBD/b1SSGaInqX/K7jpVRKA=;
        b=LXcwVizvFL7SjKCXKuCoQfWAYpHOQFMIsfvaBv9J6ZIhI6mlTEb/OoL/PGa2EYhDKy
         aQNsr29CKBreYNUaDvAFNZYVQ83GbRN6+wEcg1BKTCsqEoS/1dZnpd/FxTAtaw3BK4np
         4DXFFWefgVSPCWNzoguFllSpnuEEIA6kZ9WA7WFS602rAyB2UX8afTfhNXRd7SM6+Vat
         AC8vmciKYPSiQF5/PEGpA4+iRnjwHaRE2jhB9ZmD8pMwnJhXaPqu4/lz8sQaJVhujOXp
         rvoxT99I4g/pi0v5T8Djhfz9aSpX06eQNrsM42xMbbPr4pFvchLC7xsajuWVyc19ilWz
         aQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679573612;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DrtQ8CwDcwRA/DKiIVaGSBD/b1SSGaInqX/K7jpVRKA=;
        b=7EZ47sY0Ydy7KJd2a7fsbErf6y5Cxnw8PYN3Xp+KzOUdrubVIvw5z5xKvHIA70nI9c
         JYCfFagOKkmQ9O52Yj9KyyDH75fGLCxoGbtmPs07Ifef4TwewCw0jutuklIexB8bSXQw
         0n2TejWXKvmXAV6hUqAYsILBIEG1qfRkB21pZlDzHwxc7ts5BcWgGFHOWTN4sVbJt6/e
         93N6QhRmfioefTCxVfEm2bOB4VOK+lvNgeo+0Ce4LdJ+0MrpiBbSOGongpHZpgO9KvG2
         C0Fimzkgwp6Y7kqanJt63saCwgGo83+8NhB6F1f8DDkPeM32q5XNpmCvOM9PAKuRTuXm
         tN5w==
X-Gm-Message-State: AAQBX9ebp3Y0JYX7r1S2iKqwcnaPSv+dj6ea1yUiTxmNt9UkdwEXXJk0
        1OEgPoizzO78hoDO8uwCp8d7cr0qADDMEdLd3wfDNw==
X-Google-Smtp-Source: AKy350Y6PAngVYMC5aIvNHmGoOD2wdu03PXzck6qzjHGv4u4r/rSe3V4PKht12FdYJJ+8QYKiBvoXSmOWogaFoo1tbA=
X-Received: by 2002:a05:6902:722:b0:b68:7a4a:5258 with SMTP id
 l2-20020a056902072200b00b687a4a5258mr2072334ybt.3.1679573611981; Thu, 23 Mar
 2023 05:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230315055023.61779-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230315055023.61779-1-yang.lee@linux.alibaba.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Mar 2023 13:12:56 +0100
Message-ID: <CAPDyKFrcATB2qxzpkHGKD=VGK21Vr83xmHYcaX708F0Qjek4xA@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: sdhci-of-aspeed: Use devm_platform_get_and_ioremap_resource()
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     adrian.hunter@intel.com, andrew@aj.id.au, oel@jms.id.au,
        linux-mmc@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2023 at 06:50, Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> According to commit 890cc39a8799 ("drivers: provide
> devm_platform_get_and_ioremap_resource()"), convert
> platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-aspeed.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index ba6677bf7372..25b4073f698b 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -547,8 +547,7 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
>                 return ret;
>         }
>
> -       sdc->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       sdc->regs = devm_ioremap_resource(&pdev->dev, sdc->res);
> +       sdc->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &sdc->res);
>         if (IS_ERR(sdc->regs)) {
>                 ret = PTR_ERR(sdc->regs);
>                 goto err_clk;
> --
> 2.20.1.7.g153144c
>
