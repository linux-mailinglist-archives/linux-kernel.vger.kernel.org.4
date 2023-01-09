Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4AE6624AF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 12:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237044AbjAILwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 06:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236907AbjAILwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 06:52:24 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D621160DD
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 03:52:20 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 18so12114059edw.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 03:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aj54tILATw6IjxGXVi89331IRiw4NYazC/2sU/ZkN+Y=;
        b=BCCCQEKmZL84Juhc7zGZCXjtK4wyyaCN4hfIM+xbNBfxo2cKpGp5cR4DCifuTkUzdJ
         jhxXnBeM3XShSj/wMrYO9jfOrTHerhq4Vlf73TjgoH7s5JZVtNkCYE2WPHJrhaTcXe6z
         CG+cq6MEKS/MALB+m8YJxvYIHuuPd6kDIx5CA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aj54tILATw6IjxGXVi89331IRiw4NYazC/2sU/ZkN+Y=;
        b=WsxLcnarEohil64jIcfNFwmcnw0SV0L7lH6b6vhJEcFNKUn122PM/2hVKgGj9rzuwe
         RIRBWU70LX6ZC5EnFTl9viTfen7OKusckfYa+/0S+T6Zr9qK3RqCnAvov3NjrziNqUYA
         r61ZpNOxddAK4u4JfTZnPQB7Si7AmBeIxgMBWIcKPxlgod0ALV9HT7HDK9wcuO4GDkOO
         BL0rdu4ioXeZaMq2WBtaOW3KEvonPlyHMC6L3KLMcuJqEH+mIYgPibqAc93roHeFY1Fw
         5V5Aa4aKzeEQHo8bh7mOIWDz2aDSG4pYt3Y7g9kWV3pSh91uAS1vrQtcTB7igmt1wAMI
         G+FA==
X-Gm-Message-State: AFqh2kr+rtBvFKSEppU3FdeKmshhIccKpBkhka9mp38EVJ2LttGe5nJr
        rcoweOegjHjXlvnzIejOA7Ybx6p8Rgtg7qGSWfyDVw==
X-Google-Smtp-Source: AMrXdXvN+Ats8ThNe0Wauwq+5AC+Xtplphn3hZTaZBEbiZru8LtYPLmG1d5frTknSfPmN1CM7v2/wz2UX19/OcnHhq4=
X-Received: by 2002:a05:6402:a49:b0:48c:974b:cffd with SMTP id
 bt9-20020a0564020a4900b0048c974bcffdmr2271764edb.83.1673265139305; Mon, 09
 Jan 2023 03:52:19 -0800 (PST)
MIME-Version: 1.0
References: <52861a84-0fe2-37f0-d66a-145f2ebe1d79@gmail.com>
 <20221214134620.3028726-1-peter.suti@streamunlimited.com> <c6863a3e-8855-50fe-25cb-0b38bc3a05e0@gmail.com>
In-Reply-To: <c6863a3e-8855-50fe-25cb-0b38bc3a05e0@gmail.com>
From:   Peter Suti <peter.suti@streamunlimited.com>
Date:   Mon, 9 Jan 2023 12:52:08 +0100
Message-ID: <CACMGZgZY4Zb+3vHUDAS0+3r55K4_J40dtbsTPTFZMd6duBikpQ@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: meson-gx: fix SDIO interrupt handling
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 10:33 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 14.12.2022 14:46, Peter Suti wrote:
> > With the interrupt support introduced in commit 066ecde sometimes the
> > Marvell-8987 wifi chip got stuck using the marvell-sd-uapsta-8987
> > vendor driver. The cause seems to be that after sending ack to all interrupts
> > the IRQ_SDIO still happens, but it is ignored.
> >
> > To work around this, recheck the IRQ_SDIO after meson_mmc_request_done().
> >
> > Inspired by 9e2582e ("mmc: mediatek: fix SDIO irq issue") which used a
> > similar fix to handle lost interrupts.
> >
> The commit description of the referenced fix isn't clear with regard to
> who's fault it is that an interrupt can be lost. I'd interpret it being
> a silicon bug rather than a kernel/driver bug.
Unfortunately I can't confirm that the referenced bug is in the
silicon for the original commit either.
However a similar workaround works in this case too which is why I
referenced that commit.

> Not sure whether it's the case, but it's possible that both vendors use
> at least parts of the same IP in the MMC block, and therefore the issue
> pops up here too.
>
> > Fixes: 066ecde ("mmc: meson-gx: add SDIO interrupt support")
> >
> > Signed-off-by: Peter Suti <peter.suti@streamunlimited.com>
> > ---
> > Changes in v2:
> >       - use spin_lock instead of spin_lock_irqsave
> >       - only reenable interrupts if they were enabled already
> >
> > Changes in v3:
> >       - Rework the patch based on feedback from Heiner Kallweit.
> >               The IRQ does not happen on 2 CPUs and the hard IRQ is not re-entrant.
> >               But still one SDIO IRQ is lost without this change.
> >               After the ack, reading the SD_EMMC_STATUS BIT(15) is set, but
> >               meson_mmc_irq() is never called again.
> >
> >               The fix is similar to Mediatek msdc_recheck_sdio_irq().
> >               That platform also loses an IRQ in some cases it seems.
> >
> >  drivers/mmc/host/meson-gx-mmc.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> > index 6e5ea0213b47..7d3ee2f9a7f6 100644
> > --- a/drivers/mmc/host/meson-gx-mmc.c
> > +++ b/drivers/mmc/host/meson-gx-mmc.c
> > @@ -1023,6 +1023,22 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
> >       if (ret == IRQ_HANDLED)
> >               meson_mmc_request_done(host->mmc, cmd->mrq);
> >
> > +     /*
> > +     * Sometimes after we ack all raised interrupts,
> > +     * an IRQ_SDIO can still be pending, which can get lost.
> > +     *
>
> A reader may scratch his head here and wonder how the interrupt can get lost,
> and why adding a workaround instead of eliminating the root cause for losing
> the interrupt. If you can't provide an explanation why the root cause for
> losing the interrupt can't be fixed, presumably you would have to say that
> you're adding a workaround for a suspected silicon bug.
After talking to the manufacturer, we got the following explanation
for this situation:
"wifi may have dat1 interrupt coming in, without this the dat1
interrupt would be missed"
Supposedly this is fixed in their codebase.
Unfortunately we were not able to find out more and can't prepare a
patch with a proper explanation.
Thank you for reviewing.
>
> > +     * To prevent this, recheck the IRQ_SDIO here and schedule
> > +     * it to be processed.
> > +     */
> > +     raw_status = readl(host->regs + SD_EMMC_STATUS);
> > +     status = raw_status & (IRQ_EN_MASK | IRQ_SDIO);
>
> This isn't needed here. Why not simply:
>
> status = readl(host->regs + SD_EMMC_STATUS);
> if (status & IRQ_SDIO)
>   ...
>
>
> > +     if (status & IRQ_SDIO) {
> > +             spin_lock(&host->lock);
> > +             __meson_mmc_enable_sdio_irq(host->mmc, 0);
> > +             sdio_signal_irq(host->mmc);
> > +             spin_unlock(&host->lock);
> > +     }
> > +
> >       return ret;
> >  }
> >
>
