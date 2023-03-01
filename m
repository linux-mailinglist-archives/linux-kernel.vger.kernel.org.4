Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70EE6A6616
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 04:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCADBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 22:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjCADBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 22:01:09 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC6438B68
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 19:00:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NcX/CtO6/jCRcAqDi9bvE7MFJXKSpVstms8l4sLup6cp68oXZFxcmIzWdbAPmfZg9ys6Zo77ouw9nx84/rUleTFWlPzFQsSVsC1HJRNoNxN8LfPFmvBxJjvNKORt0txPljsaw/dq0xpNL/+XBhUqC4/f8pHyKYO83AlbQg5U+ie0TnLcBqrICFxmFceQeJQlhK9Wj/jYy1/xZYkiw0a7HLHj7BJ78K9NM5pxvHkshdvJydaFP4zbt7z6y98ThWjhuZljttDF/5xqBHq7xgu8WsVppFQD4NvxNoVSAdWvhVT8tQvaOsxku4RdeIzUZX3oRLPUs6IWX7BV7jGakJZCGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wzd25UybNCGPtKBQuy7NpCTc+ytnhO0nBlJxc1bVMBQ=;
 b=UDhIhtgGQ+o8CJaxYAcK76YFOaClUhQibj/9QzZWtfk8mreSjNaFjVm/lfkq/epsInWXFvi2wBBfnoQ0ug4bGatyP/KQYHsidOR+q9a2eRPDbR3wTDv8EyBf+huHL95RuSBBdBmxO+9B2OgAkqCQ3tAkJ39drtJaFM4wkVJAjiEwnW74nsDK3/IXItaOe2eUY/9NJksJQZCPWWEAET7v1u0oFmSXZnIUnkVvrT2yjeqI3kUKevWnTlE9cm0UIkRIiMUKpFoRlWMcpsN7Eya1SAfjWv4F/oNO4FmXGAbv4nNSxCMyFeIrha0/mhPwbFWuFNqm/p6RpHmtIZDZdwPrfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wzd25UybNCGPtKBQuy7NpCTc+ytnhO0nBlJxc1bVMBQ=;
 b=OAh+tva+nRXHyD8kx+hw9i4xXM0IykIRva8bklReMk6RPfKxtJsAMXZux+i3oAfw1K6nPa8PRQc/F3v+evAMG2+57bRI7Z9pc130MtY4jN/yiAYTK1c5kUOhyv6exJ562O3B2NkAqXdzTkwSrtKLC64g2ctlOZbo4S3Rbo+MnIQ=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7527.eurprd04.prod.outlook.com (2603:10a6:20b:23c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 03:00:55 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6134.027; Wed, 1 Mar 2023
 03:00:55 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "J.D. Yue" <jindong.yue@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH v2 6/7] soc: imx8m: Add MODULE_LICENSE
Thread-Topic: [PATCH v2 6/7] soc: imx8m: Add MODULE_LICENSE
Thread-Index: AQHZS+kn8uQyS6vw6EO3aaT98L/s8q7lPC4A
Date:   Wed, 1 Mar 2023 03:00:55 +0000
Message-ID: <DU0PR04MB941710632B18ECAB9944866588AD9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230301030042.2357706-1-jindong.yue@nxp.com>
 <20230301030042.2357706-7-jindong.yue@nxp.com>
In-Reply-To: <20230301030042.2357706-7-jindong.yue@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB7527:EE_
x-ms-office365-filtering-correlation-id: 070ca7f6-6aa1-4344-4ce1-08db1a012d00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gm9cJueOTSLHBMpZRNjdYl1GVB1rSqo1MrVSO6jJNUQg9J9lH5K078VtB0gPK3r0BCRaxWusN+i3X+iAdoB8Q8DbC7WKWRLDll2br9lV9Wd68yEQIClfn0fzfq5rvNS10q1miCgjCdnVuU5CevUmeODnVkO/ksdAAI4vpOMfad41YO2QGvfonfGH7ahSY0N+4tj6uiubiP6XRKKMux506lxFnWTj1cYYWhN2mkDi2HiOggcedevwKK9NfMJ+EFRVuWjSY5ap+Xp7Mcqv/m8GcSUFB+qauVhukzhDc9aHJ9FZ6PnekyqaKgiXQmEiC/4AF6BYBDwe7VN7xicWxUw6CLxIxRE5jTmaOWtph8vH7Kfi16arGb7Y1Fe+det78+lWk8nLyxT8GQ7VZCpbnHZtnWZxdd24aTPRWE5BHn2XTwnEsKu9+XwcMm0bNbszT5tKoHED7qIU05cz4N0dREsXX17QgnBy4NDChqS/YX3ZbJr6RaUE+esIilRLvGFGESgoPos2PH+aAKfL8TAb3BDEiHgeI1psg3W19coO7RbOnmI8cIaHk/E7ENddem0mOXvQ+V7zTozMu3ljQArokDthWgurEybKX+vr7hwkBz/W496hKh33Wg8N8Dp+uYP0zoSPeawmoNkhVwfc66tL7TJwNZFP0/Z5xVZjisfgwGazUrvOa31dYi2b5gC0fnE/qefx4+RYefmp4kkGVqw4NOdgvgoKHz20C4qLK35yhTQeYuA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199018)(33656002)(110136005)(4744005)(9686003)(7696005)(41300700001)(26005)(186003)(71200400001)(86362001)(5660300002)(55016003)(66946007)(66446008)(76116006)(4326008)(64756008)(8676002)(2906002)(66556008)(52536014)(44832011)(8936002)(66476007)(38100700002)(38070700005)(122000001)(478600001)(6506007)(316002)(54906003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VYa3O3MIL7+h25AVNWR5/84ZTUNnZRGCIxxysD3oZ2u/RIZREPUYf3km7wDq?=
 =?us-ascii?Q?G2pF2SeS4EtyJJw5q7aK8WMxAVjkDnrByDsUpqUfBleRg9GV32hfxwtWcNBi?=
 =?us-ascii?Q?b8xUAaN7Ci/Kblm8OuXDZG8ArR1K1AbKTuAf7aBn4gwhj3Sj2gyDr53DwFuX?=
 =?us-ascii?Q?AnYwlPLZbEBbnUQEg/rCrc9Z7z9gmXoa0zD7tatK0oHKU2qIAwhkukXGM8G+?=
 =?us-ascii?Q?QSfg9wLRFmUgxYgjhiSYLdxamybSgRss5IEhhLBIkldXAy8++eJfv+9AZxpe?=
 =?us-ascii?Q?f3tJlJ+wjEoefU7mqNw7WWw6O0vDl2G0X6NzSJn4qQ9IYpgV3rXwhjei+uDY?=
 =?us-ascii?Q?udksCOyfD0rEAKFA/VyzmgIa/QtDMJ+S6PXmos8h1ONAttDrpiPPQvuEwxri?=
 =?us-ascii?Q?8OkNTy9TgAPfi41HgAivd7EHUGr5vr3ZSjsQ4EXBhMtVDCgXAl/LVaDhKdAa?=
 =?us-ascii?Q?LBIyXySu3E3FgQxKs4knpRfjxXl/CwuqVI8Rfjaw5W+mZT8njH3ytFkxXQnv?=
 =?us-ascii?Q?m+hPIpXxISP8Irmlto+O6CPPz3JBPkjpbnt6RaBwvXs3SoMGlMXSxDU9na4r?=
 =?us-ascii?Q?xVdiqxWltGBIBjJpwmC5AaK7pk70asQtWqvG566tFHMR0wNBuoDqODepLGfy?=
 =?us-ascii?Q?s88lqVLHE69uFHyT8ukueGgU5uKpGDODg19QmFddXlrQjyNL3bJ8Ox7vsGxN?=
 =?us-ascii?Q?K7TZv+qRhIQ747pxixCeqWWZFA0sEa9AoNNfgqOvptz3Z+mPG4yzOiS8ovn8?=
 =?us-ascii?Q?I97S3bXee1/sCgclncjT/JXNLit7GMvm3gydOYZJYKRUCbtM7/2iis+XbeVI?=
 =?us-ascii?Q?XTw+ai7qCPK2tkxc0LqVS5jsZ5zyF40CZ/xLkxrhDL/z2h9ziUf2WL4Gjgcd?=
 =?us-ascii?Q?qyM318rIM60VVFhRbaNMeS76mdxFoH0C9FfHkgZmmI0eCe/XhjNcYRBabcq5?=
 =?us-ascii?Q?dovNRTDCZP/x0GIWXi3DVdhf6EgvagkjDWOg4hfsnHFrsMAnA4z/vNhjaJrW?=
 =?us-ascii?Q?kduQR4MsWKM6pPzNwJyByVNUTIb7ywSm4wl1OWnQqkPuOafrcKYDuczbsyjV?=
 =?us-ascii?Q?2u98LPQGYqvECznWzHAUtLsPs4q8cTYQc5MZU5nVpcfvKx9mXRVdvuNJIqbo?=
 =?us-ascii?Q?h5cC1NWPpM9Xl8DnAA6rCHL4No/dzS1VFiT+NFJLGBW97J3lyDDOI6S93QjZ?=
 =?us-ascii?Q?FZwJFvni21bhiUBGYMqvnV/f1QOaSQW37WhTBU21I65SFMi2WAiFe+Vk7QJx?=
 =?us-ascii?Q?n1d2NohkmEJdLatNaXilygNRb1g+fg+51ruZ7dn0MBrEq6STrhi4ZDBA0hiU?=
 =?us-ascii?Q?MylnvXeTZAKeZUFO1cWeKqDP2xw5fihJxIVd4GmCYbE6Hujmz21588K/2v5t?=
 =?us-ascii?Q?O8vedjxHycqqAzCozLAac5hhcCgVy203SZCB77Jqi9t6NknLS/8xMqTGU+HJ?=
 =?us-ascii?Q?kwgQvqcjUvroaHZsBM4GaQkKhF5+LjXuxGxwim7f/PLEW7uUxTqdfhHi2Ed+?=
 =?us-ascii?Q?Rce0rM4767qY8Ot/rrGvqGgBj34aMiXaO9TAGlMzEGpgs0TVnBzPcE6KXWZ8?=
 =?us-ascii?Q?keyRMx6fyxyB//CLtP0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 070ca7f6-6aa1-4344-4ce1-08db1a012d00
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 03:00:55.4872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n0vXbP5xJ3GujId37RLI09R1MgPfUmwKtb6GbiY710yRxiuiMDpW2zcVPDtV5+QeojTdWkRam2LaZBq7laFG+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7527
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH v2 6/7] soc: imx8m: Add MODULE_LICENSE
>=20
> Add MODULE_LICENSE to support building as module.
>=20
> Signed-off-by: Jindong Yue <jindong.yue@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/soc/imx/soc-imx8m.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
> index 32ed9dc88e45..1dcd243df567 100644
> --- a/drivers/soc/imx/soc-imx8m.c
> +++ b/drivers/soc/imx/soc-imx8m.c
> @@ -242,3 +242,4 @@ static int __init imx8_soc_init(void)
>  	return ret;
>  }
>  device_initcall(imx8_soc_init);
> +MODULE_LICENSE("GPL");
> --
> 2.36.0

