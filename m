Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9106765AED5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 10:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjABJqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 04:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbjABJp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 04:45:58 -0500
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2053.outbound.protection.outlook.com [40.92.102.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82604D5F;
        Mon,  2 Jan 2023 01:45:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDD63lWmef18VLGXGhdtJvjNeYdSaFCYUxgMMujS4URlwPPtoQOmBBtcBP9V0JAcOSugfbBJ9W8EysrNqtmVYtpqv/bFny+2AD4NYuN9W0HBNqRfksnag/wM2AwnE0QObgnqWPAOcQTomY9uiXSrQHuufnAcsomKqZ3rNYlHzQ4JPpswtWPAEUb6Rd9PPF1TPcDgLCoKt3F1AC5vgjqO+b0eyXIVfoLHsEWbSFOtt8g53t+vcY5JHaSvd7uur4nwzUkGoHYzZOmNxtSPLe1tdBwU0H2vsV2dYMCFdy2alVS7lly/upIT9aEturlqeQnSUmRChV2pRSEU82yXl2nNhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LP4n11FLTAkf6LyGzfvJPsp94IIRcbjWJWczPGIjmFk=;
 b=TEl3r6xvGY4lcb8b1cRvP081V9DRzBRg8txCq6+hz0DS1zgJjW1iEkhe3HKvkAKFvPXJptvdQ4c1Z1bDV/Wg/yZMQ7F5wuNwmnI+W9Fh5d5cezSsw0MFLYhAMjit1cBXxMxbzZQYEgTjFhcntp62OG2TyqNN3vhj+1YoGBP/WD7awzRKvmysjaObRO4la8yyjK0I+XXAtt0HhLBJvVyMeuDv142EY8kFixy1MW4cy3ziTQTLtiwqkXA4B4/wcgXxuPd2uF/SC5M6QV4uT1ggawTHdslYfQa3fhQ6GL6yhEEofacASPKsbfeOUBfLzPs9exjO8+eFOqBx5v+KhgNKPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LP4n11FLTAkf6LyGzfvJPsp94IIRcbjWJWczPGIjmFk=;
 b=QZ/EI+5tMFLq04msgQUWQ9ipa7mJS5SMrzpI3Efx1wHJD4PcFo0T9puY8AQuwscwn1cI0X9xP8pWqU03XCDRaeD5SiNtFS3grq5umWLsefR3pCRZmOivsGx46w7uj7SA7//lamaruinV0NE7ntI3+I27RcR8DxEiV9jT92KaF6sj2c5yQSy00v37Tuo61+a8CkOvXvohEmcXJAJU1KqUn9eslqb6LI7fi1Fyp8MR2TlVMl2+NhB8GlGga9MjOaoawpvvczMoNax0jnbaq6bGXZRV8mViU++K0+xDShXeTIgbWnqLcQCGN2I2UaAKxTA58KDTwi2846XYKPCPJRwodw==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 PNXPR01MB7090.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:c5::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Mon, 2 Jan 2023 09:45:45 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f90e:46bc:7a0f:23bc]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f90e:46bc:7a0f:23bc%7]) with mapi id 15.20.5944.019; Mon, 2 Jan 2023
 09:45:45 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Hector Martin <marcan@marcan.st>
CC:     Ian Lin <ian.lin@infineon.com>,
        "alep@cypress.com" <alep@cypress.com>,
        "brcm80211-dev-list@broadcom.com" <brcm80211-dev-list@broadcom.com>,
        "brcm80211-dev-list@cypress.com" <brcm80211-dev-list@cypress.com>,
        "franky.lin@broadcom.com" <franky.lin@broadcom.com>,
        "hante.meuleman@broadcom.com" <hante.meuleman@broadcom.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "Double.Lo@infineon.com" <Double.Lo@infineon.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Asahi Linux <asahi@lists.linux.dev>
Subject: Re: [PATCH v2 2/4] brcmfmac: Support 89459 pcie
Thread-Topic: [PATCH v2 2/4] brcmfmac: Support 89459 pcie
Thread-Index: AQHZHo788NMBa+5HNU60gzVi1SpvqQ==
Date:   Mon, 2 Jan 2023 09:45:45 +0000
Message-ID: <6D6035D7-894B-44F6-B35A-3EC9C57029B5@live.com>
References: <20220922104140.11889-1-ian.lin@infineon.com>
 <20220922104140.11889-3-ian.lin@infineon.com>
 <3eb9cc12-db75-8042-4106-fa6521c684a7@marcan.st>
In-Reply-To: <3eb9cc12-db75-8042-4106-fa6521c684a7@marcan.st>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [FXAHCpcMFoyshNucTO9Kqi4ayHRcV4ddqJYkHH4o2XyH2lBO5oPqylVBsiOmrYfm]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|PNXPR01MB7090:EE_
x-ms-office365-filtering-correlation-id: 358eba35-1421-4006-050d-08daeca61f0e
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wqLqBiuPNR3+yUjIV/HZ2mWXqH5keLcoATIE8K08hVuFqhiZC3KmKCe72mTqkc57hRdidx+Y2awtD4IyYFz2H6fvva03SvXxbIliBg94jq8rcdV+6YS5P7V8AiUdaPYIZ9RKdY40DUV5qg3QzjxJIr6KnOd5J09cXwXWHxvTCeiaFg2vd9UKqM+mU91hHPyEeB1EFjLYQaE+zu/iC1bA4C118hCndjRnvIy+ntl6Nvun+O1WvVJCZJSnxxafNE8y4JLxegA0WOwCIgkUVEL8oFzTcjUR6E82fmWfrRwdcdlSktEVucw7JMZLHhoYus6T1+rKeTndKtcejtz+ONiIb73qUKBe05jroOVq0TQvXZ65f7kaStr+X2QLbJM9FA659HtHuvnaecPahvMYZADl8WChT53w5PUWtzpBmvYlqJIXCKzf1ypLccN0M8hAIAJBr+A2XZRTso53/GQzDtZbAG2YSAWqW7KRaXgEUxrbNYcm0IdT1wxXGQ+JMsJ6klDwPOAu9390WXpbI4jsCMSriW3aGlhg+aN3Kb0jnGFSr7hS2l71pv4kfpPbQ02Wh/bewIU/x7atvtc2MqjUry1akkeKQdq5EnciYe2GBfnk3UduAN7fM9u1nuDAXEO4Kk9yDWZwsDlbJWGAlP1tdNpfXA==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T8rp/Vt1iJmxqUDIgOG06osf21A/yupKRSOcfHwgsIpra2whQ5m0x6s009du?=
 =?us-ascii?Q?0g0NeRW8LQinxPn6hdrt2aCLFvlg1HLwA99f4kQwL6H3nmOAdk3oRsvOfmyS?=
 =?us-ascii?Q?mOci8IMdneBJM5K9EXr9VqAA5H9hzVjjzkIoRHGoHuZat8Bt2Gbn9xE3RYpt?=
 =?us-ascii?Q?tWWtQ2TxZy8cIyK5Y4cbHm3dV9viS3FaUmwYQdIU9QReaL7eOkvVSVsOnJuw?=
 =?us-ascii?Q?q1YF0tSqwRmmXQaI4MTLS+FFeKlyZ1M/VoQOCIda1MclmMSeuZWhKEnmcdsV?=
 =?us-ascii?Q?AYryyrSgkNq8FnDPkj1Ndrq9EDnrwFagX96L/lUUQgWc3pkHzd/Ujzuz5eb5?=
 =?us-ascii?Q?ERduBZaxd70wxyXzxZ+LDDws9GjaEZTYa9b+BYfyxNLDnNZT+ucgIThkUM3X?=
 =?us-ascii?Q?wO92haaGXkJMeZeCm8X1zz/+A4qk3Dg8VNq9lN4JBpBYQ4wPbzrL/QDieMvA?=
 =?us-ascii?Q?K94GKWkskFIXL/hPnIsrYcTD9xIObBjncjRel51FKbK6Ee4lue3+nfKCDcdX?=
 =?us-ascii?Q?fYm/LF4SrfuR1I6ss3MhBGgEHfynVyiynIICYz4htIW+r5kDnTh4DRU78XkF?=
 =?us-ascii?Q?bFrqhEF8JWUlA2h1Eqs5m7YuGq8IMYQe0qterf7ldEvM0rfh4RF1pwSLaBpO?=
 =?us-ascii?Q?4muUR0oEj36m4R5Yx3F1wqTetLCUzx2yij6ByuKYYmiXVXq0rDarNPqluRIh?=
 =?us-ascii?Q?ZlZZiXNcBWy3ZS1JnuLku+4SRyLZW14e8lJQ3jXSwFhIAZ1BRWtYezrm84/o?=
 =?us-ascii?Q?EbQibLFrPNRjxERIrD3LfZBi4dxTNehsfk8rUZlnIRSDIp5wjjNcjSUgTV6j?=
 =?us-ascii?Q?kx0IYzmqcqy5ulEy/Ym6wuUYoeoyK0Rj/6JOtfEUqdNcWtjqpQ8UdzosYKp/?=
 =?us-ascii?Q?I7hYMdWNPHgOKsHDa0GZ6m6hinSnRbRGlCIvcS79paDUZjR6rmX9eJhGjLGR?=
 =?us-ascii?Q?pPfGbOBoIBeX2iGQdbwvh8v7sYNjjw6oZjI+rMm4erDwiOkVxGlQgGmn1+vL?=
 =?us-ascii?Q?ZCBuny3L+1BFWC6S3uFbrkepq1eJBESkVhJY3vYaq0WCHeV6NXX5zNmnmVHf?=
 =?us-ascii?Q?UU9kcIlk4ugkwtS/0W2kCKuOh32sfgiMyTUxUJdkupM1rI3TuCwm6/4FlFae?=
 =?us-ascii?Q?Q4NqpZIPRX8jcqhg0VQkrx7hrlZEKPTAPE5r7wfVuAiIvLxuaQj965sJSWoi?=
 =?us-ascii?Q?GiOmkXUtSNxfJLhiyryupkrD+UQ/TMkQ+MOGIUKyGjzHZKIWZo4jKoG+dIRk?=
 =?us-ascii?Q?AG7WxESoIndA9Y6tJ7eF+uimeulLziyUh/c5LYKKLckvpoK23gzySuLc4aSd?=
 =?us-ascii?Q?lcRW4cYCxSEWyztRgqfS1HTxVECnZvUwTq0YBWLyuKvekw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CCB8DEB9BDE68D4DA65C0C6A9E1CAC75@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 358eba35-1421-4006-050d-08daeca61f0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2023 09:45:45.5460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXPR01MB7090
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hector

>=20
> Is the CYW89459 just a rebrand of the BCM4355, or just a subset? If it
> is a rebrand, it's okay if we call our Apple firmware
> brcmfmac89459-pcie* (note that we use per-board firmware names, so it
> wouldn't conflict with a generic one). However, if CYW89459 only refers
> to specific variants, I think the firmware should be named after the
> overall bcm4355 family.
>=20
> I'm guessing you intend to ship firmware for this. Would that firmware
> work for all 4355 variants, or only the CYW one? If only the CYW one, is
> it possible to differentiate between them based on PCI revision ID? Note
> that our 4355 has revision ID 12, and Apple specifically calls it 4355C1
> (different chip revisions have different firmware builds, which is why I
> named our firmware brcmfmac4355c1-pcie). If the CYW variant uses other
> revision IDs that do not overlap, maybe we should have different
> firmware entries for them with different masks.


Can we make a separate table for the OTP Apple chips, something like here :=
-

https://github.com/AdityaGarg8/linux/commit/fc41aac9283d2ba653a8b3191e8c013=
8c13d8ee1=
