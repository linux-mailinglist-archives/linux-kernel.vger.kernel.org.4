Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BFE728FC9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 08:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237138AbjFIGUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 02:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237714AbjFIGT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 02:19:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31201FE6;
        Thu,  8 Jun 2023 23:19:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39FEC61F4D;
        Fri,  9 Jun 2023 06:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F74C433D2;
        Fri,  9 Jun 2023 06:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686291594;
        bh=rYenQZcJ00i17NHmowq8OR4nZ3oLcojXfyMw7FepXj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tTlMUimOBD6RM7QFRTDo/wB8rf6G9d8Z/wZ42CaPO3yJMTu6HX5uZjb6ghGSdpGSf
         WH927+9XmwqtpCrBvTzTrerP84U+dPjAPisC1I6jMW6cWRvve+3vMe5Zd9EnGAzzST
         p7IisharJdAwvl6Fc35v1W+wHzZaS/5EVYeDrt/g=
Date:   Fri, 9 Jun 2023 08:19:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] mmc: inline the first mmc_scan() on mmc_start_host()
Message-ID: <2023060930-uphold-collie-3ec5@gregkh>
References: <20230329202148.71107-1-dennis@kernel.org>
 <ZCTOMVjW+pnZVGsQ@snowbird>
 <CAPDyKFrcdJuyA9B-JDReacT2z1ircDoY4oTXZQ8AVFk6UEFYsw@mail.gmail.com>
 <ZCclEE6Qw3on7/eO@snowbird>
 <CAPDyKFqc33gUYXpY==jbNrOiba2_xUYLs-bv0RTYYU5d8T0VBA@mail.gmail.com>
 <CAPDyKFos3i60U0g0vJstetvLMyouiTpUP8-Jop_LMB9T-ZNU=w@mail.gmail.com>
 <ZII-vJWGb7F97S_A@V92F7Y9K0C.corp.robot.car>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZII-vJWGb7F97S_A@V92F7Y9K0C.corp.robot.car>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 01:49:00PM -0700, Dennis Zhou wrote:
> On Fri, May 12, 2023 at 01:42:51PM +0200, Ulf Hansson wrote:
> > + Linus,
> > 
> > Hi Dennis,
> > 
> > On Mon, 3 Apr 2023 at 11:50, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Fri, 31 Mar 2023 at 20:23, Dennis Zhou <dennis@kernel.org> wrote:
> > > >
> > > > Hi Ulf,
> > > >
> > > > On Fri, Mar 31, 2023 at 02:43:10PM +0200, Ulf Hansson wrote:
> > > > > On Thu, 30 Mar 2023 at 01:48, Dennis Zhou <dennis@kernel.org> wrote:
> > > > > >
> > > > > > When using dm-verity with a data partition on an emmc device, dm-verity
> > > > > > races with the discovery of attached emmc devices. This is because mmc's
> > > > > > probing code sets up the host data structure then a work item is
> > > > > > scheduled to do discovery afterwards. To prevent this race on init,
> > > > > > let's inline the first call to detection, __mm_scan(), and let
> > > > > > subsequent detect calls be handled via the workqueue.
> > > > >
> > > > > In principle, I don't mind the changes in $subject patch, as long as
> > > > > it doesn't hurt the overall initialization/boot time. Especially, we
> > > > > may have more than one mmc-slot being used, so this needs to be well
> > > > > tested.
> > > > >
> > > >
> > > > I unfortunately don't have a device with multiple mmcs available. Is
> > > > this something you could help me with?
> > >
> > > Yes, I can help to test. Allow me a few days to see what I can do.
> > >
> > > Note that, just having one eMMC and one SD card should work too. It
> > > doesn't have to be multiple eMMCs.
> > >
> > > >
> > > > > Although, more importantly, I fail to understand how this is going to
> > > > > solve the race condition. Any I/O request to an eMMC or SD requires
> > > > > the mmc block device driver to be up and running too, which is getting
> > > > > probed from a separate module/driver that's not part of mmc_rescan().
> > > >
> > > > I believe the call chain is something like this:
> > > >
> > > > __mmc_rescan()
> > > >     mmc_rescan_try_freq()
> > > >         mmc_attach_mmc()
> > > >             mmc_add_card()
> > > >                 device_add()
> > > >                     bus_probe_device()
> > > >                         mmc_blk_probe()
> > > >
> > > > The initial calling of this is the host probe. So effectively if there
> > > > is a card attached, we're inlining the device_add() call for the card
> > > > attached rather than waiting for the workqueue item to kick off.
> > > >
> > > > dm is a part of late_initcall() while mmc is a module_init(), when built
> > > > in becoming a device_initcall(). So this solves a race via the initcall
> > > > chain. In the current state, device_initcall() finishes and we move onto
> > > > the late_initcall() phase. But now, dm is racing with the workqueue to
> > > > init the attached emmc device.
> > >
> > > You certainly have a point!
> > >
> > > This should work when the mmc blk module is built-in. Even if that
> > > doesn't solve the entire problem, it should be a step in the right
> > > direction.
> > >
> > > I will give it some more thinking and run some tests at my side, then
> > > I will get back to you again.
> > >
> > > Kind regards
> > > Uffe
> > >
> > > > >
> > > > > >
> > > > > > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> > > > > > ---
> > > > > > Sigh.. fix missing static declaration.
> > > > > >
> > > > > >  drivers/mmc/core/core.c | 15 +++++++++++----
> > > > > >  1 file changed, 11 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > > > > > index 368f10405e13..fda7ee57dee3 100644
> > > > > > --- a/drivers/mmc/core/core.c
> > > > > > +++ b/drivers/mmc/core/core.c
> > > > > > @@ -2185,10 +2185,8 @@ int mmc_card_alternative_gpt_sector(struct mmc_card *card, sector_t *gpt_sector)
> > > > > >  }
> > > > > >  EXPORT_SYMBOL(mmc_card_alternative_gpt_sector);
> > > > > >
> > > > > > -void mmc_rescan(struct work_struct *work)
> > > > > > +static void __mmc_rescan(struct mmc_host *host)
> > > > > >  {
> > > > > > -       struct mmc_host *host =
> > > > > > -               container_of(work, struct mmc_host, detect.work);
> > > > > >         int i;
> > > > > >
> > > > > >         if (host->rescan_disable)
> > > > > > @@ -2249,6 +2247,14 @@ void mmc_rescan(struct work_struct *work)
> > > > > >                 mmc_schedule_delayed_work(&host->detect, HZ);
> > > > > >  }
> > > > > >
> > > > > > +void mmc_rescan(struct work_struct *work)
> > > > > > +{
> > > > > > +       struct mmc_host *host =
> > > > > > +               container_of(work, struct mmc_host, detect.work);
> > > > > > +
> > > > > > +       __mmc_rescan(host);
> > > > > > +}
> > > > > > +
> > > > > >  void mmc_start_host(struct mmc_host *host)
> > > > > >  {
> > > > > >         host->f_init = max(min(freqs[0], host->f_max), host->f_min);
> > > > > > @@ -2261,7 +2267,8 @@ void mmc_start_host(struct mmc_host *host)
> > > > > >         }
> > > > > >
> > > > > >         mmc_gpiod_request_cd_irq(host);
> > > > > > -       _mmc_detect_change(host, 0, false);
> > > > > > +       host->detect_change = 1;
> > > > > > +       __mmc_rescan(host);
> > > > > >  }
> > > > > >
> > > > > >  void __mmc_stop_host(struct mmc_host *host)
> > > > > > --
> > > > > > 2.40.0
> > > > > >
> > 
> > My apologies for the long delay. I finally managed to test this.
> > 
> > I decided to pick an old arm32 based platform. An ST-Ericsson HREF,
> > based upon the ux500 SoC. It's quite good to use for these types of
> > tests as it has two eMMCs soldered, an embedded SDIO (for WiFi) and an
> > SD-card slot. So in total there are 4 devices that get probed.
> > 
> > The SDIO card isn't detected properly, but always fails in the similar
> > way (thus I left it out from the below data). I tested both with and
> > without an SD card inserted during boot, to get some more data to
> > compare. These are the summary from my tests:
> > 
> > v6.4-rc1 without SD card:
> > ~2.18s - MMC1 (eMMC)
> > ~3.33s - MMC3 (eMMC)
> > ~5.91s - kernel boot complete
> > 
> > v6.4-rc1 with an SD card:
> > ~2.18s - MMC1 (eMMC)
> > ~3.45s - MMC3 (eMMC)
> > ~3.57s - MMC2 (SD)
> > ~5.76s - kernel boot complete
> > 
> > v6.4-rc1 + patch without SD card:
> > ~2.24s - MMC1 (eMMC)
> > ~3.58s - MMC3 (eMMC)
> > ~5.96s - kernel boot complete
> > 
> > v6.4-rc1 + patch with an SD card:
> > ~2.24s - MMC1 (eMMC)
> > ~3.73s - MMC2 (SD)
> > ~3.98s - MMC3 (eMMC)
> > ~6.73s - kernel boot complete
> > 
> > By looking at these results, I was kind of surprised. I was thinking
> > that the asynchronous probe should address the parallelism problem.
> > Then I discovered that it in fact, hasn't been enabled for the mmci
> > driver that is being used for this platform. Huh, I was under the
> > assumption that it has been enabled for all mmc hosts by now. :-)
> > 
> > Okay, so I am going to run another round of tests, with async probe
> > enabled for the mmci driver too. I will let you know the results as
> > soon as I can.
> > 
> > Kind regards
> > Uffe
> 
> Hi Uffe,
> 
> Kindly this has been way too long for review. It's been over 3 months.
> What's going on here?
> 
> I think there's a misunderstanding too. Without this fix, the machine
> doesn't even boot. I'm not sure why perf is the blocking question here.

Well you can not degrade performance of existing machines that work
today, right?  That would be a regression and it seems that you are
doing that if I read the numbers above correctly.

> Greg, is there another tree I can run this through?

Why would you want to route around a maintainer just to get a patch that
would have to be reverted applied?  :)

thanks,

greg k-h
