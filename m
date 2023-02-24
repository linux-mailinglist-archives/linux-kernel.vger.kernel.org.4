Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E336A1A0D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjBXKXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjBXKXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:23:07 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322DD1557A;
        Fri, 24 Feb 2023 02:22:57 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id y3so13221023qvn.4;
        Fri, 24 Feb 2023 02:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NxU50L6viC6Ws7E4tWJls1tTY7hL+eFt+CM+wgzSh6c=;
        b=oF/BjZ1Xy/Vgas/cyWNgXnQgj0SfhlRwX3VywpP/SKo2Jy8E0nYXEn1nSXZlMEJ0TE
         OWvIUMzP7R8J6WHze48ZP3XcbggXYB3o7rEoOc05lR/T3yrR+e2dLdheJe9mtD9MQ8y/
         dGiK+geDihy0o+qv3KtVIsi9ImU55AF9qi4CVRnXK1Nu5nO7TJK3Y4LvdAnoFWTE8KVh
         fLCXfrO9vnYEbB1P0CqUxNV6I/opVFEchkMUa+vPARd4VXvAdBD7xRdMu28ZTIBymnkT
         NvzoQZOYQceMYsTxusRmlDEeuG9Qw6f15bchIS0WWrTn1mkS3JBvdW4OKGJK16dhCOhl
         pA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NxU50L6viC6Ws7E4tWJls1tTY7hL+eFt+CM+wgzSh6c=;
        b=jwsuRlPFaJxGAFG0zdlqwIpFnfWXf4ICC5H9A2wFu8dgj5DAA9f1HZiHaj7j3rmZLu
         Uea4/U1Wn9rJDfjEIPdRe0P+p8Z/tuavxz5a7TBfj49y/mxLU2rerGV9YXP5pCL3cxr1
         /FmYRRqGjZPNRXtH0BbF61EYJ/CPznedWsYZQKIRXgitAGiYhl+XhfP/kffXFhzJ/SKw
         j1JB0+yj1AXOTGAxQ+hCVRw8qAK343ybqyS4cA2N/0Fdxc2CD6ddLyiutATC6iMwV5s/
         B+/vwKmoPKsiKCAOYLl/Ezm3PBSzlgNxPc8TntTt5kwUENIqT+4rnLhMwRu0DVLOiuFU
         4xLQ==
X-Gm-Message-State: AO0yUKXM3VstDLvvsmXVdeYMo1PPsGII6clFQRY0Zxib3Mcfcrp8F1oW
        bvLfe2YJNlYjLjgXEZ9DX+tY3A9SG5lSJ9L3KM8=
X-Google-Smtp-Source: AK7set9iPQshBpL8rRo6AZQbXyj0w9UCsGgOGeTsKCbfQ8wPDZV8yPogCncaCfz9cqgBvvncvlkYgK3ElGenPv3Utoo=
X-Received: by 2002:a05:6214:570b:b0:56f:378:951 with SMTP id
 lt11-20020a056214570b00b0056f03780951mr3244001qvb.1.1677234176220; Fri, 24
 Feb 2023 02:22:56 -0800 (PST)
MIME-Version: 1.0
References: <20221213090047.3805-1-victor.shih@genesyslogic.com.tw>
 <20221213090047.3805-16-victor.shih@genesyslogic.com.tw> <5f42c505-7c32-1027-d9a5-6fff7655eee6@intel.com>
In-Reply-To: <5f42c505-7c32-1027-d9a5-6fff7655eee6@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Fri, 24 Feb 2023 18:22:44 +0800
Message-ID: <CAK00qKAqBdzbYFgLRLv=JwyLzBgLAcfthE4MPusTTLU2JBBatw@mail.gmail.com>
Subject: Re: [PATCH V6 15/24] mmc: sdhci-uhs2: add detect_init() to detect the interface
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
> > Sdhci_uhs2_do_detect_init() is a sdhci version of mmc's uhs2_detect_init
> > operation. After detected, the host's UHS-II capabilities will be set up
> > here and interrupts will also be enabled.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 117 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 117 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> > index 3d52d35a91a5..52587025d5e3 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -335,6 +335,123 @@ int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >   *                                                                           *
> >  \*****************************************************************************/
> >
> > +static int sdhci_uhs2_interface_detect(struct sdhci_host *host)
> > +{
> > +     /* 100ms */
> > +     int timeout = 100000;
> > +     u32 val;
> > +
> > +     udelay(200); /* wait for 200us before check */
> > +
> > +     if (read_poll_timeout_atomic(sdhci_readl, val, (val & SDHCI_UHS2_IF_DETECT),
> > +                                  100, timeout, true, host, SDHCI_PRESENT_STATE)) {
> > +             pr_warn("%s: not detect UHS2 interface in 200us.\n", mmc_hostname(host->mmc));
> > +             sdhci_dumpregs(host);
> > +             return -EIO;
> > +     }
> > +
> > +     /* Enable UHS2 error interrupts */
> > +     sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK, SDHCI_UHS2_INT_ERROR_MASK);
> > +
> > +     /* 150ms */
> > +     timeout = 150000;
> > +     if (read_poll_timeout_atomic(sdhci_readl, val, (val & SDHCI_UHS2_LANE_SYNC),
> > +                                  100, timeout, true, host, SDHCI_PRESENT_STATE)) {
> > +             pr_warn("%s: UHS2 Lane sync fail in 150ms.\n", mmc_hostname(host->mmc));
> > +             sdhci_dumpregs(host);
> > +             return -EIO;
> > +     }
> > +
> > +     DBG("%s: UHS2 Lane synchronized in UHS2 mode, PHY is initialized.\n",
> > +         mmc_hostname(host->mmc));
> > +     return 0;
> > +}
> > +
> > +static int sdhci_uhs2_init(struct sdhci_host *host)
> > +{
> > +     u16 caps_ptr = 0;
> > +     u32 caps_gen = 0;
> > +     u32 caps_phy = 0;
> > +     u32 caps_tran[2] = {0, 0};
> > +     struct mmc_host *mmc = host->mmc;
> > +
> > +     caps_ptr = sdhci_readw(host, SDHCI_UHS2_CAPS_PTR);
> > +     if (caps_ptr < 0x100 || caps_ptr > 0x1FF) {
> > +             pr_err("%s: SDHCI_UHS2_CAPS_PTR(%d) is wrong.\n",
> > +                    mmc_hostname(mmc), caps_ptr);
> > +             return -ENODEV;
> > +     }
> > +     caps_gen = sdhci_readl(host, caps_ptr + SDHCI_UHS2_CAPS_OFFSET);
> > +     caps_phy = sdhci_readl(host, caps_ptr + SDHCI_UHS2_CAPS_PHY_OFFSET);
> > +     caps_tran[0] = sdhci_readl(host, caps_ptr + SDHCI_UHS2_CAPS_TRAN_OFFSET);
> > +     caps_tran[1] = sdhci_readl(host, caps_ptr + SDHCI_UHS2_CAPS_TRAN_1_OFFSET);
> > +
> > +     /* General Caps */
> > +     mmc->uhs2_caps.dap = caps_gen & SDHCI_UHS2_CAPS_DAP_MASK;
> > +     mmc->uhs2_caps.gap = FIELD_GET(SDHCI_UHS2_CAPS_GAP_MASK, caps_gen);
> > +     mmc->uhs2_caps.n_lanes = FIELD_GET(SDHCI_UHS2_CAPS_LANE_MASK, caps_gen);
> > +     mmc->uhs2_caps.addr64 = (caps_gen & SDHCI_UHS2_CAPS_ADDR_64) ? 1 : 0;
> > +     mmc->uhs2_caps.card_type = FIELD_GET(SDHCI_UHS2_CAPS_DEV_TYPE_MASK, caps_gen);
> > +
> > +     /* PHY Caps */
> > +     mmc->uhs2_caps.phy_rev = caps_phy & SDHCI_UHS2_CAPS_PHY_REV_MASK;
> > +     mmc->uhs2_caps.speed_range = FIELD_GET(SDHCI_UHS2_CAPS_PHY_RANGE_MASK, caps_phy);
> > +     mmc->uhs2_caps.n_lss_sync = FIELD_GET(SDHCI_UHS2_CAPS_PHY_N_LSS_SYN_MASK, caps_phy);
> > +     mmc->uhs2_caps.n_lss_dir = FIELD_GET(SDHCI_UHS2_CAPS_PHY_N_LSS_DIR_MASK, caps_phy);
> > +     if (mmc->uhs2_caps.n_lss_sync == 0)
> > +             mmc->uhs2_caps.n_lss_sync = 16 << 2;
> > +     else
> > +             mmc->uhs2_caps.n_lss_sync <<= 2;
> > +     if (mmc->uhs2_caps.n_lss_dir == 0)
> > +             mmc->uhs2_caps.n_lss_dir = 16 << 3;
> > +     else
> > +             mmc->uhs2_caps.n_lss_dir <<= 3;
> > +
> > +     /* LINK/TRAN Caps */
> > +     mmc->uhs2_caps.link_rev = caps_tran[0] & SDHCI_UHS2_CAPS_TRAN_LINK_REV_MASK;
> > +     mmc->uhs2_caps.n_fcu = FIELD_GET(SDHCI_UHS2_CAPS_TRAN_N_FCU_MASK, caps_tran[0]);
> > +     if (mmc->uhs2_caps.n_fcu == 0)
> > +             mmc->uhs2_caps.n_fcu = 256;
> > +     mmc->uhs2_caps.host_type = FIELD_GET(SDHCI_UHS2_CAPS_TRAN_HOST_TYPE_MASK, caps_tran[0]);
> > +     mmc->uhs2_caps.maxblk_len = FIELD_GET(SDHCI_UHS2_CAPS_TRAN_BLK_LEN_MASK, caps_tran[0]);
> > +     mmc->uhs2_caps.n_data_gap = caps_tran[1] & SDHCI_UHS2_CAPS_TRAN_1_N_DATA_GAP_MASK;
> > +
> > +     return 0;
> > +}
> > +
> > +static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
> > +{
> > +     struct sdhci_host *host = mmc_priv(mmc);
> > +     int ret = -EIO;
> > +
> > +     DBG("Begin do uhs2 detect init.\n");
> > +
> > +     if (sdhci_uhs2_interface_detect(host)) {
> > +             pr_warn("%s: cannot detect UHS2 interface.\n",
> > +                     mmc_hostname(host->mmc));
> > +             goto out;
> > +     }
> > +
> > +     if (sdhci_uhs2_init(host)) {
> > +             pr_warn("%s: UHS2 init fail.\n", mmc_hostname(host->mmc));
> > +             goto out;
> > +     }
> > +
> > +     /* Init complete, do soft reset and enable UHS2 error irqs. */
> > +     host->ops->uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
>
> host->ops->uhs2_reset -> sdhci_uhs2_reset
>

I will update it in V7 version.

> > +     sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK, SDHCI_UHS2_INT_ERROR_MASK);
> > +     /*
> > +      * N.B SDHCI_INT_ENABLE and SDHCI_SIGNAL_ENABLE was cleared
> > +      * by SDHCI_UHS2_SW_RESET_SD
> > +      */
> > +     sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> > +     sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> > +
> > +     ret = 0;
> > +out:
> > +     return ret;
> > +}
> > +
> >  static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
> >  {
> >       host->mmc_host_ops.start_signal_voltage_switch =
>

Thanks, Victor Shih
