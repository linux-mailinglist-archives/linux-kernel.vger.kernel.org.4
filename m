Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770B2738025
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbjFUKbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbjFUKaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:30:30 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8EE198E;
        Wed, 21 Jun 2023 03:30:07 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-78cbc37c5b1so2191464241.0;
        Wed, 21 Jun 2023 03:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687343406; x=1689935406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmU9sAN49/wEqjPoeYLfAk6bffGXJ+JIjvrbjvUNccs=;
        b=aReCgKcCa2sfKK0GJ81X1qzA6vO8WXs2+fVwiTFXt1FbtlZN9ztwB6vdYJUL0if/yA
         X2J9OZRFvED5CPJwQEvEB07t51PgBMZ/LkJWKQHS64Mr62EVvKewyX3YJy6DkxYa5ovC
         bq+TKJO0J50+awNTLUyrtpX3LPlH8QGxF5zcyN+hS1Qpivg3HqablKR/yOPSlgSWs7FE
         UkyN/HWpwJrUu3evC/dxzdtTG62iGA5RYNUKCZTS71h9gqZuJw8K/WETRX/+tqy6AvkI
         THfVi3ut+8o5dKU023U0IpH0h8EJlUHlk1Ni1swKCrzLJjVcEHX64EcYacgjm4c9BN0O
         6+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687343406; x=1689935406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rmU9sAN49/wEqjPoeYLfAk6bffGXJ+JIjvrbjvUNccs=;
        b=JA3S23J2reKUuE2UE1SLgtzCJEtIVqBbFHTAZ3NjLN4TWMb+SIhljo78n1wG1sDQcK
         1d8gdR8Ku9N85imRKu0JCmJGffvMifn3muAdJk+ErvkaitXx/8WJLIyn9VxcZ4/LLZyM
         9U+htc8M314ZN36xqOBhEkJ+kR/EyuzAXq8ZrnvUCc4WET+8RlgR2HTODSu9AlK1jou5
         C2dd8d1Vj/z0G9TCWT/PxykrGUFYocLQ51QJ2m7z5iuMn3gQ3l70Geo2Qd49T9Mi9Fsd
         4S2g15K0aVwPTXksvKj4D1VjG60QasbPBUifrP1Y63/cKkuMn3Fn2GnyVhoMJf7anKdR
         W8KQ==
X-Gm-Message-State: AC+VfDwOFqw+t76YnlkfZeeOMSGix4Xg11QQ6eIELSe0n4MfWgD5NVpm
        CGTJI+guEqhSbJS/DgovcuYLjIRIa970dj1o7Ko=
X-Google-Smtp-Source: ACHHUZ6EuCXBUlQ38EnY7I6Bu/MFlDRAXWvhV1ze0QE2UkRMfH7cT/YGFQJM2gLaauZhhnyAysQyb/luvMh9nZozp7Y=
X-Received: by 2002:a05:6102:98:b0:440:ad55:a589 with SMTP id
 t24-20020a056102009800b00440ad55a589mr5115867vsp.12.1687343406569; Wed, 21
 Jun 2023 03:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230331105546.13607-1-victor.shih@genesyslogic.com.tw>
 <20230331105546.13607-18-victor.shih@genesyslogic.com.tw> <402b9e3e-7d30-bf80-1ebe-708821e55983@intel.com>
In-Reply-To: <402b9e3e-7d30-bf80-1ebe-708821e55983@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Wed, 21 Jun 2023 18:29:53 +0800
Message-ID: <CAK00qKBNJWFF9ukBeD_KvtLeknDhwA2HJV2aka7dd5x_LsdOoQ@mail.gmail.com>
Subject: Re: [PATCH V7 17/23] mmc: sdhci-uhs2: add uhs2_control() to
 initialise the interface
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

On Wed, Apr 12, 2023 at 9:14=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 31/03/23 13:55, Victor Shih wrote:
> > This is a sdhci version of mmc's uhs2_set_reg operation.
> > UHS-II interface (related registers) will be initialised here.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 89 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 89 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs=
2.c
> > index 71ac76065886..6fe394b1a7be 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -278,6 +278,49 @@ static void __sdhci_uhs2_set_ios(struct mmc_host *=
mmc, struct mmc_ios *ios)
> >       sdhci_set_clock(host, host->clock);
> >  }
> >
> > +static void sdhci_uhs2_set_config(struct sdhci_host *host)
> > +{
> > +     u32 value;
> > +     u16 sdhci_uhs2_set_ptr =3D sdhci_readw(host, SDHCI_UHS2_SETTINGS_=
PTR);
> > +     u16 sdhci_uhs2_gen_set_reg =3D (sdhci_uhs2_set_ptr + 0);
> > +     u16 sdhci_uhs2_phy_set_reg =3D (sdhci_uhs2_set_ptr + 4);
> > +     u16 sdhci_uhs2_tran_set_reg =3D (sdhci_uhs2_set_ptr + 8);
> > +     u16 sdhci_uhs2_tran_set_1_reg =3D (sdhci_uhs2_set_ptr + 12);
>
> Perhaps line these up and lose the parentheses.
>
>         u16 sdhci_uhs2_gen_set_reg    =3D sdhci_uhs2_set_ptr;
>         u16 sdhci_uhs2_phy_set_reg    =3D sdhci_uhs2_set_ptr + 4;
>         u16 sdhci_uhs2_tran_set_reg   =3D sdhci_uhs2_set_ptr + 8;
>         u16 sdhci_uhs2_tran_set_1_reg =3D sdhci_uhs2_set_ptr + 12;
>

I will update it to the V8 version.

> > +
> > +     /* Set Gen Settings */
> > +     value =3D FIELD_PREP(SDHCI_UHS2_GEN_SETTINGS_N_LANES_MASK, host->=
mmc->uhs2_caps.n_lanes_set);
> > +     sdhci_writel(host, value, sdhci_uhs2_gen_set_reg);
> > +
> > +     /* Set PHY Settings */
> > +     value =3D FIELD_PREP(SDHCI_UHS2_PHY_N_LSS_DIR_MASK, host->mmc->uh=
s2_caps.n_lss_dir_set) |
> > +             FIELD_PREP(SDHCI_UHS2_PHY_N_LSS_SYN_MASK, host->mmc->uhs2=
_caps.n_lss_sync_set);
> > +     if (host->mmc->ios.timing =3D=3D MMC_TIMING_UHS2_SPEED_B ||
> > +         host->mmc->ios.timing =3D=3D MMC_TIMING_UHS2_SPEED_B_HD)
> > +             value |=3D SDHCI_UHS2_PHY_SET_SPEED_B;
> > +     sdhci_writel(host, value, sdhci_uhs2_phy_set_reg);
> > +
> > +     /* Set LINK-TRAN Settings */
> > +     value =3D FIELD_PREP(SDHCI_UHS2_TRAN_RETRY_CNT_MASK, host->mmc->u=
hs2_caps.max_retry_set) |
> > +             FIELD_PREP(SDHCI_UHS2_TRAN_N_FCU_MASK, host->mmc->uhs2_ca=
ps.n_fcu_set);
> > +     sdhci_writel(host, value, sdhci_uhs2_tran_set_reg);
> > +     sdhci_writel(host, host->mmc->uhs2_caps.n_data_gap_set, sdhci_uhs=
2_tran_set_1_reg);
> > +}
> > +
> > +static int sdhci_uhs2_check_dormant(struct sdhci_host *host)
> > +{
> > +     u32 val;
> > +     /* 100ms */
> > +     int timeout =3D 100000;
> > +
> > +     if (read_poll_timeout_atomic(sdhci_readl, val, (val & SDHCI_UHS2_=
IN_DORMANT_STATE),
> > +                                  100, timeout, true, host, SDHCI_PRES=
ENT_STATE)) {
>
> atomic not needed
>

I will update it to the V8 version.

> > +             pr_warn("%s: UHS2 IN_DORMANT fail in 100ms.\n", mmc_hostn=
ame(host->mmc));
> > +             sdhci_dumpregs(host);
> > +             return -EIO;
> > +     }
> > +     return 0;
> > +}
> > +
> >  /*********************************************************************=
********\
> >   *                                                                    =
       *
> >   * MMC callbacks                                                      =
       *
> > @@ -360,6 +403,51 @@ static int sdhci_uhs2_enable_clk(struct mmc_host *=
mmc)
> >       return 0;
> >  }
> >
> > +static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc);
> > +
> > +static int sdhci_uhs2_control(struct mmc_host *mmc, enum sd_uhs2_opera=
tion op)
> > +{
> > +     struct sdhci_host *host =3D mmc_priv(mmc);
> > +     struct mmc_ios *ios =3D &mmc->ios;
> > +     int err =3D 0;
> > +
> > +     DBG("Begin uhs2 control, act %d.\n", op);
> > +
> > +     switch (op) {
> > +     case UHS2_PHY_INIT:
> > +             err =3D sdhci_uhs2_do_detect_init(mmc);
> > +             break;
> > +     case UHS2_SET_CONFIG:
> > +             sdhci_uhs2_set_config(host);
> > +             break;
> > +     case UHS2_ENABLE_INT:
> > +             sdhci_uhs2_clear_set_irqs(host, 0, SDHCI_INT_CARD_INT);
> > +             break;
> > +     case UHS2_DISABLE_INT:
> > +             sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_CARD_INT, 0);
> > +             break;
> > +     case UHS2_CHECK_DORMANT:
> > +             err =3D sdhci_uhs2_check_dormant(host);
> > +             break;
> > +     case UHS2_DISABLE_CLK:
> > +             err =3D sdhci_uhs2_disable_clk(mmc);
> > +             break;
> > +     case UHS2_ENABLE_CLK:
> > +             err =3D sdhci_uhs2_enable_clk(mmc);
> > +             break;
> > +     case UHS2_SET_IOS:
> > +             err =3D sdhci_uhs2_set_ios(mmc, ios);
> > +             break;
> > +     default:
> > +             pr_err("%s: input sd uhs2 operation %d is wrong!\n",
> > +                    mmc_hostname(host->mmc), op);
> > +             err =3D -EIO;
> > +             break;
> > +     }
> > +
> > +     return err;
> > +}
> > +
> >  /*********************************************************************=
********\
> >   *                                                                    =
       *
> >   * Driver init/exit                                                   =
       *
> > @@ -487,6 +575,7 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_ho=
st *host)
> >  {
> >       host->mmc_host_ops.start_signal_voltage_switch =3D
> >               sdhci_uhs2_start_signal_voltage_switch;
> > +     host->mmc_host_ops.uhs2_control =3D sdhci_uhs2_control;
> >
> >       return 0;
> >  }
>

Thanks, Victor Shih
