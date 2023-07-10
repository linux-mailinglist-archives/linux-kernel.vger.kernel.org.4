Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF0C74DC72
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjGJR20 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jul 2023 13:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjGJR2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:28:24 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2B9C4;
        Mon, 10 Jul 2023 10:28:22 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-98dfd15aae1so108981366b.0;
        Mon, 10 Jul 2023 10:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689010101; x=1691602101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6m9bcYgGbjrVRMFW6nrHcAcb8xg9Wr/oPN8BtfdOyoo=;
        b=DpbGpUoGlBUJ3pq+NuJX09C9Ttk9iQS7C1oQ+dDX2wLh6fd4AgdpBkS/n9QsnABYP8
         Zo2b+0LZgV8Xnxi1qyzTo+fZoaobbDctjEigQNJEG0H80bKVitAaSYLtxKBYqknqUHtX
         bh6S7PjWeWorPAet3nZCwGnrLHV6X7NX7o63nHaimBwCQ95Z5QBEgZRxtBG4Q6fIfC9u
         hruAc4+FShMtcK48CFl/qqByFVfmCUb1CCFX6tXqTxy3cc0pgyMEco0cMnNhileckDEp
         3dZR+P1J1WK2DzRRDs6Gv/1/3cglTZM4cufwglJXXiRT898ujbHJ+HFHPfSgBZAlEkbI
         pRZQ==
X-Gm-Message-State: ABy/qLZ8/3I8Xc9nIacUWw3/lXWqne9sASv09kw5BdHKzuT+VoHPn/LG
        GE/AjhAlkxXKX+3e8cWrTs7TZp6yOoixQ89Z+vg=
X-Google-Smtp-Source: APBJJlGaLddWMgg3l2iwjH8O/u5lm1FCcnISu3+XYpvHyebQmDlWIxA57nnYOaWv8SkozX7erXyetKP23I5mOyLbYZ4=
X-Received: by 2002:a17:906:51c9:b0:993:d901:9b46 with SMTP id
 v9-20020a17090651c900b00993d9019b46mr8677753ejk.3.1689010101128; Mon, 10 Jul
 2023 10:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230710095926.15614-1-frank.li@vivo.com> <20230710095926.15614-9-frank.li@vivo.com>
In-Reply-To: <20230710095926.15614-9-frank.li@vivo.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 10 Jul 2023 19:28:09 +0200
Message-ID: <CAJZ5v0h7bvAqyKzV_SsKaTc3JV0R01y0k6aaieAk7iRcbN-eCg@mail.gmail.com>
Subject: Re: [PATCH v4 09/21] thermal: intel: int340x: processor_thermal:
 convert to use devm_request*_irq_probe()
To:     Yangtao Li <frank.li@vivo.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 12:00 PM Yangtao Li <frank.li@vivo.com> wrote:
>
> There are more than 700 calls to devm_request_threaded_irq method and
> more than 1000 calls to devm_request_irq method. Most drivers only
> request one interrupt resource, and these error messages are basically
> the same. If error messages are printed everywhere, more than 2000 lines
> of code can be saved by removing the msg in the driver.
>
> And tglx point out that:
>
>   If we actually look at the call sites of
>   devm_request_threaded_irq() then the vast majority of them print more or
>   less lousy error messages. A quick grep/sed/awk/sort/uniq revealed
>
>      519 messages total (there are probably more)
>
>      352 unique messages
>
>      323 unique messages after lower casing
>
>          Those 323 are mostly just variants of the same patterns with
>          slight modifications in formatting and information provided.
>
>      186 of these messages do not deliver any useful information,
>          e.g. "no irq", "
>
>      The most useful one of all is: "could request wakeup irq: %d"
>
>   So there is certainly an argument to be made that this particular
>   function should print a well formatted and informative error message.
>
>   It's not a general allocator like kmalloc(). It's specialized and in the
>   vast majority of cases failing to request the interrupt causes the
>   device probe to fail. So having proper and consistent information why
>   the device cannot be used _is_ useful.
>
> So convert to use devm_request*_irq_probe() API, which ensure that all
> error handling branches print error information.
>
> In this way, when this function fails, the upper-layer functions can
> directly return an error code without missing debugging information.
> Otherwise, the error message will be printed redundantly or missing.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Cc: AngeloGioacchino Del Regno  <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  .../intel/int340x_thermal/processor_thermal_device_pci.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
> index 0d1e98007270..ee766904b314 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
> @@ -258,13 +258,10 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
>                 irq_flag = IRQF_SHARED;
>
>         irq =  pci_irq_vector(pdev, 0);
> -       ret = devm_request_threaded_irq(&pdev->dev, irq,
> -                                       proc_thermal_irq_handler, NULL,
> -                                       irq_flag, KBUILD_MODNAME, pci_info);
> -       if (ret) {
> -               dev_err(&pdev->dev, "Request IRQ %d failed\n", pdev->irq);
> +       ret = devm_request_threaded_irq_probe(&pdev->dev, irq, proc_thermal_irq_handler,
> +                                             NULL, irq_flag, KBUILD_MODNAME, pci_info, NULL);
> +       if (ret)
>                 goto err_free_vectors;
> -       }
>
>         ret = thermal_zone_device_enable(pci_info->tzone);
>         if (ret)
> --
> 2.39.0
>
