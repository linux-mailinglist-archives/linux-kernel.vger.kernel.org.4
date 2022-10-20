Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727C8605935
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiJTIA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiJTIAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:00:09 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75913B9B7;
        Thu, 20 Oct 2022 00:59:59 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c24so19582023pls.9;
        Thu, 20 Oct 2022 00:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m0JeBN7iCUk6q5jQRpN/rZt1LaJzoUAVMeSbf0WL1SE=;
        b=Wfrqsu9VOmpoP8iwnJkiaek2AXhF6PNbi6rWD6xS8/FCoT8EKjLpMBXaz2ABs0BA2+
         Wk5wLYtxWnxhMsaTosHne2pC7ur5sR4GUGOWHFgYXXK0HGsd3xnetwQM2U2AckGQTmIF
         N+wZvQnM/o0BGg+/vHAF+ZTicHOuRBQ9m0Ouf+r/PR6DxzJybb4mXLm4BjjGcKJStPYI
         YoVX7kIU17SVLmU3Z5nP+2rPo5ZZK9H7F9itfBoS76JP9sx8QlSmbZ7BQeTXgU53s57z
         O8zMoR+7B2MNQFA/TW+CPP3jtKCTs+X/IS8H7qov4Teq71TX+ZTuYBLKCgNaDzYj5CDq
         Nw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m0JeBN7iCUk6q5jQRpN/rZt1LaJzoUAVMeSbf0WL1SE=;
        b=Te8bQZ+i9j1mSzDfQqwB534xckcvOGPbqKsaqF781Njh2noAk7sp0P9bm1oF+I8olK
         ARHhlUuhmtoesE0mecc7KCDyVkIV7Dlx7rNyTkHds/q3EnM7EtzycLXOWHWHw8uisHWn
         k4ZitEFMMAZoP72axmsQgSDKjBqkbuADF5AjOeF3lm0y7NR2raPxZccSrj+QeeTSi0OX
         le3F+YuBenj1NZQM6+aIw6J4t7xgBQnHOC0r0Lhk7HR8NCWCYiUNj758tJPGdQK2/E4I
         vZEJi8st+01ygdDvKKzsQFOtyKdFOHabpoK6jSQ+Gfl69+WnPjgXqrHc4QyTP545QzSq
         0r/g==
X-Gm-Message-State: ACrzQf2dAOGvEFhdaMTbcv8A5YhGcxAeoDc1R+CESfT1kuhO0UiUbIf0
        Mne8upqV2DIUb4rZaIJ5AWFTGoXIocqkPpRZHFY=
X-Google-Smtp-Source: AMsMyM6UZswHEmp54Pt+aaGlMrzuIVZcJjU0NPz0CXtMUf0TcvGPnU5mXpJIKKg07XpUm5df+4IyscyYQta1KWwAMFc=
X-Received: by 2002:a17:902:e5c9:b0:186:4f8a:d6a with SMTP id
 u9-20020a170902e5c900b001864f8a0d6amr10289295plf.150.1666252781166; Thu, 20
 Oct 2022 00:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20221020024529.25227-1-wenchao.chen666@gmail.com> <DM6PR04MB6575C38931D2BB4A560A355BFC2A9@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB6575C38931D2BB4A560A355BFC2A9@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Wenchao Chen <wenchao.chen666@gmail.com>
Date:   Thu, 20 Oct 2022 15:59:19 +0800
Message-ID: <CA+Da2qwKRCNhz78tVOaUaTfLiPN1b-ycOZ2_X_N7D8ZeACRQRg@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: Support Host to control FUA.
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "kch@nvidia.com" <kch@nvidia.com>,
        "CLoehle@hyperstone.com" <CLoehle@hyperstone.com>,
        "vincent.whitchurch@axis.com" <vincent.whitchurch@axis.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "s.shtylyov@omp.ru" <s.shtylyov@omp.ru>,
        "michael@allwinnertech.com" <michael@allwinnertech.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "megoo.tang@gmail.com" <megoo.tang@gmail.com>,
        "lzx.stg@gmail.com" <lzx.stg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 3:44 PM Avri Altman <Avri.Altman@wdc.com> wrote:
>
> > According to the above data, disable FUA (fua_disable = 1) improves the
> > performance. Therefore, it is recommended to support the host to control
> > FUA.
> >
> > Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> > ---
> >  drivers/mmc/core/block.c | 3 ++-
> >  include/linux/mmc/host.h | 3 +++
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
> > 54cd009aee50..333e819e077a 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -2490,7 +2490,8 @@ static struct mmc_blk_data
> > *mmc_blk_alloc_req(struct mmc_card *card,
> >             ((card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN) ||
> >              card->ext_csd.rel_sectors)) {
> >                 md->flags |= MMC_BLK_REL_WR;
> > -               fua_enabled = true;
> > +               if (!card->host->fua_disable)
> > +                       fua_enabled = true;
> Where are you allowing to set fua_disable?
> And then I would expect you to call blk_queue_flag_set to set QUEUE_FLAG_FUA.
>
> Thanks,
> Avri
Hi Avri
We will implement sdhci_sprd_probe in sdhci-sprd.c host->fua_disable = true;
Because sdhci_sprd_probe is before mmc_blk_alloc_req, calling blk_queue_flag_set
directly will also be updated.

Thanks,
Wenchao
>
> >                 cache_enabled = true;
> >         }
> >         if (mmc_cache_enabled(card->host)) diff --git
> > a/include/linux/mmc/host.h b/include/linux/mmc/host.h index
> > 8fdd3cf971a3..16a5bee3eeae 100644
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -517,6 +517,9 @@ struct mmc_host {
> >         struct blk_crypto_profile crypto_profile;  #endif
> >
> > +       /* Host FUA support */
> > +       bool                    fua_disable;
> > +
> >         /* Host Software Queue support */
> >         bool                    hsq_enabled;
> >
> > --
> > 2.17.1
>
