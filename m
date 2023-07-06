Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C397493DE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 04:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbjGFCuZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 Jul 2023 22:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbjGFCuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 22:50:23 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F43B1BC7;
        Wed,  5 Jul 2023 19:50:20 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3662o7MI1016388, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3662o7MI1016388
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 6 Jul 2023 10:50:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 6 Jul 2023 10:50:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 6 Jul 2023 10:50:10 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 6 Jul 2023 10:50:10 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Zhang Shurong <zhang_shurong@foxmail.com>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] wifi: rtw89: debug: fix error code in rtw89_debug_priv_send_h2c_set()
Thread-Topic: [PATCH v4] wifi: rtw89: debug: fix error code in
 rtw89_debug_priv_send_h2c_set()
Thread-Index: AQHZr7PivS7TyITqwU+gLYMnIIw9Ta+sCaeg
Date:   Thu, 6 Jul 2023 02:50:10 +0000
Message-ID: <b1fa5bf7811c4050b3f585012125898c@realtek.com>
References: <tencent_AD09A61BC4DA92AD1EB0790F5C850E544D07@qq.com>
In-Reply-To: <tencent_AD09A61BC4DA92AD1EB0790F5C850E544D07@qq.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
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
> From: Zhang Shurong <zhang_shurong@foxmail.com>
> Sent: Thursday, July 6, 2023 10:45 AM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: kvalo@kernel.org; linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org; Zhang Shurong
> <zhang_shurong@foxmail.com>
> Subject: [PATCH v4] wifi: rtw89: debug: fix error code in rtw89_debug_priv_send_h2c_set()
> 
> If there is a failure during rtw89_fw_h2c_raw() rtw89_debug_priv_send_h2c
> should return negative error code instead of a positive value count.
> Fix this bug by returning correct error code.
> 
> Fixes: e3ec7017f6a2 ("rtw89: add Realtek 802.11ax driver")
> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

[...]

