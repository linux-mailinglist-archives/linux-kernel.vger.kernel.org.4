Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941725EC1CB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbiI0LqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiI0LqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:46:00 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFC0D74C7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:45:58 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id u16-20020a05600c211000b003b5152ebf09so6707422wml.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=cW0PFtHcH315+P0IZunq5r81rk9eIqO6kj1c7fq1huU=;
        b=Th7sqnFELyColCbuae7tXbk4PnDEkUn3Ig4VEp9sVP1gllvkr+Qa3B7E95QONDpJ1v
         RZ+YW48X3RpnSobBhdthpGZXx2sSyZFrA8kXTmrPbFdnrx8LhmyKSGWRmBzfIptwdYmo
         D8qYQy9TVogvtTd63dsfCiipqCfHpqQ2mSO7rAKHlp/3O/dHL/Bo780OAyDHwZtx0008
         V8QEj/sKh74wIr9KaOaMx8ypw3evK8Pm10SNvXjVoRo6COYv5gjrsIb4d9Nrb1IvuFgy
         nD5DVkgLJ8kJCbLWMmtgDvWKvBwMSL17T6DWISLISg+n6+v0HH+idm2tx3u2hoWbOgoS
         RVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=cW0PFtHcH315+P0IZunq5r81rk9eIqO6kj1c7fq1huU=;
        b=WmpUTs5yS0wJ/+QkZlVhcbajikWZUQ1OQuVydqilx4t65Ng9y30xp7LTlyLtlj7kC0
         ywPWjh9eHfPBY45ZwAgdIz629e6oG217fFxu8FOWEq/St3vRz+FewA+1N8JseowbGQnt
         5y+XM4JQKLKNauIziMQLAZK3RsNR5y1G/g3A0d5WicTui6/pEh2Q91rP2/9BGkTo7jRB
         M6tQglkUaWHCjfRBDkKWeL25tWa5H2dGB5X0ggzfbgk6L5O1lF3qmGHUn5nnnF71/ODa
         DoSUf6ekM1JwVietsgjIhwx2N7yqDz0dAAOY11Rj/KnJB2bzxzenoQpD8XA4cQmnyAdG
         rGQQ==
X-Gm-Message-State: ACrzQf28D6CE5XKBsyaHmNoIFAQRS0Cw3XyS8+wAgjKVys0XfK06gUXu
        iPVIWGbXhr31Sp2mIdbkvlvUL4VlVY4gFeg1TB493w==
X-Google-Smtp-Source: AMsMyM7P+f509M72pNs5+zL9lV4mgm5EFtN+3jo5Pk3JHiE+HZ1cILCZDE6oXX9GIq/dkHnMZc+AJ6PahlgLSMV5hNc=
X-Received: by 2002:a05:600c:4f8d:b0:3b4:9f2f:4311 with SMTP id
 n13-20020a05600c4f8d00b003b49f2f4311mr2262067wmq.17.1664279157160; Tue, 27
 Sep 2022 04:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220923135617.46-1-avri.altman@wdc.com>
In-Reply-To: <20220923135617.46-1-avri.altman@wdc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 27 Sep 2022 13:45:20 +0200
Message-ID: <CAPDyKFr2+PmmmOoOo-YzaogdaCRCW=CB2PdZcSGdoMjOj0zA_A@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: SD: Add BROKEN-SD-DISCARD quirk
To:     Avri Altman <avri.altman@wdc.com>
Cc:     linux-mmc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sept 2022 at 15:56, Avri Altman <avri.altman@wdc.com> wrote:
>
> Some SD-cards that are SDA-6.0 compliant reports they supports discard
> while they actually don't.  This might cause mk2fs to fail while trying
> to format the card and revert it to a read-only mode.
>
> While at it, add SD MID for SANDISK. This is because eMMC MID is assign
> by JEDEC and SD MID is assigned by SD 3c-LLC.
>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/mmc/core/block.c  | 6 +++++-
>  drivers/mmc/core/card.h   | 1 +
>  drivers/mmc/core/quirks.h | 6 ++++++
>  include/linux/mmc/card.h  | 1 +
>  4 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index ce89611a136e..a31dc915c5ec 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1140,8 +1140,12 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
>  {
>         struct mmc_blk_data *md = mq->blkdata;
>         struct mmc_card *card = md->queue.card;
> +       unsigned int arg = card->erase_arg;
>
> -       mmc_blk_issue_erase_rq(mq, req, MMC_BLK_DISCARD, card->erase_arg);
> +       if (mmc_card_sd(card) && (card->quirks & MMC_QUIRK_BROKEN_SD_DISCARD))

There's no need for the mmc_card_sd() here, as the quirk can't be set
unless it's the SD card type (see add_quirk_sd()).

Moreover, I would prefer if we can use a helper function
(mmc_card_broken_sd_discard()), that checks the new quirk bit. Similar
helpers are already available in drivers/mmc/core/card.h.

> +               arg = SD_ERASE_ARG;
> +
> +       mmc_blk_issue_erase_rq(mq, req, MMC_BLK_DISCARD, arg);
>  }
>
>  static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> index 99045e138ba4..881432309b46 100644
> --- a/drivers/mmc/core/card.h
> +++ b/drivers/mmc/core/card.h
> @@ -73,6 +73,7 @@ struct mmc_fixup {
>  #define EXT_CSD_REV_ANY (-1u)
>
>  #define CID_MANFID_SANDISK      0x2
> +#define CID_MANFID_SANDISK_SD   0x3
>  #define CID_MANFID_ATP          0x9
>  #define CID_MANFID_TOSHIBA      0x11
>  #define CID_MANFID_MICRON       0x13
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index be4393988086..29b9497936df 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -100,6 +100,12 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
>         MMC_FIXUP("V10016", CID_MANFID_KINGSTON, CID_OEMID_ANY, add_quirk_mmc,
>                   MMC_QUIRK_TRIM_BROKEN),
>
> +       /*
> +        * Some SD cards reports discard support while they don't
> +        */
> +       MMC_FIXUP(CID_NAME_ANY, CID_MANFID_SANDISK_SD, 0x5344, add_quirk_sd,
> +                 MMC_QUIRK_BROKEN_SD_DISCARD),
> +
>         END_FIXUP
>  };
>
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 8a30de08e913..c726ea781255 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -293,6 +293,7 @@ struct mmc_card {
>  #define MMC_QUIRK_BROKEN_IRQ_POLLING   (1<<11) /* Polling SDIO_CCCR_INTx could create a fake interrupt */
>  #define MMC_QUIRK_TRIM_BROKEN  (1<<12)         /* Skip trim */
>  #define MMC_QUIRK_BROKEN_HPI   (1<<13)         /* Disable broken HPI support */
> +#define MMC_QUIRK_BROKEN_SD_DISCARD    (1<<14) /* Disable broken SD discard support */
>
>         bool                    reenable_cmdq;  /* Re-enable Command Queue */
>
> --
> 2.17.1
>

Other than the minor nitpicks above, this looks good to me!

Kind regards
Uffe
