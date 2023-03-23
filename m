Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F79B6C67C2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjCWMNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjCWMNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:13:32 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B2D126D6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:13:30 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id j7so24490735ybg.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679573609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uQrN+6jw1W0Vk1sn5kB/FTmE1DrEeDvSIIgUQEHjFKs=;
        b=EOCTXJBwcdEXk3JTQVgoo0zxvBXkJVo+Hr1E19g04Uw9agrV42ddufIl0yzaFImlmI
         l4dCmicbqkpqYv+IXg6ga3SZMtsu4ZPZunLXZhkQbwn3uiSMCPaX50XR/TTW9rcHX+zy
         NEc6UNvEB1fNh2ix+e8bTOaomUxK/IftGjRv7ZAmvnzRKpWAt/qdAFSL97ktGxorV5uS
         o3YJsGpw66wP6Cy6ayJRVptxtl0oUj6csYm+HtWL47aH/Ok2bv/abwN+CQFBKI32PrkW
         vrwUWNORx1OT75DADU0O5ahER9oMQXAZWvNXS6PACQsWH9I1GO8BNh4WwmlkverLPMBd
         ozxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679573609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uQrN+6jw1W0Vk1sn5kB/FTmE1DrEeDvSIIgUQEHjFKs=;
        b=rs6D3jdqL4KM2eChAVbF4WB/2OA9Gab6E2DKdbmtiFlEsI6VvhMH2YWBPq5N73d4Lj
         UvqV5cBVAEeziCG0NYl1IEtdRSLnPSyo0+QZyp762voQPOozJKxvPyTohrREzHRVNwcW
         FcqhkxWEeWKsi49E8UIbYpnOPvz8tECd/dCoOzfzksianF3qC85IvGNSPSKHXKMXBLGV
         CzOqjfQGJHxPv3QcA4CSPQmgenVOVtO8WRF6ZNoKQoSmuOn9c0GkmIjLAGk6f58rGnjB
         9HrLTv+2f6SrRg6ye4wrScEkaKPl8uWFtycEAMO/JggS2GO4wwHwgki9N5ARZGTRphZG
         WBgA==
X-Gm-Message-State: AAQBX9fcHeUMWy1c8WMimwucUM+lPjaGFSFA37KdvOfWaM+s57CFTFxn
        /tnP3lluCgUOhh5z79Qok4N3bGueSRg1hcyICkw4QsL0BJSVc+KC
X-Google-Smtp-Source: AKy350Yz1QU/HRQZIbuhaa5BVUK11B7cbjmzYsCpg5CdGSMBa0XjL2SjXtCAZSuzYAIMePTgt5WYiB7KYmZ+AjHWZNA=
X-Received: by 2002:a05:6902:120f:b0:b6c:f26c:e5ab with SMTP id
 s15-20020a056902120f00b00b6cf26ce5abmr2059170ybu.3.1679573609525; Thu, 23 Mar
 2023 05:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230315052231.21212-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230315052231.21212-1-yang.lee@linux.alibaba.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Mar 2023 13:12:52 +0100
Message-ID: <CAPDyKFrfj87bSdcVV52pCWWtk_bdZS3LSkgfnOjpw5co6n7nYw@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: dw_mmc-pltfm: Use devm_platform_get_and_ioremap_resource()
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     jh80.chung@samsung.com, linux-mmc@vger.kernel.org,
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

On Wed, 15 Mar 2023 at 06:22, Yang Li <yang.lee@linux.alibaba.com> wrote:
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
>  drivers/mmc/host/dw_mmc-pltfm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
> index 13e55cff8237..48b7da2b86b3 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -46,8 +46,7 @@ int dw_mci_pltfm_register(struct platform_device *pdev,
>         host->irq_flags = 0;
>         host->pdata = pdev->dev.platform_data;
>
> -       regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       host->regs = devm_ioremap_resource(&pdev->dev, regs);
> +       host->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &regs);
>         if (IS_ERR(host->regs))
>                 return PTR_ERR(host->regs);
>
> --
> 2.20.1.7.g153144c
>
