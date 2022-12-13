Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B0064B16F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 09:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbiLMIqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 03:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbiLMIqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 03:46:16 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0431A3A1;
        Tue, 13 Dec 2022 00:46:15 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id pv25so3987556qvb.1;
        Tue, 13 Dec 2022 00:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5HFOBQ9YyIlyceTXS9b1vJlCGtpUb7u21dq78J5Vypk=;
        b=cfodd8HT8Ylx4Reo8jxYiAIQCV9xoDwlAemYOMw42KR3NELnXsMGGGs4rQtBvIKcPq
         UdPsuosr8zLWjIRQRHNnQRFT4Jmdgg0+F5vRMWdvWnywtNiKvn6soXLgC7i7kEs+KFEI
         wetW0020++KQVm8cA8dMutrcNsn0oELBMQY93g8psZGwjBdvBYQzEQqiB/IJwcPZdHYI
         BjUhMReDSJIqlwsuPRnVrwKzdZbxwa6PvcKGR8bsLTftqOfqut0XEOxZ/JL8p/3n1sLg
         fjHYnUbJdWFd3TvyVZeLEbDJ3DiggpZPttKt2EgezKnNxZaX0l4/6MvFbe3o3uJ7ePJA
         FXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5HFOBQ9YyIlyceTXS9b1vJlCGtpUb7u21dq78J5Vypk=;
        b=pMR/jTQkdbvDUtlRRw5Vo1MIebIe06TKz9MzVu3zqgejz9CWRA8ZXdkHsw6n/7lbOf
         tHZo4sVtto2ratHAa3kZEhg5k2t7GtgqTkJxuKJX3dfsKRLgGs7Q/oTedwED+rX7+qIh
         4c5jB2/SetLKbBeTL0oXXHldeEG0vwfGfaoglpJFfIvXej3+D/ye0ckB6fbRpLSoCY5T
         V5cqDEiAa4ne42CJkNVQovOcT86U/HwTJGLlcUkR7YR2g2tY1Utcuvgsji8Bz8+MkSg8
         HrI1QzCNv24XWubH123VGxXHn4MnvQ2wFZsCUtkczVN8GYifObgozXvBPH9Cojlfqh01
         2i8A==
X-Gm-Message-State: ANoB5pmHktkmRsa9f69Ur8PnkQHYhVL+50F1k9a3aIb+JiU2V+N5z3rk
        2ZmyMIw8X1NEKaNWglJJXeh+wq4ZbKi0nbAvoKE=
X-Google-Smtp-Source: AA0mqf5wDamtWw4INoorMWfKAyjgPx4iNkQpnoVjQAksPCnetnukxC/z3oPuc2t8PyGh+p+zntIXz0cUCatVSYVkHTE=
X-Received: by 2002:a0c:f7c4:0:b0:4c6:fe57:5b97 with SMTP id
 f4-20020a0cf7c4000000b004c6fe575b97mr45111616qvo.49.1670921174330; Tue, 13
 Dec 2022 00:46:14 -0800 (PST)
MIME-Version: 1.0
References: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
 <20221019110647.11076-13-victor.shih@genesyslogic.com.tw> <96826b51-a980-0c25-f448-78bf726458fd@intel.com>
In-Reply-To: <96826b51-a980-0c25-f448-78bf726458fd@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Tue, 13 Dec 2022 16:46:01 +0800
Message-ID: <CAK00qKAuzNUwA_k0MLfJKh9iNfJNK-2RgkaRvDKjj8YMXLN7yQ@mail.gmail.com>
Subject: Re: [PATCH V5 12/26] mmc: sdhci-uhs2: add set_power() to support vdd2
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

On Wed, Nov 2, 2022 at 1:13 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 19/10/22 14:06, Victor Shih wrote:
> > This is a UHS-II version of sdhci's set_power operation.
> > VDD2, as well as VDD, is handled here.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 79 +++++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci-uhs2.h |  2 +
> >  drivers/mmc/host/sdhci.c      | 66 ++++++++++++++++-------------
> >  drivers/mmc/host/sdhci.h      |  2 +
> >  4 files changed, 120 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> > index 0e82f98d1967..896a1c8e55cf 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -117,6 +117,85 @@ void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
> >  }
> >  EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
> >
> > +void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
> > +                       unsigned short vdd)
> > +{
> > +     struct mmc_host *mmc = host->mmc;
> > +     u8 pwr;
> > +
> > +     /* FIXME: check if flags & MMC_UHS2_SUPPORT? */
> > +     if (!(sdhci_uhs2_mode(host))) {
> > +             sdhci_set_power(host, mode, vdd);
> > +             return;
> > +     }
>
> sdhci_uhs2_set_power() is called via ->uhs2_set_ios().  That should
> not be called if not in UHS2 mode, so no check should be needed here.
>
>

I will update it in the patch#11 of the new [PATCH V6].

> > +
> > +     if (mode != MMC_POWER_OFF) {
> > +             pwr = sdhci_get_vdd_value(vdd);
> > +             if (!pwr)
> > +                     WARN(1, "%s: Invalid vdd %#x\n",
> > +                          mmc_hostname(host->mmc), vdd);
> > +             pwr |= SDHCI_VDD2_POWER_180;
> > +     }
> > +
> > +     if (host->pwr == pwr)
> > +             return;
> > +     host->pwr = pwr;
> > +
> > +     if (pwr == 0) {
> > +             sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> > +
> > +             if (!IS_ERR(host->mmc->supply.vmmc))
> > +                     mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
>
> Seems to be a common if-clause.  Looks like we could use a
> helper like:
>
> static inline int mmc_opt_regulator_set_ocr(struct mmc_host *mmc,
>                                             struct regulator *supply,
>                                             unsigned short vdd_bit)
> {
>         return IS_ERR_OR_NULL(supply) ? 0 : mmc_regulator_set_ocr(mmc, supply, vdd_bit);
> }
>
>

I will update it in the patch#11 of the new [PATCH V6].

> > +             if (!IS_ERR_OR_NULL(host->mmc->supply.vmmc2))
> > +                     mmc_regulator_set_ocr(mmc, mmc->supply.vmmc2, 0);
> > +
> > +             if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
> > +                     sdhci_runtime_pm_bus_off(host);
>
> Let's not support quirks that you don't need like
> SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON
>

I will update it in the patch#11 of the new [PATCH V6].

> > +     } else {
> > +             if (!IS_ERR(host->mmc->supply.vmmc))
> > +                     mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
> > +             if (!IS_ERR_OR_NULL(host->mmc->supply.vmmc2))
> > +                     /* support 1.8v only for now */
> > +                     mmc_regulator_set_ocr(mmc, mmc->supply.vmmc2,
> > +                                           fls(MMC_VDD2_165_195) - 1);
> > +
> > +             /*
> > +              * Spec says that we should clear the power reg before setting
> > +              * a new value. Some controllers don't seem to like this though.
> > +              */
> > +             if (!(host->quirks & SDHCI_QUIRK_SINGLE_POWER_WRITE))
>
> Let's not support quirks that you don't need like
> SDHCI_QUIRK_SINGLE_POWER_WRITE
> note this one is !
>

I will update it in the patch#11 of the new [PATCH V6].

> > +                     sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> > +
> > +             /*
> > +              * At least the Marvell CaFe chip gets confused if we set the
> > +              * voltage and set turn on power at the same time, so set the
> > +              * voltage first.
> > +              */
> > +             if (host->quirks & SDHCI_QUIRK_NO_SIMULT_VDD_AND_POWER)
> > +                     sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
>
> Let's not support quirks that you don't need like
> SDHCI_QUIRK_NO_SIMULT_VDD_AND_POWER
>

I will update it in the patch#11 of the new [PATCH V6].

> > +
> > +             /* vdd first */
> > +             pwr |= SDHCI_POWER_ON;
> > +             sdhci_writeb(host, pwr & 0xf, SDHCI_POWER_CONTROL);
> > +             mdelay(5);
> > +
> > +             pwr |= SDHCI_VDD2_POWER_ON;
> > +             sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
> > +             mdelay(5);
> > +
> > +             if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
> > +                     sdhci_runtime_pm_bus_on(host);
>
> Let's not support quirks that you don't need like
> SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON
>

I will update it in the patch#11 of the new [PATCH V6].

> > +
> > +             /*
> > +              * Some controllers need an extra 10ms delay of 10ms before
> > +              * they can apply clock after applying power
> > +              */
> > +             if (host->quirks & SDHCI_QUIRK_DELAY_AFTER_POWER)
> > +                     mdelay(10);
>
> Let's not support quirks that you don't need like
> SDHCI_QUIRK_DELAY_AFTER_POWER
>

I will update it in the patch#11 of the new [PATCH V6].

> > +     }
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_uhs2_set_power);
>
> It is only used in this file, so let's not export it.
>
> > +
> >  /*****************************************************************************\
> >   *                                                                           *
> >   * Driver init/exit                                                          *
> > diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
> > index 31776dcca5cf..3179915f7f79 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.h
> > +++ b/drivers/mmc/host/sdhci-uhs2.h
> > @@ -213,5 +213,7 @@ struct sdhci_host;
> >  void sdhci_uhs2_dump_regs(struct sdhci_host *host);
> >  bool sdhci_uhs2_mode(struct sdhci_host *host);
> >  void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
> > +void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
> > +                       unsigned short vdd);
>
> Let's not export it for now.
>

I will update it in the patch#11 of the new [PATCH V6].

> >
> >  #endif /* __SDHCI_UHS2_H */
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index bd017c59a020..dfa0939a9058 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -23,7 +23,7 @@
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/of.h>
> > -
> > +#include <linux/bug.h>
> >  #include <linux/leds.h>
> >
> >  #include <linux/mmc/mmc.h>
> > @@ -186,13 +186,14 @@ static void sdhci_disable_card_detection(struct sdhci_host *host)
> >       sdhci_set_card_detection(host, false);
> >  }
> >
> > -static void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
> > +void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
> >  {
> >       if (host->bus_on)
> >               return;
> >       host->bus_on = true;
> >       pm_runtime_get_noresume(mmc_dev(host->mmc));
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_runtime_pm_bus_on);
> >
> >  void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
> >  {
> > @@ -2071,41 +2072,48 @@ static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
> >               sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> >  }
> >
> > +unsigned short sdhci_get_vdd_value(unsigned short vdd)
> > +{
> > +     u8 pwr;
> > +
> > +     switch (1 << vdd) {
> > +     case MMC_VDD_165_195:
> > +     /*
> > +      * Without a regulator, SDHCI does not support 2.0v
> > +      * so we only get here if the driver deliberately
> > +      * added the 2.0v range to ocr_avail. Map it to 1.8v
> > +      * for the purpose of turning on the power.
> > +      */
> > +     case MMC_VDD_20_21:
> > +             pwr = SDHCI_POWER_180;
> > +             break;
> > +     case MMC_VDD_29_30:
> > +     case MMC_VDD_30_31:
> > +             pwr = SDHCI_POWER_300;
> > +             break;
> > +     case MMC_VDD_32_33:
> > +     case MMC_VDD_33_34:
> > +             pwr = SDHCI_POWER_330;
> > +             break;
> > +     default:
> > +             pwr = 0;
> > +             break;
> > +     }
> > +
> > +     return pwr;
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_get_vdd_value);
> > +
> >  void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
> >                          unsigned short vdd)
> >  {
> >       u8 pwr = 0;
> >
> >       if (mode != MMC_POWER_OFF) {
> > -             switch (1 << vdd) {
> > -             case MMC_VDD_165_195:
> > -             /*
> > -              * Without a regulator, SDHCI does not support 2.0v
> > -              * so we only get here if the driver deliberately
> > -              * added the 2.0v range to ocr_avail. Map it to 1.8v
> > -              * for the purpose of turning on the power.
> > -              */
> > -             case MMC_VDD_20_21:
> > -                     pwr = SDHCI_POWER_180;
> > -                     break;
> > -             case MMC_VDD_29_30:
> > -             case MMC_VDD_30_31:
> > -                     pwr = SDHCI_POWER_300;
> > -                     break;
> > -             case MMC_VDD_32_33:
> > -             case MMC_VDD_33_34:
> > -             /*
> > -              * 3.4 ~ 3.6V are valid only for those platforms where it's
> > -              * known that the voltage range is supported by hardware.
> > -              */
> > -             case MMC_VDD_34_35:
> > -             case MMC_VDD_35_36:
> > -                     pwr = SDHCI_POWER_330;
> > -                     break;
> > -             default:
> > +             pwr = sdhci_get_vdd_value(vdd);
> > +             if (!pwr) {
> >                       WARN(1, "%s: Invalid vdd %#x\n",
> >                            mmc_hostname(host->mmc), vdd);
> > -                     break;
> >               }
> >       }
> >
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index 28716105da61..c34ca6ffbff6 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -850,6 +850,7 @@ static inline void sdhci_read_caps(struct sdhci_host *host)
> >       __sdhci_read_caps(host, NULL, NULL, NULL);
> >  }
> >
> > +void sdhci_runtime_pm_bus_on(struct sdhci_host *host);
> >  void sdhci_runtime_pm_bus_off(struct sdhci_host *host);
> >  u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
> >                  unsigned int *actual_clock);
> > @@ -860,6 +861,7 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
> >  void sdhci_set_power_and_bus_voltage(struct sdhci_host *host,
> >                                    unsigned char mode,
> >                                    unsigned short vdd);
> > +unsigned short sdhci_get_vdd_value(unsigned short vdd);
> >  void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
> >                          unsigned short vdd);
> >  int sdhci_get_cd_nogpio(struct mmc_host *mmc);
>

Thanks, Victor Shih
