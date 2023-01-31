Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902EE6828EE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjAaJfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjAaJe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:34:58 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2072.outbound.protection.outlook.com [40.107.13.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907AA18B3A;
        Tue, 31 Jan 2023 01:34:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ot1FyuF9jMpkS5o+4JjOgAcKwPIKurZ+aBtGviivExgjkltBOw1X6TnH3n/votnnVFKugCJyP82JqR3v2SEMqZorK8xbA7+yMZHStuPIXLFN675JAfAr7vSXUlKbLJb6+KY8yPH3cXUSiIbSZ6FRG5e1ptqQnGK7+J/oCxuPgAPJb7+Kr2KUdcq8Sh3PqwbjuzV9CblPp4l+Rqvo4siWFJGIIbrd3g4cE3YwJJ9m0hZXe03FJ8LSqlEVSBEHABFQi5cMDTZZoCNnn3145lrBMrRo+/juicvaVXBvXdY8lcfMX4rXFkTknsdvtG/aKKXmq4BYXgrIq6gtP7pBezV7YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNjaKreO2i+Lsm/PlDEOVVPWlz54xA9344/vGQUtH/Q=;
 b=JUeA6mCfQ2f8UiPB+ipJa5VF88elowigpQeu3OPXHjWw5TwUqGEp/xhLS7YGlsR013t3QGEdBftAxqcx7CgUp4sNnZAixcgpD0QMRA5hI5Xt9rLp2WVaSr++7Wp1LvgazDfHIWwZxMJYmYKbZIM21nptr9incELrvPVY/Cq+8t3QxvkzGVWBogDpNYzJMdkWebOLXBH6+E317nzuqazNsyjrFyPbFh/TDE8V1QHTtRlfO+/W7vnUtLwngkPJoYGTHWc/QTENDKGQzFe3VzReZNxxL2FK7HD5TlJmoOm471fZvv1TSsrqLKoGn95hGXRi/Ot1mDoMOhikNIIXtrf0wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNjaKreO2i+Lsm/PlDEOVVPWlz54xA9344/vGQUtH/Q=;
 b=BRNy4HbUdUbOi5gxsNGcewIgeRuAE79STjPwgwcgls0SOMokO9XRDLvZmfuCsqfwju73IyQbQWqaWetSO+ZMmjL7y7g7WfBsCdUaszEh4426DNQ+UErOVpS7L6shkN7x2qqQXWoD4t1iFwdmaz5FjKXm/qszeG2VSVIgqoEKvZQ=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB6989.eurprd04.prod.outlook.com (2603:10a6:803:131::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 09:34:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3%9]) with mapi id 15.20.6043.025; Tue, 31 Jan 2023
 09:34:49 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Marco Felsch <m.felsch@pengutronix.de>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] arm64: dts: imx8mq: update usb compatible string
Thread-Topic: [PATCH] arm64: dts: imx8mq: update usb compatible string
Thread-Index: AQHZNVPZKYj2vaLQBEOJVeHt/zuM7K64QRqAgAACFPA=
Date:   Tue, 31 Jan 2023 09:34:49 +0000
Message-ID: <DU0PR04MB941741A921F3953E165BB45F88D09@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230131091140.3696808-1-peng.fan@oss.nxp.com>
 <20230131092455.2s63zr6d56v2u6ka@pengutronix.de>
In-Reply-To: <20230131092455.2s63zr6d56v2u6ka@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|VI1PR04MB6989:EE_
x-ms-office365-filtering-correlation-id: 96050593-3d3c-41a0-0ac5-08db036e660f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q/otq0EsHN/QCU8YGkhUR6+2NYOa8YXNXngceAfDcTIemy9z0uU1/5CyCVBlGoPnS9fba3qo2NyoZCMgQfMyznS8hdFhxhu3h1F4lzYSymb842h1VrDJUuG2VfasO1X9X9mNgYYkbUgchQrtPOq4NMnM2ckMAO3QC2m6OX8SLrnLLMe/4xURaEAm4CJQ/+fcPBgYKLfE/UFKJwEIpH/t6TYzdridemVfDeJtzvBgfdEH3Uk+RT9CMeM2dEQaVt/7DkTouo/hrzgpkfaVPD1MnM07um5nXVAr9RNXJ0GDONvm8gXeYvrhhwVg491NYr2SKlbn4dkUL64G0zKGueBSVYET0WJS4k3UoDpUBPRUK48jr2aUsXAZuvgRJ48oJfKssZldXs0R88sxM6bVZwIZK72EUBsQOzmTiTbVcylsmAYZy0ytrQ993qZKhyFs/9OB4VXWuvmBPgugXYOKrTBem8J7LqjtgX5/d5vvs9TvzpiqkftgvYeiuuo2Hmrsqaawl88XSKAV8C2zRDn5mB07qpbxey1kdXyh/XL/aEXBKGZccEuwbRj+IvgjCIAlHgsm4gRhazjLd31/2xZuRTCE5GNBeJuVvuRkAyQa+DEoEG0kZZLcExpBl7AgtVbruyp8UDqAXCYgykLDJs0uaWEpKspGHZsmcR9N9H4PKsiBP8lCNr6o1wY/oEooyHcl9XJMu1DReHftko05IIOqnvFSfVtXZ1a9hbTwr60hmRFscJA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(451199018)(7416002)(5660300002)(15650500001)(44832011)(8936002)(83380400001)(52536014)(2906002)(66556008)(66446008)(4326008)(41300700001)(66476007)(186003)(76116006)(7696005)(9686003)(33656002)(64756008)(26005)(66946007)(8676002)(6506007)(86362001)(316002)(55016003)(38070700005)(71200400001)(110136005)(38100700002)(122000001)(54906003)(478600001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+/reNvXYgWlhriIN/trt/QGEjSWl/j6k/I6a10G7/cKHVSZCohEDGCmvntCu?=
 =?us-ascii?Q?/YnAH9JBnhJm1tPDGmOqKdFHHxT/yiIMzklyx5nZeD45ufehZpPrgICTEXOQ?=
 =?us-ascii?Q?QXTmm7VN1e2tBL2OKN4esFMibo9VNHZg9X9mCnyaA1uGTqimNjnQguF+k1dX?=
 =?us-ascii?Q?7VUSMzRZj9PqFL0sM5KnkjLB9wmVLiK1G/H4nRFCdv61Y3PGm3AapETcM9UJ?=
 =?us-ascii?Q?ktuCz8CvYEQfErw5etU8jFh3BMZ36QNZrKg8Kz3O7flkq5wMNcEVuA4Ve1go?=
 =?us-ascii?Q?1FEixx4v24lyiCa4Gz8goeYDcakfuYSK09dV4Ky5Q0ZH1DwXR7Mbg9IYePuA?=
 =?us-ascii?Q?X6SNxGPIruEzHTGRUOGBycpE3Oi0DfhLmvuIsb3NgtuIHt7M9GuTIX1MoEL4?=
 =?us-ascii?Q?PBepQxSrwUtY9IwWEXmNMF7vQYx2NFKDglCxt35skSGhyDj0jhZNzEyOM+Xh?=
 =?us-ascii?Q?Eo4OZZuS5GDQHrbFKeaNO4iSRBDGPVhbGFl9YfwXKP6YgAsfw98gzbRgRbBR?=
 =?us-ascii?Q?LVa51xh/vit6Gy9eNAVakVuXI8ldy4/cF9MHalkyEuHiox5yIzX/e1l8tr5b?=
 =?us-ascii?Q?Lyx0so7PILp59V+emKmFMcidraYBstB5xmyq/ijFomh++cJ1kEqUIwRZQjZ9?=
 =?us-ascii?Q?kZTd+vQT/8z73pFHWpCS7b/QbJbgPONbOEopJGZgvTTs2XydWk2DHN9fVR6Y?=
 =?us-ascii?Q?HcLs8J2Lv9sJYHD7sQmLKp6K7gSj6c3hd83mU5Fmbkv1yLUt2jSsVQcgy6dt?=
 =?us-ascii?Q?NfUm9Oh4u0SljpXMi5XNlP7LxjJKkRPMFn0YcfUdmWWAVElzK5fQZL/i6VpS?=
 =?us-ascii?Q?ZZXFbIHll7G0NsS52ZToqvJUg6uszwtKExIJM2tGpPDRGQOooLix8LfCTR2r?=
 =?us-ascii?Q?Wnu79zyfLHhTAWQXexOYbq6nmD5HkzmSub7v05jajcjwUwtbDdHYdI4aQ0Dn?=
 =?us-ascii?Q?UYNYm2QUrBbQcTUQrLfx0/mUQOAqe5wiOabM+egZyeWzMUksAo+rTqKC9dd1?=
 =?us-ascii?Q?WnHWUXU8KX0MuFYseFhFQBk4lq8IeU+iTq8ex1j39AdT7SnRB77JDl/aUsNY?=
 =?us-ascii?Q?fDYsYce3WM7XGIYw6PrHrz86FS1LqCMN9wd729UL0z8AtgGUfwU6k+9r2Ao4?=
 =?us-ascii?Q?dtPhthVKpotbaB8wZr6Nir55I1LqPcEdxhdKuKR+wmAsDX5RYqn1D77GVFuG?=
 =?us-ascii?Q?2kJ7kLjQqQXhFWxnyUuxhubuB1yAhNxpEbh5+uixOEBciMU0H77MgYZa6x8W?=
 =?us-ascii?Q?t8Bx/SOI7WchT8kfclmjMT5uj2tEK0v3/DUIgsK376e+AxV26rRHeYZnWiGi?=
 =?us-ascii?Q?GF/yNjVgbve4CXVZm7RmUVq+vtxUAzbZjGF4TBkyEuvTtEs5prFve/Ekn5Tr?=
 =?us-ascii?Q?uw537nhxDcLSWH4nbWBCKgjuyDL3aCddVW78ay410vPEyPkTou9ddrbJOlS3?=
 =?us-ascii?Q?7VWiAgXk9nDM9ItfJhvoR38IexmPw5VMgKQEKrQTlOAfiggZO/sfrmcg+GKu?=
 =?us-ascii?Q?TYVlCvnNVm9WNyxOPYgu/kRA4CuoN7wxywk/7Y5DHs20XbebHIrQ3WHTfmTr?=
 =?us-ascii?Q?WgFbG0VlGCHQNBPr3nw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96050593-3d3c-41a0-0ac5-08db036e660f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 09:34:49.6448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QGUi9VGnMmAJ+9pcqlz6k9GOgenj4j14vVMUSmyKrDScArQgaj4XxVGQPFFyXrVDHO1+VleyVbmAMiMdMW8vYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6989
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH] arm64: dts: imx8mq: update usb compatible string
>=20
> Hi,
>=20
> On 23-01-31, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > There is no fsl,imx8mq-dwc3 binding doc, no driver use this compatible
> > string. Drop it.
>=20
> please don't. I'm not aware of the driver state but the compatibles are t=
here
> for _possible_ quirk handling, so the driver can add a match on demand.

NXP downstream also not has driver use this compatible string, and pass
several GA releases.

People could add it back when it is needed together with binding doc.

Thanks,
Peng.

>=20
> Regards,
>   Marco
>=20
>=20
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > index d59156fdee0b..d308f94a7c52 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > @@ -1431,7 +1431,7 @@ gpu: gpu@38000000 {
> >  		};
> >
> >  		usb_dwc3_0: usb@38100000 {
> > -			compatible =3D "fsl,imx8mq-dwc3", "snps,dwc3";
> > +			compatible =3D "snps,dwc3";
> >  			reg =3D <0x38100000 0x10000>;
> >  			clocks =3D <&clk IMX8MQ_CLK_USB1_CTRL_ROOT>,
> >  			         <&clk IMX8MQ_CLK_USB_CORE_REF>, @@ -
> 1463,7 +1463,7 @@
> > usb3_phy0: usb-phy@381f0040 {
> >  		};
> >
> >  		usb_dwc3_1: usb@38200000 {
> > -			compatible =3D "fsl,imx8mq-dwc3", "snps,dwc3";
> > +			compatible =3D "snps,dwc3";
> >  			reg =3D <0x38200000 0x10000>;
> >  			clocks =3D <&clk IMX8MQ_CLK_USB2_CTRL_ROOT>,
> >  			         <&clk IMX8MQ_CLK_USB_CORE_REF>,
> > --
> > 2.37.1
> >
> >
> >
