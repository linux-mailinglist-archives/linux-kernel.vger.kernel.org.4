Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546126A6615
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 04:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjCADAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 22:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjCADAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 22:00:47 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2067.outbound.protection.outlook.com [40.107.104.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1414E38675
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 19:00:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Og791+zvpBZv//i4iQROAVQjKajLHOtIUfEQxWP2o5503cKIHkiZ4VoE8jkGEfC9/7yKruJAz2EEvGPNNM82dTxc7MZpnnMgEKBOLOuvm1sX42bnqolZKpgIE4wPHhKfZyud2Aaug714KeQDc8T09HPygikOn2h4HlnW4bqRguPErF9MbkEi68yJVRwl1w6E1NXDyXK5qjBEWbSFKVjarAXhV23Mt28Pm23du54i5jqPjE1wJlHdHlWxMOq7CI9EsOqQkMaykvSAt59Y/kHlYUoH0ky6bbWevycainBcqsN0Dd9RPLENiJPZ3HxFlRZnGvu6z2Vahnobx4RtPkKbZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Enu7wotQ5YfL9V40KeLevDWXwERaFQB8AVfif2qU50k=;
 b=JtklW3I9HK0YQy6ItspjrSXrOTc3y0e7v99ggc1C63SGc61wQU30wW3jfmxqSh7X5B3vAhDIqMen/tJBIFWwoyI0XX/QPwk3OedeeUehxBW2VegfwQ1K3CLg8J3SZLRa9l26BWVvcocCXgzPiLzUHg4ejxJz8tOsLTAtY12/FYDZSEywi8d6prpvTWfbsBsuHfjms1gX6cAcXkhY7bz5xNwuTZNwBpZwsOXwn+XDttXutLspadGz7Uzi/Eu/28JHwAX8oe3k1R2GbCG/n9LtQVNlea9t7TnjOAWKwGpEt7LoDmgbV4ijY2O6G5Mb5P4bQNgFrqvz3HygxwhrlTL3Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Enu7wotQ5YfL9V40KeLevDWXwERaFQB8AVfif2qU50k=;
 b=sDMXvqALFyK+ZyN+FmGBx8u2+vmEnHmwKG5zPbGN2Y52nfF92w3/og9tRSS1Xny+rmRiIzPnRCZ3lyfjRYbzsRjbDVRs46cFs3wz3rLqU70gUxiTQ2Ju3xmchT01TJYV7V0Tu8mixYD/yTJvquv0jW00bv/KcJeZd3ojkK/Vv6k=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7527.eurprd04.prod.outlook.com (2603:10a6:20b:23c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 03:00:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6134.027; Wed, 1 Mar 2023
 03:00:30 +0000
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
Subject: RE: [PATCH v2 5/7] soc: imx: imx8m-blk-ctrl: Add MODULE_LICENSE
Thread-Topic: [PATCH v2 5/7] soc: imx: imx8m-blk-ctrl: Add MODULE_LICENSE
Thread-Index: AQHZS+klxYGFc2OGiEie6daNggCCYa7lPBHQ
Date:   Wed, 1 Mar 2023 03:00:29 +0000
Message-ID: <DU0PR04MB9417393B23AB8D906576638488AD9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230301030042.2357706-1-jindong.yue@nxp.com>
 <20230301030042.2357706-6-jindong.yue@nxp.com>
In-Reply-To: <20230301030042.2357706-6-jindong.yue@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB7527:EE_
x-ms-office365-filtering-correlation-id: 766f9f1f-439f-4029-a282-08db1a011dc0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pi5bRFJbhgbLp2vPpIdHNM+MpeB3i57dulu7bNK5xChjSNQuzEuuEIbZPXrPvw12dZExpqEPPlR3eS3eUE7Kc7hPHxkAY7kCOlRP1ixjqlnPPkNuSIqOd4emzJz66lvjYH7B1EtMToVUoxUv5jtXhRZ9oWhYqKbVyOl4DAEKgpc53LUQQbJEd8OEzGwdFljCB8lk6/LAgCnpZ9NTmGMeG66Z3sKt50e1bEvNX0Cf7VViwwHfn1ErPcHkSY/n0YEH/dRu3pnPTKnK+U3wBeEkWYO2yQ2PGxMSuHaB/L7zbO33IYNeAm2tpZdZVWOLcVQnvSDOQny3qkf9JCfuUOR+5vVkB4WrhfbrbYraXvMcO/6jMW83NDM3i/96OgtJaAa4L3Xhq8l3pM0u0HadUC8/XpcSSg31ZOH5wcGhgIqMR0chhn7JdDSQn+h6da5uSkymUjvV5eH9w5cwzOozahdTXY3DGqv4dgECNGi4w+6mGfGyH1k2BVHWt5KoMaHsb5inW4An2dKGPSc+v61yUvd3VBszW1lk7tlz591GUc5u+MlsYV2ZhrWv6GWeu+PmJxGM2Ut+Evjeanf6rml+jwTIKZ8B4q644FoejANiCKgEcB5UdxIr5hed0NBKYyWQeGr7SOv7AKekwijZAnXQ3mQPcOp9qAA3kuEjMgS9HdG0hwFOy90s1TafmzLsUADn+6u9F3BvTreLm1/iKAl4S6090d00bA0rWqb4J9hbQHoTS2U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199018)(33656002)(110136005)(4744005)(9686003)(7696005)(41300700001)(26005)(186003)(71200400001)(86362001)(5660300002)(55016003)(66946007)(66446008)(76116006)(4326008)(64756008)(8676002)(2906002)(66556008)(52536014)(44832011)(8936002)(66476007)(38100700002)(38070700005)(122000001)(478600001)(6506007)(316002)(54906003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vnIjc5CzJhJzRprNZqH5xuAcgBNzy/5YVmn38ywN7iFFI16KaoLa+Q/gG+vb?=
 =?us-ascii?Q?Tx4tQ/jUd8RU69s4/Yp24qdruWvC3Mz9sCKPkkI+hUQaGk18vhnSOLdnk3PB?=
 =?us-ascii?Q?SYQPA+TszibjIiSanXRzuZdjSY8u9qyL1UuvfQ3o/dzzWzIHvE2rjcsZb72h?=
 =?us-ascii?Q?WlMqGzH1sJExudGtMZ2QS7tQR4hsxvmMIJnOAoBDcsL/CoBO1/ifPDV4kKdv?=
 =?us-ascii?Q?tFGdMuqrMO6pO1ZFsEaTkFJpFKK7ETN1Jz+sky/8s6D0sXqB+uTSZbhonX2M?=
 =?us-ascii?Q?JWwcbAi8MJjwlSwKXCRV8mbjOJJgzn24KuyYd/TTnnHNDfQXiVRllVJe+mmI?=
 =?us-ascii?Q?9YUxWNyoI/V7iO2jb2c/2HVyFq4EG6v0f8OEyqCcsROednlBp5oOEybahAB0?=
 =?us-ascii?Q?5Jo8oHnBRj4bPMN8rozOqnWN2do9j7B+qps6o4bP6/UU7go2OL2q9Fv4LT5m?=
 =?us-ascii?Q?pyqglXaL+C5wbdmjweVVWzsnk9a1NxVC4M5oqHojp7/6atAC7b6rmuCJeDGM?=
 =?us-ascii?Q?vth5+POYJbmF3yuMMCYat1EPxpfAHhgXR5LdXmuuQ4HVakV9r0S4kqPhnQ6I?=
 =?us-ascii?Q?fw6dDTu0vgmsarpALJp2il782SWgg5+T7eamkYlbzy0Cm26VCTVzbImBSw10?=
 =?us-ascii?Q?RYfLQcyrlogVuPgSWqAmViko9FC92O/C5Yj7h8veIfrqPxUh2D8hZ/K02siC?=
 =?us-ascii?Q?L8t3AP20YhNEp64Pr9Pv3/5D16Wp3Jitx85PXNYRDNcwoLqGblMt98ttSfQp?=
 =?us-ascii?Q?Yvu5jGhXEF6oOFboU06V1tX9JWH6S8D01QFLkwq73ZKAu3X92NbeeQxj+zdR?=
 =?us-ascii?Q?+AjTsmOfz8XRsPWv9JKsopFbLYIC6OvIsCVS3kXQuiLrhkp+9FsbLfzvUWWR?=
 =?us-ascii?Q?oDTioTZCZW0k91+d70quLBoDAYvYDK/FFt/VLddH14812X7loTSB9RnFH/9u?=
 =?us-ascii?Q?4ZhDDE0Xg3l+YsGFLVFodK6Fw/Ljl66zbFnUMAr4ZWfnk5l+JbXUi4vScgpq?=
 =?us-ascii?Q?QROC9BL6jyCOAbLwRK+KsrlcrPXu7ca0aKuuc5TiK9g/wRfeXa6sF1fLU3ep?=
 =?us-ascii?Q?TYGH8Z0vY4jeR5rPgyhGl5ctPepsAGOhLlXKFdItqY/U0qkKUu4uw+1UTAuh?=
 =?us-ascii?Q?uxWA50ko8+EtiqiFb4NFSbbvsuv4OIPge2liEncCa6aQ49/OxF/aafcpO/1E?=
 =?us-ascii?Q?bZkQwii2NSR+U0DZIs2LSYHmKC/10+4XrGPLQvKKJyFqvMT5cXGs6+9yPSal?=
 =?us-ascii?Q?hjlZcGb+6cFH7AKSoUXwmSamrq3ElosdvJYrIyl4uInYHcg1KWkdgoqYkN9j?=
 =?us-ascii?Q?egXbjEU5zWtUvbQ7dFDgTB5J/gHnCK7h3wn2PgeMVIV9Bsk8L+Qnsp1mcYLy?=
 =?us-ascii?Q?dYfdLTM59K0MzdupCn8iNMS32Ps6vzEb4P9B9oziZU+3aEK7nSdWg/NYHYDQ?=
 =?us-ascii?Q?h9PB4mAWDvlXVCRnZibd+DagF40+uwuJdUH/zO3nB3pPrz/+mpnIg8UtbJsr?=
 =?us-ascii?Q?BCrsvfQFiNOKZlSXOIEMH6d+PLnJtj+Ih3TMUJbLTdcbicnJAblbioRV1LUA?=
 =?us-ascii?Q?OmVOU0vTP+g92Nn6O8Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 766f9f1f-439f-4029-a282-08db1a011dc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 03:00:29.9041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a3AJ4xBKOB2pnfqU5gqq8QiS858klL1eSxaBR7iX+2olbK6vJjZhT5FMM9HyXysYtipY+VQYph3x4RBdjOjcqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7527
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH v2 5/7] soc: imx: imx8m-blk-ctrl: Add MODULE_LICENSE
>=20
> Add MODULE_LICENSE to support building as a module.
>=20
> Signed-off-by: Jindong Yue <jindong.yue@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/soc/imx/imx8m-blk-ctrl.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk=
-
> ctrl.c
> index af67f2c3f7a1..a955513d6d68 100644
> --- a/drivers/soc/imx/imx8m-blk-ctrl.c
> +++ b/drivers/soc/imx/imx8m-blk-ctrl.c
> @@ -891,3 +891,4 @@ static struct platform_driver imx8m_blk_ctrl_driver
> =3D {
>  	},
>  };
>  module_platform_driver(imx8m_blk_ctrl_driver);
> +MODULE_LICENSE("GPL");
> --
> 2.36.0

