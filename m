Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAA26F9047
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 09:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjEFHjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 03:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjEFHjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 03:39:32 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2058.outbound.protection.outlook.com [40.107.249.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED364EE4;
        Sat,  6 May 2023 00:39:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7biZ9dBXlmrbcQAioWeFZcohJl8KZhyy++4gr9gGKGPQ5mT6bhsIi+oW9qw2bBxlTJ2geXcEKN0vSTbuL/wK5Cm3VoE3CyDLGcZNGI2K3+LcAJI2G1whK+ispToEFEuZAKDoQzERQ0MZ4DVkV5+ZFqiN48+54KlzxG1uVs6q0HZ0hkPa8GuUMz6344ElnRjbrjl0J4DTvCXhZ2GIahUNgqEES7m9F5YKselZfeKcIvOPTrAZEiEUuxGbioSX5mGJj1T842m1dsytAnD/Sms2ukVEz4CP5YihHwvG2GdGMeYcsFNtgVQd+YI3MWOS2kmoszoasWwRjtHkudlP673tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdfUe6LHrN027+Ygkp8Qa6mjHexcm6CF8dBbuuSjXsc=;
 b=diHu+BlzqoafeaifE7MM8qXcwFxxFdyGIY3c8LsBY484ALZow2K5vB5VAtpVe3oVaAt7+kfCu3cnHvLW/pnHjDV+thGqsvFCkSXXGxATNgVSrTLJrFMjIhkd9X+eXAhMv0qOjCDFvJxIyIFHI/+W4NczfR0CKTwGe9UD5cgTHxbh/iCjEOPaB9WWMnnxn9DP4Uzph+klffQ47Q1OV61rcMa6ihYK3JfgZJeYE+UW8nDleX7x+Yu9eAAtvCviEvcjkfgVYmPkSLapnBQ15Xp0NRcVna2o80IeJGvH9h8SBKn0KbbWSBYzR6u2sKWXV+OiHLVLWUIBJfcaigkyW5ac0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdfUe6LHrN027+Ygkp8Qa6mjHexcm6CF8dBbuuSjXsc=;
 b=s/vsd6iXSnwqZ6MV3MmVSkgz4etkY5ZR6+VoUlnXpNMr3DL6CJgi8oZ6NnmrcwPOOtNqenI3mg81XuvY5oC981ivWL1uzwtHn0rct7u0jIq7Z2lp4zZLA+71EABNGOgt9eptpL9TW5yrZC6sUZZjZc+1mPcEqMCAeOi5yXYwMec=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB6910.eurprd04.prod.outlook.com (2603:10a6:803:135::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 07:39:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6363.027; Sat, 6 May 2023
 07:39:26 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ARM: dts: imx7ulp: add address/size-cells to OCOTP
Thread-Topic: [PATCH] ARM: dts: imx7ulp: add address/size-cells to OCOTP
Thread-Index: AQHZf+YAvsrqDwU9m0GdkUeGBR64xq9M282g
Date:   Sat, 6 May 2023 07:39:26 +0000
Message-ID: <DU0PR04MB9417F46524ED18058BFF3BB088739@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230506064255.34290-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230506064255.34290-1-krzysztof.kozlowski@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|VI1PR04MB6910:EE_
x-ms-office365-filtering-correlation-id: cefb31a6-5709-47df-76a6-08db4e0504b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ab8tRz382a3iGPcdm5dhk6U6eZxP4S4qlU0u6cHEvCgESlOvGNgzXsJ8zTElGpbnRkJIhijRQzKPUJMztyqiY5+mlqSjYkFqjw4ktNRyuMe8h/6Wvxl1evhZ2/uIVsRTsOZVV1fe09LHNo95x5D/uHmU4Vuw/GAQ3HW8WSNUk7zPeLH4ESzzxtVqOCQ1k9OQFG7l1NYZq3j2fxGMYC+aKx6xqt+Ip7Yr+urviN5SSx/eJtLPeiZ0NOsmWmQfeP6TXmrGFig3/F1IJjTArul7SzQHSAGPxKbbv8q41UOjHqa/kEIfD5SAF+XMXBk0O+QzYgjqQ7eS4MgiLbETuwVgLi3XFP4bLUGc2T3+31nThrr/LgLelfrIz2BYSZ4T4vcwtNjzSO4iEayxw6J6DnvgfIZvGHRz847w/IdkGKYmN94XATcXpXOrmvTuPmgkRYawfdVP2Xy4xK69dW60qYlKtvLloPLD68As2z3/rC43e/vVxA2viPaoBNI89ybJsnwEwartYHFCnaHmVBjXmZc7tOSaeaqPJdUkwbIy+YDyzqg7ZnGZOOgKine75vGt7x/LThjj6k1StBuVl4zRX5OfeTlvEq5uUUunepU49JVimIc9pgl3InFoz/EdyQte5F6cNKyIqTGSCL6mnfffZaGVOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199021)(52536014)(7416002)(86362001)(8676002)(8936002)(55016003)(7696005)(76116006)(66946007)(64756008)(66446008)(66476007)(66556008)(38070700005)(921005)(5660300002)(71200400001)(38100700002)(122000001)(478600001)(41300700001)(2906002)(4744005)(110136005)(9686003)(26005)(33656002)(6506007)(316002)(44832011)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1/z3OM83RAK5JsIBEw+7aujtZ2jHyOEOwZ29iBQgEQWgZpyEflmgIc9eo2KU?=
 =?us-ascii?Q?2pmd5mnHWgvi3xsgZAOswCvmoClf/VoHmSpPE8KRdXBNuAihe2GPWfeOxHne?=
 =?us-ascii?Q?PCgyrt4xNnNZsBAMRIIIH8Ma6b4sxkssMpXC/pC8+rA2H9RJqKHjSo1C21To?=
 =?us-ascii?Q?JL8z1Q9npO5kJ2RqW1s4NEBgh93c0Slq6rcNtEdYCv5a+KYShHPQNS4R1Wz8?=
 =?us-ascii?Q?bfd05l2AEZUL9xV3USAjdIctXRCtaUybJ+aHdxGfBEyC0oiZjD+A9s9YFSXD?=
 =?us-ascii?Q?0ddcLLqwxPdqdqBLLjO3WJPLdVGcclOXUcT8gBTpMsXO3J+eswQxdQ1aicl3?=
 =?us-ascii?Q?yzxnczMJGBgSGa6R96APCTcVLZqJerlykGhrP8f1dZou+ZSKjTZJ0n903F01?=
 =?us-ascii?Q?i9Z3Zg2do2voa+zvct7SUEdaCdmRxt0Tt5GpYLhUAX8UhP9KDz5pD5XkZuq0?=
 =?us-ascii?Q?mH0klNm9h5kWxKi1nl6t9eWlAnZNEkdyFyLkHe62jTPv9G9+3qClQV4y8SsT?=
 =?us-ascii?Q?DsrM6WNBlZPA2dEvS1GIBqWAaddUHK2Xi3ZXZlXrQe7w0ud0iblsj8tHz0BK?=
 =?us-ascii?Q?wO+etomPpooWZSggvSyCxsHrQDjHRROEKaM+hh9lcGtS9xbtPYIz6CrL582r?=
 =?us-ascii?Q?2OWtjUjiVCVV2YTr3MdGh+fkcmqL8f7Wy4kmnH5AoLmo0v0jMylHg/6EpLoF?=
 =?us-ascii?Q?Ue8wNYO3HCkV63e4HDtljS3kRMVkdGuprqJPHdD3qBgcu3tno2FFsjzf0yNk?=
 =?us-ascii?Q?B/FCezDPsPQHzq1gXneiP7NCT89fkCv4LJOSl0gzZM+zRYQQ3cHWo5Xe3wop?=
 =?us-ascii?Q?UNeW7OOfjQtnmncPW2Bk1NZ+np//hqHvjZdoXaA7QJvJsX+l0z+MY2g2CpXV?=
 =?us-ascii?Q?KUQ9uDg8bJT9Uu6b2uNRpvyWKql3ylY/m8j8H4No9PqNLWSYiLTbUodosHMB?=
 =?us-ascii?Q?n7uww57nHV55gy+FsXOeURuEheOfQOkV2anJjJ90hCosxXEDPx2VYyHq5oy+?=
 =?us-ascii?Q?xzL0bT3yT3fhwD5kCWcH1m4v+wUTDfkzjl7orkZQB9EjSW2iMCCvFUlGYxAa?=
 =?us-ascii?Q?o8FHw261Pax7qPgbgxXPosFAcYJyM7lcdtUN2HRBhHwGqCCYWfslHckZpjtB?=
 =?us-ascii?Q?Lsau/PFsSXuC65HCKMMN4ZTmY5xpbrjgMeX0rbuB1AqloAGI0Y07ihAP/fmi?=
 =?us-ascii?Q?l3j6GEdm2+0FaKAO2s9xwg4FCUx4v4bfiiUPVGcVzAQsA6EGs1uTJDh/Jtiq?=
 =?us-ascii?Q?lnD3wirtlADggL8VVDzWFGceSdOTBnm9x/H+/4Lqtw2qOdVcFJ+7Rr0CKTXv?=
 =?us-ascii?Q?03DnX9GJ/ZfAoSuwhZv2Y23c7etfT55NctQ9mU58tFACpjzHZz8SA6CXLJgp?=
 =?us-ascii?Q?632Jt8YyQ/ANda5Iz8MP/9Zu2gpTUGOV8X8OGbX2Zp7BFuUTbMnhc4b8nRfZ?=
 =?us-ascii?Q?ZM4xGsbfkFBvEZCt5T37q5vd960JYPtXikYAFu7o47oJ+5ohgCXxd0HqdEUR?=
 =?us-ascii?Q?9CI/y+6bIJf2YxzfKe7Hp0Cl2dvm43lWSge+xxxfkuw9e6A3JY/wN/xAjX9S?=
 =?us-ascii?Q?9zJlmnihykHi/1Tqzgo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cefb31a6-5709-47df-76a6-08db4e0504b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2023 07:39:26.3169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jA7l5D006z+ccgnotGE31cfS8U0GsSnMICZ+9U1Q+BfvZmgDD+7Rq8qUzn5++daJ9z0Rm7BYK23nzhf12mE0aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6910
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] ARM: dts: imx7ulp: add address/size-cells to OCOTP
>=20
> The OCOTP node should have address/size-cells so the cells can have unit
> address:
>=20
>   imx7ulp-evk.dtb: efuse@410a6000: '#address-cells' is a required propert=
y
>   imx7ulp-evk.dtb: efuse@410a6000: '#size-cells' is a required property
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
