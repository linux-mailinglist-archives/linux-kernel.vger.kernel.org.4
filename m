Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A9B6C0CDE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjCTJNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjCTJM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:12:57 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2053.outbound.protection.outlook.com [40.107.6.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF8A23330;
        Mon, 20 Mar 2023 02:12:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGtfUS08I5fJ66sYviALFIjTUSXNMs1HP7yjHl8JEUNdJV19QDTEz6Cps7Ocyx2rEW7GN5Hi9daKc1UzP4v2+aoGRqxVWUqfbaUppdrhu7OXQdrDX94zmo0rRQwLrmGToSm+3dSsWhPwl3vgbf1AgNQi9sHn8XAOAODLhe5ocJP10NOmLSb5GedUDgNNjVTYXW8gFUV8AtMKgCbTV+90mQd+vzL73wawyaDfUzLsMu8wgDXg6DdBNpQaxBdVM8ctYuopTZEBj5vOqdAm9lsI92n6Il4Z9V1DC00mMosNepiBPmaVizjMOTvfancwjyoM4daOB+p+8IBgPPVfZmkieg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSvX3HeGian59BgEvq7tJ8xd8QAV9lMFFZygAx3NlkI=;
 b=QZMzRURTHnWZTB2mfqEhz9p5z05/rdfY+qZD6lhgqkkX8i7QWDfTMFIZ1G337jkzMnre8Rj2B0Q7JFP+GMrdpwKnL12hvCZObFLYIqCl3aKK+/Rghfxmr7xul9gG+lIbMBuLAJvYIw1TBm0nIPMkjU38VwFXG/kaq2H2qrtZ+1TSu+UR6Blt80XV/CnUOoHltJyWEe7yBVq40MBtOD5/Xj6m0oAo0rTno+rAxPExVy2Qq+FN0DF53hyUTKaL0vM0+tc4WQwnVsGmWh+FLGCPrp4nAE+2PWMcTOXdeqKcSxtaAGDZe5OoHY5sIhxE9f6/3QAkthM8dkkJJpkQFTWWbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSvX3HeGian59BgEvq7tJ8xd8QAV9lMFFZygAx3NlkI=;
 b=B3HSm4Uqf6MtW1NyeotrdforRuJcDsX4I2TUCAzpmmwbX47fDjYDcR7xKP7wz6PFcAxjSwXfnc/8YoXI9tSHItcZIUrUowF0ENmVs+Yr7ldbmCwyayRXWkNHGeRKXQ644MMa4EScGj1MusNpUrcoruwU/lM7v0kDooSSyKUq9BE=
Received: from AM9PR04MB8211.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::17)
 by PR3PR04MB7291.eurprd04.prod.outlook.com (2603:10a6:102:8c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 09:12:46 +0000
Received: from AM9PR04MB8211.eurprd04.prod.outlook.com
 ([fe80::80e8:4b2b:7c70:eda2]) by AM9PR04MB8211.eurprd04.prod.outlook.com
 ([fe80::80e8:4b2b:7c70:eda2%5]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 09:12:50 +0000
From:   Varun Sethi <V.Sethi@nxp.com>
To:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] crypto: caam - reduce page 0 regs access to minimum
Thread-Topic: [PATCH 1/2] crypto: caam - reduce page 0 regs access to minimum
Thread-Index: AQHZTM84TTjIbnfyN0mJ/yPRPLdXRq8DfoxQ
Date:   Mon, 20 Mar 2023 09:12:49 +0000
Message-ID: <AM9PR04MB8211E61777776A4AE60D135EE8809@AM9PR04MB8211.eurprd04.prod.outlook.com>
References: <20230302062055.1564514-1-meenakshi.aggarwal@nxp.com>
 <20230302062055.1564514-2-meenakshi.aggarwal@nxp.com>
In-Reply-To: <20230302062055.1564514-2-meenakshi.aggarwal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8211:EE_|PR3PR04MB7291:EE_
x-ms-office365-filtering-correlation-id: 2bb984d6-0da1-48ce-670c-08db29234752
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zd6ueN/CXZPLlqEQq0zazgW55U9qfAjwr1i280Y8lrVXGu0w5iyqT7Kh4YGy/v0RWh6WKEpdCac9QNPzwhzcNyIZlYYp+WWGTwHPnxPfJRdt58OWeBSgIn91GdHPHnUBI1YrG1SiJSf8Bvqq5TOAgLg/JKr8bJHOCl2e386Q6tvoD1chAgddwX3LPnkBNXdnna6X44Ge068xreF6+gW62HFIyo9hkeBziTBk75mt76xyT3g1bpoSDneN90sUB7M41HCmV0QvoTbDfAHDwRX5QOwK6XRg5jhTuoiGBmTxkQwhL+Opd7IbHIg2httDu30rapAU/VsGFsPTasNQJ1E/hUcoR+HinyUAT4HmEaDOULcjaaeaRDVRcBemrNF2tSilqGiM/fJpHJzLkyjfb3h4d1MS3aazV/vBJnzPrTtJCs1dsGYvDRDj3PUUA4C+DrR/eXmjtSkvEkr+gg0Uj3ueJH6r9ExBNT2oPRCZTQTSNp4YnFozAi+qju0SLKmyRxdaJcs84AMLBbmEpKUHW9FNYCYYxvLF4mPmGT+HIll7z9ygjVql9WvfYQNCzXWfQJYvFh154z5UU3oYddfqeG6qoYCkVwP8FmDLASoUcVtkOpr9dcv8JrvVQXo+yHcX4Plq1XyDINEChlcTnha/RuKmcJ7qfezBEoebH5avBEnrWQg8/4agafv1cUBCb8Pt2DUrLNayHgtEZZSxuI8BWqZA2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8211.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(451199018)(83380400001)(7696005)(33656002)(55236004)(86362001)(122000001)(55016003)(9686003)(6506007)(26005)(8676002)(186003)(38100700002)(38070700005)(53546011)(71200400001)(478600001)(8936002)(316002)(66446008)(64756008)(66556008)(66476007)(66946007)(110136005)(41300700001)(76116006)(30864003)(52536014)(2906002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tSzi6eLbkI39EH9Tj12FEBplDX65SH4zzSlYlfhED2EZAoEvF1uAsW1593Dw?=
 =?us-ascii?Q?Z2mxBR7MDBDZhr0LLi9PyFmvRqgEBXyg12xKDiWBScw2+mKMuWe6N3OPwkLV?=
 =?us-ascii?Q?rvaHZtlrHlZKl9HQM+1nLwlDyZkvZuvvAV9aznqH9XgJtl1aDcowX8BZDS6u?=
 =?us-ascii?Q?bT7BEjKJidgEtlJoWBTiuYVsgJqTkt1gMerBvfTI1ZaZaJxNH/s9Fk1opmmJ?=
 =?us-ascii?Q?bFfW7chAWTMFETMHpF4NdqFOmffWucq8zV/IJPFVQH27sACO3Hxw3uj48gJ5?=
 =?us-ascii?Q?VOSMvtplpQj0YIpbyA5DM7V34ITzTv44NpeuB735uhzeh5Jv97j5D1UwCfUx?=
 =?us-ascii?Q?uZSW5U/e6IOQiNZGwyt5+2bKxaPQNpgyuCjRZCoAHP9hkrbPPhp+f3UgD4CX?=
 =?us-ascii?Q?KLr4/vRLdgTKPLzdiw3U0j1d59/tK0aHqgL+UNrK2dDdVCxk48ooJOr1yhvg?=
 =?us-ascii?Q?0GBqeTBc9lMJnbcpaZsLzlRO2jPkjQWDYwHFWzxokz2eikGp3CX4ASQwTkcv?=
 =?us-ascii?Q?+mRDQ0Ifx28HmNRgUq0/1qaXmBx81847E6Ai9ra5Pqe0zU7bO2zi5kqksoRf?=
 =?us-ascii?Q?eRWpKA6DAYTFXl2b1q4SPH4m2CwIOgxar6Ycc/ngMlvawqP20pUBP5GmifzZ?=
 =?us-ascii?Q?Xiu+aUTzNUuhXj8W74vmjhEm93c/QS4oKa4awViQTUAYTcOstllI+cbs/rE3?=
 =?us-ascii?Q?gFSI78QTbzywDLxt+zfPV35Fw0vC3tKb4QNic5E4rsezvSHsgjpSG+Ttqmdy?=
 =?us-ascii?Q?dk8aZJdREZYPaZxBgRJxyrK/lVSX9ifF3E5F2pXvN0TTBZkaqgoaBA72Jo1b?=
 =?us-ascii?Q?xXrQdSWuAqS4Mz/YDe319v2T1YDJwdRhHHRVCbg2lSJZQrW0n0zuq5NQD6P+?=
 =?us-ascii?Q?8mSYoDBXjpHUUWeH0PjQ6CHNInoU9Wc1Pun813iOUE2iB8fj00z8zYU/K8QO?=
 =?us-ascii?Q?+KJU188q9v/EvsspGRA+sU9+xTS+q5tKGwC1wtf6T6NFSPbFP3eIX3q5EDWi?=
 =?us-ascii?Q?Xei/SD+YZ+bzScv7BONr25xDTzuTxKb5THJylsZZy2xWJdoL09wGDoV+qQ3i?=
 =?us-ascii?Q?TMAMWD55kS0qgx/QO1Kr4htFy4QXHZJq67MuNq2qFFQ90+xGs4CzlmVoCQwX?=
 =?us-ascii?Q?A8j92V1/kexnfjxk2T+Htz8jlyUqGTymx2o1ptmpjW548Q0C7xuRq8drAQIO?=
 =?us-ascii?Q?olLYGtH4WeV2he7nRf1J7w9a3dUxHr3uyK0C6Ue+WcP5cXluo3pVpmp45i4N?=
 =?us-ascii?Q?G8Hqe1zNwIXdG7kXlDW01SnORc6/llnFDe0eXA2VpU3E6lgG7tljQWZy/m+n?=
 =?us-ascii?Q?QTjq1L51nXJw9iq5RY3bk7WFCH9BYcNPOLnb2ta90O4QXe5TGNQ24HJJUIkS?=
 =?us-ascii?Q?QFlrQd7P4eXEveOvhe6UkXg4Mnp9D3lgavd0ZnXXrf/XW2MMLOKYJnlCKIYv?=
 =?us-ascii?Q?k2RALLsbfsVv54Rfd5wr2xhmIXnHJl9yRogfUo7z5HCvzmY0lK6Oj/2Ab9gX?=
 =?us-ascii?Q?WAZJXC6ZKsXQzj1dlJCdEpdCsv69NoLf3FoLwJnlpyFrRKUOkFfmWGxeyuJe?=
 =?us-ascii?Q?3EnVFY+335JzxXKHkSw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8211.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb984d6-0da1-48ce-670c-08db29234752
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 09:12:49.9765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nYpt8REC8X2P29IsxCQQAgnzfa+5ub4aQ4h51WiSNMHx286/WQSqN+9BQnSdmLaC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7291
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Varun Sethi <v.sethi@nxp.com>



Regards
Varun

> -----Original Message-----
> From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> Sent: Thursday, March 2, 2023 11:51 AM
> To: Horia Geanta <horia.geanta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>;
> Pankaj Gupta <pankaj.gupta@nxp.com>; Gaurav Jain <gaurav.jain@nxp.com>;
> herbert@gondor.apana.org.au; davem@davemloft.net; linux-
> crypto@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH 1/2] crypto: caam - reduce page 0 regs access to minimum
>=20
> From: Horia GeantA <horia.geanta@nxp.com>
>=20
> Use job ring register map, in place of controller register map to access =
page 0
> registers, as access to the controller register map is not permitted.
>=20
> Signed-off-by: Horia GeantA <horia.geanta@nxp.com>
> ---
>  drivers/crypto/caam/caamalg.c  | 21 +++++-----
> drivers/crypto/caam/caamhash.c | 10 +++--  drivers/crypto/caam/caampkc.c =
 |
> 6 +--  drivers/crypto/caam/caamrng.c  |  6 +--
>  drivers/crypto/caam/ctrl.c     | 74 +++++++++++++++++++++-------------
>  drivers/crypto/caam/debugfs.c  |  8 ++--  drivers/crypto/caam/debugfs.h =
 |  7
> +++-
>  7 files changed, 78 insertions(+), 54 deletions(-)
>=20
> diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.=
c
> index 4a9b998a8d26..29838b80a0bb 100644
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
> @@ -3530,13 +3530,14 @@ int caam_algapi_init(struct device *ctrldev)
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
>  		aes_inst =3D cha_inst & CHA_ID_LS_AES_MASK; @@ -3544,23
> +3545,23 @@ int caam_algapi_init(struct device *ctrldev)
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
> 6278afb951c3..be9724d05d01 100644
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
> @@ -446,7 +446,7 @@ static int caam_get_era_from_hw(struct caam_ctrl
> __iomem *ctrl)
>   *
>   * @ctrl:	controller region
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
> +	perfmon =3D ring ? (struct caam_perfmon *)&ctrlpriv->jr[0]->perfmon :
> +			 (struct caam_perfmon *)&ctrl->perfmon;
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
>  	if (ctrlpriv->qi_present && !caam_dpaa2) { @@ -808,19 +836,6 @@
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
>  		dev_err(dev, "no queues configured, terminating\n"); @@ -
> 836,12 +851,17 @@ static int caam_probe(struct platform_device *pdev)
>  	 * check both here.
>  	 */
>  	if (ctrlpriv->era < 10) {
> -		rng_vid =3D (rd_reg32(&ctrl->perfmon.cha_id_ls) &
> +		rng_vid =3D (rd_reg32(&perfmon->cha_id_ls) &
>  			   CHA_ID_LS_RNG_MASK) >> CHA_ID_LS_RNG_SHIFT;
>  		ctrlpriv->blob_present =3D ctrlpriv->blob_present &&
>  			(rd_reg32(&ctrl->perfmon.cha_num_ls) &
> CHA_ID_LS_AES_MASK);
>  	} else {
> -		rng_vid =3D (rd_reg32(&ctrl->vreg.rng) & CHA_VER_VID_MASK) >>
> +		struct version_regs __iomem *vreg;
> +
> +		vreg =3D ring ? (struct version_regs *)&ctrlpriv->jr[0]->vreg :
> +			      (struct version_regs *)&ctrl->vreg;
> +
> +		rng_vid =3D (rd_reg32(&vreg->rng) & CHA_VER_VID_MASK) >>
>  			   CHA_VER_VID_SHIFT;
>  		ctrlpriv->blob_present =3D ctrlpriv->blob_present &&
>  			(rd_reg32(&ctrl->vreg.aesa) &
> CHA_VER_MISC_AES_NUM_MASK); @@ -925,8 +945,8 @@ static int
> caam_probe(struct platform_device *pdev)
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
> 806bb20d2aa1..73fe8530c0d6 100644
> --- a/drivers/crypto/caam/debugfs.c
> +++ b/drivers/crypto/caam/debugfs.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> -/* Copyright 2019 NXP */
> +/* Copyright 2019, 2023 NXP */
>=20
>  #include <linux/debugfs.h>
>  #include "compat.h"
> @@ -42,16 +42,14 @@ void caam_debugfs_qi_init(struct caam_drv_private
> *ctrlpriv)  }  #endif
>=20
> -void caam_debugfs_init(struct caam_drv_private *ctrlpriv, struct dentry =
*root)
> +void caam_debugfs_init(struct caam_drv_private *ctrlpriv,
> +		       struct caam_perfmon *perfmon, struct dentry *root)
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
> index 661d768acdbf..fd2f0fc46d53 100644
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
> +		       struct caam_perfmon *perfmon, struct dentry *root);
>  #else
>  static inline void caam_debugfs_init(struct caam_drv_private *ctrlpriv,
> +				     struct caam_perfmon *perfmon,
>  				     struct dentry *root)
>  {}
>  #endif
> --
> 2.25.1

