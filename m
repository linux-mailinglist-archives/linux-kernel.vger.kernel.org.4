Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0135FB063
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 12:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiJKKZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 06:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiJKKZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 06:25:17 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832323FD53
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 03:25:14 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id b2so12777796plc.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 03:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLIrvoe+FIF9Rl2LQ64g0umqbuCq3HckpYKCNFCJXoc=;
        b=sucvMSyaJJ7WUgAGc9j7CW1DsPdUQM0ZgLA6Vhv2X/TNygbvbQ/7kgQ5ySHNFbeG7+
         3zBAi+kFLvkVdnSqiAh981+9pZmYLzLIJr7w5bX+YiMLm5NyG7ZcMq8dzF99ug6lbDrD
         pJNwSB01N+F2j4wt3T9yVTUKpXZo3EWOJBTZuJVhuVUPTsf9lzOWg4Q5EJtzSfGkMG9g
         0qs0syN8zitlFQyYCkPvTVsg0j8ZQN3c6jsJVMROS1oyeWLWAu3NOoJaNihUhguY+0Br
         wj6MFdwcKbIu8dgcTmRmhCpdJxvWUy1+bXeJH/c7vXyLWzoRA9SxT9VCM1IaYZAlFFNb
         bmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLIrvoe+FIF9Rl2LQ64g0umqbuCq3HckpYKCNFCJXoc=;
        b=gxK4GtWik+6noUhvvI81b2UszYX3EcvUDc/SiBUkzCwJPhXGK5FYP4cMBgnvn31kks
         1v98CY5eMCzFa0YOJcGNZGCwkkgXO2ILGWK9elZrOYqtwsKxsjFL/J1h1baDWyFKq8nq
         RINgnPxYmoKquMv0WT9kBTk1YLF6B76axyoeS+eZs1CM3yhUycA5inKC4rCjpFfmcYUs
         l/bLtI+ju75qoE+vByWhI3EH8j8U4Lb6d6XOoNz3okZm6AqB537FB+tZuoDTNs/urZZx
         2XpTds6lpDj89ASpYmd45wHi4oHL6Sij7ykI1D+etYIal5pv9/Wf3dcShT6aSC7vipbG
         oDew==
X-Gm-Message-State: ACrzQf0Bb4dN4aCoQZfkuSBRrUftvtWQ5fmZXtTh8W2qH/gUfoZqcJdv
        jMaN2Ov8MqPwTyoRB8Gk+DjYKei8vN7+83oZkFNKWQ==
X-Google-Smtp-Source: AMsMyM7bnEMmu7GGjFSOcsjc2YYtupfRU9fTXmi1D+13DDq3jpNz23a99th4veHj/mCCgN0KNcMATqBzJv4c9LLjqj0=
X-Received: by 2002:a17:90b:1d8b:b0:20d:30a5:499e with SMTP id
 pf11-20020a17090b1d8b00b0020d30a5499emr13995274pjb.84.1665483913542; Tue, 11
 Oct 2022 03:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <0d0ef6651ed44fc780e95c8797294708@hyperstone.com> <65d813c6-65c0-fb5b-2709-8068e1dc89c1@intel.com>
In-Reply-To: <65d813c6-65c0-fb5b-2709-8068e1dc89c1@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 Oct 2022 12:24:36 +0200
Message-ID: <CAPDyKFpWn-mW_myadoXwM=p_7Mmk+NkkJdLmtLsx0Hr7bz1_gQ@mail.gmail.com>
Subject: Re: [PATCHv3 1/2] mmc: block: Remove error check of hw_reset on reset
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <cloehle@hyperstone.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Oct 2022 at 12:15, Adrian Hunter <adrian.hunter@intel.com> wrote=
:
>
> On 10/10/22 17:03, Christian L=C3=B6hle wrote:
> > Before switching back to the right partition in mmc_blk_reset
> > there used to be a check if hw_reset was even supported.
> > This return value was removed, so there is no reason to check.
> > Furthermore ensure part_curr is not falsely set to a valid value
> > on reset or partition switch error.
> >
> > Fixes: fefdd3c91e0a ("mmc: core: Drop superfluous validations in mmc_hw=
|sw_reset()")
> > Cc: stable@vger.kernel.org
> >
> > Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> > ---
> > -v3: Ensure invalid part_curr on error
> > -v2: Do not attempt to switch partitions if reset failed
> >
> >  drivers/mmc/core/block.c | 29 ++++++++++++++---------------
> >  1 file changed, 14 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > index ce89611a136e..45a44edcc31a 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -134,6 +134,7 @@ struct mmc_blk_data {
> >        * track of the current selected device partition.
> >        */
> >       unsigned int    part_curr;
> > +#define MMC_BLK_PART_INVALID UINT_MAX        /* Unknown partition acti=
ve */
> >       int     area_type;
> >
> >       /* debugfs files (only in main mmc_blk_data) */
> > @@ -991,29 +992,27 @@ static int mmc_blk_reset(struct mmc_blk_data *md,=
 struct mmc_host *host,
> >                        int type)
> >  {
> >       int err;
> > +     struct mmc_blk_data *main_md =3D dev_get_drvdata(&host->card->dev=
);
> > +     int part_err;
> >
> >       if (md->reset_done & type)
> >               return -EEXIST;
> >
> >       md->reset_done |=3D type;
> > +     main_md->part_curr =3D MMC_BLK_PART_INVALID;
>
> This forces a partition switch even if it is not necessary.

Right, very good point!

>
> >       err =3D mmc_hw_reset(host->card);
>
> This would be better:
>
>         /*
>          * A successful reset will leave the card in the main partition, =
but
>          * upon failure it might not be, so set it to MMC_BLK_PART_INVALI=
D
>          * in that case.
>          */
>         main_md->part_curr =3D err ? MMC_BLK_PART_INVALID : main_md->part=
_type;
>

Yes! And the comment is valuable too!

[...]

Kind regards
Uffe
