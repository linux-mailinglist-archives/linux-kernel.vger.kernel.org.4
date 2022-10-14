Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFCF5FE658
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 02:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiJNAfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 20:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJNAfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 20:35:40 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80055.outbound.protection.outlook.com [40.107.8.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C567104501;
        Thu, 13 Oct 2022 17:35:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjfYcWgc/mwWGUegsOnMasGIQOtemHmd7spcfIpX/zvPkdT7PNpLkIi6AZC9CbY94gIcEGLZfu0sle5yFZZpPzKh4oXjG/Zc8+bAkdwVVKDgWXibTqLP66VdUOYixCrbjsA7RMOdjL7zgw7BdS3gIO3ehzvEe2ovn2M2JImNpI3yYibrd1EMiOcEmdgc1ubl4V/c13TMH+1fcfa0x0Zf6MVxJmwNXfh7jPBea6LxNMQrbS367gq+L/URMWaGPhnwiB1+N/Vjp9WGKhlBcIo2Ydwoue1cIw5On39ahl31IJtTLYzADZ9j0OL36811FF3K5oBoO9/SyD9LqZiQGfIS1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6y2voNUE3mz8s+iADpSinjOVwb7VtjWvydIt1WOCMpU=;
 b=Jf21pnV5rOQ4w+xspzHwquGc0n+p2ZUuN1GXo/cpTDWbtmEsd2/XUzXtfZnYc9uDbfRyrmocYtbHQdDsSnGZBuYc/GXh45tOO098QFtKpYkZPLc3DHqkrqI6Bb2DAZaAB+b9ax9BSx2qFkiMORnas4+Mq9xtB3xBUE0ljujnGwuN42VQQvz+bXUE44ehQNcihuK2TWoEQQppLQQxgloQNaiDOIpcRZrT6/Iyrmg7T0uhQpRXKiRPminkPuzQMA9/O9bylD62Qz0zUoghFQMUXy5C2HMqVcfy8xMdZg+y22m04uTcYvJwsjAdv5HfGC3hv3MlB9cojgIEMU0mkavVkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6y2voNUE3mz8s+iADpSinjOVwb7VtjWvydIt1WOCMpU=;
 b=Jrkjy2ejKmLb/9SIzvIl5gu2lNA5E0RF88Da1hALK0xquFIxlfT4jQs2359eUcwZ2D6SrPgBt6aiQIQdcmVcAq/0RaQQvDYh8JpVZVqB7godo/TmbSo2cZLLSdAP8PXbtoWTZRn//pPAYT0MNPPWVy/AdtHItt909QH1qkqaSO4=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9639.eurprd04.prod.outlook.com (2603:10a6:102:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 00:35:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a%4]) with mapi id 15.20.5676.028; Fri, 14 Oct 2022
 00:35:29 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
        <linux-arm-kernel@lists.infradead.org>, Jun Li <jun.li@nxp.com>
Subject: RE: [PATCH 4/6] dt-bindings: usb: usbmisc-imx: convert to yaml
Thread-Topic: [PATCH 4/6] dt-bindings: usb: usbmisc-imx: convert to yaml
Thread-Index: AQHY3JFxx4dcN7/cu06TPYj3q5Imqa4Kw8IAgAJMn8A=
Date:   Fri, 14 Oct 2022 00:35:29 +0000
Message-ID: <DU0PR04MB9417616F713E937FD6D6337588249@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20221010101816.298334-1-peng.fan@oss.nxp.com>
 <20221010101816.298334-5-peng.fan@oss.nxp.com>
 <f68cdc01-2195-70fa-df11-521cca3505f0@linaro.org>
In-Reply-To: <f68cdc01-2195-70fa-df11-521cca3505f0@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PA4PR04MB9639:EE_
x-ms-office365-filtering-correlation-id: da0b0983-d30c-4a5b-e547-08daad7bff07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AnkcQbzLTEkRbWL7x/kwyx3khr+frXWgaiuW0jHfvhnZ2KnjTkdtQvVhM9Y+TM0w+ia2Ic9+gLdna6zy05akKiYW5GXikFJ4PYHS5nBKaQHS162ZP1TMcxNjBTBi582xPpo9mEdJTWsqskKX/3mCLobfMiKjApXzp7YTLWNe4xe8rr5AJLHtAhZi1MgTKjBc1xOAHcNKxUaSqfXBK9xdg+G1wMzKmW957hPbNP8XFOVYbV6GU4YyeC8vuXgk2RpBTfl0Xae0m1LMWHwLl3sSlA48y92BEgRMymfptmteWEASyXTnTcHeFNZn48keyMXiA0MzPIPCKMOCPzK8iOgJPHoUkIgA52Lg5GnD0jdivh/vJ4UczJwiIqhw66PhOv+JnO9RCt9UyaXN/bbajZ6Yey0kFGo28N+FLCLHoeQ1z0HKdFvnWX1kM1qm0JWN4J308/T5EqM2lq2ZLlrR1Lel5ts7UaiC8w9fsTQTb1bxy5C5k1Dq1tCdYxGZtF0Uuyx4BBHQgdsv3OCoLwEIGivnNJZgtj2FwNwhs0eqXuKCLmFaZTMAFDs8Cs93HHgdkEhP38cBeRVtR/aBIhZGOQW6UWFUaaYD0+lWVsjH/otscdvLEn/cEJB0Go/D5aIFsQ1Q+GWS1tMki2rsBTveAY3ZhTb9BjqX+Sb80hNOTRTo7ffaNmnZOC3QaWRpZywLFX5AI31qPpXSSwDblgZgFQ8h9jADInRyp7PQvDWyeL5DC6EPU6gfGi5lJlmQkVFEu5BspZyWo+5Ep+zLXzzatmYpp1nZkudhnEQK7MPUZ0nFCHI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(83380400001)(64756008)(4326008)(66446008)(8676002)(2906002)(76116006)(66556008)(66476007)(33656002)(38070700005)(66946007)(8936002)(6506007)(52536014)(110136005)(54906003)(26005)(7696005)(86362001)(9686003)(38100700002)(44832011)(41300700001)(45080400002)(186003)(478600001)(53546011)(71200400001)(5660300002)(122000001)(7416002)(316002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8Lj6LTiN/gF2BpymJQ5WPDvt1IUDR5Zzsvb9EEPG0yHLlnNCsJApSqqLpRIy?=
 =?us-ascii?Q?02gAUQxgodltPspC6LRsbN3jDufFh830NYYjmBLLPr72Mzk2dr+F2IpipauN?=
 =?us-ascii?Q?RXLv3qp/VqZrPVZtV5dJi8K40xDOmnMW9bfn0KBacKoV8EZNYzl2j8TVzdI6?=
 =?us-ascii?Q?1kaPn8cibLKh3JqVS8HsULGpPLdm1H5ZTDtS8XxuiVyhGMin+Iwgo/OL9u11?=
 =?us-ascii?Q?e4tRkQpcyvd56f1gBhAO/NpNhNmnVOfioT5cIPRGw7lUoj1boqUInYn/o62P?=
 =?us-ascii?Q?Pwi51K242vzti9TzSNG+EHLlb1gUmfUbMnDldwvyqQiJ1u3+3tGMYcmqHD1j?=
 =?us-ascii?Q?zw5cjPMdae6Sh9fDodz7MkEmBbpQBaJiSC82lX3jGwj5B5WOeHsvXfI1+gmU?=
 =?us-ascii?Q?oYxDH1DqSG9LA0vqUicDxwG3saZHSAldru95JpKJlmUULFzT2wRugTYb8kde?=
 =?us-ascii?Q?1SheF/Nd5wjEZ8ApxZ+7K0LpVMO3obZ9n+6/DtPL0BXkjf6VF0eBZ34XI0HY?=
 =?us-ascii?Q?dmQr8CbjRF1FiNWbIo6oaqmK1ld3YvOj5SyAZ5htlpIN95q0x/wvKcuSa0wd?=
 =?us-ascii?Q?N638/K5y1SYHcxyvDuz6VXaTz4qxxS0T7/F0Q3Br0vZ0ldHT7siQSr4r+toX?=
 =?us-ascii?Q?S1Q4QGgG2XYMeZCThhXGlFvVV6/JsC3NX7SUhfSB9KoCdR0kT41/HPZMluPR?=
 =?us-ascii?Q?7gt/YngCjNNJx6A8Pn2Ct6Rg3dG1Jcyh0+Vc9LM9y1ZfhmRnvpe8bC/Rx1yC?=
 =?us-ascii?Q?T1oAkqkFQnTJTT15arcmJXfAdXjDUjZ27Ki9+iSMqKh/YT3cXc0map3DnClI?=
 =?us-ascii?Q?MQBUwtg+709gz7485yFe+BMbCanVH/Jw2zDnMcGaqm8CBRH+SL3EcDpAXD4z?=
 =?us-ascii?Q?CEWHCkCzO8dQ4wgE0I2SKl8TVhPgsJAd2DLbog5UTGbQQZuuq5KHsjARnuPd?=
 =?us-ascii?Q?hpq6u9TLiElk91QcM1GFxCGUnqX9kE1KRJCaCP6sHApMcq05Cy5UsPEMaXNZ?=
 =?us-ascii?Q?3bCS3U7g1L3ygKZRG5WPDXaJyO5iKMCWt4wFo21Ypbsvicv5tBvxGSyA157J?=
 =?us-ascii?Q?QEqnvuKoa9MqRtnGd4NzAFMYZkBIyLqGV1rV6k+7ZEPpMRZpfKFbOhvRSEFj?=
 =?us-ascii?Q?vbMXFyt3oAhH832hHQzOykD+2EtAPw5U0jjhOle6Sa4jpKyLtZPUtEN3M0Fm?=
 =?us-ascii?Q?xm6ntZixXHNvg0DcvzBI2s/oT5qleVi6MXkOgDfyUkqW3qNz+Ich3RZmMdTg?=
 =?us-ascii?Q?Z38rrLUkC1U0d8X8aimYam9cIhrW9Nizc3x9jWtpRXqB+m/IIZhJvfmBwq06?=
 =?us-ascii?Q?IrH83tFJ9cKbRV+6qiPeBBJFHDrB4EWvH1yUPmhXgrIiCB8Fkjvg1ijfxR1Z?=
 =?us-ascii?Q?IHg3IqJHES8OT7FNEl2WH5DxEGByyZyaaiHlJ0n0NA93y31zfsJptYkze7zK?=
 =?us-ascii?Q?BzCT2JoiBL1l5j7FC+5DL7v7Gaa/NMmhQ45Y5m/VaP/jnz6ntR43S8ZWivLR?=
 =?us-ascii?Q?joFYbvNbyPlnCYO6YWGDyqn09HV3G/A+j+IK4o+RpEZkh83uGM+rctrpGjqr?=
 =?us-ascii?Q?4FdwwF1IFB+z2VTPCho=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da0b0983-d30c-4a5b-e547-08daad7bff07
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 00:35:29.7011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JxuYJxw+IWWJE5nAgMD1e+JI9mAwrkRGfY0pjBA+PugQIV9b0vDe08peFbOlwFqtY7E5qbgznLWXi1xfEUTxNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9639
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 4/6] dt-bindings: usb: usbmisc-imx: convert to yaml
>=20
> On 10/10/2022 06:18, Peng Fan (OSS) wrote:
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
>=20
> Filename: fsl,usbmisc.yaml
>=20
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
> > +cetree.org%2Fschemas%2Fusb%2Fusbmisc-
> imx.yaml%23&amp;data=3D05%7C01%7Cp
> >
> +eng.fan%40nxp.com%7C8e789b7d73a645df2a5e08daac55e59c%7C686ea1
> d3bc2b4c
> >
> +6fa92cd99c5c301635%7C0%7C0%7C638011782161619006%7CUnknown%7
> CTWFpbGZsb
> >
> +3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M
> n0%3D
> >
> +%7C3000%7C%7C%7C&amp;sdata=3DzokmV96uHbH8kf6c%2BRhktNfjGOBsd
> %2BhhtrloJV
> > +vGuUI%3D&amp;reserved=3D0
> > +$schema:
> >
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> > +cetree.org%2Fmeta-
> schemas%2Fcore.yaml%23&amp;data=3D05%7C01%7Cpeng.fan%
> >
> +40nxp.com%7C8e789b7d73a645df2a5e08daac55e59c%7C686ea1d3bc2b4c
> 6fa92cd9
> >
> +9c5c301635%7C0%7C0%7C638011782161775149%7CUnknown%7CTWFpb
> GZsb3d8eyJWI
> >
> +joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> C3000%
> >
> +7C%7C%7C&amp;sdata=3DDFe%2BH5iWFF9yEKRiXzWnhqqXHK4zExiK%2F%2F
> gB1Ux8csg%
> > +3D&amp;reserved=3D0
> > +
> > +title: Freescale i.MX non-core registers
>=20
> non-core registers? Does not look right.

The txt binding has title: Freescale i.MX non-core registers,
so I just reuse it.

Thanks,
Peng.
>=20
>=20
> Best regards,
> Krzysztof

