Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2DB6C5FF4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 07:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCWGvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 02:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjCWGvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 02:51:07 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2085.outbound.protection.outlook.com [40.107.247.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D282D151;
        Wed, 22 Mar 2023 23:51:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6gAIeLx3Tdi6urrla+KeVHFvkDQOnU8wFVcZv48irjZcZ4WlS2yR9zdxCD5OxXAqAWZI9EtijBwKt9U6qXG8PNDyYsdGUmd3mJSfQS297SN1wU5yRu2GSuA9uTNEVEyseQDMNiS+LUkdeGwLDBb1zXlRN2e/0TD315qZD2ZjHs8mEquho1CQN47qzD0Bi7DNR+vDLt8pCIBD1Y4vzFKSCKLaMRGHqtOmqd7yV4zc1ZZ6jel10XGONTXPNs5rXSMz8x902fwO1mZvOcbTc7sRQAx196Yk324HjlWun7JtLDxVEW6LuqABxAROVb6Or3Gtg5ImBXDXf0pmNHvIUH+Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bgh4WP0Nb4MB+lDsDochKK4zRI0eb5pyxnUmHDoNGpA=;
 b=X3tFqb+0jVsilMkjpIxUddc4qJAyYlOHZA9hpnLd6Eqgz0HTWo+yQqVhmqYq+/XwhjsTu/B2gYEGOXNHv6nIX1Zjr1Iy0dmfaMkDdMfqfobVMVDY2WOIRrgwqZsa+p9YzG+6YmmX/otMofvxirqkDix6Sg1YIGE82LTYB0/HMZgAm3vXPUY1BgR+EnQ0ney9waRW4sSzzJNN1xVg/+B2wWzT28j0T1i4GXsdh/QnZcJUZQfofg6TBBoAWT9tSG8ZuDdgxuqyNDYqVv51Goq7t/cQyrk1JBYv2Z++YqFUrp0rMhzR8NpZlfgI8SKFBc3labWy0T2pDqBm/iM0tLWZcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bgh4WP0Nb4MB+lDsDochKK4zRI0eb5pyxnUmHDoNGpA=;
 b=UTpprmz+N4diLJ8Wqm6VU80RMQCzDMUZVIjZf37jWiqN5Slklt2harJPR2Jlsof1/YiF8aXe9UrpATGj/RZlwUiChk2NEABwTilvCVorWcQ2TCK/MyrSIIsnwvLwBPZylZbbWoCucdx1iWUFJt8VO11Ii04fqK0UbZ8FExDTOpU=
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com (2603:10a6:208:11a::11)
 by PAXPR04MB8206.eurprd04.prod.outlook.com (2603:10a6:102:1cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 06:51:01 +0000
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::c2c7:5798:7033:5f87]) by AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::c2c7:5798:7033:5f87%7]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 06:51:01 +0000
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
Subject: RE: [PATCH v2 1/2] crypto: caam - reduce page 0 regs access to
 minimum
Thread-Topic: [PATCH v2 1/2] crypto: caam - reduce page 0 regs access to
 minimum
Thread-Index: AQHZXIYE2xtrf7mAKE+fMldeQujGH68H7pTA
Date:   Thu, 23 Mar 2023 06:51:01 +0000
Message-ID: <AM0PR04MB600438C3B877D01E37BD2616E7879@AM0PR04MB6004.eurprd04.prod.outlook.com>
References: <20230302062055.1564514-3-meenakshi.aggarwal@nxp.com>
 <20230322061716.3195841-1-meenakshi.aggarwal@nxp.com>
 <20230322061716.3195841-2-meenakshi.aggarwal@nxp.com>
In-Reply-To: <20230322061716.3195841-2-meenakshi.aggarwal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6004:EE_|PAXPR04MB8206:EE_
x-ms-office365-filtering-correlation-id: 88b003c0-6d63-4623-99af-08db2b6af720
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AygyYMaUKcJvEsbrfiTtGTbhuwiAavsXriJ8um05fnonapDFM88iAnQtAtgNEP66JlzfIAof6RSXay7/sjBjRkKzDEaYyGfR0W2PGnN3llBxYdIsWazw8U3TLv5dpxGhMEWtUJMz7Srz3blSjTfzHwdxdYb1zyBZwzJZy5FYwmO9C2FUD97JuU82wbGkKtJJewGFeSgMM2ue9oef4Y0RHqd5um/guXg47nMtRe6PUiXPbMcGDGve1XidBS9ZIpb5b8/yAkuwRuLEXuIk++rjEwLsbjs5uGqBWtntdjkCiXIbkhrUUlVoR7d1ciwibt3wStQkuE636AA4SXmTT6beOWun/JXjXFcng+iBjr3PvslHA73jfTNnmBGcLFZtmui44YzPU+a7gYKZ+SM+wNlFwGGs3IOtPhvA32TpP59ZyREDjXTgP6sbmj7WtjLUngH67qoMEFkpLSeFMVKfRnZJ0PHagDcCFjkGflMJrJ/S4nHcRO7qg9Ts0kfmR8l/++1DWNmK5f8Jlzu4w2vAFtLLy0lEuSguhI5lexG9AfWHe49/Kl034yhA/vP9HVm2U2d+0rn4wvSBXAbMLxNSn7lrZyyivgxcSSkELFkdHXdgz/32hxLiIuNhAGClKiM5pQMJx1DArNpPvVOJ8cq9KgcgW2sUELuHQ4Pub4dTW/k27Fw8pBkwrAJWM+OMNgykUzoSbvqh1WOYRP5faDu9YiStKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(451199018)(8936002)(76116006)(52536014)(66556008)(66446008)(64756008)(66476007)(41300700001)(8676002)(66946007)(4326008)(33656002)(478600001)(38100700002)(38070700005)(53546011)(122000001)(86362001)(26005)(9686003)(6506007)(55016003)(83380400001)(186003)(316002)(71200400001)(7696005)(110136005)(2906002)(5660300002)(44832011)(30864003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q0ZYAaC3G8OXewO9i51Rjyp/iV4yoSugFkkvfFqAQF/8nzHmYKdIVSAHjhDQ?=
 =?us-ascii?Q?Z0VdzZMWyzbHkYASZdPY3Z8JxPqS8x2tV4oMk/4ncinmHXG3VmaAz0wFaKq5?=
 =?us-ascii?Q?Qd5yWa5fBXROhXsgY/eJswrauKbGGD9rC8ZznnrI3AT1Aco79JXvMSG3JyHV?=
 =?us-ascii?Q?EVhqGAzSAjfPN1iuYK4jdC9gmMAr4f1a/y1rL8N0fLipUUlhXPU0nSYL+puo?=
 =?us-ascii?Q?viJEc2mD7vVhpIR1RiLHaMSYi6OIhkY6OBxw3o5K6bn+e2pq2cS7IALUZotC?=
 =?us-ascii?Q?Wy37JQfpg2wwXQL3NIxbbFmjg7aTNxXBkMs5cL6wWUi47ogJxUKRSfwYHhhC?=
 =?us-ascii?Q?AwFt52aMYuxipud0PZz3o/W4NrGJmo7VtwEgadvoJR/Kt96osxvNkCs84KWE?=
 =?us-ascii?Q?ZzCVeo+khK7flxig1SoClaIz6O7V9m9j2M7AHDlmETMzYwqbfFBTyyx2fRYf?=
 =?us-ascii?Q?Ntc3/PcGyhyrHwIc4G1l41ffg5GSUnLU20w3jysOUdhDkoJO8MkZjiw/68HM?=
 =?us-ascii?Q?Fs9KMsXTnDoIMwKVUE4pskKi1TMbZIEs9kVpdho+Y8q8g14esyt+G3iz7Yni?=
 =?us-ascii?Q?ZcQ+Y6tJHRMYOzMHgwxLpwfc3KGPuIydPd8CJjX3KpzUzgCgbwafbNC5pmqW?=
 =?us-ascii?Q?ZxopZBLpnY/d1PGGjnPBJmkR8DZIYa1xWXQsLU7/F4Ig/9vJisaey2wUGD34?=
 =?us-ascii?Q?7c+05IlzX/qvN//uCdKwnbGIHc/0itU2Mphn2WpoHySOcUSPTMJrqQ/f2C5r?=
 =?us-ascii?Q?3jX+fhZctsLW2vTd8v14Rw2lP+L9u8Du/A550WWIs1UZ0dMmvU4TBMDEmiug?=
 =?us-ascii?Q?GifvD1glveblZ/9bIE78mbgF799uY5vURT+ydMC0e/Sl8NwMtkAix5EySgIx?=
 =?us-ascii?Q?GpwzMW1sjtaXbVwBMB+uhqvcEV4o7qxXiak/YIeTx53lqi0RqoP7HFD4MG79?=
 =?us-ascii?Q?G15G8I5YOxFq+s2psDKtsm0CKGsAlrP1IMEsuZ3ayg3GZEpj+j9gKWvpz/IS?=
 =?us-ascii?Q?vgrHX6f5X6h82IdYROHeCSl+h4kVJg49Kay/poiG/TAWL09mm6+AXVMA6pJb?=
 =?us-ascii?Q?TJUEU4AHmgubRcH6eaEt/y3ulRpjply8io4JYdLZVKlePeJDmmExnWHxrKXT?=
 =?us-ascii?Q?JIQqiC+NsujBf+fM/+inTM92EM18e2C15y3yKeCyxPNnETMNPZpBy8Xs9jSj?=
 =?us-ascii?Q?IDY4vyji2/EFMcK32H/L0wJyWBekdvvFULsdyCwyShyaTHzeEEdHtUI3tcps?=
 =?us-ascii?Q?nYXPGLRAXgP5q2Fg7fOVngmcZWX1kx7+ET/tPwnxjYx6xSqqAyR3C2zNyZnQ?=
 =?us-ascii?Q?jpAcn5n9/bqNKb6uVE2slhgB1BUsE+zz2j1t5/dR428TvmzeNfYEBaaQ8ifX?=
 =?us-ascii?Q?SeH0zSCNjx3FOt+orNFd2vrHN6t0OxLE+7jiB3QWTmNRXefuFS5wXHecs1u+?=
 =?us-ascii?Q?tXU5zNimO64zsuKXpUYfdz7/fYI6/fbmC2j2RVJY0sH+2etoPzIDB4ssIeYW?=
 =?us-ascii?Q?sBPo36yg51/9kZiCRQQJUjNn6KjjygDyHcG6GbQP3uRdCQL5Xcstz6JB88NS?=
 =?us-ascii?Q?QPZL2YEJd9gmpbILt+blLwRqMBnOC/vyDLvDsiAK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b003c0-6d63-4623-99af-08db2b6af720
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 06:51:01.5537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k0YeG2XspO0lZ+3BWDRrKYflCbuj+DdOG9VQsHopX4ZBi4XaK/AaQHqRANer8p+EubX+p5rUFeQkDfXIxgWbPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8206
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Gaurav Jain <gaurav.jain@nxp.com>

> -----Original Message-----
> From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> Sent: Wednesday, March 22, 2023 11:47 AM
> To: Horia Geanta <horia.geanta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>;
> Pankaj Gupta <pankaj.gupta@nxp.com>; Gaurav Jain <gaurav.jain@nxp.com>;
> herbert@gondor.apana.org.au; davem@davemloft.net; linux-
> crypto@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>; Varun Sethi
> <V.Sethi@nxp.com>
> Subject: [PATCH v2 1/2] crypto: caam - reduce page 0 regs access to minim=
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
>  drivers/crypto/caam/caamalg.c  | 21 ++++-----
> drivers/crypto/caam/caamhash.c | 10 +++--  drivers/crypto/caam/caampkc.c =
 |
> 6 +--  drivers/crypto/caam/caamrng.c  |  6 +--
>  drivers/crypto/caam/ctrl.c     | 82 +++++++++++++++++++++-------------
>  drivers/crypto/caam/debugfs.c  |  9 ++--  drivers/crypto/caam/debugfs.h =
 |  7
> ++-
>  7 files changed, 83 insertions(+), 58 deletions(-)
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
> 6278afb951c3..ae07c1e5fd38 100644
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
> @@ -836,15 +851,20 @@ static int caam_probe(struct platform_device *pdev)
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
> +		vreg =3D ring ? (struct version_regs __iomem *)&ctrlpriv->jr[0]-
> >vreg :
> +			      (struct version_regs __iomem *)&ctrl->vreg;
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
> @@ -925,8 +945,8 @@ static int caam_probe(struct platform_device *pdev)
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
> 806bb20d2aa1..798ba989a8a0 100644
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
> +		       struct caam_perfmon __iomem *perfmon,
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
> index 661d768acdbf..78e3c6b957c2 100644
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
> +		       struct caam_perfmon __iomem *perfmon, struct dentry
> *root);
>  #else
>  static inline void caam_debugfs_init(struct caam_drv_private *ctrlpriv,
> +				     struct caam_perfmon __iomem *perfmon,
>  				     struct dentry *root)
>  {}
>  #endif
> --
> 2.25.1

