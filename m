Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609E56A1A0B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjBXKXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjBXKXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:23:02 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9266A4E;
        Fri, 24 Feb 2023 02:22:53 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id y12so13149024qvt.8;
        Fri, 24 Feb 2023 02:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=75Uy1e7Np60dQ7Fyvc2/uyvyXBCJ5r1RPIBRgfiKdjc=;
        b=OOYNNudWZ3kW0dEY28TSjFr30UvcaQ+3xA2S3RivmAlKF64SOnvbpsHTLoIwHq5ukS
         buO+rGgYICDrV/fixVR0mKqBLi+G0GR5+9IUdMxVU8FeFddjPfJwXKTPr1JHeXDKNvaE
         V8WKjBcyXYIcn6kIQw6cScTk9uJMTib6slBcNXh6z6h4UCqHyzAzOAZ9UQZlx8a1zNO1
         Bjk9IMYGWKzlPY1l0/KNpCLu83lHwhT/KmM4ei3EGY+pnUBGiuRAtZxfCf/E8Dlb7Wq0
         EV2t19Xhp4MKSp9EYql1cnAWBvxmJ2CUKC4f7eaCfsFqqNf/r/W2negSv1+bzRDxCYl0
         m6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=75Uy1e7Np60dQ7Fyvc2/uyvyXBCJ5r1RPIBRgfiKdjc=;
        b=azNYHBc86UZV7l9vFAyaBfG8V+ZPklV2E0bEihnVdHk7GKhDCxCVZLfj+4RPEoHNP1
         gkqmF/qP9DpCTpgcSX+vct0JHnGQ4oDAjI46Hfc6+0cwRrYEtf162pz7TpgFFLEIHMcw
         d4Ta3FEt3AMuNkfKKH0OsA0bYbwkv7aUzCUgqh5tf7tQlHRlp9yWd5E0maI6qnJ+Fy+n
         9cp91XHBgBfcGLh19CENa75cS7JokcS4gP5lNoMKdwBkCyHpGE/Rti5eFiFndPTJa5yJ
         Qf+f9gK8w4AKWpoStNY5Oo1JM+HvkJ1EUOqEgKcgWHoKEBOz45zdJ85dOHXpzqqAb8Cb
         CmmQ==
X-Gm-Message-State: AO0yUKVvGVfwy3G/WaybDiqq9kefj1reYqA+zyk/T8+Fb0Px5h7LlHLS
        WdHStqRw32oNDRXyGVp/cQjazLfslAPAG808xRA=
X-Google-Smtp-Source: AK7set+FzgAz8e/87657gIj7CaNDDopWC2BPRDM/T+QRN9KvWv31K15qpKNVqeKBjyYYqPZj5JSCCRRyOHjCbw0nDls=
X-Received: by 2002:a05:6214:4c1a:b0:56e:f63b:634e with SMTP id
 qh26-20020a0562144c1a00b0056ef63b634emr2594891qvb.6.1677234172688; Fri, 24
 Feb 2023 02:22:52 -0800 (PST)
MIME-Version: 1.0
References: <20221213090047.3805-1-victor.shih@genesyslogic.com.tw>
 <20221213090047.3805-12-victor.shih@genesyslogic.com.tw> <d828948f-2cd4-9bc1-688d-5de6bd7b58bc@intel.com>
In-Reply-To: <d828948f-2cd4-9bc1-688d-5de6bd7b58bc@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Fri, 24 Feb 2023 18:22:40 +0800
Message-ID: <CAK00qKDyez21Cy=x=dp_yNPnconabPzJna6a+GmV_pHdsDEZOw@mail.gmail.com>
Subject: Re: [PATCH V6 11/24] mmc: sdhci-uhs2: add set_power() to support vdd2
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

On Fri, Jan 6, 2023 at 5:27 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 13/12/22 11:00, Victor Shih wrote:
> > This is a UHS-II version of sdhci's set_power operation.
> > VDD2, as well as VDD, is handled here.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 46 +++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci.c      | 63 +++++++++++++++++++----------------
> >  drivers/mmc/host/sdhci.h      |  1 +
> >  3 files changed, 82 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> > index ae862e1eadab..780491781613 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -57,6 +57,13 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
> >   *                                                                           *
> >  \*****************************************************************************/
> >
> > +static inline int mmc_opt_regulator_set_ocr(struct mmc_host *mmc,
> > +                                         struct regulator *supply,
> > +                                         unsigned short vdd_bit)
> > +{
> > +     return IS_ERR_OR_NULL(supply) ? 0 : mmc_regulator_set_ocr(mmc, supply, vdd_bit);
> > +}
> > +
> >  bool sdhci_uhs2_mode(struct sdhci_host *host)
> >  {
> >       return host->mmc->flags & MMC_UHS2_SUPPORT;
> > @@ -95,6 +102,45 @@ void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
> >  }
> >  EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
> >
> > +static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
> > +                       unsigned short vdd)
> > +{
> > +     struct mmc_host *mmc = host->mmc;
> > +     u8 pwr;
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
> > +             mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> > +             mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc2, 0);
> > +     } else {
> > +             mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
> > +             /* support 1.8v only for now */
> > +             mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc2, fls(MMC_VDD2_165_195) - 1);
> > +
>                 /* Clear the power reg before setting a new value */
>                 sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
>

I will update it in V7 version.

> > +             /* vdd first */
> > +             pwr |= SDHCI_POWER_ON;
> > +             sdhci_writeb(host, pwr & 0xf, SDHCI_POWER_CONTROL);
> > +             mdelay(5);
> > +
> > +             pwr |= SDHCI_VDD2_POWER_ON;
> > +             sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
> > +             mdelay(5);
> > +     }
> > +}
> > +
> >  /*****************************************************************************\
> >   *                                                                           *
> >   * Driver init/exit                                                          *
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 9b66b9a32c72..99633a3ef549 100644
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
> > @@ -2061,41 +2061,48 @@ static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
> >               sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> >  }
> >
> > +unsigned short sdhci_get_vdd_value(unsigned short vdd)
> > +{
> > +     u8 pwr;
>
> It is simpler without pwr
>

I will update it in V7 version.

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
>
>                 return SDHCI_POWER_180;
>

I will update it in V7 version.

> > +     case MMC_VDD_29_30:
> > +     case MMC_VDD_30_31:
> > +             pwr = SDHCI_POWER_300;
> > +             break;
>
>                 return SDHCI_POWER_300;
>

I will update it in V7 version.

> > +     case MMC_VDD_32_33:
> > +     case MMC_VDD_33_34:
>
> Missing:
>
>         /*
>          * 3.4 ~ 3.6V are valid only for those platforms where it's
>          * known that the voltage range is supported by hardware.
>          */
>         case MMC_VDD_34_35:
>         case MMC_VDD_35_36:
>
>

I will update it in V7 version.

> > +             pwr = SDHCI_POWER_330;
> > +             break;
>
>                 return SDHCI_POWER_330;
>

I will update it in V7 version.

> > +     default:
> > +             pwr = 0;
> > +             break;
>
>                 return 0;
>

I will update it in V7 version.

> > +     }
> > +
> > +     return pwr;
>
> Not needed. Control never reaches it anymore.
>

I will update it in V7 version.

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
> > index f41c19c76994..df7fa0c0ebf8 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -840,6 +840,7 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
> >  void sdhci_set_power_and_bus_voltage(struct sdhci_host *host,
> >                                    unsigned char mode,
> >                                    unsigned short vdd);
> > +unsigned short sdhci_get_vdd_value(unsigned short vdd);
> >  void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
> >                          unsigned short vdd);
> >  int sdhci_get_cd_nogpio(struct mmc_host *mmc);
>

Thanks, Victor Shih
