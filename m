Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02294672227
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjARPwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjARPve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:51:34 -0500
X-Greylist: delayed 313 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Jan 2023 07:49:46 PST
Received: from cnc.isely.net (cnc.isely.net [192.69.181.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719D445233;
        Wed, 18 Jan 2023 07:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=isely.net; s=deb;
        t=1674056364; bh=PUCorUQZC6FeLowATjHfocaMvZBn2st6AioBFC89WJI=;
        l=1781; h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
        b=BUZEbEqT1HJhDjTohgOQaLFLfu6tNIuWeAx8CtryC0Y4PiR7So2vdM9viJgIy6VTu
         BNCQ3MzQRyYgTk0FJIzX2KDaP8UdVymGBQ9l7zrjkAvysxDhtZBdzMNkxu9bxLQJrd
         Z2yjvxMGD+pUaO1AIJ8oNIlLgBHznaWw+G0ffiO0FHt1WSjikF/nzG+/OtGrF
Original-Reply-To: Mike Isely at pobox <isely@pobox.com>
Original-Subject: Re: [PATCH] media: pvrusb2: fix DVB_CORE dependency
Original-From: Mike Isely <isely@isely.net>
Original-cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
  Lecopzer Chen <lecopzer.chen@mediatek.com>,
  Hans Verkuil <hverkuil-cisco@xs4all.nl>,
  Arnd Bergmann <arnd@arndb.de>,
  "=?ISO-8859-2?Q?=A3ukasz_Stelmach?=" <l.stelmach@samsung.com>,
  Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
  Jacopo Mondi <jacopo@jmondi.org>,
  Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
  linux-media@vger.kernel.org,
  Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
  Mike Isely at pobox <isely@pobox.com>
Received: from ts3-dock1.isely.net (ts3-dock1.isely.net [::ffff:192.168.23.13])
  (AUTH: PLAIN isely, TLS: TLS1.3,256bits,ECDHE_RSA_AES_256_GCM_SHA384)
  by cnc.isely.net with ESMTPSA
  id 000000000008033F.0000000063C812AC.00006E06; Wed, 18 Jan 2023 09:39:24 -0600
Date:   Wed, 18 Jan 2023 09:39:24 -0600 (CST)
From:   Mike Isely <isely@isely.net>
Reply-To: Mike Isely at pobox <isely@pobox.com>
To:     Arnd Bergmann <arnd@kernel.org>
cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Arnd Bergmann <arnd@arndb.de>,
        "=?ISO-8859-2?Q?=A3ukasz_Stelmach?=" <l.stelmach@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        linux-media@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Isely at pobox <isely@pobox.com>
Subject: Re: [PATCH] media: pvrusb2: fix DVB_CORE dependency
In-Reply-To: <20230117171055.2714621-1-arnd@kernel.org>
Message-ID: <f045d0c6-0043-8feb-a423-954ce381396d@isely.net>
References: <20230117171055.2714621-1-arnd@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


That doesn't seem right.  The pvrusb2 module should reference that 
symbol like any other.  There is no special treatment of it within 
pvrusb2 - so why is that requiring special treatment here?

Is it possible that dvb_module_probe and dvb_module_release are not 
exported?  (Or that there are two corresponding different exported 
symbol names that pvrusb2 should be using instead?)

  -Mike

On Tue, 17 Jan 2023, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> Now that DVB_CORE can be a loadable module, pvrusb2 can run into
> a link error:
> 
> ld.lld: error: undefined symbol: dvb_module_probe
> >>> referenced by pvrusb2-devattr.c
> >>>               drivers/media/usb/pvrusb2/pvrusb2-devattr.o:(pvr2_lgdt3306a_attach) in archive vmlinux.a
> ld.lld: error: undefined symbol: dvb_module_release
> >>> referenced by pvrusb2-devattr.c
> >>>               drivers/media/usb/pvrusb2/pvrusb2-devattr.o:(pvr2_dual_fe_attach) in archive vmlinux.a
> 
> Refine the Kconfig dependencies to avoid this case.
> 
> Fixes: 7655c342dbc4 ("media: Kconfig: Make DVB_CORE=m possible when MEDIA_SUPPORT=y")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/media/usb/pvrusb2/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/usb/pvrusb2/Kconfig b/drivers/media/usb/pvrusb2/Kconfig
> index f2b64e49c5a2..e02a25d2d029 100644
> --- a/drivers/media/usb/pvrusb2/Kconfig
> +++ b/drivers/media/usb/pvrusb2/Kconfig
> @@ -37,6 +37,7 @@ config VIDEO_PVRUSB2_DVB
>  	bool "pvrusb2 ATSC/DVB support"
>  	default y
>  	depends on VIDEO_PVRUSB2 && DVB_CORE
> +	depends on VIDEO_PVRUSB2=m || DVB_CORE=y
>  	select DVB_LGDT330X if MEDIA_SUBDRV_AUTOSELECT
>  	select DVB_S5H1409 if MEDIA_SUBDRV_AUTOSELECT
>  	select DVB_S5H1411 if MEDIA_SUBDRV_AUTOSELECT
> 
