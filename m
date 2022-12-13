Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B261A64B168
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 09:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbiLMIqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 03:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234798AbiLMIp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 03:45:57 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20801A3A1;
        Tue, 13 Dec 2022 00:45:56 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id ay32so11251680qtb.11;
        Tue, 13 Dec 2022 00:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tvTCz8SsoxXhcC9pujbnf6TIAiCpC9/d3HGYJmVHsoc=;
        b=quWXRSdHuXkoUnwHNL6hO/VASK1B3GBfalchrO8CUwMWhqjdZPFPT3uX1Ff4uzxqXu
         ubhiXVAZsZJBSCJTqgKgCwxQCjqsoQ0xUVYc62ICHuQ2X6f6U4RDcWpYHuq4dMsEphd9
         SOuu+cEDSck381OXMNnJAOYY/GUKXEn47g2OPEN34AYyb27h/2RQakOftuFrdjUaF/yz
         o4MidKUKkxhWhYYHvJnT+pHXJndx8oRzjahFwN0b/eDNuvX0gBQPwZoAoSmhzniQZqu8
         o8QxJz77Id6MbhDYsKuipB/IxRawHskCW1n4GEm/31b5al6VrQGRQtFixGXUcX2x30X3
         gFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tvTCz8SsoxXhcC9pujbnf6TIAiCpC9/d3HGYJmVHsoc=;
        b=MvCmIPHqcJIE01d975uM7SY2LXdZrqMDWDQ4Aig7/QNWQMwn9IK4nMfYjpxaF5RKMn
         fHKuKJDPp2igvg7+D4egnGA0Zp+bs/zv1X5XNX1NWs5EAUoIlFqtXw+XkJi11svwORUV
         NMusiot41eoVIBYTSGYbIp3QzK73hS8QAsdeUCTWjw0g5iYKEEnDb9wEdQK20pKuo9Gc
         YMYqHofAowTYRmsgSySZBbvk6JCJsf7+WU4AaGemOXXDp6HwN5TCez1V8MlkGEh+ESTy
         i9ZFnFqZWAal6RJyuoz3Y5nOgrWvYznsDWar0UFcMlMWyE4F5qGaz6ygvA/9M535WbjC
         zXAw==
X-Gm-Message-State: ANoB5pnTeCPWmACIXOWxwqrsQylPPJ8LNy10866/yhvV1BdSQYY/dL4s
        Z2em81XqRMTBM2lMo6F0txV9NkAFwQZzdhHrXhA=
X-Google-Smtp-Source: AA0mqf6wNxhjJLAjP90fjTblN2s8aEKGTtEZ6vnWHOOGL2loVoAoQM+jUfjo8swYxRdvVoBAtBd5kKDeNI631z0wTr8=
X-Received: by 2002:ac8:4245:0:b0:3a8:2080:4597 with SMTP id
 r5-20020ac84245000000b003a820804597mr158162qtm.23.1670921156010; Tue, 13 Dec
 2022 00:45:56 -0800 (PST)
MIME-Version: 1.0
References: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
 <20221019110647.11076-11-victor.shih@genesyslogic.com.tw> <3b36c596-3353-bb2c-b92f-fb475934503a@intel.com>
In-Reply-To: <3b36c596-3353-bb2c-b92f-fb475934503a@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Tue, 13 Dec 2022 16:45:43 +0800
Message-ID: <CAK00qKBT-tz1R3+BKebNFggkEU9C1JT1sOwFQY+fwMOuvMHCvw@mail.gmail.com>
Subject: Re: [PATCH V5 10/26] mmc: sdhci-uhs2: dump UHS-II registers
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

On Wed, Nov 2, 2022 at 1:13 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 19/10/22 14:06, Victor Shih wrote:
> > From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >
> > Dump UHS-II specific registers, if available, in sdhci_dumpregs()
> > for informative/debugging use.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 30 ++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci-uhs2.h |  4 ++++
> >  drivers/mmc/host/sdhci.c      |  3 +++
> >  3 files changed, 37 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> > index f29d3a4ed43c..08905ed081fb 100644
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
> > +     if (!host->mmc || !(host->mmc->flags & MMC_UHS2_SUPPORT))
>
> !host->mmc is not possible
>

I will update it in the patch#9 of the new [PATCH V6].

> > +             return;
> > +
> > +     SDHCI_UHS2_DUMP("==================== UHS2 ==================\n");
> > +     SDHCI_UHS2_DUMP("Blk Size:  0x%08x | Blk Cnt:  0x%08x\n",
> > +                     sdhci_readw(host, SDHCI_UHS2_BLOCK_SIZE),
> > +                     sdhci_readl(host, SDHCI_UHS2_BLOCK_COUNT));
> > +     SDHCI_UHS2_DUMP("Cmd:       0x%08x | Trn mode: 0x%08x\n",
> > +                     sdhci_readw(host, SDHCI_UHS2_COMMAND),
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
> > +                     sdhci_readl(host, SDHCI_UHS2_ERR_INT_STATUS),
> > +                     sdhci_readl(host, SDHCI_UHS2_ERR_INT_STATUS_EN));
> > +     SDHCI_UHS2_DUMP("ErrSigEn:  0x%08x\n",
> > +                     sdhci_readl(host, SDHCI_UHS2_ERR_INT_SIG_EN));
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
> >
> >  /*****************************************************************************\
> >   *                                                                           *
> > diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
> > index 5610affebdf3..afdb05d6056b 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.h
> > +++ b/drivers/mmc/host/sdhci-uhs2.h
> > @@ -207,4 +207,8 @@
> >  #define SDHCI_UHS2_EMBED_CTRL        0xE6
> >  #define SDHCI_UHS2_VENDOR    0xE8
> >
> > +struct sdhci_host;
> > +
> > +void sdhci_uhs2_dump_regs(struct sdhci_host *host);
> > +
> >  #endif /* __SDHCI_UHS2_H */
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index fef03de85b99..2cdd183c8ada 100644
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
>

Thanks, Victor Shih
