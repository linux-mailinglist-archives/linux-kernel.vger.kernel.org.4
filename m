Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD9C6C67E9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjCWMPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjCWMOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:14:43 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354A7274BE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:14:13 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id z83so24493571ybb.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679573651;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uppU9AbNohBvi0g75x2gTr8jOQr1QPXx8DqWx6y8HIg=;
        b=Vlb2igggfGE4b7llwtKfNo8B5oectf4E0xhuW4+2yO68QpEJ3NRBnNhQlu7RmbRAlU
         W1MMxKBikROrMe8sgjLXZGVNSosF+iQl14XVbrWHUPbfGOqloFi7A4AR/lHg+gT/OSlg
         Ld8NoZZYlYyxnXlI9NVLxUAoSR1sBuQ3HdKeMvcos4KXmEiHUD6n0cAFcs+/S22L9Mnk
         f75Fn4vGuAN8u5i1kfOHmz3Ex/97PhYFlNKdehGH/ZQYLvP1Or3HF3iuNXCAeVmh6o78
         MbjuPpiNaRtMfxnPwbXtI9nNBfxu8W2V/LGBE1N34aqj0PxAvhe2nUr4OKIPbzSZUpY4
         dxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679573651;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uppU9AbNohBvi0g75x2gTr8jOQr1QPXx8DqWx6y8HIg=;
        b=hUWHzmWQ2S/LtBr6WueR7PttQyM5OswtHKeWdexwKYfazVxW6mdff7jNKqpKK/cIgK
         0zTM8jdJknPzPNbK4hTVO3YfbXDZXK51NO2L7aXLgmG/rNbB4v67PK+rAMp9nIfPLEmP
         8kLsIh3vVm/U/iYi50N81m1L0dJSja+pls+arUYMiFCga1ZM6LY/tz7OwZZQzWTTldeQ
         ugVfPopViwEJkQVoOHWndHadNFJZxKfDj9LvQd7dHoIPBArzgk6Eb1xRqazqh+aR4CzX
         RnPMJr3QPEqhmGYNGY6n2egEiVZ1tIMxeUhkOjIf/law0Jp8VElZjmIpe1rf4AhMVJga
         1Nzg==
X-Gm-Message-State: AAQBX9cL11oUcGXOorvzbShjkttXpng0vXd1c6T8V9jd6hFiKa+2xRl2
        Apdu9/t+V4g7ekjc02reFzOLb1L6HpZ+l+wB/e3RdA==
X-Google-Smtp-Source: AKy350bw608jypkAmbz7acytC3RVNxEt/PVeJGobnfoIjzTjIlalXCNplviPPUJpYgMZ0MsoLN3QQm1Nl1hm01rloTg=
X-Received: by 2002:a05:6902:1705:b0:b75:8ac3:d5d8 with SMTP id
 by5-20020a056902170500b00b758ac3d5d8mr943033ybb.3.1679573650766; Thu, 23 Mar
 2023 05:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230314220619.41242-1-georgy.kruglov@yandex.ru> <20230321203715.3975-1-georgy.kruglov@yandex.ru>
In-Reply-To: <20230321203715.3975-1-georgy.kruglov@yandex.ru>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Mar 2023 13:13:35 +0100
Message-ID: <CAPDyKFpfXq0yi462tvTP5u0BR8EVas4WSiALRO9y-kiLuBYLzA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-of-esdhc: fix quirk to ignore command
 inhibit for data
To:     Georgii Kruglov <georgy.kruglov@yandex.ru>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Yangbo Lu <yangbo.lu@nxp.com>, Yinbo Zhu <yinbo.zhu@nxp.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Mar 2023 at 21:37, Georgii Kruglov <georgy.kruglov@yandex.ru> wrote:
>
> If spec_reg is equal to 'SDHCI_PRESENT_STATE', esdhc_readl_fixup()
> fixes up register value and returns it immediately. As a result, the
> further block
> (spec_reg == SDHCI_PRESENT_STATE)
>     &&(esdhc->quirk_ignore_data_inhibit == true),
> is never executed.
>
> The patch merges the second block into the first one.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 1f1929f3f2fa ("mmc: sdhci-of-esdhc: add quirk to ignore command inhibit for data")
> Signed-off-by: Georgii Kruglov <georgy.kruglov@yandex.ru>

Next time, please include acks according to earlier replies. This time
I have added Adrian's ack.

Applied for next, thanks!

Kind regards
Uffe


> ---
> v2: Drop the redundant '== true' as Adrian Hunter <adrian.hunter@intel.com> suggested.
>  drivers/mmc/host/sdhci-of-esdhc.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 4712adac7f7c..48ca1cf15b19 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -133,6 +133,7 @@ static u32 esdhc_readl_fixup(struct sdhci_host *host,
>                         return ret;
>                 }
>         }
> +
>         /*
>          * The DAT[3:0] line signal levels and the CMD line signal level are
>          * not compatible with standard SDHC register. The line signal levels
> @@ -144,6 +145,16 @@ static u32 esdhc_readl_fixup(struct sdhci_host *host,
>                 ret = value & 0x000fffff;
>                 ret |= (value >> 4) & SDHCI_DATA_LVL_MASK;
>                 ret |= (value << 1) & SDHCI_CMD_LVL;
> +
> +               /*
> +                * Some controllers have unreliable Data Line Active
> +                * bit for commands with busy signal. This affects
> +                * Command Inhibit (data) bit. Just ignore it since
> +                * MMC core driver has already polled card status
> +                * with CMD13 after any command with busy siganl.
> +                */
> +               if (esdhc->quirk_ignore_data_inhibit)
> +                       ret &= ~SDHCI_DATA_INHIBIT;
>                 return ret;
>         }
>
> @@ -158,19 +169,6 @@ static u32 esdhc_readl_fixup(struct sdhci_host *host,
>                 return ret;
>         }
>
> -       /*
> -        * Some controllers have unreliable Data Line Active
> -        * bit for commands with busy signal. This affects
> -        * Command Inhibit (data) bit. Just ignore it since
> -        * MMC core driver has already polled card status
> -        * with CMD13 after any command with busy siganl.
> -        */
> -       if ((spec_reg == SDHCI_PRESENT_STATE) &&
> -       (esdhc->quirk_ignore_data_inhibit == true)) {
> -               ret = value & ~SDHCI_DATA_INHIBIT;
> -               return ret;
> -       }
> -
>         ret = value;
>         return ret;
>  }
> --
> 2.34.1
>
