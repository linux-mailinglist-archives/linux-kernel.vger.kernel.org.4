Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5813C715D09
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjE3LXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjE3LW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:22:59 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2057.outbound.protection.outlook.com [40.107.8.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB7B102;
        Tue, 30 May 2023 04:22:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AaYxgy9Y0znarqkg5lqFhQ7w27cepZgpQ6QTkC/bNHXAeWi5V7my2J6t73rLRvz5u8WqwiwqVF8WU34Ie91qCPUgQ8uf1snf7GfH/ms22cweUVJoR14qFADSkeeFj17eJoKMbi7095SWyUpD3v1gYQ2PkaYAQLB4LE9U9qen39uw5ypSQV27XbE8IsGVETXzXlXq9k2higkk5I4WPcJdH0FqTer5jlDXoKUV/IR+noiRHwDCkcs7BpB4g69iYaUhYiBD6AY+pMQXqOC32kQYz3a97RicCklMY0T7HyDtwtbJXla2IeL7WoXu2S87d8mxJZz9Hbm+fy37sm1GkyyuWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qt4qUMB6P+DyIx6KwjN1SK9VQZQ203Oob7ZvwfH1MUA=;
 b=cJ5n/cqmP1TZ9nwJM85U5HWTWdyUeJ2Bqzgi/+YY4uJVTXM0ylY3XIRj4HtoAYPBvPPQpdZKJZXMLchZIIbOX5Mu/wbqU+QWH+bb+Ux5Anrmgnp5pM2wz+RqafiUIuxNvQ/K9SI+QWaEp84AeU6334r83yqUr55uHekaHYCCgu9HGW4LmyHShaiR5Emk+e2Zy1F6Moiq9SErBVaLvffsbXNm6LpVYIIoSIz9s/2WpaoCrloque6aOtpzfh0FVmBQgqNWI41Tqwi/GIuhM//hj4JFviMifagbe9rDkKlhDRZtvyXnUb6O19KdRLyw5cI+qFaVniSpDMN0Y+hq0IpjDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qt4qUMB6P+DyIx6KwjN1SK9VQZQ203Oob7ZvwfH1MUA=;
 b=WBwe+15u/G2kgKdURpqxcnohVsdEOeSNuE8fslL3dqy2eTa167+zdr4WgO5BIYuiU+P6weruFj1UeV5LlDovE5+c0YBBVWpQwZDDW/+vtFM59/cBdI50mMMA1JBhdxZapFmdE2PahcQEdUJw/Jmv1ZwqKdh2ogs93cBrciuUP9I=
Received: from PA4PR04MB9640.eurprd04.prod.outlook.com (2603:10a6:102:261::21)
 by AS5PR04MB9893.eurprd04.prod.outlook.com (2603:10a6:20b:653::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Tue, 30 May
 2023 11:22:51 +0000
Received: from PA4PR04MB9640.eurprd04.prod.outlook.com
 ([fe80::adc9:9956:50dc:d10e]) by PA4PR04MB9640.eurprd04.prod.outlook.com
 ([fe80::adc9:9956:50dc:d10e%7]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 11:22:51 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>
CC:     Francesco Dolcini <francesco@dolcini.it>,
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
Thread-Index: AQHWWfIP+etXd7nQnUiONRrlcYizuqkH0FqAgACfy4CAB2whAIAARP2AgAAEJ4CAACLRAIZATVEAgAAHjgCAARDykIAAEIcAgAAPIACAAABSsIAEu1uAgAAhvACAIM7OgIABH3Bw
Date:   Tue, 30 May 2023 11:22:51 +0000
Message-ID: <PA4PR04MB96405138465D215C34285F02894B9@PA4PR04MB9640.eurprd04.prod.outlook.com>
References: <23672d66d229d3be4cc854ddf1462c3507f1c2fc.camel@toradex.com>
        <20230504162312.1506763-1-luca.ceresoli@bootlin.com>
        <ZFPiRvoF5l8uGzzZ@francesco-nb.int.toradex.com>
        <PA4PR04MB96403377F5E37C12AD8C25B389729@PA4PR04MB9640.eurprd04.prod.outlook.com>
        <20230505120618.2f4cf22c@booty>
        <ZFThyn/D/dDK9nk3@francesco-nb.int.toradex.com>
        <PA4PR04MB96405EE2468555EA900B340189739@PA4PR04MB9640.eurprd04.prod.outlook.com>
        <ZFjaNzY32x8o2XG7@francesco-nb.int.toradex.com>
        <20230508151756.785ec07e@booty> <20230529121825.71e9b6d6@booty>
In-Reply-To: <20230529121825.71e9b6d6@booty>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9640:EE_|AS5PR04MB9893:EE_
x-ms-office365-filtering-correlation-id: 39f23d0b-46e3-44de-a674-08db61003475
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /kJ+FD0TCjMy9xddvxXHkS+8WAuXHpSp5Gu5KsdF3qNpkSXA2DI+OCzI15oUhAU1LOPmRwN0K8tNrHj9fs2YNjs4bT8ajjWjGg4lQVYulA/uexQ7EsPierKoLvsnryiqxFjhMDpO/4e1BIkefPGL2+SgHh5hZ3CCzvGywIquK4JQu9t57nJwUHomqlejLR/SiB0eHaA3t9Ko4P2ZX2BUGMQ2UWWmpbw3Kg6I/Bn9AGmkDo49DZxCi2sa3C9f047CB5Yk8GWMYWREkR5JGlvnZvtqOfB72PjprosalxSkRoIHEd82X0EXGJk0+D3fWCyEZNu5yukKbWmdRym59U1/0gfiJN6Gbh9QXYWTTKtLOsKzWshZl63l06xJS8P1OPY/d1nbWal/DsEN71h4Lhmhz78ucHTaO+gHZUZ2B05bvvY4UXLt86IAuF3XEFW91zWTXqjtLGSFM97cF95k/80E7Y77qu+OIlOwzlk6NSdFlsv5W/EhKiT3teCyPSLaMXHevwDiwgPy8IvgTNW7AqscEJerKIkHH2ub/SmqkzzrfoK1crghnnE1FjUqudCEoG+uRtocbzzfcBy0+u250ERjb/zQ69U4+wbOyeAMpzLHMFuxU0udXTJSIig+tCN7n2pw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9640.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199021)(6506007)(38070700005)(9686003)(186003)(2906002)(53546011)(54906003)(478600001)(26005)(44832011)(83380400001)(86362001)(45080400002)(7696005)(8676002)(41300700001)(38100700002)(122000001)(966005)(8936002)(55016003)(66946007)(316002)(5660300002)(66476007)(66556008)(76116006)(64756008)(66446008)(71200400001)(33656002)(52536014)(7416002)(6916009)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SLB9vlMMrHmo3CLxieHjMSqSgdcTFe+Tx3nv4RoXczsKR4kakQRZg2tp5dV4?=
 =?us-ascii?Q?xXHoDUUaqkxxwAiSSo0vxv1JRlucddXuz6mJgT0EdgleKSPjOaip0ZV106P/?=
 =?us-ascii?Q?QqPYPcksma3UpAczOzDkMRPi4bs6S020QwO+AKOOgPSsl2sr11Kq69kgt9ov?=
 =?us-ascii?Q?RxgRLTkaCug2IB4vvDKNnmXoAIMi8a84tuOA+8FHcbn27QlIeaNn1EYH81qQ?=
 =?us-ascii?Q?KmTOSC9R75SCvRmyui+K6woq241dmvnPEPs0SjPy/jWVMd3PUod8Grc+6dOg?=
 =?us-ascii?Q?UbKC6UqEILYcD8a3C9Srl9lw/aZqJVki7X4GmPSyudEcW+3kGdIQKmu3rlNN?=
 =?us-ascii?Q?C6iSRY0rFJ75wpfHnhUxc3PYych/6H5WwDtX9hX70E/9l2JG92qAFuGgzN6b?=
 =?us-ascii?Q?u/N6ujuzVxUmJkVdsm7V1+nggWMsInMcVauHxc0SLn5rR4fCtxgIYYfUSTiM?=
 =?us-ascii?Q?523HZL9/i4g2WlMVr1lOfvSYVQyy4n4gmcuZCrBP7wyS0TbSB4QE9XxqJWLi?=
 =?us-ascii?Q?p/S1jl2MoClSQWQTAKpjjjKrbdzpe2uagZK8gBLsWzzYfw+FKNYp0OaGAtKo?=
 =?us-ascii?Q?4p7FV6uAfaXRibQ/PcsKyoMFcDtzTfBqAxui+cHWByEUMKQhT7CEsSVmdlB4?=
 =?us-ascii?Q?1bCVWNipZamzOXkPncdXMHGdYADFtSV4Vy3dEM36H+ZEPscMJXhDrMRCVhQq?=
 =?us-ascii?Q?eH2g57Vauo5XAlhOiLD+L/ZxqDyQp+fS0xGlDwq9e8VVy5ybUnGkYowvXF7F?=
 =?us-ascii?Q?I9DmdkA4OO1Z2ShbHlff1Q+YkrXevOwUE8oDWlAOMlUVLjKipUmMkO3U8LAU?=
 =?us-ascii?Q?U7mVC3SNBVjZEepbzUbA7LkvNCSJK9kRd2ephTPuOSmhlruLG5AAxznZzpFi?=
 =?us-ascii?Q?Ohyki7kQ+LFpzRIv2uxrNHQCOkW9SzxXo8Gd0ZTCvcyy0hONQl+VQKqsGaJZ?=
 =?us-ascii?Q?ocUU/kfU3yQoxmVoxuoI5OiaJ1hnQQkJ9P52W+s5nh/ogAJNNcOjiTJ6G73z?=
 =?us-ascii?Q?o2oine1x1ptMGFdq+tNPQUSd11Ncvi99UUrvrNk+hfF2QH0O2rhRkSssPZCa?=
 =?us-ascii?Q?vmYlA2mWIkEPwaJ6R50qyaPhSFobxntiY8tkh4UlJSlUOxM4pvPKP2lRHTg8?=
 =?us-ascii?Q?4M6fK5Y7fUHYWCeAmW7igcYS2GJh1ejJmy5h5bmJoM4D3aGG//yr07O0vVp9?=
 =?us-ascii?Q?H8jVTkNR9KBEbQ+btx+744Myj926F9WIXI7NTM6P1uIboZnya9k2vmmQVmJG?=
 =?us-ascii?Q?H4xIc1BqAUmTarQJD8HtkXfJOgwxTih6HJLMIXl4/iIpA1iCmrtCjOT4TJhA?=
 =?us-ascii?Q?PjJvjM6Ia1CdBjrK6AfeeQk1ZyYX/9VqhaqZzO4lhjuNJk5jTS4WAR8R9lJI?=
 =?us-ascii?Q?ZR7ASkTQqECtDlM9QfW+4lblonZV1etVFly4wV6WfE6UrJy/vH7v9d+aPi20?=
 =?us-ascii?Q?c7NBPJAqHMPskQksbBaSFGx//Oi1+wAJW1HdKlnZKq7joS6Ak9PzgnUkkdCo?=
 =?us-ascii?Q?VodPPwrzFloIUfOq7ArsBzqINJugc7PEqsj2HKDXmE4zJsdDPszAPs+5wStd?=
 =?us-ascii?Q?UA8VMrTDXC65/C7fDT8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9640.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f23d0b-46e3-44de-a674-08db61003475
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 11:22:51.1035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bTs+X6++Ksjb/9RWPABcwbI0Vg1mikmn7yxvqmVm0xFPc6T0pM1eZIyxdEsSnNja
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9893
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Sent: Monday, May 29, 2023 6:18 PM
> To: Jun Li <jun.li@nxp.com>
> Cc: Francesco Dolcini <francesco@dolcini.it>; devicetree@vger.kernel.org;
> festevam@gmail.com; gregkh@linuxfoundation.org; kernel@pengutronix.de;
> linux-arm-kernel@lists.infradead.org; dl-linux-imx <linux-imx@nxp.com>;
> linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org;
> robh+dt@kernel.org; s.hauer@pengutronix.de; shawnguo@kernel.org;
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>; Francesco Dolcini
> <francesco.dolcini@toradex.com>; Xu Yang <xu.yang_2@nxp.com>
> Subject: Re: [PATCH v2 2/3] usb: chipidea: imx: support disabling runtime=
-pm
>=20
> Hello Jun,
>=20
> On Mon, 8 May 2023 15:17:56 +0200
> Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
>=20
> > Hello Jun, Francesco,
> >
> > On Mon, 8 May 2023 13:17:11 +0200
> > Francesco Dolcini <francesco@dolcini.it> wrote:
> >
> > > On Sat, May 06, 2023 at 09:02:39AM +0000, Jun Li wrote:
> > > > > -----Original Message-----
> > > > > From: Francesco Dolcini <francesco@dolcini.it>
> > > > > Sent: Friday, May 5, 2023 7:00 PM
> > > > > To: Luca Ceresoli <luca.ceresoli@bootlin.com>; Jun Li
> <jun.li@nxp.com>
> > > > > Cc: Francesco Dolcini <francesco@dolcini.it>;
> devicetree@vger.kernel.org;
> > > > > festevam@gmail.com; gregkh@linuxfoundation.org;
> kernel@pengutronix.de;
> > > > > linux-arm-kernel@lists.infradead.org; dl-linux-imx
> <linux-imx@nxp.com>;
> > > > > linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org;
> > > > > peter.chen@nxp.com; robh+dt@kernel.org; s.hauer@pengutronix.de;
> > > > > shawnguo@kernel.org; Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org>;
> > > > > Francesco Dolcini <francesco.dolcini@toradex.com>
> > > > > Subject: Re: [PATCH v2 2/3] usb: chipidea: imx: support disabling
> runtime-pm
> > > > >
> > > > > On Fri, May 05, 2023 at 12:06:18PM +0200, Luca Ceresoli wrote:
> > > > > > On Fri, 5 May 2023 09:49:16 +0000
> > > > > > Jun Li <jun.li@nxp.com> wrote:
> > > > > > > Is your board design similar like Francesco's as below?
> > > > > >
> > > > > > Possibly, but I'm afraid I can't say: I am using the Toradex Co=
libri
> > > > > > i.MX6ULL SoM, whose schematics are not public.
> > > > >
> > > > > I can confirm that it's the same.
> > > >
> > > > Thanks Francesco for the confirmation, had a check with design team=
,
> > > > there is no status bit which can be used to judge the VDD_USB_CAP i=
s
> > > > powered or not, so we have to add a board level dts property to tel=
l
> > > > this usb phy driver to bypass MXS_PHY_DISCONNECT_LINE_WITHOUT_VBUS.
> > > >
> > > > Before send a formal patch, I want to confirm this should work for
> your
> > > > HW design, like below simple hack:
> > >
> > > Thanks Li Jun, I tested it with v6.3.1 kernel and it's all good.
> > > I would be happy to test the patch as soon as you send it.
> >
> > Thanks Jun, it works here as well, on 6.1.27!
>=20
> Have you managed to make progress on the patch after Francesco's and my
> tests?
>=20
> As I see it, a proper fix for mainline could be as simple as a new DT
> property to describe this specific hardware configuration and a patch
> to ignore the flag when the property is present. Is my understanding
> correct?

Yes, your understanding is correct, talked with Xu(in CC), he will take thi=
s
soon.

Thanks
Li Jun

>=20
> Best regards,
> Luca
>=20
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbootl
> in.com%2F&data=3D05%7C01%7Cjun.li%40nxp.com%7C54d7d4bc194545db610608db602
> e0ca6%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638209523121178887%7
> CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1h
> aWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D3SbXTUvvRwcsJoBIhPoypWDLDMpj2m
> z09JC34t3rNh4%3D&reserved=3D0
