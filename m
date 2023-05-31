Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C099717C52
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbjEaJpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbjEaJpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:45:45 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DA5C0;
        Wed, 31 May 2023 02:45:43 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-75b04e897a5so651844385a.2;
        Wed, 31 May 2023 02:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685526343; x=1688118343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZtrU0a4f+GyB8KEp6XlttCUsOU+1CNOaTHldj3h697w=;
        b=GvZmjJU7PINp4pi1w4F72UVhSBX+iSQyN84mwaWOGnVUQZ4Gh01d/2k48q5xZLDwRo
         Q5DBc00RrSgVmq0TamZ9mXsIJ66O3mJ87HIxusiTbJdnM86P4z0P+pECGeAsbCcTA5rb
         L2645BGWwIkcgIQiMAM5dm1XmpWiR1qKjHHS1Y8IJ7n74CCH+rSmSqicYlYZYKODzAl1
         v/rzeIJjIRdT7E9J24vp2GbZopG3I0Y5osa+zkG2SACsw1XVzIM01eSC99bxYzAsMMg/
         R7ofTi8uya3oMUslW4D5IRco/CBcQUHX40zN9zF+l9zKoxWxmn3cm2TnwG9cl4WIqaVv
         Atdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685526343; x=1688118343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZtrU0a4f+GyB8KEp6XlttCUsOU+1CNOaTHldj3h697w=;
        b=PSinS8gwsKo+nGHZoYL+0G64m5tb5/8atG5pTgoY8LJgdODJJ3GKBSw1USOKKAXesr
         AAgZ9zPLERToxEIGtSVwFB50tx+hYVoeWz97tZB8k42WV6/d8aizexRdI+/wT1ujCB+X
         8xcwBe7Q2TtTdEfGNm+p25w2e72iHhL6oFL31T0t9/ePxUivdHtR6mCcnCy5kHPecQRh
         8m6hwM8H39rOkm4pyRkDtc2L2fu0wQgNYUB8bCHXEvxfKvjRRkqlHpcm0hnv80+wEi3+
         LvPRMYDExFbXfBYbXLiz9TyFU+v6WhgGtkm3Ceg2A2VtgtTG1Lg/gQLmP8N+kUoB3HiH
         25Bg==
X-Gm-Message-State: AC+VfDz+n2YSr51VpZMRhO7oTfvDWZ5aTs5VB4lTuJ/H3FnhlwjQ/14W
        BV5m0B5/nkNPsYpby+j6GAG4Ncmo1mbMEwkZp90=
X-Google-Smtp-Source: ACHHUZ6SYVGJXZFrg3xy7F3Qihmbd5j3nkCs/3pfVR96ylIETmxMwKBqjdt0SjGF9RnRvw4NB/K6dIcSwNBS/3wYQgw=
X-Received: by 2002:a05:620a:400a:b0:75b:23a1:35f2 with SMTP id
 h10-20020a05620a400a00b0075b23a135f2mr7376833qko.3.1685526342931; Wed, 31 May
 2023 02:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230530095308.8165-1-victorshihgli@gmail.com>
 <20230530095308.8165-3-victorshihgli@gmail.com> <7c185eb3-5775-af7c-3035-2799e3395c33@intel.com>
In-Reply-To: <7c185eb3-5775-af7c-3035-2799e3395c33@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Wed, 31 May 2023 17:45:31 +0800
Message-ID: <CAK00qKAn1WAh+zNT11L7G+fyGP-x0H7CzTFA3+T0GavpUufFVg@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] mmc: sdhci-pci-gli: Set SDR104's clock to 205MHz
 and enable SSC for GL9767
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
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

On Wed, May 31, 2023 at 3:01=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 30/05/23 12:53, Victor Shih wrote:
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > Set GL9767 SDR104's clock to 205MHz and enable SSC feature
> > depend on register 0x888 BIT(1).
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/sdhci-pci-gli.c | 135 ++++++++++++++++++++++++++++++-
> >  1 file changed, 134 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-=
pci-gli.c
> > index 3ed207b89d1a..178253a7e86f 100644
> > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > @@ -158,6 +158,12 @@
> >  #define   GLI_9767_VHS_REV_M   0x1
> >  #define   GLI_9767_VHS_REV_W   0x2
> >
> > +#define PCIE_GLI_9767_COM_MAILBOX            0x888
> > +#define   PCIE_GLI_9767_COM_MAILBOX_SSC_EN     BIT(1)
> > +
> > +#define PCIE_GLI_9767_CFG            0x8A0
> > +#define   PCIE_GLI_9767_CFG_LOW_PWR_OFF        BIT(12)
> > +
> >  #define PCIE_GLI_9767_PWR_MACRO_CTL                                  0=
x8D0
> >  #define   PCIE_GLI_9767_PWR_MACRO_CTL_LOW_VOLTAGE                     =
 GENMASK(3, 0)
> >  #define   PCIE_GLI_9767_PWR_MACRO_CTL_LD0_LOW_OUTPUT_VOLTAGE          =
 GENMASK(15, 12)
> > @@ -175,6 +181,16 @@
> >  #define   PCIE_GLI_9767_SCR_CORE_PWR_D3_OFF            BIT(21)
> >  #define   PCIE_GLI_9767_SCR_CFG_RST_DATA_LINK_DOWN     BIT(30)
> >
> > +#define PCIE_GLI_9767_SD_PLL_CTL                     0x938
> > +#define   PCIE_GLI_9767_SD_PLL_CTL_PLL_LDIV            GENMASK(9, 0)
> > +#define   PCIE_GLI_9767_SD_PLL_CTL_PLL_PDIV            GENMASK(15, 12)
> > +#define   PCIE_GLI_9767_SD_PLL_CTL_PLL_DIR_EN                  BIT(16)
> > +#define   PCIE_GLI_9767_SD_PLL_CTL_SSC_EN              BIT(19)
> > +#define   PCIE_GLI_9767_SD_PLL_CTL_SSC_STEP_SETTING    GENMASK(28, 24)
> > +
> > +#define PCIE_GLI_9767_SD_PLL_CTL2            0x93C
> > +#define   PCIE_GLI_9767_SD_PLL_CTL2_PLLSSC_PPM         GENMASK(31, 16)
> > +
> >  #define GLI_MAX_TUNING_LOOP 40
> >
> >  /* Genesys Logic chipset */
> > @@ -753,6 +769,123 @@ static inline void gl9767_vhs_write(struct pci_de=
v *pdev)
> >       pci_write_config_dword(pdev, PCIE_GLI_9767_VHS, vhs_value);
> >  }
> >
> > +static bool gl9767_ssc_enable(struct pci_dev *pdev)
> > +{
> > +     u32 value;
> > +     u8 enable;
> > +
> > +     gl9767_vhs_write(pdev);
> > +
> > +     pci_read_config_dword(pdev, PCIE_GLI_9767_COM_MAILBOX, &value);
> > +     enable =3D FIELD_GET(PCIE_GLI_9767_COM_MAILBOX_SSC_EN, value);
> > +
> > +     gl9767_vhs_read(pdev);
> > +
> > +     return enable;
> > +}
> > +
> > +static void gl9767_set_ssc(struct pci_dev *pdev, u8 enable, u8 step, u=
16 ppm)
> > +{
> > +     u32 pll;
> > +     u32 ssc;
> > +
> > +     gl9767_vhs_write(pdev);
> > +
> > +     pci_read_config_dword(pdev, PCIE_GLI_9767_SD_PLL_CTL, &pll);
> > +     pci_read_config_dword(pdev, PCIE_GLI_9767_SD_PLL_CTL2, &ssc);
> > +     pll &=3D ~(PCIE_GLI_9767_SD_PLL_CTL_SSC_STEP_SETTING |
> > +              PCIE_GLI_9767_SD_PLL_CTL_SSC_EN);
> > +     ssc &=3D ~PCIE_GLI_9767_SD_PLL_CTL2_PLLSSC_PPM;
> > +     pll |=3D FIELD_PREP(PCIE_GLI_9767_SD_PLL_CTL_SSC_STEP_SETTING, st=
ep) |
> > +            FIELD_PREP(PCIE_GLI_9767_SD_PLL_CTL_SSC_EN, enable);
> > +     ssc |=3D FIELD_PREP(PCIE_GLI_9767_SD_PLL_CTL2_PLLSSC_PPM, ppm);
> > +     pci_write_config_dword(pdev, PCIE_GLI_9767_SD_PLL_CTL2, ssc);
> > +     pci_write_config_dword(pdev, PCIE_GLI_9767_SD_PLL_CTL, pll);
> > +
> > +     gl9767_vhs_read(pdev);
> > +}
> > +
> > +static void gl9767_set_pll(struct pci_dev *pdev, u8 dir, u16 ldiv, u8 =
pdiv)
> > +{
> > +     u32 pll;
> > +
> > +     gl9767_vhs_write(pdev);
> > +
> > +     pci_read_config_dword(pdev, PCIE_GLI_9767_SD_PLL_CTL, &pll);
> > +     pll &=3D ~(PCIE_GLI_9767_SD_PLL_CTL_PLL_LDIV |
> > +              PCIE_GLI_9767_SD_PLL_CTL_PLL_PDIV |
> > +              PCIE_GLI_9767_SD_PLL_CTL_PLL_DIR_EN);
> > +     pll |=3D FIELD_PREP(PCIE_GLI_9767_SD_PLL_CTL_PLL_LDIV, ldiv) |
> > +            FIELD_PREP(PCIE_GLI_9767_SD_PLL_CTL_PLL_PDIV, pdiv) |
> > +            FIELD_PREP(PCIE_GLI_9767_SD_PLL_CTL_PLL_DIR_EN, dir);
> > +     pci_write_config_dword(pdev, PCIE_GLI_9767_SD_PLL_CTL, pll);
> > +
> > +     gl9767_vhs_read(pdev);
> > +
> > +     /* wait for pll stable */
> > +     mdelay(1);
>
> So long as SDHCI_QUIRK_CLOCK_BEFORE_RESET is not used, it is OK
> to sleep here, so msleep() or usleep_range()
>

I will update it in patch v3.

> > +}
> > +
> > +static void gl9767_set_ssc_pll_205mhz(struct pci_dev *pdev)
> > +{
> > +     bool enable =3D gl9767_ssc_enable(pdev);
> > +
> > +     /* set pll to 205MHz and ssc */
> > +     gl9767_set_ssc(pdev, enable, 0x1F, 0xF5C3);
> > +     gl9767_set_pll(pdev, 0x1, 0x246, 0x0);
> > +}
> > +
> > +static void gl9767_disable_ssc_pll(struct pci_dev *pdev)
> > +{
> > +     u32 pll;
> > +
> > +     gl9767_vhs_write(pdev);
> > +
> > +     pci_read_config_dword(pdev, PCIE_GLI_9767_SD_PLL_CTL, &pll);
> > +     pll &=3D ~(PCIE_GLI_9767_SD_PLL_CTL_PLL_DIR_EN | PCIE_GLI_9767_SD=
_PLL_CTL_SSC_EN);
> > +     pci_write_config_dword(pdev, PCIE_GLI_9767_SD_PLL_CTL, pll);
> > +
> > +     gl9767_vhs_read(pdev);
> > +}
> > +
> > +static void sdhci_gl9767_set_clock(struct sdhci_host *host, unsigned i=
nt clock)
> > +{
> > +     struct sdhci_pci_slot *slot =3D sdhci_priv(host);
> > +     struct mmc_ios *ios =3D &host->mmc->ios;
> > +     struct pci_dev *pdev;
> > +     u32 value;
> > +     u16 clk;
> > +
> > +     pdev =3D slot->chip->pdev;
> > +     host->mmc->actual_clock =3D 0;
> > +
> > +     gl9767_vhs_write(pdev);
> > +
> > +     pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
> > +     value |=3D PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> > +     pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
> > +
> > +     gl9767_disable_ssc_pll(pdev);
> > +     sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> > +
> > +     if (clock =3D=3D 0)
> > +             return;
> > +
> > +     clk =3D sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
> > +     if (clock =3D=3D 200000000 && ios->timing =3D=3D MMC_TIMING_UHS_S=
DR104) {
> > +             host->mmc->actual_clock =3D 205000000;
> > +             gl9767_set_ssc_pll_205mhz(pdev);
> > +     }
> > +
> > +     sdhci_enable_clk(host, clk);
> > +
> > +     pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
> > +     value &=3D ~PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> > +     pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
> > +
> > +     gl9767_vhs_read(pdev);
> > +}
> > +
> >  static void gli_set_9767(struct sdhci_host *host)
> >  {
> >       u32 value;
> > @@ -1293,7 +1426,7 @@ const struct sdhci_pci_fixes sdhci_gl9763e =3D {
> >  };
> >
> >  static const struct sdhci_ops sdhci_gl9767_ops =3D {
> > -     .set_clock               =3D sdhci_set_clock,
> > +     .set_clock               =3D sdhci_gl9767_set_clock,
> >       .enable_dma              =3D sdhci_pci_enable_dma,
> >       .set_bus_width           =3D sdhci_set_bus_width,
> >       .reset                   =3D sdhci_gl9767_reset,
>

Thanks, Victor Shih
