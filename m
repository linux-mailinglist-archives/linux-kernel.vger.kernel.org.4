Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38095714256
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 05:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjE2Dfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 23:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2Dfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 23:35:40 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2073.outbound.protection.outlook.com [40.107.7.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A3AAF;
        Sun, 28 May 2023 20:35:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+KfsptqI47xC/j974OA/XgZkgjspGakL6+ohoPbohSWI3rN3l/KNiFx6xlOUFYRpPweGvhTeH/zgBQpEbjwYXCZXt2wvytwzKnZXqfzmrkBjNKNSiIHupR7JcT6BichjAAr3DPKiuhjLoqOjqj9LKiBe4G2hzeuEAm5sL+wsLP52CeoWQWI20T8vooXL+j6EUfLUav1UoBXKdkI2TeHQUJVuA8Ur0crycaMzVbKZcISaFOXyfCGhojeZlOeUYVEjnRxQcCQ8GsYkKT9/ToTZog/PvFKM2cNchpZfW4FZLzwJxVqZkuIrbxX5tIJKTVVGeDLCyT6X7xi/frESA2sSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnBaL8AAbpxVUJNfWSCNHXxk7GQI6vRn45ea3MKqC0o=;
 b=OUYmsoleoSjXuNF0/y6pH16hAqOx4DQGAKmdf1U9Tg8OAOKa37Y2kPCAJszXW2cufyBldPGoLAj0y87veX+rubZ4IuREY/kd0ooIvP/efS7lT5I0U8NddorA/OtCOi4K+vJua5EYuJPKEDkVQCxqllaOFYHef9NymASImL2jmLUbMDBsAPqzUAg+f405FmLz6i+RMvlLy+JcV0a21hcqwtTVytOaq77CfejL52I6XtG46FPZeEK5Nh5OpZ8S+Q1tX+rGZN4tWUdZ9U5KCw2zqJOHxbexe9rwPTUS7YunfG7M8I+QriV+RM5KZmbSb7OVH1wmF+o9NuQ2R4y2CAUf7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnBaL8AAbpxVUJNfWSCNHXxk7GQI6vRn45ea3MKqC0o=;
 b=ECYRQR52ZkSW+blcgNkdtcMm+68yPGRgTR0mUpzY1S7+lMouJKSs1ySY56g/BO8+fpVK201tMrvrIkmywf08MK0mAc98Y8pG+RQqSpSC8T98ZWITenaKpGQEGLnT6UNMZDaO5ABbZnx5FCA8Qt+bCuuOOVzPL981Ys2IFJDYRug=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB9062.eurprd04.prod.outlook.com (2603:10a6:20b:445::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 03:35:36 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%7]) with mapi id 15.20.6433.020; Mon, 29 May 2023
 03:35:36 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Alice Guo <alice.guo@nxp.com>
Subject: RE: [PATCH 0/3] thermal: qoriq_thermal: support TMU 2.1
Thread-Topic: [PATCH 0/3] thermal: qoriq_thermal: support TMU 2.1
Thread-Index: AQHZh9ECJ7zEKm/Mqk2esO8+n6hl6K9wrVVQ
Date:   Mon, 29 May 2023 03:35:36 +0000
Message-ID: <DU0PR04MB9417F2D34656A59A0874CFA4884A9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230516083746.63436-1-peng.fan@oss.nxp.com>
In-Reply-To: <20230516083746.63436-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB9062:EE_
x-ms-office365-filtering-correlation-id: b7cdc5de-7200-4333-a5f4-08db5ff5c3e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Ux+YBFZkLEZMd7HBGzuS9/uzNGjMXr/vE//8GH8eO2+3iRdn0yZ2UmOX7La8eAQGCaJD3RKWLYeIIrKCeQJevzAM5L4+GJjxvvzq9A0BCcMgwej1L9vAMF3JOebcT3pf/DsBoJjMyKcQxQRKF4WIiHZPjN57/yDiFxfeW+/xTIrb9zP6nzeP4Fgfk3Yigbh47SD3TGa3s3T5Cb4T2uWj1w/c443h/0JMmXYpqgy4UhyslVumi0aC2BkqswnXZH2JTLMOFgfZgBKvSvfgVfDKGvyRlX5uA51HemoR/s5RXN4k5dIrzyAPVohi/MEYpUP+FbZ1ZR55pCjzHp9dIay0cOV4UZ3O1Tbnmda+vEfvGN/VBWpx4dIuy6f+1ilnCIbMrpLXc+b5Z18jiJKfvRvKKP7G1BLJrie4PeoTJZiScyzyynNZe1dmGQ8ItB9mPu8yRPPSnuIhgEkBO4UNKgLF0NsD6Yifrb0DvocsIaQaMsX2dE7YuoeaplsuCWKyxUsBK0zWECiCROGPuDCp+luB1Qv3W2E22iB6fcs3liKH/p3xKFSzShhjU65ydvDVT+1MDRRj9M+wvGHk1OfNQlA+YE/Fh37iZymzpc3TqplJni5ExZExBUiWo9ws14jJcn8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199021)(66946007)(7416002)(76116006)(4326008)(64756008)(66556008)(66476007)(66446008)(83380400001)(52536014)(5660300002)(44832011)(86362001)(41300700001)(38100700002)(186003)(8936002)(7696005)(8676002)(2906002)(4744005)(122000001)(55016003)(38070700005)(71200400001)(6506007)(316002)(33656002)(26005)(478600001)(110136005)(54906003)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hCO1UFAubL9BLfW66NsK2Kcubxzl0M+4WRhVG0Wx7w40nbZi2QfmeqnAGwsi?=
 =?us-ascii?Q?1ekXz7/PRtJGtNDMg5W1wquxoxSj0DROP9kCC+mbEea6RfbDsSP8NWJxngSJ?=
 =?us-ascii?Q?YBM5poTeffjywZasv685xuU2b4IQAvFgZzueJe/LAytKyLt2tkhbs9g5BLyc?=
 =?us-ascii?Q?cIOhLwB9eYHpWB14HsBqIgIi76M/K7+ctQcGUg9EPRGuxhbq5ULH+gumHLid?=
 =?us-ascii?Q?wyoV1brW+cCxm+hK29kiZynyDTyJ605REIoO/XCV8t5Tulvnj3pjq+Girtsk?=
 =?us-ascii?Q?n2lO9TPfrClKDySNIUyrcOiXBrw6GCEnZHfdEe5phbzzgZ8ZtuoRFnG4cbSX?=
 =?us-ascii?Q?MLxSajLpzktlYx4iVCti1hdfYqyPEX19bIvUVqjpBmMPZ7RmvfSdY5xLJs9n?=
 =?us-ascii?Q?LpLaeC0+5X6Usku7H3QxkimIsXqRmka87rQjRO5ihBZX7/4h2DRSrfKZJvDt?=
 =?us-ascii?Q?xEE2uH3G1bfDPve+eERdP5V+lA92POiFEP6hdeZUGP0M8QJPGqT0y10vh8pn?=
 =?us-ascii?Q?yENaDTQgP6SLcDuWRcczbBjnSvLnwAzEEI0expynegPy8JjH/00ZzjZbCyIU?=
 =?us-ascii?Q?drCpIbtXNh7ERk3f2PlNBQ/g1SzfaqQKBQY4vysdoHq/UOclmNbpyK+ahCY3?=
 =?us-ascii?Q?f9myUZrJkCqINVvUJyislxqdxuGvKBr5kkPZ9bdmAGzyTjRD6XIfT3/HVSwQ?=
 =?us-ascii?Q?v/dTq/oodZG4iXq18pYUkXRGTjEZWO0E988g6n/OVeua7Ts3XIx4MWj72k8A?=
 =?us-ascii?Q?X5XNKPx/KFVq4NvLhsnmHDKmfWTsmDdWFhh4YDvRcofXq+tGpHL+oakwE+ax?=
 =?us-ascii?Q?+MpAPbDoiPzeBqw1MWx5CAp2IXo30RrSSB4bAy6n15xmUuUhrHIns0+xmxIM?=
 =?us-ascii?Q?XrQvLCzThy65VJjCu8buwqFBNUxGUq+68/7hlMPuTEZUtBdNYVnmF7ID36wU?=
 =?us-ascii?Q?72ZOeug9hpj+OXJK1tC1TqFXZSUCV0/4Ybd8f1agXXXrICJPofE4wx8YwvXg?=
 =?us-ascii?Q?AWL2ViOgQgYURRHJ5l7ooTgQIVjRRjPgE0nMQI86lZmxQI/UhJGFo2imP/S8?=
 =?us-ascii?Q?3uEsB67O3m868sgCPyFGsLfdf37RWE6p7byVYWu6JA6E3xRK5NdYMOnY83Tm?=
 =?us-ascii?Q?QSoUbKoyQ7pmLpn8l+Kj7N//L4os02YdX5PtoBcYRDdlfcMs/cEtvn/oQDXM?=
 =?us-ascii?Q?1ug3nzZxqNDXFCtkkN4IEe7IEjglFXdGQjitpsux6rE691RrJN9aDLm8Bwyq?=
 =?us-ascii?Q?qtYzv/z7ZxUT/H3A2sbPBB7dMEhusI4xHXVyaNrp6BhDdU5kmDlprelPGdLB?=
 =?us-ascii?Q?6nvLLnYjVGxwjVG6nee4sFwGIxfv8zoMT7dmRWtpGqUS2NuAURqTLXqui35l?=
 =?us-ascii?Q?v7oO8NDUWnqpqCbrERQRFBFE6keWUrH3G7knGxeJrQRbvqtvULWLq7nKXQge?=
 =?us-ascii?Q?9ZW6EYnM9VQqMApisFlYKgAtNKK4/Ga65wunqMTGWU6skey1GHd/Fr2NWszl?=
 =?us-ascii?Q?33H29r7aVuaoKz9F2ITIpGUsedVwMUJDEgCZZx5BBhG1UT7/fyA7RK4Bbb8l?=
 =?us-ascii?Q?qm9s1Nsa0xeFTr4MvVE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7cdc5de-7200-4333-a5f4-08db5ff5c3e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2023 03:35:36.0990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pQKZ0/o57Ec/dXAvGFJgG1xsn1BPK/uuIomPXF0hShDMeWInxnkEjPwMhh6we0TJCx59SWg34R1d/HwoL4IRpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9062
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel

> Subject: [PATCH 0/3] thermal: qoriq_thermal: support TMU 2.1

Are you fine with this patchset?

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> i.MX93 use same TMU IP as Qoriq, but with version 2.1, so update the driv=
er
> to support 2.1.
>=20
> This patch also includes a fix for i.MX8MQ
>=20
> Pankit Garg (1):
>   thermal: qoriq_thermal: No need to program site adjustment register
>=20
> Peng Fan (2):
>   thermal: qoriq_thermal: only enable supported sensors
>   thermal: qoriq: support version 2.1
>=20
>  drivers/thermal/qoriq_thermal.c | 48 ++++++++++++++++++++-------------
>  1 file changed, 29 insertions(+), 19 deletions(-)
>=20
> --
> 2.37.1

