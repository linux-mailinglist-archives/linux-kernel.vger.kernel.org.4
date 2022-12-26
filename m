Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64866563FA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 17:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbiLZQCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 11:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLZQCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 11:02:40 -0500
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F33D2AD4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 08:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4wN/2c51h0IQE7ZBS8vW1oWtqIFSDdqWFrW2DZ84Jqk=;
  b=cCDGvLZWIz1JsCu72ZM5ND3fy7S1u4OT+8sIbrDYiPNsTbqgsqR9d0aV
   ONkhorFaQ4jRDL/LwnFW+aM+SrDbY9UgbLCdPtCF65zWlxjJfo4ktjglk
   X2jbN9DvDUNuBfc3CkP34HbaPzWnUL6Es6l79z/RtEf3Ujdd8yjL5kQKe
   w=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.96,276,1665439200"; 
   d="scan'208";a="43659643"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 17:02:36 +0100
Date:   Mon, 26 Dec 2022 17:02:35 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
cc:     kernel@pengutronix.de, Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, cocci@inria.fr
Subject: Re: coccinelle: How to remove a return at the end of a void
 function?
In-Reply-To: <20221225212011.6il5egocxtx5zupa@pengutronix.de>
Message-ID: <be39f7d-31ab-24c-61c5-6daabdef9267@inria.fr>
References: <20221224115657.kqyocti356cwm7hc@pengutronix.de> <alpine.DEB.2.22.394.2212241326310.2711@hadrien> <20221225212011.6il5egocxtx5zupa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1161383448-1672070555=:3850"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1161383448-1672070555=:3850
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



On Sun, 25 Dec 2022, Uwe Kleine-König wrote:

> Hello Julia,
>
> first of all thanks for your quick answer.
>
> On Sat, Dec 24, 2022 at 01:28:04PM +0100, Julia Lawall wrote:
> > On Sat, 24 Dec 2022, Uwe Kleine-König wrote:
> > > A simplified spatch looks as follows:
> > >
> > > -------->8--------
> > > virtual patch
> > >
> > > @p1@
> > > identifier pdev;
> > > @@
> > > -int
> > > +void
> > >  rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev) {
> > >  <...
> > > -return 0;
> > > +return;
> > >  ...>
> > >  }
> > > -------->8--------
> > >
> > > This results in:
> > >
> > > -------->8--------
> > > diff -u -p a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
> > > --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> > > +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> > > @@ -1379,13 +1379,13 @@ static int rtsx_usb_sdmmc_drv_probe(stru
> > >         return 0;
> > >  }
> > >
> > > -static int rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
> > > +static void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
> > >  {
> > >         struct rtsx_usb_sdmmc *host = platform_get_drvdata(pdev);
> > >         struct mmc_host *mmc;
> > >
> > >         if (!host)
> > > -               return 0;
> > > +               return;
> > >
> > >         mmc = host->mmc;
> > >         host->host_removal = true;
> > > @@ -1416,7 +1416,7 @@ static int rtsx_usb_sdmmc_drv_remove(str
> > >         dev_dbg(&(pdev->dev),
> > >                 ": Realtek USB SD/MMC module has been removed\n");
> > >
> > > -       return 0;
> > > +       return;
> > >  }
> > >
> > >  #ifdef CONFIG_PM
> > > -------->8--------
> > >
> > > which is as intended. Now I want to remove the useless "return;" at the
> > > end of the function, however adding
> > >
> > > -------->8--------
> > > @p2 depends on p1@
> > > identifier pdev;
> > > @@
> > >  void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev) {
> > >  ...
> > > -return;
> > >  }
> > > -------->8--------
> > >
> > > to the spatch doesn't (only) do the intended:
> >
> > The problem is that Coccinelle is following the control-flow through the
> > function, and all of the returns are at the end of a control.flow path.
> > The simple, hacky solution is to change the return;s into some function
> > call Return();, then do like the above for Return(); and then change the
> > Return();s back to return;s
>
> OK, I tried, but somehow coccinelle refuse to work after I introduced
> Return(), even replacing them by return; doesn't work:
>
> -------->8--------
> virtual patch
>
> @p1@
> identifier pdev;
> @@
> -int
> +void
>  rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev) {
>  ...
> -return 0;
> +Return();
>  ...
>  }
>
> @p2@
> identifier pdev;
> @@
>  void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev) {
>  ...
> -Return();
> +return;
>  ...
>  }

The problem is that a control-flow path at this point can have multiple
calls to Return();  You pattern only matches when every control-flow path
through the code has exactly one Return().

You should have one rule that removes the final Return();

 @p2@
 identifier pdev;
 @@
  void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev) {
  ...
 -Return();
  }

Then another rule to remove the others:

 @p2@
 identifier pdev;
 @@
  void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev) {
  <...
 -Return();
 +return;
  ...>
  }

julia

> -------->8--------
>
> results in
>
> -------->8--------
> $ /usr/bin/spatch --debug -D patch --very-quiet --cocci-file scripts/coccinelle/api/test.cocci --patch . --dir drivers/mmc/host/rtsx_usb_sdmmc.c -I ./arch/x86/include -I ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I ./arch/x86/include/generated/uapi -I ./include/uapi -I ./include/generated/uapi --include ./include/linux/compiler-version.h --include ./include/linux/kconfig.h --jobs 4 --chunksize 1
> diff -u -p a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
> --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> @@ -1385,7 +1385,7 @@ static int rtsx_usb_sdmmc_drv_remove(str
>  	struct mmc_host *mmc;
>
>  	if (!host)
> -		return 0;
> +		Return();
>
>  	mmc = host->mmc;
>  	host->host_removal = true;
> @@ -1416,7 +1416,7 @@ static int rtsx_usb_sdmmc_drv_remove(str
>  	dev_dbg(&(pdev->dev),
>  		": Realtek USB SD/MMC module has been removed\n");
>
> -	return 0;
> +	Return();
>  }
>
>  #ifdef CONFIG_PM
> -------->8--------
>
> Adding --debug doesn't give any hints.
>
> (And if I add another hunk inbeetween removing Return at the end of the
> function there is no effect either.)
>
> Do I need to split that in two spatches to make coccinelle cooperate?
>
> (If it matters, this is coccinelle as shipped by Debian, Version
> 1.1.1.deb-2)
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |
>
--8323329-1161383448-1672070555=:3850--
