Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F016D586E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 08:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbjDDGJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 02:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjDDGI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 02:08:58 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC68D19B2;
        Mon,  3 Apr 2023 23:08:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0sP7HxloeGsXM0W2+BOAdqoDR0XOz29Gdt4vKq7ca6wIdjL/8djt+0qkUFDpJe02/Sz66FGtS4Kza44xPiFWiAZX5vq+CZj6aexugNKAvB6jrUNSh/OQ/uif2SzjoeURKabM2uPYaCTu5JDbTXl7nCBxiWA6NsmEbbDUT7Ajvs0B+qUXKKtip6uNSQKeVl4MK9ToYwPstNgXJom9di3UvdPxdxELoM5QT6/ArgTkiWS91JRX1MHdccWnAC9xT4+7iW1Jwa0agoxvP6KtI5hgz4C+Gp4b8lfyxAyZyIelUHOqnHG/xISevRc1/mFjhoV5YgOXNpaZBwqaFHrt+6iGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzRjV3/JBkMxyvJF/+yiTCgLkPA48VDjeJG4VpKN084=;
 b=ey+YgmwKI3aQRDxA+arqw4jOtQpFcWn8j+qG39ifZBKG3GjghABTgPM/ruYsLl6kj0X1q3hlwL92/mEjS5BISQ2HHkx9uQJCcjF9+U7nIMhPIQAfIlXXsA/SL0ITZ4+Iu9YxvmOdfs9fvFd2Y4SK4AfqDoUVzvKgnk8SVbWwecnl+oPX0HzHoYSHSuIlLQ806JbWUGibtDBzvSIZYBwcYAsppNYlz6qb5vMHZ2qD5s0jvtFjF2j5HyS7SmzcSxLx/8pyQVruzkdqIXb7xnGejOcuNsmG9AIgxmETQUuCXRsjWkmwHxYGKVyO9khFavaqJxdMw7121yaRGfPV3G57vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzRjV3/JBkMxyvJF/+yiTCgLkPA48VDjeJG4VpKN084=;
 b=eO235B1Xy5Ppbb9DK+61MlgIvXpVoHrPVjFQtlyBZ3JzLfId0apVrMwbsnxVzJyijmRH4zxNI2bGMuCakzjZuToxDRvhzsGxMeIA5DNLA63T2Zt2neYGN2hrGx3DZsv1fZAgqasj+EM9NNsVXEST7VekNO8p+a9bkvtl3hfIZiY=
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com (2603:10a6:208:11a::11)
 by VI1PR04MB6910.eurprd04.prod.outlook.com (2603:10a6:803:135::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 06:08:53 +0000
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::8735:c480:4ac7:165c]) by AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::8735:c480:4ac7:165c%6]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 06:08:53 +0000
From:   Gaurav Jain <gaurav.jain@nxp.com>
To:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] crypto: caam - OP-TEE firmware support
Thread-Topic: [PATCH v2 2/2] crypto: caam - OP-TEE firmware support
Thread-Index: AQHZXIYITEAQkV3L7UGfIzKxwz55q68ava0g
Date:   Tue, 4 Apr 2023 06:08:53 +0000
Message-ID: <AM0PR04MB6004907C356A3C844814ACF9E7939@AM0PR04MB6004.eurprd04.prod.outlook.com>
References: <20230302062055.1564514-3-meenakshi.aggarwal@nxp.com>
 <20230322061716.3195841-1-meenakshi.aggarwal@nxp.com>
 <20230322061716.3195841-3-meenakshi.aggarwal@nxp.com>
In-Reply-To: <20230322061716.3195841-3-meenakshi.aggarwal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6004:EE_|VI1PR04MB6910:EE_
x-ms-office365-filtering-correlation-id: f27cf617-adb3-4844-3d35-08db34d31159
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dtJOfkFotQoxjA3gZSYxGKtfYsM2XWoc4xAC2ZyUXQrCQj0AgAvckQnXy9Ub1NS1cZk+Z8Kfgx2KSupdItAqnKPRdggpqtYy04BeiWf7vjQL7ZrtG0S5qazv0s92kdG4khU1HI7OjgRuZADYqS7g7Urkc2QoYoZloUsdV6Ae64rE3nJjdlhLKE6vBbGvCx90gEsnWEosUFkMcPjEWS1ztLCs6cI8lbIb37SWPa/ocmyL2BI3tVS+nQGqpUPOzuVdBqe2NaJghOWT6cxdYzQl7BBVo13ArPYgnACc7cfYNpVpUo2gjVzGt4FZnCcEsADAYNm9Bz6FQ6DeJC5/+94JbbM8YkQeBGOYYGmSG+vOG5Tx/FTDPJ5X3ASbkuckCP2VYUv2edmlq8N98JYIa4IacQg8I7PB2lrEN5i1tEgJOA1uLHsJz7fkfFGt0l4jmrgzptVT3hyyu/9DRBjkW4r7R7Nabc7k1eoz1mdYrTI5RwAF9AXKX5wz/yrlStV9L1/huY/UGRz5/577RaJAzLY+1VjKSD2aRlK97ouNN9scRXnp/dpUj7NSWJbwvgEcVPMKR5QYVwKQuHV/IvS8OO2EF/D+LC1pioLkIRyb1sXSKevFRUsEOcDbC8etQhts4CMY4+P+8iYyviSnlXq/q6fU3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199021)(66946007)(66476007)(66446008)(41300700001)(66556008)(8676002)(76116006)(52536014)(64756008)(316002)(8936002)(5660300002)(55236004)(44832011)(478600001)(9686003)(7696005)(26005)(6506007)(53546011)(186003)(83380400001)(110136005)(33656002)(122000001)(86362001)(38100700002)(2906002)(71200400001)(38070700005)(55016003)(309714004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xcukksKmvwT6kItKD8NNKeDjLBeQsZKaJiLXqsbAuIrs1Azr/6N6cfasoHVM?=
 =?us-ascii?Q?AogPSE6GPhFP+UQSAwG9t6ABHEmS2GOOzCpnr1MNi9gUcIAMSHZ+OfFiwy8W?=
 =?us-ascii?Q?5vGJEyGaoUUBYDUDTruiCRj3jqYMJ0NUT5b/s+bWsmXC4EPVZhxcB1abKIhx?=
 =?us-ascii?Q?53gncslrzoNghhFgj6NUgWVqN916R6aSqYWuaoWV9d/dBeCnXvCwBMtkZmVu?=
 =?us-ascii?Q?fZxXMsZWykIL+YMAA3sf0rmreZV5d1jJIk8LwsT8ulv5uZmlfTLXoNn4iSEK?=
 =?us-ascii?Q?Vfd6KY54hRoC6BVVSXIooIHikithMhnapHtCHBjFQRuALjITUavv4ceS5hyq?=
 =?us-ascii?Q?ZRH/pcON+J5OG1sQ9HPZexfFd1ZIViEaSCfCd/6fACQykei8VXq3kurXTlxU?=
 =?us-ascii?Q?zOkbJZ+W8V3brc3C+Dx2Z2VAwtZttoQlSq28Lgrs1WO+veyt1H+qme1gyfns?=
 =?us-ascii?Q?BMZwTDobmysoRaiiRxw8NTKgiKYiK51SmzIDcfOBEJkxI4I6KynjSuG3o9gB?=
 =?us-ascii?Q?9pn3xgcPu6IAeS9EpugxxyLUPQo5ePUNjlwB0e/MGjZ3iJMW3Zgnwp+Fykv9?=
 =?us-ascii?Q?lAqYU5sG8dksMu77SY8NKSYkwiUOhRyA+XlCueTj5XV0B7dfJxtivOzJwnyP?=
 =?us-ascii?Q?rb8iptSRjcXHaf9pU3rgs4kicw0UOMc7XQFCoid/sdTdN3Or+yNA67nGLYqr?=
 =?us-ascii?Q?Y9m89Ykcw18f15nU5Zb0cM5fT7sEkP7MmSVGAOmBJM7BjCGxUC/BKbDTMvo6?=
 =?us-ascii?Q?CjtgzPAnTcSazEuI35w9NB+iu3Wjrih4BPhuZzoIvPOqpvL78z3sJFU7reLT?=
 =?us-ascii?Q?PB5e4I1Jt1EPezE7Eyev0DgdtWLg4aHGBp3nvg7qtY7zAJqSOCk7u8QUk+NY?=
 =?us-ascii?Q?q82mXiaXOy//Tey/zky3QFrRMb+H5EIh/VDecaxygJMNmc+sLPXISp8FC8Pk?=
 =?us-ascii?Q?94bYYtOelz1WFSXv6GsgJQ5O4rbSpqevF9CEpaWP269iaAABzpVEhi/k6Ahs?=
 =?us-ascii?Q?kPz8XZrvP2rn9HnEj/vV/+QWjM1VUP7KJk1UvInfmM0bjx6LfIiPguJ/YPsE?=
 =?us-ascii?Q?Ey6SLFWaqoFj9G871ekE0By132OyANYxhmsFsEoyOY67MujujAZfAdA18YpU?=
 =?us-ascii?Q?jMdYUxT/1N8vWnr2pR2M5GOvmqb8bsZqkR3jOGw4iNZLaBtoxKKmvHPWU27b?=
 =?us-ascii?Q?KwhteB1Wzo56XN0rd7FHxKXexREBRUSTYrpdoTLgykPxta++nVhRmhY8P6Cz?=
 =?us-ascii?Q?ZWQi5ervImUJNkKJscNiHzhLtS7hB7RQLq5fXzLyg1sCdktdrTyV5rGgrm2s?=
 =?us-ascii?Q?xQ9Uum9cj/g52WXiYkFfNJL7ZmRpEQfPUP+o5s53V9fZrJTYAaAj+D/0jiFc?=
 =?us-ascii?Q?QqE/mRDuBoQYqEZou71/wOs2I9SJ2xC8P9tY5I14ejqY8H1avEgMRruqbPrH?=
 =?us-ascii?Q?m345oTQ3Glw+cqy4q3EMgD8h/hV5HJE9bQMLZhZAvKbzMk8cZEDKOX3AJ1gr?=
 =?us-ascii?Q?JOnPFTNrcX6aJpl9Z2vRG4zuePQ4XubnQdjpFCHGhS+h5YTFrgUfYXVTJwUu?=
 =?us-ascii?Q?OPaZfG2aUBoJ3lIlESgBR2IEZTuZJd8PqfB9KE6V?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f27cf617-adb3-4844-3d35-08db34d31159
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 06:08:53.6700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vl3aCA2w8fdZuANAQ5z2bz/Ap3g+cJ9eLhVvq2Xtkbe0OlIi3SqHsZ7DZixZB+OdQUod/PAh/SCib9w05C6tDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6910
X-Spam-Status: No, score=1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> -----Original Message-----
> From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> Sent: Wednesday, March 22, 2023 11:47 AM
> To: Horia Geanta <horia.geanta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>;
> Pankaj Gupta <pankaj.gupta@nxp.com>; Gaurav Jain <gaurav.jain@nxp.com>;
> herbert@gondor.apana.org.au; davem@davemloft.net; linux-
> crypto@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> Subject: [PATCH v2 2/2] crypto: caam - OP-TEE firmware support
>=20
> From: Horia GeantA <horia.geanta@nxp.com>
>=20
> caam driver needs to be aware of OP-TEE f/w presence, since some things a=
re
> done differently:
>=20
> 1. there is no access to controller's register page (note however that so=
me
> registers are aliased in job rings' register pages)
>=20
> 2 Due to this, MCFGR[PS] cannot be read and driver assumes MCFGR[PS] =3D =
b'0 -
> engine using 32-bit address pointers.
>=20
> This is in sync with the fact that:
> -all i.MX SoCs currently use MCFGR[PS] =3D b'0 -only i.MX OP-TEE use case=
s don't
> allow access to controller register page
>=20
> Signed-off-by: Horia GeantA <horia.geanta@nxp.com>
> Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> ---
>  drivers/crypto/caam/ctrl.c    | 23 ++++++++++++++++++++++-
>  drivers/crypto/caam/debugfs.c |  3 +++
>  drivers/crypto/caam/intern.h  |  1 +
>  3 files changed, 26 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c inde=
x
> ae07c1e5fd38..d96c81540957 100644
> --- a/drivers/crypto/caam/ctrl.c
> +++ b/drivers/crypto/caam/ctrl.c
> @@ -633,6 +633,7 @@ static int caam_probe(struct platform_device *pdev)
>  	int pg_size;
>  	int BLOCK_OFFSET =3D 0;
>  	bool pr_support =3D false;
> +	bool reg_access =3D true;
>=20
>  	ctrlpriv =3D devm_kzalloc(&pdev->dev, sizeof(*ctrlpriv), GFP_KERNEL);
>  	if (!ctrlpriv)
> @@ -646,6 +647,17 @@ static int caam_probe(struct platform_device *pdev)
>  	caam_imx =3D (bool)imx_soc_match;
>=20
>  	if (imx_soc_match) {
> +		/*
> +		 * Until Layerscape and i.MX OP-TEE get in sync,
> +		 * only i.MX OP-TEE use cases disallow access to
> +		 * caam page 0 (controller) registers.
> +		 */
> +		np =3D of_find_compatible_node(NULL, NULL, "linaro,optee-tz");
> +		ctrlpriv->optee_en =3D !!np;
> +		of_node_put(np);
> +
> +		reg_access =3D ctrlpriv->optee_en;
When optee is enabled in imx, we need to skip the operations done by optee.
Update this to reg_access =3D !ctrlpriv->optee_en;

Regards
Gaurav Jain

> +
>  		if (!imx_soc_match->data) {
>  			dev_err(dev, "No clock data provided for i.MX SoC");
>  			return -EINVAL;
> @@ -696,7 +708,8 @@ static int caam_probe(struct platform_device *pdev)
>  	caam_little_end =3D !(bool)(rd_reg32(&perfmon->status) &
>  				  (CSTA_PLEND | CSTA_ALT_PLEND));
>  	comp_params =3D rd_reg32(&perfmon->comp_parms_ms);
> -	if (comp_params & CTPR_MS_PS && rd_reg32(&ctrl->mcr) &
> MCFGR_LONG_PTR)
> +	if (reg_access && comp_params & CTPR_MS_PS &&
> +	    rd_reg32(&ctrl->mcr) & MCFGR_LONG_PTR)
>  		caam_ptr_sz =3D sizeof(u64);
>  	else
>  		caam_ptr_sz =3D sizeof(u32);
> @@ -761,6 +774,9 @@ static int caam_probe(struct platform_device *pdev)
>  	}
>  #endif
>=20
> +	if (!reg_access)
> +		goto set_dma_mask;
> +
>  	/*
>  	 * Enable DECO watchdogs and, if this is a PHYS_ADDR_T_64BIT kernel,
>  	 * long pointers in master configuration register.
> @@ -800,6 +816,7 @@ static int caam_probe(struct platform_device *pdev)
>  			      JRSTART_JR1_START | JRSTART_JR2_START |
>  			      JRSTART_JR3_START);
>=20
> +set_dma_mask:
>  	ret =3D dma_set_mask_and_coherent(dev, caam_get_dma_mask(dev));
>  	if (ret) {
>  		dev_err(dev, "dma_set_mask_and_coherent failed (%d)\n", ret);
> @@ -842,6 +859,9 @@ static int caam_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
>=20
> +	if (!reg_access)
> +		goto report_live;
> +
>  	comp_params =3D rd_reg32(&perfmon->comp_parms_ls);
>  	ctrlpriv->blob_present =3D !!(comp_params & CTPR_LS_BLOB);
>=20
> @@ -943,6 +963,7 @@ static int caam_probe(struct platform_device *pdev)
>  		clrsetbits_32(&ctrl->scfgr, 0, SCFGR_RDBENABLE);
>  	}
>=20
> +report_live:
>  	/* NOTE: RTIC detection ought to go here, around Si time */
>=20
>  	caam_id =3D (u64)rd_reg32(&perfmon->caam_id_ms) << 32 | diff --git
> a/drivers/crypto/caam/debugfs.c b/drivers/crypto/caam/debugfs.c index
> 798ba989a8a0..cec93498836d 100644
> --- a/drivers/crypto/caam/debugfs.c
> +++ b/drivers/crypto/caam/debugfs.c
> @@ -77,6 +77,9 @@ void caam_debugfs_init(struct caam_drv_private *ctrlpri=
v,
>  	debugfs_create_file("fault_status", 0444, ctrlpriv->ctl,
>  			    &perfmon->status, &caam_fops_u32_ro);
>=20
> +	if (ctrlpriv->optee_en)
> +		return;
> +
>  	/* Internal covering keys (useful in non-secure mode only) */
>  	ctrlpriv->ctl_kek_wrap.data =3D (__force void *)&ctrlpriv->ctrl->kek[0]=
;
>  	ctrlpriv->ctl_kek_wrap.size =3D KEK_KEY_SIZE * sizeof(u32); diff --git
> a/drivers/crypto/caam/intern.h b/drivers/crypto/caam/intern.h index
> 572cf66c887a..86ed1b91c22d 100644
> --- a/drivers/crypto/caam/intern.h
> +++ b/drivers/crypto/caam/intern.h
> @@ -94,6 +94,7 @@ struct caam_drv_private {
>  	u8 qi_present;		/* Nonzero if QI present in device */
>  	u8 blob_present;	/* Nonzero if BLOB support present in device */
>  	u8 mc_en;		/* Nonzero if MC f/w is active */
> +	u8 optee_en;		/* Nonzero if OP-TEE f/w is active */
>  	int secvio_irq;		/* Security violation interrupt number */
>  	int virt_en;		/* Virtualization enabled in CAAM */
>  	int era;		/* CAAM Era (internal HW revision) */
> --
> 2.25.1

