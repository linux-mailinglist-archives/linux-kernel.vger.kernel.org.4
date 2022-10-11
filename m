Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8725FAA54
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 03:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiJKBvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 21:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJKBvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 21:51:08 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2061.outbound.protection.outlook.com [40.107.249.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D9058DFB;
        Mon, 10 Oct 2022 18:51:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9ZCvt1W51ARRHNUqH9skpobf3UlISjCbkH6eCWeM5+X/UWzgR81+Q5xxfv1P1Alrd468VYhck/dScP2U4qIbp56jawEsLecMpc7yfqKX993HFFIJK7lQ3E3bUtVIG2Ke3E+g/Uc9uGrhRHrJDyUt1r/XkpHsO0K5IRlt6pK59UcRuhKdGnSmAMwH6HB9Rj9lN9+d85vfN+/gl5+/Tt22hgwumEzV0gEFxqxy3OPtSpf3J0JSBkw/j84AbcST2h/J6Bei+FXnWE/ZaFUD0JpGhcnyzWCHjiG4wuGq4hLroGVghwbOkhTUqjUZb/nHhqAvoXbxi46tikAOsOC0DcB4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVmc//nkEfK2u2MHvMwzxV/TEbfh0Upek7fqg0cz2Gw=;
 b=hMnHWx9TqFgSCkMvDwe2DIXMlma2uuvf5LIaAM7PnVnUI7Zk+1sHhRi2OgLgO99gj4EPxWDY8j43Hxja+4GEGnYM7+/0bZPf/rf6YV4MBazTl5lz0+GxA9oyyKpEJcfCQQkgY6dQka/r+/q7gS471RnRczAnb59sO1rgHDKdVc3dGB0w2+w9NlFR712p713CsluU/WkoK0mhL3rpDEPfaYeFz/yQONYsSwyCSIxq0Nw3LlqnjpYKyDuIEr8WIDDMCNIXpncc53UeUcRH3+A/kpLYi4T87pWnj3lLejGgMoaN9IzQDjR+R8yyhRGh/mAyXXsDM6LCoyhEAAHCeE3FpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVmc//nkEfK2u2MHvMwzxV/TEbfh0Upek7fqg0cz2Gw=;
 b=MgUD5KNrZFvUK5zBpI4htGicxGGijND8q/EvN+aDaq/gTRdXVXHwdRnVQ28uIJQLDgt2XKHrumdHF15Ac0k4BPYgkGxzXZaFRfvnJZVnMiarlJdnHEoGVhpSYiTmsuSfGI2Jw8z6GyFdwRT6Bh8xMRe9HC7ZrBZV0LN0FYAD4gg=
Received: from PA4PR04MB9640.eurprd04.prod.outlook.com (2603:10a6:102:261::21)
 by PAXPR04MB8893.eurprd04.prod.outlook.com (2603:10a6:102:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19; Tue, 11 Oct
 2022 01:51:01 +0000
Received: from PA4PR04MB9640.eurprd04.prod.outlook.com
 ([fe80::3d56:3e76:4960:20d9]) by PA4PR04MB9640.eurprd04.prod.outlook.com
 ([fe80::3d56:3e76:4960:20d9%7]) with mapi id 15.20.5709.015; Tue, 11 Oct 2022
 01:51:01 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Xu Yang <xu.yang_2@nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Peng Fan <peng.fan@nxp.com>
Subject: RE: [PATCH 4/6] dt-bindings: usb: usbmisc-imx: convert to yaml
Thread-Topic: [PATCH 4/6] dt-bindings: usb: usbmisc-imx: convert to yaml
Thread-Index: AQHY3JFyHsORHis1NEqMKhc0Pv37mq4IE60AgABZtMA=
Date:   Tue, 11 Oct 2022 01:51:00 +0000
Message-ID: <PA4PR04MB9640BA1F87883D6A61E50B6789239@PA4PR04MB9640.eurprd04.prod.outlook.com>
References: <20221010101816.298334-1-peng.fan@oss.nxp.com>
 <20221010101816.298334-5-peng.fan@oss.nxp.com> <Y0R/rJn+C0VPm3A/@kroah.com>
In-Reply-To: <Y0R/rJn+C0VPm3A/@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-Mentions: xu.yang_2@nxp.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9640:EE_|PAXPR04MB8893:EE_
x-ms-office365-filtering-correlation-id: 5e96b092-59c5-4b23-4160-08daab2b0cc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F8tRTIvSy5JmC8aLJBiU2+x+C3toZhp3ZKH80I1HrpDMxHtsg6x6ymKkhiSte86WnV7aPVxx7jEgqdqRGsQ6hKJP11Oo1FH7p9skLVO4RTT5fwrvgSepZ+lEF5gmr3/WzthjAG8kCZtirev6VdGmrPappA6BhdPv2Sqa5sLHckTEFyW+YSb+EsephpjDok4c9OIH0hdLE5POzMSBdRaltV89QxtxJUEZ8kvWaYvt4RQ4zl6lnibN4mJNTzHetciDX65lfItze1ryoKI5Pq2CBDNONgLEe3dfwHvyvHBVVrryZ1kNHeCf+dgzOFtokvDDw2DPMatsGyn8b4JITTKjXnHRIM0YIjXlxCHPYCpOWVaHTchfdZucUe0rTPvwI4212mkMxT1D0luNYkNCjLV6YKuZOA3lvc9SM7HSO6utz+KvecNmBFng179w2hN7s6/oNp+VB5LZMC/3d1g6CnY3OpiqQTvob9LXF52Km5ZUCtfr68TRqQKQ2EByuctCpBdpMCDmmJjARGQE4j/wbtegEsVI5d7uglzJnJH3UXHEKCxsevHU97aHqtsrTHTqyHaDc5mkoYlngdmFGzeXa5tDZA0zdWEfP4nfBtPkPz1CtWN2DWiRIl+gIc+nEtDO1wH8AtJdvJp36tkhLA5Mr/+Rkmq0PqxFSWUbwjV5MQBNf0bjlzX5tuvaES6Cw6SdjJjeoaHIONfOKnjekK2Xa7ffRZoNktvoB1w3tkKSfxBzMKDqebDg3qtwGXGNajTiZRRB9V05Tn2DO8NMslxxtMLWu29WnxpakVoOUgp+5sMexCk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9640.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199015)(8676002)(316002)(71200400001)(33656002)(54906003)(66446008)(66476007)(66946007)(66556008)(64756008)(76116006)(110136005)(6636002)(4326008)(478600001)(41300700001)(53546011)(6506007)(7696005)(26005)(5660300002)(7416002)(9686003)(52536014)(8936002)(55016003)(86362001)(186003)(2906002)(44832011)(83380400001)(45080400002)(38100700002)(122000001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J1+dFlPAacEpp9LJtxl7rBk7IAc9SAugscmCA2SSXL7jewTSYeSpUZUTRjqz?=
 =?us-ascii?Q?mUJnP0bSUnqBCOH+rC3A9Yqc21J/HN/AS+rJyWkl82u7YJah4u12JcpCg5b/?=
 =?us-ascii?Q?n81sYZl3wQWjBUwkJdfvdvO9ZFvjeLX9yuqSaXczAEeR+3CsZQmq+djK8UBp?=
 =?us-ascii?Q?ceJ3rFJf/FnCt0o4UaiitE6E63EH4OFCd0UBqcHu8pvzUZr7bsu5JXRJKTaC?=
 =?us-ascii?Q?JwS0nFbpujMu7zzquWs2US6/JKLUDnQyh2a+IITfIhui7xK6eOcVFj9amPyW?=
 =?us-ascii?Q?akxOROomSPKo1jpt94OSF0csWbr1u4C3InGHVUEJmXcPqWczusrZnrsNWvWe?=
 =?us-ascii?Q?gLcU4oXFSuAWvGxnqxOkYySflU5KP77Tp55Tsv/wZdY/DN8tzZRe1EQgIeJ3?=
 =?us-ascii?Q?+WwP+EWHyK+zIa884PcdMHqg/IBDE9o905DIuYEss1gH0AsrOXondRGa6+2r?=
 =?us-ascii?Q?rH9oTg3ZNPpw6F30S1+uveG+/THEJ4bNEDdsmvnJ8QTxn6Sed1gXyWklqEOi?=
 =?us-ascii?Q?zcRLNo6cZ1ZcRq8XBelC2IQEES+nSjLHb1LymgIPXkPi0xaiGKV+Mz9LW1dK?=
 =?us-ascii?Q?JUCar7O5mUyWupPsckQtriU6dh3Z/D+Jm54u/7SXeXXWUFPgbYymQDrFsL9Y?=
 =?us-ascii?Q?nR8DDuLKk7avjPymCim+aFfB7/zl5XjsEz6AJ9u4msFz5LH65FFUVvDYyaTp?=
 =?us-ascii?Q?xJ2r/SYG6F/+VDXRlFDVV775qbbeaEyI7apByRQFPNpp2mOq3tAEKRshUDsr?=
 =?us-ascii?Q?FXEpi94HblDRBCsqjTClUVQs9uCgGPLtjmaxk+SbmZxRRF1+wFeBOSACoPwD?=
 =?us-ascii?Q?9D7jvopIVaqeJwihGXWIdw7Wps+Q9z/f0FhfAb6Zh3DbQ2JPWvlzH+npCxpR?=
 =?us-ascii?Q?O7li5kxqj8TNAdbE4OB/r2ixZVhGQFu2kB0+nbxSAiecW4OZOCtsrkbPJMvd?=
 =?us-ascii?Q?SDPNgqdyQB33sdhAqWiMM3loQCZarDqBwj23eIywgRVLOQsDbpIWe1Ji9C8O?=
 =?us-ascii?Q?+UvpCnl7Dw8e7cDAWDY5TXp7ZmAjErtPhX/h2A6Il55rx9HzeR18p9Fxtr71?=
 =?us-ascii?Q?PrNH4+zzkrNAOdY00zlY5p0oK8mTYWXfjuUAz/MvJMxn8SCQbcJUpi9QX27T?=
 =?us-ascii?Q?F1npDQcZyFXG58DdPfMM0R9y2woeVDj5A/HxuyhlTkJlD1SUNzkK79KFsOoX?=
 =?us-ascii?Q?XrEpO1tymcsvF/qy0cCD1JPnF86qbstlnU/X23XmS1MldusbLg2OepP6fM0r?=
 =?us-ascii?Q?oZuqC9icgcOXsBw+PHvcruXTPScdv8gyso4W1GPiHhqs+FbJxzuA/ARFbTvl?=
 =?us-ascii?Q?WGDdtLlr+Rnt/iQHXyUsUXfQ755BbRYtSHMwrUsT/mbgbKuoL5H+DtaZykRR?=
 =?us-ascii?Q?6hwmJdw7ABT2FsqBFXNjOi3bRgi6bIHa7iKOnO/J4txu5VVNOy0hFL3CMDC/?=
 =?us-ascii?Q?iKm8cyMxl/OCvm/8SFcaSmj5mHS+xiedE/nA2wi0b+i3qiH9cGl82vGX4dg/?=
 =?us-ascii?Q?aqLWA/4rXpVtyWSfaIMif+xC0ZighVDcAxr+b+T4oQFj+ClKVMv9C9wrNCwR?=
 =?us-ascii?Q?y09AvIUzp4wdFRzZu+A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9640.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e96b092-59c5-4b23-4160-08daab2b0cc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 01:51:01.2649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MHuaHbAGyDkCfE3bqW7QkYopwWLQlZPWMSKGOlYO7faGNbTrYoe0W1eIrZPwBpaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8893
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Xu

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, October 11, 2022 4:25 AM
> To: Peng Fan (OSS) <peng.fan@oss.nxp.com>
> Cc: robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>;
> linux-usb@vger.kernel.org; devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Jun
> Li <jun.li@nxp.com>; Peng Fan <peng.fan@nxp.com>
> Subject: Re: [PATCH 4/6] dt-bindings: usb: usbmisc-imx: convert to yaml
>=20
> On Mon, Oct 10, 2022 at 06:18:14PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Convert usbmisc-imx to yaml format.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../devicetree/bindings/usb/usbmisc-imx.txt   | 18 -------
> >  .../devicetree/bindings/usb/usbmisc-imx.yaml  | 52
> > +++++++++++++++++++
> >  2 files changed, 52 insertions(+), 18 deletions(-)  delete mode
> > 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/usb/usbmisc-imx.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> > b/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> > deleted file mode 100644
> > index b796836d2ce7..000000000000
> > --- a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> > +++ /dev/null
> > @@ -1,18 +0,0 @@
> > -* Freescale i.MX non-core registers
> > -
> > -Required properties:
> > -- #index-cells: Cells used to describe usb controller index. Should
> > be <1>
> > -- compatible: Should be one of below:
> > -	"fsl,imx6q-usbmisc" for imx6q
> > -	"fsl,vf610-usbmisc" for Vybrid vf610
> > -	"fsl,imx6sx-usbmisc" for imx6sx
> > -	"fsl,imx7d-usbmisc" for imx7d
> > -	"fsl,imx7ulp-usbmisc" for imx7ulp
> > -- reg: Should contain registers location and length
> > -
> > -Examples:
> > -usbmisc@2184800 {
> > -	#index-cells =3D <1>;
> > -	compatible =3D "fsl,imx6q-usbmisc";
> > -	reg =3D <0x02184800 0x200>;
> > -};
> > diff --git a/Documentation/devicetree/bindings/usb/usbmisc-imx.yaml
> > b/Documentation/devicetree/bindings/usb/usbmisc-imx.yaml
> > new file mode 100644
> > index 000000000000..c0741ce9b523
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/usbmisc-imx.yaml
> > @@ -0,0 +1,52 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> >
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> >
> +cetree.org%2Fschemas%2Fusb%2Fusbmisc-imx.yaml%23&amp;data=3D05%7C01%7Cj
> >
> +un.li%40nxp.com%7Ca362b29633474826da9408daaafd7315%7C686ea1d3bc2b4c6f
> >
> +a92cd99c5c301635%7C0%7C0%7C638010302778862012%7CUnknown%7CTWFpbGZsb3d
> >
> +8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> >
> +C3000%7C%7C%7C&amp;sdata=3DKw6EHKfbwZ%2FfGgX6xJxML4W4E5DLiRx6pauQbLEbt0
> > +g%3D&amp;reserved=3D0
> > +$schema:
> >
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> >
> +cetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=3D05%7C01%7Cjun.li%40
> >
> +nxp.com%7Ca362b29633474826da9408daaafd7315%7C686ea1d3bc2b4c6fa92cd99c
> >
> +5c301635%7C0%7C0%7C638010302778862012%7CUnknown%7CTWFpbGZsb3d8eyJWIjo
> >
> +iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
> >
> +%7C%7C&amp;sdata=3DakKA3n0sxbOhvwDURs%2FoV7nM680QcOQCLKgxnakRe8w%3D&amp
> > +;reserved=3D0
> > +
> > +title: Freescale i.MX non-core registers
> > +
> > +maintainers:
> > +  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>=20
> Cool, is nxp going to pay me to maintain this?  If not, then don't be ass=
igning
> such a thing to someone else.  Why can you not maintain it?
>=20
> Assigning a file to someone without even asking them is a bit odd, please
> never do that.

Hi Peng,

Thanks for this patchset.

Since xu.yang_2@nxp.com is now actively working on this IP for iMX, so he k=
nows
well this h/w, I guess maybe he can maintain this, @Xu Yang, can you commen=
ts on
this?

Thanks
Li Jun

>=20
> thanks,
>=20
> greg k-h
