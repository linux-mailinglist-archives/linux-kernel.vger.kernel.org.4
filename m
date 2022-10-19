Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688FD6037E9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 04:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiJSCKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 22:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiJSCKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 22:10:10 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2049.outbound.protection.outlook.com [40.107.104.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455952CDCB;
        Tue, 18 Oct 2022 19:10:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAS8Q+ZtWzHkdtEZMzpoiCQ6OTtCbeewQKjsp6HiD1McloJ5EIKhIVg1MAdQ2QLLIwF88wI55oCpmDJIhZe28zh3Smv5MytSPWCFNfCzSKoqs444gnLystIVwy91nnCpy+SKdpErnupKlopU/fMsS2e/FUezn/DA90i45vyWf03pUX5fPenCXkcnM18l9aVsvL+RJkORI4+UoIoqJDQ1MdNiwOKcCnSuud6k4q9XRr5hn0x03jQJ6L1x1egMJyRnthDJjJlkyj0ZNkXtYhoP7L+jGLW1xH2Jg6N5rWvxy2SXkLDggnH8Ys/iVI37aXK3AEL9dKPfy8TUl7+CWh1xVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90tDNvPsuZXXkDik+PY6mHPcMeYR5hn9mS16hVUG71w=;
 b=X2uUmfADaluiyvlYjMP4Wlrryw1P2nbjijjE/7akCjuCSuHQ/I/blhCZsgomhtuI1fMwmqRPRGTHugj3ScF7DsNIcYC/Yq1Tl7ly+h2LTDEpuOq23mqOsJ76r7gYbVMiO8dyvaKQlCYC5KLnrgNeVtGPcW514V2i1LyzFLqStqcIV9Qb7EWzwu1j544pioSpnnPx+5mHIgGoNjGlRTOv79sUis8mOKFhiu+v3PuiZPZHiNzwzQfHGpcmAnZ/xkpgp74OpzTGR4Zvn5zkc8izvw/sHDlT1zUzE+OO/ic43Rvf8gkEhgJyMCAI4goWn9yhpxk/poentlKhwQAFyL5C2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90tDNvPsuZXXkDik+PY6mHPcMeYR5hn9mS16hVUG71w=;
 b=rnc88jsZZrHDtf0nzjODVqSn2uPYtoEYzplFH2KmCjXuYzdojbHbePRKZqmEJFWDJEyiejSx8QZGPOxEHF8xMQBbaJYmTDX3up1MfbuL1XUCTNeCjd2zDf2IAzxtEQxOgIDzYbzY0A1g4ND8e1WrLUAZKWJ+qkICzdXoqVwsCNM=
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com (2603:10a6:10:30b::14)
 by PA4PR04MB7934.eurprd04.prod.outlook.com (2603:10a6:102:ca::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Wed, 19 Oct
 2022 02:10:03 +0000
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::56ef:967c:937d:8d76]) by DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::56ef:967c:937d:8d76%5]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 02:10:03 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Xu Yang <xu.yang_2@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Peng Fan <peng.fan@nxp.com>
Subject: RE: [EXT] Re: [PATCH V2 1/6] dt-bindings: usb: usbmisc-imx: convert
 to DT schema
Thread-Topic: [EXT] Re: [PATCH V2 1/6] dt-bindings: usb: usbmisc-imx: convert
 to DT schema
Thread-Index: AQHY37JhrICZs6ojUU203kZt3gxCgK4PjEKAgAJiSgCAAtp8AIAANVIw
Date:   Wed, 19 Oct 2022 02:10:03 +0000
Message-ID: <DB9PR04MB9628C50A44BF8DC09C75CAF9892B9@DB9PR04MB9628.eurprd04.prod.outlook.com>
References: <20221014095148.2063669-1-peng.fan@oss.nxp.com>
 <20221014095148.2063669-2-peng.fan@oss.nxp.com>
 <359bc301-fed6-80eb-6945-caeb7fbb319d@linaro.org>
 <PAXPR04MB87840FFD365C5C044D54B55F8C299@PAXPR04MB8784.eurprd04.prod.outlook.com>
 <9e03801c-dea8-1029-4ba1-fa0d6144b0d7@linaro.org>
In-Reply-To: <9e03801c-dea8-1029-4ba1-fa0d6144b0d7@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9628:EE_|PA4PR04MB7934:EE_
x-ms-office365-filtering-correlation-id: 28067a3a-6195-4e3e-8d3c-08dab17708cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zqkm/8Tlleh9A1HB2RO/A3DZNO8Wyy2QgM4xErLLp0GGJAcSPwF18Q/eZDZggb49cjzUVZLBKum6v9AsCysSJjtzwpn2m5zZjKwGpu4EfylL80cF+FmhIaDkrAx64T+IA4Py7r3wVIxAgAhIHSrLs3/kxJQLr0lA3yGJFTgWejbx67Od393CnMaCgg6OcJk/K+/nJ1v6RcVtuq30I5yrM4SRZy3/L2oa9HI4KJ1F0StfX8NtdxDCAo4wt+DtG5Xal34i4LhYKO+1CrrrdQ5pXDQ/zybLdhbTR+nYL7lnV6b5d2Srj1BC1Rs5fX95C0WdcJru2VK3BWJNcMr7ZFipCazcNAro9YaSvgEoIl7+MHo+R73kAJVpG2/8EhYtScBf1syuS3Zi2ZhwknUwogiKc28FvFWXdwWLhq39hI26c8BckyNAcYxl/sQNwMO8LHWRoHYWvX7qN7ikU15Zjdjvu1Y7RmHpK8dkgg6ukOMWEthl9zQPSiCixeMv69NQbCBXcmkxOzyYCcot4Wj1y0bsIzo6EKDhtdJbQV7t4DHV9f+f5MeEOUkJGoJ4pAJTgWpEhXmlhX1iXAae0083VMUMvOEstgnVQmVbKCLKwDfGd42r5djydZpRLi2XV8h0Ll+jkoHjndG4Bxwf+U2GhtsXRTUzMVttrOHNzv/8Nlr2yoNHF2kSM0Chv83SwJG+4SBFa9F+VzO1P5HLNhpInIz+HTN6FDf6jGeup9T7KUfshwFCxV4JnvvT0VRpQ7GsKozTUHaSy4fr0B13MXDMJpOwKI8J2rYKgjmzcWp9zj1n0MiJK1n2L5ckmJ/NuxHP1Eei7/m5qtZfcIgoI3BsKqHb6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9628.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199015)(316002)(2906002)(19627235002)(110136005)(54906003)(186003)(33656002)(26005)(9686003)(41300700001)(44832011)(5660300002)(38100700002)(6506007)(7416002)(8936002)(55016003)(52536014)(66556008)(4326008)(8676002)(64756008)(66446008)(66946007)(76116006)(66476007)(53546011)(86362001)(7696005)(83380400001)(71200400001)(122000001)(966005)(38070700005)(478600001)(45080400002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5WA8WhkF7ZQ9TzorPgLxT346uy9u4N9BHjoP83IgDlLc9+qfWxRt884E9K9t?=
 =?us-ascii?Q?g6B19zUR618poL/VbwSncVOU+ZEUoEgnMO/rHs7xpWuw6qnxR6zjlfZhYzEX?=
 =?us-ascii?Q?CrEqMbUd933ZX5aT0/y2URY4YWamKHeNGftHNqBGUdTzPp//DPX0C3Qe+txc?=
 =?us-ascii?Q?Ka1rLtUYVXv8njptz2Fr+U8CjR30ae6TALcYE3vZrdEMoBhFTy8cXnCWDno6?=
 =?us-ascii?Q?4IqcuaILpg2gP8xq2ZwOlFmptYCg5g34lZy4UuI+eQw8dBL/ynyiV9H9+xyf?=
 =?us-ascii?Q?9o7sSvgAqz0AYj6zDsERmJP+/L7gZmzuVHo073sFe/Ixd1xyaV2HrxgNBFE/?=
 =?us-ascii?Q?Jqoz0SybmeUdOGQxCpZCTF54inafA/Cmpt30zAwaw96YC2YmQXE3ExwGs7gq?=
 =?us-ascii?Q?VdV89kzYNr/Z2aLSOKYiF9MHNVMQr0F77SsFv4vliLgtI0G6nhf5X0BSpZv7?=
 =?us-ascii?Q?Pw/rn9oMUvVtZCZEBvVYUeZW17FxxUeOPTzrNFIaTA7gCUAFeV83jh0vk3rA?=
 =?us-ascii?Q?YDjYsDV9ARPJDb3d2RtrK4tqgdPx9SFlUkxuiBF/dsUJd7tc+N8q+tLFszVu?=
 =?us-ascii?Q?7cSKFThSCwW6gjlqg0hPBL8bsuqX+lPK/03JqRjOzu7JO29/nsjKGPfXReIP?=
 =?us-ascii?Q?mcAMFuy6QPvpPU/t3oZq4pnqVNv2QT541iNaM4IXoz1CCFtNxIz0gXAoZ1jI?=
 =?us-ascii?Q?8qPeempUChimddVCdIVd+HAI46IIlVIoxP4RqbBq5FC24yGgr31XUdxD+aSY?=
 =?us-ascii?Q?I3ilPKS7r8NaTU1iy6ZPLedu5UEvawkTznyjP5cEDM6DfVIWpL1s6OZcY4kF?=
 =?us-ascii?Q?NyA7KX3skSC/f/fsKOEGKqXte9MlCVf8QQl+xs0tM387tHFxcujxy0NXk9fa?=
 =?us-ascii?Q?cK4hsSwnnlLx2N89AEv3pRUdTxl4jX9rjpma4d68bpm4S7yFf8JayguU0kWe?=
 =?us-ascii?Q?1JLfY8vznzF9F8CjWv5RSlZ+gC9iOxC1gavqSDco9HwvTje4BH4z/Z3bopHy?=
 =?us-ascii?Q?4WYFRgFbdchh5hhwU9T6wK7AppvXaWIzXh1YHxrHUzfaczBQLMeTZy10UrTF?=
 =?us-ascii?Q?9T0/4bRUSw9K74i/ELRIFw6jV8/IheR2LLmQ8A25KzYt0IjayI9o8MUAVH51?=
 =?us-ascii?Q?p2zbVMbasfejOt9P8JBvZYEbzanN/OPgMXtyDd1lXmNgeIqZQSqJ3g7l3zJy?=
 =?us-ascii?Q?d83UTwd+r9XtF3mMiAYvbRK4T0u1d6Y3RryIM/E9QMbgsJpK+u6gEsmKXE6u?=
 =?us-ascii?Q?/iJyH20CZmsQqTTz0JYKP4Oi7Hz53sxl/C1K2zporwpy/wWk4MRjfpEbWNLs?=
 =?us-ascii?Q?NeAdS/BmY/OUrg0BYRPgpqC9SBJLCDP34kzYAgT4pQhsWu6yU2UC238nyWEM?=
 =?us-ascii?Q?TTkE9wJvhuDPfc9HQD7QddYXkYV/Ct+0Fe/OXpjAsYS2iMZAKHtmDmrTDHaJ?=
 =?us-ascii?Q?RM2P8V3A/7tV/VBe/sKvrz+ZrHhh+oQSPvT49rWlZk9TBxULKNUNhnPfnoTx?=
 =?us-ascii?Q?D52OF4d8+kE6RUcpyPIAl4GnMC/qZ/cnI3ykYp+20VHIunrnJZPzBTRenBh4?=
 =?us-ascii?Q?w1GVqvcsZMwhP+ZjPJ8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9628.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28067a3a-6195-4e3e-8d3c-08dab17708cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 02:10:03.2815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vUBZHFhVc/z85puibonqtP1AK8WqSCY7HDiEPLtxaYpjGm2kWjIYmK/PTYqqlWk/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7934
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Wednesday, October 19, 2022 6:52 AM
> To: Xu Yang <xu.yang_2@nxp.com>; Peng Fan (OSS) <peng.fan@oss.nxp.com>;
> gregkh@linuxfoundation.org; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; shawnguo@kernel.org;
> s.hauer@pengutronix.de
> Cc: kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx
> <linux-imx@nxp.com>; linux-usb@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; Jun Li <jun.li@nxp.com>; Peng Fan
> <peng.fan@nxp.com>
> Subject: Re: [EXT] Re: [PATCH V2 1/6] dt-bindings: usb: usbmisc-imx: conv=
ert
> to DT schema
>=20
> On 16/10/2022 23:17, Xu Yang wrote:
> > Hi Krzysztof,
> >
> >> -----Original Message-----
> >> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> Sent: Saturday, October 15, 2022 10:53 PM
> >> To: Peng Fan (OSS) <peng.fan@oss.nxp.com>;
> >> gregkh@linuxfoundation.org; robh+dt@kernel.org;
> >> krzysztof.kozlowski+dt@linaro.org; shawnguo@kernel.org;
> >> s.hauer@pengutronix.de; Xu Yang <xu.yang_2@nxp.com>
> >> Cc: kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx
> >> <linux-imx@nxp.com>; linux-usb@vger.kernel.org;
> >> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> >> linux-arm-kernel@lists.infradead.org; Jun Li <jun.li@nxp.com>; Peng
> >> Fan <peng.fan@nxp.com>
> >> Subject: [EXT] Re: [PATCH V2 1/6] dt-bindings: usb: usbmisc-imx:
> >> convert to DT schema
> >>
> >> Caution: EXT Email
> >>
> >> On 14/10/2022 05:51, Peng Fan (OSS) wrote:
> >>> From: Peng Fan <peng.fan@nxp.com>
> >>>
> >>> Convert usbmisc-imx to DT schema format.
> >>>
> >>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >>> ---
> >>>  .../devicetree/bindings/usb/fsl,usbmisc.yaml  | 52
> +++++++++++++++++++
> >>>  .../devicetree/bindings/usb/usbmisc-imx.txt   | 18 -------
> >>>  2 files changed, 52 insertions(+), 18 deletions(-)  create mode
> >>> 100644 Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
> >>>  delete mode 100644
> >>> Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
> >> b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
> >>> new file mode 100644
> >>> index 000000000000..c83ffb6729b5
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
> >>> @@ -0,0 +1,52 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> >>> +---
> >>> +$id:
> >>
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> >>
> cetree.org%2Fschemas%2Fusb%2Ffsl%2Cusbmi&amp;data=3D05%7C01%7Cjun.li%40
> >>
> nxp.com%7C15ee8a29acf04f95ff4108dab15b5b88%7C686ea1d3bc2b4c6fa92cd99c
> >>
> 5c301635%7C0%7C0%7C638017303177794862%7CUnknown%7CTWFpbGZsb3d8eyJWIjo
> >>
> iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
> >> %7C%7C&amp;sdata=3DtovO%2F6fnxAMSUu9hTFv1Kgarmo%2BwxKCxS%2FeJAbt3e0k%3
> D
> >> &amp;reserved=3D0
> >>
> sc.yaml%23&amp;data=3D05%7C01%7Cxu.yang_2%40nxp.com%7C24e82b830d9f47018
> >> ff408daaebcf83d%7C686ea1d3bc2b4c6
> >>
> fa92cd99c5c301635%7C0%7C0%7C638014423898086337%7CUnknown%7CTWFpbGZsb3
> >> d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> >>
> V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DgNwM
> >> bGsiuMS1zgvbgATYAY70gv2nIhX%2F
> >> 16IxiSYBf3s%3D&amp;reserved=3D0
> >>> +$schema:
> >>>
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fde
> >>>
> +vicetree.org%2Fmeta-&amp;data=3D05%7C01%7Cjun.li%40nxp.com%7C15ee8a29
> >>>
> +acf04f95ff4108dab15b5b88%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> >>>
> +%7C638017303177794862%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiL
> >>>
> +CJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;s
> >>>
> +data=3DNxKdgHlJ9q%2F82XtXwWxHf5UFJR3v08L83jomQxg3Blo%3D&amp;reserved=3D
> >>> +0
> >>
> schemas%2Fcore.yaml%23&amp;data=3D05%7C01%7Cxu.yang_2%40nxp.com%7C24e82
> >> b830d9f47018ff408daaebcf83d%7C68
> >>
> 6ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638014423898242035%7CUnknown
> >> %7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
> >>
> wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&a
> >> mp;sdata=3DjJUP5aKNkfkAefhNQL9almV
> >> Gqzn8cTNyjcRlZMOZwRk%3D&amp;reserved=3D0
> >>> +
> >>> +title: Freescale i.MX non-core registers
> >>
> >> You sent v2 before we finished this topic. Is it correct? Even if TXT
> >> had such title, let's don't keep the wrong name.
> >>
> >> If it is non-core registers, why it is in USB? Why it is an usb-misc d=
evice?
> >
> > The chipidea's doc has a more clear explanation about core and
> > non-core registers as follow:
> >
> > "There are two kinds of registers in the USB module: USB core
> > registers and USB non-core registers. USB core registers are used to
> > control USB core functions, and more independent of USB features. Each
> > USB controller core has its own core registers. USB non-core registers
> > are additional to USB core registers, and more dependent on USB
> > features. i.MX series products vary in non-core registers."
> >
> > So we have named it like this.
>=20
> "Freescale i.MX non-core registers" implies this hardware is about i.MX
> registers. i.MX like for all SoCs.
>=20
> What you wrote now, about USB registers - quite different.
>=20
> However if you describe here registers, not some device, usually it's pla=
ce
> is not USB...
>=20
> And actually all devices are bunch of registers, right? So everything sho=
uld
> be called registers?
>=20
> Name is poor choice, so please find more appropriate one matching real pu=
rpose
> of this block.

How about "Freescale i.MX wrapper module for Chipidea USB2 controller"

Thanks
Li Jun
>=20
>=20
> Best regards,
> Krzysztof

