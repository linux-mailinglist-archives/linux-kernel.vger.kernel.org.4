Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E547D6A65E7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 03:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjCAC63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 21:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjCAC6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:58:22 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2053.outbound.protection.outlook.com [40.107.104.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D390F1351C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 18:58:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4EbjdY5K5yA5bd4SWRoFa/biFuXrc/j0Hyn0HLgI5FFQM3APDYsi968jtTz8gZ9cMZMeWteL7VFz0dcXHJ3gl/oZs9dLCdpEAByIGwbsudYlgtrqMjlxXDELubiWaNigPNm5/lNPW/p3PL3Ou+/8ctMKRR832SS9zxGLTRHNXsVDC1wF41lzVQctUhU/7M7RvAbA75jm1g1Br77Ed0SpDZSk2YRS2TSzxu1tOpoIg+dz5JIO4B7zmoU9mCzuUEPyYkoqUQPTmIXXZ1Zxhub6fSFPIl9YAB8WklEe31z96bG3fMC3ExNYZpJopwUFf3gorXfE6akjeNkbnSFMTDebw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gl2B6ZmfawBdS26a5lY9ekvSceD7vU0hcprUodhfAS4=;
 b=n2sMrUYJhBQDOz4Dfau5p8DJ5vp3Q5IajeZ6fWmIUzDS5bW1t1mxtjkI8f3Qvb8qvB2r2P4ur4EvtBJHdX/ewQQ28fPMF4Ron/31gA8cdOyb/W90Nne1M3c2cjRNPZcofgTdlDB4IS36gwAy0D+GdAZaD3PeFcGGxPaAFJXjPlsM6KwomiRrPPNdvQj3nmnwaZ4VFmBQqKN79A0lm6K7/5ef0jy6ZHoVwwA5/kbG1aClHDfjHUuQ8ilEJwtoDyRyu1/0+LholcBoRfyEGGPCMZBlnvFC+Uqkq4GjyhTW6omgTVtTRdvXqNVV5zdUbz6UtIM6KfVbayzd0vx/TPLGJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gl2B6ZmfawBdS26a5lY9ekvSceD7vU0hcprUodhfAS4=;
 b=LrDqLLKDmmWIegcq0rTkug3OKCyARNE88lVw4Ck4u9z5X0KOhE4jq92vDiWji4Jv9tRKnuVLkQJPmu+zbDRztedK7ysgSwZkMSdR1AGlvHULP4GiNUL+Zw78jdxN6e3aniH8ZHnb9fd7lUrgwMk9RM6T6OFzq9YVqOcAwvJh6Sc=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7527.eurprd04.prod.outlook.com (2603:10a6:20b:23c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 02:58:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6134.027; Wed, 1 Mar 2023
 02:58:16 +0000
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
Subject: RE: [PATCH v2 1/7] soc: imx: imx8mp-blk-ctrl: Use
 dev_pm_domain_attach_by_name
Thread-Topic: [PATCH v2 1/7] soc: imx: imx8mp-blk-ctrl: Use
 dev_pm_domain_attach_by_name
Thread-Index: AQHZS+katgeX1W+QuUWDAHSlS9/DV67lO2SQ
Date:   Wed, 1 Mar 2023 02:58:16 +0000
Message-ID: <DU0PR04MB9417096218D12B6ACD88BE7988AD9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230301030042.2357706-1-jindong.yue@nxp.com>
 <20230301030042.2357706-2-jindong.yue@nxp.com>
In-Reply-To: <20230301030042.2357706-2-jindong.yue@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB7527:EE_
x-ms-office365-filtering-correlation-id: 1b9b8a9b-eb69-4d6e-3880-08db1a00ce2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d0cEaToHBJKvCSkCmyHxujmDWhAbWN7wkyVHyPqdzLqCDu3jep3+3W9ElwkxA2JV6huHot2iafmbRaEEvesvju0LnPigcNgxpusuwPfxBrvL3ThFH1IaH6QsS6eccb9AsxSVbXqfO+RayVOdF4bPt4rM8whvEdCts44jIvMTdsmJZTz2dO1wCjMeDxZxdopwLOeiHL0PbOMLM0l3TuHEShXQVM/HuNXxwZYpjXMtZN3nLvseRMuiWxhCDNu2vAeQ+TSeRVAAypypPp7INDUYPsrNnCwmOhhn3ENHRpho/J4GF/6Ff3/u73DNDlEIoT/2j7PRhn662UwUfUyAUR5dgr4/1Y41+SZLnqDcTdf1n8pwNXTrwFzY9NTcBFffW0/iY4cCit26XibXgLlZun22iajN92Iw3HeRBeCiDwjqBJ3uAO2iy0c8Zk1wpu6M4GIKgEfjKeJ5H9lI2oQ5RZEx1j03IBH8jX5h+aRAmvXKOX5jHJTyEhvOuW6KlA3ElBeglDvKDh4eLSBSuWeKlpmDxQQamoY3abqw5yjafyBUrrpVIoGy+YPmicUG0yQXzPCb+02VIGBZV9R89vwsG/XGRw27tznH6cq5qHnl6Q6PU21FuN2N8DIQWA/ZvPqihDpNRfpP2dH4FHntn7OfhQ+pC1K4118w8cjZuy1qZQcnHphnhHNVrf/Sgs+kKpT0FPpQHGXOK5KOSMcsrBKi1z0xUfqYDOOMtT0YOX6j4Wyy9H8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199018)(33656002)(83380400001)(110136005)(9686003)(7696005)(41300700001)(26005)(186003)(71200400001)(86362001)(5660300002)(55016003)(66946007)(66446008)(76116006)(4326008)(64756008)(8676002)(2906002)(66556008)(52536014)(44832011)(8936002)(66476007)(38100700002)(38070700005)(122000001)(478600001)(6506007)(316002)(54906003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FglypdYprWlvA46M9/hHQM+a9zrOCKKUTZzTxAJB5CiNBddaBYu618SZOtJV?=
 =?us-ascii?Q?DCmpzohj3A2xSu4DUK7B98t7T9v8MdZ7uPJRcH3tvPFOxWtISHLBoKz6IY0b?=
 =?us-ascii?Q?bOpuWR5jUs4X8wwhMtFAFmC4cD90rljvBL/WQBdxmmcXWFH7SRhmXsrkwHks?=
 =?us-ascii?Q?U7/BsTkyMcfCs88Zoxf7RPPVhf4IOtz7kwGN9wa5/zbatilev52hat6vRkOq?=
 =?us-ascii?Q?ka6hagTMfuNkW2lGP9hRMo1RKPOGF4buBESpdO3dmZayx2wI0AEo5FeODy0v?=
 =?us-ascii?Q?KjmmKmvg9IAq/eCwzlBBmNv7wKxQWeqTfzgK9foP3DbWREKNaSx9Gzo/CAZj?=
 =?us-ascii?Q?EpMVEpP2+LtZ0jhNsfJqk1vt6n3M4pNHNr7NKCQBYVLc/Ez9vhPI4NqxZmEC?=
 =?us-ascii?Q?SvY8W5NTAVlXNkBvPB2qNp5Xbnh4C7PdQQjtElv2+ikUHwb9WZcopwSRS6RO?=
 =?us-ascii?Q?0TmnRrKM02zJzsMafN76Qh7NDeQfZkj5AjMPUcoPrO8XuZctmPG7Sux7epCY?=
 =?us-ascii?Q?k39Ss+A+iD1U3QqyBW83Kx4OBw9EuPIbGrs7EhgNkxWSQQOI6fyOxlKhLW3A?=
 =?us-ascii?Q?MFO978pLCFRScR5f8PicbDAw+mWDKXZFQWzanQV/Wax1ZkdT+BNLp1pPwk00?=
 =?us-ascii?Q?RFREMT2J4phJMQ9qAtqZOznC5ZjGEOcgBy8lRod/8UPes+528QOqKGbkcERn?=
 =?us-ascii?Q?HR8KVEBaLjwQkDqeFOtZkPD5sTkf2K7FzmfgJ8tBbHE7WD7NmJ4h7qTSXnQv?=
 =?us-ascii?Q?CvnhKLdSYE66Rrz9AcpgoNCa6f/MWqr4zOAKK3f9CjN0lniWU0stkU1Ieap6?=
 =?us-ascii?Q?IQZJYQBemtC3rWl+6VCj8DZEbW1wIikYGpight9fjDjp2epTOpSyR7oaDiMG?=
 =?us-ascii?Q?iPUoGekuD4WkyhSyNYQT3ktuHMzLkNn2Q1xheA+1QYzfi9zA9MaQn/xnLgIs?=
 =?us-ascii?Q?XRp6oypjlu2JqNRBfngc0DgWiPtnW5k2y0zsTiFduLKkBw/HjEylPmT8awTS?=
 =?us-ascii?Q?45TzcrnWUJQcvEL/57ejfgNMKV75rpvf6cPBepHsaAPJqUbq+fuo7o0f5duA?=
 =?us-ascii?Q?AgDwPpGF6hYPwvZ4iGEcPrNQfhVtdpv7NdIpV9SwUh0wEV/ds18QMKyeX1jS?=
 =?us-ascii?Q?90uwFELU43UhtnW9d1z1tdB0vYZBmx34iRVvPRHHg+XSI45/QxlsZvcNWa7l?=
 =?us-ascii?Q?AojGsW5/ZyzFn97SBQ8y1rKGOCBsk3+Dxg3vHZ1HqtIZMF/4KER55ApWIK0/?=
 =?us-ascii?Q?4WGxEoZLaL4beEIJj8SHsHiZRSpsuHM9S/dpguhodRdHywmcrzusSMCGOyzt?=
 =?us-ascii?Q?t0szlTxahRvp9ngSdZggHtrwhZ/BSezZJyPkYIPX1UO2QY4FiThmMCdQGhI+?=
 =?us-ascii?Q?+e6RauEN3oa2KauOrLF4Tw/GNb07mQaF9ZwoWgsfn8IlkhV9nOyH+6nRBN8a?=
 =?us-ascii?Q?n62vGMRK4IgDY4d7T3cKn0u7jOU7ABJBxRUkXyiN2uZgS3TTiZGf1wbL7dGb?=
 =?us-ascii?Q?K8/dxTCfwBDX2XnFxxdaceP1+h2+dVp1P4jW2Y9Krk3OElrpCppvGsUmxSX0?=
 =?us-ascii?Q?8dHYFpqmd/J829K3L8E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9b8a9b-eb69-4d6e-3880-08db1a00ce2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 02:58:16.4424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5kiV89JBmUkqPrZCVWUtw0dC0XTgxAM2IosSR6xTfQuOFRu/ziuBmpM4n5VMGQnmhOSB5sEY8KV3KrurIM7yQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7527
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH v2 1/7] soc: imx: imx8mp-blk-ctrl: Use
> dev_pm_domain_attach_by_name
>=20
> The genpd_dev_pm_attach_by_name() is not exported, it should not be
> used by consumer driver.
> Use dev_pm_domain_attach_by_name() instead.
>=20
> Signed-off-by: Jindong Yue <jindong.yue@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/soc/imx/imx8mp-blk-ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/soc/imx/imx8mp-
> blk-ctrl.c
> index a0592db8fa86..1892c2c78831 100644
> --- a/drivers/soc/imx/imx8mp-blk-ctrl.c
> +++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
> @@ -642,7 +642,7 @@ static int imx8mp_blk_ctrl_probe(struct
> platform_device *pdev)
>  	if (!bc->onecell_data.domains)
>  		return -ENOMEM;
>=20
> -	bc->bus_power_dev =3D genpd_dev_pm_attach_by_name(dev, "bus");
> +	bc->bus_power_dev =3D dev_pm_domain_attach_by_name(dev,
> "bus");
>  	if (IS_ERR(bc->bus_power_dev))
>  		return dev_err_probe(dev, PTR_ERR(bc->bus_power_dev),
>  				     "failed to attach bus power domain\n");
> --
> 2.36.0

