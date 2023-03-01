Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFDC6A661A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 04:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjCADBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 22:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjCADBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 22:01:38 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2047.outbound.protection.outlook.com [40.107.7.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6300D38B61
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 19:01:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRztWgqUixM2QdAAWj79xgNlh+d2YibXm8YOOVAAEUEDQO8oE4HvUnuVJDWhBDMQ0daaU9oUhtKkIE53VrHluI0oysdepHQ/XjZ8uyQdKfEDlYPKLQ11OsZwb8sWVfhQf4yJG8FG7Hmfl7IaI6T0W4FX/y/BWmeX46by7E6+Qm5wFj9BG7WUGNazBw2Fb6jpCNc/MC3yI2B/q3GMVWmgSSNqA4Q/Rvx1W92ojltCJM1h8WO1dvkRaWWac9MlTVFfvIlmxb06mXKCVKslU+prsdnTHUCkHv5OZBmPjRVsyr73xg1tyPzXVZWPp+m+cqMTFb+l/kPsmHyLyc2iaRA8Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnCwpmxIueqhTHkBlMQAwUusHXSnyn8bMUMX9DOX7Ys=;
 b=g4g6QijoHPwp4/J3Ra4qwmWrp4xViTunZK8hU9/sLenJ85VX/b1E5qr9luXYM/V3Hi+0WOamyvTE28KBF4FdZRDr8ndf7Rkiaj/8uVRHbZVwUF35PjFlmEZkR3bwYF6xyEv243P9x6DrjoXcMh/fJkD1zuI3ZoimIlqs6uUpE5aJZSWaF9ICiU29Dpi8cLfAv0ctAg9rUhjL4JGfdYWtpL0c9z6DZfe2xE6n08Vi3z1ahOvS2h/fURpU8Z38KHKACOMGx6Tex6LyErFx25n6RlPgSAKVvOJbVksQnUo3Z9PVynWcz16oLRPFg+s/9eAN/jxljtTggIcm2ngaZf8Jog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnCwpmxIueqhTHkBlMQAwUusHXSnyn8bMUMX9DOX7Ys=;
 b=Y2XQhnGHBmmsRqbAH3/0ww0uypUeJRPB2uCbbnV0CKWIr9KiuJI9Yn7ovgzNT6/LEK3900dolGOauKi0nwQE+HpqgX5rz3lHNw6vSkQeo66n1CxaybCsS+hjp6N1CygrUildAb1rO7GlVU6v3q67yIcQx8hsSi3JXtdRklaevKA=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7527.eurprd04.prod.outlook.com (2603:10a6:20b:23c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 03:01:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6134.027; Wed, 1 Mar 2023
 03:01:13 +0000
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
Subject: RE: [PATCH v2 7/7] soc: imx8m: Support building imx8m soc driver as
 module
Thread-Topic: [PATCH v2 7/7] soc: imx8m: Support building imx8m soc driver as
 module
Thread-Index: AQHZS+kpBYx8GdhEc0y5DtUMQSKGc67lPETw
Date:   Wed, 1 Mar 2023 03:01:13 +0000
Message-ID: <DU0PR04MB941741D66FD6C5008A54D9C788AD9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230301030042.2357706-1-jindong.yue@nxp.com>
 <20230301030042.2357706-8-jindong.yue@nxp.com>
In-Reply-To: <20230301030042.2357706-8-jindong.yue@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB7527:EE_
x-ms-office365-filtering-correlation-id: 795e589e-695a-425f-9ccb-08db1a0137f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tcApL36Kp3O574AsvbE/nPB8WMq7Md5+/SQulzGABurnY/Xg0aqhtAp/pr6aq6gpvLyBW9hH7qL4RNDizT1qBmzAXhvcQl3TKRclyvkjsnwRVMt0MyZDNuHw0yTTs/lWUjWDhaSUinHBvfTRbuytOH02uXayhlslspvbxVIJTtaRvqXNealHeRFvYPTvRn42pNzwweO3Ke5DGHtt7UrQ6/Q+cl4fO3ZLpD6vlb2/BCO5+wzPY0KVaAhBuFsDPg+lFr+1RgluVdnGkA10tMRHwAl7d/W3e1M5gdYXOZToQ9uQTO76dXFR2Ca/u66V6pb7GKGZOhtIUkjNB8CiYPYsZTISzFUf9WrpOM5ePJT4OCb/NPJvZycsKEDSBIQixmLM5bdPOBCDfWi7F1RqTCSe9jzaTTFxXCRdZswVKVSdnJwvcmyCbhnzalE59l5RwW8NV3OPm6OXl0m+96UKkrqUr5qK0wivo1i75RZRjEFDHiQoPDg2ACgt0gp6YqZLUJBY26Lr6D/WYPcF9UikpQcrf0Mb5/9gw3MvFtO5otLxt2tOrJ+atqvbJ/e+yht761Lmb3rMqVgcBtdp1K5nN9meFP3ZMwT4J1ZGMVD1HMGuJ9HyUELXZNGVpNxF4KmdWLDrgnE7pM/KCv7Xrsge/1l4bORhHzfbwFmCktyDPlSVi0p9w+hwQfASL5jxWJxnk76YEJfsHadrCT8kNrmoLguYcJvNv1yDKWs2RwwIvc1UIwo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199018)(33656002)(83380400001)(110136005)(4744005)(9686003)(7696005)(41300700001)(26005)(186003)(71200400001)(86362001)(5660300002)(55016003)(66946007)(66446008)(76116006)(4326008)(64756008)(8676002)(2906002)(66556008)(52536014)(44832011)(8936002)(66476007)(38100700002)(38070700005)(122000001)(478600001)(6506007)(316002)(54906003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RM/nSD2ZhLkWbovNlpUNrljopWez6xBSvYt0xomf30eb/C5WXFFqBOnlg9r5?=
 =?us-ascii?Q?msVvHuqU+BdO9utKdlT4YSeuByHHo2eR9vbAsIGVlf8PHYuLDv9kn3e5h60E?=
 =?us-ascii?Q?bzMSoX0YPMCUt69Toi9mJFQas5x7aRFRkoTgOcdzY7BXQC8aXaCoyCuNzc4o?=
 =?us-ascii?Q?VDj924hoCNKmpTGwDw1bfvu1vF6d6FAD3lFZZlo+5LdiBrvdFY2AMy6hWPdq?=
 =?us-ascii?Q?rz9ffZdOkgh5JIopiwr/LJc2KK/nKwPlLbzLqMVbtdtzRQlcfsBqTFzaPHuO?=
 =?us-ascii?Q?OAhXF3/J1azw0WSfZHFXTVO/5l+YBB6dxgff/CyC45y5ZJuFpdHBGR5uquXW?=
 =?us-ascii?Q?X36tv1Ydd/2HFezYwh4qOdFvB8TAU5pczrY5nxz235pm/nR46x5qIz6gkeI4?=
 =?us-ascii?Q?ifuleOiY0Our4OKhWxn31J89EbOFU/46Q2J5hLvunFgUMvCzhlzxZGaHTaA2?=
 =?us-ascii?Q?4c8oVuPhMaiWF0yLn8xPuWGXPhurzTONviptmLAsdQ0ULffVB7ehOXVNTis/?=
 =?us-ascii?Q?LxkyuajCQkPeBtZe205WVKMugjlOVtMjRsGdCifv8RXmCjpYuzNf+P/ezKwR?=
 =?us-ascii?Q?HyR4t5OK20G/DdpZPfv1OqHewiq3/3ANMVDvQ4ofmg7T4+NeDQPlFKDgchjl?=
 =?us-ascii?Q?UrDH6fI/Hj3ksBfPTxmPw7BDdHhDvhhXhSmXkaKZLYdPnuLRkE5HvrXSP9jp?=
 =?us-ascii?Q?rBp79w4Y580Zy7KrL5qe0wNmWX1gcM1Wb+un4rPfuz6QmAWs1NPxPRz9BpGI?=
 =?us-ascii?Q?0bzom8Rk+AlAp5aHtBrYCtAH5LdeqydSe39bacadF8OmA9h9/xM5OYgYUBqV?=
 =?us-ascii?Q?ze5xMHD5UEOS7fiG2WsxdKRyFBCS3NP0zx6HjZ/ggxmjboRxXkbTrHQmKkAG?=
 =?us-ascii?Q?UDTi+mNeiVMv2bUhI1/pJbyqFWH8X17K1boHE0kD2KZuyZhywMqMxT3haevb?=
 =?us-ascii?Q?uLKvsztrMuBHQY9PnOPBJBpVEMXFaic9t01y2JdnBzTr4ZAcCYK8TLXPRrOv?=
 =?us-ascii?Q?/p7q7hGfABcrL0520WQ9hEFuIl8B+C3UurObX0i9lEwl4rCASKlhAmfGpR84?=
 =?us-ascii?Q?3gDINB4Y3hXsdYD3jJDuRMkSJAwOfLmBZQwbmqg6ngoPIu/I16t8QbqZxQVD?=
 =?us-ascii?Q?1kaUAACRgSPEN7cpJY7j9xoyrj8uwV+Nk+tkZ28fl4kAuOysI2e41IWl8JJL?=
 =?us-ascii?Q?v2J9VdkwBHYpzxaIPivaMEFHCZC3LY1Pu2lQ5LF4u4uSd1JHcqSMP8ONOJx/?=
 =?us-ascii?Q?PGoJ019pWTpjOEtCbMRwkADAE8XAtx9fe4y67LI5ZlADJ7dCbJ6hgdROAk9v?=
 =?us-ascii?Q?D4b1+oJdveHq14F3SNJtsjNMqscMCJ7fS255xEnGEt4yfGRS5Wi5gH6s3G6V?=
 =?us-ascii?Q?te9WMtZKeuXHGrNnLwLMR3CXcPkKCiXvBZxj59NgZ8ZPcMpQpi35UWSRncx/?=
 =?us-ascii?Q?ceR1Hc4/lr0KCKJA8hXycppwTCjEns+DKn58YzE+R+IICbBo9AqEDDiaDy0S?=
 =?us-ascii?Q?vNCN9BVOKZmo7BLfBLsjczyQ2NdbgDPOQ736nHQh7l733DapzttIaZehAv8m?=
 =?us-ascii?Q?VzjUtkS/YGNM7bZBuIg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 795e589e-695a-425f-9ccb-08db1a0137f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 03:01:13.8368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RHi1ZPNBH4DeQMp+METhgKSkp+L41sByka+XiFPwxmW2YJbfnn/kEB6HNXaPTu8y2cb1kjqmbNr0eeLp2R6GhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7527
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH v2 7/7] soc: imx8m: Support building imx8m soc driver as
> module
>=20
> Make the imx8m soc driver as tristate so that it can be built as loadable
> module, module names are:
> soc-imx8m.ko, imx8m-blk-ctrl.ko and imx8mp-blk-ctrl.ko
>=20
> Signed-off-by: Jindong Yue <jindong.yue@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/soc/imx/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig index
> a8742fc58f01..76a4593baf0a 100644
> --- a/drivers/soc/imx/Kconfig
> +++ b/drivers/soc/imx/Kconfig
> @@ -10,7 +10,7 @@ config IMX_GPCV2_PM_DOMAINS
>  	default y if SOC_IMX7D
>=20
>  config SOC_IMX8M
> -	bool "i.MX8M SoC family support"
> +	tristate "i.MX8M SoC family support"
>  	depends on ARCH_MXC || COMPILE_TEST
>  	default ARCH_MXC && ARM64
>  	select SOC_BUS
> --
> 2.36.0

