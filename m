Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D16E6DF095
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 11:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjDLJiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 05:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjDLJiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:38:22 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2087.outbound.protection.outlook.com [40.107.6.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272C8272B;
        Wed, 12 Apr 2023 02:38:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUyLf5myGEF91xmf6IFPF+dCIxOusFeO0FjDIYd99vhwUlUpjcsGr0Y+Vinwf+G4dgbnWrlW98vdWY/JGBpNV9NejO17zpPCJAFR3W1ZYLSmKA+dWIi+v2l1ulGS5nmKzivzy4Jpf55Bms8pf7pAG4TKYM7gorkqwK4CyUWQUQimExy3NpfHa34VrzGs2Y+3hB5knsNRD+pnK9pAiPozcWRGbeSmThlWmaiiD9D4qy/l8EhIaK77Ynl81VgbGrgZyzgtGv4CYyFcOEyc8OWr5IQ7i48jPImovkISKmP4ZnKJ1m0o+8FXHEkIsZwadC2Nk/Rn0upQ8yry54DdTlw+GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xutPr+iq4ZK7OGZWcQTjn9eYeVHA/OArr05YIjIo2ws=;
 b=DPDq0MaUPLeTnoNctVQsoMJ/5GSSE1lu02Jj4ISzO95WbBQA9e8RijEdCOuM30JeccZftK4x80OArkplSn++dWhyEIbtdIjAPOqNLzvg9la2zj9rrEHyjhwWoQTBhxN27dQqc0lz8jsaVXKOpHuBs4auyLoGXyzL5Wr5nNRxa6JEJz3SR1vbkIVPbXR9z4bWBbTCM2/tOxJeVnrnx8THnjR5IRhHpwpjnB9Bmm31Vxx7pYF8i+FIgRu2Mfuve/52iPTJBzpKqxjJ/dnN4PsK69DhOVjSQCT5fWCmR98p40KfLeJnyZ5u86oGnM8NBrhYGSTt/ixwZaoLbc4hR8Bo1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xutPr+iq4ZK7OGZWcQTjn9eYeVHA/OArr05YIjIo2ws=;
 b=OEYDa+gaB/ACFq8YbCG9wozuVJowhbUZ38JoVzBtfCWxgx57t3Z2+D9IowFJmcMZKfljthWo2SbTKLKMk1GSf6ZS5HJHIkCJZBIH734tPwIAwhU2OJWzQCJE0TXEtwUcyOTzRVM5bMjo7ziRJL7sBSuEwjLdcRo2lthTzGFlHJ4=
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com (2603:10a6:208:11a::11)
 by AM7PR04MB6822.eurprd04.prod.outlook.com (2603:10a6:20b:108::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 09:38:13 +0000
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::8735:c480:4ac7:165c]) by AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::8735:c480:4ac7:165c%6]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 09:38:13 +0000
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
Subject: RE: [PATCH v2] crypto: caam - refactor RNG initialization
Thread-Topic: [PATCH v2] crypto: caam - refactor RNG initialization
Thread-Index: AQHZZ6oPDInr9kDS5keXCwUtD489v68ndVZA
Date:   Wed, 12 Apr 2023 09:38:13 +0000
Message-ID: <AM0PR04MB600442AEC79685A66AEF71A9E79B9@AM0PR04MB6004.eurprd04.prod.outlook.com>
References: <20230320073848.697473-1-meenakshi.aggarwal@nxp.com>
 <20230405103306.1763491-1-meenakshi.aggarwal@nxp.com>
In-Reply-To: <20230405103306.1763491-1-meenakshi.aggarwal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6004:EE_|AM7PR04MB6822:EE_
x-ms-office365-filtering-correlation-id: b55a7901-9891-4350-7819-08db3b39a2fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X4Tp9zvkl4QyIlqKkXPIBC0BVuzKuFUi00Gm0TEKpzOKEu2i5annekS4W+6it/f0If2pRWlDGsoCn0deBqyxO4yJCksx0UOfjnUNVcxhylUOPK5dAsDNdufrjzivNkOxXGOk9zHq7JHXmmHpHm1kYV9uZygVd/U479W70csJoBWf6Vj75iVaLZHmRbOUyAHo8eakhB9TJzV1KBBKkIwsiGPl3cbR6Lt/pr8HDNdMz1oXIntPsv8IVmCRGzICHKouXwD5tofqF5uCNo/BpQgzZHfBhWZL83fvi2iADhHqBba0wEX60MxqEsv6CoHGcM53JChvLXeV5JdL40sVi9aRU2SeWjvExiueH8U84bE7lA6yVlXpoyH2LCnuiB0+QVQvolyeushdXuMlJp/8hQf6+QqdgvOwjh8NMPNctoavPVXUbWSOTahRfFVZiViXxlqR8Ugozy0l5PvAMXZ0l0ZSijsRisOrQ6EuSW9kaCbLagKCUpQ1/NCxSb+yO+DBEps6DE/kOUo3UneBQmPFFAZufGAnC9krg1cgOIGo6+GPV/6r3JB34iAEIDN/vlW4APo1+FBiQoNdr82e5JKSMg8DRu8zDM3659AHeTXKlPaBz5B5x+F9EAHgASgMwYg+T3uTD0niqqmiKZ/KqTXsQ30BpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199021)(76116006)(83380400001)(478600001)(71200400001)(7696005)(26005)(186003)(6506007)(6636002)(53546011)(110136005)(55236004)(9686003)(41300700001)(2906002)(44832011)(52536014)(30864003)(33656002)(5660300002)(38100700002)(122000001)(921005)(66556008)(66476007)(66446008)(66946007)(64756008)(8936002)(38070700005)(316002)(55016003)(86362001)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jHJajv2bbHByr2fqn8Z06GA6OxBxgtENqlYoSQehShSk8KsL+PrlilEbqvvZ?=
 =?us-ascii?Q?MMEQ0eV+2cY3ly6LxCm+EjrTraQY1cLhOarnZDMsld4p1bJSSc6lSshfchHj?=
 =?us-ascii?Q?z0igRbS94eMJisUTxvfQYJ5BfsNp4BTLu5lPaXkGOir6IJZ5rxOXPukMKJZo?=
 =?us-ascii?Q?LI3cTaJRKr2Sn+Mec6D4rHRWFdV0lhkVMf/p0n3MhIUXg6dIuHzsdNUd/kmw?=
 =?us-ascii?Q?eMXETJebXO2Jjk7AeMbPStgU3pb7Re2OwPUTGd1xYhM6nnpZNZ3x9GSI9xy+?=
 =?us-ascii?Q?EKQTqcCx57KrCC3a5mqDbqHqKh6MBbPzZEbdvVvOogRPHhxfI3x5eY59gRSb?=
 =?us-ascii?Q?I01SiF147bfIFDnjJbwki7ydiRzO+t2c8et36RbqJ9dqvMBdrTdfNLX3l+DF?=
 =?us-ascii?Q?tc0hE1yifCxoFMde2iPg2aPHmKU9GZ1+OFpkGA4Gy0BL6j0BxnjPhS5wEkQq?=
 =?us-ascii?Q?ayp0Zhfq/p0TQ4L1DepSRJb9AF11/4/k+50eUk7g7DD/QcXAPrtw3XKL3hpv?=
 =?us-ascii?Q?+LiR+8aA0EWSMhuArJWaKPc+Lm0YJ+EvbyYlcMZWhGtd6rvMyMLn/vR4xYXi?=
 =?us-ascii?Q?GuTrZ6z0qbDxQ8uSWid254/6e5mfJIqvdlC8NS6UeGENeLJdZpAIGye0jVzI?=
 =?us-ascii?Q?VG53QrDy2OyKo/h5Vg/MjlrtpkPII36APlDiz6Uh/tiAumfvbC6dx3MtsW7j?=
 =?us-ascii?Q?ULWq2tHoFZNu/OuKDBZahTglwEsztK2UoCZeiFoZ1It1tq+JJaqpyh7MpD9v?=
 =?us-ascii?Q?8DRE2z33TaMDPPAfylH9T79/fm4a5Nzh3v/gG945l/I2drnT0zm1ClOmKtFv?=
 =?us-ascii?Q?sX/ZuUWyRmdzFB810/13SqHdqCU6DOBNkLWlRyK53lJcvVsQsl7VGtMxijMn?=
 =?us-ascii?Q?Njp4C5Cb5zFCpCFvlDlHolk5pYlIhdPaVtuMPnJRaCkhPRCENxvv32++6V61?=
 =?us-ascii?Q?C0Pv19a9PtmH5ouVjh4NYTr5DdDfkfvg+za/UuFnFrMMIfcOLwlAHczSqEBZ?=
 =?us-ascii?Q?eD5jTt6nOC2+6OI/q9me0rVZeGpruncbb8AHaqFgb8s25iiE7KLi14kGIN0A?=
 =?us-ascii?Q?5oUBQEYJI3hdn03+YuBhTQtTiA0IyS9elSMyBslgJ7RKNBDbuaiqNDwbKfYJ?=
 =?us-ascii?Q?CQuADYhQwT4VLsGsnTCv2MFjbyFHaTyv7UCr02oxUktIPaBQrYqoOa0hU50K?=
 =?us-ascii?Q?1yCYTlrgPTUKUkVsqC1xz2zR6E15GAC8QD1SVC+YVnJXomHo9+Z8St0NGOSs?=
 =?us-ascii?Q?Or1CWXClHpgF87d3jT82oIXzgM4K4Du1jpLA8+nxEW862rlBajcjzVDq8XpS?=
 =?us-ascii?Q?865DsH6Z0MJqso7deBSsXkfCW+ax4MG740fIJ4dngWiCehw8lnO+V1HteEcx?=
 =?us-ascii?Q?0BCroyE0ijbjlgNdD5YqKbVf2Kjq9QF3nOa1vJulqfZT+TVRIRKkKTsh6d16?=
 =?us-ascii?Q?bo2Jxb4WV6JhtE4IZ7Z0vA9fmDTJ2IAD8d2G7sYqgz/P+DudlJMrVBt5iMHX?=
 =?us-ascii?Q?437ZZHqmoua5lFOl1y8P83dEYg0BTKinmsM4G4Tw4R8V7EUjpVcHec70RfC1?=
 =?us-ascii?Q?DbcdnJqGQSicH5JgYS0+Ukepl+hDIDVDvLdQOnUq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b55a7901-9891-4350-7819-08db3b39a2fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 09:38:13.6316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PRxr7RZ996gsIHDIubH/4FCnAVsKUJum2tv0sovVzacWG26cn1xooUv1ynQiIbwYdIFQ//8ffeNcuAzgrfNuIA==
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

HI

> -----Original Message-----
> From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> Sent: Wednesday, April 5, 2023 4:03 PM
> To: Horia Geanta <horia.geanta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>;
> Pankaj Gupta <pankaj.gupta@nxp.com>; Gaurav Jain <gaurav.jain@nxp.com>;
> herbert@gondor.apana.org.au; davem@davemloft.net; linux-
> crypto@vger.kernel.org; linux-kernel@vger.kernel.org;
> leonard.crestez@nxp.com; Aisheng Dong <aisheng.dong@nxp.com>
> Cc: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> Subject: [PATCH v2] crypto: caam - refactor RNG initialization
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
> NOTE: This patch depends on "page 0" patches, which are under  review on
> mailing list.
>=20
>  drivers/crypto/caam/ctrl.c   | 201 ++++++++++++++++++-----------------
>  drivers/crypto/caam/intern.h |   1 +
>  2 files changed, 104 insertions(+), 98 deletions(-)
>=20
> diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c inde=
x
> 9c5a035e1b96..852d538cfc25 100644
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
> @@ -589,6 +588,100 @@ static void caam_remove_debugfs(void *root)
>  	debugfs_remove_recursive(root);
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
> +			  (struct caam_perfmon *)&ctrlpriv->jr[0]->perfmon :
> +			  (struct caam_perfmon *)&ctrl->perfmon;
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
>  #ifdef CONFIG_FSL_MC_BUS
>  static bool check_version(struct fsl_mc_version *mc_version, u32 major,
>  			  u32 minor, u32 revision)
> @@ -609,17 +702,10 @@ static bool check_version(struct fsl_mc_version
> *mc_version, u32 major,  }  #endif
>=20
> -static bool needs_entropy_delay_adjustment(void)
> -{
> -	if (of_machine_is_compatible("fsl,imx6sx"))
> -		return true;
> -	return false;
> -}
This will break the RNG on i.MX6SX platform.
Please rework this.

Regards
Gaurav Jain

> -
>  /* Probe routine for CAAM top (controller) level */  static int caam_pro=
be(struct
> platform_device *pdev)  {
> -	int ret, ring, gen_sk, ent_delay =3D RTSDCTL_ENT_DLY_MIN;
> +	int ret, ring;
>  	u64 caam_id;
>  	const struct soc_device_attribute *imx_soc_match;
>  	struct device *dev;
> @@ -629,10 +715,8 @@ static int caam_probe(struct platform_device *pdev)
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
> @@ -768,7 +852,8 @@ static int caam_probe(struct platform_device *pdev)
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
> @@ -859,9 +944,6 @@ static int caam_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
>=20
> -	if (!reg_access)
> -		goto report_live;
> -
>  	comp_params =3D rd_reg32(&perfmon->comp_parms_ls);
>  	ctrlpriv->blob_present =3D !!(comp_params & CTPR_LS_BLOB);
>=20
> @@ -871,8 +953,6 @@ static int caam_probe(struct platform_device *pdev)
>  	 * check both here.
>  	 */
>  	if (ctrlpriv->era < 10) {
> -		rng_vid =3D (rd_reg32(&perfmon->cha_id_ls) &
> -			   CHA_ID_LS_RNG_MASK) >> CHA_ID_LS_RNG_SHIFT;
>  		ctrlpriv->blob_present =3D ctrlpriv->blob_present &&
>  			(rd_reg32(&perfmon->cha_num_ls) &
> CHA_ID_LS_AES_MASK);
>  	} else {
> @@ -882,91 +962,16 @@ static int caam_probe(struct platform_device *pdev)
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

