Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEB862B169
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 03:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiKPCir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 21:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiKPCip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 21:38:45 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2079.outbound.protection.outlook.com [40.92.53.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528B3B851;
        Tue, 15 Nov 2022 18:38:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1zNWIhDDylp7ur5BgO56IZE26br67hm5fRDfkZZsB/dl+9eD2Z9Vt0Bq4LUPiuyasmxo/24YoY6jvCHez9jX6xqIvBO56AdSn2diKSCwON3buXItCZbOfqhL0S8IhDj2E14Ji6IWVHEmzNS65Uijk+jg/665Q2J45mt5N/lPmBdejoJpJL+CUZLrMdikiwlohxTjT6R3v9M88qa3wfZRtbGEDcgX/AEv/3pAnBDE5UcOcIjS5GwOX+VxGaGhGq6s6B4Lv3ehaY5jIPqfQJbdwAJE434Num/K79CWY6OG7CuZ7AV4/IHoUlZ0MVPsEeidV/nVTfUQTnzFSkybJWJbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPC0PWj25MBZSzwsKsVcmMHSzk2NutVG2pM834wRkrI=;
 b=Yj/ou8PpXod+d2dN3qGpiHeWH0Sh3P5T0CPEtqhJQQcoPFXd2m+3aCePK15UfHKDOwjV8aKz0lzj6RFXt5vJ/I1zgbbLVGxqSldApRec85B/AXClHY85ELdiczpntH37wuQg8HoyGInc2QQa3Kt8CGPcbiPqHaBYry7xkTIReUcZN0PteZbPsTBpaNMl+PBrpB8X2NyP10V+A5X1l9RnC2wxAihZqNJxXJ6N+Eho1IFdvt2Tt+BM4kTz2AAvPD4prF5DmcFZwfqqe+KUuPFGevp8i5ecqIHo09Y7Wnbz8lIa2VbBFwoP0nHMjXJRWKXYwO8FPa/jsLS2jWT48nejWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPC0PWj25MBZSzwsKsVcmMHSzk2NutVG2pM834wRkrI=;
 b=eC2ENhlyaWgSmoFVSyV/iBM9yeaVSANVnBJ8jpvVk89YAd225XpPCwdpqCv6hHJPoXsgAEoihPPpSnIJbLylpKARH/6O8Yk3O2HCwx2hucgXYDMBos7vhy/gRuFH11NIMIw3BZOP4IwbFJHG8eWSsG7znVkTpQ6/JmIK4CQ/itlgnhuiAUsr3vRC0P+s+kiD5jbAjmMDL4cNQBEhPTzcya2Pzw8kYt2BfQWdHPkoxpHoKs7agqM1Dur2nI48SdLncZDjtJtBYF6BNNNmoMi4MKGmNpR4IUH4LybJIDEGPLPCW0+/wLOB0YM0DL9yexfvyudvC7pw9tAYJlvDlP7Biw==
Received: from SI2PR02MB4603.apcprd02.prod.outlook.com (2603:1096:4:10c::14)
 by KL1PR02MB5028.apcprd02.prod.outlook.com (2603:1096:820:72::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.15; Wed, 16 Nov
 2022 02:38:40 +0000
Received: from SI2PR02MB4603.apcprd02.prod.outlook.com
 ([fe80::11fb:db8f:df36:c049]) by SI2PR02MB4603.apcprd02.prod.outlook.com
 ([fe80::11fb:db8f:df36:c049%8]) with mapi id 15.20.5813.018; Wed, 16 Nov 2022
 02:38:40 +0000
From:   jinchuan li <lifangpi@hotmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        972624427@qq.com, ligongwei <ligongwei@kylinos.cn>
Subject: [PATCH -next] Bluetooth: btusb: Add a new PID/VID 13d3/3549 for RTL8822CU
Date:   Wed, 16 Nov 2022 10:38:24 +0800
Message-ID: <SI2PR02MB4603DDABFC0EC1CC323BAF4ADD079@SI2PR02MB4603.apcprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [EhUlL4l5mle2v/ainhRAOLuUSW/GK78ctfIZEMqu9sY=]
X-ClientProxiedBy: TYXPR01CA0063.jpnprd01.prod.outlook.com
 (2603:1096:403:a::33) To SI2PR02MB4603.apcprd02.prod.outlook.com
 (2603:1096:4:10c::14)
X-Microsoft-Original-Message-ID: <20221116023824.227808-1-lifangpi@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR02MB4603:EE_|KL1PR02MB5028:EE_
X-MS-Office365-Filtering-Correlation-Id: f013e288-2c01-4028-e73a-08dac77babab
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i+SwVAXWSlZktSo8qJYHaUwwvOjEbc9RFENu6iGkVu9SM41WktNU9LPrXAjJkebIZaWTm6+dPedNLRZPvbMs9ES+gakEm5glr12z844PU0NJC8C5yEr/+jsAQfLbJPqsuCtBKUjxaRCGkJnvZa/sH1ismy6KEaY2jNp5vzd9iPp0UPoJ4cLwpYjeLDi7hzlsF8UIq5caNwwtwOLV878YCgxwRCB8fUwRClcB96wXLOecz+fP0zJxVISV7k3FeunSwJqvkal4ggJSFqYFKEq1KTF7oCziizHHwmvoQXqcmNkA39LIw4TgJJ4gUsMH3qvTx+AUWZcFLgXBbo9ZFKapPirAAENsQB7ZfxA+RHQgPpf78x7hAdYvlha2paE2y/Zhh7p2hMSxvaKxQv1FrQq22Hy2pOrOgTLK9BULrEd6ezhI7DBOZm74m91HFvYa6BH08g34wswN9lueaX9fyrkMg6npfqsNE7Mx7AzN8k35nbikB/n3LaYfovrnyNkyK3yiH+SgqbLCemOmfs39oO1e04eRa7XFszsosxuSD698aXcNyvi5qsUrgl4hP10sSfGjHWdnHDP2nL7BQCIbwCALRBVX06ytvO6pL9IuTwHnkWiw9lIOnvEbdERSj8IO5AnVISOZdTq8msfMXXIbKONmSQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C/GWfkPkaYrLhl36n18oDiwHTGCdGRROr/YvbZapXxXEaWAeiI5qpkFjxUZx?=
 =?us-ascii?Q?7IVDhQl1/lQZLCKY4fV0as4ano32CjerECkFQjLG/zPqLjKvXTXaWHY6kHJP?=
 =?us-ascii?Q?91nIUI8E5Xplmx5bxq6C46xNUKaylj1kJ36vPBrLbtf1VzU23zJWJTPHepF9?=
 =?us-ascii?Q?T2HjQnlEyWlhBEfzQt8bDVId5nfC2Ne2hCZH/JGeBcQ+6m8yOFQQw4DM2wS4?=
 =?us-ascii?Q?HEE/hCZOgM1dyWOhYECzRQfjFcIyJQ3oYs9eRZBpocv5gxYcWx92jU5L1Gj4?=
 =?us-ascii?Q?9OK4uSYR4PktmTUYciaT2Po4apemeVkN6H3RssGSOY50pVRUiNAyrH+sCgS7?=
 =?us-ascii?Q?AErQjodk5O1ffsG5m7oHET/G/d1eFt9SQ0NK02d4LBUnvyk5ifFO5qIDUKpQ?=
 =?us-ascii?Q?NaCg9/cBJip8vs0lwnGFZ5MEm4/XRdOkg5a5Fye3lebO/4BZoOiFn+RHlK8g?=
 =?us-ascii?Q?FbIqA+3TTI30eDVXSI31AgzB8WEnbtX3La9DJossO8JU0W2PVLqgzU7uNcCB?=
 =?us-ascii?Q?+rRj1ZVM3Ar/mt53t5vwlyDOhpZYzQoCR4+xzU9c+JXsqPDg/OFM1lk7qCaI?=
 =?us-ascii?Q?bxtFb7tzhcisbrxDfRcENX015pYYas4xQHFQqBUdsmxIe6Xs6WPuZ+1GndxI?=
 =?us-ascii?Q?2R7UFi97FqKHKiEejCiQUYLvD33xQ3cSvXY9xU0yg1oWW5BEbR6nH49cDpv2?=
 =?us-ascii?Q?gudwMgWLrvL52xxmAy7++IOKjdzvRZvkbdvOHRyTwlnqjRd8WigA6BnQteiG?=
 =?us-ascii?Q?ew6aD0UoFMraPb1vwl2k2z7bFjAOY9Z+Pe1FjODEB2fWtX3Pmd5lRQNpD1SD?=
 =?us-ascii?Q?4Da3HBisbZ1VzsHiRb1nSbLEFI2lGoCFf5REWNG3DpE/rEQgo6n0oTkuuJNf?=
 =?us-ascii?Q?wIFS24pA+rMwyWmc0aF8ID+Y0Dj9d42A3jSaCJGomw7xwvgneaAMMPn1cnbu?=
 =?us-ascii?Q?TCaCNxJeLEs1QV4NvChYB8ievDSc/6An/YpAn3OypJZBphZyro+6Spitlazd?=
 =?us-ascii?Q?EoApQYMfm/m2AJUx2hXfAoIWjjbcMnp6+47L3nIMUJx1xBf7TnrMVhuQ+7wz?=
 =?us-ascii?Q?y1JztKuLtjhTiGh38Z0FxTkPyvbmzN42irxqWzi0ZuQSoWWcPljHiqQ79aZL?=
 =?us-ascii?Q?DqCaP/8dkIZuq6qCpSSN9xwsO/FpwJJj6BPm4huz/H9ry4UU18Ws550gWBDg?=
 =?us-ascii?Q?vSOMNXWgcji/KxF/4oxNjI1fFMVTxhxqgMC51S90cXTJ6mvn7wJShfDhZmLH?=
 =?us-ascii?Q?X+5TP2bYEN1Xmztt5TfOBBBnK3OcoqDIrCntwxTl7Q=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-20e34.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f013e288-2c01-4028-e73a-08dac77babab
X-MS-Exchange-CrossTenant-AuthSource: SI2PR02MB4603.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 02:38:40.8308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB5028
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ligongwei <ligongwei@kylinos.cn>

* /sys/kernel/debug/usb/devices
T:  Bus=03 Lev=02 Prnt=02 Port=02 Cnt=03 Dev#=  5 Spd=12   MxCh= 0
D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0bda ProdID=b85b Rev= 0.00
S:  Manufacturer=Realtek
S:  Product=Bluetooth Radio
S:  SerialNumber=00e04c000001
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms

Signed-off-by: ligongwei <ligongwei@kylinos.cn>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 64a3febb9dec..437d0b53efe7 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -498,6 +498,10 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0bda, 0xc822), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 
+	/* Realtek 8822CU Bluetooth devices */
+	{ USB_DEVICE(0x13d3, 0x3549), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+
 	/* Realtek 8852AE Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0x2852), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
-- 
2.25.1

