Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A87E6B01AB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjCHIil convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Mar 2023 03:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjCHIiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:38:12 -0500
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B43BDFF;
        Wed,  8 Mar 2023 00:38:07 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id k14so20336406lfj.7;
        Wed, 08 Mar 2023 00:38:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678264685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANgFNPaR0GvIitWau5iY4IFEMttHskDR5w8JjBg/OUo=;
        b=YdG9J8sbdJqk7uHW1wkmXfqY3HY3w/hghqTjNYdjUHRMt9A8tIzDT7fX7nCGQS5JSx
         iIaW+bIVeAAyX+F9wp9Xz0CekkZcxujblCyzlgKvupt5clOb7CyG8EbUsGRjJ4ryA3MB
         Mth3HrIdFEe+EX2rqUNjbyg+J8tomkPX5zc/3A3rj6CbM+HB5B2Ok3Z3ehk8qhYj1E6r
         +uw3Oy6rYZlxcyLcQjmg9vkIplCXgidXZ98A3RT99A9Wyt+9azVKz/XGg3Bwtz1Pun+h
         l5AX3k6Vx548I/wY2AD2EnmHgPGJQDWOV61PhCynKcGk12gXPjNxPWagjVvAoJO2jdXe
         mtRQ==
X-Gm-Message-State: AO0yUKXPkjXlRn+K+WLzU4VPNPpgmn/A21Jw2rxELeMsBpbzURtar6IX
        wxSAS5R1wyNB/7bsYdieUIAKdZtgGwxtONPF
X-Google-Smtp-Source: AK7set+bmXEYIiwjlvtrM2FP7knyjiJrfOvOMShlRg81L2mrFpAPhrYMH3IYepuMyE5Y27SjNjlyxw==
X-Received: by 2002:ac2:4148:0:b0:4db:3e7e:51d3 with SMTP id c8-20020ac24148000000b004db3e7e51d3mr4098617lfi.55.1678264685342;
        Wed, 08 Mar 2023 00:38:05 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id w29-20020a05651204dd00b004da8d947c57sm2300867lfq.149.2023.03.08.00.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 00:38:03 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id m6so20348373lfq.5;
        Wed, 08 Mar 2023 00:38:02 -0800 (PST)
X-Received: by 2002:ac2:4c13:0:b0:4dd:a4c5:2b42 with SMTP id
 t19-20020ac24c13000000b004dda4c52b42mr5285064lfq.8.1678264682409; Wed, 08 Mar
 2023 00:38:02 -0800 (PST)
MIME-Version: 1.0
References: <20230308060357.45647-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230308060357.45647-1-yang.lee@linux.alibaba.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 8 Mar 2023 09:37:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUSpSBriV8i=zSbSqeDTxnf_QuXO+u1Cx+jXshBaSbiZg@mail.gmail.com>
Message-ID: <CAMuHMdUSpSBriV8i=zSbSqeDTxnf_QuXO+u1Cx+jXshBaSbiZg@mail.gmail.com>
Subject: Re: [PATCH -next] thermal/hwmon: Use devm_platform_ioremap_resource()
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     niklas.soderlund@ragnatech.se, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

On Wed, Mar 8, 2023 at 7:17 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
> According to commit 7945f929f1a7 ("drivers: provide
> devm_platform_ioremap_resource()"), convert platform_get_resource(),
> devm_ioremap_resource() to a single call to Use
> devm_platform_ioremap_resource(), as this is exactly what this function
> does.

Thanks for your patch!

> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -435,9 +435,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>                          * Then, driver uses common registers
>                          * rcar_has_irq_support() will be enabled
>                          */
> -                       res = platform_get_resource(pdev, IORESOURCE_MEM,
> -                                                   mres++);
> -                       common->base = devm_ioremap_resource(dev, res);
> +                       common->base = devm_platform_ioremap_resource(pdev, mres++);
>                         if (IS_ERR(common->base)) {
>                                 ret = PTR_ERR(common->base);
>                                 goto error_unregister;

Note that there is a second opportunity for conversion in the same
function, a few lines below.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
