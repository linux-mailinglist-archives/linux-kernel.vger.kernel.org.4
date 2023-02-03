Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADB3688B5E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 01:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbjBCAEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 19:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbjBCAEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 19:04:35 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20626.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::626])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45912332C;
        Thu,  2 Feb 2023 16:04:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbgU6OaSBDzTLZUzbbwMieCMz5fV879KquE4Gv5wr1BbNQiYfgxd441z6W6jSIyshVwRJTykdZMcO0bylSQvDRD75h85sGxNJQb+7dAplUHwYi5rTD3KhgYqEFM2zje1RFktK9zq19QeM4Qxx6WbKzcJ/6ep49sVi5pY9GoUiI9GHJaiS5yURTZyNsA88JhsWh7qvjE+fQzsKAD92LtapxK/5f+MYb0/j8nl70J871JdlNzo3HhPa9oDox+3JGc+wiIf3xc403PjuHdMmTgmHxD2f9x8MJNGUqKgfH8nfe9vQV2vFmreHfgOgltgxtujWhNFEkv1CaCSzrkuf5gK+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQBfP7QQjKIG0o3Pg9WIkZVuXKxrDOf0OgFZeVCbQFg=;
 b=acERzL19PF9ERCD3lv9HiuWYEeR9oX5Qxf20TF8WFhy4zBjn33Ir8KpactpBZ9i2Bxo4Q5qRaPoQXNIIJnWp6nfB5V0RXKqXS1ow//1jMoYZ4UoOz71JHl7Kxp+diERdOyU6iOAIEqQPUbOdzfPry2tQJzvUiXy8wrnlITWN6on1Tb9qKBLFwM5x+FtOZ42Z7BmLHvx5STofAvzC1veilLx3InxqIRRYXKSagJkya5SJ7KubGrk0HN8+OHpMFoEuy0b0eN5apjhoXGsKQ8Ht2ARhJgNkui9KOxhXxYx/7AGFKGENKabc16ar9JLeK9swkpdculHwhl2Rq+IOQ5NHHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQBfP7QQjKIG0o3Pg9WIkZVuXKxrDOf0OgFZeVCbQFg=;
 b=su/K7Ln4hkRVlfwYmy7EYXcrAYJ7z4QM7GEPVpdKb/csocy3E57gkaiWUhy9XisOR78PSApf8tAL+JYT3XZkgecFp9cedd4TgCKmkF9HQuqNnYWUYsI36v8dP4nmkXXubl/AfQQN3k4lVkSYmj7ofqJ5MIoyQZkiN1dY9mOmiUw=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8176.eurprd04.prod.outlook.com (2603:10a6:102:1c9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Fri, 3 Feb
 2023 00:04:28 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3%9]) with mapi id 15.20.6043.025; Fri, 3 Feb 2023
 00:04:27 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 5/6] remoteproc: imx_rproc: set Cortex-M stack/pc to
 TCML
Thread-Topic: [PATCH V2 5/6] remoteproc: imx_rproc: set Cortex-M stack/pc to
 TCML
Thread-Index: AQHZMjDJzgt7cVgC9UWv0kJgugWwrq68PgaAgAAiy7A=
Date:   Fri, 3 Feb 2023 00:04:27 +0000
Message-ID: <DU0PR04MB9417620B668E43118933821388D79@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230127092246.1470865-1-peng.fan@oss.nxp.com>
 <20230127092246.1470865-6-peng.fan@oss.nxp.com>
 <20230202215629.GC1147631@p14s>
In-Reply-To: <20230202215629.GC1147631@p14s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAXPR04MB8176:EE_
x-ms-office365-filtering-correlation-id: e0018c0c-bfdf-4456-816b-08db057a3767
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +kjSK0Shu2JpbiSUaOhBLaVqMAoASJcnpun5niu91nNNZeOzZrfOERQnUZ6so9kMvf6F3/7u+bNuu0CBapCgsGTbN5MY8bvX2++oFVg4gfIgaDjNasmrQElN8qtwy5JiFKJmmUj614fGtwFXhQ6K5kvQO1yRPOG1klu3/9tkDNgUW+yXMmSsfZF32QLHOgW5Is0BHsPIgyBC0fb2CnLMzFPeuE3EqJqHc3NqfFn37goFv/cOhZFECi9Ssanbe9O4zI+3mM/08f1ZhOQb7GH8YaRIz4TALtTSI/nbiBOw11UEC1jS+4u4UvSDdI72B01lEgqFjR+BzrxmO/OOmhLy7YSRxGoIn2J+P7O8OuGKBE1o5kuoW2KeMZie8SXRpaq7107YSZU8OCjhsu5sTryi1LyAKW/5IIujiszhLfcqHSjAGHwQhGhTSMJNI8nWpbJ9M9RI+O/PLLwP0btajLqSeKEmSIYjcfkr6JrOQNTXTZEZVpvenMfbX0Lfw/bcZXFmZrMzfneWPOw0fh0OgRR/Yi+69FQsWAwmaUoraUx7sdYF8po2eIPNC8ZVFdLclEFLIpGhSf06m0GGYRzPirLPxnJGYqJxahFV7W4xsO7dmk6Gjxv0kqzXweH5MJHs/BaYqdAnBYkEbrOJiannYAa7Rkus5fRuOapXARUapauh2bGgprt5HsirCiaWkzSId/p2R6osXbAAf5ZIIfj0uy6t3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199018)(316002)(52536014)(186003)(9686003)(38100700002)(38070700005)(26005)(83380400001)(44832011)(54906003)(55016003)(7416002)(5660300002)(2906002)(33656002)(122000001)(110136005)(6506007)(478600001)(66556008)(86362001)(66946007)(66446008)(66476007)(71200400001)(64756008)(8676002)(8936002)(41300700001)(7696005)(76116006)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lWm63t75sN0usCiFsX68FWID7uSaBM9OWQMl7IMUaA1x1RAJWtM0bnoHK7Xi?=
 =?us-ascii?Q?2VhoGYFOIJlGl7Z9MegjULxXn8OwVid1M7eG5wvBkc51oMAUxzLMVN8Mdmfv?=
 =?us-ascii?Q?8pEyMQryuOlGmTKtyEP8YSH+Xxk2R/V5WoyTg5g+5itemURJZWq8iWA4bN/2?=
 =?us-ascii?Q?scC386ZacY8tzkiSAQ7vvv1PHAZEFjIGXeclKL1uDMefhBrjAZf61FZMF0Ql?=
 =?us-ascii?Q?fNMIwAK1UXKOFtINYsn/TUaps7czu1Vu2ZmoO2WdiOSpAFPNJBhVhjRNX3By?=
 =?us-ascii?Q?8FV/9PlaVccX7Oi3VbkZaEh8KwyoTIC8KPa3dDArNL82HJ8m2TEwQVopioo3?=
 =?us-ascii?Q?6ZQgMDhDbrDkJ1xhXioBn0P/IUOj8XNZL/d5LQkVnVexw/2nxN/o4EfN14FO?=
 =?us-ascii?Q?0ItCO+9C6EmuwuzyAbxRvFRC6txfTJf9TIMb4ns/Oq6Myneai5KFmcPG049g?=
 =?us-ascii?Q?cywHWXLqKkzMol0RxIe7pfS3AnhxnnkONb2s3ZZ7BVtBJESsa/ESZa7po/ng?=
 =?us-ascii?Q?Mod6wnyjyRVEvu6GefqfFyNBhDBFtar1MyGCEgkqinvUCWoXOJ8mjQ4XfuLP?=
 =?us-ascii?Q?U4EUf+9TFCVLfEA7iYw+KClBdEvUBPeRJsbclEDa+wTri70aH9WOK8Wih8pE?=
 =?us-ascii?Q?6zyPLdqR9Gu74t2ocPAAp28Zq5MoGK4tWgqd4/taInhkYJlqzKtQFYrrRTmV?=
 =?us-ascii?Q?ZaAmRLG2bg7ONpZ4p8kXXdOSMEkSrPiVzRRm+r2xEdbLqz/rYlMBI/+0h8XB?=
 =?us-ascii?Q?oaLrR+4jhZmV6lEa66hFg66blrVP5/lPRCrQVyFfdx8pptpb0KQnS/UnCxf5?=
 =?us-ascii?Q?/fteoMt5q0y+okY8mftBq+RqALo+fnLtOKdP+0iY5pKrOSDzyNBkhj1rjN1O?=
 =?us-ascii?Q?KU1V+GuXs57XC52Ze+Rv4V1LoiWAXl58XiK7pFNdQY9fO77eujk6nd8BYZNM?=
 =?us-ascii?Q?PDEKWWVQxOKA6OwJDx6AAOzpe0oP2/10hTosClnzcKcZrwaOKZmjcYEIrvc7?=
 =?us-ascii?Q?0kSqCsi84cJQ23Cvxyd2pcIq6uxX8u7ynVe6DvCkC6o0iX5iXQpq8zhCLx5l?=
 =?us-ascii?Q?y+o8B0D6qR6c1SXLWzO0nUvmdneukc8pjazjXtOzYpA+nP1gWtXABEFWJmPO?=
 =?us-ascii?Q?2RvwI9Xd6G7qaN3dA5Np3h19MYX+NhTg45Q6EUUKTTLaWQ8pCtnQ1nRk+4Ik?=
 =?us-ascii?Q?erpB8wtqkpZaCT4APE5VasxjzcEIxsQYSEvj86OJcb2DoC6Wm3jhjvWi/14o?=
 =?us-ascii?Q?cVY+2zCCq5s7Z2HHEIYGmffL5SEN5ZEC7Ojhp9vmP6/2Ln6vZny+Od8WlM5h?=
 =?us-ascii?Q?IQR5hquJMoT4IUlEFrKViBN37rIgoy92wUb6914HRXXH8as5bNk48ks9e4v/?=
 =?us-ascii?Q?o30ofi8+kv4YQXkUoUa53YCPL7fwSzOAZrKEZ2p3FLKCcLj6cw24hJOJo3MC?=
 =?us-ascii?Q?ibcUSAVduXcJo8+bN9l0nTgomU6zGiRMsChjggcF0lvKp1vcYMUJZ6haWub/?=
 =?us-ascii?Q?NBgjtU7hTfjU+kUfUMjA6m2WkURTNF17yFUcq8DA/La4mubLwwHuIa+Mm5IV?=
 =?us-ascii?Q?bkB1HK+xXhi5gtXRblw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0018c0c-bfdf-4456-816b-08db057a3767
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 00:04:27.6580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o/oobiCrnqqHWfOissi/jpaCCg0JT9gnHNbAjL0ONuZ92UyIdYB2swGP2ghQAxlL4OZIrIMYj8i78Su7MUa3yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8176
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,T_SPF_PERMERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V2 5/6] remoteproc: imx_rproc: set Cortex-M stack/pc
> to TCML
>=20
> On Fri, Jan 27, 2023 at 05:22:45PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > The i.MX8M Cortex-M core not has ROM. It has a requirement is the
> > stack, pc value should be set in address 0 and 4 from the view of
> > itself. From Cortex-A core view, the region is at TCML start address.
> >
> > The stack and pc value are the first two words stored in section
> > ".interrupts" of the firmware, and the section is the first section in
> > the firmware.
> >
> > When the firmware is built to run in TCML, there is no issue, because
> > when copying elf segments, the first two words are copied to TCML also.
> >
> > However when the firmware is built ro run in DDR, the first two words
> > are not copied to TCML start address.
> >
> > This patch is to find the ".interrupts" section, read out the first
> > two words and write to TCML start address at offset 0 and 4.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/remoteproc/imx_rproc.c | 37
> > +++++++++++++++++++++++++++++++++-
> >  1 file changed, 36 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/remoteproc/imx_rproc.c
> > b/drivers/remoteproc/imx_rproc.c index 295e0e0e869a..f5ee0c9bb09d
> > 100644
> > --- a/drivers/remoteproc/imx_rproc.c
> > +++ b/drivers/remoteproc/imx_rproc.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/arm-smccc.h>
> >  #include <linux/clk.h>
> >  #include <linux/err.h>
> > +#include <linux/firmware.h>
> >  #include <linux/firmware/imx/sci.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/kernel.h>
> > @@ -23,6 +24,7 @@
> >  #include <linux/workqueue.h>
> >
> >  #include "imx_rproc.h"
> > +#include "remoteproc_elf_helpers.h"
> >  #include "remoteproc_internal.h"
> >
> >  #define IMX7D_SRC_SCR			0x0C
> > @@ -634,6 +636,39 @@ static struct resource_table
> *imx_rproc_get_loaded_rsc_table(struct rproc *rproc
> >  	return (struct resource_table __force *)priv->rsc_table;  }
> >
> > +static u64 imx_rproc_get_boot_addr(struct rproc *rproc, const struct
> > +firmware *fw) {
> > +	struct imx_rproc *priv =3D rproc->priv;
> > +	const u8 *elf_data =3D (void *)fw->data;
> > +	u8 class =3D fw_elf_get_class(fw);
> > +	u64 bootaddr =3D rproc_elf_get_boot_addr(rproc, fw);
> > +	const void *shdr;
> > +	void __iomem *va;
> > +	u64 sh_addr, offset;
> > +
> > +	if (priv->dcfg->devtype =3D=3D IMX_RPROC_IMX8M) {
> > +		/*
> > +		 * i.MX8M Cortex-M requires [stack, pc] be put in address
> > +		 * [0, 4], so the da address is 0, size is 8 words.
> > +		 */
> > +		va =3D (__force void __iomem *)rproc_da_to_va(rproc, 0, 8,
> NULL);
> > +		shdr =3D rproc_elf_find_shdr(rproc, fw, ".interrupts");
> > +		if (!shdr || !va)
> > +			return bootaddr;
> > +		sh_addr =3D elf_shdr_get_sh_addr(class, shdr);
>=20
> This isn't used - why is it still there?

will drop it.

>=20
> > +		offset =3D elf_shdr_get_sh_offset(class, shdr);
> > +
> > +		/*
> > +		 * Write stack, pc to TCML start address. The TCML region
> > +		 * is marked with ATT_IOMEM, so use writel.
> > +		 */
> > +		writel(*(u32 *)(elf_data + offset), va);
> > +		writel(*(u32 *)(elf_data + offset + 4), va + 4);
>=20
> Here you are writing 2 words at address 0x0 and 2 words at address 0x4.
> Why are you saying the size is 8 words in the comment above?

Typo. I should mean 8 bytes.

Thanks,
Peng.

>=20
> > +	}
> > +
> > +	return bootaddr;
> > +}
> > +
> >  static const struct rproc_ops imx_rproc_ops =3D {
> >  	.prepare	=3D imx_rproc_prepare,
> >  	.attach		=3D imx_rproc_attach,
> > @@ -647,7 +682,7 @@ static const struct rproc_ops imx_rproc_ops =3D {
> >  	.find_loaded_rsc_table =3D rproc_elf_find_loaded_rsc_table,
> >  	.get_loaded_rsc_table =3D imx_rproc_get_loaded_rsc_table,
> >  	.sanity_check	=3D rproc_elf_sanity_check,
> > -	.get_boot_addr	=3D rproc_elf_get_boot_addr,
> > +	.get_boot_addr	=3D imx_rproc_get_boot_addr,
> >  };
> >
> >  static int imx_rproc_addr_init(struct imx_rproc *priv,
> > --
> > 2.37.1
> >
