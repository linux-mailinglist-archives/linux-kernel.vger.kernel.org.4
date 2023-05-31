Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BB5717C56
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbjEaJqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235574AbjEaJqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:46:08 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B231B1;
        Wed, 31 May 2023 02:46:03 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-565cfe4ece7so54088227b3.2;
        Wed, 31 May 2023 02:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685526362; x=1688118362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnLlnK5tgX6MTnacFdfiHp67y1VecyPAXn0kDrRDIuc=;
        b=TSbIG42DfdBpxXzN2abaroMzQyCGTcJ2lYn79qHkNA9QMEaHsgr40sQVFNfgXm4i+0
         7u9OUold0eSaeVC6HAloP9zGhdutmt0YFV1K2hOg5LE2YpZfUqydt80XBsaTwABhG9KW
         F+xCjFAx22b7s/xCP7uqS+FD2DTHPIv8dn0+2i+WsRo5mFx0lt7AQBCIjEFYgXBHYUrY
         7bL/iUhqtVnL8WeeLn1n3JiZs29RV5ox2qE68YzWkeuv3cSCwKpp/8XczEXlMBWcbm17
         CdA30NmYmc0fwX2ijAq34Eo9yDb7sLIF9AYLdb3oECS9ZT1dnDGmvzx+TAT6lRtjrXO6
         04hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685526362; x=1688118362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnLlnK5tgX6MTnacFdfiHp67y1VecyPAXn0kDrRDIuc=;
        b=Pc3LKPo7qoX4ikfJeJg5OL9yte70p+OjpNGJvYcVlXcCSwGaU3v+WeQ02Qb1dyVvO/
         r7Ax+yLJidm3tUFAG1+ERfA+dBHscfGas9aZSG1+zmvYgPTK5EJrIdWWRPFM88aShBhL
         JV9wPrScWnQL4qK9/lLMSxr1+YGnOrhZLjXefCrNBRBJJY4KGDnyr+Y7v/VslVoKFsRY
         Mk3Rwc6kqJUlPQswE/1gMxZm4oHtUqT5NRGAwTcCu2cUsyhym1cGJ5mZTjSGthw1ur/Q
         Hk9crEmr9XzjfOqoBcpD1mtzm70xTeQDduFst139nDTdcZ6HnNYX9AEDISU9lZdg1EnZ
         jeUg==
X-Gm-Message-State: AC+VfDx2iGyH8GN2VNVGepfdCpy8PIQqrfOoxkFwhbkDHJFlBriPLJjo
        GqpZHwDjhg/l/GWzsOvWmIvRew9wDb/lTqZAe7k=
X-Google-Smtp-Source: ACHHUZ7c97D+V2tYbv6D98epiID37lbyVs2RqM7EDsb5f+aK9v8Yrt+O9Xie4QIMxchjeGihweWrIQwXyR6gNRRrfDk=
X-Received: by 2002:a0d:ea52:0:b0:565:ead5:a126 with SMTP id
 t79-20020a0dea52000000b00565ead5a126mr5133145ywe.46.1685526362432; Wed, 31
 May 2023 02:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230530095308.8165-1-victorshihgli@gmail.com>
 <20230530095308.8165-4-victorshihgli@gmail.com> <c5601bbe-2ec9-1cd4-1e0f-1eca183e1b39@intel.com>
In-Reply-To: <c5601bbe-2ec9-1cd4-1e0f-1eca183e1b39@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Wed, 31 May 2023 17:45:51 +0800
Message-ID: <CAK00qKA66Vg+MHu9199V4rPO0LgX6n1akNJsdWtsnkWgrnqpug@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] mmc: sdhci-pci-gli: Add support SD Express card
 for GL9767
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

On Wed, May 31, 2023 at 3:15=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 30/05/23 12:53, Victor Shih wrote:
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > Add support SD Express card for GL9767. The workflow of the
> > SD Express card in GL9767 is as below.
> > 1. GL9767 operates in SD mode and set MMC_CAP2_SD_EXP flag.
> > 2. If card is inserted, Host send CMD8 to ask the capabilities
> >    of the card.
> > 3. If the card has PCIe capability, then init_sd_express()
> >    will be invoked.
> > 4. If the card has been put in write protect state then the
> >    SD features supported by SD mode but not supported by
> >    PCIe mode, therefore GL9767 switch to SD mode.
> > 5. If the card has not been put in write protect state then
> >    GL9767 switch from SD mode to PCIe/NVMe mode and mmc driver
> >    handover control to NVMe driver.
> > 6. If card is removed, GL9767 will return to SD mode.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>

Excuse me, I will adjust the order of definitions and modify the
if-else condition
and content in gl9767_init_sd_express() function, please help to review
it once, thank you.

> > ---
> >  drivers/mmc/host/sdhci-pci-gli.c | 105 +++++++++++++++++++++++++++++++
> >  1 file changed, 105 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-=
pci-gli.c
> > index 178253a7e86f..c7fa92fdadcd 100644
> > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > @@ -164,6 +164,10 @@
> >  #define PCIE_GLI_9767_CFG            0x8A0
> >  #define   PCIE_GLI_9767_CFG_LOW_PWR_OFF        BIT(12)
> >
> > +#define PCIE_GLI_9767_COMBO_MUX_CTL                  0x8C8
> > +#define   PCIE_GLI_9767_COMBO_MUX_CTL_RST_EN           BIT(6)
> > +#define   PCIE_GLI_9767_COMBO_MUX_CTL_WAIT_PERST_EN    BIT(10)
> > +
> >  #define PCIE_GLI_9767_PWR_MACRO_CTL                                  0=
x8D0
> >  #define   PCIE_GLI_9767_PWR_MACRO_CTL_LOW_VOLTAGE                     =
 GENMASK(3, 0)
> >  #define   PCIE_GLI_9767_PWR_MACRO_CTL_LD0_LOW_OUTPUT_VOLTAGE          =
 GENMASK(15, 12)
> > @@ -181,6 +185,26 @@
> >  #define   PCIE_GLI_9767_SCR_CORE_PWR_D3_OFF            BIT(21)
> >  #define   PCIE_GLI_9767_SCR_CFG_RST_DATA_LINK_DOWN     BIT(30)
> >
> > +#define PCIE_GLI_9767_SDHC_CAP                       0x91C
> > +#define   PCIE_GLI_9767_SDHC_CAP_SDEI_RESULT   BIT(5)
> > +
> > +#define PCIE_GLI_9767_SD_EXPRESS_CTL                 0x940
> > +#define   PCIE_GLI_9767_SD_EXPRESS_CTL_SDEI_EXE                BIT(0)
> > +#define   PCIE_GLI_9767_SD_EXPRESS_CTL_SD_EXPRESS_MODE         BIT(1)
> > +
> > +#define PCIE_GLI_9767_SD_DATA_MULTI_CTL                              0=
x944
> > +#define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME      GENMASK=
(23, 16)
> > +#define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME_VALUE       =
 0x64
> > +
> > +#define PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2                     0=
x950
> > +#define   PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SDEI_COMPLETE      =
 BIT(0)
> > +
> > +#define PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_EN_REG2                   =
       0x954
> > +#define   PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_EN_REG2_SDEI_COMPLETE_ST=
ATUS_EN          BIT(0)
> > +
> > +#define PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2                   =
       0x958
> > +#define   PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2_SDEI_COMPLETE_SI=
GNAL_EN          BIT(0)
> > +
> >  #define PCIE_GLI_9767_SD_PLL_CTL                     0x938
> >  #define   PCIE_GLI_9767_SD_PLL_CTL_PLL_LDIV            GENMASK(9, 0)
> >  #define   PCIE_GLI_9767_SD_PLL_CTL_PLL_PDIV            GENMASK(15, 12)
> > @@ -935,6 +959,85 @@ static void sdhci_gl9767_reset(struct sdhci_host *=
host, u8 mask)
> >       gli_set_9767(host);
> >  }
> >
> > +static int gl9767_init_sd_express(struct mmc_host *mmc, struct mmc_ios=
 *ios)
> > +{
> > +     struct sdhci_host *host =3D mmc_priv(mmc);
> > +     struct sdhci_pci_slot *slot =3D sdhci_priv(host);
> > +     struct pci_dev *pdev;
> > +     u32 value;
> > +     int i;
> > +
> > +     pdev =3D slot->chip->pdev;
> > +
> > +     if (mmc->ops->get_ro(mmc)) {
> > +             mmc->ios.timing &=3D ~(MMC_TIMING_SD_EXP | MMC_TIMING_SD_=
EXP_1_2V);
> > +             return 0;
> > +     }
> > +
> > +     gl9767_vhs_write(pdev);
> > +
> > +     pci_read_config_dword(pdev, PCIE_GLI_9767_COMBO_MUX_CTL, &value);
> > +     value &=3D ~(PCIE_GLI_9767_COMBO_MUX_CTL_RST_EN | PCIE_GLI_9767_C=
OMBO_MUX_CTL_WAIT_PERST_EN);
> > +     pci_write_config_dword(pdev, PCIE_GLI_9767_COMBO_MUX_CTL, value);
> > +
> > +     pci_read_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_CTL, &val=
ue);
> > +     value &=3D ~PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME;
> > +     value |=3D FIELD_PREP(PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_=
TIME,
> > +                         PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TI=
ME_VALUE);
> > +     pci_write_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_CTL, val=
ue);
> > +
> > +     pci_read_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_R=
EG2, &value);
> > +     value |=3D PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SDEI_COMPLETE=
;
> > +     pci_write_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_=
REG2, value);
> > +
> > +     pci_read_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_E=
N_REG2, &value);
> > +     value |=3D PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_EN_REG2_SDEI_COMPL=
ETE_STATUS_EN;
> > +     pci_write_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_=
EN_REG2, value);
> > +
> > +     pci_read_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_E=
N_REG2, &value);
> > +     value |=3D PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2_SDEI_COMPL=
ETE_SIGNAL_EN;
> > +     pci_write_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_=
EN_REG2, value);
> > +
> > +     pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
> > +     value |=3D PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> > +     pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
> > +
> > +     value =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > +     value &=3D ~(SDHCI_CLOCK_CARD_EN | SDHCI_CLOCK_PLL_EN);
> > +     sdhci_writew(host, value, SDHCI_CLOCK_CONTROL);
> > +
> > +     value =3D sdhci_readb(host, SDHCI_POWER_CONTROL);
> > +     value |=3D ((SDHCI_POWER_180 | SDHCI_POWER_ON) << 4);
> > +     sdhci_writeb(host, value, SDHCI_POWER_CONTROL);
> > +
> > +     pci_read_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL, &value)=
;
> > +     value |=3D PCIE_GLI_9767_SD_EXPRESS_CTL_SDEI_EXE;
> > +     pci_write_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL, value)=
;
> > +
> > +     for (i =3D 0; i < 2; i++) {
> > +             msleep(10);
> > +             pci_read_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_=
STATUS_REG2, &value);
> > +             if (value & PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SDEI=
_COMPLETE) {
> > +                     pci_write_config_dword(pdev, PCIE_GLI_9767_NORMAL=
_ERR_INT_STATUS_REG2,
> > +                                            value);
> > +                     break;
> > +             }
> > +     }
> > +
> > +     pci_read_config_dword(pdev, PCIE_GLI_9767_SDHC_CAP, &value);
> > +     if ((value & PCIE_GLI_9767_SDHC_CAP_SDEI_RESULT) =3D=3D PCIE_GLI_=
9767_SDHC_CAP_SDEI_RESULT) {
> > +             pci_read_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL,=
 &value);
> > +             value |=3D PCIE_GLI_9767_SD_EXPRESS_CTL_SD_EXPRESS_MODE;
> > +             pci_write_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL=
, value);
> > +     } else {
> > +             mmc->ios.timing &=3D ~(MMC_TIMING_SD_EXP | MMC_TIMING_SD_=
EXP_1_2V);
> > +     }
> > +
> > +     gl9767_vhs_read(pdev);
> > +
> > +     return 0;
> > +}
> > +
> >  static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
> >  {
> >       struct sdhci_host *host =3D slot->host;
> > @@ -967,6 +1070,8 @@ static int gli_probe_slot_gl9767(struct sdhci_pci_=
slot *slot)
> >       gl9767_hw_setting(slot);
> >       gli_pcie_enable_msi(slot);
> >       slot->host->mmc->caps2 |=3D MMC_CAP2_NO_SDIO;
> > +     host->mmc->caps2 |=3D MMC_CAP2_SD_EXP;
> > +     host->mmc_host_ops.init_sd_express =3D gl9767_init_sd_express;
> >       sdhci_enable_v4_mode(host);
> >
> >       return 0;
>

Thanks, Victor Shih
