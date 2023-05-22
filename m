Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCDB70B2DD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 03:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjEVBn0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 21 May 2023 21:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjEVBnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 21:43:24 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24182AF;
        Sun, 21 May 2023 18:43:20 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34M1go4iB030448, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34M1go4iB030448
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 22 May 2023 09:42:50 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 22 May 2023 09:43:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 22 May 2023 09:43:00 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 22 May 2023 09:43:00 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "Peter Robinson" <pbrobinson@gmail.com>,
        "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>
Subject: RE: [PATCH wireless-next v1 1/4] wifi: rtw88: sdio: Check the HISR RX_REQUEST bit in rtw_sdio_rx_isr()
Thread-Topic: [PATCH wireless-next v1 1/4] wifi: rtw88: sdio: Check the HISR
 RX_REQUEST bit in rtw_sdio_rx_isr()
Thread-Index: AQHZiaRUyNopi6TOU06ASkVQiZhTKq9liWyA
Date:   Mon, 22 May 2023 01:43:00 +0000
Message-ID: <d6a5555d13ed467db8c181962c2adb85@realtek.com>
References: <20230518161749.1311949-1-martin.blumenstingl@googlemail.com>
 <20230518161749.1311949-2-martin.blumenstingl@googlemail.com>
In-Reply-To: <20230518161749.1311949-2-martin.blumenstingl@googlemail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Sent: Friday, May 19, 2023 12:18 AM
> To: linux-wireless@vger.kernel.org
> Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org; ulf.hansson@linaro.org; kvalo@kernel.org;
> tony0620emma@gmail.com; Peter Robinson <pbrobinson@gmail.com>; Ping-Ke Shih <pkshih@realtek.com>;
> jernej.skrabec@gmail.com; Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Subject: [PATCH wireless-next v1 1/4] wifi: rtw88: sdio: Check the HISR RX_REQUEST bit in rtw_sdio_rx_isr()
> 
> rtw_sdio_rx_isr() is responsible for receiving data from the wifi chip
> and is called from the SDIO interrupt handler when the interrupt status
> register (HISR) has the RX_REQUEST bit set. After the first batch of
> data has been processed by the driver the wifi chip may have more data
> ready to be read, which is managed by a loop in rtw_sdio_rx_isr().
> 
> It turns out that there are cases where the RX buffer length (from the
> REG_SDIO_RX0_REQ_LEN register) does not match the data we receive. The
> following two cases were observed with a RTL8723DS card:
> - RX length is smaller than the total packet length including overhead
>   and actual data bytes (whose length is part of the buffer we read from
>   the wifi chip and is stored in rtw_rx_pkt_stat.pkt_len). This can
>   result in errors like:
>     skbuff: skb_over_panic: text:ffff8000011924ac len:3341 put:3341
>   (one case observed was: RX buffer length = 1536 bytes but
>    rtw_rx_pkt_stat.pkt_len = 1546 bytes, this is not valid as it means
>    we need to read beyond the end of the buffer)
> - RX length looks valid but rtw_rx_pkt_stat.pkt_len is zero
> 
> Check if the RX_REQUEST is set in the HISR register for each iteration
> inside rtw_sdio_rx_isr(). This mimics what the RTL8723DS vendor driver
> does and makes the driver only read more data if the RX_REQUEST bit is
> set (which seems to be a way for the card's hardware or firmware to
> tell the host that data is ready to be processed).
> 
> For RTW_WCPU_11AC chips this check is not needed. The RTL8822BS vendor
> driver for example states that this check is unnecessary (but still uses
> it) and the RTL8822CS drops this check entirely.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/net/wireless/realtek/rtw88/sdio.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
> index 06fce7c3adda..32b8c9194b2c 100644
> --- a/drivers/net/wireless/realtek/rtw88/sdio.c
> +++ b/drivers/net/wireless/realtek/rtw88/sdio.c
> @@ -998,9 +998,9 @@ static void rtw_sdio_rxfifo_recv(struct rtw_dev *rtwdev, u32 rx_len)
> 
>  static void rtw_sdio_rx_isr(struct rtw_dev *rtwdev)
>  {
> -       u32 rx_len, total_rx_bytes = 0;
> +       u32 rx_len, hisr, total_rx_bytes = 0;
> 
> -       while (total_rx_bytes < SZ_64K) {
> +       do {
>                 if (rtw_chip_wcpu_11n(rtwdev))
>                         rx_len = rtw_read16(rtwdev, REG_SDIO_RX0_REQ_LEN);
>                 else
> @@ -1012,7 +1012,24 @@ static void rtw_sdio_rx_isr(struct rtw_dev *rtwdev)
>                 rtw_sdio_rxfifo_recv(rtwdev, rx_len);
> 
>                 total_rx_bytes += rx_len;
> -       }
> +
> +               if (rtw_chip_wcpu_11n(rtwdev))
> +                       /* Stop if no more RX requests are pending, even if
> +                        * rx_len could be greater than zero in the next
> +                        * iteration. This is needed because the RX buffer may
> +                        * already contain data while either HW or FW are not
> +                        * done filling that buffer yet. Still reading the
> +                        * buffer can result in packets where
> +                        * rtw_rx_pkt_stat.pkt_len is zero or points beyond the
> +                        * end of the buffer.
> +                        */
> +                       hisr = rtw_read32(rtwdev, REG_SDIO_HISR);
> +               else
> +                       /* RTW_WCPU_11AC chips have improved hardware or
> +                        * firmware and can use rx_len unconditionally.
> +                        */
> +                       hisr = REG_SDIO_HISR_RX_REQUEST;

nit: adding braces to these branches would be clearer. 

If not, this patch still looks good to me, so

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>


> +       } while (total_rx_bytes < SZ_64K && hisr & REG_SDIO_HISR_RX_REQUEST);
>  }
> 
>  static void rtw_sdio_handle_interrupt(struct sdio_func *sdio_func)
> --
> 2.40.1

