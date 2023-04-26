Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133C86EEEF0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239934AbjDZHJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239584AbjDZHIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:08:45 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on20608.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaf::608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDA55260;
        Wed, 26 Apr 2023 00:06:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBLTdYRi4FBMxvLVrlswx/MoGmZmfrQhAULI9PjQpgTW+d17DDX8qUX1xd2wBX2nONQEvkyemos3B3TAzDLRw2D0qgB+rRHFjZJsv8h5gs2EWtFv6T904pLRKkjw5Xr3Cx4S8JOP0tINnuD8V1nmtf39xwTRyfaF6N4cH4xvw9MPxxE6rfom2qRtSxHLQYPQAmJJPHC7H6LGK/iw2wfYTB353+RyrgBCFveThtkUNE41t4L1Ena+jeSResRHje1t4zbVxolztKB1fMSMPn2la1J4OR/IgqvFmUnxpGRjoCgeskTPzCudMoDR1zTOI5HeN99Am4QCBPIq/kK2Sm/QcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XODiEXB7EIEk8BlX30HkudZ2DMP+UYvkurKqgcXtTKg=;
 b=e5ro6bPuklJZh3Jbd0OkS8V4hmWT8xp28iLi62LA+OhWWAwzxh/IMVVJTB9ofXz+8ogNLxaIrN2AAEMRl3CFLsuHSDlvGrwe3aZkcKVZ6kphMO+Wi0tBqiUaIkQ2dPf/d5bTXeyv5fYHxEuwemhdZC573AXzOJ6CrCsKs7gKuuM7vrndUMgiZwJ1kCJ9RITVna7Fhwrt5kB+YQgQXxo5oJsfyWmLo7YJZ9fB7a53Ktwh8dAVSKuY4HgCEL0YKX2D6vfNuoYLgG0TCHRxY37Lf1jSaYKu7pBl1j75w5hFFsrWpeM31UZPcNS9aZujHCuzQa+uf0hhvguM3HPDlPnAFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XODiEXB7EIEk8BlX30HkudZ2DMP+UYvkurKqgcXtTKg=;
 b=AUq8cLSdk+sDPIp88xcvZzr89VkGZxa09J7EB62QHa+JJz9YJRt04hCnQp1ZDbc0quhbE4xhQC+vV2DJM8cEWTJBXUWyMi/i0BUYr2DcQnSzug4sZl5646ymDljYpOhxOvr7sVVT8EO9ZsgZFUBOoMx3RdKSf92JODJoX99Iq9Q=
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com (2603:10a6:208:11a::11)
 by AS8PR04MB8200.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 07:05:55 +0000
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::22df:f288:a27b:b8d3]) by AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::22df:f288:a27b:b8d3%6]) with mapi id 15.20.6319.033; Wed, 26 Apr 2023
 07:05:55 +0000
From:   Gaurav Jain <gaurav.jain@nxp.com>
To:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "leonard.crestez@nxp.com" <leonard.crestez@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [PATCH v3] crypto: caam - refactor RNG initialization
Thread-Topic: [PATCH v3] crypto: caam - refactor RNG initialization
Thread-Index: AQHZcVqAHaxra9tL8kqieh41tJiT/q89ODJQ
Date:   Wed, 26 Apr 2023 07:05:54 +0000
Message-ID: <AM0PR04MB60048938761D9C21EC0042D7E7659@AM0PR04MB6004.eurprd04.prod.outlook.com>
References: <20230405103306.1763491-1-meenakshi.aggarwal@nxp.com>
 <20230417182839.782924-1-meenakshi.aggarwal@nxp.com>
In-Reply-To: <20230417182839.782924-1-meenakshi.aggarwal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6004:EE_|AS8PR04MB8200:EE_
x-ms-office365-filtering-correlation-id: e879a0f0-726c-49d4-25d9-08db4624ada1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 26ZNrdm/9Vxe0USU+nZQr5sE4n4iL+jmj/NnbP5sf6uL2dHIG0NXwgxYYCDJ/wHXfmFmrM1QO+q03qTtto6f7pn2eCSHDw0eAMAKBr1ZsFoTivPpDQsPRakztlcFqyvDMrsYT94PnKUvsrk33qZpth8HpArJqk+ikvZ6W500U8tz26IZqtJlVqFLFsPf4sejxCPlylJcTM1Ku1t5vj1yDWycp29vSlw9inTOQTcUfdRnN+zSNfTQvNuId7/V7YRiIt8VUouT/PpmDhdMwcG5iVam4A+wQNM1nP5UEA9ZIzppvzraARk3Jb2OBNJXOMBJhgdU2cp7cQNZNmfV6r3cusrGFZWGeola9wips1kHJzMTMynrOvl8eAstOQMcb0EoZVPyptDlZxAEsyrItSF2POSSyOxujyVn9Wla3UNUpmg8mJirj3VokSEKFSqhQpbwBLwC33d3MbHaPtIHdTyXxVvK3WvIGkIC9lL5FJ5wWfmhrPtz41PrSnae8UL99QMvo/vgjDPLptw71pQnF5vm9h1r5ktkMP/tPZljbBIHWLONFcO58fShgiNvVe7/SzrIFCOgDATUFNT/tjRB/ethgPgY4BNyAZYEaFLQ20tqatinTkEc6noXwZVX07EH4dvWyrV4psfKmqar096HsmR1hw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(451199021)(33656002)(122000001)(921005)(52536014)(30864003)(5660300002)(2906002)(44832011)(38070700005)(8936002)(55016003)(316002)(8676002)(66946007)(66446008)(38100700002)(66556008)(41300700001)(86362001)(66476007)(64756008)(6636002)(76116006)(83380400001)(9686003)(186003)(6506007)(26005)(55236004)(53546011)(7696005)(71200400001)(478600001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eSTDT3KS+zcvv9KO2oOWibX/onm9mba7P2HVXrOklk6aiSrlZ+/BQZzZGL0I?=
 =?us-ascii?Q?0JPACWh2hzvg2F49w/d2Hm0RP6a5r5noWQK24e96LTDTHAe2dFYa7vvTWXZe?=
 =?us-ascii?Q?W+zWJCAv4VmFXIN9VLTk+aVWk1JT0lQSo6hgprRf7FW7rmN0ubq+Gh3imhvb?=
 =?us-ascii?Q?9He+vnaPLF5vzfrNY/XoOpemNg+OuuUxfhD/7n1DY0AoQCuJ+YJXwXLemBLu?=
 =?us-ascii?Q?fxIRwUaHOAzJCgkFy0qDP6m/AOjUifscsevq82Ca/JKN6YWcpqUcL5u/hVWT?=
 =?us-ascii?Q?hAZwW/BFO4z9sVIKc0/V9zN8w5LlVuqdHJLa5AlO4WAe1N8e8bUvQPPPYdpH?=
 =?us-ascii?Q?5MpbufLvgoRCxD3ezB5LzOKUP0ITSJc+jZqheNxoOPxrSckqt8TO6wkvrv6Q?=
 =?us-ascii?Q?zncXPHoWqubKmnL/btIkpbIwjo3hSWxqyE4OXsBWanhQA0VASYHNfcYYO5/4?=
 =?us-ascii?Q?2jfn4/hqaKfzz/ELs3NVlvWzxL+vYYHdLbjPRXL3Oha8oXSCsLdoHpAW81D9?=
 =?us-ascii?Q?+gkoRu9//t+I1Cf+2CH6Cmr2x0+qRd71YvqkoclN0ERNrUI6WJeL35PPrZg9?=
 =?us-ascii?Q?L7IVOYaZ4fLda6jrKe28X44oc4YrUhJL2d3FoJz1vdO3nInqUkX35k4XGgCb?=
 =?us-ascii?Q?+7ZMNZlE8WvuEPYw72EuLNyjOALQVf6f+pzf74c4WXbCzmSZC3mqKVLeg7Xr?=
 =?us-ascii?Q?08ptoS+3M6V3rzZ47DctZp6AJVbQSpgr5AFiNcjfTkGgiZSoG1eRlMPOnKOH?=
 =?us-ascii?Q?BkC4TTxhShYYAZeK9rAKOCyWGQ65XRLJoEPgTKCE6VyhoFKlA1ZGzi44pJZN?=
 =?us-ascii?Q?6Hr59qnQyfh6HaaT/BsgqxkGGvxuPRJzt7A9IXNVxm42v268nxcwVyZFYXWt?=
 =?us-ascii?Q?omZg7cXxzDU3KBG5cabtzpBWAFNiDoqiC3hNcYePCs0o5Z/cWsd+L6lPSmq/?=
 =?us-ascii?Q?7g6FdAqyhXH8eWC6er+PPYZPhhIzSyF2aKo8hGrc4NNw+vK5d4d+CZwgE3hR?=
 =?us-ascii?Q?BJejy2LPmmjx9HeC8zc6DKfZQHqKQ/s/Qr4pPWOfd3zpvg6XVgfKj78AQjDK?=
 =?us-ascii?Q?OXpndxF9BN6YEXdm5e3fvizdX43IHGZ0fnZpL8vkPx99ViYsR5bmwMKU67Xa?=
 =?us-ascii?Q?gGPkIOHIXMBWLgIRS1/Dlgxq3diDPcnhd+Q6UW2mxw8BsIK8WynbBAqsneIN?=
 =?us-ascii?Q?dUIBoP3LxhUFtsEfxdtxAdl+Id08+Oz2ogXwX3F+mPjGFUYUdzhQLHbMEaII?=
 =?us-ascii?Q?hFc1FfY3Ohd2+hKjLquNpdBDok8xQ3VeXvW/heFjjYJYxYaNsoh8n+HmAvkz?=
 =?us-ascii?Q?mb2t0QBztDhNtRFI09h2hYpN2Qt27HPeusJYUADiM/zYpejtwMiyXlmvxfDR?=
 =?us-ascii?Q?XevJwexicCDLZGNAvctkmlzKL4R69TqFBoH3oOXpH2vj9drj+yhe7IzQ2GVv?=
 =?us-ascii?Q?wUkCgN3/HNCwD/mQXPIOZpYletOeXB0SgkSiJx5bspdez/o2DrSYxVcYu0n1?=
 =?us-ascii?Q?nY/pxIJFfyPdBhZtMfgU4YTykdECorAsfDvdNo7gxifpcPwYmDA0nlNqLmgo?=
 =?us-ascii?Q?AZxpR/3WTtxFA+3iMBgUcexJ5PKcVa4dKjzwVyG8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e879a0f0-726c-49d4-25d9-08db4624ada1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 07:05:54.8503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DXgoGV/6+MOLZvKDp88gMoXJf3z4KXn7JswVGDubc72Te8OkCHhgRDYNheUUQRGlQx8Ff9jc8u9UHn5k6PuG7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8200
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Gaurav Jain <gaurav.jain@nxp.com>

> -----Original Message-----
> From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> Sent: Monday, April 17, 2023 11:59 PM
> To: Horia Geanta <horia.geanta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>;
> Pankaj Gupta <pankaj.gupta@nxp.com>; Gaurav Jain <gaurav.jain@nxp.com>;
> herbert@gondor.apana.org.au; davem@davemloft.net; linux-
> crypto@vger.kernel.org; linux-kernel@vger.kernel.org;
> leonard.crestez@nxp.com; Aisheng Dong <aisheng.dong@nxp.com>
> Cc: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> Subject: [PATCH v3] crypto: caam - refactor RNG initialization
>=20
> From: Horia GeantA <horia.geanta@nxp.com>
>=20
> RNG (re-)initialization will be needed on pm resume path, thus refactor t=
he
> corresponding code out of the probe callback.
>=20
> Signed-off-by: Horia GeantA <horia.geanta@nxp.com>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> ---
> changes in v2:
> 	Rebased on "page 0" patches
>=20
> changes in v3:
> 	Incorporated review comments
>=20
>  drivers/crypto/caam/ctrl.c   | 205 +++++++++++++++++++----------------
>  drivers/crypto/caam/intern.h |   1 +
>  2 files changed, 115 insertions(+), 91 deletions(-)
>=20
> diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c inde=
x
> 9c5a035e1b96..7070349943c8 100644
> --- a/drivers/crypto/caam/ctrl.c
> +++ b/drivers/crypto/caam/ctrl.c
> @@ -342,13 +342,12 @@ static int instantiate_rng(struct device *ctrldev, =
int
> state_handle_mask,
>  /*
>   * kick_trng - sets the various parameters for enabling the initializati=
on
>   *	       of the RNG4 block in CAAM
> - * @pdev - pointer to the platform device
> + * @dev - pointer to the controller device
>   * @ent_delay - Defines the length (in system clocks) of each entropy sa=
mple.
>   */
> -static void kick_trng(struct platform_device *pdev, int ent_delay)
> +static void kick_trng(struct device *dev, int ent_delay)
>  {
> -	struct device *ctrldev =3D &pdev->dev;
> -	struct caam_drv_private *ctrlpriv =3D dev_get_drvdata(ctrldev);
> +	struct caam_drv_private *ctrlpriv =3D dev_get_drvdata(dev);
>  	struct caam_ctrl __iomem *ctrl;
>  	struct rng4tst __iomem *r4tst;
>  	u32 val;
> @@ -616,10 +615,115 @@ static bool needs_entropy_delay_adjustment(void)
>  	return false;
>  }
>=20
> +static int caam_ctrl_rng_init(struct device *dev) {
> +	struct caam_drv_private *ctrlpriv =3D dev_get_drvdata(dev);
> +	struct caam_ctrl __iomem *ctrl =3D ctrlpriv->ctrl;
> +	int ret, gen_sk, ent_delay =3D RTSDCTL_ENT_DLY_MIN;
> +	u8 rng_vid;
> +
> +	if (ctrlpriv->era < 10) {
> +		struct caam_perfmon __iomem *perfmon;
> +
> +		perfmon =3D ctrlpriv->total_jobrs ?
> +			  (struct caam_perfmon __iomem *)&ctrlpriv->jr[0]-
> >perfmon :
> +			  (struct caam_perfmon __iomem *)&ctrl->perfmon;
> +
> +		rng_vid =3D (rd_reg32(&perfmon->cha_id_ls) &
> +			   CHA_ID_LS_RNG_MASK) >> CHA_ID_LS_RNG_SHIFT;
> +	} else {
> +		struct version_regs __iomem *vreg;
> +
> +		vreg =3D ctrlpriv->total_jobrs ?
> +			(struct version_regs __iomem *)&ctrlpriv->jr[0]->vreg :
> +			(struct version_regs __iomem *)&ctrl->vreg;
> +
> +		rng_vid =3D (rd_reg32(&vreg->rng) & CHA_VER_VID_MASK) >>
> +			  CHA_VER_VID_SHIFT;
> +	}
> +
> +	/*
> +	 * If SEC has RNG version >=3D 4 and RNG state handle has not been
> +	 * already instantiated, do RNG instantiation
> +	 * In case of SoCs with Management Complex, RNG is managed by MC
> f/w.
> +	 */
> +	if (!(ctrlpriv->mc_en && ctrlpriv->pr_support) && rng_vid >=3D 4) {
> +		ctrlpriv->rng4_sh_init =3D
> +			rd_reg32(&ctrl->r4tst[0].rdsta);
> +		/*
> +		 * If the secure keys (TDKEK, JDKEK, TDSK), were already
> +		 * generated, signal this to the function that is instantiating
> +		 * the state handles. An error would occur if RNG4 attempts
> +		 * to regenerate these keys before the next POR.
> +		 */
> +		gen_sk =3D ctrlpriv->rng4_sh_init & RDSTA_SKVN ? 0 : 1;
> +		ctrlpriv->rng4_sh_init &=3D RDSTA_MASK;
> +		do {
> +			int inst_handles =3D
> +				rd_reg32(&ctrl->r4tst[0].rdsta) & RDSTA_MASK;
> +			/*
> +			 * If either SH were instantiated by somebody else
> +			 * (e.g. u-boot) then it is assumed that the entropy
> +			 * parameters are properly set and thus the function
> +			 * setting these (kick_trng(...)) is skipped.
> +			 * Also, if a handle was instantiated, do not change
> +			 * the TRNG parameters.
> +			 */
> +			if (needs_entropy_delay_adjustment())
> +				ent_delay =3D 12000;
> +			if (!(ctrlpriv->rng4_sh_init || inst_handles)) {
> +				dev_info(dev,
> +					 "Entropy delay =3D %u\n",
> +					 ent_delay);
> +				kick_trng(dev, ent_delay);
> +				ent_delay +=3D 400;
> +			}
> +			/*
> +			 * if instantiate_rng(...) fails, the loop will rerun
> +			 * and the kick_trng(...) function will modify the
> +			 * upper and lower limits of the entropy sampling
> +			 * interval, leading to a successful initialization of
> +			 * the RNG.
> +			 */
> +			ret =3D instantiate_rng(dev, inst_handles,
> +					      gen_sk);
> +			/*
> +			 * Entropy delay is determined via TRNG
> characterization.
> +			 * TRNG characterization is run across different
> voltages
> +			 * and temperatures.
> +			 * If worst case value for ent_dly is identified,
> +			 * the loop can be skipped for that platform.
> +			 */
> +			if (needs_entropy_delay_adjustment())
> +				break;
> +			if (ret =3D=3D -EAGAIN)
> +				/*
> +				 * if here, the loop will rerun,
> +				 * so don't hog the CPU
> +				 */
> +				cpu_relax();
> +		} while ((ret =3D=3D -EAGAIN) && (ent_delay <
> RTSDCTL_ENT_DLY_MAX));
> +		if (ret) {
> +			dev_err(dev, "failed to instantiate RNG");
> +			return ret;
> +		}
> +		/*
> +		 * Set handles initialized by this module as the complement of
> +		 * the already initialized ones
> +		 */
> +		ctrlpriv->rng4_sh_init =3D ~ctrlpriv->rng4_sh_init & RDSTA_MASK;
> +
> +		/* Enable RDB bit so that RNG works faster */
> +		clrsetbits_32(&ctrl->scfgr, 0, SCFGR_RDBENABLE);
> +	}
> +
> +	return 0;
> +}
> +
>  /* Probe routine for CAAM top (controller) level */  static int caam_pro=
be(struct
> platform_device *pdev)  {
> -	int ret, ring, gen_sk, ent_delay =3D RTSDCTL_ENT_DLY_MIN;
> +	int ret, ring;
>  	u64 caam_id;
>  	const struct soc_device_attribute *imx_soc_match;
>  	struct device *dev;
> @@ -629,10 +733,8 @@ static int caam_probe(struct platform_device *pdev)
>  	struct caam_perfmon __iomem *perfmon;
>  	struct dentry *dfs_root;
>  	u32 scfgr, comp_params;
> -	u8 rng_vid;
>  	int pg_size;
>  	int BLOCK_OFFSET =3D 0;
> -	bool pr_support =3D false;
>  	bool reg_access =3D true;
>=20
>  	ctrlpriv =3D devm_kzalloc(&pdev->dev, sizeof(*ctrlpriv), GFP_KERNEL);
> @@ -768,7 +870,8 @@ static int caam_probe(struct platform_device *pdev)
>=20
>  		mc_version =3D fsl_mc_get_version();
>  		if (mc_version)
> -			pr_support =3D check_version(mc_version, 10, 20, 0);
> +			ctrlpriv->pr_support =3D check_version(mc_version, 10,
> 20,
> +							     0);
>  		else
>  			return -EPROBE_DEFER;
>  	}
> @@ -859,9 +962,6 @@ static int caam_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
>=20
> -	if (!reg_access)
> -		goto report_live;
> -
>  	comp_params =3D rd_reg32(&perfmon->comp_parms_ls);
>  	ctrlpriv->blob_present =3D !!(comp_params & CTPR_LS_BLOB);
>=20
> @@ -871,8 +971,6 @@ static int caam_probe(struct platform_device *pdev)
>  	 * check both here.
>  	 */
>  	if (ctrlpriv->era < 10) {
> -		rng_vid =3D (rd_reg32(&perfmon->cha_id_ls) &
> -			   CHA_ID_LS_RNG_MASK) >> CHA_ID_LS_RNG_SHIFT;
>  		ctrlpriv->blob_present =3D ctrlpriv->blob_present &&
>  			(rd_reg32(&perfmon->cha_num_ls) &
> CHA_ID_LS_AES_MASK);
>  	} else {
> @@ -882,91 +980,16 @@ static int caam_probe(struct platform_device *pdev)
>  			(struct version_regs __iomem *)&ctrlpriv->jr[0]->vreg :
>  			(struct version_regs __iomem *)&ctrl->vreg;
>=20
> -		rng_vid =3D (rd_reg32(&vreg->rng) & CHA_VER_VID_MASK) >>
> -			   CHA_VER_VID_SHIFT;
>  		ctrlpriv->blob_present =3D ctrlpriv->blob_present &&
>  			(rd_reg32(&vreg->aesa) &
> CHA_VER_MISC_AES_NUM_MASK);
>  	}
>=20
> -	/*
> -	 * If SEC has RNG version >=3D 4 and RNG state handle has not been
> -	 * already instantiated, do RNG instantiation
> -	 * In case of SoCs with Management Complex, RNG is managed by MC
> f/w.
> -	 */
> -	if (!(ctrlpriv->mc_en && pr_support) && rng_vid >=3D 4) {
> -		ctrlpriv->rng4_sh_init =3D
> -			rd_reg32(&ctrl->r4tst[0].rdsta);
> -		/*
> -		 * If the secure keys (TDKEK, JDKEK, TDSK), were already
> -		 * generated, signal this to the function that is instantiating
> -		 * the state handles. An error would occur if RNG4 attempts
> -		 * to regenerate these keys before the next POR.
> -		 */
> -		gen_sk =3D ctrlpriv->rng4_sh_init & RDSTA_SKVN ? 0 : 1;
> -		ctrlpriv->rng4_sh_init &=3D RDSTA_MASK;
> -		do {
> -			int inst_handles =3D
> -				rd_reg32(&ctrl->r4tst[0].rdsta) &
> -								RDSTA_MASK;
> -			/*
> -			 * If either SH were instantiated by somebody else
> -			 * (e.g. u-boot) then it is assumed that the entropy
> -			 * parameters are properly set and thus the function
> -			 * setting these (kick_trng(...)) is skipped.
> -			 * Also, if a handle was instantiated, do not change
> -			 * the TRNG parameters.
> -			 */
> -			if (needs_entropy_delay_adjustment())
> -				ent_delay =3D 12000;
> -			if (!(ctrlpriv->rng4_sh_init || inst_handles)) {
> -				dev_info(dev,
> -					 "Entropy delay =3D %u\n",
> -					 ent_delay);
> -				kick_trng(pdev, ent_delay);
> -				ent_delay +=3D 400;
> -			}
> -			/*
> -			 * if instantiate_rng(...) fails, the loop will rerun
> -			 * and the kick_trng(...) function will modify the
> -			 * upper and lower limits of the entropy sampling
> -			 * interval, leading to a successful initialization of
> -			 * the RNG.
> -			 */
> -			ret =3D instantiate_rng(dev, inst_handles,
> -					      gen_sk);
> -			/*
> -			 * Entropy delay is determined via TRNG
> characterization.
> -			 * TRNG characterization is run across different
> voltages
> -			 * and temperatures.
> -			 * If worst case value for ent_dly is identified,
> -			 * the loop can be skipped for that platform.
> -			 */
> -			if (needs_entropy_delay_adjustment())
> -				break;
> -			if (ret =3D=3D -EAGAIN)
> -				/*
> -				 * if here, the loop will rerun,
> -				 * so don't hog the CPU
> -				 */
> -				cpu_relax();
> -		} while ((ret =3D=3D -EAGAIN) && (ent_delay <
> RTSDCTL_ENT_DLY_MAX));
> -		if (ret) {
> -			dev_err(dev, "failed to instantiate RNG");
> +	if (reg_access) {
> +		ret =3D caam_ctrl_rng_init(dev);
> +		if (ret)
>  			return ret;
> -		}
> -		/*
> -		 * Set handles initialized by this module as the complement of
> -		 * the already initialized ones
> -		 */
> -		ctrlpriv->rng4_sh_init =3D ~ctrlpriv->rng4_sh_init & RDSTA_MASK;
> -
> -		/* Enable RDB bit so that RNG works faster */
> -		clrsetbits_32(&ctrl->scfgr, 0, SCFGR_RDBENABLE);
>  	}
>=20
> -report_live:
> -	/* NOTE: RTIC detection ought to go here, around Si time */
> -
>  	caam_id =3D (u64)rd_reg32(&perfmon->caam_id_ms) << 32 |
>  		  (u64)rd_reg32(&perfmon->caam_id_ls);
>=20
> diff --git a/drivers/crypto/caam/intern.h b/drivers/crypto/caam/intern.h =
index
> 86ed1b91c22d..b4f7bf77f487 100644
> --- a/drivers/crypto/caam/intern.h
> +++ b/drivers/crypto/caam/intern.h
> @@ -95,6 +95,7 @@ struct caam_drv_private {
>  	u8 blob_present;	/* Nonzero if BLOB support present in device */
>  	u8 mc_en;		/* Nonzero if MC f/w is active */
>  	u8 optee_en;		/* Nonzero if OP-TEE f/w is active */
> +	bool pr_support;        /* RNG prediction resistance available */
>  	int secvio_irq;		/* Security violation interrupt number */
>  	int virt_en;		/* Virtualization enabled in CAAM */
>  	int era;		/* CAAM Era (internal HW revision) */
> --
> 2.25.1

