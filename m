Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6556E7020BA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 02:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbjEOAPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 20:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjEOAPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 20:15:10 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB67AE6C;
        Sun, 14 May 2023 17:15:08 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50bceaf07b8so22079136a12.3;
        Sun, 14 May 2023 17:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684109707; x=1686701707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZYkWxyeoGcMPPZjWMJ8tL0VIfezGs1FZL2C/Wu5QG0=;
        b=SRnzom0jUM6DK4bUTf7F1c/m0bHbdtEIZRGTzF2k2awjYh/hGnqnUnpMNJVFDHqlm7
         MHH3WpAoUyyqw8mtqUVrrF8z2EVFkdEEBP9VN28Se5OQx73bd2NmvWOObbFhrbTkp1xW
         sqK2eNkuccUA+cxk1qjweN2qoBiv3np+QmuIx5oGy70+ylOHCid7i2U3dEm1ow5ogpVK
         Cf9jjcqp74ZMrX5bUT9HK2kH0xAIpgjT1obvg/VZBjDGLANoRT5bzECtj3YlL26DCLcg
         hKjx1f3OctGsXo3BFXDoZDFJqt5XWCPsc0G4Im5Y7jAErUm6zBFzhzSKtl1tH3UJUSLr
         hqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684109707; x=1686701707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZYkWxyeoGcMPPZjWMJ8tL0VIfezGs1FZL2C/Wu5QG0=;
        b=d2t87lt2po4t4DPrVGJB1zTuG/7Q4PkWQ/eBSUMht6FC5XYh1qPUu+gOPf9ojgUum9
         IiigVQwCx8g8JlxpXfvbQ48no2CmCz4Gn7dRCECq1Y0WufdZiX0w1CQord2aD+POg8ee
         lOaWsAxoFiQHO56dSNJDTwjrrhW9gHlRPae/xmCdndr2zyvhYsXPeRahvQqPSScqgmHU
         MDaiuJgKkch6Uk+XwuwXcOdQP5q5MjlSeADU1WZL4ihxdjFQ29CJb3didAHoauKsGsH8
         LKgrRgTBWAui68QKfejrXWpOwPjjT1m9VWERa7VcHTdeuRKcYQ4w+nK62HV/EsujLvbt
         2BKg==
X-Gm-Message-State: AC+VfDzAXGbMwMFq3nXdBNHmy0jPm13wVmMy3qqy8VEexi/LdoVVmDCy
        V1cnPHyNiACEbIHOkp2s6OUwE44w+X2oheUJjL0XQp2gcZE=
X-Google-Smtp-Source: ACHHUZ5p1MZC4WIGFCsPKqqprki9AzgfFhVWheLJTrNF9ZFSEqi5eFqDvAjrJelVPDqy5e6m10+hBD2kaoZcNDq0FcU=
X-Received: by 2002:a50:eb47:0:b0:50d:f9b3:444c with SMTP id
 z7-20020a50eb47000000b0050df9b3444cmr8292900edp.17.1684109707143; Sun, 14 May
 2023 17:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230512104559.11218-1-victor.shih@genesyslogic.com.tw> <20230512104559.11218-4-victor.shih@genesyslogic.com.tw>
In-Reply-To: <20230512104559.11218-4-victor.shih@genesyslogic.com.tw>
From:   Ben Chuang <benchuanggli@gmail.com>
Date:   Mon, 15 May 2023 08:14:55 +0800
Message-ID: <CACT4zj8EXyizQLnb837pzg8kEURWrO4BkVeRmtDUmTo6yh9E+g@mail.gmail.com>
Subject: Re: [PATCH V1 3/3] mmc: sdhci-pci-gli: Add support SD Express card
 for GL9767
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Hi Victor,

On Fri, May 12, 2023 at 6:47=E2=80=AFPM Victor Shih <victorshihgli@gmail.co=
m> wrote:
>
> Add support SD Express card for GL9767. The workflow of the
> SD Express card in GL9767 is as below.
> 1. GL9767 operates in SD mode and set MMC_CAP2_SD_EXP flag.
> 2. If card is inserted, Host send CMD8 to ask the capabilities
>    of the card.
> 3. If the card has PCIe capability and write protect is not
>    enable, then init_sd_express() will be invoked.
> 4. GL9767 switch from SD mode to PCIe/NVMe mode and mmc driver
>    handover control to NVMe driver.
> 5. If card is removed, GL9767 will return to SD mode.
>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 115 +++++++++++++++++++++++++++++++
>  1 file changed, 115 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pc=
i-gli.c
> index 300512740cb0..a0f9c24439be 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -158,6 +158,13 @@
>  #define   GLI_9767_VHS_REV_M     0x1
>  #define   GLI_9767_VHS_REV_W     0x2
>
> +#define PCIE_GLI_9767_CFG              0x8A0
> +#define   PCIE_GLI_9767_CFG_LOW_PWR_OFF          BIT(12)
> +
> +#define PCIE_GLI_9767_COMBO_MUX_CTL                    0x8C8
> +#define   PCIE_GLI_9767_COMBO_MUX_CTL_RST_EN             BIT(6)
> +#define   PCIE_GLI_9767_COMBO_MUX_CTL_WAIT_PERST_EN      BIT(10)
> +
>  #define PCIE_GLI_9767_PWR_MACRO_CTL                                    0=
x8D0
>  #define   PCIE_GLI_9767_PWR_MACRO_CTL_LOW_VOLTAGE                       =
 GENMASK(3, 0)
>  #define   PCIE_GLI_9767_PWR_MACRO_CTL_LD0_LOW_OUTPUT_VOLTAGE            =
 GENMASK(15, 12)
> @@ -175,6 +182,27 @@
>  #define   PCIE_GLI_9767_SCR_CORE_PWR_D3_OFF              BIT(21)
>  #define   PCIE_GLI_9767_SCR_CFG_RST_DATA_LINK_DOWN       BIT(30)
>
> +#define PCIE_GLI_9767_SDHC_CAP                 0x91C
> +#define   PCIE_GLI_9767_SDHC_CAP_SDEI_RESULT     BIT(5)
> +
> +#define PCIE_GLI_9767_SD_EXPRESS_CTL                   0x940
> +#define   PCIE_GLI_9767_SD_EXPRESS_CTL_SDEI_EXE                  BIT(0)
> +#define   PCIE_GLI_9767_SD_EXPRESS_CTL_SD_EXPRESS_MODE   BIT(1)
> +
> +#define PCIE_GLI_9767_SD_DATA_MULTI_CTL                                0=
x944
> +#define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME        GENMASK=
(23, 16)
> +#define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME_VALUE         =
 0x64
> +
> +#define PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2                       0=
x950
> +#define   PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SDEI_COMPLETE        =
 BIT(0)
> +#define   PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SDEI_GEN_TIMER       =
 GENMASK(1, 0)
> +
> +#define PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_EN_REG2                     =
       0x954
> +#define   PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_EN_REG2_SDEI_COMPLETE_STAT=
US_EN    GENMASK(1, 0)
> +
> +#define PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2                     =
       0x958
> +#define   PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2_SDEI_COMPLETE_SIGN=
AL_EN    GENMASK(1, 0)
> +
>  #define GLI_MAX_TUNING_LOOP 40
>
>  /* Genesys Logic chipset */
> @@ -774,6 +802,91 @@ static void sdhci_gl9767_reset(struct sdhci_host *ho=
st, u8 mask)
>         gli_set_9767(host);
>  }
>
> +static int gl9767_init_sd_express(struct mmc_host *mmc, struct mmc_ios *=
ios)
> +{
> +       struct sdhci_host *host =3D mmc_priv(mmc);
> +       struct sdhci_pci_slot *slot =3D sdhci_priv(host);
> +       struct pci_dev *pdev;
> +       u32 value;
> +       int i;
> +
> +       pdev =3D slot->chip->pdev;
> +
> +       if (sdhci_check_ro(host)) {
> +               mmc->ios.timing &=3D ~(MMC_TIMING_SD_EXP | MMC_TIMING_SD_=
EXP_1_2V);
> +               return 0;
> +       }
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9767_VHS, &value);
> +       value &=3D ~GLI_9767_VHS_REV;
> +       value |=3D FIELD_PREP(GLI_9767_VHS_REV, GLI_9767_VHS_REV_W);
> +       pci_write_config_dword(pdev, PCIE_GLI_9767_VHS, value);
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9767_COMBO_MUX_CTL, &value);
> +       value &=3D ~(PCIE_GLI_9767_COMBO_MUX_CTL_RST_EN | PCIE_GLI_9767_C=
OMBO_MUX_CTL_WAIT_PERST_EN);
> +       pci_write_config_dword(pdev, PCIE_GLI_9767_COMBO_MUX_CTL, value);
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_CTL, &val=
ue);
> +       value &=3D ~PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME;
> +       value |=3D FIELD_PREP(PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_=
TIME,
> +                           PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TI=
ME_VALUE);
> +       pci_write_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_CTL, val=
ue);
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_R=
EG2, &value);
> +       value |=3D PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SDEI_GEN_TIME=
R;
> +       pci_write_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_=
REG2, value);
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_E=
N_REG2, &value);
> +       value |=3D PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_EN_REG2_SDEI_COMPL=
ETE_STATUS_EN;
> +       pci_write_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_=
EN_REG2, value);
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_E=
N_REG2, &value);
> +       value |=3D PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2_SDEI_COMPL=
ETE_SIGNAL_EN;
> +       pci_write_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_=
EN_REG2, value);
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
> +       value |=3D PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> +       pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
> +
> +       value =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +       value &=3D ~(SDHCI_CLOCK_CARD_EN | SDHCI_CLOCK_PLL_EN);
> +       sdhci_writew(host, value, SDHCI_CLOCK_CONTROL);
> +
> +       value =3D sdhci_readb(host, SDHCI_POWER_CONTROL);
> +       value |=3D ((SDHCI_POWER_180 | SDHCI_POWER_ON) << 4);
> +       sdhci_writeb(host, value, SDHCI_POWER_CONTROL);
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL, &value)=
;
> +       value |=3D PCIE_GLI_9767_SD_EXPRESS_CTL_SDEI_EXE;
> +       pci_write_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL, value)=
;
> +
> +       for (i =3D 0; i < 10; i++) {
> +               mdelay(10);

A little question.
Can you explain or comment on the reason for up to 10 loops (max. 100 ms wa=
it),
For example "because of asic specs..." or "hardware measurements".

Best regards,
Ben

> +               pci_read_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_=
STATUS_REG2, &value);
> +               if (value & PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SDEI=
_COMPLETE) {
> +                       pci_write_config_dword(pdev, PCIE_GLI_9767_NORMAL=
_ERR_INT_STATUS_REG2,
> +                                              value);
> +                       break;
> +               }
> +       }
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9767_SDHC_CAP, &value);
> +       if ((value & PCIE_GLI_9767_SDHC_CAP_SDEI_RESULT) =3D=3D PCIE_GLI_=
9767_SDHC_CAP_SDEI_RESULT) {
> +               pci_read_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL,=
 &value);
> +               value |=3D PCIE_GLI_9767_SD_EXPRESS_CTL_SD_EXPRESS_MODE;
> +               pci_write_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL=
, value);
> +       } else {
> +               mmc->ios.timing &=3D ~(MMC_TIMING_SD_EXP | MMC_TIMING_SD_=
EXP_1_2V);
> +       }
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9767_VHS, &value);
> +       value &=3D ~GLI_9767_VHS_REV;
> +       value |=3D FIELD_PREP(GLI_9767_VHS_REV, GLI_9767_VHS_REV_R);
> +       pci_write_config_dword(pdev, PCIE_GLI_9767_VHS, value);
> +
> +       return 0;
> +}
> +
>  static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
>  {
>         struct sdhci_host *host =3D slot->host;
> @@ -806,6 +919,8 @@ static int gli_probe_slot_gl9767(struct sdhci_pci_slo=
t *slot)
>         gl9767_hw_setting(slot);
>         gli_pcie_enable_msi(slot);
>         slot->host->mmc->caps2 |=3D MMC_CAP2_NO_SDIO;
> +       host->mmc->caps2 |=3D MMC_CAP2_SD_EXP;
> +       host->mmc_host_ops.init_sd_express =3D gl9767_init_sd_express;
>         sdhci_enable_v4_mode(host);
>
>         return 0;
> --
> 2.25.1
>
