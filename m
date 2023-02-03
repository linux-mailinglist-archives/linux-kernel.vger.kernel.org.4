Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED2D688B90
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 01:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbjBCAMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 19:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbjBCAMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 19:12:19 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2085.outbound.protection.outlook.com [40.107.249.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1015C29158;
        Thu,  2 Feb 2023 16:12:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkepByXD72g8o3TLMkzXf9wBJbGejSlu41MzwmxcJ2aDsnsQIRvRGlOheLIGA1lMywldLgKYOgTqawCz9ExmPVQzH9r652xKbbnG04ZwMdSLl5rdcnfNJgoTvYpHa+yKP29PoH60zvkIOBCUktXjZqy8vBVqjZ5B5YFCsz/PSqyG2zh8faCBZJoUFGv/fX4GVsEQn4hBfIAGiHg92WQVmXtX1rgL/qOwmyhs0xC5iLaHgpzAtV5J8M6vHvfMwM8aWlZ5INaHiWD+qUnRdg+JVfMNrzEBCaA/gf+ljOWxCVPZKEw2Jgr3wl5JqQsrxBlVLQZlHPsjt7+pvTJ7Mk2V6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLmfRKmwBwAf+cxy8SMheREm78cCmGmQQpqHsg3ZAZU=;
 b=bNXIizEp7JUlN8eGoZZ5eIYdc11WSXuLrYVRgV3IanPDe8tlMTv0OGgUGToou9J3/S28J7YvNKXLSWDV8drLtLvndJjWvXl65nsjyiWJkKaD45vJ4Unkla1r8MKE2yvg6g0DO9n5y2l7HaKyB6wdTzZ52/Ou6Jeuv4G1Wwp57nrHF15kqff+zxNNrzzdAZRMjbw49TKXLKk2/03AsxJRu2V4KE6Nj3QucmcfwJjx3l6AW91W6ADflB/kyb79oT3pLyok+aah/WMgF3ZRC3FC+ezOEbTUhh/qCyW5zspja8HpzSphiuzDsGrEKmTAZ954ske69jrK72K9CbSW7+c5ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLmfRKmwBwAf+cxy8SMheREm78cCmGmQQpqHsg3ZAZU=;
 b=jIshPU/DQ6wxikguP+iFY8rtrJlr85T+UbxKX+vCgerbIPsvcaDXolUAsJQV0XnIHh99BhdjcU7ojdaqfrqLE7VYP7N+HUd7MEfIFEB1k1GyRVbozYrFyPL32FuqXMAByPQN76L+P08VxGnI277Acgz2zPJx/tToZn4l0oqDmFE=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7424.eurprd04.prod.outlook.com (2603:10a6:800:1a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 00:12:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3%9]) with mapi id 15.20.6043.025; Fri, 3 Feb 2023
 00:12:15 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "andersson@kernel.org" <andersson@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "arnaud.pouliquen@foss.st.com" <arnaud.pouliquen@foss.st.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: RE: [PATCH V2 6/6] remoteproc: imx_rproc: set address of .interrupts
 section as bootaddr
Thread-Topic: [PATCH V2 6/6] remoteproc: imx_rproc: set address of .interrupts
 section as bootaddr
Thread-Index: AQHZMjDLa30Jfx3KJki7iAzCkmrKAq68QKuAgAAhn6A=
Date:   Fri, 3 Feb 2023 00:12:15 +0000
Message-ID: <DU0PR04MB94178BB971E5107E907C743B88D79@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230127092246.1470865-1-peng.fan@oss.nxp.com>
 <20230127092246.1470865-7-peng.fan@oss.nxp.com>
 <20230202220557.GD1147631@p14s>
In-Reply-To: <20230202220557.GD1147631@p14s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|VE1PR04MB7424:EE_
x-ms-office365-filtering-correlation-id: 1670733f-a315-4ffc-f800-08db057b4e31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TKLh0CyCapRYSxmiWbuoTc8MuTtTa1Y6kauqCVTRtcjNn4QCek8165HaIvdYL11FId4qUOQI7SZgyedfW5OkDu+9XMMfH2Qg6rFH2qzaSOWvI0OkzBRhfhS8mBM7W5N9V6lBuczzevQKQPzTk9drn4JkQhRk1z6kzpAo7O8qeYZQdC+ZDmzzQROCjWtLx880aCI6OZrIigN0zItTmmgi3WAqBeVzK1aPMFvUyhqOHn7idXBOmfMnGtWMMH+SQ9iej2hjZAxaWDHS6co+QBTJNNIfDm8E50wYIJ//AYP7PP4JfZeb5/a1ECZPsazRLJ76CDHVzdWbKN+/ZxfyNtStW28YYaICOSbRX6g4CVWTll+dQUITVgcxusRjNogmOTUmsjJwKS/Q2py3FWxxRpNAp80lraMiE+KjL+/IAcOmhGJIZB0Pu2r3qzoJjIx5Ei1UgBbdJw9SRBSTU5pmUo6IM3LIY8NCnm1dsbqTwCmKmfUYctHr/Dj+YyU5g6uCFo5J10E7hRkQA1z0cqvDw6AG82r0/ysnu48ENkCA4gAuDKIdtpjKf2fBtJtcClTadLKiiYze2yYffvYwpufDYa4SKJ4mbwZUg5lf3FhvNOuqitgzwAMLX/ZdY2oPCYMKx3ptT/7ZnzeSfubFdekY5t2v6hNpPPmDu/SLbLwz9Ww11YXt3v8ESkVv4S6SnZurSDa4b94Yqfzh05egY3iJUzL5Sf8xxBTRqCT1qr4p7jkMOgM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199018)(38100700002)(86362001)(54906003)(5660300002)(7416002)(316002)(110136005)(83380400001)(38070700005)(122000001)(33656002)(55016003)(52536014)(9686003)(7696005)(186003)(26005)(2906002)(71200400001)(478600001)(44832011)(76116006)(66476007)(66946007)(66446008)(4326008)(66556008)(8676002)(64756008)(6506007)(8936002)(41300700001)(142923001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F5+Mxw9ViJYnQAg7Z/t6WFQdD3OiMNEDkWEETsshhN7OAnTrRVyN1I0W2y35?=
 =?us-ascii?Q?fFppinVavuCQquooI3KsJOYyamtJt8N+vshRAdsNH1EiFCrG9y6NjTrF6XcD?=
 =?us-ascii?Q?rm204j3g3Os9h1qc9/JH1Dj9FUg/TJh6cwj7SuSNGWkM5XA0RBVUrFmPSDHA?=
 =?us-ascii?Q?IHTrxxkVUWPabFRKiGp08WfTDIsn2i+Mz1uLG4kG4tW69Rpo8fdhgRFj0y6m?=
 =?us-ascii?Q?4PuhUjJ2dEqrCPMLCJlGYvSYC8dsaGic+lYR3AdnzY+wmd5QxVInu/p+0as2?=
 =?us-ascii?Q?DWwxpupZmE6b+rFPtQPPHR41vlWQr4XYRdDADAwOHYsUb+r2u4YggbqQfsZg?=
 =?us-ascii?Q?25CBuI0QmUVl0rXeoL3GtemLgYRO9yKOd3RIpvN0s+gXmXwVWklYPu87G/9q?=
 =?us-ascii?Q?4jNklDp0Y2sEOR0WNUqDnPyWZTXQRZzPiOxU14MOrBcHpAsyrwAHxpPKhdBM?=
 =?us-ascii?Q?Pd8IaoXKqtUfN6vV9I5qQ/RkNxx/oUyem4r5Gnfump68KI1k9H8I/IP+7V/j?=
 =?us-ascii?Q?DTUQtE00QaflUQXgLDRgzae7fhJDtrj5DPJzqgt4oJymop3ttYBSv8Skm5Bd?=
 =?us-ascii?Q?1pp3QaxLY3jPgstPZwcUEwalnRNpS3rKZSpata0ZG/hSZVxKSypc+nqokUox?=
 =?us-ascii?Q?p5/k7n22JerSQdD4tLtT1e8oSMf3zhlXkIDLp1XTqnr8jjeQ7ZJ+2zBy+mC6?=
 =?us-ascii?Q?mGX5HI/x3fJ/ujioqISU7I9Oy6p8dB6KReqyLg/VibduFEQZBeLyEWb+SRyB?=
 =?us-ascii?Q?Lsg5MlKg39pt5jSZJTRf5a7IMicOdT/qplcOvJtyyn+imk3bqUiRUmquBt+H?=
 =?us-ascii?Q?AXGjsyZQ832FHdzy+BdQMjma9Tnn/hk6DAFvDimkBiIYpJHr0WtMWm6b4QYT?=
 =?us-ascii?Q?yp1ZHLiWONQavoAQAG2PhKFYf1peHQzmBy4D4YhGNX2dzd3baT4zs7QWdbsr?=
 =?us-ascii?Q?JtygfAYET+jvWqIghIpMjqgteZwJnRplKTkEXp9WppI5C+4cq4qSat2au1it?=
 =?us-ascii?Q?PLwUS6dSp5OPSKThIuPbaO24t0KdOroQsy1A4j/b6hR8Nul2JIHZwRuDD1Rh?=
 =?us-ascii?Q?nQjO12+kYViDDJX2pV64nfJvuS9+Rv0ALEQY6eUVN+hvtGQZ+ZoC091f0p6u?=
 =?us-ascii?Q?GhXJEV1bsgBAPte4Rtx4Ec/J9b3LKTEQ/OPQIrClW8eSNaKzgO33MChE2uFK?=
 =?us-ascii?Q?H6IH1pqMdmbu2lIUdGSEEbrzJgkeienvsAuABgyy853bT92IkU4a+o+XswUY?=
 =?us-ascii?Q?sEe9swDg8Fm8dHSBvUuoN7UNUnsot5hzAHmyXiKAwiJzYxM8dsITVxtK2OjL?=
 =?us-ascii?Q?AImPWg09EiPmNtuXHTpKq4Nh/WljbQRQHju2wWDszbnLzCOyX8d8dipbK+Dj?=
 =?us-ascii?Q?rZkKHHDaxPAQSTOacpz2F5HGE6EBdmcjN2YCszV6xHFXGiHbNLKbo50kfdEa?=
 =?us-ascii?Q?9+tgJ8Uur1ULx35oY1L1e0hcgZAbpZkpv9kDChvmQNW/hwAToQ3IacHIKNLR?=
 =?us-ascii?Q?xu0/8PT8vIOeotixW1AUuDQGgoqzfKySdtHK7oXowfJ7ejit8EIHLJTmLnmC?=
 =?us-ascii?Q?zSBWENBe+IzHN1mW/yQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1670733f-a315-4ffc-f800-08db057b4e31
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 00:12:15.3446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K6PyeqKSK50aGAC/czcd7f/VR6rtVoyb2/pBKAUjbhrmCpfmsspgQ28N0U5uQs6z0Sadx9NjRjUPn9759AmL/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7424
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V2 6/6] remoteproc: imx_rproc: set address
> of .interrupts section as bootaddr
>=20
> On Fri, Jan 27, 2023 at 05:22:46PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > i.MX93 M33 has ROM, it needs the ".interrupts" section address to
> > start
> > M33 firmware. In current design, the Arm Trusted Firmware(ATF) use
> > TCML start address when the 2nd arg is 0 when SMC call. So When the
> > M33 firmware is built with TCML address, it works well.
> >
> > However when M33 firmware is built to run in DDR, we need pass the
> > ".interrupts" address as 2nd arg to ATF to start M33 firmwrae.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/remoteproc/imx_rproc.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/remoteproc/imx_rproc.c
> > b/drivers/remoteproc/imx_rproc.c index f5ee0c9bb09d..59cca5ac3045
> > 100644
> > --- a/drivers/remoteproc/imx_rproc.c
> > +++ b/drivers/remoteproc/imx_rproc.c
> > @@ -374,7 +374,8 @@ static int imx_rproc_start(struct rproc *rproc)
> >  					 dcfg->src_start);
> >  		break;
> >  	case IMX_RPROC_SMC:
> > -		arm_smccc_smc(IMX_SIP_RPROC, IMX_SIP_RPROC_START, 0,
> 0, 0, 0, 0, 0, &res);
> > +		arm_smccc_smc(IMX_SIP_RPROC, IMX_SIP_RPROC_START,
> rproc->bootaddr,
> > +			      0, 0, 0, 0, 0, &res);
> >  		ret =3D res.a0;
> >  		break;
> >  	case IMX_RPROC_SCU_API:
> > @@ -664,6 +665,13 @@ static u64 imx_rproc_get_boot_addr(struct rproc
> *rproc, const struct firmware *f
> >  		 */
> >  		writel(*(u32 *)(elf_data + offset), va);
> >  		writel(*(u32 *)(elf_data + offset + 4), va + 4);
> > +	} else if (priv->dcfg->devtype =3D=3D IMX_RPROC_IMX93) {
> > +		/* i.MX93 Cortex-M33 has ROM, it only needs the section
> address */
> > +		shdr =3D rproc_elf_find_shdr(rproc, fw, ".interrupts");
> > +		if (!shdr)
> > +			return bootaddr;
>=20
> This contradicts what you wrote in the cover letter of the patchset about=
 an
> ".interrupts" section always being present.

Yes, from the initial beginning for supporting Cortex-M firmware, the secti=
on
is there. I just think whether people build their own firmware, not has
this section, and just put firmware in TCM, there is no need to explicitly =
set
word 0 and 4 again. This maybe a fake assumption, I could refine this piece
code.

>=20
> There is enough in this patchset to make me look for a second opinion.  A=
s
> such I am CC'ing Iuliana and Daniel.  Please respin this, adding both of =
them
> to the recipient list.  I will do another revision only when they have pr=
ovided
> an RB tag.

They not work on other areas, not same as me. Anyway I could ask them to
help review.=20

Thanks,
Peng.

>=20
> Thanks,
> Mathieu
>=20
> > +
> > +		return elf_shdr_get_sh_addr(class, shdr);
> >  	}
> >
> >  	return bootaddr;
> > --
> > 2.37.1
> >
