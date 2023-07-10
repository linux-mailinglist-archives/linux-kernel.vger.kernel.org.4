Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C7B74D560
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 14:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjGJM2B convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jul 2023 08:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjGJM14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 08:27:56 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46449B1;
        Mon, 10 Jul 2023 05:27:55 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5701810884aso47893327b3.0;
        Mon, 10 Jul 2023 05:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688992074; x=1691584074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72G0xT35DUUmjR1UqeCEhln7BH2NFD1TsIdwv6WzGBc=;
        b=ZIcR4xwd+wyeXWZZf2pQxCdkIYD1dc8smbu0Aj/4NmE04Aa6wxyNER2S+y7gCiKzcP
         YwmM4bRRrC8rbxdBTJeMspOog2NknJrGtg+QyLKfeEMM9FFo5B3sfth1NKvYRlbN1InM
         nvPhs9fA4mZIBKyaqRHLiB4BYWLgUXYadg6QQhvqmbxyNV1qCRGWdyGpjtuYWgZpZU+B
         N6tVBhayyONlmEOpgrfyTu3OdFasDiGP0Yb0CX3iboRYK7Dy4YRr5crSvItF/DHpqpc+
         Gl+kjrkDoJPIKTYJChF+KlzyO0MPIwpitYZRP1Gbx1/85Qpldsn/Vi4uOwH2cZI0mwsw
         cAJA==
X-Gm-Message-State: ABy/qLb4OxsycZB+Nc2ERz2SXjpb0tMPS/RkKCHPeEa3ye4mLLmbHYIF
        zAeTSfHT7y8hT3Tb8Iln1HsuYFo7m3yU5w==
X-Google-Smtp-Source: APBJJlF3C3k5W0rlJYMrCIaaaHsDWlLU6YObswQhANuqzGgxgR+Tm6T4wmMLk9qs7TuJINXBo4mkMw==
X-Received: by 2002:a0d:de42:0:b0:570:7df7:e401 with SMTP id h63-20020a0dde42000000b005707df7e401mr14208890ywe.29.1688992074352;
        Mon, 10 Jul 2023 05:27:54 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id a62-20020a0dd841000000b0054f9e7fed7asm3048610ywe.137.2023.07.10.05.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 05:27:53 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-c4d04d50c4cso4240323276.1;
        Mon, 10 Jul 2023 05:27:53 -0700 (PDT)
X-Received: by 2002:a25:5c5:0:b0:c59:f91:a769 with SMTP id 188-20020a2505c5000000b00c590f91a769mr11544540ybf.64.1688992073743;
 Mon, 10 Jul 2023 05:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230710095926.15614-1-frank.li@vivo.com> <20230710095926.15614-13-frank.li@vivo.com>
In-Reply-To: <20230710095926.15614-13-frank.li@vivo.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jul 2023 14:27:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV7nef1OaBCwG7vs3KKm1nFuuhGp_41V6v4ZFjahZBeGQ@mail.gmail.com>
Message-ID: <CAMuHMdV7nef1OaBCwG7vs3KKm1nFuuhGp_41V6v4ZFjahZBeGQ@mail.gmail.com>
Subject: Re: [PATCH v4 13/21] drivers/thermal/rcar_gen3_thermal: convert to
 use devm_request*_irq_probe()
To:     Yangtao Li <frank.li@vivo.com>
Cc:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Jul 10, 2023 at 12:10 PM Yangtao Li <frank.li@vivo.com> wrote:
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

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
