Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747A064B173
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 09:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbiLMIrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 03:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbiLMIrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 03:47:17 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCF71A390;
        Tue, 13 Dec 2022 00:46:59 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id h8so6224409qkk.8;
        Tue, 13 Dec 2022 00:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l0SugT89DsuwwpcNdPOb+/C/nHkoa0JZvlhywXM43mY=;
        b=E+1fBF2YXlryO+J79OyAp80oweGl/axjzW5F4xQdc3izMqfYCOp5k89z9TkjcP+Wll
         hGUdqDsD3WJDoQc8vIYBlFbye+DxRu/7cpDsngiL0dcN0KTO3KfGm5BXMQfJJGP5OIzp
         ciKfBVwCckn4j2wneVnVuYrodQaSpHUQow4jZumihI1kXo05uN8w1xuK1OlDdeiDNW7g
         SXOehO7blHZ86YJeYzzHBq8/W6xow3bSfnA3hT1T/5i/zTsImiFlF/uVMPwxwU9EZQik
         MPmVPT7iHY9DpBmzuJo5ApAVibsuHEVAz9/V3mfNaXdkgNQvhnE0VJuyTgPREoqEO4Hp
         Rk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l0SugT89DsuwwpcNdPOb+/C/nHkoa0JZvlhywXM43mY=;
        b=q93PPrF0Dh8lM8cKA/dIf5lb8+z8oXswKG6DgYEqnxE3M7e+R9+CJmgT5i+ccwNEKw
         QkpalktntNT76Z3auEqwXlt23986aRkT+2Jo9yS7mBiCmJn7nER27+2azXHu4EFEH6rt
         PSiHYeXwYoAmGLiw53JuKozN9i1Uyae0kBR/fhaWs/n3NjpXTAnEO1+BJvS7d34gK61W
         OBZoJODZmjihTzE4dwedwMzyTm5CsiEd6kMQ6V4TQxgqg5QfpwZiVp+u2j9uQzU2cWC7
         9k1oKHscdecyxkwGLXvh3Dfoo4jJC0w67tgPTROOsi7dQbR1ddCR+FDeFCcR01t8mrcy
         WGnw==
X-Gm-Message-State: ANoB5pn5B1WEowpZlFBPjDNoS8Yhf8bwY4YyDoicf4IYSSeAg8WZJCBC
        vQB2azScdiNbi9bWHssGVFLOMV2WZneyphWG4pQ=
X-Google-Smtp-Source: AA0mqf6XVPNJbIb4MV/ql/bkLRdC6rgdfE60aHqPI528XDWc9BN/3U0cM7mh/YiAMr6plnLayW5mQf490iviq3Wjty8=
X-Received: by 2002:a05:620a:89d:b0:6fa:77c0:ea01 with SMTP id
 b29-20020a05620a089d00b006fa77c0ea01mr54585qka.537.1670921218982; Tue, 13 Dec
 2022 00:46:58 -0800 (PST)
MIME-Version: 1.0
References: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
 <20221019110647.11076-16-victor.shih@genesyslogic.com.tw> <e8527156-b320-e3ac-73ab-74e9c95f0925@intel.com>
In-Reply-To: <e8527156-b320-e3ac-73ab-74e9c95f0925@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Tue, 13 Dec 2022 16:46:46 +0800
Message-ID: <CAK00qKDJKemF1C1oDNT1+zP-dC7gmmDLeWqcDUa=DaeBTJ09Dg@mail.gmail.com>
Subject: Re: [PATCH V5 15/26] mmc: sdhci-uhs2: add set_ios()
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Adrian

On Wed, Nov 2, 2022 at 1:15 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 19/10/22 14:06, Victor Shih wrote:
> > This is a sdhci version of mmc's set_ios operation.
> > It covers both UHS-I and UHS-II.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 102 ++++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci-uhs2.h |   1 +
> >  drivers/mmc/host/sdhci.c      |  40 ++++++++-----
> >  drivers/mmc/host/sdhci.h      |   2 +
> >  4 files changed, 130 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> > index 2b90e5308764..b535a47dc55a 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -281,6 +281,74 @@ void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
> >  }
> >  EXPORT_SYMBOL_GPL(sdhci_uhs2_set_timeout);
> >
> > +/**
> > + * sdhci_uhs2_clear_set_irqs - set Error Interrupt Status Enable register
> > + * @host:    SDHCI host
> > + * @clear:   bit-wise clear mask
> > + * @set:     bit-wise set mask
> > + *
> > + * Set/unset bits in UHS-II Error Interrupt Status Enable register
> > + */
> > +void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set)
> > +{
> > +     u32 ier;
> > +
> > +     ier = sdhci_readl(host, SDHCI_UHS2_ERR_INT_STATUS_EN);
> > +     ier &= ~clear;
> > +     ier |= set;
> > +     sdhci_writel(host, ier, SDHCI_UHS2_ERR_INT_STATUS_EN);
> > +     sdhci_writel(host, ier, SDHCI_UHS2_ERR_INT_SIG_EN);
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_uhs2_clear_set_irqs);
> > +
> > +static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > +{
> > +     struct sdhci_host *host = mmc_priv(mmc);
> > +     u8 cmd_res, dead_lock;
> > +     u16 ctrl_2;
> > +     unsigned long flags;
> > +
> > +     /* FIXME: why lock? */
> > +     spin_lock_irqsave(&host->lock, flags);
>
> ->uhs2_set_ios() should not be racing with anything, so the lock
> should not be needed.  Please remove for now.
>

I will update it in the patch#14 of the new [PATCH V6].

> > +
> > +     /* UHS2 Timeout Control */
> > +     sdhci_calc_timeout_uhs2(host, &cmd_res, &dead_lock);
> > +
> > +     /* change to use calculate value */
> > +     cmd_res |= dead_lock << SDHCI_UHS2_TIMER_CTRL_DEADLOCK_SHIFT;
> > +
> > +     sdhci_uhs2_clear_set_irqs(host,
> > +                               SDHCI_UHS2_ERR_INT_STATUS_RES_TIMEOUT |
> > +                               SDHCI_UHS2_ERR_INT_STATUS_DEADLOCK_TIMEOUT,
> > +                               0);
> > +     sdhci_writeb(host, cmd_res, SDHCI_UHS2_TIMER_CTRL);
> > +     sdhci_uhs2_clear_set_irqs(host, 0,
> > +                               SDHCI_UHS2_ERR_INT_STATUS_RES_TIMEOUT |
> > +                               SDHCI_UHS2_ERR_INT_STATUS_DEADLOCK_TIMEOUT);
> > +
> > +     /* UHS2 timing */
> > +     ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> > +     if (ios->timing == MMC_TIMING_SD_UHS2)
> > +             ctrl_2 |= SDHCI_CTRL_UHS_2 | SDHCI_CTRL_UHS2_INTERFACE_EN;
> > +     else
> > +             ctrl_2 &= ~(SDHCI_CTRL_UHS_2 | SDHCI_CTRL_UHS2_INTERFACE_EN);
> > +     sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
> > +
> > +     if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN))
> > +             sdhci_enable_preset_value(host, true);
> > +
> > +     if (host->ops->set_power)
> > +             host->ops->set_power(host, ios->power_mode, ios->vdd);
> > +     else
> > +             sdhci_uhs2_set_power(host, ios->power_mode, ios->vdd);
> > +     udelay(100);
> > +
> > +     host->timing = ios->timing;
> > +     sdhci_set_clock(host, host->clock);
> > +
> > +     spin_unlock_irqrestore(&host->lock, flags);
> > +}
> > +
> >  /*****************************************************************************\
> >   *                                                                           *
> >   * MMC callbacks                                                             *
> > @@ -302,6 +370,39 @@ static int sdhci_uhs2_start_signal_voltage_switch(struct mmc_host *mmc,
> >       return sdhci_start_signal_voltage_switch(mmc, ios);
> >  }
> >
> > +int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > +{
> > +     struct sdhci_host *host = mmc_priv(mmc);
> > +
> > +     if (!(host->version >= SDHCI_SPEC_400) ||
> > +         !(host->mmc->flags & MMC_UHS2_SUPPORT &&
> > +           host->mmc->caps2 & MMC_CAP2_SD_UHS2)) {
> > +             sdhci_set_ios(mmc, ios);
> > +             return 0;
> > +     }
> > +
> > +     if (ios->power_mode == MMC_POWER_UNDEFINED)
> > +             return 1;
>
> ->uhs2_set_ios() expects 0 or a negative error code.
> This case is not an error.
>
>                 return 0;
>

I will update it in the patch#14 of the new [PATCH V6].

> > +
> > +     if (host->flags & SDHCI_DEVICE_DEAD) {
> > +             if (!IS_ERR(mmc->supply.vmmc) &&
> > +                 ios->power_mode == MMC_POWER_OFF)
> > +                     mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> > +             if (!IS_ERR_OR_NULL(mmc->supply.vmmc2) &&
> > +                 ios->power_mode == MMC_POWER_OFF)
> > +                     mmc_regulator_set_ocr(mmc, mmc->supply.vmmc2, 0);
> > +             return 1;
>
> This is an error, so a negative code is needed
>

I will update it in the patch#14 of the new [PATCH V6].

> > +     }
> > +
> > +     /* FIXME: host->timing = ios->timing */
>
> Yes, __sdhci_uhs2_set_ios() should do that when it sets the timing
>

I will update it in the patch#14 of the new [PATCH V6].

> > +
> > +     sdhci_set_ios_common(mmc, ios);
> > +
> > +     __sdhci_uhs2_set_ios(mmc, ios);
> > +
> > +     return 0;
> > +}
> > +
> >  /*****************************************************************************\
> >   *                                                                           *
> >   * Driver init/exit                                                          *
> > @@ -312,6 +413,7 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
> >  {
> >       host->mmc_host_ops.start_signal_voltage_switch =
> >               sdhci_uhs2_start_signal_voltage_switch;
> > +     host->mmc_host_ops.uhs2_set_ios = sdhci_uhs2_set_ios;
> >
> >       return 0;
> >  }
> > diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
> > index 5ea235b14108..23368448ccd4 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.h
> > +++ b/drivers/mmc/host/sdhci-uhs2.h
> > @@ -216,5 +216,6 @@ void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
> >  void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
> >                         unsigned short vdd);
> >  void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
> > +void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
> >
> >  #endif /* __SDHCI_UHS2_H */
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index dfa0939a9058..de47c71995fb 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -47,8 +47,6 @@
> >  static unsigned int debug_quirks = 0;
> >  static unsigned int debug_quirks2;
> >
> > -static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
> > -
> >  static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd);
> >
> >  void sdhci_dumpregs(struct sdhci_host *host)
> > @@ -1888,6 +1886,9 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
> >       case MMC_TIMING_MMC_HS400:
> >               preset = sdhci_readw(host, SDHCI_PRESET_FOR_HS400);
> >               break;
> > +     case MMC_TIMING_SD_UHS2:
> > +             preset = sdhci_readw(host, SDHCI_PRESET_FOR_UHS2);
> > +             break;
> >       default:
> >               pr_warn("%s: Invalid UHS-I mode selected\n",
> >                       mmc_hostname(host->mmc));
> > @@ -2305,20 +2306,9 @@ void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
> >  }
> >  EXPORT_SYMBOL_GPL(sdhci_set_uhs_signaling);
> >
> > -void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > +void sdhci_set_ios_common(struct mmc_host *mmc, struct mmc_ios *ios)
> >  {
> >       struct sdhci_host *host = mmc_priv(mmc);
> > -     u8 ctrl;
> > -
> > -     if (ios->power_mode == MMC_POWER_UNDEFINED)
> > -             return;
> > -
> > -     if (host->flags & SDHCI_DEVICE_DEAD) {
> > -             if (!IS_ERR(mmc->supply.vmmc) &&
> > -                 ios->power_mode == MMC_POWER_OFF)
> > -                     mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> > -             return;
> > -     }
> >
> >       /*
> >        * Reset the chip on each power off.
> > @@ -2355,6 +2345,25 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >               host->ops->set_power(host, ios->power_mode, ios->vdd);
> >       else
> >               sdhci_set_power(host, ios->power_mode, ios->vdd);
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_set_ios_common);
> > +
> > +void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > +{
> > +     struct sdhci_host *host = mmc_priv(mmc);
> > +     u8 ctrl;
> > +
> > +     if (ios->power_mode == MMC_POWER_UNDEFINED)
> > +             return;
> > +
> > +     if (host->flags & SDHCI_DEVICE_DEAD) {
> > +             if (!IS_ERR(mmc->supply.vmmc) &&
> > +                 ios->power_mode == MMC_POWER_OFF)
> > +                     mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> > +             return;
> > +     }
> > +
> > +     sdhci_set_ios_common(mmc, ios);
> >
> >       if (host->ops->platform_send_init_74_clocks)
> >               host->ops->platform_send_init_74_clocks(host, ios->power_mode);
> > @@ -2935,7 +2944,7 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
> >  }
> >  EXPORT_SYMBOL_GPL(sdhci_execute_tuning);
> >
> > -static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
> > +void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
> >  {
> >       /* Host Controller v3.00 defines preset value registers */
> >       if (host->version < SDHCI_SPEC_300)
> > @@ -2963,6 +2972,7 @@ static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
> >               host->preset_enabled = enable;
> >       }
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_enable_preset_value);
> >
> >  static void sdhci_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
> >                               int err)
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index c34ca6ffbff6..22d7f47862ae 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -871,6 +871,8 @@ void sdhci_set_bus_width(struct sdhci_host *host, int width);
> >  void sdhci_reset(struct sdhci_host *host, u8 mask);
> >  void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
> >  int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
> > +void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
> > +void sdhci_set_ios_common(struct mmc_host *mmc, struct mmc_ios *ios);
> >  void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
> >  int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
> >                                     struct mmc_ios *ios);
>

Thanks, Victor Shih
