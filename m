Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E676D414F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjDCJwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjDCJwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:52:20 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711F51A952
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 02:51:28 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id p204so34004374ybc.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 02:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680515477;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5Myr4SOqgp/Xpahg3zCPICN65Lgc87yWnRIomS6rycc=;
        b=GPcW7yzc6Y3bgT6bww3ltcw04qeqvy7Edi1PSy8xetx51klIvNb25DddZh7qOtn3Zt
         448OEueWdAmkqADKKH62h/yzixUrtHA6dR42cFmPLzdVaBDsp/KOsRe0GAWqq1PoJXCy
         645onHrED3MlyzhcnBubHx2u0FPdbNNhO8uY/0H0lghBj1Dw1m6LdH5dOtwHKT28stVw
         AGSuCPHUldU87zv1oRIgR9R/8XG/kNdVZ01e6dpfX9CFc3h8cLXx5mHlo6LjgeAjox4N
         /nLgluJt8hJPLiDyWJO1Sym+V/I+TnNXDo5pjejXwAd/1gAwNL+0D7FudQ3hmq9CgRjV
         EBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680515477;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Myr4SOqgp/Xpahg3zCPICN65Lgc87yWnRIomS6rycc=;
        b=yMv67t35lRWUJKSTAA4KiGCu99nkELrCdOqSB1tgHo8HZ2solxaxbINocBEUql/pef
         90xIOX9/cl5tLgb4bSIQrJxEXiwy98hZXPfPuh7lhcaW7hTjCzaPvBLe3MtLHxoWJngX
         tftkMceVgEvXARVU89+RbXvYvxo8KcXS8B8sMbi8pmRKPBhbbptIZXRjJprbc3I/dqFk
         9pnGFTFSIC8umZFYy7R4rKJOqju9NY6MeYvP1FlMFw4acNYncTLXEDk+FCAloq6EgqSP
         uXFqBwjCIUOPxytCFMgvQNQHrUF7MDAFIOSYufscd2WQ1uSWjHK/0htVdMXprOfkOTpY
         Kpcg==
X-Gm-Message-State: AAQBX9dcLCjVieQdlxjRqjaZ3753ELA2jIDhPKIaiXaC4crHv+u61cWu
        N4txOU0TnhI7JA/SlV+vqEnqs0wTgwRiSpSTRRUDhw==
X-Google-Smtp-Source: AKy350bNjes3lUCW0Puu0SEvzQIxGEKTB7f/ZKo170GPrpIIbQT+S2NOobt6fb58J1TXjFuBWJuKofuApgAGg2knmPw=
X-Received: by 2002:a25:abee:0:b0:b68:7a4a:5258 with SMTP id
 v101-20020a25abee000000b00b687a4a5258mr22948859ybi.3.1680515477454; Mon, 03
 Apr 2023 02:51:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230329202148.71107-1-dennis@kernel.org> <ZCTOMVjW+pnZVGsQ@snowbird>
 <CAPDyKFrcdJuyA9B-JDReacT2z1ircDoY4oTXZQ8AVFk6UEFYsw@mail.gmail.com> <ZCclEE6Qw3on7/eO@snowbird>
In-Reply-To: <ZCclEE6Qw3on7/eO@snowbird>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 3 Apr 2023 11:50:41 +0200
Message-ID: <CAPDyKFqc33gUYXpY==jbNrOiba2_xUYLs-bv0RTYYU5d8T0VBA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: inline the first mmc_scan() on mmc_start_host()
To:     Dennis Zhou <dennis@kernel.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Mar 2023 at 20:23, Dennis Zhou <dennis@kernel.org> wrote:
>
> Hi Ulf,
>
> On Fri, Mar 31, 2023 at 02:43:10PM +0200, Ulf Hansson wrote:
> > On Thu, 30 Mar 2023 at 01:48, Dennis Zhou <dennis@kernel.org> wrote:
> > >
> > > When using dm-verity with a data partition on an emmc device, dm-verity
> > > races with the discovery of attached emmc devices. This is because mmc's
> > > probing code sets up the host data structure then a work item is
> > > scheduled to do discovery afterwards. To prevent this race on init,
> > > let's inline the first call to detection, __mm_scan(), and let
> > > subsequent detect calls be handled via the workqueue.
> >
> > In principle, I don't mind the changes in $subject patch, as long as
> > it doesn't hurt the overall initialization/boot time. Especially, we
> > may have more than one mmc-slot being used, so this needs to be well
> > tested.
> >
>
> I unfortunately don't have a device with multiple mmcs available. Is
> this something you could help me with?

Yes, I can help to test. Allow me a few days to see what I can do.

Note that, just having one eMMC and one SD card should work too. It
doesn't have to be multiple eMMCs.

>
> > Although, more importantly, I fail to understand how this is going to
> > solve the race condition. Any I/O request to an eMMC or SD requires
> > the mmc block device driver to be up and running too, which is getting
> > probed from a separate module/driver that's not part of mmc_rescan().
>
> I believe the call chain is something like this:
>
> __mmc_rescan()
>     mmc_rescan_try_freq()
>         mmc_attach_mmc()
>             mmc_add_card()
>                 device_add()
>                     bus_probe_device()
>                         mmc_blk_probe()
>
> The initial calling of this is the host probe. So effectively if there
> is a card attached, we're inlining the device_add() call for the card
> attached rather than waiting for the workqueue item to kick off.
>
> dm is a part of late_initcall() while mmc is a module_init(), when built
> in becoming a device_initcall(). So this solves a race via the initcall
> chain. In the current state, device_initcall() finishes and we move onto
> the late_initcall() phase. But now, dm is racing with the workqueue to
> init the attached emmc device.

You certainly have a point!

This should work when the mmc blk module is built-in. Even if that
doesn't solve the entire problem, it should be a step in the right
direction.

I will give it some more thinking and run some tests at my side, then
I will get back to you again.

Kind regards
Uffe

> >
> > >
> > > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> > > ---
> > > Sigh.. fix missing static declaration.
> > >
> > >  drivers/mmc/core/core.c | 15 +++++++++++----
> > >  1 file changed, 11 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > > index 368f10405e13..fda7ee57dee3 100644
> > > --- a/drivers/mmc/core/core.c
> > > +++ b/drivers/mmc/core/core.c
> > > @@ -2185,10 +2185,8 @@ int mmc_card_alternative_gpt_sector(struct mmc_card *card, sector_t *gpt_sector)
> > >  }
> > >  EXPORT_SYMBOL(mmc_card_alternative_gpt_sector);
> > >
> > > -void mmc_rescan(struct work_struct *work)
> > > +static void __mmc_rescan(struct mmc_host *host)
> > >  {
> > > -       struct mmc_host *host =
> > > -               container_of(work, struct mmc_host, detect.work);
> > >         int i;
> > >
> > >         if (host->rescan_disable)
> > > @@ -2249,6 +2247,14 @@ void mmc_rescan(struct work_struct *work)
> > >                 mmc_schedule_delayed_work(&host->detect, HZ);
> > >  }
> > >
> > > +void mmc_rescan(struct work_struct *work)
> > > +{
> > > +       struct mmc_host *host =
> > > +               container_of(work, struct mmc_host, detect.work);
> > > +
> > > +       __mmc_rescan(host);
> > > +}
> > > +
> > >  void mmc_start_host(struct mmc_host *host)
> > >  {
> > >         host->f_init = max(min(freqs[0], host->f_max), host->f_min);
> > > @@ -2261,7 +2267,8 @@ void mmc_start_host(struct mmc_host *host)
> > >         }
> > >
> > >         mmc_gpiod_request_cd_irq(host);
> > > -       _mmc_detect_change(host, 0, false);
> > > +       host->detect_change = 1;
> > > +       __mmc_rescan(host);
> > >  }
> > >
> > >  void __mmc_stop_host(struct mmc_host *host)
> > > --
> > > 2.40.0
> > >
