Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254DF6C2FBC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjCULEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjCULED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:04:03 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DC03B85A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:04:00 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id n125so16517768ybg.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679396640;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+xGaWFqZk+SjQHPaJZ22gZZSAzmIpjEZSvJQ2u7q7hU=;
        b=Esmc5EfF3KMPYOrGWpN+3uKTDp47YY+1KX3RRmSmmAovWOaUuDAcTvSeqZ6aa+IeMW
         b5K+4JqGLGmVm5oMAQYJJg/E1sIoySEQPczVHNLimG5jbDccF4Ze3VEmdZGSRm0pjbxC
         juX5JCX5YE15q/YHSfsS3zL50OgeDBCM1XJcuTGodXYp4+yNnj8E/KEFB9on1tt6qBPB
         AWqNTxMSp01qiJN2EVLNHrPgIRXVdTmIpXbvPhj5fnEXB1BBy5myUKH28C3wt5ukiPHd
         gUfe7CDu3AeWULSqAJme5NPzMFiaUhl3/pEW8wSZk0e1isHnzA2sO/xbCvhrmXon9NFG
         ayDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679396640;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+xGaWFqZk+SjQHPaJZ22gZZSAzmIpjEZSvJQ2u7q7hU=;
        b=CL0BjXFf4G6iibd7MwIgP/V04k8qDVPUVsUQ6U9os+/Ae4Wlybaba3t2DkVKJHON2m
         QsuuxYCvkc6LGk3RdtAg/0uFGGm98o3Zr1B60PMmCNK177nuBards2vIkgjRVAwPKBcM
         FAqxfnl5HlWw2jeloij8FKnhMC4cM7YNpycibOqtnvnY4+0PKRQxfztKwPf1znZcJC5U
         HavQ2tXF3VbismoBElamyn8xH1tSJNsQpGkJIrPaWuth2pz7uRRItVh298knq6oL8L0u
         eLTANAc83MhW5hR92GftAKOt4F1p/24Uw/HSCNqD4etk9KkaYngeGBZJ7yY33TOw/dsK
         GQKQ==
X-Gm-Message-State: AAQBX9dW25xZeahB291MZlUh+N25t9nBh16mLLAz8C17PRsmqPVnizIQ
        eO/xLs/FWk3GCQt+zCoscw4Plq5fCupUD5Qbq24OgQ==
X-Google-Smtp-Source: AKy350anWjiUgJzmZq/Q0GSExiC0OXO7/b8ibvhwpC6ppwIWDbuvnqDTTEE2zKvhqXnHLmmpwFf5pd2YH8Ge21uSmHU=
X-Received: by 2002:a05:6902:1107:b0:b3c:cbdb:ed5e with SMTP id
 o7-20020a056902110700b00b3ccbdbed5emr1201464ybu.3.1679396639937; Tue, 21 Mar
 2023 04:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230316164514.1615169-1-ulf.hansson@linaro.org> <8d6d12b5-39d4-ac07-f725-18ae9df9765b@intel.com>
In-Reply-To: <8d6d12b5-39d4-ac07-f725-18ae9df9765b@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 21 Mar 2023 12:03:23 +0100
Message-ID: <CAPDyKFrvWA-SxM6d=eVHFyPTYygsXmWQGVmnHJxsRFwGOhVjYw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Allow to avoid REQ_FUA if the eMMC supports an
 internal cache
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org,
        Wenchao Chen <wenchao.chen666@gmail.com>,
        Avri Altman <avri.altman@wdc.com>,
        Christian Lohle <cloehle@hyperstone.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Mar 2023 at 11:36, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 16/03/23 18:45, Ulf Hansson wrote:
> > REQ_FUA translates into so called "reliable writes" (atomic writes) for
> > eMMC cards, which is generally supported as it was introduced as a
> > mandatory feature already in the v4.3 (2007) of the eMMC spec. To fully
> > support the reliable writes (thus REQ_FUA), the mmc host driver needs to
> > support the CMD23 (MMC_CAP_CMD23) too, which is rather common nowadays.
> >
> > File systems typically uses REQ_FUA for writing their meta-data and other
> > important information. Ideally it should provide an increased protection
> > against data-corruption, during sudden power-failures. This said, file
> > systems have other ways to handle sudden power-failures too, like using
> > checksums to detect partly-written data, for example.
> >
> > It has been reported that the reliable writes are costly for some eMMCs,
> > leading to performance degradations. Exactly why, is in the implementation
> > details of the internals of the eMMC.
> >
> > Moreover, in the v4.5 (2011) of the eMMC spec, the cache-control was
> > introduced as an optional feature. It allows the host to trigger a flush of
> > the eMMC's internal write-cache. In the past, before the cache-control
> > feature was added, the reliable write acted as trigger for the eMMC, to
> > also flush its internal write-cache, even if that too remains as an
> > implementation detail of the eMMC.
> >
> > In a way to try to improve the situation with costly reliable writes and
> > REQ_FUA, let's add a new card quirk MMC_QUIRK_AVOID_REL_WRITE, which may be
> > set to avoid announcing the support for it. However, as mentioned above,
> > due to the specific relationship with the cache-control feature, we must
> > keep REQ_FUA unless that is supported too.
> >
> > Reported-by: Wenchao Chen <wenchao.chen666@gmail.com>
> > Acked-by: Bean Huo <beanhuo@micron.com>
> > Acked-by: Avri Altman <avri.altman@wdc.com>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Minor cosmetic suggestion below, but nevertheless:
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks!

>
> > ---
> >
> > Updated since the RFC:
> >       Added a card quirk to maintain the current behaviour. The quirk isn't
> >       set for any cards yet, which is needed (a patch on top) to move forward
> >       with this.
> >
> > ---
> >  drivers/mmc/core/block.c | 16 ++++++++++++----
> >  drivers/mmc/core/card.h  |  5 +++++
> >  include/linux/mmc/card.h |  1 +
> >  3 files changed, 18 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > index 672ab90c4b2d..35292e36a1fb 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -2409,8 +2409,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
> >       struct mmc_blk_data *md;
> >       int devidx, ret;
> >       char cap_str[10];
> > -     bool cache_enabled = false;
> > -     bool fua_enabled = false;
> > +     bool cache_enabled, avoid_fua, fua_enabled = false;
> >
> >       devidx = ida_simple_get(&mmc_blk_ida, 0, max_devices, GFP_KERNEL);
> >       if (devidx < 0) {
> > @@ -2494,11 +2493,20 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
> >           ((card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN) ||
> >            card->ext_csd.rel_sectors)) {
> >               md->flags |= MMC_BLK_REL_WR;
> > +     }
> > +
> > +     /*
> > +      * REQ_FUA is supported through eMMC reliable writes, which has been
> > +      * reported to be a bit costly for some eMMCs. In these cases, let's
> > +      * rely on the flush requests (REQ_OP_FLUSH) instead, if we can use the
> > +      * cache-control feature too.
> > +      */
> > +     cache_enabled = mmc_cache_enabled(card->host);
> > +     avoid_fua = cache_enabled && mmc_card_avoid_rel_write(card);
> > +     if (md->flags & MMC_BLK_REL_WR && !avoid_fua) {
> >               fua_enabled = true;
> >               cache_enabled = true;
> >       }
>
> looks like this could be just:
>
>         fua_enabled = (md->flags & MMC_BLK_REL_WR) && !avoid_fua;
>
> with fua_enabled no longer needing initialization

Unless I misunderstand your point, that would work for fua_enabled,
but would not be sufficient for cache_enabled.

cache_enabled should be set if fua_enabled is set - and no matter
whether mmc_cache_enabled() returns true or not.

Did that make sense?

[...]

Kind regards
Uffe
