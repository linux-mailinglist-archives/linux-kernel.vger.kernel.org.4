Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C856A660B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 03:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjCAC7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 21:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjCAC7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:59:51 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2082.outbound.protection.outlook.com [40.107.104.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FF25BA8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 18:59:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcVd0dOFoSJ9WCburjhNm0Cg3l21/eZxZtAHme6LzyIsjueoE6Pd59VaV6F4XZu9Q4WiWT1Nq5SlJdAu+JvP9TYnzBR/d7LcqIMMpXR0awPY/fu9SHCL/CEibvWULhGY7d+YzNsokhDwksYmZiPL5lXtRYudVJl95JT8JEi8psHCWpjlNP9ta3itumVlI2L56I3706nZhtEO6+usMNTVn76i3xKJeH9Z5Yrwf9aIQw7qMCQRArERPjmX7ZFE8EJLk6vnvhIjwz9vEQb2d+p2zmIUX0i+Zw8G/KCXGurS2u2FXQss3eCfGYawig3KwXM4xe8bOVZaIIn8LDHG8uOE8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBV4AZmzekZD5M75vUVJ2wgHcg5G3cNctZ67bOK2sdc=;
 b=oZwsEUCX/Ut3rptZRa/PvqSHuzEZlC0Mn0m8k4RJg+XlJaJ3QAxcTwqvbvKvnocfoLeTZYLTNkfmke+P2hZZInCdJ5HztgbbbsE2xRmkL+qVQpZ59rugD1IfAc+tIqQ32Yr/MQG/4BmjGPsyCkyecCvrXaZMeiUMZXgooElWE5MI7o0yIxpnATM10LEI++M8lTPNssXfMqb8AY1j3ImTiaJnviFSCRR0Z6cNSPA0efYwjs3bOLfOnjUqmB/iFBKlql2hj1l4q0Jgu2HfB4FkJY99F+/L3Y9HrIS9yzGfwuqlY1aEA/aAry63JHbMOQZuCuIP/B6b+XztG/wJ776lIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBV4AZmzekZD5M75vUVJ2wgHcg5G3cNctZ67bOK2sdc=;
 b=hnwMZwMzi5QzzQ3+rArrBSPEvrWCDmbrSk8eLzoi4czivSoD/+XBa7wHgzUl65seDNq7u27lZEPm92mQ+gRaBtiEV9GXFEYE/+o9FckfhJBHXToPleausE5Vg/5cPwqRBSOEwkBQ5LukhPu73lgzdDFSnWAvx97a4jhMqlSA4R4=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7527.eurprd04.prod.outlook.com (2603:10a6:20b:23c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 02:59:48 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6134.027; Wed, 1 Mar 2023
 02:59:48 +0000
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
Subject: RE: [PATCH v2 3/7] soc: imx: imx8mp-blk-ctrl: Add MODULE_LICENSE
Thread-Topic: [PATCH v2 3/7] soc: imx: imx8mp-blk-ctrl: Add MODULE_LICENSE
Thread-Index: AQHZS+kgzjckCkqBw0C4fpUzQStMBa7lO9RA
Date:   Wed, 1 Mar 2023 02:59:48 +0000
Message-ID: <DU0PR04MB9417DC8513D70BE7EDC92EE488AD9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230301030042.2357706-1-jindong.yue@nxp.com>
 <20230301030042.2357706-4-jindong.yue@nxp.com>
In-Reply-To: <20230301030042.2357706-4-jindong.yue@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB7527:EE_
x-ms-office365-filtering-correlation-id: ba616dd4-406d-469b-8f97-08db1a0104de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tymD954jy7PQmPeuVZIX0v8sClg4qnrs4e7OgxgOPPonxS3GXQdGJVCv/pkC2gaMMTFPJl+n4tyYUudEacjvEMs2qUb8TzNSuLgf7gmq4t+S+GgA2ytkTr9R1Vyj86JSU7c4npKQWCMeZSAUvedoo/35b2nG7gbWznCDFk5/oVbA0f8BSnnqMP3esjHCPC2HOijit2jN0l90O2t5HE9+YTDCgU64yvDmKyqttpRabtsY39PKrJstysf/7Hb0L4zxvUncr6rYRpPOLwrbV9GguSV1ViWIkFmzPfK9ypdJO+9q7t5dOnNBfgjWNZ5yFo9OxzIdurN7pO7Lyza+Z3FyChXUeK36kmIG0tPl437ROh3DMm5RlpWZELeXCOlTTgp1nk3biGzCcet6T/0bI5xW8omdk/gin62cydxpujl4JFRTi0DjRhb2j6jlnAfLJqTy4NKDVcQCy9espXyLX3mudWPFCXAZO5WGOozhgT+ssd/kEYxbhn1HV3V32G1Z0QIWbC8A9Azx4PXfUR7r8sjdgkZnfqETHsp168pzf+uBKpcfNy3beK12xaDRNOVHt1Tv6ynM49T/4B3Zx3oJmvUrnr3SQCm4wioJ/okOXQRIZcCglYTvCes/80Ig0WP88/ZB1OX0DX4P5hjZyGwuofdauhzz09XrrvPCzImNtWlZBP967FK3rhwLvoSBc87wx0OEeN/XTkh5uNZCCMBcfUR0yGlw2PFSGft5cVcsPg1AhqU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199018)(33656002)(110136005)(4744005)(9686003)(7696005)(41300700001)(26005)(186003)(71200400001)(86362001)(5660300002)(55016003)(66946007)(66446008)(76116006)(4326008)(64756008)(8676002)(2906002)(66556008)(52536014)(44832011)(8936002)(66476007)(38100700002)(38070700005)(122000001)(478600001)(6506007)(316002)(54906003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vfOJUW6OTnqOTuriRKrfXadGBahKuf/dy8vbGwcrqmBe5kS1CHoWZ2X6p9nD?=
 =?us-ascii?Q?QvcgGD5vU+j+LB5QZ7+EUB+OrEiXCFL0ABWfYN8r1bLTJKEIAwZS6mysRkQ4?=
 =?us-ascii?Q?sjO377JjpS+1uEZ83LDl032nb6I1f2HtYvRDuPE4gzoHBsgR6eluzsz/U+Hn?=
 =?us-ascii?Q?e51VqQGFatgO+7V6B/1jT746c5q5vthUO8FmMe0UFD0L0RJbToJZFkaMwG0J?=
 =?us-ascii?Q?Ox6JqYKECTRWzNbGDHm9uZxfXQotaxk/jYMxAaYg2sYEp9ZmTKEnbk9X8jFR?=
 =?us-ascii?Q?EC3YUdbL/8sGCW85WOTWUT0+n8urbMX8bu9PHFB77sgVNj+Od0RCeUnNLXoY?=
 =?us-ascii?Q?DJM6s/Rm1NLBOc9zWJbpcHKcrikplTDQc9Yem2rTZ3zOzytCVWclbAvA7yw7?=
 =?us-ascii?Q?Zy8yqtKonX3NoShZoi3KZEgt03R0MOQU8eP2bdty1wrfDgx3IVCB53aKOTTC?=
 =?us-ascii?Q?nEeZtvsLxyhDW/pys+lpDQd7W1d4UN2WEAg40i8Px+WK6HUdMw9lL7WTOMNr?=
 =?us-ascii?Q?8cCLO2vvmFJ4YtRyYOFr3xLAhck9m3wPMe+ffRVP9LZLI6FgHA7+S0FYJabK?=
 =?us-ascii?Q?9oRDo75rv9+k5Rh50hke9PJfV6P+fya/AH1pw2TlFncCus4d2kL7Q74DQ8Sk?=
 =?us-ascii?Q?znAXQRe8GIeQ46UCSK/6OgSfW3zb5K4Xb79ItOdIOvPGTXok6W8yyl6yw4Xk?=
 =?us-ascii?Q?1Qa+RjU8cjMpfR5ZJUabXFC9vAf0VhFwmrBeBdXv6fAnojemfjTzAvW9TNwR?=
 =?us-ascii?Q?5/nZs/Oyy+lwmVNc4Sw5EL550n/+Vt7t3M2DGtgHPa+RQnvShMzZfKOhWQzi?=
 =?us-ascii?Q?LMVqhW6g9QfhBHxFBaK5uvas7lHrPwFznSZ8ea8Qh7QO3CzRjN3heEw4rFhV?=
 =?us-ascii?Q?96QuYzVeQ18DCAC80zB3tLBs5gVUjISQqMILTu9C8BdmztbDMwEGoQquyken?=
 =?us-ascii?Q?2F793Xgg16d/hxlTb+6CVlqDjlTV7aRT7uJo6a3ytYr58aFRelrGQW/AwRdt?=
 =?us-ascii?Q?+jYtu9/gzXcpeb7mUApcK2/r6d2tBjEL2S3VCbPqgoHXfFl1hekX/l0A/ICz?=
 =?us-ascii?Q?W/zEorpJLmW/VpxkzZEaIKwPlSYEnM1T+LT22ektzTGkF8iMJIfsifdnbfY6?=
 =?us-ascii?Q?bnwxZHmi/XZNQbYbmw3YfovhQq7cf3w+YXqftSGal3+4+ApewfrnMPz8xn/O?=
 =?us-ascii?Q?pOIUMkn6iKpzv81CNDI6VXykFjQzHlA5ko2qadkeHAV8KeLqZDuwvJGmm+sO?=
 =?us-ascii?Q?RTALUtC0pWrJogxwoLnw832+qmyKhvv6S3MfVdulZNxxT9H8ATA/PF4Ks92U?=
 =?us-ascii?Q?cSoa1g7CbmODL0psQO0ydvzqoIGsm7n1o5OcAML3Og0uoe4KXVAyaARQho4C?=
 =?us-ascii?Q?qWBE5a8WFcHDQm6LJcWWXyCRuCJ7uT8Hbvu7UfVrCx7um9xpvZ3GY6OUoQCT?=
 =?us-ascii?Q?apvQxk7TgQxhfl0HF03UbdzYc0OBPrDIP6/xAFm0uh7exlFTyzMd1sR0RDfP?=
 =?us-ascii?Q?fcDeOrFBmLy/5UPJuaELVascxsAfIcGG5XLxDFWqhXf9baGC8yJlG4XjcABK?=
 =?us-ascii?Q?ZSSvDmm3PFTthP6Qoic=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba616dd4-406d-469b-8f97-08db1a0104de
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 02:59:48.1415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GQvzzPYwoaksNrFBLyybG5NC23iGFjbHBREX04xDd0UmIgQ3dvEOi10qUtugNSpadjSWfxJAgefWnecA3Ulz0w==
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

> Subject: [PATCH v2 3/7] soc: imx: imx8mp-blk-ctrl: Add MODULE_LICENSE
>=20
> Add MODULE_LICENSE to support building as a module.
>=20
> Signed-off-by: Jindong Yue <jindong.yue@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/soc/imx/imx8mp-blk-ctrl.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/soc/imx/imx8mp-
> blk-ctrl.c
> index f109c7bd6658..870aecc0202a 100644
> --- a/drivers/soc/imx/imx8mp-blk-ctrl.c
> +++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
> @@ -864,3 +864,4 @@ static struct platform_driver imx8mp_blk_ctrl_driver
> =3D {
>  	},
>  };
>  module_platform_driver(imx8mp_blk_ctrl_driver);
> +MODULE_LICENSE("GPL");
> --
> 2.36.0

