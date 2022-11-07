Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F06361FF49
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 21:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbiKGUOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 15:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbiKGUNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 15:13:51 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBA92B247
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 12:13:46 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id b21so12077937plc.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 12:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ob3MMNiUC2vlW5lEHB7KfWXwdlr55fOWirRPwAMtLlI=;
        b=mlGnodq/OEZbV7bHtyxPxYmWDgdUOs8WRoE9x/YW0QLeANRLG/qo/pFHQlSwwXxQXv
         LwhdrGjnQ9ypjMoT2zJamcn2ES6KYdD0CB+rHnx9c0u8odxSm07xf8NHvm9ODGNFUO5i
         4dPGEiH7Y7E3Xp/d0G5J4JLFs3lhIr6Xo4qDtFwVdmBkjmxVrgueA9LjHYy1I1rlnnil
         fAJpqs6cJ9C9UVsq2+h7uWs4W8w1ctgcT6LQmsoyuTmmBXtZD2noiKWDNPj1G0B1WP8m
         zEPuoFPPiImF/OcItBQLY2FD2rUCywNHdwediEh5pf+9kTqACmwrxKN0VIHlypyLu0iR
         xWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ob3MMNiUC2vlW5lEHB7KfWXwdlr55fOWirRPwAMtLlI=;
        b=IfFu/CgW6XdN1eUTBJj5nfC9jc47tq9eefMeTIwV5WjFjE9dvBtQj62X9/tiNmc1Hz
         NRciKlOa50p1C3QsLAe5ZhJzLLZEgFtb3GI39r1yyXy2hVpBIYXGgUnjCY8thCKQCJt5
         o5dVv4aWOHCOQGECb5a5IiAL9qmSX8sLGu6L3LBbiLveJX2DA3g8GNjRYDLWDGPis2ql
         /HjGO1DM7MDkRCjO5DmUQaQ9Uha70I8R3WpIEoebgXXWROf0PDwDdSihpqTEuVQNE/5W
         IKFF9gMi8RMqTDGjoUYOIpmp20uD/3WyYVfnpcNrYqEuRkSjGJeazCmy+VMhhjVHIb9i
         o6Hg==
X-Gm-Message-State: ACrzQf3dCpHIgWevzHbV+JuDeBtuJMsg3doF4eHHiedyr8eW5edxkbOx
        AUtClHk7sjFe8Hz1WLFRY/PNwlZ240fT/X2pUKRlqX9V9f0=
X-Google-Smtp-Source: AMsMyM44GPAF7URc2P5pI5FosDeB5qAi3FX4SCryhfWo1VFrOXczM/69ZFl/9Nj3zliTUvqVfTPd8pjg/fYeEGfufQ0=
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id
 mw7-20020a17090b4d0700b001ef521cf051mr71862866pjb.164.1667852025837; Mon, 07
 Nov 2022 12:13:45 -0800 (PST)
MIME-Version: 1.0
References: <20221028155633.1.I6c4bfb31e88fad934e7360242cb662e01612c1bb@changeid>
In-Reply-To: <20221028155633.1.I6c4bfb31e88fad934e7360242cb662e01612c1bb@changeid>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 7 Nov 2022 21:13:08 +0100
Message-ID: <CAPDyKFqd7+ozW3=mTFzDQDz-dX_Z62mJBs1N-wf636AWrgGmjA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci: Set PROBE_PREFER_ASYNCHRONOUS
To:     Brian Norris <briannorris@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Oct 2022 at 00:56, Brian Norris <briannorris@chromium.org> wrote:
>
> This driver often takes on the order of 10ms to start, but in some cases
> as much as 190ms. It shouldn't have many cross-device dependencies to
> race with, nor racy access to shared state with other drivers, so this
> should be a relatively low risk change. We've done similarly with a
> variety of other MMC host drivers already.
>
> This driver was pinpointed as part of a survey of top slowest initcalls
> (i.e., are built in, and probing synchronously) on a lab of ChromeOS
> systems.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/sdhci-pci-core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 34ea1acbb3cc..0449630acbb3 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -2281,7 +2281,8 @@ static struct pci_driver sdhci_driver = {
>         .probe =        sdhci_pci_probe,
>         .remove =       sdhci_pci_remove,
>         .driver =       {
> -               .pm =   &sdhci_pci_pm_ops
> +               .pm =   &sdhci_pci_pm_ops,
> +               .probe_type = PROBE_PREFER_ASYNCHRONOUS,
>         },
>  };
>
> --
> 2.38.1.273.g43a17bfeac-goog
>
