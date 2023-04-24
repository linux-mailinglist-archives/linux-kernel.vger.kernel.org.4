Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67966DA9FE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 10:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjDGIYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 04:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjDGIYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 04:24:20 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833006EAB;
        Fri,  7 Apr 2023 01:24:18 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id ja10so39501616plb.5;
        Fri, 07 Apr 2023 01:24:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680855858; x=1683447858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qApLz7WDCv18vydgjE+EOqQlINQHyff3Bn8mgcG6t8=;
        b=lF4Lgfll6ID6Hu3nVqXXXxs4jNjfq9xtZ0JJuU/J8wyXORhGYRHdXchL73SdjaaQoF
         qre0hPaPbI5Q1UND1R6nXAg8iq74ZRNakYOwQ2aV+MLf+7N79ZSEkbifcFqbOKxD1rpl
         mnhMa5XXqsvrL6ddTGQtE+LQ1BdGJrBodl412how/aosm9yGF/8Am75gu0j2Pq2GvR9u
         tcMHzF2014uS5ihsD8AIw+Yq39zWyMi7V8O/VD62O7c9LDhKwm7CxvK4rhr1gFB9bckn
         JsmWrnD+KjJaIM60DvdR85L+NVB5rslJ7EcPqwiks7Y5KuPuOJuI6XajL3MTK4oKYbeN
         Riqg==
X-Gm-Message-State: AAQBX9fg3W1NRdcMaVh7pdGUx8fHsF/BBQJC2gy7LZ2y/Tgr2w7IAXEp
        mc0kgezl5UGzB3AraP4nGHjbwCxkWjXLuQ==
X-Google-Smtp-Source: AKy350bqI+k6OGtQYINR/AKVLWq+RlcWiaMVg+3EIvH82fBA3BBSXvQQUr5KkQWXmwhDiDXIhv+4lg==
X-Received: by 2002:a05:6a20:2d94:b0:e4:c9f7:d280 with SMTP id bf20-20020a056a202d9400b000e4c9f7d280mr2135416pzb.58.1680855857715;
        Fri, 07 Apr 2023 01:24:17 -0700 (PDT)
Received: from snowbird (136-24-99-118.cab.webpass.net. [136.24.99.118])
        by smtp.gmail.com with ESMTPSA id j24-20020a170902759800b0019ef86c2574sm2457632pll.270.2023.04.07.01.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 01:24:17 -0700 (PDT)
Date:   Fri, 7 Apr 2023 01:24:15 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mmc: inline the first mmc_scan() on mmc_start_host()
Message-ID: <ZC/TL2/gLre0B4xH@snowbird>
References: <20230329202148.71107-1-dennis@kernel.org>
 <ZCTOMVjW+pnZVGsQ@snowbird>
 <CAPDyKFrcdJuyA9B-JDReacT2z1ircDoY4oTXZQ8AVFk6UEFYsw@mail.gmail.com>
 <ZCclEE6Qw3on7/eO@snowbird>
 <CAPDyKFqc33gUYXpY==jbNrOiba2_xUYLs-bv0RTYYU5d8T0VBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqc33gUYXpY==jbNrOiba2_xUYLs-bv0RTYYU5d8T0VBA@mail.gmail.com>
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 11:50:41AM +0200, Ulf Hansson wrote:
> On Fri, 31 Mar 2023 at 20:23, Dennis Zhou <dennis@kernel.org> wrote:
> >
> > Hi Ulf,
> >
> > On Fri, Mar 31, 2023 at 02:43:10PM +0200, Ulf Hansson wrote:
> > > On Thu, 30 Mar 2023 at 01:48, Dennis Zhou <dennis@kernel.org> wrote:
> > > >
> > > > When using dm-verity with a data partition on an emmc device, dm-verity
> > > > races with the discovery of attached emmc devices. This is because mmc's
> > > > probing code sets up the host data structure then a work item is
> > > > scheduled to do discovery afterwards. To prevent this race on init,
> > > > let's inline the first call to detection, __mm_scan(), and let
> > > > subsequent detect calls be handled via the workqueue.
> > >
> > > In principle, I don't mind the changes in $subject patch, as long as
> > > it doesn't hurt the overall initialization/boot time. Especially, we
> > > may have more than one mmc-slot being used, so this needs to be well
> > > tested.
> > >
> >
> > I unfortunately don't have a device with multiple mmcs available. Is
> > this something you could help me with?
> 
> Yes, I can help to test. Allow me a few days to see what I can do.
> 
> Note that, just having one eMMC and one SD card should work too. It
> doesn't have to be multiple eMMCs.
> 
> >
> > > Although, more importantly, I fail to understand how this is going to
> > > solve the race condition. Any I/O request to an eMMC or SD requires
> > > the mmc block device driver to be up and running too, which is getting
> > > probed from a separate module/driver that's not part of mmc_rescan().
> >
> > I believe the call chain is something like this:
> >
> > __mmc_rescan()
> >     mmc_rescan_try_freq()
> >         mmc_attach_mmc()
> >             mmc_add_card()
> >                 device_add()
> >                     bus_probe_device()
> >                         mmc_blk_probe()
> >
> > The initial calling of this is the host probe. So effectively if there
> > is a card attached, we're inlining the device_add() call for the card
> > attached rather than waiting for the workqueue item to kick off.
> >
> > dm is a part of late_initcall() while mmc is a module_init(), when built
> > in becoming a device_initcall(). So this solves a race via the initcall
> > chain. In the current state, device_initcall() finishes and we move onto
> > the late_initcall() phase. But now, dm is racing with the workqueue to
> > init the attached emmc device.
> 
> You certainly have a point!
> 
> This should work when the mmc blk module is built-in. Even if that
> doesn't solve the entire problem, it should be a step in the right
> direction.
> 
> I will give it some more thinking and run some tests at my side, then
> I will get back to you again.
> 

Hi Ulf, is there an update on testing with this patch?

Thanks,
Dennis

> Kind regards
> Uffe
> 
> > >
> > > >
> > > > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> > > > ---
> > > > Sigh.. fix missing static declaration.
> > > >
> > > >  drivers/mmc/core/core.c | 15 +++++++++++----
> > > >  1 file changed, 11 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > > > index 368f10405e13..fda7ee57dee3 100644
> > > > --- a/drivers/mmc/core/core.c
> > > > +++ b/drivers/mmc/core/core.c
> > > > @@ -2185,10 +2185,8 @@ int mmc_card_alternative_gpt_sector(struct mmc_card *card, sector_t *gpt_sector)
> > > >  }
> > > >  EXPORT_SYMBOL(mmc_card_alternative_gpt_sector);
> > > >
> > > > -void mmc_rescan(struct work_struct *work)
> > > > +static void __mmc_rescan(struct mmc_host *host)
> > > >  {
> > > > -       struct mmc_host *host =
> > > > -               container_of(work, struct mmc_host, detect.work);
> > > >         int i;
> > > >
> > > >         if (host->rescan_disable)
> > > > @@ -2249,6 +2247,14 @@ void mmc_rescan(struct work_struct *work)
> > > >                 mmc_schedule_delayed_work(&host->detect, HZ);
> > > >  }
> > > >
> > > > +void mmc_rescan(struct work_struct *work)
> > > > +{
> > > > +       struct mmc_host *host =
> > > > +               container_of(work, struct mmc_host, detect.work);
> > > > +
> > > > +       __mmc_rescan(host);
> > > > +}
> > > > +
> > > >  void mmc_start_host(struct mmc_host *host)
> > > >  {
> > > >         host->f_init = max(min(freqs[0], host->f_max), host->f_min);
> > > > @@ -2261,7 +2267,8 @@ void mmc_start_host(struct mmc_host *host)
> > > >         }
> > > >
> > > >         mmc_gpiod_request_cd_irq(host);
> > > > -       _mmc_detect_change(host, 0, false);
> > > > +       host->detect_change = 1;
> > > > +       __mmc_rescan(host);
> > > >  }
> > > >
> > > >  void __mmc_stop_host(struct mmc_host *host)
> > > > --
> > > > 2.40.0
> > > >
