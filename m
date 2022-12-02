Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125BA63FE3B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 03:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbiLBCln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 21:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiLBCll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 21:41:41 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F95D11FA;
        Thu,  1 Dec 2022 18:41:40 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id x13-20020a17090a46cd00b00218f611b6e9so3934529pjg.1;
        Thu, 01 Dec 2022 18:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x2CJLDeMTax4EICCqPsqq3RJPU66HgqpIjfLLroD130=;
        b=Rtlef5yi1ClT4FE1RGTqkQWnWUz84pIKpHwccr5XU+kyFKtPKtp803Peh2OspDkcy8
         UBzvzrunOm7mnyUmJuj+RW4RfWfVyabSDytroJBP1N3oEh93ZPa+de0YTJ1jjXaOzQ2L
         rgfIjTw0FQCK7ChskrWCIikX9sln0ZRr4SaA6emf4inW0hv9neR7GXsxZ1GBV+pT7XHt
         DFKb3bpoqB2iAbGIwItapZjfDnx63Dtftx4Sn/KnOV2oNuVxW18enCSlPX/qsN9bI6E1
         Gy4Zv1pCoen/05D0HbvGp3wnuYaA54EEGm3kiNQ8ncqPHtVPwdIVAUOqNR2ouETA2R6F
         yhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x2CJLDeMTax4EICCqPsqq3RJPU66HgqpIjfLLroD130=;
        b=lPXRK5H7lxpa58yzF2SmTmJvdQjjJaXLqeR9WrX4NWNxBZqEYtt9ynX/TXb5CgjiI6
         iccZ/enUm/bNMl0HpThgBAXxrqvZLeeXED7MbKPy+HUJP24Wm4dVr6buTi6K/n8wZzQi
         bJdwKR64QoQzkWrOlBRLFWxFfxJjpO3U3ew37EYmWoJ9CeP4aTT9ley+5+ifR38WRFMJ
         oYC13edQBIK83COeR+w7B71TbpwxQnnPNNYffjGt3WcIENp2/JAqgGe75mvHlxXaO2ub
         Kv9g8VXMkY4H7cZNa/ej49wlCVpDg5GSRorC7D5hkp8TSlijUKbzZ5X/pEm5A8+O4hmA
         j3ng==
X-Gm-Message-State: ANoB5pkXQIMv4+zvatM2hxwV0v8DvHqNX7m1AB/Q36pvOzgSCjw/gFMJ
        dGYSmH5HnidGwWImsbPU/h69AFyvKezf6pPDN8E=
X-Google-Smtp-Source: AA0mqf4k73woFRQdY6bWFYtdTl6ldHToVxzBNXJYIvAq9wvjHPzGQ5gzwXO2jESc5OAo7dKW5mO3MtalyFPcAf8oZ1s=
X-Received: by 2002:a17:90a:5d08:b0:218:770c:9a40 with SMTP id
 s8-20020a17090a5d0800b00218770c9a40mr56776286pji.158.1669948899815; Thu, 01
 Dec 2022 18:41:39 -0800 (PST)
MIME-Version: 1.0
References: <20221201091150.3474-1-wenchao.chen@unisoc.com> <CAPDyKFoBf25CDAgg5R0MSp53iC277FzGO9DUDf3LPU+_wuxCsA@mail.gmail.com>
In-Reply-To: <CAPDyKFoBf25CDAgg5R0MSp53iC277FzGO9DUDf3LPU+_wuxCsA@mail.gmail.com>
From:   Wenchao Chen <wenchao.chen666@gmail.com>
Date:   Fri, 2 Dec 2022 10:41:28 +0800
Message-ID: <CA+Da2qwjY=ebOmwsauPS5r8ig7wbH0JwjhDPmi1+eaT09tKxGQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-sprd: remove prefer asynchronous probe
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Wenchao Chen <wenchao.chen@unisoc.com>, adrian.hunter@intel.com,
        orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhenxiong.lai@unisoc.com,
        yuelin.tang@unisoc.com, gengcixi@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 1, 2022 at 6:41 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 1 Dec 2022 at 10:12, Wenchao Chen <wenchao.chen@unisoc.com> wrote:
> >
> > The prefer asynchronous probe affects the order of device probes.
>
> Is there a problem with this? If so, can you elaborate on what kind of problems?
>

Hi Uffe
dts:
sdio0: sdio@71100000 {
...
bus-width = <4>;
no-sdio;
no-mmc;
...
}; // SD Host(Device: SD CARD)

sdio3: sdio@71400000 {
...
bus-width = <8>;
non-removable;
no-sdio;
no-sd;
...
}; // eMMC Host(Device: eMMC)

According to the order of DTS: sdio0: sdio@71100000 is MMC0, sdio3:
sdio@71400000 is MMC1.
Log:
[    1.714617][   T11] mmc1: SDHCI controller on 71400000.sdio
[71400000.sdio] using ADMA 64-bit
[    1.715276][    T9] mmc0: SDHCI controller on 71100000.sdio
[71100000.sdio] using ADMA 64-bit
[    1.884525][   T75] mmc1: Host Software Queue enabled
[    1.890965][   T75] mmc1: new HS400 Enhanced strobe MMC card at address 0001

But set prefer_asynchronous_probe, sometimes there will be sdio0:
sdio@71100000 is MMC1, sdio3: sdio@71400000 is MMC0.
Log:
[    1.619888][   T68] mmc0: SDHCI controller on 71400000.sdio
[71400000.sdio] using ADMA 64-bit
[    1.620534][    T9] mmc1: SDHCI controller on 71100000.sdio
[71100000.sdio] using ADMA 64-bit
[    1.792570][   T77] mmc0: Host Software Queue enabled
[    1.799532][   T77] mmc0: new HS400 Enhanced strobe MMC card at address 0001

We use emmc as rootfs (without ramfs or initfs), but with SD card
inserted and not inserted, the partition name of emmc is different, we
need to fix this partition name.

> >
> > Fixes: d86472ae8b20 ("mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in v5.4")
> > Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
>
> Kind regards
> Uffe
>
> > ---
> >  drivers/mmc/host/sdhci-sprd.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> > index b92a408f138d..bf8df727e95e 100644
> > --- a/drivers/mmc/host/sdhci-sprd.c
> > +++ b/drivers/mmc/host/sdhci-sprd.c
> > @@ -801,7 +801,6 @@ static struct platform_driver sdhci_sprd_driver = {
> >         .remove = sdhci_sprd_remove,
> >         .driver = {
> >                 .name = "sdhci_sprd_r11",
> > -               .probe_type = PROBE_PREFER_ASYNCHRONOUS,
> >                 .of_match_table = sdhci_sprd_of_match,
> >                 .pm = &sdhci_sprd_pm_ops,
> >         },
> > --
> > 2.17.1
> >
