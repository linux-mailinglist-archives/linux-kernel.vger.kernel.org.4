Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A998600577
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 04:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiJQCxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 22:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbiJQCxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 22:53:11 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70044.outbound.protection.outlook.com [40.107.7.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5B1476D2;
        Sun, 16 Oct 2022 19:53:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEXZbQfGYuyHiMg/k1mqON4X9ft9YxThackGuPg/A+WXAvjelYeCLjjy9eHr5Njjt//9jd2OLPNAyX7nloc4rc+tYNJ6EjTkE1NboNDBv6bqSCc7EPOcOYCfrwGbZGMu+M2ZOD8V9aIXO0Niht0DBty9BQ1cFOj6L3uk4t8miJ3ssWo4i0i3EGt6vDBpkTxOfyPXoSq+QKlTNoxaz3pYDf6g4iiiTjlaegweDxXnkUJEDWqAW4BMWQWl7ZLaerz5tFIEFPy5f4HQH1Uc9FDO5BlKDvYFOApDctQ+KMyLeVpVb/xJSs3oTL+5OlY91WGcQcQvf+EkULdnVFCsA2UZqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1rCVaDNDcquytsURJor1O/7ArQlbCXqEbXyBOIAIeg=;
 b=n4yolM1Zs4bpFtDuOyErIUcbDilvwO0QD3D/LDYEaQe5Y+ETkss5AqMLTl5xezdrfe8XL80sd9nRCXISyRH1KjNFV2qDlr+z4xbASzMRMr9nL94jYA8y5NWzJpQgaB7xiNUaYYhTKAdqcMEtfNSuyVhf65lX9+DEE8mkMSt+VYucK2HIaI1RoC4pF67/xNIVUPkhNoV4C9VCC0xV5qjKnb4DTBvuoHNRgcbvxawtcX5eFHR9NdDruKdAYD/bSy7b5DW8Jb1nihwkUQLCIrSiTnaeKczAu2GWHGnnXqdVOpb2f0Aolxd78MIODGIp/A1gItS6S5RBlXBItxudb2RqVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1rCVaDNDcquytsURJor1O/7ArQlbCXqEbXyBOIAIeg=;
 b=eI5C4RdtsfQ772fkGeF4rnm3FBcd0ZKMNdBRLrwJtSjrzZtHYpnCnYaUGLuSChk7RCFBDBiLLFHhmYSyJBy4iqqCmsKfsIQY1gjZ7W4UFeGJlkR8PrMpcfs4bZFhm5U8ltwvJ8cgVdOo3i5aM0Ky2yhpRa+uUxUDD6ctA18fu+o=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7853.eurprd04.prod.outlook.com (2603:10a6:102:c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Mon, 17 Oct
 2022 02:53:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Mon, 17 Oct 2022
 02:53:07 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Xu Yang <xu.yang_2@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Jun Li <jun.li@nxp.com>
Subject: RE: [PATCH V2 1/6] dt-bindings: usb: usbmisc-imx: convert to DT
 schema
Thread-Topic: [PATCH V2 1/6] dt-bindings: usb: usbmisc-imx: convert to DT
 schema
Thread-Index: AQHY37JgAc+YPDtjGkGp4NxLxWcnTq4NyH6AgAQeZkA=
Date:   Mon, 17 Oct 2022 02:53:06 +0000
Message-ID: <DU0PR04MB9417C0E749521747F7A5C4F788299@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20221014095148.2063669-1-peng.fan@oss.nxp.com>
 <20221014095148.2063669-2-peng.fan@oss.nxp.com> <Y0lOV8iWlpfDV/kj@kroah.com>
In-Reply-To: <Y0lOV8iWlpfDV/kj@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PA4PR04MB7853:EE_
x-ms-office365-filtering-correlation-id: e2f1e02b-075e-477a-ac38-08daafeab7f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KfPY3t8sG4xL+TV8nuBsp8UyD8vnaT+K7n4h8dHepqeN+Pr94OtLr6wf9nH1525mktqeP+ZLJHXw9XFUQSzAUmA+WK+mCQBH0Q0XX0zkZHt+4ZRA+8ZZ0x/NId/33hAUWvTz794j7Hhjh5jywzbPsEPZ4mvkWWPP6tcbS5isuNMz1hFICIjs3a3T4XhvUDFwhfN7wDLbPMSInGyjctkZf6ZqPi6yE6Xe76wg2LIym1WKpoIa6iBMBVycrJt3yULWEl1g9NLwwijHBYJLyHL98SS2hyFxDAQu4mlbH/s7bROdxSlbC+X8oxRIn/nGVNE28Q2T24X6bTyFGv/NNC1Ud5gnQgg2MyXysfjJJx+kaVx6ono+OMOfcmWJJOtFk9949pQMw0zeLKCFosx//1n5M7i4ajl7EeheENTBQgcHml/8z/R+UnS8+rDGGUbn++CgsNuw3Vw4xGdELS6qIOd3Q6yuNLwg9hcMwr75OpUVJ2UXpGKXl/dcLRLxH+1aq7D75DZUGKgPBllaCyWaf3Y/lAA4++GanKtIJomii60Z92dNmtSrdigmrBE+7JYfp5DuUL97qRQZKFm/9qCeIlhyMs44TU2Tjcqugn1y8VAs4BMzx6+9FnB5UYpSqsIFA90b5DBva0oi6qaqju0j8SiIJGWiSu4yDoECEvt/P3oGE9z0XfwwfXbDUmoYdd8eDMPY2TTLMfCYXMYNfDLY4hZ0VXTYCGZTrfwHz3/l4RKMZ6pbBJB440zCSLnp2qESRS8SCdL355Bmm/4bNedb4xx+t+ELtE8deka/+co/iZ2e59g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(451199015)(38070700005)(122000001)(55016003)(33656002)(86362001)(38100700002)(83380400001)(76116006)(66556008)(66446008)(64756008)(8676002)(66476007)(5660300002)(54906003)(316002)(110136005)(66946007)(7416002)(44832011)(4326008)(186003)(71200400001)(2906002)(8936002)(7696005)(6506007)(45080400002)(478600001)(9686003)(26005)(52536014)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kKbifKe37AK7ADdmIE7Jv62D+47nlg45z4DxomWDf9POI+OMeYuRGLtMqxWV?=
 =?us-ascii?Q?E+tXCNq81rEYl6BeBOGyGTMsX8Hc7872fbvaAM79yGy5ic+4UvcmxK80IQPu?=
 =?us-ascii?Q?/+fenEdOOBnZQVcIAAyhVepwgxWGj98G/LLIoxqtqc33d2baMKVrd3Tsv3Eb?=
 =?us-ascii?Q?DqPgisZ+uoLQYWXLbNs8orbO5qN9Mx7OgMJF72ZcfRizMzX/WwhdXLYDJ9ue?=
 =?us-ascii?Q?D6iTt8UYAZW1ec58dEUlWKhzg6OG1/ymN66Go6yIaWwuzpt98BmKVw1mH7EV?=
 =?us-ascii?Q?EdsPUvjeVAmcrYGHCH09iDU52WIrAXnC5cQoT3fu0KpzTR+ruiLj3nCjr4qx?=
 =?us-ascii?Q?DXxVP0+3N8EhGrvkOPC96SmFzXPZ4AC5ZbXuDrDOGikKqWCRYhAxJCi7fAbE?=
 =?us-ascii?Q?UI5Gx+YLKSd+CbiZJoiBMdmHyK/b8CLyOlKA4B1lceky+9CfpZDkVjaiUbWi?=
 =?us-ascii?Q?15KXstaGE63BRz7UWBYdmUhTWzOn8fV+Nbu+PquZt/AsuBuTYGsYTuH0NPll?=
 =?us-ascii?Q?CPqHJepCmXhIpVjCE3EGGcoz+eUzkb2HNW88rTNIgff1Q3aXlRNLECyBTwzD?=
 =?us-ascii?Q?JVcUPL8qkaZpqY2GfE683fQnNfriy+gXjE9z4zMR3h3Pf2NzLzTxog49u1Zz?=
 =?us-ascii?Q?bir5l0sCxDQG/U+9jkdPMGuPnPl+A/7C+OS2kEO0gWH+JbcPqfzl3ykPnplP?=
 =?us-ascii?Q?rcV9xIbZgeHFtUmhplHymjBEcoxBH6gyyWvDQHALiIeFNIYYPHRKMRctNryd?=
 =?us-ascii?Q?crOetYwlqFblajJOxGGXg6Id+JHentumgsHcWX7hv1V1i8rS9olu1lJkl62O?=
 =?us-ascii?Q?oE7+nzVoe3pDqG7oak85AC6bSvl5LRyrCLLQ3SsEv+MhXTmBeM7kRgT3T/8I?=
 =?us-ascii?Q?iGSFV+PWneGdMkEWzATox+TvDvtw4YQWqn37uRg2/m+Jt8zTwLfnqXkYWict?=
 =?us-ascii?Q?lpBlQUh4viTYX+Z8WZNfSRPy2xuwbIRfJ81zLPSJZWV7YONswUJRkmw5twhV?=
 =?us-ascii?Q?+INmSeoN7qtyK/l+xlxUOvDSCQdQ7ZjQexjM0FalNYKkMm6pQD7Vcn65fibR?=
 =?us-ascii?Q?xvaLjvM8OZJ4HbUixYig8DUNZemyG6t++DW271XyQvhYE1ddDTuadaYdIlsv?=
 =?us-ascii?Q?Ob/vs+cg38BCC/Zyia/hnvicmkiLK/Dhw19KvpZgcT5FfghHaVzLovRmaeAx?=
 =?us-ascii?Q?UTRW7EKFEvBnuDim6g8tKduJhdWOlps8psOd1zN4Amt6vp5iuZF6KC+Qnz/R?=
 =?us-ascii?Q?U44mC5KvhStT94eBktHtEac5pGbHjXjpVo4sGImNAGCrIxC1O30lVLpBpF+k?=
 =?us-ascii?Q?Oz5h5pp0dIDPihOr31MeGvEXWxNejFau4fDWRzEOHM7URgBo1YnwUy67ONXC?=
 =?us-ascii?Q?gyLOUWFyI18Ciw0EseOW5toLODUI0mTnlGW/sK6iR49xF+ZFyvTu86OIuRb9?=
 =?us-ascii?Q?7cFQcEUbJqKoohQ5SqVJ/UA3rTspcK8p7WtvQ3crHFM4E1TCBWflNheZ90l9?=
 =?us-ascii?Q?69UoczePRYz+QlTUsemYVQrrdEMekKKZ56uwjcw6g1/86it5PcZ1OZfN26sR?=
 =?us-ascii?Q?uzUfO+/spezoW2Dg6/o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f1e02b-075e-477a-ac38-08daafeab7f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 02:53:06.9612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PEZbGkEciupVeHBGutHvs+he4h3QD4RueGGqHxzL4jvgjZthyV++dcA4ODc2K2nTQNAx9h/GXftBi3fEBocqNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7853
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> Subject: Re: [PATCH V2 1/6] dt-bindings: usb: usbmisc-imx: convert to DT
> schema
>=20
> On Fri, Oct 14, 2022 at 05:51:43PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Convert usbmisc-imx to DT schema format.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../devicetree/bindings/usb/fsl,usbmisc.yaml  | 52 +++++++++++++++++++
> >  .../devicetree/bindings/usb/usbmisc-imx.txt   | 18 -------
> >  2 files changed, 52 insertions(+), 18 deletions(-)  create mode
> > 100644 Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
> >  delete mode 100644
> > Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> >
> > diff --git a/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
> > b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
> > new file mode 100644
> > index 000000000000..c83ffb6729b5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
> > @@ -0,0 +1,52 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> >
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> >
> +cetree.org%2Fschemas%2Fusb%2Ffsl%2Cusbmisc.yaml%23&amp;data=3D05
> %7C01%7
> >
> +Cpeng.fan%40nxp.com%7C15ebc6c1040f46f3ecef08daaddafa7a%7C686ea
> 1d3bc2b
> >
> +4c6fa92cd99c5c301635%7C0%7C0%7C638013453273330209%7CUnknown
> %7CTWFpbGZ
> >
> +sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> Mn0%
> >
> +3D%7C3000%7C%7C%7C&amp;sdata=3DNZ4SFEve9DqdFVremHTDVGgrpISKyj
> yoEJKYE4sk
> > +7tA%3D&amp;reserved=3D0
> > +$schema:
> >
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> > +cetree.org%2Fmeta-
> schemas%2Fcore.yaml%23&amp;data=3D05%7C01%7Cpeng.fan%
> >
> +40nxp.com%7C15ebc6c1040f46f3ecef08daaddafa7a%7C686ea1d3bc2b4c6f
> a92cd9
> >
> +9c5c301635%7C0%7C0%7C638013453273330209%7CUnknown%7CTWFpb
> GZsb3d8eyJWI
> >
> +joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> C3000%
> >
> +7C%7C%7C&amp;sdata=3DSYlpPoSmOQxNYaJFAlvwPQRFq0Oaugwc%2F52w6
> tvgcrk%3D&a
> > +mp;reserved=3D0
> > +
> > +title: Freescale i.MX non-core registers
> > +
> > +maintainers:
> > +  - Xu Yang <xu.yang_2@nxp.com>
>=20
> Signing someone else up to be a maintainer requires them to sign off on t=
he
> patch to agree with this.  Why not list yourself instead?

I am not expert in USB area. I am just convert the file to yaml to ease the=
 upstream
of i.MX device tree.

Is it ok for for Xu Yang to Ack the patch or I must add:
Signed-off-by: Xu Yang <xu.yang_2@nxp.com> in the patch?

Thanks,
Peng.

>=20
> thanks,
>=20
> greg k-h
