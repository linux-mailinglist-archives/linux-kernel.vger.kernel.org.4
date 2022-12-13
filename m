Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB7564B171
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 09:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbiLMIrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 03:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234779AbiLMIqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 03:46:39 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1981AD93;
        Tue, 13 Dec 2022 00:46:31 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id e1so5975092qka.6;
        Tue, 13 Dec 2022 00:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tDPr0fpArfbAT11l9y8Es1gHLy3bCKZmwebapZm2QRI=;
        b=AmK1Xl9lXti90JFwJZbcQuVKXE3J+0BbY7Mhs2zoueCkPuUB9wHirQvp0SRpF1+8KE
         Y1Tj8oyDzE+hICbBvbmsZM6Af8Kk2N1QubRBuFK7Zid79EGHPrQ4rWOZ1Gg4DhJ74+8w
         yrIjkdf8JOvoozaKEhHv+NpD05K/DX2l0kYXA4IUaixy+oynSNOi4aSRQDJuSFW1ctSA
         9zd72UB/hpsnTO2ilvfGJU9yFXWTO6eAsLXVa+dyw35arCWrkgNHHHjzM/P1GBNFIaq5
         Bxn3JVY+gROSqz51mqkpagb23/4y+oAOeLU7oCFOPQaGPfe3PoXZG+ekd1WBXInyKmeP
         DcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDPr0fpArfbAT11l9y8Es1gHLy3bCKZmwebapZm2QRI=;
        b=Lk4i8kMv8bc2bB0rH3B2xdMI3DAiRK3F+FoxOdqCKSe62Djyc71RpqAsT1epfm1yWB
         8LnxpzGjDHMyanuAjBZ/Hv291b6Togfg5ClD+oOrI25LlIiXxUJjHQKX7NLmsA/Vbv8F
         ftwM6FLwid+hawE6Fj1n4QLCP5Lk/F98mcKJSi8m/ZYtw/VqBpxuqeNBY4/Sunnm5x4Q
         cE0FwUZuFmmITFafkv/5YWyMhcqsPpcwG+t1i+KH6VBqUnZNIMrs853XvhUERwnromWR
         LeHL5hPPVYQ/frcrW74hSvLsDsfFbvRyuojGr6nt4mcZrrr/3KGWi7gAqMoGHK0xL+2f
         GiAw==
X-Gm-Message-State: ANoB5pnJ4DUghee0wr96nVSoVeuPE5rmFUnQVS+CAEjeetkxf13zuvwW
        2sePu4k+SXHkmi9+OQeekEPDzvd3xx+NHwPF0R8=
X-Google-Smtp-Source: AA0mqf5naCnDsj/fnTc1u8kjJ30TCFkMevh3MZ7b/NOma1V9O3Mv+lW/W2HTnrdDqgEl7cRVqJKpbad3ejA2vxvMr4g=
X-Received: by 2002:a37:9ad2:0:b0:6fc:cdf8:dfe2 with SMTP id
 c201-20020a379ad2000000b006fccdf8dfe2mr17754880qke.580.1670921190998; Tue, 13
 Dec 2022 00:46:30 -0800 (PST)
MIME-Version: 1.0
References: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
 <20221019110647.11076-15-victor.shih@genesyslogic.com.tw> <f8b3feee-8372-a469-1853-45fb2738740d@intel.com>
In-Reply-To: <f8b3feee-8372-a469-1853-45fb2738740d@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Tue, 13 Dec 2022 16:46:18 +0800
Message-ID: <CAK00qKArihMMDt7bRR+ycC+qKwaHXBPDv38+dLRBPToKQZKocw@mail.gmail.com>
Subject: Re: [PATCH V5 14/26] mmc: sdhci-uhs2: add set_timeout()
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
> > From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >
> > This is a UHS-II version of sdhci's set_timeout() operation.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 85 +++++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci-uhs2.h |  1 +
> >  2 files changed, 86 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> > index 4dc3e904d7d2..2b90e5308764 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -196,6 +196,91 @@ void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
> >  }
> >  EXPORT_SYMBOL_GPL(sdhci_uhs2_set_power);
> >
> > +static u8 sdhci_calc_timeout_uhs2(struct sdhci_host *host, u8 *cmd_res,
> > +                               u8 *dead_lock)
> > +{
> > +     u8 count;
> > +     unsigned int cmd_res_timeout, dead_lock_timeout, current_timeout;
> > +
> > +     /*
> > +      * If the host controller provides us with an incorrect timeout
> > +      * value, just skip the check and use 0xE.  The hardware may take
> > +      * longer to time out, but that's much better than having a too-short
> > +      * timeout value.
> > +      */
> > +     if (host->quirks & SDHCI_QUIRK_BROKEN_TIMEOUT_VAL) {
> > +             *cmd_res = 0xE;
> > +             *dead_lock = 0xE;
> > +             return 0xE;
> > +     }
>
> Let's skip quirks you don't need for now.
>

I will update it in the patch#13 of the new [PATCH V6].

> > +
> > +     /* timeout in us */
> > +     cmd_res_timeout = 5 * 1000;
> > +     dead_lock_timeout = 1 * 1000 * 1000;
> > +
> > +     /*
> > +      * Figure out needed cycles.
> > +      * We do this in steps in order to fit inside a 32 bit int.
> > +      * The first step is the minimum timeout, which will have a
> > +      * minimum resolution of 6 bits:
> > +      * (1) 2^13*1000 > 2^22,
> > +      * (2) host->timeout_clk < 2^16
> > +      *     =>
> > +      *     (1) / (2) > 2^6
> > +      */
> > +     count = 0;
> > +     current_timeout = (1 << 13) * 1000 / host->timeout_clk;
> > +     while (current_timeout < cmd_res_timeout) {
> > +             count++;
> > +             current_timeout <<= 1;
> > +             if (count >= 0xF)
> > +                     break;
> > +     }
> > +
> > +     if (count >= 0xF) {
> > +             DBG("%s: Too large timeout 0x%x requested for CMD_RES!\n",
> > +                 mmc_hostname(host->mmc), count);
> > +             count = 0xE;
> > +     }
> > +     *cmd_res = count;
> > +
> > +     count = 0;
> > +     current_timeout = (1 << 13) * 1000 / host->timeout_clk;
> > +     while (current_timeout < dead_lock_timeout) {
> > +             count++;
> > +             current_timeout <<= 1;
> > +             if (count >= 0xF)
> > +                     break;
> > +     }
> > +
> > +     if (count >= 0xF) {
> > +             DBG("%s: Too large timeout 0x%x requested for DEADLOCK!\n",
> > +                 mmc_hostname(host->mmc), count);
> > +             count = 0xE;
> > +     }
> > +     *dead_lock = count;
> > +
> > +     return count;
> > +}
> > +
> > +static void __sdhci_uhs2_set_timeout(struct sdhci_host *host)
> > +{
> > +     u8 cmd_res, dead_lock;
> > +
> > +     sdhci_calc_timeout_uhs2(host, &cmd_res, &dead_lock);
> > +     cmd_res |= dead_lock << SDHCI_UHS2_TIMER_CTRL_DEADLOCK_SHIFT;
>
> GENMASK() and FIELD_PREP() please
>
> > +     sdhci_writeb(host, cmd_res, SDHCI_UHS2_TIMER_CTRL);
> > +}
> > +
> > +void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
> > +{
> > +     __sdhci_set_timeout(host, cmd);
> > +
> > +     if (host->mmc->flags & MMC_UHS2_SUPPORT)
>
>         if (sdhci_uhs2_mode(host))
>

I will update it in the patch#13 of the new [PATCH V6].

> > +             __sdhci_uhs2_set_timeout(host);
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_uhs2_set_timeout);
> > +
> >  /*****************************************************************************\
> >   *                                                                           *
> >   * MMC callbacks                                                             *
> > diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
> > index 3179915f7f79..5ea235b14108 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.h
> > +++ b/drivers/mmc/host/sdhci-uhs2.h
> > @@ -215,5 +215,6 @@ bool sdhci_uhs2_mode(struct sdhci_host *host);
> >  void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
> >  void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
> >                         unsigned short vdd);
> > +void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
> >
> >  #endif /* __SDHCI_UHS2_H */
>

Thanks, Victor Shih
