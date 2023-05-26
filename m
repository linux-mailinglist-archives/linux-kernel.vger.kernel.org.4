Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28042712626
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 14:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjEZMCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 08:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjEZMB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 08:01:58 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2094.outbound.protection.outlook.com [40.107.22.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276E1199;
        Fri, 26 May 2023 05:01:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOqbEPm1ezFPH+Yrk4iVCYhMjSLmzN5iRwiyQ8a2DYGI3TMIHK3TALKcYPhxVzx8glzwbPiFB4z/HdeHrZL1XXRDo4AvThuP5Z7ysH8HS3Fqy+Vg4WDly6l/66IeJy/entHuFXG+LZxcXk2izfPVSacQOWEx+/5ft+AMbIIL6hYEAXGBve6F1zGv+ggRU8RA7QWKS20JbCrCXC3aQ5px4TBEZkSm2v6LrXUY8M4JAWJJGsVcuHhIr5v/0+6zVHgHcYdcBZyY6nKKTIYaLc9dxrRLdG18SrNo3u31ELc7VMITZVLsQMeBL6xmIDvujH9q2aQCf4zN6kGLWQznkvp1eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gDPAk4gxgf7HtF42qvIHBcx3h97h4jWV6S67/zMkpI=;
 b=Jewyt2REj6Timc07mnQbGmQgoA28rmdWtmwkgnBhOSepUHEvKGua3ZP7mXqHF77UyhauUlh3t/QlQx8LufKCtC9908HwpCghOrO0SvU1C80ARdE3UEjbozB3zbdm3XRkq6Y28whE9x1PQRsYTY3jX47lUQdlMwyNb2eBqRRHIy5DKdskp52zk1Ru9R0ZQjcxFUBUTDam/mweZi566Kye8FiIhfx0B3L1B8a39OEEaQKgJPAMkQYDE9EuVwBBV8/wgFSNikzZsx1mQSLqhCUoSD+VBXIV3dIgh70B7HSDH8yTaS8bkSPrhvMt36h7KamoVw7JWKBthwY2buVhtszDzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gDPAk4gxgf7HtF42qvIHBcx3h97h4jWV6S67/zMkpI=;
 b=EBUdSDQeNGpPzAWuq49enBZsw//QZ4U7gpfKrU6RMYaKiX4ZgCYM+pgTUBwxL1FqafnxjA8zFBzYEMAKlh9nR/xhM7CnAr4UR66klIL5Tf9xJ0SYwo8eZrT9RtJMGRt20BBsXauxaZ8n3LsMIw83JIWzXf3+EDwGYt3+4KnNCQQ=
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by PA4P190MB1101.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:102::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Fri, 26 May
 2023 12:01:50 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::398b:5b73:7509:65fc]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::398b:5b73:7509:65fc%3]) with mapi id 15.20.6433.016; Fri, 26 May 2023
 12:01:50 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Roger Quadros <rogerq@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Aviram Dali <aviramd@marvell.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Elad Nachman <enachman@marvell.com>
Subject: Re: [PATCH 0/3] mtd: rawnand: marvell: add support for AC5 SoC
Thread-Topic: [PATCH 0/3] mtd: rawnand: marvell: add support for AC5 SoC
Thread-Index: AQHY45PNiQyYrdEWN06hu0A4/jLhu69rf3CAgAJMXSM=
Date:   Fri, 26 May 2023 12:01:50 +0000
Message-ID: <VI1P190MB031742E17BBA60A36FEF9CFB95479@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
References: <20221019082046.30160-1-vadym.kochan@plvision.eu>
 <143fb1ff-b2d4-a6fe-e892-b55a7bbf56f8@alliedtelesis.co.nz>
In-Reply-To: <143fb1ff-b2d4-a6fe-e892-b55a7bbf56f8@alliedtelesis.co.nz>
Accept-Language: uk-UA, en-US
Content-Language: uk-UA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1P190MB0317:EE_|PA4P190MB1101:EE_
x-ms-office365-filtering-correlation-id: 930d2d49-b382-4246-919b-08db5de0fd1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dzOdD0w2sdEK+WXsotD0PZAm8qJmgql5zYGRhoGKLf2GslVSkOYDkVQzQzprFtbwTwhlUei7sC82LItdVebw2nSdH6wdEcTrgplYiwkFF4+mBTYKTaSt+Y8hX9V8TB2NnRbpNeiNNnx1ipysJfsGtmt4z0qoWq4M/NQu+6TooOTTQK65rrhyXZx5L/RxoLFlITWTvUk5gwv0uHV6zJUtHtsH/4RT7V7OyUqEm8WCFsPzitDciCdPIMjyWISS167mH9jLanux0J3UpuhhtIbaEl2qjOBcj2zQZBo3ne8AHvvNjeOneUxlPTIoIHdKByAGxyWvZbxgkLUDYCUUjTezAAn2EWe80Lh6FPbtfvyHMsY6CIHNHvfKEQ5uKY29cxQffEF4S22DeGhnkj4bLbzhUQ4NowSTXv6ESq0G8A6t34vBWdqcwYWT40tO/ndWAIqEFuC1n0gfg9CInPjLhk1bu0zXpAfPLO5FpndVibZZWoaA/7JoNKak3mJy8w3KlkWe7SzvIBHDif2qihGJTFkDft8PqTTAjCktV5UT/b7XZ6ICmXtOf2tNID6N3uI6gvCq/zF73GaoRdQmvEuOPiJ6F4U5CxyB478m516+F5SFUXc9MRyUw9zVg5TIo+RwSS04mN9V2ULDv8LbQ1ZHE1h/hg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(39830400003)(346002)(136003)(451199021)(2906002)(64756008)(76116006)(66556008)(66946007)(66476007)(66446008)(5660300002)(52536014)(83380400001)(7416002)(8676002)(8936002)(44832011)(316002)(41300700001)(4326008)(91956017)(33656002)(110136005)(478600001)(55016003)(7696005)(71200400001)(9686003)(53546011)(6506007)(921005)(186003)(26005)(38070700005)(86362001)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?koi8-u?Q?+YT3yRQoXtCX4cjESbFFkFLJeKFWOeIeHB1MZxrITYIX4t2awEqUItL4akk9Z8?=
 =?koi8-u?Q?ZYDZje/NfJu2osDkOIfiR2tmRHpUixMAK9xLH6SUE88uxujCX4tUm4vfrKTNyB?=
 =?koi8-u?Q?WFba9ek77/TdX6yyAYEJKAL6QuW87q42Ax7fE9A1gT/KOHlMgQqabwlLjjiUU0?=
 =?koi8-u?Q?qYc/pA3uhFlqHnqgmkH3PIEHvUSjtStwFjD2GOrgqqQuCafIunEvf5I/vQChI6?=
 =?koi8-u?Q?gLiyXxUfBrRUxZRtWNLJ6vx3QvVIenN6oCC301QhpWSSRWHPHRmhGY4K7IUx5o?=
 =?koi8-u?Q?S267ynZaZ8GbYenydzmCbYd6nvPfIC6nBM/a8d94jnNwAAyy0UFTLNg8yNF1wU?=
 =?koi8-u?Q?RldoORDIsMqm7Ima5zsKQvB9mCns3gAmYbEu4TRSnzGHLm0IQ7v+ivL32Gnrbi?=
 =?koi8-u?Q?jvZQCQRc67xYOrkuP6XkxawWsyrLVGxACMfRpdwR+W0BgO1Z7dzas4BCJHqe9X?=
 =?koi8-u?Q?9OcS+yARcHLciqXQhNU08EhS7leS63UIWFGG+yc7i2ISvjrYToqhBSdjMCnNAc?=
 =?koi8-u?Q?Qldvz5qGfGusAyy77qv1GoBrQgZSpszJewta6RoiTb1ND6ry4eALyt+xfOO5Lb?=
 =?koi8-u?Q?15kzUNoHrBoiiKDH7YflV9GW5hy8bICDAp6GyyhMILQNtT3ntc6ZgPvf9KZU9d?=
 =?koi8-u?Q?sXamtb/boKJUkqr2GWpGgc1VAt69eQ3uiULn+A3/KcDs46WkRcRWI4RSAA5Btz?=
 =?koi8-u?Q?b52cIIeTPZxOwA25kyiDuJ2KXQIMKh30qpIdjowjHyEPlFM4tkNxHjW4xi9YRI?=
 =?koi8-u?Q?piIgil1D+urdaZiW7C97l2uZGyxJ6IUAUU0qdMDZf50VE5VoqLTT43UoZTIIpE?=
 =?koi8-u?Q?sTcfMe0Qp1aPT8C+kFyBiWrHveZJgEzF4ArYXTQVVsNqO7NhnoEP35Hs/BGywk?=
 =?koi8-u?Q?QK241Pkok/Oc4+6DJnVf801iHihrLjuFR91CSkrdau5OBonnOU3GqmkPv1FQNi?=
 =?koi8-u?Q?b5gEaMDT/oSka5g+gO8owq4NxQ1iC68nQHIFGfs7D/hza5JB9e3vVIvc7JCg2y?=
 =?koi8-u?Q?eltWrU2Uple2I5MF9V23rDA5yPzN87mOJXJpsXxbEtbk2vZgQrMIJeilGlMB1+?=
 =?koi8-u?Q?O42Lyn+EvGw8bLj3jfRHNXktU0VkUM+Nt8VQ25PAK5nXNj4Waj9lWg2x54ZozD?=
 =?koi8-u?Q?iARmi/ZJGrYaNjXKxIIFSRUG3Qqct9VtIHP8jnQKDn6g69h0CFX0Vd+6/qLz3F?=
 =?koi8-u?Q?KpT5r9xW8riTrVJWWYdDYH7Kq3/Ofr2HsJ/XSMwjJpGcP/R8tHL+ZmiMDwiX+6?=
 =?koi8-u?Q?yMEwenUfAnt5qrKssbEd0bifU5oEAxeTC622JACKvq2NzlHmvpGXRJ4Rq7WIST?=
 =?koi8-u?Q?gsFs3ZAcKfFO94aYOKhQMGUHtHoDeurKVUoPw4gW3dsxGCi/SC3bRPp4xIeS2F?=
 =?koi8-u?Q?AI3nQjd36c8fdvAaPp1NxV7vM4Y0LNqTHjduX0mTulIbJHnaqpcyDySmKpiOQW?=
 =?koi8-u?Q?jWEbyOFus7ugKvbejx2Gudso5Rv6oST/YjyRe2ahReNq1j6iKuVx9qX6MNh8K+?=
 =?koi8-u?Q?ZbdwU8SI0cs1+KLcPewLLGbwNPMECpfCEaDsTMCtIneUpfahUL?=
Content-Type: text/plain; charset="koi8-u"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 930d2d49-b382-4246-919b-08db5de0fd1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2023 12:01:50.3318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zp8E30ppbzbpI86lkDgsLeQsrTb/MQy/bQEngoz6qlCtnGpLPaHr/7eMlOLUyqRPMa46ticZxJGaguSodW4ip5w9kPngVBxVpF+lFk9gq1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P190MB1101
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

Sorry for the delay.

Currently I do not work with Marvell, so I can't do anything with that.

Regards,
Vadym

________________________________________
=F7=A6=C4: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
=EE=C1=C4=A6=D3=CC=C1=CE=CF: 25 =D4=D2=C1=D7=CE=D1 2023 =D2. 3:53
=EB=CF=CD=D5: Vadym Kochan; Miquel Raynal; Richard Weinberger; Vignesh Ragh=
avendra; Rob Herring; Krzysztof Kozlowski; Roger Quadros; Florian Fainelli;=
 Wolfram Sang; Liang Yang; Thomas Bogendoerfer; Aviram Dali; linux-mtd@list=
s.infradead.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
=EB=CF=D0=A6=D1: Elad Nachman
=F4=C5=CD=C1: Re: [PATCH 0/3] mtd: rawnand: marvell: add support for AC5 So=
C

Hi Vadym,

On 19/10/22 21:20, Vadym Kochan wrote:
> This series adds support for AC5 SoC.
>
> The following changes were made to add AC5 support:
>
>     1) Modify Marvell nand NFC timing set for mode 0
>
>     2) fix validation in AC5 Nand driver for ONFI timings values modes 1 =
and 3
>
>     3) remove unnecessary nand timing-mode in device tree of ac5.dtsi
>
>     4) add nand missing AC5X layouts , add option to use ndtr predefined =
values
>
>     5) Zero steps and total fields of ecc in ecc controller initializatio=
n so
>        nand_scan_tail() will calculate these two fields, otherwise
>        NAND initialization will fail with kernel 5.15 and above.
>
> Aviram Dali (2):
>    dt-bindings: mtd: Add AC5 specific binding
>    mtd: rawnand: marvell: add support for AC5 SoC

Are you still looking into this series? I see one part made it upstream
as commit 68c18dae6888 ("mtd: rawnand: marvell: add missing layouts")
and there was an off-shoot series around converting the DT binding.

> Vadym Kochan (1):
>    mtd: rawnand: Partially revert 4114f97c41cd ("mtd: rawnand: Get rid of
>      a few unused definitions")
>
>   .../devicetree/bindings/mtd/marvell-nand.txt  |   1 +
>   drivers/mtd/nand/raw/Kconfig                  |   2 +-
>   drivers/mtd/nand/raw/marvell_nand.c           | 277 ++++++++++++++++--
>   drivers/mtd/nand/raw/nand_timings.c           |  14 +
>   include/linux/mtd/rawnand.h                   |   3 +
>   5 files changed, 264 insertions(+), 33 deletions(-)
>
