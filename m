Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5781620D3F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 11:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbiKHK2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 05:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbiKHK2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 05:28:19 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE891E3D4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 02:28:18 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id a13so21804715edj.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 02:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LlnvrOgzgIYzw4ErLSoSuTM9O5WrKKjLBVTFrQiiYrw=;
        b=uRJpmF7t1GC1Egg7oFX+ei1Qh/4yebt4vO9g2dik7FW03duXGG0BEOE2gI6Y0FfvMX
         +864UB7R9U4cJn8ChpItgijT6UBe7X+JpscotYbcxhiD3Dau1AWmEwQTqgXolQl7AAFs
         B/I5uIktqkJ5DeYb+ofF5AgkTYKV3PmfcEMQ9RYY27fIn+0m/IGGgr30FftKknpxpsrA
         WM1uByoGPRdftGxd7bpqJlLIGsKD8cSw4h925iIRw4C+2a/CtZMF4XuDS4YQoYC2xeZ2
         lrtAU/5z5jYxlgbN0Qan6wVpKpr5JyozVZniLuNlG8Z+V7RJ0L1W1NiEfENeNI1/aZI6
         Cr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LlnvrOgzgIYzw4ErLSoSuTM9O5WrKKjLBVTFrQiiYrw=;
        b=zykMs7+xfAC28cdzO7Xm/XOE8e6EhYo7SOxQEN17cuXWpMmzQWAPSw62Wow66RzRN0
         /Q0B/k3jb5zBJG3UQAHAX5WHUEpr2H96bYKO85xZDIyBPLbxhyIh5dfRCpqA/XrpADo9
         widSgX4BH8PkdQcHOoqx6LVnKB9nojpXfvhln7DMgiwRGbUfVJvbwsrCdZ2AVWX6UzvN
         zaWgW94FbXY/pB3Oyt6Rly5FgKYcfX42YgRTYZAbmhC3zcRnIAhzhz6faa7QCJRSjhWx
         P3kU0q07BBHRpxGyd4dkObNUegNTPXF8LEPmQmF/5qmut+qP8Q97QUoaQ0Aafr6dOyZL
         4C0Q==
X-Gm-Message-State: ACrzQf19+YMEi4IS51Gvhj9P/1iZAXXiTxDTpv1ctyvCp2S6e3LqbrS4
        rTy1c0lIJShcGR+MpEg/bJdD42AIEcYAKuRFj5v3xg==
X-Google-Smtp-Source: AMsMyM7wG2afDMiM73wj4GBVpgdRAm1+t9UlWeLhKqAi3x0F1p1MKifmuIe2E4I5GKjvUkxMDbkL4KHlbwyp4q/gzGs=
X-Received: by 2002:aa7:d6d1:0:b0:463:ba50:e574 with SMTP id
 x17-20020aa7d6d1000000b00463ba50e574mr37155013edr.158.1667903297471; Tue, 08
 Nov 2022 02:28:17 -0800 (PST)
MIME-Version: 1.0
References: <20221027130859.1444412-1-shenwei.wang@nxp.com>
In-Reply-To: <20221027130859.1444412-1-shenwei.wang@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 8 Nov 2022 11:28:06 +0100
Message-ID: <CACRpkdbCxW7yPKnMTFDsUhCH2LHja6Pf1GpbdmqhDMqLA28aRg@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] gpio: add suspend/resume support for i.mx8x SoCs
To:     Shenwei Wang <shenwei.wang@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 3:09 PM Shenwei Wang <shenwei.wang@nxp.com> wrote:

> On i.MX8QM/QXP/DXL SoCs, even a GPIO is selected as the wakeup source,
> the GPIO block will be powered off when system enters into suspend
> state. This can greatly reduce the power consumption of suspend state
> because the whole partition can be shutdown. This is called PAD wakeup
> feature on i.MX8x platform.
>
> This series of patches enable this wakeup feature on i.MX8QM/QXP/DXL
> platforms.

First: thanks a lot for fixing this the way I wanted it!

> Shenwei Wang (5):
>   arm64: dts: imx8dxl-ss-lsio: add gpio-ranges property
>   arm64: dts: imx8qm-ss-lsio: add gpio-ranges property
>   arm64: dts: imx8qxp-ss-lsio: add gpio-ranges property

Please push these into the SoC tree for i.MX.

>   pinctrl: freescale: add pad wakeup config
>   gpio: mxc: enable pad wakeup on i.MX8x platforms

I have applied these two to the pinctrl tree.

Yours,
Linus Walleij
