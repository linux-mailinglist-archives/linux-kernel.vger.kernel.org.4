Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4CB6A1A13
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjBXKXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjBXKXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:23:14 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E610928223;
        Fri, 24 Feb 2023 02:23:02 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id x1so14641500qtw.3;
        Fri, 24 Feb 2023 02:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=brjvwtMJAJiZwKBHpvvak/n6D45GUYI3DhvIrAt5W/8=;
        b=A/w189WH1XLu7LU9NdNEUXhkPOt3hlayN0+eZQvGLNBNM7xUyvFfpQqjhv4fT3lr16
         sqQZauWDessBHgekioIEhkqigm0Xu3hkFY7NoYeJfZMBWgj/fKubvvmkWocGcu6ffGTb
         2WUTQORC5R+4t5NHiwNYdWx9KOWUK9pW3Wy36xxL+VoEZ1sgDqv2/a6fVN+e2XNwv0Xu
         kO3GUp94pldSW58ZAAvil5Of9JuHMpT6fnONcAR2sHjvFCcrJ3VLG4BDJrv2rm6Devls
         5jWtkWae4d3HqstWO+7RiZieTdfWTlD5ooK2eaphUOpMUyx8eGp1YfwZg75kc9Wn6UJd
         5akQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=brjvwtMJAJiZwKBHpvvak/n6D45GUYI3DhvIrAt5W/8=;
        b=usymXGap9RDvRerWIM5uarXb0aA+h1aZS8ZA6N8+Wc/5s6gwTH/JmZwMn06YBArMRv
         21LMtA+UhaugbRa4Hf6pP000/h0b8Y4j3yNzaPg6y4saypFHFMUn9Be9ibxnkNMQXKxw
         q16CWE11iSeljqtTRjR9B0Z/cHKGTe5I5hdxs25nn9h6utbSr0APvdGvG+vADbg4SOUF
         T1EvsGONzujsgoYwWd6CCCJAWJKQ+z3HJBcHab4mjDkxZQHyITw+J/tfi/2fXzY8Pl88
         y9Hm+/PYXI8rahWbanSHocydBmR5tWoE/eY5Lh5mOlS9oLLxUMZVflwORPhZjTk+6MhQ
         UlbQ==
X-Gm-Message-State: AO0yUKX01xo8kj9tMIjyk+KAX9HmG4BhnS5KfrOSJCBI4Ay7b03isfTR
        karlQz30HgH+BK4vuUjczym6R5JBKXYTl32ojQg=
X-Google-Smtp-Source: AK7set9aZmN6mIctAMgOOYFkZ63MAmp9e6GmYCnyfe1Tf/cIZKPe8pVNqJbNDCcSa0kDzi7Owf2kzLHOIi5HQIWvKZ8=
X-Received: by 2002:ac8:159:0:b0:3bd:119d:d606 with SMTP id
 f25-20020ac80159000000b003bd119dd606mr2889747qtg.10.1677234181313; Fri, 24
 Feb 2023 02:23:01 -0800 (PST)
MIME-Version: 1.0
References: <20221213090047.3805-1-victor.shih@genesyslogic.com.tw>
 <20221213090047.3805-18-victor.shih@genesyslogic.com.tw> <d032a567-51ed-44b4-6040-1d721ac00d09@intel.com>
In-Reply-To: <d032a567-51ed-44b4-6040-1d721ac00d09@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Fri, 24 Feb 2023 18:22:49 +0800
Message-ID: <CAK00qKDVm=KyPknEPV+GL6Zq5nsq0-Pk2Hfw7a2H3jpFZtWyJQ@mail.gmail.com>
Subject: Re: [PATCH V6 17/24] mmc: sdhci-uhs2: add uhs2_control() to
 initialise the interface
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

On Fri, Jan 6, 2023 at 5:28 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 13/12/22 11:00, Victor Shih wrote:
> > This is a sdhci version of mmc's uhs2_set_reg operation.
> > UHS-II interface (related registers) will be initialised here.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 92 +++++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci.c      | 11 +++++
> >  2 files changed, 103 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> > index c7e411fa0a6e..de15a6559702 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -276,6 +276,48 @@ static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >       sdhci_set_clock(host, host->clock);
> >  }
> >
> > +static void sdhci_uhs2_set_config(struct sdhci_host *host)
> > +{
> > +     u32 value;
> > +     u16 sdhci_uhs2_set_ptr = sdhci_readw(host, SDHCI_UHS2_SETTINGS_PTR);
> > +     u16 sdhci_uhs2_gen_set_reg = (sdhci_uhs2_set_ptr + 0);
> > +     u16 sdhci_uhs2_phy_set_reg = (sdhci_uhs2_set_ptr + 4);
> > +     u16 sdhci_uhs2_tran_set_reg = (sdhci_uhs2_set_ptr + 8);
> > +     u16 sdhci_uhs2_tran_set_1_reg = (sdhci_uhs2_set_ptr + 12);
> > +
> > +     /* Set Gen Settings */
> > +     value = FIELD_PREP(SDHCI_UHS2_GEN_SETTINGS_N_LANES_MASK, host->mmc->uhs2_caps.n_lanes_set);
> > +     sdhci_writel(host, value, sdhci_uhs2_gen_set_reg);
> > +
> > +     /* Set PHY Settings */
> > +     value = FIELD_PREP(SDHCI_UHS2_PHY_N_LSS_DIR_MASK, host->mmc->uhs2_caps.n_lss_dir_set) |
> > +             FIELD_PREP(SDHCI_UHS2_PHY_N_LSS_SYN_MASK, host->mmc->uhs2_caps.n_lss_sync_set);
> > +     if (host->mmc->flags & MMC_UHS2_SPEED_B)
> > +             value |= SDHCI_UHS2_PHY_SET_SPEED_B;
> > +     sdhci_writel(host, value, sdhci_uhs2_phy_set_reg);
> > +
> > +     /* Set LINK-TRAN Settings */
> > +     value = FIELD_PREP(SDHCI_UHS2_TRAN_RETRY_CNT_MASK, host->mmc->uhs2_caps.max_retry_set) |
> > +             FIELD_PREP(SDHCI_UHS2_TRAN_N_FCU_MASK, host->mmc->uhs2_caps.n_fcu_set);
> > +     sdhci_writel(host, value, sdhci_uhs2_tran_set_reg);
> > +     sdhci_writel(host, host->mmc->uhs2_caps.n_data_gap_set, sdhci_uhs2_tran_set_1_reg);
> > +}
> > +
> > +static int sdhci_uhs2_check_dormant(struct sdhci_host *host)
> > +{
> > +     u32 val;
> > +     /* 100ms */
> > +     int timeout = 100000;
> > +
> > +     if (read_poll_timeout_atomic(sdhci_readl, val, (val & SDHCI_UHS2_IN_DORMANT_STATE),
> > +                                  100, timeout, true, host, SDHCI_PRESENT_STATE)) {
> > +             pr_warn("%s: UHS2 IN_DORMANT fail in 100ms.\n", mmc_hostname(host->mmc));
> > +             sdhci_dumpregs(host);
> > +             return -EIO;
> > +     }
> > +     return 0;
> > +}
> > +
> >  /*****************************************************************************\
> >   *                                                                           *
> >   * MMC callbacks                                                             *
> > @@ -361,6 +403,55 @@ static int sdhci_uhs2_enable_clk(struct mmc_host *mmc)
> >       return 0;
> >  }
> >
> > +static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc);
> > +
> > +static int sdhci_uhs2_control(struct mmc_host *mmc, enum sd_uhs2_operation op)
> > +{
> > +     struct sdhci_host *host = mmc_priv(mmc);
> > +     int err = 0;
> > +     u16 sdhci_uhs2_set_ptr = sdhci_readw(host, SDHCI_UHS2_SETTINGS_PTR);
> > +     u16 sdhci_uhs2_phy_set_reg = (sdhci_uhs2_set_ptr + 4);
> > +
> > +     DBG("Begin uhs2 control, act %d.\n", op);
> > +
> > +     switch (op) {
> > +     case UHS2_PHY_INIT:
> > +             err = sdhci_uhs2_do_detect_init(mmc);
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
> > +     case UHS2_SET_SPEED_B:
> > +             sdhci_writeb(host, SDHCI_UHS2_PHY_SET_SPEED_B, sdhci_uhs2_phy_set_reg);
> > +             break;
> > +     case UHS2_CHECK_DORMANT:
> > +             err = sdhci_uhs2_check_dormant(host);
> > +             break;
> > +     case UHS2_DISABLE_CLK:
> > +             err = sdhci_uhs2_disable_clk(mmc);
> > +             break;
> > +     case UHS2_ENABLE_CLK:
> > +             err = sdhci_uhs2_enable_clk(mmc);
> > +             break;
> > +     case UHS2_POST_ATTACH_SD:
> > +             host->ops->uhs2_post_attach_sd(host);
> > +             break;
> > +     default:
> > +             pr_err("%s: input sd uhs2 operation %d is wrong!\n",
> > +                    mmc_hostname(host->mmc), op);
> > +             err = -EIO;
> > +             break;
> > +     }
> > +
> > +     return err;
> > +}
> > +
> >  /*****************************************************************************\
> >   *                                                                           *
> >   * Driver init/exit                                                          *
> > @@ -489,6 +580,7 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
> >       host->mmc_host_ops.start_signal_voltage_switch =
> >               sdhci_uhs2_start_signal_voltage_switch;
> >       host->mmc_host_ops.uhs2_set_ios = sdhci_uhs2_set_ios;
> > +     host->mmc_host_ops.uhs2_control = sdhci_uhs2_control;
> >
> >       return 0;
> >  }
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 49bbdc155b2b..3656e66fcca7 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -234,6 +234,17 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
> >  }
> >  EXPORT_SYMBOL_GPL(sdhci_reset);
> >
> > +void sdhci_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set)
> > +{
> > +     u32 ier;
> > +
> > +     ier = sdhci_readl(host, SDHCI_INT_ENABLE);
> > +     ier &= ~clear;
> > +     ier |= set;
> > +     sdhci_writel(host, ier, SDHCI_INT_ENABLE);
> > +     sdhci_writel(host, ier, SDHCI_SIGNAL_ENABLE);
> > +}
>
> Not used anymore
>

I will drop it and update in V7 version.

> > +
> >  static bool sdhci_do_reset(struct sdhci_host *host, u8 mask)
> >  {
> >       if (host->quirks & SDHCI_QUIRK_NO_CARD_NO_RESET) {
>

Thanks, Victor Shih
