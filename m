Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA63C655A21
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 13:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiLXM2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 07:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiLXM2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 07:28:07 -0500
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BF8F002
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 04:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uyXsiyueiTc8v5MlNRur4jIQ7A6s63yrjzYIjyka/fE=;
  b=Te36gCRS4d3KXHDAb2wNQ70s//5flt8MMQnMQo4meBZ37/Zd+Ot9TtiR
   iJAtkOm44u1U5wQLzU2hQicsvau9kWWCgCg/WQUk31h9teVrPs82cc5o6
   MDbFhPb0yYsBt/gtWlRVEvarXp3fiPMgHmhamjjgDbDtiF9/k3wOtzKrX
   8=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.96,271,1665439200"; 
   d="scan'208";a="84927040"
Received: from 214.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.214])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2022 13:28:04 +0100
Date:   Sat, 24 Dec 2022 13:28:04 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
cc:     Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: coccinelle: How to remove a return at the end of a void
 function?
In-Reply-To: <20221224115657.kqyocti356cwm7hc@pengutronix.de>
Message-ID: <alpine.DEB.2.22.394.2212241326310.2711@hadrien>
References: <20221224115657.kqyocti356cwm7hc@pengutronix.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1137191680-1671884884=:2711"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1137191680-1671884884=:2711
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



On Sat, 24 Dec 2022, Uwe Kleine-König wrote:

> Hello,
>
> I work on a patch set that eventually makes the function
> rtsx_usb_sdmmc_drv_remove() return void:
>
> A simplified spatch looks as follows:
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
>  <...
> -return 0;
> +return;
>  ...>
>  }
> -------->8--------
>
> This results in:
>
> -------->8--------
> diff -u -p a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
> --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> @@ -1379,13 +1379,13 @@ static int rtsx_usb_sdmmc_drv_probe(stru
>         return 0;
>  }
>
> -static int rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
> +static void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
>  {
>         struct rtsx_usb_sdmmc *host = platform_get_drvdata(pdev);
>         struct mmc_host *mmc;
>
>         if (!host)
> -               return 0;
> +               return;
>
>         mmc = host->mmc;
>         host->host_removal = true;
> @@ -1416,7 +1416,7 @@ static int rtsx_usb_sdmmc_drv_remove(str
>         dev_dbg(&(pdev->dev),
>                 ": Realtek USB SD/MMC module has been removed\n");
>
> -       return 0;
> +       return;
>  }
>
>  #ifdef CONFIG_PM
> -------->8--------
>
> which is as intended. Now I want to remove the useless "return;" at the
> end of the function, however adding
>
> -------->8--------
> @p2 depends on p1@
> identifier pdev;
> @@
>  void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev) {
>  ...
> -return;
>  }
> -------->8--------
>
> to the spatch doesn't (only) do the intended:

The problem is that Coccinelle is following the control-flow through the
function, and all of the returns are at the end of a control.flow path.
The simple, hacky solution is to change the return;s into some function
call Return();, then do like the above for Return(); and then change the
Return();s back to return;s

julia


>
> -------->8--------
> diff -u -p a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
> --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> @@ -1379,13 +1379,13 @@ static int rtsx_usb_sdmmc_drv_probe(stru
>         return 0;
>  }
>
> -static int rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
> +static void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
>  {
>         struct rtsx_usb_sdmmc *host = platform_get_drvdata(pdev);
>         struct mmc_host *mmc;
>
>         if (!host)
> -               return 0;
> +               {}
>
>         mmc = host->mmc;
>         host->host_removal = true;
> @@ -1415,8 +1415,6 @@ static int rtsx_usb_sdmmc_drv_remove(str
>
>         dev_dbg(&(pdev->dev),
>                 ": Realtek USB SD/MMC module has been removed\n");
> -
> -       return 0;
>  }
>
>  #ifdef CONFIG_PM
> -------->8--------
>
> It's obvious to me, why coccinelle also removes the first return, but
> it's not obvious to me, how to prevent this and only drop the 2nd one.
>
> Do you have a hint for me?
>
> Thanks in advance and happy holidays,
> Uwe
>
>
> --
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |
>
--8323329-1137191680-1671884884=:2711--
