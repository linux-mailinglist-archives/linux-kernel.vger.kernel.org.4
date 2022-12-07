Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595BD645558
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 09:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiLGIVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 03:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiLGIVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 03:21:04 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2014.outbound.protection.outlook.com [40.92.107.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCD76576
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 00:21:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdRxHryjXAUQ8wXlr8ucykdyDY/b0FX0RpT9MP53t/W3LwC/QaJuaDUW9SCY082sn/Pw8RLFMD2pRqWAlReWFEsDqbW44woXxaDFFWGIZ5OzwywV7Whqx9rmKdTlzezcvPRBFEcZoBj0h6XvyFX5uWKTZLuqK4RUWM3EMUl9gzCa5OKb0ASV+jLo+XFYTEBMhWzRttgCZXSdD1L4DIKvzwlWDyYhUz7sGMBPKSyzjbveUM6rQchwagH+GZxjWgOuu5OOtG3DPGE0HPLF+5Ja00XwvSOK9uAZc+letuiqKi0VV293HFW5bRjEjuRRNnq2ILd/OO4xYJPmOn8tdQN5DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ygrx8jG4GN9LmJLO6IGTc3kPJztQLPVgtjoAyjN1eo=;
 b=e+/MAi+kWlSbM4yMgGK5jn4J5MurdqnRfZfEdntixmncFHV7WrLryMeBubt5to5OB8EMgzf9yM6UECfU/WkHcgVCiPK4KF3HfjZz7DLCmJRhs3hGX9MmYMUrM2pvTkLipghCSPHLhPdKoUENIN+fOU9cVHnvlNhMF6miV4h9deco5E0msn/eW98iPjrBoaA+4obrV0FT4HXzmUgcPSJ8MbCiZ4qGEW4zQ9Pnrql2x8f2qTYVwzUdgMTwB4Ouumqf4KA3oUKAZiGyoTxad56DFYNcZa7Gxs9V+oeaDA1wzda/pTBmEjXEqJVuHxMPfwyPGvv+GLbIwCWnQ+JSOmkTGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ygrx8jG4GN9LmJLO6IGTc3kPJztQLPVgtjoAyjN1eo=;
 b=IadKVhk7uRPmNmSuGOVJnS7xnzN7eSNCcTe0xpTWpVUbGyXD0ZV49ocTF96fxtS4W5m4kJoOEtAmOQBSrCvbsGTHU46oMUT1lKtp4QyJ9BWT71P8h6nX4OAyNJ9g/pQ6ouZs+pblYVDFUlT03EfLXeEtqZ162wtsbV04hBkIgUKhNuXNn36EWGBKU0zBotP3GLbF+ndipoQLgUtdVMxXV5PmRGyhZg2Tct0MgQef8MS7A291INiakwpmGwgCWKx62vMe+E3RLh7t5x/OUXGpNXEJ6SlrIPo1JEwTA4yxsxdvH9mIXJvqNdEs52TKWjtbnRnRZnk4pj6nQyZUfsas9g==
Received: from SG2PR02MB5878.apcprd02.prod.outlook.com (2603:1096:4:1d2::9) by
 SEYPR02MB5896.apcprd02.prod.outlook.com (2603:1096:101:88::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Wed, 7 Dec 2022 08:20:58 +0000
Received: from SG2PR02MB5878.apcprd02.prod.outlook.com
 ([fe80::2c81:c803:d49b:eebb]) by SG2PR02MB5878.apcprd02.prod.outlook.com
 ([fe80::2c81:c803:d49b:eebb%6]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 08:20:58 +0000
From:   Dicheng Wang <wangdicheng123@hotmail.com>
To:     perex@perex.cz, tiwai@suse.com, sdoregor@sdore.me,
        hahnjo@hahnjo.de, wangdicheng@kylinos.cn,
        connerknoxpublic@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 -next] ALSA:usb-audio:add the information of KT0206 device driven by USB audio
Date:   Wed,  7 Dec 2022 16:20:36 +0800
Message-ID: <SG2PR02MB587849631CB96809CF90DBED8A1A9@SG2PR02MB5878.apcprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [LLheTn0gQfsL2VV5tZPlQ6OMH9Qk/MsQ]
X-ClientProxiedBy: TY2PR0101CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::19) To SG2PR02MB5878.apcprd02.prod.outlook.com
 (2603:1096:4:1d2::9)
X-Microsoft-Original-Message-ID: <20221207082036.79728-1-wangdicheng123@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR02MB5878:EE_|SEYPR02MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f33004-89e8-411d-8088-08dad82bf7ca
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LCTqkMB//P4vt36i9/oB1p1euwMqBI924fKQ0jjn80GD276eRaWdNj5JB1HqGRhIO6UzjwP/gH84CjD8RN4CQNt+NPJ/mlvF820Acc20yHmYmHGf6oIQz7Z7PbBbBrSlRINyOYUAUKYfitmyDwNjWqrHvZ1UCfz7tRj0kpucDgaa7iwcj5lVDV2lBfEFv5SdS9Y724H/SyD17wM8PL+EUt5jCRfiZJ32i06cjT9fK913poggfkXgzM5iCbk2+0+MnEbBDGP3gd3G4X7fTch6q0Y2EYKXJZFgEeFhaMtHWk1J8TEhDzMF8MqFyekYi0nKXl9X4ckplFbw+egV/Ljr5+Yg6eqGqEnYq+k95/cnLiAfQGjyZc/eHxvhsSP0Y+veOGefb7+scomebjeY1K8/1zi76e33BPEyas7DovQDh5OuR2zLn2r7ZpluZiGrl1r/G1dmLOIep9Y/t7xJrOhltmW2Cc2HokkH3x71Psikn36Wm+J210EkywiQBPirJhK/uf76Z2qXTS7HyyuF3Y7+9Dw0boJ7M6X2lmKWYf72qaVpwSbE0r3SCRqXEpBxWwdCybdzMIc4JwNZU07jXyDko2j+sMCIwYiKUI3hPH5eGsI=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4iZgn1+fjJKFq8v04bT/BliiwLaEyUbUsPLwJJnxDvmX/QBeOmtCtI3/Z4zX?=
 =?us-ascii?Q?3pVMBionEeK6AulC3nCSgayNAWDXbI3AUL6JHCgaVFYKYdJiVGsjHgdHMPRb?=
 =?us-ascii?Q?w3nRAKFVwYgg+SB68dk4ldHOG6cX5sYjo1XwYqj2iBTV3JR94c0qI+MvS7Xm?=
 =?us-ascii?Q?k/Q4oIOXBIQksLRfH/7XnN2pnNaywPWiQzbtg6qADT8arxXQ3Bkw5rhELt5g?=
 =?us-ascii?Q?3V/NecWXISi/O4UfTdQ2ueOkQ74zMOgRw53HWwuCjzj55aosPAkJyrf/zIA8?=
 =?us-ascii?Q?057Lrsx+6iuKi7qWYBS2Y4rxq0pMnp0QnhddHMB0cQSjQuKdTbiKE/Dbl+j3?=
 =?us-ascii?Q?NHiULEqCxjcynwxZMEAqrTeUhY4LBqkTSbk+H5Uwr3nhowNMnFxOb84+PKxp?=
 =?us-ascii?Q?ymTjt0oM7mDDVZRED4X9SNLA2lXvbRer5XiDSeHPN5M/bgJZwb1UwkUk/kg7?=
 =?us-ascii?Q?Xk3bj5mzDqylpNLZoVWzPamy22rtr8lXkJGkN9vLXqquSGxRuMUmlAOt7zKc?=
 =?us-ascii?Q?xrD+7QGE4xTucXNQXMPki45iUymAPL1uLKxN9rBfdPPtjWLf5dtwdgyvunkW?=
 =?us-ascii?Q?xN/Oxp3y7tQmogyrpLnaNJYafyXuZ9/uERRMX5MT4H8bHoBZ4zrRKKKqXMuN?=
 =?us-ascii?Q?R5N+boRfx8ah7bBB8vsw5Oxn61SE/4Gpc0OIb0v7luMWcuJYWJPaQtzbybM1?=
 =?us-ascii?Q?3xTsoYAAxBI5XNr8GGsXkWI8mzrsEnN2nJ6P57R/KufYwpKqfk/pUuPp95BU?=
 =?us-ascii?Q?vKDoRQH8JjkoF4HcTbq6h/t7szhpxQY2h43GIGG9XunhKiYNe5ROxxt2iasg?=
 =?us-ascii?Q?6OEhr0OE2WnJ5TMalMc/IBBfAPZgr/QQjfCxP7QBQ42ZvhmoI/AwdRv353oc?=
 =?us-ascii?Q?xK7rGFSE4lDXH2QfCYWzJgraAkQVSh3ffHuOyYgHnnVFwvX2thGM+YowWWhU?=
 =?us-ascii?Q?Cj59MUbCmgpxx05071Qc1R81nKGJ3Qsw1dkAh4YVaZXxgPDpIaW4/Jex7OmR?=
 =?us-ascii?Q?cJuSYoUp4NshsOtcAyfYSrBkafVb3IFCgEC6jNohyzmmVIM5rVNYA+OUYNNK?=
 =?us-ascii?Q?X+WvQz775/PSHMfe0dt7yHQAEgs56M2jSxcwu4fhUgopRAiTGxGgAVHQDD2j?=
 =?us-ascii?Q?BSBxaYMEs2PQO6Y7qoTPIFjMKxyIj4VmqO9EkBbauaCH5oL60Ct2tjpKXifj?=
 =?us-ascii?Q?IdOXE0KH598M7vF1wiX7eijkrleFHnLeKjqALKkA6QI72X2iyLLs8mBD+R58?=
 =?us-ascii?Q?M5Sol8ZlqdMSnAgg0BLzES7XPl71pPIPhNcGAanKuCxiYVX7r0+Pg205rrlL?=
 =?us-ascii?Q?TeY=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-20e34.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f33004-89e8-411d-8088-08dad82bf7ca
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB5878.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 08:20:58.1452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB5896
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wangdicheng <wangdicheng@kylinos.cn>

Add relevant information to the quirks-table.h file.
The test passes and the sound source file plays normally.

Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>
---
v3:add body information 

v2:use USB_DEVICE_VENDOR_SPEC() suggested by Takashi Iwai

 sound/usb/quirks-table.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 874fcf245747..271884e35003 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -76,6 +76,8 @@
 { USB_DEVICE_VENDOR_SPEC(0x041e, 0x3f0a) },
 /* E-Mu 0204 USB */
 { USB_DEVICE_VENDOR_SPEC(0x041e, 0x3f19) },
+/* Ktmicro Usb_audio device */
+{ USB_DEVICE_VENDOR_SPEC(0x31b2, 0x0011) },
 
 /*
  * Creative Technology, Ltd Live! Cam Sync HD [VF0770]
-- 
2.25.1

