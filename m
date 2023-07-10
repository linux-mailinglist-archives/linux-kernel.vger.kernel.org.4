Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C1174D55D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 14:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjGJM12 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jul 2023 08:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjGJM10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 08:27:26 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E73B1;
        Mon, 10 Jul 2023 05:27:25 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-c15a5ed884dso5189995276.2;
        Mon, 10 Jul 2023 05:27:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688992044; x=1691584044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3C5/GxdOTSlGprN5fpWAYyQzVkP9RkeiGRt79KEKJV0=;
        b=DxbA6SuYGMgWLuYHx95pmcwlkZbqbaRP7MARpwj7evY+FvPMvXXHMwEFtjAHPG1QJJ
         uw/NUTfMquBhJG0YOOz5Nk538V3L+grqawIWLquLTY1yMoNRGfWXn4hbWRf3hR2hnRRT
         tfjGCWXke9jrnTLlnwDIce3M8G2hfotA6bMwB8t+aacIwyW1sCwoUzu7+FiRzwpujNvw
         YCQD630frD4SHmIvdW2xBNzpKFEmlbDXcS4f6o/Vl8AaQtYiAa2pP1LdtyXlshG3KOdd
         +PcVYGkQmFNuARYSzma/OhC5cMobCcOxXidPMUgT2J9dpK+/0HE6JTlhI9NoXb4j99Rw
         jFsg==
X-Gm-Message-State: ABy/qLbLNIdbf4l5T4+9bhD2kEu56CXdNmDrOconWqSqhHUJVhzHJLbg
        KjAklp6tj3SR/qHMFkNd+xynj/pPcoVzdA==
X-Google-Smtp-Source: APBJJlHfu8VK3J40QrG+Nn6xp1XhW/ay4N1jugeZcU8FZ3XTTHXsKRCdy9dTn4xrnTFC529JOyyRCA==
X-Received: by 2002:a25:1657:0:b0:bad:125f:9156 with SMTP id 84-20020a251657000000b00bad125f9156mr9983466ybw.35.1688992044203;
        Mon, 10 Jul 2023 05:27:24 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id x63-20020a25ce42000000b00c5f99a71eaasm2605732ybe.57.2023.07.10.05.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 05:27:23 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-c5ce57836b8so5202300276.1;
        Mon, 10 Jul 2023 05:27:23 -0700 (PDT)
X-Received: by 2002:a25:d895:0:b0:bac:fecf:43d0 with SMTP id
 p143-20020a25d895000000b00bacfecf43d0mr10694122ybg.10.1688992042808; Mon, 10
 Jul 2023 05:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230710095926.15614-1-frank.li@vivo.com> <20230710095926.15614-7-frank.li@vivo.com>
In-Reply-To: <20230710095926.15614-7-frank.li@vivo.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jul 2023 14:27:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU==PhzyG7Dhzsq+3kq-B+H7D59juWyn2Lcg2A_C=XVHg@mail.gmail.com>
Message-ID: <CAMuHMdU==PhzyG7Dhzsq+3kq-B+H7D59juWyn2Lcg2A_C=XVHg@mail.gmail.com>
Subject: Re: [PATCH v4 07/21] thermal/drivers/rcar: convert to use devm_request*_irq_probe()
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

On Mon, Jul 10, 2023 at 12:07 PM Yangtao Li <frank.li@vivo.com> wrote:
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
