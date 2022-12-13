Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7388864B175
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 09:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbiLMIsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 03:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234734AbiLMIrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 03:47:32 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCBA1ADAC;
        Tue, 13 Dec 2022 00:47:24 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id h8so6224774qkk.8;
        Tue, 13 Dec 2022 00:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pGG6ZW+lYihsXmI8GwHIIRxe8K+AaMY4NpX1pOlDRQw=;
        b=CNbKH13Zv92oc72+p/iZRB6RfRVpQ/pXiJRgS4ygl05XYnXX7Tslr5+T7H2cdErJuT
         IRT1uXcM2DZVRXG+CZsw4zIDqMTV/BWAFZlw9M+PqvRGLJvcoQ6WnNyVK4pgKNznT7+W
         bsc8MAGobRXTW/+ZC5MAy6QF2l+GU2XdvSJ1Ig16Sjc3ARMbuxLTpDfR2lFErmkuv+bx
         aQavB7PNwyUwVUdB/FIE5CLNvGZuZoRNrSg6+z5EP0qEi+UEH4KMEtW6g6lPdspQUf6M
         0cXwR+/+F5gAuHGVeh4pceJ+pGqidVUKl5VQxgsV7HY3wGKIG8j75UzGZGGv2D7Qsp/p
         Ns7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pGG6ZW+lYihsXmI8GwHIIRxe8K+AaMY4NpX1pOlDRQw=;
        b=txAiY/HyF935LdfoFckeaA6xmGi84ZvmeKgbm6mTihASO6TU5YqmOwTbNd1gy2fyn3
         A1NLQL9pJrVzAjqEzOoUysURGYaFnQnrSadGbURMKQx+QK0aSWKGJ6+YapQevFzp3Wqh
         ILucpYAnaMl3uZSuEeU/TaP9hyPcnQP6dWQuQvjpgpG/KiRG+hWBsW7Z+Rd5Xw0RIWBj
         CKBfu0YDnQs12pA0MfeMOmSso0zztSezrzmB3S3p9GEo4/UDDQKEO5maSv3wqZfc2LT6
         KcCRP+muJUEaVYNqvhMUc3sCOG28/WUb+lHhsa5Exjlh8S0tnmxL0oiaixgQii7ey5iE
         PWQg==
X-Gm-Message-State: ANoB5pmdehTobfhwQyd7MEubp8NcSmYOnCVUKx4Bx5GNZ8rqmWFSlgnz
        oZtX/iNrwViQ9rHFe627eEhWoYJLdHDtIpQDABQ=
X-Google-Smtp-Source: AA0mqf7fLZ1Fu71DHEEYa3RnfBmr9Wsm3+sNErqqD704G1rynE0tWDdRn30Ycg04/Ork6QgDBS08sVZydKRftd5HRig=
X-Received: by 2002:a37:8ac2:0:b0:6fa:442d:f4d3 with SMTP id
 m185-20020a378ac2000000b006fa442df4d3mr83183380qkd.665.1670921244203; Tue, 13
 Dec 2022 00:47:24 -0800 (PST)
MIME-Version: 1.0
References: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
 <20221019110647.11076-17-victor.shih@genesyslogic.com.tw> <e889d37c-8034-7e0f-70aa-1ac07bce32da@intel.com>
In-Reply-To: <e889d37c-8034-7e0f-70aa-1ac07bce32da@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Tue, 13 Dec 2022 16:47:11 +0800
Message-ID: <CAK00qKAiUqb-SUmVV=d+TVr3b_qigJc28D4OWgw5Z4q+MG3npw@mail.gmail.com>
Subject: Re: [PATCH V5 16/26] mmc: sdhci-uhs2: add detect_init() to detect the interface
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

On Wed, Nov 2, 2022 at 1:14 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 19/10/22 14:06, Victor Shih wrote:
> > Sdhci_uhs2_do_detect_init() is a sdhci version of mmc's uhs2_detect_init
> > operation. After detected, the host's UHS-II capabilities will be set up
> > here and interrupts will also be enabled.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 146 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 146 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> > index b535a47dc55a..9ceae552c323 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -409,12 +409,158 @@ int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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
> > +     sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK,
> > +                               SDHCI_UHS2_ERR_INT_STATUS_MASK);
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
> > +     caps_ptr = sdhci_readw(host, SDHCI_UHS2_HOST_CAPS_PTR);
> > +     if (caps_ptr < 0x100 || caps_ptr > 0x1FF) {
> > +             pr_err("%s: SDHCI_UHS2_HOST_CAPS_PTR(%d) is wrong.\n",
> > +                    mmc_hostname(mmc), caps_ptr);
> > +             return -ENODEV;
> > +     }
> > +     caps_gen = sdhci_readl(host,
> > +                            caps_ptr + SDHCI_UHS2_HOST_CAPS_GEN_OFFSET);
>
> Please wrap at 100 columns not 80, here and elsewhere.
>

I will update it in the patch#15 of the new [PATCH V6].

> > +     caps_phy = sdhci_readl(host,
> > +                            caps_ptr + SDHCI_UHS2_HOST_CAPS_PHY_OFFSET);
> > +     caps_tran[0] = sdhci_readl(host,
> > +                                caps_ptr + SDHCI_UHS2_HOST_CAPS_TRAN_OFFSET);
> > +     caps_tran[1] = sdhci_readl(host,
> > +                                caps_ptr
> > +                                     + SDHCI_UHS2_HOST_CAPS_TRAN_1_OFFSET);
> > +
> > +     /* General Caps */
> > +     mmc->uhs2_caps.dap = caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_DAP_MASK;
> > +     mmc->uhs2_caps.gap = (caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_GAP_MASK) >>
> > +                          SDHCI_UHS2_HOST_CAPS_GEN_GAP_SHIFT;
> > +     mmc->uhs2_caps.n_lanes = (caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_LANE_MASK)
> > +                     >> SDHCI_UHS2_HOST_CAPS_GEN_LANE_SHIFT;
> > +     mmc->uhs2_caps.addr64 =
> > +             (caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_ADDR_64) ? 1 : 0;
> > +     mmc->uhs2_caps.card_type =
> > +             (caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_MASK) >>
> > +             SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_SHIFT;
> > +
> > +     /* PHY Caps */
> > +     mmc->uhs2_caps.phy_rev = caps_phy & SDHCI_UHS2_HOST_CAPS_PHY_REV_MASK;
> > +     mmc->uhs2_caps.speed_range =
> > +             (caps_phy & SDHCI_UHS2_HOST_CAPS_PHY_RANGE_MASK)
> > +             >> SDHCI_UHS2_HOST_CAPS_PHY_RANGE_SHIFT;
> > +     mmc->uhs2_caps.n_lss_sync =
> > +             (caps_phy & SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_SYN_MASK)
> > +             >> SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_SYN_SHIFT;
> > +     mmc->uhs2_caps.n_lss_dir =
> > +             (caps_phy & SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_DIR_MASK)
> > +             >> SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_DIR_SHIFT;
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
> > +     mmc->uhs2_caps.link_rev =
> > +             caps_tran[0] & SDHCI_UHS2_HOST_CAPS_TRAN_LINK_REV_MASK;
> > +     mmc->uhs2_caps.n_fcu =
> > +             (caps_tran[0] & SDHCI_UHS2_HOST_CAPS_TRAN_N_FCU_MASK)
> > +             >> SDHCI_UHS2_HOST_CAPS_TRAN_N_FCU_SHIFT;
> > +     if (mmc->uhs2_caps.n_fcu == 0)
> > +             mmc->uhs2_caps.n_fcu = 256;
> > +     mmc->uhs2_caps.host_type =
> > +             (caps_tran[0] & SDHCI_UHS2_HOST_CAPS_TRAN_HOST_TYPE_MASK)
> > +             >> SDHCI_UHS2_HOST_CAPS_TRAN_HOST_TYPE_SHIFT;
> > +     mmc->uhs2_caps.maxblk_len =
> > +             (caps_tran[0] & SDHCI_UHS2_HOST_CAPS_TRAN_BLK_LEN_MASK)
> > +             >> SDHCI_UHS2_HOST_CAPS_TRAN_BLK_LEN_SHIFT;
> > +     mmc->uhs2_caps.n_data_gap =
> > +             caps_tran[1] & SDHCI_UHS2_HOST_CAPS_TRAN_1_N_DATA_GAP_MASK;
> > +
> > +     return 0;
> > +}
> > +
> > +static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
> > +{
> > +     struct sdhci_host *host = mmc_priv(mmc);
> > +     int ret = -EIO;
> > +
> > +     DBG("%s: begin UHS2 init.\n", __func__);
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
> > +     sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK,
> > +                               SDHCI_UHS2_ERR_INT_STATUS_MASK);
> > +     /*
> > +      * !!! SDHCI_INT_ENABLE and SDHCI_SIGNAL_ENABLE was cleared
>
> !!! is a little dramatic, what about just N.B.
>

I will update it in the patch#15 of the new [PATCH V6].

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
> >               sdhci_uhs2_start_signal_voltage_switch;
> >       host->mmc_host_ops.uhs2_set_ios = sdhci_uhs2_set_ios;
> >
> > +     if (!host->mmc_host_ops.uhs2_detect_init)
> > +             host->mmc_host_ops.uhs2_detect_init = sdhci_uhs2_do_detect_init;
>
> As mentioned before ->uhs2_detect_init() is never called.
>
> > +
> >       return 0;
> >  }
> >
>

Thanks, Victor Shih
