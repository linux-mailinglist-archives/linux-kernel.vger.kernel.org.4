Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F6B70061A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjELK5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240373AbjELK51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:57:27 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0EE72BA;
        Fri, 12 May 2023 03:57:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=App7Rw24gtCWPDZBod1OZHbqa7sKk7+lC2YAzpyc9um4YRjz8Ei0uCXQYY+9/G8SvfFIb+Wavczxi83Km4artyOXaHpVFHpia8KWkHCgSnB4iPqLFAoJDPgPa3pAkwR+7+dOV0hVMJ04rgQMxqElK21y65SVE8I7JKrmIqEeQx5XoAC/hD1i9uwg/Ei545QEi+BkX+5JdQ2nJQBAe90l4svC/IQCeM/abhxf63X0DGR+9VF+6KAQeDGIwCC6zgYi1CIkseFZsd2tpCZYjPBfBMQ+V+niWMu3Uk/x5i9kHkJ4wZ+MRf1ELHHSXLhYDxQm/ApcfmQC34dgMA67SbE1hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1f0FhVGjBOIhbJ7aj28PfDuTLXLA9kWzTmw5ennM6s=;
 b=L+IaPPftGhcxi7lrnKk8UEOpxDY5IQvAA8YJhrvaS+DTUyrAVpjqOiZHoeoXGuRht7/0Y03lpQB1UyUW2msAdvuzGscjzFNgBaE66d+y7gJg3kb36a3XDWwse6aFGgO3ITmSNZIz6MYmPJB5Gt/Ubdc+kiWoJqVeRA819/Nz826h0v1KhqA4g6ofGchQ2UuOu5IVD7F8hB3PJ8JabMJ+fu+K+gWBzCDjc9h8FaluIonhQFA0mC2poWVu2FdTNKbM5+VFJ46mPrg3DWro9iGhmR/kHvKmdVlVeJz22Qz1w9TMJ6cwm2u+qDSHYPyHfkPAl5UEj98HRNkWyJei0nyWDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1f0FhVGjBOIhbJ7aj28PfDuTLXLA9kWzTmw5ennM6s=;
 b=eDx2QmqeL1EnikXh53++xrTUCxO/K648TxGcXic4Xxscb/20Jzu+FAYgkeAJAeFUKtoJpiax/wEVZIuGahTJyXsfvM7wTy0NR4iavzbYMM+ksbUkT2xWklsxDgAwRfuCQ8neSB4ewRrN6UKeFHhOW03gFnggrrIHsyGdeVpsPnw=
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by PAXPR04MB8142.eurprd04.prod.outlook.com (2603:10a6:102:1ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Fri, 12 May
 2023 10:57:23 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::11:5194:1418:6a75]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::11:5194:1418:6a75%6]) with mapi id 15.20.6363.033; Fri, 12 May 2023
 10:57:23 +0000
From:   Alice Guo <alice.guo@nxp.com>
To:     Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: RE: [PATCH] caam: imx: fix the built-in caam driver cannot match
 soc_id
Thread-Topic: [PATCH] caam: imx: fix the built-in caam driver cannot match
 soc_id
Thread-Index: AQHZhLXpMVK5RXmzBESb3LpnLeQPia9Wd38w
Date:   Fri, 12 May 2023 10:57:22 +0000
Message-ID: <AM6PR04MB60535A5DB643B8A5B07E1C55E2759@AM6PR04MB6053.eurprd04.prod.outlook.com>
References: <20230512151033.1327643-1-pankaj.gupta@nxp.com>
In-Reply-To: <20230512151033.1327643-1-pankaj.gupta@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6053:EE_|PAXPR04MB8142:EE_
x-ms-office365-filtering-correlation-id: bad479b2-d855-4839-ffdd-08db52d7aa31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xn5F0uQxiQnhUmaiX+HGYDGrXny+NQPxcNa2EOwUrY4wrLAe+MVrfs3NMkvIpZeHfrmkW04v6GGVT2HquatWyC5oEXLZvCv5FLUrgxLFKqehrJ+0uhGyXfCiCYFlsxDDbuM1V1mmrOk2T60CH8hk20oEwTvjFtSh5FO3T1JyPVrjaBvYNL8+sBRAilFuw/mR7lguxHHP6KWmuz0rwOuprMPy3QWc9CHrh5WLeyeqRBWYcaJWNnPUdSb9nW9Bi35TyszwiYPghNbYinWD2Nzj1r1x4gKlzunbKj4hc1InqIZJ8JFSMohljTjGCab/gNXk5qRQ58lfxRN0cMcjk0/lzltsEPcnRg1X7kOXokmViAi865yR8txcc2YzjLvvThBx0qX3zbuw5JqqlFoIccSrkqNwdW/smdnWh60HiMXzwR6Awl8nbhzSTF7gQAITrHfdFtmJ7modJ2nvx6cCo3ZIGJ09rnLMJ+IAg/EkfhHqVWWzjj+/rlj/jA8G6nDkO9HV3tX5qRcLGK4817tqwBAddRzUh/wwleWMBTKpdyoujVC7NJJJVzqdWPDAeXR1S+0gCQ2lcbWNKD7YO18URPvwSvOlNZXM/fjm48UUJvIhiQforffUi8imO7tq7R3jdcq5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199021)(55016003)(54906003)(83380400001)(110136005)(86362001)(478600001)(6506007)(26005)(186003)(9686003)(53546011)(71200400001)(8676002)(7696005)(316002)(8936002)(33656002)(44832011)(52536014)(122000001)(5660300002)(41300700001)(38070700005)(38100700002)(2906002)(4326008)(66556008)(66476007)(76116006)(64756008)(66946007)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6ZNfaD+/0gHrU2L1mlZm7SBAEdVnVoVJb0NrZ4Qcr0L3q5Irs4w5Wk8Cni5q?=
 =?us-ascii?Q?dV2vY3+XO0O07H2oPuV+Qlx+OnkRiAdkg9sQW83rMzVtBYR8aJiHA3WE/PEG?=
 =?us-ascii?Q?aOJRUcmgMhItlfhoar2DAjcxiPGlggGDfcwBUKK3l4Fi8Wu2LYucigPlT9JW?=
 =?us-ascii?Q?EU8o38uPh9rBPiKSzF2Lo3cWVL7MFyAq6Vo0r/CkywAltYqcR4XdJInceeG5?=
 =?us-ascii?Q?XXA5L/zrxz+14Z5ALfGit/JyPmjzO6Vw2tgBPdATsoHJqe/LmaowSluhxrTH?=
 =?us-ascii?Q?q+NyFISoLUf7zEXLvSzjGZ7/P8S6BTlwQE+9F4tVE48+xLzaeyX+QN99WDqy?=
 =?us-ascii?Q?MNb6AuNR8z08I8kDdnRypc/+R5gNMN8PfRmrHMvtUEJ7wja/iJseI0yuLv9O?=
 =?us-ascii?Q?iFkvGWMrnMqnJawZ9tKBtEPP4i+tkE2MVWcrUCFgNEAAtX87dleHczfqXNUK?=
 =?us-ascii?Q?ETM4CVgcrOA04fkA2SeKSLSXmT/dBgpP03rW61qzDSPn0ruaO9whAcOoRgSy?=
 =?us-ascii?Q?ViVy60NfKGonT3sHjZxslJpCHwVMEmEe4x6paKd9TJ/Eiuvplw9mRREHb3q1?=
 =?us-ascii?Q?v5inlKbf9GCtHVg118Cd2pEvdSrPLbupVSkH7YyrhpmdXUcHvxx2da/QA+lQ?=
 =?us-ascii?Q?79wqp6YU3mRnpJTgpcEt6CYz82caZuuLjS1TRzcumnFIu+thsh4BOZjDsZF4?=
 =?us-ascii?Q?lTwZM7CThv19WADMRcf/rrHd5zTU6BN2n14stm2RREehqDUX3BJTEjWdFIEh?=
 =?us-ascii?Q?hzbO5E1CLHf/Tc3pwtsKk2LK0ymI91NkwMAoxgnCEOr9B65cxOyikD2fWiPJ?=
 =?us-ascii?Q?ByecL3IBPjBRpTCeRGez8e+DYNvdmkj9kyJtcBfeJe+jt0XEsJGGmcBK+dBy?=
 =?us-ascii?Q?pYQ5TDMJyy+PPd4jbamZcdl2l27cABwrg+Ax79j1G/FLD+M4EC1qIaFNlqs/?=
 =?us-ascii?Q?RXqE+Kku8oVRnJ9KyuszXhQgb8e8FY1onJwPJX/FSiALLOWQs7FVI0myAYI6?=
 =?us-ascii?Q?udwPDesa3PFb6TjTt/oXj9M7eL6ZhNohIhiSF5SLcrSpDKEF2YgDHD6iry3c?=
 =?us-ascii?Q?dw0AX/WCjehlIcRPHJhFpIj2li8SZqjgcQvPy+QwzsNp4wW7SUU901s6Go0c?=
 =?us-ascii?Q?zayeCxIFz9keWporJZGbkIk5KqiF2aAF8BJWOFWxvCY6MOaXaz1pE0yxLEIE?=
 =?us-ascii?Q?jlFiUkK1vMr2LNXKvH3oPaZqwoa0YY0cc8pWhDjQsgIJY+gO3Am6OmoxBaus?=
 =?us-ascii?Q?6DR9M3y4AvVaz4e3p5tQcECt9HSKSux906yYL0xsDmm3LeG764KcH+XF5i/o?=
 =?us-ascii?Q?BH8wOome4ma8JE77ToJOaOG/YFXnOHYaaUB5z/NYofs+FdxyB3mj117iTFdN?=
 =?us-ascii?Q?+OAOgNxbqTmgZHWBEmLswto0u/DdbK5MBEEauK+0z5akXnpDLuT4d4DVaKCD?=
 =?us-ascii?Q?ybfYiaj08Hycwc8QtjKFYYrk/h+ezwdiJfCaRRvo5ELImEJ9gueej8Myr4eq?=
 =?us-ascii?Q?x3KeaAmql4DghmQQ1OYZOp5nYCXrO2JET/+moXvPYHXDb1h9/f0m1cHGfHwt?=
 =?us-ascii?Q?+l3dCzxEBUUGIaZ3aCs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad479b2-d855-4839-ffdd-08db52d7aa31
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 10:57:22.9425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LQw6TopT8/gprDvUxm2hlHGFHtiKuEZHWSPptcWNyAzm/F5Vsue7SNL5swwPgU+Q/8Rm5+D+uiteM8SQmB7ZFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8142
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Alice Guo <alice.guo@nxp.com>

Best Regards,
Alice Guo

> -----Original Message-----
> From: Pankaj Gupta <pankaj.gupta@nxp.com>
> Sent: Friday, May 12, 2023 11:11 PM
> To: Gaurav Jain <gaurav.jain@nxp.com>; herbert@gondor.apana.org.au;
> davem@davemloft.net
> Cc: linux-crypto@vger.kernel.org; linux-kernel@vger.kernel.org; dl-linux-=
imx
> <linux-imx@nxp.com>; Pankaj Gupta <pankaj.gupta@nxp.com>; Alice Guo
> <alice.guo@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>; Horia Geanta
> <horia.geanta@nxp.com>; Peng Fan <peng.fan@nxp.com>
> Subject: [PATCH] caam: imx: fix the built-in caam driver cannot match soc=
_id
>=20
> Since, CAAM driver is probed before soc_device_attribute done as part of:
> - drivers/soc/imx/soc-imx8m.c   (for i.MX8M)
> - drivers/firmware/imx/ele_mu.c (EdgeLock Enclave kernel driver, for
> i.MX8ULP)
>=20
> It is needed to return -EPROBE_DEFER, after calling soc_device_match() in
> drivers/crypto/caam/ctrl.c.
>=20
> soc_device_match returns NULL for:
> - i.MX8M
> - i.MX8ULP,
> can be considered that the SoC device has not been probed yet.
> Hence, it returns -EPROBE_DEFER directly.
>=20
> caam: imx: change to use of_match_node in run_descriptor_deco0
>=20
> Providing imx8m_machine_match to match:
> - i.MX8M{Q,M,N,P},
> - i.MX8ULP,
> so as to start using of_match_node, to simplify the code.
>=20
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> Reviewed-by: Horia Geanta <horia.geanta@nxp.com>
> Acked-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/crypto/caam/ctrl.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c inde=
x
> bedcc2ab3a00..d8c528363f10 100644
> --- a/drivers/crypto/caam/ctrl.c
> +++ b/drivers/crypto/caam/ctrl.c
> @@ -79,6 +79,15 @@ static void build_deinstantiation_desc(u32 *desc, int
> handle)
>  	append_jump(desc, JUMP_CLASS_CLASS1 | JUMP_TYPE_HALT);  }
>=20
> +static const struct of_device_id imx8m_machine_match[] =3D {
> +	{ .compatible =3D "fsl,imx8mm", },
> +	{ .compatible =3D "fsl,imx8mn", },
> +	{ .compatible =3D "fsl,imx8mp", },
> +	{ .compatible =3D "fsl,imx8mq", },
> +	{ .compatible =3D "fsl,imx8ulp", },
> +	{ }
> +};
> +
>  /*
>   * run_descriptor_deco0 - runs a descriptor on DECO0, under direct contr=
ol
> of
>   *			  the software (no JR/QI used).
> @@ -105,10 +114,7 @@ static inline int run_descriptor_deco0(struct device
> *ctrldev, u32 *desc,
>  	     * Apparently on i.MX8M{Q,M,N,P} it doesn't matter if virt_en =3D=
=3D 1
>  	     * and the following steps should be performed regardless
>  	     */
> -	    of_machine_is_compatible("fsl,imx8mq") ||
> -	    of_machine_is_compatible("fsl,imx8mm") ||
> -	    of_machine_is_compatible("fsl,imx8mn") ||
> -	    of_machine_is_compatible("fsl,imx8mp")) {
> +	    of_match_node(imx8m_machine_match, of_root)) {
>  		clrsetbits_32(&ctrl->deco_rsr, 0, DECORSR_JR0);
>=20
>  		while (!(rd_reg32(&ctrl->deco_rsr) & DECORSR_VALID) && @@
> -646,6 +652,9 @@ static int caam_probe(struct platform_device *pdev)
>  	nprop =3D pdev->dev.of_node;
>=20
>  	imx_soc_match =3D soc_device_match(caam_imx_soc_table);
> +	if (!imx_soc_match && of_match_node(imx8m_machine_match, of_root))
> +		return -EPROBE_DEFER;
> +
>  	caam_imx =3D (bool)imx_soc_match;
>=20
>  	if (imx_soc_match) {
> --
> 2.34.1

