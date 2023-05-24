Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07A670EABD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 03:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238938AbjEXBZJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 23 May 2023 21:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjEXBZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 21:25:07 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5B3E5;
        Tue, 23 May 2023 18:25:06 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34O1OemeE028494, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34O1OemeE028494
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 24 May 2023 09:24:40 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 24 May 2023 09:24:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 24 May 2023 09:24:50 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 24 May 2023 09:24:50 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Arnd Bergmann <arnd@kernel.org>, Kalle Valo <kvalo@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>, DeanKu <ku920601@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rtw89: use flexible array member in rtw89_btc_btf_tlv
Thread-Topic: [PATCH] rtw89: use flexible array member in rtw89_btc_btf_tlv
Thread-Index: AQHZjWpPQ0KzeDFfo0qATwMmb1dUKK9ooiyw
Date:   Wed, 24 May 2023 01:24:50 +0000
Message-ID: <27a7010de8be4006a3e4b95e851781c6@realtek.com>
References: <20230523113241.2772811-1-arnd@kernel.org>
In-Reply-To: <20230523113241.2772811-1-arnd@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
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
> From: Arnd Bergmann <arnd@kernel.org>
> Sent: Tuesday, May 23, 2023 7:33 PM
> To: Ping-Ke Shih <pkshih@realtek.com>; Kalle Valo <kvalo@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>; DeanKu <ku920601@realtek.com>; linux-wireless@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: [PATCH] rtw89: use flexible array member in rtw89_btc_btf_tlv
> 
> From: Arnd Bergmann <arnd@arndb.de>
> 
> struct rtw89_btc_btf_tlv contains a one-byte member that is intended as a
> flexible array:
> 
> In function 'fortify_memcpy_chk',
>     inlined from '_append_tdma' at drivers/net/wireless/realtek/rtw89/coex.c:1579:3:
> include/linux/fortify-string.h:583:25: error: call to '__write_overflow_field' declared with attribute
> warning: detected write beyond size of field (1st parameter); maybe use struct_group()?
> [-Werror=attribute-warning]
>   583 |                         __write_overflow_field(p_size_field, size);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Make this actually use a flexible array to let the compiler understand.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

> ---
>  drivers/net/wireless/realtek/rtw89/coex.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
> index 3a586a971e8f..bda0e1e99a8c 100644
> --- a/drivers/net/wireless/realtek/rtw89/coex.c
> +++ b/drivers/net/wireless/realtek/rtw89/coex.c
> @@ -206,7 +206,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
>  struct rtw89_btc_btf_tlv {
>         u8 type;
>         u8 len;
> -       u8 val[1];
> +       u8 val[];
>  } __packed;
> 
>  enum btc_btf_set_report_en {
> --
> 2.39.2

