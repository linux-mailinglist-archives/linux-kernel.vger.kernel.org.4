Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B600715ABD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjE3Jwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjE3Jwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:52:43 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849E519C;
        Tue, 30 May 2023 02:52:21 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-565de553de1so39303337b3.0;
        Tue, 30 May 2023 02:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685440340; x=1688032340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZfy2MPe7qEXms+DlIlXm/R7LpX5eSwNhJpQPIOyi8o=;
        b=SmUlcuJ7oigl4HIWMNomimNSL8zoerJISjdxdQ2Pg0ke+TFky1r8mrVCV3w0RDm4Fp
         uaYtUYcCM2pxNrdyc+2GTTve78YC0sLZZ5QeDg6OTUp9N2C/TRcMO8AuXktiXP4BOvBI
         Q6Jk5hasS8xgbO8jNd0/Z22hRBazjyno6afV59ElBT/rnD7KMEHpPy8vtwr7VpXxYKSn
         IRQvYxJY8oSp+LT8cJQFT0jn8xO7YV4FGw+KaxdU7S6izRyqxngsj58KVjmo8e6yPzlK
         E9dLspZI4p40LfWTdNKPLNtvCX3nQsy4OLIpGJU9uEZKwcsosEeNkhdVydQSX5PLT/Vc
         V5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685440340; x=1688032340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZfy2MPe7qEXms+DlIlXm/R7LpX5eSwNhJpQPIOyi8o=;
        b=fBfaV1AZzs6LPWGFiFjvK2mEtuLrm7rKQdrbAV7MSCjpXXcND/NGIxSTBujxo19987
         D5Qn2CKhNncYtKZY4JVCFoUFRA1uOSSf4/9qN3kuZsXxP08gEWkYghYO6jej7zvtnrTX
         4l6LX9lsqfrkeShh62XsEF0rMqegfvPRaQuvaEv2q9jpIASkiZk7kzGRb+30Uuf8C8aW
         cf9dN3WRc4d1fBHziCO29FLbtRC4c0kjDHSRegSc485BXa8CErFSGx5+SlSF8lcnjS35
         akMYckSlXT8wn3OAST7d+7RvESj2kbi1P1YBgKbTKBI2jRUVjDL46GrmD572/TcfmJPs
         nQqA==
X-Gm-Message-State: AC+VfDyCWS/3exbwWX/FzBB95hiLEiPAe3W3NMjV42bM6nlrtSAmzp/C
        fGkR72bBJ3yGGbvmZ7LdiGLJ3/hG7JTOZf7csok=
X-Google-Smtp-Source: ACHHUZ7KRY8XEGhwfVFFo5DieOOubp5CnxYIqbObSz7wiSGN51Mw9OLbpXptTNivJP5h5Mk+CqOnDDhckaVnC4C/y1w=
X-Received: by 2002:a81:a014:0:b0:565:9f61:c771 with SMTP id
 x20-20020a81a014000000b005659f61c771mr1748377ywg.9.1685440340332; Tue, 30 May
 2023 02:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230512104559.11218-1-victor.shih@genesyslogic.com.tw>
 <20230512104559.11218-4-victor.shih@genesyslogic.com.tw> <8e8f7a8c-bb7d-3e8a-7c3e-af95f4effe4e@intel.com>
In-Reply-To: <8e8f7a8c-bb7d-3e8a-7c3e-af95f4effe4e@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Tue, 30 May 2023 17:52:09 +0800
Message-ID: <CAK00qKDOeHQjYGz079yYqWYkOD9dWwMrAabKBOdLU7nxaQywug@mail.gmail.com>
Subject: Re: [PATCH V1 3/3] mmc: sdhci-pci-gli: Add support SD Express card
 for GL9767
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
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

On Mon, May 29, 2023 at 5:36=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 12/05/23 13:45, Victor Shih wrote:
> > Add support SD Express card for GL9767. The workflow of the
> > SD Express card in GL9767 is as below.
> > 1. GL9767 operates in SD mode and set MMC_CAP2_SD_EXP flag.
> > 2. If card is inserted, Host send CMD8 to ask the capabilities
> >    of the card.
> > 3. If the card has PCIe capability and write protect is not
> >    enable, then init_sd_express() will be invoked.
>
> Could explain about why not write protect
>

I will update the commit message as below in Patch v2:
If the card has been put in write protect state then the SD features suppor=
ted
by SD mode but not supported by PCIe mode, therefore GL9767 will switch
to SD mode.

> > 4. GL9767 switch from SD mode to PCIe/NVMe mode and mmc driver
> >    handover control to NVMe driver.
> > 5. If card is removed, GL9767 will return to SD mode.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> As Ben pointed out, please try to use the same email address
> for From: and Signed-off-by:
>

I will be careful about this in the Patch v2.

> > ---
> >  drivers/mmc/host/sdhci-pci-gli.c | 115 +++++++++++++++++++++++++++++++
> >  1 file changed, 115 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-=
pci-gli.c
> > index 300512740cb0..a0f9c24439be 100644
> > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > @@ -158,6 +158,13 @@
> >  #define   GLI_9767_VHS_REV_M   0x1
> >  #define   GLI_9767_VHS_REV_W   0x2
> >
> > +#define PCIE_GLI_9767_CFG            0x8A0
> > +#define   PCIE_GLI_9767_CFG_LOW_PWR_OFF        BIT(12)
> > +
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
> > @@ -175,6 +182,27 @@
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
> > +#define   PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SDEI_GEN_TIMER     =
 GENMASK(1, 0)
> > +
> > +#define PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_EN_REG2                   =
       0x954
> > +#define   PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_EN_REG2_SDEI_COMPLETE_ST=
ATUS_EN          GENMASK(1, 0)
> > +
> > +#define PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2                   =
       0x958
> > +#define   PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2_SDEI_COMPLETE_SI=
GNAL_EN          GENMASK(1, 0)
> > +
> >  #define GLI_MAX_TUNING_LOOP 40
> >
> >  /* Genesys Logic chipset */
> > @@ -774,6 +802,91 @@ static void sdhci_gl9767_reset(struct sdhci_host *=
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
> > +     if (sdhci_check_ro(host)) {
>
> I think mmc->get_ro(mmc) would be fine here instead.
>

I will update it in Patch v2.

> > +             mmc->ios.timing &=3D ~(MMC_TIMING_SD_EXP | MMC_TIMING_SD_=
EXP_1_2V);
> > +             return 0;
> > +     }
> > +
> > +     pci_read_config_dword(pdev, PCIE_GLI_9767_VHS, &value);
> > +     value &=3D ~GLI_9767_VHS_REV;
> > +     value |=3D FIELD_PREP(GLI_9767_VHS_REV, GLI_9767_VHS_REV_W);
> > +     pci_write_config_dword(pdev, PCIE_GLI_9767_VHS, value);
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
> > +     value |=3D PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SDEI_GEN_TIME=
R;
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
> > +     for (i =3D 0; i < 10; i++) {
> > +             mdelay(10);
>
> This should be msleep() or usleep_range()
>

I will update this in Patch v2.

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
> > +     pci_read_config_dword(pdev, PCIE_GLI_9767_VHS, &value);
> > +     value &=3D ~GLI_9767_VHS_REV;
> > +     value |=3D FIELD_PREP(GLI_9767_VHS_REV, GLI_9767_VHS_REV_R);
> > +     pci_write_config_dword(pdev, PCIE_GLI_9767_VHS, value);
> > +
> > +     return 0;
> > +}
> > +
> >  static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
> >  {
> >       struct sdhci_host *host =3D slot->host;
> > @@ -806,6 +919,8 @@ static int gli_probe_slot_gl9767(struct sdhci_pci_s=
lot *slot)
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
