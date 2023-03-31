Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12C76D27BB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 20:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbjCaSXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 14:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjCaSXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 14:23:17 -0400
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42321BF44;
        Fri, 31 Mar 2023 11:23:16 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id d13so21343012pjh.0;
        Fri, 31 Mar 2023 11:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680286996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTebArJXS/p6tOYYXSptr4puwVM64fTvtw6kGil+3Vs=;
        b=NP1sR5HgwmqjNuRYxBVG2DC9m0bUsQDHo8ksKMt8xR1H4gt9iOXmg0vir8cg/VpnbT
         DHfTLbPhxx4hFKfhynlhCw5iCWtfMXIgbeuaoDQzvjRwtUT5IXeTnmvHFc0VXV8JCCkf
         4ADk7cZX7jm6xMHnHLk+JIUuXnF9K94Lk4NUb6LTiyaJE1aqdPR4UVKJ2b971/w7kyh8
         xqRlY3UE7vhJy+/0u83/UoNYOKnztVvX8+X9c1vsSCAxqRQu3EzB+clZV1ttJu9jhJrS
         MvmBfD+nGkzTBfQsSXFwn4zL1w4MMaNGsxLpMFs13+JFByKj1jHZ56QkCUZzme7dQHd4
         ccgA==
X-Gm-Message-State: AAQBX9c/PrvIgsCcUW+ZrPxgIXtOxKTYCym0KPdzH2ctgZ/xsAUxHrpa
        j/r8vqLYaCh7cqO7bd1TzEceHH+ZJyg3xw==
X-Google-Smtp-Source: AKy350aXt6uq93jKiGpsgQjor7aBNfRMnNFFdhgeE9VpsjrzXsm/9N8TW3VB92nmR7A7ICydZdsotg==
X-Received: by 2002:a17:90b:1bc7:b0:23f:b35a:534e with SMTP id oa7-20020a17090b1bc700b0023fb35a534emr32013368pjb.29.1680286996083;
        Fri, 31 Mar 2023 11:23:16 -0700 (PDT)
Received: from snowbird ([199.73.127.3])
        by smtp.gmail.com with ESMTPSA id e91-20020a17090a6fe400b0023f786a64ebsm5281418pjk.57.2023.03.31.11.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 11:23:15 -0700 (PDT)
Date:   Fri, 31 Mar 2023 11:23:12 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mmc: inline the first mmc_scan() on mmc_start_host()
Message-ID: <ZCclEE6Qw3on7/eO@snowbird>
References: <20230329202148.71107-1-dennis@kernel.org>
 <ZCTOMVjW+pnZVGsQ@snowbird>
 <CAPDyKFrcdJuyA9B-JDReacT2z1ircDoY4oTXZQ8AVFk6UEFYsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrcdJuyA9B-JDReacT2z1ircDoY4oTXZQ8AVFk6UEFYsw@mail.gmail.com>
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

On Fri, Mar 31, 2023 at 02:43:10PM +0200, Ulf Hansson wrote:
> On Thu, 30 Mar 2023 at 01:48, Dennis Zhou <dennis@kernel.org> wrote:
> >
> > When using dm-verity with a data partition on an emmc device, dm-verity
> > races with the discovery of attached emmc devices. This is because mmc's
> > probing code sets up the host data structure then a work item is
> > scheduled to do discovery afterwards. To prevent this race on init,
> > let's inline the first call to detection, __mm_scan(), and let
> > subsequent detect calls be handled via the workqueue.
> 
> In principle, I don't mind the changes in $subject patch, as long as
> it doesn't hurt the overall initialization/boot time. Especially, we
> may have more than one mmc-slot being used, so this needs to be well
> tested.
> 

I unfortunately don't have a device with multiple mmcs available. Is
this something you could help me with?

> Although, more importantly, I fail to understand how this is going to
> solve the race condition. Any I/O request to an eMMC or SD requires
> the mmc block device driver to be up and running too, which is getting
> probed from a separate module/driver that's not part of mmc_rescan().

I believe the call chain is something like this:

__mmc_rescan()
    mmc_rescan_try_freq()
        mmc_attach_mmc()
            mmc_add_card()
                device_add()
                    bus_probe_device()
                        mmc_blk_probe()

The initial calling of this is the host probe. So effectively if there
is a card attached, we're inlining the device_add() call for the card
attached rather than waiting for the workqueue item to kick off.

dm is a part of late_initcall() while mmc is a module_init(), when built
in becoming a device_initcall(). So this solves a race via the initcall
chain. In the current state, device_initcall() finishes and we move onto
the late_initcall() phase. But now, dm is racing with the workqueue to
init the attached emmc device.

Thanks,
Dennis

> 
> Kind regards
> Uffe
> 
> >
> > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> > ---
> > Sigh.. fix missing static declaration.
> >
> >  drivers/mmc/core/core.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index 368f10405e13..fda7ee57dee3 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -2185,10 +2185,8 @@ int mmc_card_alternative_gpt_sector(struct mmc_card *card, sector_t *gpt_sector)
> >  }
> >  EXPORT_SYMBOL(mmc_card_alternative_gpt_sector);
> >
> > -void mmc_rescan(struct work_struct *work)
> > +static void __mmc_rescan(struct mmc_host *host)
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
