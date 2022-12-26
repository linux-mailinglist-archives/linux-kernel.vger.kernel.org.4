Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590E26561F3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 11:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbiLZKoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 05:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiLZKoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 05:44:13 -0500
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2017.outbound.protection.outlook.com [40.92.102.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA18CCB
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 02:44:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKhOcL492b+RpA2fp1tjLE9VPZa+5/AnQCWXtpvIvsLnHG2BOVkm63HqZt3+T1RX7CD9cZ68ahXeuajNawH8JO3BVa2n+RkGK6hTiiB4jkSZGZkxZkLhkOAP8B3So//aOtxCi8ZxyMBT0p+nKQ5px1cc4UjV2aBFET3FzixKi//AfChy47v6PIlsNqyhc7hqQHRgON/m5bmsVNpCkI4R955j2b23ZmQWyW3JVEnR/tvoaJQNzWPeXBSmZZSPjEBtQlaLTs9YCFR3Fgagb3fCGfRewS7+fbyb7c/jRoN++2TsIItDSP8stGac2ai8r+VPJ4rvKREdOWerB9O6AUI4yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5G14hAMWL2l8vJlHnIAEggwYcDvwjxuu29qluLNh+Y=;
 b=cADrOXhRzBliUp3j4e8oQBp0/rYwg7Gaa3MJ3Jo9QV6arkJIulmfeBFrYha4pI30aGtSC5BEAr4nzoDNo6mb7FHtrwIjQIDwu86N3aawcf7GNMJKgVKyBp7I0Z0mPuL0LkRQCYJRbEQ0p0AP+1+jRh1IbZeLgfJiKWuhShFhcmhk6I1lAheEVUtSql/pRSm58gLP8IJN/a0bJdZFoEs/iu3eqoSEO7Isa/HSaD4ic09mAWDG7X/UyF7zHENkcK2+zUQBN3SAwAbAXDRHnzyG3Nei6Atdn7vxWO/XBsAJuqRQRVKL9PZRd+Wf3pUkKYCBTjLZpg1CymUz/a9jKLvc7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5G14hAMWL2l8vJlHnIAEggwYcDvwjxuu29qluLNh+Y=;
 b=me+AFyRlmDYmPaBz0Rc1ytmaYjyL9kSmvh88O3cATdq9ttQ5USiCI24WKKuqi0b8yOiKeoFZQ7PfqcTzhiPLoC5hH3zXj/1ctRFbgJ1taebmnqwsCO48ROfxs+IXy13Hkycx+XNlvcP2s7awHlAnNy7FbHmb5mpk5cvB9y7p7zLOMfHocByM+S4SKQuVblsFfHc9enrABKt7mEi80gdBOrQ81EjiRYV+58s4ooWCpy32MyKoLmNqI1D8Hbr+5CQFoOHPiR9Pk0h0Bv9wl3Xo4eAuUCLig7SoAkq0xaxodZLR7lWEkV2MVvw5eeeE45NoE8g0te1iIJHzYm7c2qni0w==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 MAZPR01MB9031.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:109::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.14; Mon, 26 Dec 2022 10:44:06 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f90e:46bc:7a0f:23bc]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f90e:46bc:7a0f:23bc%7]) with mapi id 15.20.5944.016; Mon, 26 Dec 2022
 10:44:06 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     "harry.wentland@amd.com" <harry.wentland@amd.com>,
        "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
        "Rodrigo.Siqueira@amd.com" <Rodrigo.Siqueira@amd.com>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>
CC:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Orlando Chamberlain <redecorating@protonmail.com>
Subject: [BUG] AMD Radeon Pro 5600M with 8GB of HBM2 memory shows blank screen
 on Linux
Thread-Topic: [BUG] AMD Radeon Pro 5600M with 8GB of HBM2 memory shows blank
 screen on Linux
Thread-Index: AQHZGRb6uT6dJkmogkGgN01AW6oP/Q==
Date:   Mon, 26 Dec 2022 10:44:06 +0000
Message-ID: <3AFB9142-2BD0-46F9-AEA9-C9C5D13E68E6@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [kj23VZFuMBM2FvmDMyhskQxrkm4NtyeFnMbm84NrUPdU7jg3UjX4Y6zVkQFX5rBx]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|MAZPR01MB9031:EE_
x-ms-office365-filtering-correlation-id: 1ad4c993-3a7d-483d-e66d-08dae72e1ce5
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ccaQsBw/oy+8/iIYhraDSprL0KH/PkM3Z4sq4zZRsd0SwblAFfJnQY8/CaZBPOYR2N9a1bBPb/x06HuWlb2qECkO+OXrfJwVQyZa2FaYzNXTELuIQ+XdPpFlABWG/NL8Q0Bl/w/VXhLN0wAKvHNlojP0zo5Itr6eQFPsChJdep0zVe4jm6Wf7B6ez9Nn4nR5MZO1n/Z2SuYRJxDKSMhYaP8pHOzkdIagpcEYZyJEp7Z+lmZsojFXuBICt7jfnIsfsTCEj8yEC1gQW3O6iEFc28XVXeAkboG+FGl4umLEPZbWYM7l4fzbzvqWTNWQwJR2MGUpfCBSTTiVhCokI0u8lnDkNawc0MxefbSgUzWUiudJ45DT5ryJZVKtWaUiQghzRj5IRttzSomH/IFihtlp7ZujLWVmzXtQ9wIuj+h4xZ6ZnSnAHXw9THBE//N4o0+m13ceobWdflHNMJSufhYqc2DKxrCJ6Npvw9B5L/QLh1XXFPWlGq8h45LYZynA0hwolirJ4WFR6mbJngOZo2e5aw8vdkY8HA9gdjk3iuiyLvEv7BZAwnk/w9U5amxIQxyiisx7DA9qERmcvQClSGWe3A==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TfKh3mA2Y4vgCJYuPZqPaaxJZlv7Xfteyegp4P7jF+MEhRkW4lRlMfyJyYKx?=
 =?us-ascii?Q?xUSevaKUd/KM8w143u9XHnQfRSWbfI1+MKTuYMBlOgOgovCvzdvcPhvpHvOm?=
 =?us-ascii?Q?pAh7SH9Q9w4UP5dlAvgzfp/e5hDR46F2nYIPx+UKgUxhzQ29sNTEEwopDyIg?=
 =?us-ascii?Q?pNKOWznPjLyYX1RZi1GQgIRjqeU0gfGSpnG7dLhUJP2k582znuF1FJmRMtOJ?=
 =?us-ascii?Q?FExBxn17SHaFVl5JBvVUo5plEvhJanMcQuFnMOtbhsau6j7CibibSSPuuCja?=
 =?us-ascii?Q?oOJ3WLR3d7eu26AoB92sFOb5mVxqs+kEiLumClvQP5krY8YH15i5mP7oHYUv?=
 =?us-ascii?Q?YI8x/Ewe1WWO95LvK4v9DYFWSGwFSWe35jYPzfHd7QleAYAeRFaC78QuVId2?=
 =?us-ascii?Q?SaRWpyuWfm8bKmjAcbaiEywZ4Urth1Q68Mo7bqgbF1p163/s70m/INd4x2N0?=
 =?us-ascii?Q?lNHj1/6LIl1c50ts45CHef/nskvt6AApRVMkc0XzmACpY1j8ubRQsO5P98P2?=
 =?us-ascii?Q?O4I9CzMMuowbmNh/pilHW9JUK7uZIol969mssAV/sHYwABxFExqkiK12R7H/?=
 =?us-ascii?Q?v7SC6LPISeHoUzBH5u6jjY9aymsDbbevdWw0iFqij4nO1BWfclmZsTDguSkJ?=
 =?us-ascii?Q?JMrK8a6S1UXUXUe/LcXbHWsRKtRaWtIRbxhvT0VtJfwHfM1lEJ7VBBqLlgJB?=
 =?us-ascii?Q?SgQPCUPREGFVvjT3NB1VXfoag0bOFQ/xS6XTHaw/EqIVhDo9IDt+hq+YjhTt?=
 =?us-ascii?Q?MRvWE1g6FLdzndNYr+g43gAMJQzCsE3hefPGEI46aK2oy/4e/ga8dqgoHv2k?=
 =?us-ascii?Q?/3mwXrGhy5c2DVf9hDz76N+QP+2YIwTIblWrSoAIzRKK/l18U5bxOjcDw2rd?=
 =?us-ascii?Q?T/REdeLU4KrrQACD62/VqWs8Ko/2br+1iMBb+0VrrD3c3YmSHDb0xfQzrrBA?=
 =?us-ascii?Q?nAWUTKtEBQ541SMrj6mas1C+vugU+M+gTvrWj9GFoh0cMCuRuy/z99G4mRpy?=
 =?us-ascii?Q?OqnOf5y7nQ4FFO6eiIWNyohyuFbpctSuEuA15mDySpfL7vam8yn5NQ4Yrug0?=
 =?us-ascii?Q?ndwXIuykz4v06ueUDpilcmW04BRx8WXNxpRJROySLGoNzndSeKPhysmIUGhP?=
 =?us-ascii?Q?DcKE+SkWWdD+J4CHfXIpQHJcbk7DHrgzl/PyKDjSvsquprZHhEpXwCV3NWYt?=
 =?us-ascii?Q?fHOeR4X9w3dncA+TbbRs6g6CWUT3/zHc/8b6g72KR9o4mt/NrEqyIs3HbdLT?=
 =?us-ascii?Q?nLFwVLDIwXJ4mZa/EBwyn4J1h/nnQ3k6OdzjevBtOxo34uZex0QTx9fpz9QR?=
 =?us-ascii?Q?iq0WX7Kkr/k08F+OjKGii9T/l9jQ2xYO3NKlCn0VunxujQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C28F09EFFC574F4DAC417D7AF0A24A60@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad4c993-3a7d-483d-e66d-08dae72e1ce5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2022 10:44:06.5530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB9031
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMD Radeon Pro 5600M with 8GB of HBM2 memory GPU is found in MacBook Pr=
o 16 inch, 2019 (MacBookPro16,4).

The GPU fails to work on Linux, thus a blank black screen gets displayed on=
 boot.

If nomodeset is added as a kernel parameter, we are able to access Linux ea=
sily.

The link below contains the journalctl of the failed boot :-
https://gist.github.com/AdityaGarg8/dfe1a1c23bf2b92b640dad89f55b73c7

Thanks
Aditya=
