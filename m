Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2DD5F41FF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 13:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiJDL3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 07:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiJDL3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 07:29:12 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11DD2BE39
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 04:29:10 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id x1so12411035plv.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 04:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=fYmF0v6edG3jotaZJ/G1Q7T6WIGmDDAg4ZH0RyU9M/E=;
        b=n+BJXHd8FTNb7IKnwVLJVeaZSPg3EuxhAfb8egQy3Rwd4S2sjtmvWIyUrgVRp5F35d
         RZx3BuRDhJ2dRO/6aC9Z5ibCMJseN6EqTLRisfFNFAgiBaqXy2uCd2wCya2X5tVWe85g
         +IWykzZpQWdfbRomHgMWBUa/j9kgwXlPWGC+uLeh8X9CGjnb0ifMIdy1IGD6y1Pj0Zs1
         v9Dx9QFTxsw86i4/sfkc72TOCXURtDg5ajxHL6TCkcPkVcnGzsCXLqRj3AueATaTXz5V
         1JA4cWonPtw4OE/YaPwUKfx9ggtQWm88NssA7pNZcawixwvE2hQ1ZiLrpuUQtxIzxsGd
         TjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fYmF0v6edG3jotaZJ/G1Q7T6WIGmDDAg4ZH0RyU9M/E=;
        b=ShX0VnJ/KT1pywEI0Xelq3wo0BOpo1b7EkYcodxGOpXd21/MlWT6MUKJm4cqBMfyVL
         fUV36DwLdOZF1oX6POOZQxoJ8swuj31dCzjlOnWfN0hRvVhPiseAKB4rCrkE/v7LOt9T
         ElKgZbWXrclshnoN3LGJ+AXamzC36sMuphg01z1QfBEYIyI4sYxiWXylKZboZxJ2InIV
         mF9skaCtbUo1EYIlWdHzHoraEyrcx6t0L3v3OV68+6V1dYy1GZQY5xm5HwLmw1oDRIDF
         ulLjyiSxhbRKjH2JwYjXD4xNcKTWxtjf723mXXFjjZ8j+Yoap3g+rUayay9DxhV/FEQ1
         PLFg==
X-Gm-Message-State: ACrzQf2+Sbi8nEbRRMXJElsPCCX7sTwzT0pnVl7kgKR130GBiFNUqa++
        ZvjocVUaH3ufcNnDa5wzWn2QLH0deQFJ8KcWIrAezw==
X-Google-Smtp-Source: AMsMyM6q8Slt5TIHDFbD1QSXjpu9RB4PmI/iJfGAhD/f6guF1RkBnr9COEAj/tWlF0VVDrmXIXhZOWIlQ4fSloLLej4=
X-Received: by 2002:a17:903:246:b0:179:96b5:1ad2 with SMTP id
 j6-20020a170903024600b0017996b51ad2mr26111032plh.37.1664882949585; Tue, 04
 Oct 2022 04:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220928095744.16455-1-avri.altman@wdc.com> <DM6PR04MB65758C73ABC2DD731167158BFC5B9@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB65758C73ABC2DD731167158BFC5B9@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 4 Oct 2022 13:28:32 +0200
Message-ID: <CAPDyKFqC8FskROQQbCqx5zHS8e4ci4OmekTHE+gFTR6SzUH4Ow@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: core: SD: Add BROKEN-SD-DISCARD quirk
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Oct 2022 at 00:01, Avri Altman <Avri.Altman@wdc.com> wrote:
>
> Ulf hi,
> I would appreciate if you could take a 2nd look at this,
> So it would make it to 6.1.

I am preparing the pull request for v6.1-rc1, so this won't be part of that.

Although, we can still queue this as a fix for v6.1-rc2 - and we
should also tag this for stable kernels, right!?

>
> Thanks,
> Avri
>

Kind regards
Uffe


> > v1 -> v2:
> >  - Address Ulf's suggestions
> >
> > Some SD-cards that are SDA-6.0 compliant reports they supports discard
> > while they actually don't.  This might cause mk2fs to fail while trying
> > to format the card and revert it to a read-only mode.
> >
> > While at it, add SD MID for SANDISK. This is because eMMC MID is assign
> > by JEDEC and SD MID is assigned by SD 3c-LLC.
> >
> > Signed-off-by: Avri Altman <avri.altman@wdc.com>
> > ---
> >  drivers/mmc/core/block.c  | 6 +++++-
> >  drivers/mmc/core/card.h   | 6 ++++++
> >  drivers/mmc/core/quirks.h | 6 ++++++
> >  include/linux/mmc/card.h  | 1 +
> >  4 files changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > index ce89611a136e..54cd009aee50 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -1140,8 +1140,12 @@ static void mmc_blk_issue_discard_rq(struct
> > mmc_queue *mq, struct request *req)
> >  {
> >       struct mmc_blk_data *md = mq->blkdata;
> >       struct mmc_card *card = md->queue.card;
> > +     unsigned int arg = card->erase_arg;
> >
> > -     mmc_blk_issue_erase_rq(mq, req, MMC_BLK_DISCARD, card-
> > >erase_arg);
> > +     if (mmc_card_broken_sd_discard(card))
> > +             arg = SD_ERASE_ARG;
> > +
> > +     mmc_blk_issue_erase_rq(mq, req, MMC_BLK_DISCARD, arg);
> >  }
> >
> >  static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
> > diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> > index 99045e138ba4..cfdd1ff40b86 100644
> > --- a/drivers/mmc/core/card.h
> > +++ b/drivers/mmc/core/card.h
> > @@ -73,6 +73,7 @@ struct mmc_fixup {
> >  #define EXT_CSD_REV_ANY (-1u)
> >
> >  #define CID_MANFID_SANDISK      0x2
> > +#define CID_MANFID_SANDISK_SD   0x3
> >  #define CID_MANFID_ATP          0x9
> >  #define CID_MANFID_TOSHIBA      0x11
> >  #define CID_MANFID_MICRON       0x13
> > @@ -258,4 +259,9 @@ static inline int mmc_card_broken_hpi(const struct
> > mmc_card *c)
> >       return c->quirks & MMC_QUIRK_BROKEN_HPI;
> >  }
> >
> > +static inline int mmc_card_broken_sd_discard(const struct mmc_card *c)
> > +{
> > +     return c->quirks & MMC_QUIRK_BROKEN_SD_DISCARD;
> > +}
> > +
> >  #endif
> > diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> > index be4393988086..29b9497936df 100644
> > --- a/drivers/mmc/core/quirks.h
> > +++ b/drivers/mmc/core/quirks.h
> > @@ -100,6 +100,12 @@ static const struct mmc_fixup __maybe_unused
> > mmc_blk_fixups[] = {
> >       MMC_FIXUP("V10016", CID_MANFID_KINGSTON, CID_OEMID_ANY,
> > add_quirk_mmc,
> >                 MMC_QUIRK_TRIM_BROKEN),
> >
> > +     /*
> > +      * Some SD cards reports discard support while they don't
> > +      */
> > +     MMC_FIXUP(CID_NAME_ANY, CID_MANFID_SANDISK_SD, 0x5344,
> > add_quirk_sd,
> > +               MMC_QUIRK_BROKEN_SD_DISCARD),
> > +
> >       END_FIXUP
> >  };
> >
> > diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> > index 8a30de08e913..c726ea781255 100644
> > --- a/include/linux/mmc/card.h
> > +++ b/include/linux/mmc/card.h
> > @@ -293,6 +293,7 @@ struct mmc_card {
> >  #define MMC_QUIRK_BROKEN_IRQ_POLLING (1<<11) /* Polling
> > SDIO_CCCR_INTx could create a fake interrupt */
> >  #define MMC_QUIRK_TRIM_BROKEN        (1<<12)         /* Skip trim */
> >  #define MMC_QUIRK_BROKEN_HPI (1<<13)         /* Disable broken HPI
> > support */
> > +#define MMC_QUIRK_BROKEN_SD_DISCARD  (1<<14) /* Disable broken SD
> > discard support */
> >
> >       bool                    reenable_cmdq;  /* Re-enable Command Queue
> > */
> >
> > --
> > 2.17.1
>
