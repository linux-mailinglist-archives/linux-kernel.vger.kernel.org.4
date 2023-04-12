Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6686DF0A2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 11:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjDLJkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 05:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjDLJkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:40:11 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2068.outbound.protection.outlook.com [40.107.249.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BBEAD;
        Wed, 12 Apr 2023 02:40:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goAwUSkPEPmRQfifLslBC/QaE657CgBGlsClOJclEwzQF5RGFkGdIYkiQLBM7N+sqaI8/gY5UxHBYXWNyUW0eNKOF9bDKqpHolvJmspu8K+TroH1qsSINQ95PNSYduJJLLp3zY+iZkuqWwTbks44vzcev6kbf7HxpaLGQfbPJs+y2SezazYXITjTeT7OhjcVlQqQiSTSF8yeDmfI2yn4XGZipqQXs6/p5IyADz1qR2V6gfLgMJlXPQotQsYS6mme6v2GsMq+ujf7uTwbVdxZKvysk6LkswivMEgkFrLTq7qErGRalq2o4W/VCA8muT+gMv2aNf7XLGe/3j8ZXIi1/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TaPsGMeT0M4EFr9O9N4aNMtsxgKZG38GKBBUXnYvlk=;
 b=aFfVjYrP0yt8GfZE/idczBke1H+f0toupHP4sTFqI0gVHzP55KDhkqnk6IzoRmLN/h6tweoqY76EuqNNLAIuKpJWFzgz3T47CR7u9qFhOLWNWIBvG8Vp16SX6SaWxCbUPCSyYv2XRwNVVKja9rU2y9UvUpo1E5J1wc90C3hAVL3XSOW8xfaSoTX7cJ+9GiYu0h6N43aUUbT3xHrgRoaU/D4Pt5GC5qR3DVkt+a2BXZ5Ne4uXeOzf0kRipY/Yc2+CPuyW+I2spBWBtVs3WMTaaXdSHRp2sFJfMKiAGj/icbnafn8hjcqWo0lIF6YJTCXXO+V+vhe00nOLgsPXiLD4Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TaPsGMeT0M4EFr9O9N4aNMtsxgKZG38GKBBUXnYvlk=;
 b=o0semSw3OV1sgzpfsIb7mwioT1Z1FbvfJp8gSfrI21v8b82Ipe2C/OJnGmr1ksGFJWnZsjEZdaK8dQE+hflQc3AdWul1xASIx9A79jL7GE+8aBc0fwSTHlU8cf0XTEvtk0vCMyHq6tEMSPc90J/KGuM2cUqUzFmNBSL+Ep6e/xc=
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com (2603:10a6:208:11a::11)
 by AM7PR04MB6822.eurprd04.prod.outlook.com (2603:10a6:20b:108::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 09:40:05 +0000
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::8735:c480:4ac7:165c]) by AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::8735:c480:4ac7:165c%6]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 09:40:05 +0000
From:   Gaurav Jain <gaurav.jain@nxp.com>
To:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Varun Sethi <V.Sethi@nxp.com>
Subject: RE: [PATCH v3 1/2] crypto: caam - reduce page 0 regs access to
 minimum
Thread-Topic: [PATCH v3 1/2] crypto: caam - reduce page 0 regs access to
 minimum
Thread-Index: AQHZZ54r203aXyJnrkC0k1in/JLT+a8ndj6A
Date:   Wed, 12 Apr 2023 09:40:05 +0000
Message-ID: <AM0PR04MB6004CFD6DE3FDE13300C9D71E79B9@AM0PR04MB6004.eurprd04.prod.outlook.com>
References: <20230322061716.3195841-3-meenakshi.aggarwal@nxp.com>
 <20230405090752.1708455-1-meenakshi.aggarwal@nxp.com>
 <20230405090752.1708455-2-meenakshi.aggarwal@nxp.com>
In-Reply-To: <20230405090752.1708455-2-meenakshi.aggarwal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6004:EE_|AM7PR04MB6822:EE_
x-ms-office365-filtering-correlation-id: db484d54-af65-42f2-5463-08db3b39e585
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bBcNT2zUnc3Ugb1WpGnBLWhIFBVJvLvNFMKicE4blOrIRt2BdSrX3Xtl1TgsvMUEFHY1vVbf6Zpn7cO7JTAppQ0fZoKgc2A86lbCP1tLr5OOmDzkset5oJ3wR4M55LLgRI5FRxWAtKW8VP3BrcSYBJCl+j63pRfGJkp2QPtsZyOkLYgVD69n3Ir4EEfVDdFQy+q4xE6RxLO8Wf3dUdJZHLuk6Q+jjy+6AD5yRrAs9CIHQ7TkS/qcxRHXb2oPj/rP/iAObVhONktECI5+gEEeNU6iS5W8BygoDIzkuO8VBivxiaHutQSuV2smqsS4pkUciLhwpwfHUKe/vEe5w4BvXPEAObysd4rPwPSHcleWRqLDnG9YaSzHcVi4Eohd0aqQykMwcRA2NJdRVC1yBbeV/GvvqtjE2b9BUcy0+zR7BWyz+PZtDfbSd6W89mflQuDQ1oBwUHXiSrkZA5muN+//HNPlVkTu+gO1yPj7ypCkAqYuLgadWADySuIMwNarsNbQ7uGD9xSE8/5qTvNXXlt8HeEzkU+q1AB9YfX/ViYftnc2zavAUrE+bR6E6flTREPnzeh5Z93HV/hapPjMbVfB4/Rl6Up3EGuRmB9+i0p8HD5m8p+h1J3XGqXngwEyOlbp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199021)(76116006)(83380400001)(478600001)(71200400001)(7696005)(26005)(186003)(6506007)(53546011)(110136005)(55236004)(9686003)(41300700001)(2906002)(44832011)(52536014)(30864003)(33656002)(5660300002)(38100700002)(122000001)(4326008)(66556008)(66476007)(66446008)(66946007)(64756008)(8936002)(38070700005)(316002)(55016003)(86362001)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ODd6kYo5EuUXKon2YXA+Ioi0T+Q7/frR5aBIv5BjVsYvNZoHZbVFACCTQ5wH?=
 =?us-ascii?Q?tB7Xy/e6fFXwtf6BxwhugSzlvQRIR+eigUlbeQChnR2Rlc096PLBM267OMtU?=
 =?us-ascii?Q?rhFOaoSMajIdQy5NG+HNCscKgpzCJHw+JJndhguLQoqp1hnohC4JDwuZCGkZ?=
 =?us-ascii?Q?sbcgxojCGt7LZDApTXFvvmJcdANrnXdrrgP4RpkOJ8KGB0e4PS1AJU5fRTUd?=
 =?us-ascii?Q?s/fQ/DhYIMTW8+X3zI0nP3kJy8ObTDhOcLI7+K9asjZQ+QJqiksNLxSpojr2?=
 =?us-ascii?Q?t/US6r1INsXbYnsoOY/NXbiCwfVgtOAmh+UzRZnD15rSY5QpXSIWK29PXEED?=
 =?us-ascii?Q?h8CT6zZZAhVmy966cu+SDJs9ZVQDYuTJk32py8rOuK5JvK9WtRevh/BVcAMA?=
 =?us-ascii?Q?aTT78pIzWxSywTpdkaW2upl3wIU/6p+w3I3Ol3ufwgMZaDRNipNK12/arxLp?=
 =?us-ascii?Q?6PhoBumDVbqPJr1WR2JydJgYzmeF0mJnyHRe/wz2RZEty7zCewPgOaBxwqtF?=
 =?us-ascii?Q?fY0A/jEcEDABPg8hqIocA4jc+QoU1VcmC6tuEf5E8WO3iNKm9rzpT3dyTSch?=
 =?us-ascii?Q?YHPyPgqtmiOQZhanV07H5mSWkIlyLErqMmCgDRqzqqgkgHSuwM4EyjsyvInQ?=
 =?us-ascii?Q?dN8vgc/Pt71yDY0i+Juo44K9GRXhYF7f+VrHU3fpxoURyrrhXdAs9LeC9sEH?=
 =?us-ascii?Q?J5XgsmScGKS0msIYbo34vaUWZMH0dRmIvf1kJ00nhsjiAOdy8owYeXZ+KmTa?=
 =?us-ascii?Q?/lfWD+hsbVHW5UBn3ydvm6Z1CNfSDoBaFxhymEXsPsHyudOek440YsSaNbUp?=
 =?us-ascii?Q?NFjXs+xzIjllhRR0ikduaDwQMwlw1dTaFKjZN8O7eYJtcFL/HxGq9xpFzObj?=
 =?us-ascii?Q?6R6G8nxcLI2L7sr14qnkoBce9J3rTXAxKqD6/Y+mHnXWaaz1UpuWbBIWUWEU?=
 =?us-ascii?Q?OS21jQFkHikOwyoPAx9x0j/VV9mZ1bCRAjzY9Pww7ueSDwn2lIav97xYz386?=
 =?us-ascii?Q?QxEVHkP9x510Qxo7jzXZbY24Aw1+VFDGl5EcXfLqOyGLTYHtdC6E7n+i+M5N?=
 =?us-ascii?Q?DMgVSop83iTlEsokdi26kmHGRw+nO7URl7c8E8FYTUIDiTNpQR+2ONbfPTMC?=
 =?us-ascii?Q?TbIW6J9QRYzI2Nj9BWUhhpFgwxRYExCL9ukWnvRC+pRzThO4EMfEA9tUIpYD?=
 =?us-ascii?Q?jrZcHrMgnx2ztqYOgfVSJqhxbNIaUdrEXDzTxF0Scz9m9XMpT9Oerboovi0t?=
 =?us-ascii?Q?NRZskJxpRh5PC9z0E8NbiR4GPqIJ5P3d6rOaMcASduuvBLCOx4WShnJu8sI/?=
 =?us-ascii?Q?t9IEfPVPTaRLkbc794YTu/cyX2F7PJOsg5VtQ65yPUg6qDfKnwmNGcXHvwEn?=
 =?us-ascii?Q?ZEx9ISC+ct+mVse5y0J2MC6U51cYoYI2kw6vn64ExnvjriJQ/lhQBwQgiU3E?=
 =?us-ascii?Q?yvG9uZ9i1bK4s567G27bKUPX2b5Yz+lJVrzPQgIwP1L0RfJsamFKVoD2FQvL?=
 =?us-ascii?Q?ab5fDz1AnEo3C9tNYSZILtSP6/AanMJn2+mzJG8YOUwWtl0EdhvutoJcrvDs?=
 =?us-ascii?Q?iuLrFOFwEFLzVXVmV0zmNDHTFnp47KtjMuaWbBHt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db484d54-af65-42f2-5463-08db3b39e585
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 09:40:05.2544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4883gnN2ltV0Axz1LrbY/NJZTGX3HoM98GuAM4amo/qTbhnmVzfPFAQ0zhk8dbK7z+/MDR9d6UvmTciUslwMRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6822
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Gaurav Jain <gaurav.jain@nxp.com>

> -----Original Message-----
> From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> Sent: Wednesday, April 5, 2023 2:38 PM
> To: Horia Geanta <horia.geanta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>;
> Pankaj Gupta <pankaj.gupta@nxp.com>; Gaurav Jain <gaurav.jain@nxp.com>;
> herbert@gondor.apana.org.au; davem@davemloft.net; linux-
> crypto@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>; Varun Sethi
> <V.Sethi@nxp.com>
> Subject: [PATCH v3 1/2] crypto: caam - reduce page 0 regs access to minim=
um
>=20
> From: Horia GeantA <horia.geanta@nxp.com>
>=20
> Use job ring register map, in place of controller register map to access =
page 0
> registers, as access to the controller register map is not permitted.
>=20
> Signed-off-by: Horia GeantA <horia.geanta@nxp.com>
> Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
> Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> Reviewed-by: Varun Sethi <v.sethi@nxp.com>
> ---
>  drivers/crypto/caam/caamalg.c  | 21 +++++----
> drivers/crypto/caam/caamhash.c | 10 ++--  drivers/crypto/caam/caampkc.c  =
|  6
> +--  drivers/crypto/caam/caamrng.c  |  6 +--
>  drivers/crypto/caam/ctrl.c     | 83 +++++++++++++++++++++-------------
>  drivers/crypto/caam/debugfs.c  |  9 ++--  drivers/crypto/caam/debugfs.h =
 |  7
> ++-
>  7 files changed, 84 insertions(+), 58 deletions(-)
>=20
> diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.=
c
> index 12b1c8346243..feb86013dbf6 100644
> --- a/drivers/crypto/caam/caamalg.c
> +++ b/drivers/crypto/caam/caamalg.c
> @@ -3,7 +3,7 @@
>   * caam - Freescale FSL CAAM support for crypto API
>   *
>   * Copyright 2008-2011 Freescale Semiconductor, Inc.
> - * Copyright 2016-2019 NXP
> + * Copyright 2016-2019, 2023 NXP
>   *
>   * Based on talitos crypto API driver.
>   *
> @@ -3542,13 +3542,14 @@ int caam_algapi_init(struct device *ctrldev)
>  	 * First, detect presence and attributes of DES, AES, and MD blocks.
>  	 */
>  	if (priv->era < 10) {
> +		struct caam_perfmon __iomem *perfmon =3D &priv->jr[0]-
> >perfmon;
>  		u32 cha_vid, cha_inst, aes_rn;
>=20
> -		cha_vid =3D rd_reg32(&priv->ctrl->perfmon.cha_id_ls);
> +		cha_vid =3D rd_reg32(&perfmon->cha_id_ls);
>  		aes_vid =3D cha_vid & CHA_ID_LS_AES_MASK;
>  		md_vid =3D (cha_vid & CHA_ID_LS_MD_MASK) >>
> CHA_ID_LS_MD_SHIFT;
>=20
> -		cha_inst =3D rd_reg32(&priv->ctrl->perfmon.cha_num_ls);
> +		cha_inst =3D rd_reg32(&perfmon->cha_num_ls);
>  		des_inst =3D (cha_inst & CHA_ID_LS_DES_MASK) >>
>  			   CHA_ID_LS_DES_SHIFT;
>  		aes_inst =3D cha_inst & CHA_ID_LS_AES_MASK; @@ -3556,23
> +3557,23 @@ int caam_algapi_init(struct device *ctrldev)
>  		ccha_inst =3D 0;
>  		ptha_inst =3D 0;
>=20
> -		aes_rn =3D rd_reg32(&priv->ctrl->perfmon.cha_rev_ls) &
> -			 CHA_ID_LS_AES_MASK;
> +		aes_rn =3D rd_reg32(&perfmon->cha_rev_ls) &
> CHA_ID_LS_AES_MASK;
>  		gcm_support =3D !(aes_vid =3D=3D CHA_VER_VID_AES_LP && aes_rn <
> 8);
>  	} else {
> +		struct version_regs __iomem *vreg =3D &priv->jr[0]->vreg;
>  		u32 aesa, mdha;
>=20
> -		aesa =3D rd_reg32(&priv->ctrl->vreg.aesa);
> -		mdha =3D rd_reg32(&priv->ctrl->vreg.mdha);
> +		aesa =3D rd_reg32(&vreg->aesa);
> +		mdha =3D rd_reg32(&vreg->mdha);
>=20
>  		aes_vid =3D (aesa & CHA_VER_VID_MASK) >>
> CHA_VER_VID_SHIFT;
>  		md_vid =3D (mdha & CHA_VER_VID_MASK) >>
> CHA_VER_VID_SHIFT;
>=20
> -		des_inst =3D rd_reg32(&priv->ctrl->vreg.desa) &
> CHA_VER_NUM_MASK;
> +		des_inst =3D rd_reg32(&vreg->desa) & CHA_VER_NUM_MASK;
>  		aes_inst =3D aesa & CHA_VER_NUM_MASK;
>  		md_inst =3D mdha & CHA_VER_NUM_MASK;
> -		ccha_inst =3D rd_reg32(&priv->ctrl->vreg.ccha) &
> CHA_VER_NUM_MASK;
> -		ptha_inst =3D rd_reg32(&priv->ctrl->vreg.ptha) &
> CHA_VER_NUM_MASK;
> +		ccha_inst =3D rd_reg32(&vreg->ccha) & CHA_VER_NUM_MASK;
> +		ptha_inst =3D rd_reg32(&vreg->ptha) & CHA_VER_NUM_MASK;
>=20
>  		gcm_support =3D aesa & CHA_VER_MISC_AES_GCM;
>  	}
> diff --git a/drivers/crypto/caam/caamhash.c b/drivers/crypto/caam/caamhas=
h.c
> index 82d3c730a502..80deb003f0a5 100644
> --- a/drivers/crypto/caam/caamhash.c
> +++ b/drivers/crypto/caam/caamhash.c
> @@ -3,7 +3,7 @@
>   * caam - Freescale FSL CAAM support for ahash functions of crypto API
>   *
>   * Copyright 2011 Freescale Semiconductor, Inc.
> - * Copyright 2018-2019 NXP
> + * Copyright 2018-2019, 2023 NXP
>   *
>   * Based on caamalg.c crypto API driver.
>   *
> @@ -1956,12 +1956,14 @@ int caam_algapi_hash_init(struct device *ctrldev)
>  	 * presence and attributes of MD block.
>  	 */
>  	if (priv->era < 10) {
> -		md_vid =3D (rd_reg32(&priv->ctrl->perfmon.cha_id_ls) &
> +		struct caam_perfmon __iomem *perfmon =3D &priv->jr[0]-
> >perfmon;
> +
> +		md_vid =3D (rd_reg32(&perfmon->cha_id_ls) &
>  			  CHA_ID_LS_MD_MASK) >> CHA_ID_LS_MD_SHIFT;
> -		md_inst =3D (rd_reg32(&priv->ctrl->perfmon.cha_num_ls) &
> +		md_inst =3D (rd_reg32(&perfmon->cha_num_ls) &
>  			   CHA_ID_LS_MD_MASK) >> CHA_ID_LS_MD_SHIFT;
>  	} else {
> -		u32 mdha =3D rd_reg32(&priv->ctrl->vreg.mdha);
> +		u32 mdha =3D rd_reg32(&priv->jr[0]->vreg.mdha);
>=20
>  		md_vid =3D (mdha & CHA_VER_VID_MASK) >>
> CHA_VER_VID_SHIFT;
>  		md_inst =3D mdha & CHA_VER_NUM_MASK;
> diff --git a/drivers/crypto/caam/caampkc.c b/drivers/crypto/caam/caampkc.=
c
> index e40614fef39d..72afc249d42f 100644
> --- a/drivers/crypto/caam/caampkc.c
> +++ b/drivers/crypto/caam/caampkc.c
> @@ -3,7 +3,7 @@
>   * caam - Freescale FSL CAAM support for Public Key Cryptography
>   *
>   * Copyright 2016 Freescale Semiconductor, Inc.
> - * Copyright 2018-2019 NXP
> + * Copyright 2018-2019, 2023 NXP
>   *
>   * There is no Shared Descriptor for PKC so that the Job Descriptor must=
 carry
>   * all the desired key parameters, input and output pointers.
> @@ -1168,10 +1168,10 @@ int caam_pkc_init(struct device *ctrldev)
>=20
>  	/* Determine public key hardware accelerator presence. */
>  	if (priv->era < 10) {
> -		pk_inst =3D (rd_reg32(&priv->ctrl->perfmon.cha_num_ls) &
> +		pk_inst =3D (rd_reg32(&priv->jr[0]->perfmon.cha_num_ls) &
>  			   CHA_ID_LS_PK_MASK) >> CHA_ID_LS_PK_SHIFT;
>  	} else {
> -		pkha =3D rd_reg32(&priv->ctrl->vreg.pkha);
> +		pkha =3D rd_reg32(&priv->jr[0]->vreg.pkha);
>  		pk_inst =3D pkha & CHA_VER_NUM_MASK;
>=20
>  		/*
> diff --git a/drivers/crypto/caam/caamrng.c b/drivers/crypto/caam/caamrng.=
c
> index 1fd8ff965006..50eb55da45c2 100644
> --- a/drivers/crypto/caam/caamrng.c
> +++ b/drivers/crypto/caam/caamrng.c
> @@ -3,7 +3,7 @@
>   * caam - Freescale FSL CAAM support for hw_random
>   *
>   * Copyright 2011 Freescale Semiconductor, Inc.
> - * Copyright 2018-2019 NXP
> + * Copyright 2018-2019, 2023 NXP
>   *
>   * Based on caamalg.c crypto API driver.
>   *
> @@ -227,10 +227,10 @@ int caam_rng_init(struct device *ctrldev)
>=20
>  	/* Check for an instantiated RNG before registration */
>  	if (priv->era < 10)
> -		rng_inst =3D (rd_reg32(&priv->ctrl->perfmon.cha_num_ls) &
> +		rng_inst =3D (rd_reg32(&priv->jr[0]->perfmon.cha_num_ls) &
>  			    CHA_ID_LS_RNG_MASK) >> CHA_ID_LS_RNG_SHIFT;
>  	else
> -		rng_inst =3D rd_reg32(&priv->ctrl->vreg.rng) &
> CHA_VER_NUM_MASK;
> +		rng_inst =3D rd_reg32(&priv->jr[0]->vreg.rng) &
> CHA_VER_NUM_MASK;
>=20
>  	if (!rng_inst)
>  		return 0;
> diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c inde=
x
> 6278afb951c3..de1f0acdb712 100644
> --- a/drivers/crypto/caam/ctrl.c
> +++ b/drivers/crypto/caam/ctrl.c
> @@ -3,7 +3,7 @@
>   * Controller-level driver, kernel property detection, initialization
>   *
>   * Copyright 2008-2012 Freescale Semiconductor, Inc.
> - * Copyright 2018-2019 NXP
> + * Copyright 2018-2019, 2023 NXP
>   */
>=20
>  #include <linux/device.h>
> @@ -395,7 +395,7 @@ static void kick_trng(struct platform_device *pdev, i=
nt
> ent_delay)
>  		      RTMCTL_SAMP_MODE_RAW_ES_SC);
>  }
>=20
> -static int caam_get_era_from_hw(struct caam_ctrl __iomem *ctrl)
> +static int caam_get_era_from_hw(struct caam_perfmon __iomem *perfmon)
>  {
>  	static const struct {
>  		u16 ip_id;
> @@ -421,12 +421,12 @@ static int caam_get_era_from_hw(struct caam_ctrl
> __iomem *ctrl)
>  	u16 ip_id;
>  	int i;
>=20
> -	ccbvid =3D rd_reg32(&ctrl->perfmon.ccb_id);
> +	ccbvid =3D rd_reg32(&perfmon->ccb_id);
>  	era =3D (ccbvid & CCBVID_ERA_MASK) >> CCBVID_ERA_SHIFT;
>  	if (era)	/* This is '0' prior to CAAM ERA-6 */
>  		return era;
>=20
> -	id_ms =3D rd_reg32(&ctrl->perfmon.caam_id_ms);
> +	id_ms =3D rd_reg32(&perfmon->caam_id_ms);
>  	ip_id =3D (id_ms & SECVID_MS_IPID_MASK) >> SECVID_MS_IPID_SHIFT;
>  	maj_rev =3D (id_ms & SECVID_MS_MAJ_REV_MASK) >>
> SECVID_MS_MAJ_REV_SHIFT;
>=20
> @@ -444,9 +444,9 @@ static int caam_get_era_from_hw(struct caam_ctrl
> __iomem *ctrl)
>   * In case this property is not passed an attempt to retrieve the CAAM
>   * era via register reads will be made.
>   *
> - * @ctrl:	controller region
> + * @perfmon:	Performance Monitor Registers
>   */
> -static int caam_get_era(struct caam_ctrl __iomem *ctrl)
> +static int caam_get_era(struct caam_perfmon __iomem *perfmon)
>  {
>  	struct device_node *caam_node;
>  	int ret;
> @@ -459,7 +459,7 @@ static int caam_get_era(struct caam_ctrl __iomem *ctr=
l)
>  	if (!ret)
>  		return prop;
>  	else
> -		return caam_get_era_from_hw(ctrl);
> +		return caam_get_era_from_hw(perfmon);
>  }
>=20
>  /*
> @@ -626,6 +626,7 @@ static int caam_probe(struct platform_device *pdev)
>  	struct device_node *nprop, *np;
>  	struct caam_ctrl __iomem *ctrl;
>  	struct caam_drv_private *ctrlpriv;
> +	struct caam_perfmon __iomem *perfmon;
>  	struct dentry *dfs_root;
>  	u32 scfgr, comp_params;
>  	u8 rng_vid;
> @@ -665,9 +666,36 @@ static int caam_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>=20
> -	caam_little_end =3D !(bool)(rd_reg32(&ctrl->perfmon.status) &
> +	ring =3D 0;
> +	for_each_available_child_of_node(nprop, np)
> +		if (of_device_is_compatible(np, "fsl,sec-v4.0-job-ring") ||
> +		    of_device_is_compatible(np, "fsl,sec4.0-job-ring")) {
> +			u32 reg;
> +
> +			if (of_property_read_u32_index(np, "reg", 0, &reg)) {
> +				dev_err(dev, "%s read reg property error\n",
> +					np->full_name);
> +				continue;
> +			}
> +
> +			ctrlpriv->jr[ring] =3D (struct caam_job_ring __iomem
> __force *)
> +					     ((__force uint8_t *)ctrl + reg);
> +
> +			ctrlpriv->total_jobrs++;
> +			ring++;
> +		}
> +
> +	/*
> +	 * Wherever possible, instead of accessing registers from the global
> page,
> +	 * use the alias registers in the first (cf. DT nodes order)
> +	 * job ring's page.
> +	 */
> +	perfmon =3D ring ? (struct caam_perfmon __iomem *)&ctrlpriv->jr[0]-
> >perfmon :
> +			 (struct caam_perfmon __iomem *)&ctrl->perfmon;
> +
> +	caam_little_end =3D !(bool)(rd_reg32(&perfmon->status) &
>  				  (CSTA_PLEND | CSTA_ALT_PLEND));
> -	comp_params =3D rd_reg32(&ctrl->perfmon.comp_parms_ms);
> +	comp_params =3D rd_reg32(&perfmon->comp_parms_ms);
>  	if (comp_params & CTPR_MS_PS && rd_reg32(&ctrl->mcr) &
> MCFGR_LONG_PTR)
>  		caam_ptr_sz =3D sizeof(u64);
>  	else
> @@ -778,7 +806,7 @@ static int caam_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>=20
> -	ctrlpriv->era =3D caam_get_era(ctrl);
> +	ctrlpriv->era =3D caam_get_era(perfmon);
>  	ctrlpriv->domain =3D iommu_get_domain_for_dev(dev);
>=20
>  	dfs_root =3D debugfs_create_dir(dev_name(dev), NULL); @@ -789,7
> +817,7 @@ static int caam_probe(struct platform_device *pdev)
>  			return ret;
>  	}
>=20
> -	caam_debugfs_init(ctrlpriv, dfs_root);
> +	caam_debugfs_init(ctrlpriv, perfmon, dfs_root);
>=20
>  	/* Check to see if (DPAA 1.x) QI present. If so, enable */
>  	if (ctrlpriv->qi_present && !caam_dpaa2) { @@ -808,26 +836,13 @@
> static int caam_probe(struct platform_device *pdev)  #endif
>  	}
>=20
> -	ring =3D 0;
> -	for_each_available_child_of_node(nprop, np)
> -		if (of_device_is_compatible(np, "fsl,sec-v4.0-job-ring") ||
> -		    of_device_is_compatible(np, "fsl,sec4.0-job-ring")) {
> -			ctrlpriv->jr[ring] =3D (struct caam_job_ring __iomem
> __force *)
> -					     ((__force uint8_t *)ctrl +
> -					     (ring + JR_BLOCK_NUMBER) *
> -					      BLOCK_OFFSET
> -					     );
> -			ctrlpriv->total_jobrs++;
> -			ring++;
> -		}
> -
>  	/* If no QI and no rings specified, quit and go home */
>  	if ((!ctrlpriv->qi_present) && (!ctrlpriv->total_jobrs)) {
>  		dev_err(dev, "no queues configured, terminating\n");
>  		return -ENOMEM;
>  	}
>=20
> -	comp_params =3D rd_reg32(&ctrl->perfmon.comp_parms_ls);
> +	comp_params =3D rd_reg32(&perfmon->comp_parms_ls);
>  	ctrlpriv->blob_present =3D !!(comp_params & CTPR_LS_BLOB);
>=20
>  	/*
> @@ -836,15 +851,21 @@ static int caam_probe(struct platform_device *pdev)
>  	 * check both here.
>  	 */
>  	if (ctrlpriv->era < 10) {
> -		rng_vid =3D (rd_reg32(&ctrl->perfmon.cha_id_ls) &
> +		rng_vid =3D (rd_reg32(&perfmon->cha_id_ls) &
>  			   CHA_ID_LS_RNG_MASK) >> CHA_ID_LS_RNG_SHIFT;
>  		ctrlpriv->blob_present =3D ctrlpriv->blob_present &&
> -			(rd_reg32(&ctrl->perfmon.cha_num_ls) &
> CHA_ID_LS_AES_MASK);
> +			(rd_reg32(&perfmon->cha_num_ls) &
> CHA_ID_LS_AES_MASK);
>  	} else {
> -		rng_vid =3D (rd_reg32(&ctrl->vreg.rng) & CHA_VER_VID_MASK) >>
> +		struct version_regs __iomem *vreg;
> +
> +		vreg =3D  ctrlpriv->total_jobrs ?
> +			(struct version_regs __iomem *)&ctrlpriv->jr[0]->vreg :
> +			(struct version_regs __iomem *)&ctrl->vreg;
> +
> +		rng_vid =3D (rd_reg32(&vreg->rng) & CHA_VER_VID_MASK) >>
>  			   CHA_VER_VID_SHIFT;
>  		ctrlpriv->blob_present =3D ctrlpriv->blob_present &&
> -			(rd_reg32(&ctrl->vreg.aesa) &
> CHA_VER_MISC_AES_NUM_MASK);
> +			(rd_reg32(&vreg->aesa) &
> CHA_VER_MISC_AES_NUM_MASK);
>  	}
>=20
>  	/*
> @@ -925,8 +946,8 @@ static int caam_probe(struct platform_device *pdev)
>=20
>  	/* NOTE: RTIC detection ought to go here, around Si time */
>=20
> -	caam_id =3D (u64)rd_reg32(&ctrl->perfmon.caam_id_ms) << 32 |
> -		  (u64)rd_reg32(&ctrl->perfmon.caam_id_ls);
> +	caam_id =3D (u64)rd_reg32(&perfmon->caam_id_ms) << 32 |
> +		  (u64)rd_reg32(&perfmon->caam_id_ls);
>=20
>  	/* Report "alive" for developer to see */
>  	dev_info(dev, "device ID =3D 0x%016llx (Era %d)\n", caam_id, diff --git
> a/drivers/crypto/caam/debugfs.c b/drivers/crypto/caam/debugfs.c index
> 806bb20d2aa1..b2ef2273298d 100644
> --- a/drivers/crypto/caam/debugfs.c
> +++ b/drivers/crypto/caam/debugfs.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> -/* Copyright 2019 NXP */
> +/* Copyright 2019, 2023 NXP */
>=20
>  #include <linux/debugfs.h>
>  #include "compat.h"
> @@ -42,16 +42,15 @@ void caam_debugfs_qi_init(struct caam_drv_private
> *ctrlpriv)  }  #endif
>=20
> -void caam_debugfs_init(struct caam_drv_private *ctrlpriv, struct dentry =
*root)
> +void caam_debugfs_init(struct caam_drv_private *ctrlpriv,
> +		       struct caam_perfmon __force *perfmon,
> +		       struct dentry *root)
>  {
> -	struct caam_perfmon *perfmon;
> -
>  	/*
>  	 * FIXME: needs better naming distinction, as some amalgamation of
>  	 * "caam" and nprop->full_name. The OF name isn't distinctive,
>  	 * but does separate instances
>  	 */
> -	perfmon =3D (struct caam_perfmon __force *)&ctrlpriv->ctrl->perfmon;
>=20
>  	ctrlpriv->ctl =3D debugfs_create_dir("ctl", root);
>=20
> diff --git a/drivers/crypto/caam/debugfs.h b/drivers/crypto/caam/debugfs.=
h
> index 661d768acdbf..8b5d1acd21a7 100644
> --- a/drivers/crypto/caam/debugfs.h
> +++ b/drivers/crypto/caam/debugfs.h
> @@ -1,16 +1,19 @@
>  /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
> -/* Copyright 2019 NXP */
> +/* Copyright 2019, 2023 NXP */
>=20
>  #ifndef CAAM_DEBUGFS_H
>  #define CAAM_DEBUGFS_H
>=20
>  struct dentry;
>  struct caam_drv_private;
> +struct caam_perfmon;
>=20
>  #ifdef CONFIG_DEBUG_FS
> -void caam_debugfs_init(struct caam_drv_private *ctrlpriv, struct dentry =
*root);
> +void caam_debugfs_init(struct caam_drv_private *ctrlpriv,
> +		       struct caam_perfmon __force *perfmon, struct dentry
> *root);
>  #else
>  static inline void caam_debugfs_init(struct caam_drv_private *ctrlpriv,
> +				     struct caam_perfmon __force *perfmon,
>  				     struct dentry *root)
>  {}
>  #endif
> --
> 2.25.1

