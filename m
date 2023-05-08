Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93D96FAF25
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbjEHLxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236366AbjEHLx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:53:26 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2047.outbound.protection.outlook.com [40.107.7.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF083EFB3;
        Mon,  8 May 2023 04:53:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=foez5qaA7Uxhl2V/AOl/KKGx8BSJJShMsvRjU7r0NAyHHNXzKBgRL2FQv4QFQONAeGjiCwpMcXdxRV07uOMHhunAS0HZGnVXdppnBhl4ib/QcaKuuU5zPSfDe6oUceYZp4SdhPiE2w0AEXivhxefnJZMt9wBbGwNaSKhR71C1eNU40al6jUDROkEUGTnUC/TRBnWaT2fMcx4v9P+hd6cfAp3+hrpP28QA67o4HyjlwZv2b2dmQbFVDm3r/43wv9cdwaM/s3I27KM1XQDJUMKUNJo2cPvCcK0UVuJGiYmGXlNrp8NFfJ9OkjQ0LlJoTCunI7M2sgCvHkbGZrc5yPiCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VyaSqIrLbQ1AFgAmJF3eMEqYE42gCGx0nJ34th+Hp40=;
 b=L8vZvpeYrx2Fthmhk7uryTSZ95zz3DchOxyilwaHeS1XyRnCo3fwRf0lTY+0XH3mvXtmY+3hIWR10fB1Rde+2XLXoEHbKVx8umY2CJM7sRNWYowdJVwcJf5h2T0VlR5+nmj/PDwbRvZy7P1s0eW90+VP/4EWAy+Z/bmhblLYMAB5npekgnMGe14Rn9GtkRvW6TM06J22895fe7H59htWFwGWxrxEwz24iHY2didHDauFoG6GNYLbhCw7OMYCCsSI0lDRysBIoFutNX1yGBVUXnJzOv3QmEOpzXuI6nlQw4r0kJTkq/JIRWGM26xaRwnQ4YPdvBWhArlR9Gh4XVJlpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyaSqIrLbQ1AFgAmJF3eMEqYE42gCGx0nJ34th+Hp40=;
 b=QXFMIy6Tby7HA6NM2GFyc9tMwWnANyescblMvA/NIko9CMB2Pius+cIxlRmOmWzPbprZ6q6tKjkBbXjQT6J0C8dEaGlz8gniSmtxt1W88xF0zDgyKMusKMjkcr9I2Urb5rt2hU3G2ND9KZ8OAZFo+LdcGMw4SNovmfVZPOVJIHA=
Received: from PA4PR04MB9640.eurprd04.prod.outlook.com (2603:10a6:102:261::21)
 by AM7PR04MB7159.eurprd04.prod.outlook.com (2603:10a6:20b:111::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 11:53:07 +0000
Received: from PA4PR04MB9640.eurprd04.prod.outlook.com
 ([fe80::adc9:9956:50dc:d10e]) by PA4PR04MB9640.eurprd04.prod.outlook.com
 ([fe80::adc9:9956:50dc:d10e%7]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 11:53:07 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Xu Yang <xu.yang_2@nxp.com>
Subject: RE: [PATCH v2 2/3] usb: chipidea: imx: support disabling runtime-pm
Thread-Topic: [PATCH v2 2/3] usb: chipidea: imx: support disabling runtime-pm
Thread-Index: AQHWWfIP+etXd7nQnUiONRrlcYizuqkH0FqAgACfy4CAB2whAIAARP2AgAAEJ4CAACLRAIZATVEAgAAHjgCAARDykIAAEIcAgAAPIACAAABSsIAEu1uAgAAGyoA=
Date:   Mon, 8 May 2023 11:53:07 +0000
Message-ID: <PA4PR04MB9640C09FDDDD4C29804C05BB89719@PA4PR04MB9640.eurprd04.prod.outlook.com>
References: <23672d66d229d3be4cc854ddf1462c3507f1c2fc.camel@toradex.com>
 <20230504162312.1506763-1-luca.ceresoli@bootlin.com>
 <ZFPiRvoF5l8uGzzZ@francesco-nb.int.toradex.com>
 <PA4PR04MB96403377F5E37C12AD8C25B389729@PA4PR04MB9640.eurprd04.prod.outlook.com>
 <20230505120618.2f4cf22c@booty>
 <ZFThyn/D/dDK9nk3@francesco-nb.int.toradex.com>
 <PA4PR04MB96405EE2468555EA900B340189739@PA4PR04MB9640.eurprd04.prod.outlook.com>
 <ZFjaNzY32x8o2XG7@francesco-nb.int.toradex.com>
In-Reply-To: <ZFjaNzY32x8o2XG7@francesco-nb.int.toradex.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9640:EE_|AM7PR04MB7159:EE_
x-ms-office365-filtering-correlation-id: 5a0b0b31-3dcf-4f58-e3e1-08db4fbaca03
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AWhd99D1uE697FD+ZeW1ORe5/EBDy9Q24uSgyfWb3PTlb00Lt4ez/V++TK6R38xoaXXWt4sKtfXSxLjyOVKNWp+4qCtIXe2aqoa41eYQWcUF6oa3sWW0ZivRXbjMIqZaowLpZhUmdUf8Y6czMD3xsceYV8+BMPmFG0ePWoK24CGeoTbY2byyWBvNYk7OGBJdxCwK3rX1mj3sz4kJnQkTZ5clVuPA9rTV5Dox9R1yZA1ivD4qVuA5MWc3+aNxI02RmtiC6oy96CFdekMUx/82N8HE+hUIiSHsNfQURwT84V+I3JTWvZHSPD0s2HtFI7tJ6YCHwZ8708h/Qw8vGcl1KgaSi60yMMmD0o1C33vx9P6EZyCT6y/hPhe+pigGLNtbjhzLnMbmMakN5FMkq7EdKayxYhgQV2tQh6K4iQ/lrv9QnmQ0yeQk5sZSM7DhzrC37uFT4IF34aF1tIVXFpJ0XYsT0NuExuQ05vZlhTuDxeP+xyBpm7cA134kcDz7u0pST1REbjoYtKZ5cduE/ATlFCYauNEXbPvVlCz0Aat98qu+qd7Wk7lUuS5Iqvc6lgTzFut4VjN764AMvNCCxnjGwOZoxzAf+nQX2Fz4RuW64zDPI/N9dr8a6rT8Lc59TkW3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9640.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199021)(6506007)(9686003)(26005)(53546011)(7696005)(83380400001)(55016003)(38100700002)(33656002)(122000001)(86362001)(38070700005)(186003)(6916009)(5660300002)(66446008)(4326008)(66476007)(54906003)(66946007)(2906002)(478600001)(8676002)(8936002)(66556008)(64756008)(44832011)(7416002)(76116006)(41300700001)(52536014)(71200400001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JiMG+5i+EiyJuKy3aZOT8j+glyPuQNcxU+2zDa+G0z+3sz1VI49eRYgHgdFy?=
 =?us-ascii?Q?slE1wBrJ7CxUwGco+U4dlpKfRR7lPgbWWwP79ska8lUrCheG1rQuK5fZrYIH?=
 =?us-ascii?Q?r5xDj+9PbVUWuW9mcY6f8SwexvV5ThycJmIoPkETb8XZwf4QfnibN8gLzoCO?=
 =?us-ascii?Q?1RpidH1sZ+1DdBODETsTIBIfrFyH05UgiOU+s8DQONB5RlYo5L5nub5VEgBn?=
 =?us-ascii?Q?Bhu2xroqXqrFg3Xtw5oY+pCJPxDRxgUrl1kqPNk5StL8GbQimIDkxE0Sse7Q?=
 =?us-ascii?Q?04x1UFv6zBFvM8YZKiSPJbVh9nYuHIFUx8EvnYRyWT8J9Ld/i0iSguXyY9oO?=
 =?us-ascii?Q?jJdOmHNjDaJbe35XhbklvoDLLrijgcsBChKfUFvHqB1/O4ePchaHx4c0maM0?=
 =?us-ascii?Q?pqmAKSZ//b5pn+qDQyEKaVsXmR0Unx+iVYxQqnrgoaW6xBC/AHmxIy6rDq2+?=
 =?us-ascii?Q?fSbL2g6+ap+scsWbNNlGps9SPLpaOEaNMuteCy0kHe2bSUDvfRcRGZZielE/?=
 =?us-ascii?Q?fio+oBiBtuP+ruCQId0uJhMLcd4Y77paSLuSHsBcq14lr6SEALNkWvMolNMe?=
 =?us-ascii?Q?omGixrnGG+5tdozsi4owQ5rAuMflcdYnJmexm7A7V4zVebt9Wnva1g5WdZ3z?=
 =?us-ascii?Q?N5B3b+Pf76xj+e7ywvHKIDYAhbxkR84SGuM0nic4nstPfRmPCrNfQpg2iDzq?=
 =?us-ascii?Q?Yz+SAJeRMwLByPRtJhnsrCqYW5ZUqgZy2I0Q0IxXZCbQmLGFtQSVu/6OfUFb?=
 =?us-ascii?Q?EpbyIM0SyU7qxufenrwr08H4V7cB8TR2GdKPsjaJkcQQ2PLqUwosMqMXddve?=
 =?us-ascii?Q?HxizwwAnHGrCMfZ1aAr2eHuBK0UaxIgXZ8j3dYPtXCy6MA+oRC7OmK0LNXUT?=
 =?us-ascii?Q?yRr9R3N6k5jJCEsE2L5O0fMd4BP07jCAmnsv5A+DrnRKUQBDEllTmK6QbBBu?=
 =?us-ascii?Q?3DvKS+LGLZUaREtPvBBkAPdU601iZgWEWI4pWeGxfSXXlBAKa3BMseg1dsIn?=
 =?us-ascii?Q?O3HJCr0WS21Ktk+7BmR+EC1fs5agtKAh2A53Rmc6YHxio4RZE3j7c1dKKcB/?=
 =?us-ascii?Q?vbSiO2upzNE61RrYvHbXdFCumYOHZVRvd33buGaMhLWQjOmPtpl/3Ro0UGsz?=
 =?us-ascii?Q?o96gu25QkGrFQq+bsmeKxuT5VLRhqeOkx0r8ZYj9Rk5r6tpKGyvjn2edrvKa?=
 =?us-ascii?Q?U20/r9xzugSWdfsDeIgR+EOJubL+PE7HXB5MnQUa3fQNgkojalPrs6xsrypk?=
 =?us-ascii?Q?ZI4NOBhiPE0UsC5z2tKdmkEJ4j6QKAQJtjJMU+16LZwLrSaxiPnJyxiqBxX3?=
 =?us-ascii?Q?0Z9xyHVyBIKgqR/VCJxV5JC193ZcM/j0SW0EIaBwjDKekFe8jDn3/tXSsW48?=
 =?us-ascii?Q?U211UScfl9tICZJ1Olo/1JyfIlnOdyalAvMFPk1/Y9t01qk+flhAB4eHg3Lk?=
 =?us-ascii?Q?xyWAG2pG4XLT+JPxRKPWeYNseygrqc/zG199Gts0JCjDllMVvRCFXamlNJRA?=
 =?us-ascii?Q?CRe8OM4pWF+RHACZkxHEX5gQhLnJ9y54A+H10k873BXEOmLjuX9ljdInebNA?=
 =?us-ascii?Q?HRehb0V/BKxUvp2glnc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9640.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0b0b31-3dcf-4f58-e3e1-08db4fbaca03
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 11:53:07.4692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JB01KPclAbItGWcmhgdaK5Ugm3TCC7lxFe15/83KDzXFfgcwy0qnAdijKit/mNr8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7159
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Monday, May 8, 2023 7:17 PM
> To: Jun Li <jun.li@nxp.com>
> Cc: Francesco Dolcini <francesco@dolcini.it>; Luca Ceresoli
> <luca.ceresoli@bootlin.com>; devicetree@vger.kernel.org;
> festevam@gmail.com; gregkh@linuxfoundation.org; kernel@pengutronix.de;
> linux-arm-kernel@lists.infradead.org; dl-linux-imx <linux-imx@nxp.com>;
> linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org;
> robh+dt@kernel.org; s.hauer@pengutronix.de; shawnguo@kernel.org;
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>; Francesco Dolcini
> <francesco.dolcini@toradex.com>; Xu Yang <xu.yang_2@nxp.com>
> Subject: Re: [PATCH v2 2/3] usb: chipidea: imx: support disabling runtime=
-pm
>=20
> On Sat, May 06, 2023 at 09:02:39AM +0000, Jun Li wrote:
> > > -----Original Message-----
> > > From: Francesco Dolcini <francesco@dolcini.it>
> > > Sent: Friday, May 5, 2023 7:00 PM
> > > To: Luca Ceresoli <luca.ceresoli@bootlin.com>; Jun Li <jun.li@nxp.com=
>
> > > Cc: Francesco Dolcini <francesco@dolcini.it>;
> devicetree@vger.kernel.org;
> > > festevam@gmail.com; gregkh@linuxfoundation.org;
> kernel@pengutronix.de;
> > > linux-arm-kernel@lists.infradead.org; dl-linux-imx
> <linux-imx@nxp.com>;
> > > linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org;
> > > peter.chen@nxp.com; robh+dt@kernel.org; s.hauer@pengutronix.de;
> > > shawnguo@kernel.org; Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org>;
> > > Francesco Dolcini <francesco.dolcini@toradex.com>
> > > Subject: Re: [PATCH v2 2/3] usb: chipidea: imx: support disabling
> runtime-pm
> > >
> > > On Fri, May 05, 2023 at 12:06:18PM +0200, Luca Ceresoli wrote:
> > > > On Fri, 5 May 2023 09:49:16 +0000
> > > > Jun Li <jun.li@nxp.com> wrote:
> > > > > Is your board design similar like Francesco's as below?
> > > >
> > > > Possibly, but I'm afraid I can't say: I am using the Toradex Colibr=
i
> > > > i.MX6ULL SoM, whose schematics are not public.
> > >
> > > I can confirm that it's the same.
> >
> > Thanks Francesco for the confirmation, had a check with design team,
> > there is no status bit which can be used to judge the VDD_USB_CAP is
> > powered or not, so we have to add a board level dts property to tell
> > this usb phy driver to bypass MXS_PHY_DISCONNECT_LINE_WITHOUT_VBUS.
> >
> > Before send a formal patch, I want to confirm this should work for your
> > HW design, like below simple hack:
>=20
> Thanks Li Jun, I tested it with v6.3.1 kernel and it's all good.
> I would be happy to test the patch as soon as you send it.
>=20
>=20
> With that said I had another issue that I assume is unrelated.
> In addition to the USB Host port, we have an additional OTG one. This
> interface has the same circuit WRT to the VBUS, however in this case
> it's possible to read the VBUS using extcon, e.g. a standard GPIO input.
>=20
> With that setup, while doing a role switch, I had a couple of time this
> error:
>=20
> [  187.310421] ci_hdrc ci_hdrc.0: USB bus 2 deregistered
> [  192.351452] ci_hdrc ci_hdrc.0: timeout waiting for 00000800 in OTGSC
>=20
> that was recovered only doing an additional transition.
>=20
> More complete logs here:
>=20
> [  184.997619] usb 2-1: USB disconnect, device number 9
> [  185.019620] ci_hdrc ci_hdrc.0: remove, state 1
> [  185.024271] usb usb2: USB disconnect, device number 1
> [  185.334975] ci_hdrc ci_hdrc.0: USB bus 2 deregistered
> [  185.353857] ci_hdrc ci_hdrc.0: EHCI Host Controller
> [  185.389670] ci_hdrc ci_hdrc.0: new USB bus registered, assigned bus nu=
mber
> 2
> [  185.470170] ci_hdrc ci_hdrc.0: USB 2.0 started, EHCI 1.00
> [  185.476097] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002,
> bcdDevice=3D 6.01
> [  185.484527] usb usb2: New USB device strings: Mfr=3D3, Product=3D2,
> SerialNumber=3D1
> [  185.491811] usb usb2: Product: EHCI Host Controller
> [  185.496704] usb usb2: Manufacturer: Linux 6.1.22-6.2.0+git.3b29299e5f6=
0
> ehci_hcd
> [  185.504148] usb usb2: SerialNumber: ci_hdrc.0
> [  185.531121] hub 2-0:1.0: USB hub found
> [  185.542636] hub 2-0:1.0: 1 port detected
> [  185.556586] mxs_phy 20c9000.usbphy: vbus is not valid
> [  187.271684] ci_hdrc ci_hdrc.0: remove, state 4
> [  187.276281] usb usb2: USB disconnect, device number 1
> [  187.310421] ci_hdrc ci_hdrc.0: USB bus 2 deregistered
> [  192.351452] ci_hdrc ci_hdrc.0: timeout waiting for 00000800 in OTGSC

I have 2 questions:
1. Can your OTG port work fine in device/gadget mode if you did not
   do usb role switch?(e.g. the OTG port *never* switch to host mode
   after system boot).
2. Please show me your dts file node of your USB OTG port, I want to
   Know how you config your OTG port.=20

Thanks
Li Jun
>=20
>=20
> > diff --git a/drivers/usb/phy/phy-mxs-usb.c
> b/drivers/usb/phy/phy-mxs-usb.c
> > index e1a2b2ea098b..ec5ee790455e 100644
> > --- a/drivers/usb/phy/phy-mxs-usb.c
> > +++ b/drivers/usb/phy/phy-mxs-usb.c
> > @@ -178,7 +178,6 @@ static const struct mxs_phy_data imx6sx_phy_data =
=3D
> {
> >  };
> >
> >  static const struct mxs_phy_data imx6ul_phy_data =3D {
> > -       .flags =3D MXS_PHY_DISCONNECT_LINE_WITHOUT_VBUS,
> >  };
> >
> >  static const struct mxs_phy_data imx7ulp_phy_data =3D {
>=20
> Francesco

