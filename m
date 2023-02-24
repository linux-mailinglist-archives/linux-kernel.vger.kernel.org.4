Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1971E6A1A09
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjBXKW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjBXKWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:22:52 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC00358A;
        Fri, 24 Feb 2023 02:22:50 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id c200so3442313qke.2;
        Fri, 24 Feb 2023 02:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tmfm/KdLqAFzD2EQ+ABHr9sfeoNLw4NiRWaVUc9CmoE=;
        b=DxcunPDmatY8kEbhlIUUSmSDc8zinLINUUOHXKIRPYsAUWvcXz0sMP5aWrfvae3acj
         fYlxwrDJE0YF0s4FOnidoDJhgA/yyP3n6ja+g62fHM+IjhL32ZRuikQTstruahlqTD0A
         B+Hylh3ghkMEpd59WM+4wPDeC7NNo/wcVOaQshN0nOwptKWzW/MvsgYRkd5VjUdIWQVB
         nx3tHajWH73GYxOUC4eWBM8bhOp+hS+mSrGGZrcz/AWLCvz34p1vWcuMqb3wlg+C4tRn
         uGwyr2GPWFF5wci/oMg5iYSBMvmorjaD4eKC9VFV5u1LuXFf3K6kZG4zyEFcG+LJ3jhs
         VwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tmfm/KdLqAFzD2EQ+ABHr9sfeoNLw4NiRWaVUc9CmoE=;
        b=mUCs+z6VKEmQzFoMXjIw+uoiIpjU2FVl01yvfghVgKcgC+t6QIhn5bj8bHnpOcgeQt
         Apf/B3Zc4lkQ3wMYyjRtkNQAb9UGUF/9i2Al3OrfrnNbbkJx7d+IyJ7tJnTq9Dql8ssI
         3sJYXug9HJ3AEsiGyeQ0t1BX+YrHyxuOJU8hz96Jvh+hJaWl7q2GVndeCjNjkkyqwyHg
         FW3CAcVxWaQipwdftFP2w3evqvl7Q27wGqcfr+wfBw+pGadxF2P/qvpXkYUhJfvAeLmF
         qvC9Ev7mor1qlxv3hgLgEvugVzjUMvNG+K/4FolBe3/79BHghTu3uJZZdCpEVU7gvj8c
         M5qQ==
X-Gm-Message-State: AO0yUKUQ4qsMMWKCQ20DaEC6o2bYzaiYNRplcp9qbkufX3dCRnto8TPZ
        KJX2xyi1yAemyhTDGj/h110+c7YsodpXh+4kOCw=
X-Google-Smtp-Source: AK7set/woBbI075c5CFSqPPpMIpQ/g0A3jLDzzkT+E73fuSBSs5YrAmtQZvXUrzXrl/gNHasdwYv3tZoOCK/lU7z6ag=
X-Received: by 2002:a05:620a:4710:b0:72b:25b4:565a with SMTP id
 bs16-20020a05620a471000b0072b25b4565amr3800879qkb.0.1677234169385; Fri, 24
 Feb 2023 02:22:49 -0800 (PST)
MIME-Version: 1.0
References: <20221213090047.3805-1-victor.shih@genesyslogic.com.tw>
 <20221213090047.3805-10-victor.shih@genesyslogic.com.tw> <25ad3862-0390-73e7-7abf-03298fb70a73@intel.com>
In-Reply-To: <25ad3862-0390-73e7-7abf-03298fb70a73@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Fri, 24 Feb 2023 18:22:37 +0800
Message-ID: <CAK00qKAM=VLb0crdV1ZhWDWcSUuTCKNqBAhHXTi4y7t9tQLV-A@mail.gmail.com>
Subject: Re: [PATCH V6 09/24] mmc: sdhci-uhs2: dump UHS-II registers
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

On Fri, Jan 6, 2023 at 5:26 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 13/12/22 11:00, Victor Shih wrote:
> > Dump UHS-II specific registers, if available, in sdhci_dumpregs()
> > for informative/debugging use.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 30 ++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci-uhs2.h |  4 ++++
> >  drivers/mmc/host/sdhci.c      |  3 +++
> >  drivers/mmc/host/sdhci.h      |  1 +
> >  4 files changed, 38 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> > index 8e15bd0dadee..7ea15f06fa99 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -18,6 +18,36 @@
> >  #define DRIVER_NAME "sdhci_uhs2"
> >  #define DBG(f, x...) \
> >       pr_debug(DRIVER_NAME " [%s()]: " f, __func__, ## x)
> > +#define SDHCI_UHS2_DUMP(f, x...) \
> > +     pr_err("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ## x)
> > +
> > +void sdhci_uhs2_dump_regs(struct sdhci_host *host)
> > +{
> > +     if (!(host->mmc->flags & MMC_UHS2_SUPPORT))
>
> Could make use of sdhci_uhs2_mode()
>

I will update it in V7 version.

> > +             return;
> > +
> > +     SDHCI_UHS2_DUMP("==================== UHS2 ==================\n");
> > +     SDHCI_UHS2_DUMP("Blk Size:  0x%08x | Blk Cnt:  0x%08x\n",
> > +                     sdhci_readw(host, SDHCI_UHS2_BLOCK_SIZE),
> > +                     sdhci_readl(host, SDHCI_UHS2_BLOCK_COUNT));
> > +     SDHCI_UHS2_DUMP("Cmd:       0x%08x | Trn mode: 0x%08x\n",
> > +                     sdhci_readw(host, SDHCI_UHS2_CMD),
> > +                     sdhci_readw(host, SDHCI_UHS2_TRANS_MODE));
> > +     SDHCI_UHS2_DUMP("Int Stat:  0x%08x | Dev Sel : 0x%08x\n",
> > +                     sdhci_readw(host, SDHCI_UHS2_DEV_INT_STATUS),
> > +                     sdhci_readb(host, SDHCI_UHS2_DEV_SELECT));
> > +     SDHCI_UHS2_DUMP("Dev Int Code:  0x%08x\n",
> > +                     sdhci_readb(host, SDHCI_UHS2_DEV_INT_CODE));
> > +     SDHCI_UHS2_DUMP("Reset:     0x%08x | Timer:    0x%08x\n",
> > +                     sdhci_readw(host, SDHCI_UHS2_SW_RESET),
> > +                     sdhci_readw(host, SDHCI_UHS2_TIMER_CTRL));
> > +     SDHCI_UHS2_DUMP("ErrInt:    0x%08x | ErrIntEn: 0x%08x\n",
> > +                     sdhci_readl(host, SDHCI_UHS2_INT_STATUS),
> > +                     sdhci_readl(host, SDHCI_UHS2_INT_STATUS_ENABLE));
> > +     SDHCI_UHS2_DUMP("ErrSigEn:  0x%08x\n",
> > +                     sdhci_readl(host, SDHCI_UHS2_INT_SIGNAL_ENABLE));
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
> >
> >  /*****************************************************************************\
> >   *                                                                           *
> > diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
> > index 29cd91f12b9e..a1fcd7899829 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.h
> > +++ b/drivers/mmc/host/sdhci-uhs2.h
> > @@ -172,4 +172,8 @@
> >  #define SDHCI_UHS2_EMBED_CTRL_PTR 0xE6
> >  #define SDHCI_UHS2_VENDOR_PTR     0xE8
> >
> > +struct sdhci_host;
> > +
> > +void sdhci_uhs2_dump_regs(struct sdhci_host *host);
> > +
> >  #endif /* __SDHCI_UHS2_H */
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index f3af1bd0f7b9..9b66b9a32c72 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -110,6 +110,9 @@ void sdhci_dumpregs(struct sdhci_host *host)
> >               }
> >       }
> >
> > +     if (host->ops->dump_uhs2_regs)
> > +             host->ops->dump_uhs2_regs(host);
> > +
> >       if (host->ops->dump_vendor_regs)
> >               host->ops->dump_vendor_regs(host);
> >
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index 40125ecd4e3f..f41c19c76994 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -723,6 +723,7 @@ struct sdhci_ops {
> >       void    (*request_done)(struct sdhci_host *host,
> >                               struct mmc_request *mrq);
> >       void    (*dump_vendor_regs)(struct sdhci_host *host);
> > +     void    (*dump_uhs2_regs)(struct sdhci_host *host);
> >  };
> >
> >  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
>

Thanks, Victor Shih
