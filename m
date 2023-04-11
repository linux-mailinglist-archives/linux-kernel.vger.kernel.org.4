Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C186DDEAD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjDKPAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjDKO7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:59:55 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2049.outbound.protection.outlook.com [40.107.8.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4964449C;
        Tue, 11 Apr 2023 07:59:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcQmjyWZK8uT7z+AdxrHylXwFPcp0Fi6A2wAyxFQD5ykzjsEK8f2U8ZxjxGEUpA7j9Fk+sdMleAmJZUtI9CLNf+MzE17rBQO9WRFkCZ/IXYO/2U6k6l6f8KhFjaBFAjeErInpswj/e5BgGXv3ibUbbH4J9cG32G3ki3HN4dpmmrKeEXG8CD3ExFvMzhFymjwCZZPnb9GCgtJRBF2smDXd/NT4jO7Xcqy9Q0NEeD1ti2jyVtQDwFNE1WE5dg137o7vA1EGjeKnaE9ocAV1iUNgkdNSaTnixRnq1nmX4y/40aEDcZg7iLzvLO3S9hB5k57qBk+hUmIRbGqJV3c0SnbGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXQr/gsO/5T7HvIDmppk1xRQeNKe12pDcgq8CwRdoA4=;
 b=IGMdnJ7HCvK/8ZeIl8kNUYaZCrSjQfW+6zLccUrMXV8Tz14hp6fHhZAt4/cLVnZm7U5y1x5fg4F69BjW3IM0DTJUDntjB7ORYJ+7bR0kUcO5QJRKIpd6QyiDvTVKmEFUPc+lZLV/zO0TgwQqjfZ9K1M6ZmnowyQsBgg6IxLNIpQEw2VpHpNfS61nFJssc/G4EamxIUFed906ksLs7OTsrJX68V8dTKGEMsoVY8AzX1asQKWGJwUIKPp/3lb7SzmMFd3paNOwGqVzOPSKINmbbCx4/QxFctNwqvdAqcQLJWz+dC1H2qOKsLvF7MVfOPwq//JSqq9xyVZW7cI8wmLqUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXQr/gsO/5T7HvIDmppk1xRQeNKe12pDcgq8CwRdoA4=;
 b=AE4X1ZGfjL8uixnPTJFrTZnm/jvOcWuJwxvqpYG9UWwGZtdM5t8tf1jAvlCJTijUI4wUoLCR7IYnz39ymng60AmNOeONVn8HoAv5DnlDAUH1tnFoNjgL2qUlew3bPUCd2sF1VMHdGpkTKtobC+G47Sp/5oZETuigwFdQ5r+AVMA=
Received: from PA4PR04MB9640.eurprd04.prod.outlook.com (2603:10a6:102:261::21)
 by DBBPR04MB7772.eurprd04.prod.outlook.com (2603:10a6:10:1e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 14:59:50 +0000
Received: from PA4PR04MB9640.eurprd04.prod.outlook.com
 ([fe80::5c99:52d9:e4c3:3318]) by PA4PR04MB9640.eurprd04.prod.outlook.com
 ([fe80::5c99:52d9:e4c3:3318%8]) with mapi id 15.20.6254.035; Tue, 11 Apr 2023
 14:59:50 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Johannes Zink <j.zink@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        Bough Chen <haibo.chen@nxp.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: phy: imx8mq-usb: add phy tuning
 properties
Thread-Topic: [PATCH 1/2] dt-bindings: phy: imx8mq-usb: add phy tuning
 properties
Thread-Index: AQHZZ7DMcw1qaTO5G06hSinhQXI+gq8cmmgAgAAGjwCAAu9aAIAGom6AgAAJpbA=
Date:   Tue, 11 Apr 2023 14:59:50 +0000
Message-ID: <PA4PR04MB9640611A4FF721349025BF1E899A9@PA4PR04MB9640.eurprd04.prod.outlook.com>
References: <20230405112118.1256151-1-j.zink@pengutronix.de>
         <20230405112118.1256151-2-j.zink@pengutronix.de>
         <5398cbe0-c681-5dd7-0b3e-3a586cc4915f@linaro.org>
         <3f7257ee36dc44f162a87281c8279fd5bad91dea.camel@pengutronix.de>
         <95b4afd4-c93e-628b-fd22-6fcbc1d1234e@linaro.org>
 <b394b456540943b1022a7b093bf369924fca0566.camel@pengutronix.de>
In-Reply-To: <b394b456540943b1022a7b093bf369924fca0566.camel@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9640:EE_|DBBPR04MB7772:EE_
x-ms-office365-filtering-correlation-id: 8319b856-e3c0-4259-9f17-08db3a9d663f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1/TI6M6d6Ilq40Gk88faNw+OJoULr5X6fOiO3Mj3vNCE2knK5mVwofy2StYgyR81uLVkmjnuS8mjyGVt/TEqZGAKAYmtC6xT7vMv0nIyFtQsayz/L63RnFNOGPBKiBG92YyirznCXDKlOtwOcfsAcWusOf1yJq3YR7dlK92bp2HiKjyUOnbPBKIaSgVQkzZga8rX0HMZAWYEEbL9EIAEguj83TuTECufMvnqr0NU+xDe6g7uH26O2SztkW5JIs0LU3wCIC0H2ZNOi/ZPofAU0pYaa2JbkrOdWn4flpwiBkt32tu9G+rVPwRlZbq6F03BSFEVwm6UVefT8YoP5K1E1R5MBehmM/mI5TjfsTX7ovgRmIzbk8IPnlzlcysD8LOXFIkzxn7S/wpOPiGJFBGQk1yzXfj0hVKWqjVcgNABRWte+zf23Jh+8wgTjvrNdE4WJxp2EQl5zvA9gBnGTxz7E5Eyc3XYovZMS5vVTtE9btd/ShEnUteCRtPGNHRYXGbRPLh8cxy1fdRfh35EtzYXwlXJPbEjCCtaiNN2422COOXT2OOOMzxfc5PAlyJb844uRfaqwRAhSRTxritWCGj6TuD2fSN5HqPf1n4BfcXHlfN2OqkYrP+fjAyga4CDGqGo06DRtNhKzcj6Ja0JdHLUEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9640.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199021)(71200400001)(7696005)(478600001)(45080400002)(86362001)(83380400001)(55016003)(33656002)(921005)(122000001)(38070700005)(38100700002)(2906002)(966005)(53546011)(9686003)(316002)(110136005)(26005)(6506007)(186003)(44832011)(66476007)(64756008)(66446008)(41300700001)(8676002)(66556008)(52536014)(8936002)(7416002)(5660300002)(76116006)(66946007)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ecTYnSwh5TIxJIT58GPxrzSYSswQtuoIH82ePiRZt65nhsTFEzXVa1b7Px?=
 =?iso-8859-1?Q?Ih67AQFlpvOIT3w4hReRqoJy5A/ucpjm3nLe2GU10AAYBPtLRrKGllpivK?=
 =?iso-8859-1?Q?/5f6U4psB4h9TDc3EqVzoh6HkGcVxu9jHmPiCGKZeq+SUAiZb9yQeKTL7n?=
 =?iso-8859-1?Q?80CNYtDkBrqn5R9+vBYWf70AAaJiuln5AN4JHvUSkyKeqR2oSmzVN2WCe3?=
 =?iso-8859-1?Q?yNoXzH8oV4IT0aW/+pc1W8lRGMrUI076/MggKwOpJqy0cUyXVv/dWAkUKP?=
 =?iso-8859-1?Q?qfwl4l1wr/bN1rrBCzXNemXmrOWb8N14wNMDjwntIp1GePo/a+zqV8pjhF?=
 =?iso-8859-1?Q?E6iu2k4epc17zhrjj7ySUGlIi7J0hO2Jo+Nry3jcfgyxQueZakh1Fj8jVV?=
 =?iso-8859-1?Q?IAFVzb337QNjQU1L4bp4X8ZSqP6YO219HbBaG2F6G+91AZvnmLhQEGfyYF?=
 =?iso-8859-1?Q?+oGLqHl+iRZd8BdiOCO8fiN0PZd88rvlzDvov+cYZQSTVYa+N3q8OLh7fp?=
 =?iso-8859-1?Q?ijUtlV5Lk+uoM1EFs7choAF6Wc1wdfwHMY/q26GMw4eIpAeQmbpTTJyJkZ?=
 =?iso-8859-1?Q?k9TQfdGeZPYSH8nHMStIOkDZgkugCSdEOCvDQaqLjMPlk4UZtf+bOjEZCH?=
 =?iso-8859-1?Q?/ut1z2/iaWuCIvqEwE4v3i+634DhZFBVKAzbXRfy4MTdOHPXwiocBFxm8d?=
 =?iso-8859-1?Q?8BRGn/zbWY+RgpAeUDAt4T+25wfkRQcyZRy2HyTjP8mDEfQq4jRybOtezO?=
 =?iso-8859-1?Q?jXh+eVy+tUl7xQ96EEjICIrobLgyqMkQY6vjhy9SeLmUrZVmC++8SPPW4g?=
 =?iso-8859-1?Q?oAlofbKq4NNszXWaKeVCwZwkJqe26hfSW2NdW0q1CYU30kKhH1zh/HB5Sp?=
 =?iso-8859-1?Q?DDDycgbkxCtA4TYiPnJLvssv2XscA9TJ0AaxtCjXTof0vYAiQw2fiKz5/w?=
 =?iso-8859-1?Q?XSyN8bJ7SY5q7G3o+e8lwb7n+7ma848cZWvqezySywJNFcA8QVsyde6WY4?=
 =?iso-8859-1?Q?aVcgKmXDZl8Kl+Yyw9lxRDUzvlcFMKDLZJ3D/WgypYyHz8aVjNr8b/1Dl8?=
 =?iso-8859-1?Q?W7cnhL5l5qG7CoGsSOUSsvD+5bUXD/OSUjerhfy8gpi0Xe7sb9BWj5vGKP?=
 =?iso-8859-1?Q?dECwnUkkOsAg8rdc503bbg9pugwcsIscm9ddNovsOrxt/gSV/EW5m4H4wQ?=
 =?iso-8859-1?Q?gNyjWe3HZh0deDSvynk/ryafPbarQhJRjhM4TBjqmpYqjBhGPUuI38m1p1?=
 =?iso-8859-1?Q?hirLFVDrF9VF1gpdZhfEIkXbQE7jvglEAO91S8AqRZ1pky1dJWofgX8iKX?=
 =?iso-8859-1?Q?CwRvGXvdtIE3k5wfehMOYgclXOWH4OAr+1W9w80+PoPQiBd5Km4yRCZAqV?=
 =?iso-8859-1?Q?C8tXk+6HScSW13RjH2qqnqdBXqOT/UIXSMxi97sQ56viorLTl9TtFRUusn?=
 =?iso-8859-1?Q?DJ0Ywyjukpaug+4fBfJXdqOKQjU73ELPUASUKYzVKDvBgttWyE8+BAlgzp?=
 =?iso-8859-1?Q?SPGs7oOu2pFsf4NaOAlpkhPWN0fBsFVPU9ZwiXqR/4QyWBt5MVDIUz2wVv?=
 =?iso-8859-1?Q?6uaadn64DZc1Fmu9DVQ++Exj3W7PR+tr/omWqQGDCGvPwYj4NTHql1H5Ks?=
 =?iso-8859-1?Q?CjaBAuO0wiubo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9640.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8319b856-e3c0-4259-9f17-08db3a9d663f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 14:59:50.2477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zQqq0afIUoM1dO6ZZNueWuhOneNz8qPq3wOATgL18sj0EgztKLSBlrmdnPJ0el8k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7772
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Johannes Zink <j.zink@pengutronix.de>
> Sent: Tuesday, April 11, 2023 10:23 PM
> To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>;
> vkoul@kernel.org; kishon@kernel.org; shawnguo@kernel.org;
> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> dl-linux-imx <linux-imx@nxp.com>; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; Jun Li <jun.li@nxp.com>; Bough Chen
> <haibo.chen@nxp.com>; linux-phy@lists.infradead.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org
> Subject: Re: [PATCH 1/2] dt-bindings: phy: imx8mq-usb: add phy tuning
> properties
>
> Hi Krzystof,
>
> thank you for your explanations. As I'm still quite new to writing bindin=
gs,
> I still have some questions:
>
> On Fri, 2023-04-07 at 11:03 +0200, Krzysztof Kozlowski wrote:
> > On 05/04/2023 14:14, Johannes Zink wrote:
> > > Hi Krysztof,
> > >
> > > thanks for your review, please find my questions below.
> > >
> > > On Wed, 2023-04-05 at 13:51 +0200, Krzysztof Kozlowski wrote:
> > > > [snip]
> > > > >        A phandle to the regulator for USB VBUS.
> > > > >
> > > > > +  fsl,phy-tx-vref-tune:
> > > > > +    description:
> > > > > +      HS DC Voltage level adjustment
> > > >
> > > > "Level" in what units?
> > > >
> > >
> > > The datasheet just shows percent, ranging from -6 to +24%, in 2%
> > > increments. What unit would you suggest?
> >
> > percent
> >
> https://gith/
> >
> ub.com%2Fdevicetree-org%2Fdt-schema%2Fblob%2Fmain%2Fdtschema%2Fschemas
> > %2Fproperty-units.yaml&data=3D05%7C01%7Cjun.li%40nxp.com%7Ca2e1e5bb6a78
> 4
> >
> de5941d08db3a9847d0%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63816
> >
> 8197947407580%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu
> >
> MzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DkY4dXkOHRs9k%
> > 2BeUQ5iixLYsNC8UotIgq6eOPGjbf01o%3D&reserved=3D0
>
> I am still a bit confused how to use this properly. How can I restrict th=
e
> values to multiples of 2 in order to avoid illegal values?
>
> At the moment the only thing I could come up with is something like
>
> fsl,phy-tx-vref-tune-percent:
>   description: |
>     Adjusts the high-speed DC level voltage
>   $ref: /schemas/types.yaml#/definitions/int32
>   minimum: -6
>   maximum: 24
>   default: 0
>
> Does something like this work? I am not quite sure if I am on the right t=
rack
> here, especially as this requires a signed int, of which I have not seen
> many examples so far.
>
> Also, as far as the description is concerned: This is almost the entire
> information I there is in the datasheet. As I try to upstream some of the
> vendor downstream patches, I do not have any additional information.
>
> >
> > >
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > > +    enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
> > > > > 15,
> > > > > 16]
> > > > > +
> > > > > +  fsl,phy-tx-rise-tune:
> > > > > +    description:
> > > > > +      HS Transmitter Rise/Fall Time Adjustment
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > > +    enum: [0, 1, 2, 3]
> > > > > +
> > > > > +  fsl,phy-tx-preemp-amp-tune:
> > > > > +    description:
> > > > > +      HS Transmitter Pre-Emphasis Current Control
> > > >
> > > > If this is current then use standard unit suffixes.
> > >
> > > According to the datasheet this is in "unit amonts" of 600uA,
> > > basically 0x600uA, 1x600uA etc. Should I just suffix it with uA
> > > then?
> >
> > Yes
> >
> >
> https://gith/
> >
> ub.com%2Fdevicetree-org%2Fdt-schema%2Fblob%2Fmain%2Fdtschema%2Fschemas
> > %2Fproperty-units.yaml&data=3D05%7C01%7Cjun.li%40nxp.com%7Ca2e1e5bb6a78
> 4
> >
> de5941d08db3a9847d0%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63816
> >
> 8197947407580%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu
> >
> MzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DkY4dXkOHRs9k%
> > 2BeUQ5iixLYsNC8UotIgq6eOPGjbf01o%3D&reserved=3D0
> >
> > The register values can work sometimes fine but also do not scale at
> > all. For any other variant all the meanings will differ. Any other
> > IMX8
> > phy will need new bindings and new description/values for your
> > register-like-fields.
>
> I think this particular property should work, probably its something like
>
> fsl,phy-tx-preemp-amp-tune-microamps:
>   description: |
>     Transmitter Pre-Emphasis Current Control
>     Controls the amount of current sourced to DPn and DMn after a J-to-
> K or K-to-J transition.
>   $ref: /schemas/types.yaml#/definitions/uint32
>   minimum: 0
>   maximum: 1800
>   default: 0
>
> What's the right way to communicate that the value is in multiples of 600=
uA
> and that this is only an approximate Value? Add some free-text to the
> description?
>
>
> For some other properties, such as fsl,phy-pcs-tx-swing-full or
> fsl,phy-pcs-tx-deemph-3p5db the datasheet provides no information at all,
> neither on the unit nor on a valid range. What is the proper way for some=
thing
> like them (I try to get some of the freescale downstream patches to mainl=
ine,
> but they did not even provide bindings for their
> driver...)

I will check with internal design team for those not well documented
properties.

Li Jun
>
>
> For fsl,phy-comp-dis-tune-percent, the actual values to not map well to
> integer amount of percent, but I have not found a permill in property- un=
its.
> Also, as the steps appear quite arbitrary large, what is the correct way
> of restricting the values to valid values that the hardware can actually
> support? As reference, I have only seen stuff like the st,trim-hs-current
> in Documentation/devicetree/bindings/phy/phy-stm32-
> usbphyc.yaml so far...
>
> Thanks for helping me and best regards
> Johannes
>
>
> >
> > Best regards,
> > Krzysztof
> >
> >
> >
>
> --
> Pengutronix e.K.                | Johannes Zink                  |
> Steuerwalder Str. 21            |
> https://www.p/
> engutronix.de%2F&data=3D05%7C01%7Cjun.li%40nxp.com%7Ca2e1e5bb6a784de5941d
> 08db3a9847d0%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6381681979474
> 07580%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBT
> iI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DDq06I6tprUib5nOmp4pDFdY
> MgYULn8MLj5iHwVlQHMY%3D&reserved=3D0    |
> 31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
> Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

