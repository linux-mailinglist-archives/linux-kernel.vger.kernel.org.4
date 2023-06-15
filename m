Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD0F731D6E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjFOQGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjFOQGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:06:50 -0400
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F81CEC;
        Thu, 15 Jun 2023 09:06:49 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-62ff12ba965so6837986d6.3;
        Thu, 15 Jun 2023 09:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686845208; x=1689437208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=om/3rexWstZ0S91L+gEIlLHFrjZY2axSUrZtEHSrgPw=;
        b=ZZQL4xqfGZ3YLUTqzQn49CKVqPvpjrVqFazPlRVc1ueFt5k+LJsgRJOAi64aV/oT6x
         6NtO4H78XWGqXqSfEYo/sN4zDpvSxx0j+WNIQAiylReKW+WpXqZhV5zgIen8/+Qa/Qx9
         GYExjb6DOm1V0GGci2OMqQGe8pqGQHvzqthy+JKZTAxG4I0iepi7UBTQhHYnogAsEGHL
         S0L9q96OKiN191tOO9b9kTbPJE6lCVlpDSzblYic2+uR14ZK1Sqh5DK+0fjxyfdsqogJ
         3+Q+t0yn+Cr+13EDlXugxhOMcOstITWtyhCUVbq54/Hv7PZaS1OgrgF1xXe6LPc1v0+X
         iZcg==
X-Gm-Message-State: AC+VfDy+6zsg9cyeyOlPadUXxw8DzixtFbMsQdn9YVfTHOmvCL6LCyGX
        kN+gVplIIb2cnkZL8gBqxeV1ISNqhqY=
X-Google-Smtp-Source: ACHHUZ6R9f7ZOwUs11BR3qFTpaQS/APHWFr0N/VDKoHBD955SpblUzKKuZKmRKgHavagfOfZazrQmg==
X-Received: by 2002:ad4:5b88:0:b0:5e0:3825:9ad9 with SMTP id 8-20020ad45b88000000b005e038259ad9mr12265018qvp.2.1686845208016;
        Thu, 15 Jun 2023 09:06:48 -0700 (PDT)
Received: from snowbird ([2600:4041:5505:2302:25d5:bdf3:65da:2bb9])
        by smtp.gmail.com with ESMTPSA id c11-20020a0ce14b000000b0062382e1e228sm5926310qvl.49.2023.06.15.09.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 09:06:47 -0700 (PDT)
Date:   Thu, 15 Jun 2023 09:06:45 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: inline the first mmc_scan() on mmc_start_host()
Message-ID: <ZIs3FQMiU75EhT6S@snowbird>
References: <20230329202148.71107-1-dennis@kernel.org>
 <CAPDyKFoKmWAC0V_t7WL-5OauxS-iiLxW+KhqC6RzJXD_szjPCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFoKmWAC0V_t7WL-5OauxS-iiLxW+KhqC6RzJXD_szjPCA@mail.gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 04:25:11PM +0200, Ulf Hansson wrote:
> On Wed, 29 Mar 2023 at 22:21, Dennis Zhou <dennis@kernel.org> wrote:
> >
> > When using dm-verity with a data partition on an emmc device, dm-verity
> > races with the discovery of attached emmc devices. This is because mmc's
> > probing code sets up the host data structure then a work item is
> > scheduled to do discovery afterwards. To prevent this race on init,
> > let's inline the first call to detection, __mm_scan(), and let
> > subsequent detect calls be handled via the workqueue.
> >
> > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> 
> Along with the patch for the mmci driver, this one applied too, for
> next, thanks!
> 

Thank you Ulf! I'm good with this just being applied to for-next.

Thanks,
Dennis

> Note also that I took the liberty to clarify the commit message a bit.
> 
> Moreover, if we want this to be applied for stable kernels, we need to
> manage that separately, as then the mmci patch is needed too. Please
> ping if you need some pointers in regards to this.
> 
> Kind regards
> Uffe
> 
> > ---
> >  drivers/mmc/core/core.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index 368f10405e13..c0fdc438c882 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -2185,10 +2185,8 @@ int mmc_card_alternative_gpt_sector(struct mmc_card *card, sector_t *gpt_sector)
> >  }
> >  EXPORT_SYMBOL(mmc_card_alternative_gpt_sector);
> >
> > -void mmc_rescan(struct work_struct *work)
> > +void __mmc_rescan(struct mmc_host *host)
> >  {
> > -       struct mmc_host *host =
> > -               container_of(work, struct mmc_host, detect.work);
> >         int i;
> >
> >         if (host->rescan_disable)
> > @@ -2249,6 +2247,14 @@ void mmc_rescan(struct work_struct *work)
> >                 mmc_schedule_delayed_work(&host->detect, HZ);
> >  }
> >
> > +void mmc_rescan(struct work_struct *work)
> > +{
> > +       struct mmc_host *host =
> > +               container_of(work, struct mmc_host, detect.work);
> > +
> > +       __mmc_rescan(host);
> > +}
> > +
> >  void mmc_start_host(struct mmc_host *host)
> >  {
> >         host->f_init = max(min(freqs[0], host->f_max), host->f_min);
> > @@ -2261,7 +2267,8 @@ void mmc_start_host(struct mmc_host *host)
> >         }
> >
> >         mmc_gpiod_request_cd_irq(host);
> > -       _mmc_detect_change(host, 0, false);
> > +       host->detect_change = 1;
> > +       __mmc_rescan(host);
> >  }
> >
> >  void __mmc_stop_host(struct mmc_host *host)
> > --
> > 2.40.0
> >
