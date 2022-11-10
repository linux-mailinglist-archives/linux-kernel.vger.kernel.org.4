Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2BA62446F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 15:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiKJOfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 09:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKJOfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:35:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82229CD9;
        Thu, 10 Nov 2022 06:35:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCC7AB821E7;
        Thu, 10 Nov 2022 14:35:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052B6C433D6;
        Thu, 10 Nov 2022 14:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668090932;
        bh=Ycsp23uKUl6+71MdymwhYiS3mtRr2Mqz9KnaYO3109E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M/aoeYa8GzfYpwmoQHis9W7Ht6naGjRb5iSq+u3KUd5Roj+QfxxeGz+ZSXsqriVTE
         r+d1DhD6hdpZu+Ke24w38DTucECFAgFl0K9g4SVD5kEfMZrqWPMML2U6mubgoUAxox
         cmaW+Z9pQkTS1ZrHQekWZcjgh+HO9lYVCfNcNpyA=
Date:   Thu, 10 Nov 2022 15:35:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Duke =?utf-8?B?WGluKOi+m+WuieaWhyk=?= <duke_xinanwen@163.com>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, dukexinaw <602659072@qq.com>
Subject: Re: [PATCH]     Author: Duke =?utf-8?Q?Xin?=
 =?utf-8?B?KOi+m+WuieaWhyk8ZHVrZV94aW5hbndlbkAxNjMuY29t?= =?utf-8?Q?=3E?=
 Date:   Thu, Nov 10 15:25:01 2022 +0800
Message-ID: <Y20MMYtd9vGkkPtJ@kroah.com>
References: <20221110111250.3360-1-duke_xinanwen@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221110111250.3360-1-duke_xinanwen@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 07:12:50PM +0800, Duke Xin(辛安文) wrote:
> From: dukexinaw <602659072@qq.com>
> 
>     USB: serial: option: add Quectel EM05-G modem
> 
>     The EM05-G modem has 2 USB configurations that are configurable via the AT
>     command AT+QCFG="usbnet",[ 0 | 2 ] which make the modem enumerate with
>     the following interfaces, respectively:
> 
>     "RMNET" : AT + DIAG + NMEA + Modem + QMI
>     "MBIM"  : MBIM + AT + DIAG + NMEA + Modem
> 
>     The detailed description of the USB configuration for each mode as follows:
> 
>     RMNET Mode
>     --------------
>     T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 21 Spd=480  MxCh= 0
>     D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
>     P:  Vendor=2c7c ProdID=0311 Rev= 3.18
>     S:  Manufacturer=Quectel
>     S:  Product=Quectel EM05-G
>     C:* #Ifs= 5 Cfg#= 1 Atr=a0 MxPwr=500mA
>     I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
>     E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>     E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>     I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
>     E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
>     E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>     E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>     I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
>     E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
>     E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>     E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>     I:* If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
>     E:  Ad=87(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
>     E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>     E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>     I:* If#= 6 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
>     E:  Ad=89(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
>     E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>     E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
>    MBIM Mode
>     --------------
>     T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 16 Spd=480  MxCh= 0
>     D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
>     P:  Vendor=2c7c ProdID=0311 Rev= 3.18
>     S:  Manufacturer=Quectel
>     S:  Product=Quectel EM05-G
>     C:* #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=500mA
>     A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=0e Prot=00
>     I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
>     E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>     E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>     I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
>     E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
>     E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>     E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>     I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
>     E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
>     E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>     E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>     I:* If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
>     E:  Ad=87(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
>     E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>     E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>     I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=0e Prot=00 Driver=cdc_mbim
>     E:  Ad=89(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
>     I:  If#= 1 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
>     I:* If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
>     E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>     E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
>     Signed-off-by: Duke Xin<duke_xinanwen@163.com>
>     Cc: stable@vger.kernel.org
>     Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> Signed-off-by: dukexinaw <602659072@qq.com>
> ---
>  Next/SHA1s                  |  368 ++
>  Next/Trees                  |  370 ++
>  Next/merge.log              | 8938 +++++++++++++++++++++++++++++++++++
>  drivers/usb/serial/option.c |    3 +
>  localversion-next           |    1 +
>  5 files changed, 9680 insertions(+)
>  create mode 100644 Next/SHA1s
>  create mode 100644 Next/Trees
>  create mode 100644 Next/merge.log
>  create mode 100644 localversion-next

Something went really wrong with creating this patch.  Please read the
documentation and verify it before sending out a new version.

thanks,

greg k-h
