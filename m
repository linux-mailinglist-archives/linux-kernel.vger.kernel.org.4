Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053DE622B9B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 13:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiKIMep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 07:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiKIMen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 07:34:43 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186E5C5F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 04:34:43 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so1754260pjl.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 04:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+vTr7OxuLdKpOUINi2XZxnuPJqnUXrvJgdjO2NhLpRw=;
        b=sLwZJE/xemd5S+1CdXKsb1KtEstqBjCEO2BQxelhbpSobnBi0NRITQFxqmuoRkB9zf
         8HwaQMSyUNCzEG2iDCxogqEgS64hiHgYvE+W/4zHmLMWRsbFWV//vfPCyiIqyjaD2195
         I1tUpJnS9pCFaeDAdpmKLIYfj3RIpNS689cXYVJNWrg6KSYqgyfrmfnH/FRDdjkMHvIH
         RKsHk38MWWYJR8YdIzRJNkAj6TtMd/79fP+eVZqOXaGRdtGMemhypURPMAHLcuIprNB3
         kwLdB3E+4RM6XIARemkjPj8LvSLq9kP2j/o+6gyuI3WF/HzUMkJm3XQQJ6SzH5d1/FLr
         3t5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+vTr7OxuLdKpOUINi2XZxnuPJqnUXrvJgdjO2NhLpRw=;
        b=r/UUOn3XvV4S/JtJnggn6aoFM+1lVYeKJQ9T8kJh1/J2XXehz2LkmpkMSCxh88hurZ
         ryL5d717v+1MFVef/aIg6Og2RWUZs0RdYR1S32K+SnhzL42gW4nAoSY/LXqKZIABL8Rg
         1YQxARvFhDYZ36+7CxLhVrVasL33YWqLGXAd0a5p7+xCeT0Tduv20pKij9crGXgAEu0a
         FopGLLAo4omVmySrVw7i5chr8iQ6bWS1RTQygjUKjinJ7OVIlMbrTrxhCG9ttPkConH6
         UQWaRXWhGXSSBMbnbrGMCh9KYbRFKlyGb7+t9V0smUODM8NvBSzzbOVkYuOJgmU/zBBs
         kp2Q==
X-Gm-Message-State: ACrzQf3wrvV8v8IyQte1QQQa5ZrEcGuIXHNDBe19QJGyw8qSf/peEvP+
        IIdEih6ow9Z7lWb7jLBiSkZ6dHt3pdOf7lt4Ngci+GVzhvw=
X-Google-Smtp-Source: AMsMyM5ALov/r/ZakJeN3jfFfMSqoBqWZs5d/jt5YzgMsQgWBmWKD2si99B0ol7FjSzPFb1duICNzTgFtYH88EFZiOI=
X-Received: by 2002:a17:903:100c:b0:186:63a1:3b5d with SMTP id
 a12-20020a170903100c00b0018663a13b5dmr61928202plb.148.1667997282600; Wed, 09
 Nov 2022 04:34:42 -0800 (PST)
MIME-Version: 1.0
References: <20221107155516.2535912-1-gsomlo@gmail.com>
In-Reply-To: <20221107155516.2535912-1-gsomlo@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 9 Nov 2022 13:34:05 +0100
Message-ID: <CAPDyKFpBHGzH2iuGJOr29by57azeUv_s1qmfpKdSriw2nDUQcw@mail.gmail.com>
Subject: Re: [PATCH] mmc: litex_mmc: ensure `host->irq == 0` if polling
To:     Gabriel Somlo <gsomlo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, joel@jms.id.au,
        andy.shevchenko@gmail.com, mdudek@internships.antmicro.com,
        paulus@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2022 at 16:55, Gabriel Somlo <gsomlo@gmail.com> wrote:
>
> Ensure the flag is explicitly set to 0 if we determine that polling is
> needed during driver probe, to cover all possible cases.
>
> Fixes: 92e099104729 ("mmc: Add driver for LiteX's LiteSDCard interface")
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/litex_mmc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
> index 6ba0d63b8c07..39c6707fdfdb 100644
> --- a/drivers/mmc/host/litex_mmc.c
> +++ b/drivers/mmc/host/litex_mmc.c
> @@ -502,6 +502,7 @@ static int litex_mmc_irq_init(struct platform_device *pdev,
>
>  use_polling:
>         host->mmc->caps |= MMC_CAP_NEEDS_POLL;
> +       host->irq = 0;
>         return 0;
>  }
>
> --
> 2.37.3
>
