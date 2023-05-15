Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774497020D0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 02:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237700AbjEOAg4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 14 May 2023 20:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjEOAgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 20:36:55 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC7A11D;
        Sun, 14 May 2023 17:36:53 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34F0aJroD025220, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34F0aJroD025220
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 15 May 2023 08:36:19 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 15 May 2023 08:36:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 15 May 2023 08:36:27 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 15 May 2023 08:36:27 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Rudi Heitbaum <rudi@heitbaum.com>
Subject: RE: [PATCH wireless v1] wifi: rtw88: sdio: Always use two consecutive bytes for word operations
Thread-Topic: [PATCH wireless v1] wifi: rtw88: sdio: Always use two
 consecutive bytes for word operations
Thread-Index: AQHZhp8/d2Ix7H9Kp0Kc7VStDQy2qK9aesbQ
Date:   Mon, 15 May 2023 00:36:27 +0000
Message-ID: <a0bf69fdb10b42a989a9b14e490e2f07@realtek.com>
References: <20230514200345.502807-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20230514200345.502807-1-martin.blumenstingl@googlemail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Sent: Monday, May 15, 2023 4:04 AM
> To: linux-wireless@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; Ping-Ke Shih <pkshih@realtek.com>; tony0620emma@gmail.com;
> kvalo@kernel.org; Martin Blumenstingl <martin.blumenstingl@googlemail.com>; Larry Finger
> <Larry.Finger@lwfinger.net>; Rudi Heitbaum <rudi@heitbaum.com>
> Subject: [PATCH wireless v1] wifi: rtw88: sdio: Always use two consecutive bytes for word operations
> 
> The Allwinner sunxi-mmc controller cannot handle word (16 bit)
> transfers. So and sdio_{read,write}w fails with messages like the
> following example using an RTL8822BS (but the same problems were also
> observed with RTL8822CS and RTL8723DS chips):
>   rtw_8822bs mmc1:0001:1: Firmware version 27.2.0, H2C version 13
>   sunxi-mmc 4021000.mmc: unaligned scatterlist: os f80 length 2
>   sunxi-mmc 4021000.mmc: map DMA failed
>   rtw_8822bs mmc1:0001:1: sdio read16 failed (0x10230): -22
> 
> Use two consecutive single byte accesses for word operations instead. It
> turns out that upon closer inspection this is also what the vendor
> driver does, even though it does have support for sdio_{read,write}w. So
> we can conclude that the rtw88 chips do support word access but only on
> SDIO controllers that also support it. Since there's no way to detect if
> the controller supports word access or not the rtw88 sdio driver
> switches to the easiest approach: avoiding word access.
> 
> Reported-by: Larry Finger <Larry.Finger@lwfinger.net>
> Closes: https://lore.kernel.org/linux-wireless/527585e5-9cdd-66ed-c3af-6da162f4b720@lwfinger.net/

"Closes:" seems not a regular tag. Use "Link: " instead.

> Reported-by: Rudi Heitbaum <rudi@heitbaum.com>

Followed by a "Link: " if you have another one.

> Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO based chipsets")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/net/wireless/realtek/rtw88/sdio.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
> index af0459a79899..06fce7c3adda 100644
> --- a/drivers/net/wireless/realtek/rtw88/sdio.c
> +++ b/drivers/net/wireless/realtek/rtw88/sdio.c
> @@ -87,11 +87,6 @@ static void rtw_sdio_writew(struct rtw_dev *rtwdev, u16 val, u32 addr,
>         u8 buf[2];
>         int i;
> 
> -       if (rtw_sdio_use_memcpy_io(rtwdev, addr, 2)) {
> -               sdio_writew(rtwsdio->sdio_func, val, addr, err_ret);
> -               return;
> -       }
> -
>         *(__le16 *)buf = cpu_to_le16(val);
> 
>         for (i = 0; i < 2; i++) {
> @@ -125,9 +120,6 @@ static u16 rtw_sdio_readw(struct rtw_dev *rtwdev, u32 addr, int *err_ret)
>         u8 buf[2];
>         int i;
> 
> -       if (rtw_sdio_use_memcpy_io(rtwdev, addr, 2))
> -               return sdio_readw(rtwsdio->sdio_func, addr, err_ret);
> -
>         for (i = 0; i < 2; i++) {
>                 buf[i] = sdio_readb(rtwsdio->sdio_func, addr + i, err_ret);
>                 if (*err_ret)
> --
> 2.40.1

