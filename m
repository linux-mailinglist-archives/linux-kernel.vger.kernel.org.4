Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95BD73822A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjFUK3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjFUK3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:29:14 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE8019B4;
        Wed, 21 Jun 2023 03:29:08 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-440cdef2c27so773198137.0;
        Wed, 21 Jun 2023 03:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687343347; x=1689935347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jv6GQPaa47DrYa/j8vOKHmNflqwWoenkp5YgGSQU6xk=;
        b=NJ3bHqSMPJHWML/G1ag7Zv/cQBqJ4V6cwYh6pW3LEt24QEp6YU/Y9QFq2r6u780rRc
         XQnKi7sKdwBJq8MAhvEUzsoRZNT1P4gDX9dwAsEOBVtXlTKbwJBX6hjLTcE4sUf0ErYL
         n+/L+qzgmGReUjPQnW6kK2UkLOPBnU4CA9B7z3ivHwEaSE4qfZdRAP7+civ1EnjWe4vw
         kRGYK6fPZEvTk0eNm9tNp37F1diUFUxih7y65YCoIZkjK2GAn6lU4czXtMZHU6wSTGCS
         /BErOFMpWfel6ovCrZvBH+kOwt95uVYgCubGa7tCUGKwDae2lPPOz0Egtx4cHa5z9RtI
         2GMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687343347; x=1689935347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jv6GQPaa47DrYa/j8vOKHmNflqwWoenkp5YgGSQU6xk=;
        b=RF61isl9pLrcBNreTiFHh8Lw/e6nUsu/5P/TBOp50z3Gxa+CFkQc2KhQDCozx5DD+Z
         Fvh4vK4yRge0UJliT6rhLfNCOMh909XAtkwXe3OkAmEqo2GA8ZbnveTaVyyuinXjNnoj
         JQxugEwEr8BtoUVe0IwfFrG6pqEjKrpuaPlD5WSM977n38g/MMt3aSSWW95wz++0gHaN
         XTHQeKrLCJfrtk7eggpIEQBCA242zoGyo2Sn4rZb8gfjQ1XOP/kwJYMYe/wSDkZtUI49
         nDtGUz80gFe8mXhd8ChfotuNDAF2vZFTw2c9zi1QEOruGKwpjWgltdBOa6Us39pvvqZS
         fETA==
X-Gm-Message-State: AC+VfDyPc/tMpOEM8jK3+JLhJYliexuwFZZ8Mym075V1jwNOmxpDjiLW
        5+QOSZ9cdex+A1Ni0XdOgzc+XeJ8oNRB45OGUYo=
X-Google-Smtp-Source: ACHHUZ65V8hH5kBOmS9+PmVmCdbuA0+qGG3IGVHvteTbg8hWpXkJhAOSrrfYvnk9dGeyI+AQgnUJGgeIlBwUfCII0S8=
X-Received: by 2002:a05:6102:9d2:b0:43b:4965:d03e with SMTP id
 g18-20020a05610209d200b0043b4965d03emr4527483vsi.10.1687343347341; Wed, 21
 Jun 2023 03:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230331105546.13607-1-victor.shih@genesyslogic.com.tw>
 <20230331105546.13607-12-victor.shih@genesyslogic.com.tw> <6d547b64-2030-a722-5e6a-0e0f7d0cd8cd@intel.com>
In-Reply-To: <6d547b64-2030-a722-5e6a-0e0f7d0cd8cd@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Wed, 21 Jun 2023 18:28:55 +0800
Message-ID: <CAK00qKBTN6rUT=VU4NCTY6gw-kGG6xF=OGRm9yXO5cyfvB6gtg@mail.gmail.com>
Subject: Re: [PATCH V7 11/23] mmc: sdhci-uhs2: add set_power() to support vdd2
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Adrian

On Wed, Apr 12, 2023 at 9:10=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 31/03/23 13:55, Victor Shih wrote:
> > This is a UHS-II version of sdhci's set_power operation.
> > VDD2, as well as VDD, is handled here.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 49 ++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci.c      | 61 +++++++++++++++++++----------------
> >  drivers/mmc/host/sdhci.h      |  1 +
> >  3 files changed, 83 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs=
2.c
> > index 67621eaabafc..3f232f4e0820 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -57,6 +57,13 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
> >   *                                                                    =
       *
> >  \*********************************************************************=
********/
> >
> > +static inline int mmc_opt_regulator_set_ocr(struct mmc_host *mmc,
> > +                                         struct regulator *supply,
> > +                                         unsigned short vdd_bit)
> > +{
> > +     return IS_ERR_OR_NULL(supply) ? 0 : mmc_regulator_set_ocr(mmc, su=
pply, vdd_bit);
> > +}
> > +
> >  bool sdhci_uhs2_mode(struct sdhci_host *host)
> >  {
> >       return host->mmc->flags & MMC_UHS2_SUPPORT;
> > @@ -95,6 +102,48 @@ void sdhci_uhs2_reset(struct sdhci_host *host, u16 =
mask)
> >  }
> >  EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
> >
> > +static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned cha=
r mode,
> > +                       unsigned short vdd)
>
> CHECK: Alignment should match open parenthesis
> #42: FILE: drivers/mmc/host/sdhci-uhs2.c:106:
> +static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char =
mode,
> +                         unsigned short vdd)
>
>

I will update it to the V8 version.

> > +{
> > +     struct mmc_host *mmc =3D host->mmc;
> > +     u8 pwr;
>
> pwr needs initialize to 0 i.e.
>
>         u8 pwr =3D 0;
>

I will update it to the V8 version.

> > +
> > +     if (mode !=3D MMC_POWER_OFF) {
> > +             pwr =3D sdhci_get_vdd_value(vdd);
> > +             if (!pwr)
> > +                     WARN(1, "%s: Invalid vdd %#x\n",
> > +                          mmc_hostname(host->mmc), vdd);
> > +             pwr |=3D SDHCI_VDD2_POWER_180;
> > +     }
> > +
> > +     if (host->pwr =3D=3D pwr)
> > +             return;
> > +     host->pwr =3D pwr;
> > +
> > +     if (pwr =3D=3D 0) {
> > +             sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> > +
> > +             mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> > +             mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc2, 0);
> > +     } else {
> > +             mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
> > +             /* support 1.8v only for now */
> > +             mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc2, fls(MMC=
_VDD_165_195) - 1);
> > +
> > +             /* Clear the power reg before setting a new value */
> > +             sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> > +
> > +             /* vdd first */
> > +             pwr |=3D SDHCI_POWER_ON;
> > +             sdhci_writeb(host, pwr & 0xf, SDHCI_POWER_CONTROL);
> > +             mdelay(5);
> > +
> > +             pwr |=3D SDHCI_VDD2_POWER_ON;
> > +             sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
> > +             mdelay(5);
> > +     }
> > +}
> > +
> >  /*********************************************************************=
********\
> >   *                                                                    =
       *
> >   * Driver init/exit                                                   =
       *
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index e79e1b5d5cd4..a68a2dce0efe 100644
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
> > @@ -2061,41 +2061,46 @@ static void sdhci_set_power_reg(struct sdhci_ho=
st *host, unsigned char mode,
> >               sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> >  }
> >
> > +unsigned short sdhci_get_vdd_value(unsigned short vdd)
> > +{
> > +     switch (1 << vdd) {
> > +     case MMC_VDD_165_195:
> > +     /*
> > +      * Without a regulator, SDHCI does not support 2.0v
> > +      * so we only get here if the driver deliberately
> > +      * added the 2.0v range to ocr_avail. Map it to 1.8v
> > +      * for the purpose of turning on the power.
> > +      */
> > +     case MMC_VDD_20_21:
> > +             return SDHCI_POWER_180;
> > +     case MMC_VDD_29_30:
> > +     case MMC_VDD_30_31:
> > +             return SDHCI_POWER_300;
> > +     case MMC_VDD_32_33:
> > +     case MMC_VDD_33_34:
> > +     /*
> > +      * 3.4V ~ 3.6V are valid only for those platforms where it's
> > +      * known that the voltage reange is supported by hardware.
> > +      */
> > +     case MMC_VDD_34_35:
> > +     case MMC_VDD_35_36:
> > +             return SDHCI_POWER_330;
> > +     default:
> > +             return 0;
> > +     }
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_get_vdd_value);
> > +
> >  void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode=
,
> >                          unsigned short vdd)
> >  {
> >       u8 pwr =3D 0;
> >
> >       if (mode !=3D MMC_POWER_OFF) {
> > -             switch (1 << vdd) {
> > -             case MMC_VDD_165_195:
> > -             /*
> > -              * Without a regulator, SDHCI does not support 2.0v
> > -              * so we only get here if the driver deliberately
> > -              * added the 2.0v range to ocr_avail. Map it to 1.8v
> > -              * for the purpose of turning on the power.
> > -              */
> > -             case MMC_VDD_20_21:
> > -                     pwr =3D SDHCI_POWER_180;
> > -                     break;
> > -             case MMC_VDD_29_30:
> > -             case MMC_VDD_30_31:
> > -                     pwr =3D SDHCI_POWER_300;
> > -                     break;
> > -             case MMC_VDD_32_33:
> > -             case MMC_VDD_33_34:
> > -             /*
> > -              * 3.4 ~ 3.6V are valid only for those platforms where it=
's
> > -              * known that the voltage range is supported by hardware.
> > -              */
> > -             case MMC_VDD_34_35:
> > -             case MMC_VDD_35_36:
> > -                     pwr =3D SDHCI_POWER_330;
> > -                     break;
> > -             default:
> > +             pwr =3D sdhci_get_vdd_value(vdd);
> > +             if (!pwr) {
> >                       WARN(1, "%s: Invalid vdd %#x\n",
> >                            mmc_hostname(host->mmc), vdd);
> > -                     break;
> >               }
> >       }
> >
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index 5dffa334d3fc..02ea4a00ad63 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -838,6 +838,7 @@ void sdhci_set_power(struct sdhci_host *host, unsig=
ned char mode,
> >  void sdhci_set_power_and_bus_voltage(struct sdhci_host *host,
> >                                    unsigned char mode,
> >                                    unsigned short vdd);
> > +unsigned short sdhci_get_vdd_value(unsigned short vdd);
> >  void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode=
,
> >                          unsigned short vdd);
> >  int sdhci_get_cd_nogpio(struct mmc_host *mmc);
>

Thanks, Victor Shih
