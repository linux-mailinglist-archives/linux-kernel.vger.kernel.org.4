Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351FE6EF1D9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 12:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240201AbjDZKX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 06:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjDZKX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 06:23:56 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CEE3C0C;
        Wed, 26 Apr 2023 03:23:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOhkWUBKux3HMga/A6Y8w37fXRi9C3LPjAYtr+/utCNCbFLC5JsEgkE8oA8jd6dlCA1dGys4C3SSRWMvE2OerIyklDZHRYZXgsM/cdcxMxX7dTes2M+awrddYQF7H/hxYmPWS9V7YWAw7L9ghvB3ZLy2VZ28CRooEQVoYTfsPqPdzHc8HQjCON6/qwetFNaqa0nswWPdtyDPGECmQWHStg1ig8XxE4eKM/yu9MzoCO8BnPRx1AMm6QRtu26HML1CSNDBmfIHvCvkbEWHgUQNUhYYSHKMme8fE5L1rv0XcX5MYnBu5rgKTcXpHooPfjfd21Po1ZuIeLDuZ3wsVPvCOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZ+j3s8+Z7/aQR2hbsGYDzuyzKvLWv1+PwV9CT/G6ME=;
 b=eMp2W4L0f+eTSLuTylGbPhPSfrlux5peZtPUqCg5xVgTNS6NOZnGQvzE6l7K8yBkcru3AQJRBvj0UU0KM9H5WNqDxa+Jhg6Mvy14zIx60RXqa/Pz30lEH0Uq/HAANYFRrJLaWnNMWzqVJXNR8n6OjwTx8gbR8FqiKEGds+Tdb5J6lLTJibkU+bJam0oMqU1iBWdshX44ylQ7qYM0RkIxZMeg4XTlhlCG2XaYdqg8qfDXnCAaqA9CpVv2Xoa1lXtI18FEbgW3CbHE35ruaWEfSk1DBVqq/GChbnYtdSWEB+Y/DLyyPu/usvlGg9WS8e8m8w1B24SH2fi/DS1hdOiL3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZ+j3s8+Z7/aQR2hbsGYDzuyzKvLWv1+PwV9CT/G6ME=;
 b=Ja9nBVy+7Nz5nEpo0CB+U8RJ4pbJq1GcriqQUnuSESWK32DRdcg36w1VjGJUcVhkM5LctKtVujjTnUF/eHJekwa+3wec1sXrxCuSLaeJLzAEDWOSEO+vl/v4zh1v1g7BLLbG3K22dVPLoMudVhrDbED0Wmg4dsqhEFD8foTgUC4=
Received: from PA4PR04MB9640.eurprd04.prod.outlook.com (2603:10a6:102:261::21)
 by AM9PR04MB8956.eurprd04.prod.outlook.com (2603:10a6:20b:40b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 10:23:51 +0000
Received: from PA4PR04MB9640.eurprd04.prod.outlook.com
 ([fe80::adc9:9956:50dc:d10e]) by PA4PR04MB9640.eurprd04.prod.outlook.com
 ([fe80::adc9:9956:50dc:d10e%6]) with mapi id 15.20.6319.033; Wed, 26 Apr 2023
 10:23:51 +0000
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
Thread-Index: AQHZZ7DMcw1qaTO5G06hSinhQXI+gq8cmmgAgAAGjwCAAu9aAIAGom6AgAAJpbCAAAcZAIAXOzSg
Date:   Wed, 26 Apr 2023 10:23:51 +0000
Message-ID: <PA4PR04MB9640B33A3B4A2EFC9F3EBBE489659@PA4PR04MB9640.eurprd04.prod.outlook.com>
References: <20230405112118.1256151-1-j.zink@pengutronix.de>
         <20230405112118.1256151-2-j.zink@pengutronix.de>
         <5398cbe0-c681-5dd7-0b3e-3a586cc4915f@linaro.org>
         <3f7257ee36dc44f162a87281c8279fd5bad91dea.camel@pengutronix.de>
         <95b4afd4-c93e-628b-fd22-6fcbc1d1234e@linaro.org>
         <b394b456540943b1022a7b093bf369924fca0566.camel@pengutronix.de>
         <PA4PR04MB9640611A4FF721349025BF1E899A9@PA4PR04MB9640.eurprd04.prod.outlook.com>
 <2c6f4794540587ea308b976abbc9a2f58e7f28cb.camel@pengutronix.de>
In-Reply-To: <2c6f4794540587ea308b976abbc9a2f58e7f28cb.camel@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9640:EE_|AM9PR04MB8956:EE_
x-ms-office365-filtering-correlation-id: ea5861cf-7689-4908-fbaf-08db46405470
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MQotEmXFLKKLgftleg7r4D5i8G24Ko58/CxkDM8CRq8CZTtLxnryEKdOMM/3pirLk3hUPzTdTddapF40Utak9tO4BSDqHWdFCy0UOm2cD2kzjAqUuSJak4fFypGQhZ9CyGkcgmASTyz3X1PbqAuH9ncESi6qu3fXpFQXBu1UiuFzCrWelXCn8gZTunonAdD1lt81Ha1BEKWDCWOALnfGZeeFJjQ1pFv06V1n/c+DmtbbmFjO2GnIftciyjiFuMXJ+Lt4H212VdtdM+Exiq8jnL72QrA2C0hEelQ9uu7ioqULhM5KeIyFPg9iHcK+VOsLDWWHoxKLt/u+DSGsSnbFtANdJquwNRF1YbK0kSVEP4yZRM91V5JPNvdjxD6uu7t+Wm6bKYxj9e3lh+aOyMsmgZ+aQcqqSDiNetnjjYZ/J9nV2JJUZZhv07KeORJQKTyUslRt0sOCjf48DgQPSt7gblCnedmltXjjj/mt4W+Ll1NydwfimcphiPSxapYLyFsXXHAmPw+ozaU6J3OnaSqmqmzBCSJSFf0SGeBEf2bHdTq5IE61aIaYH0OdKvNxvahHT+M68P3Z2nbq9njuf1NbPTBP43UCEX8rOvp25FdnUmjiZTZdf4vS2zk2QkPC6o6kOp7l7bNIwhxKK8Eex+Fy2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9640.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199021)(83380400001)(2906002)(7416002)(44832011)(52536014)(8676002)(8936002)(5660300002)(921005)(6506007)(53546011)(9686003)(186003)(38100700002)(122000001)(26005)(41300700001)(38070700005)(71200400001)(66446008)(66556008)(64756008)(66476007)(86362001)(7696005)(66946007)(55016003)(478600001)(110136005)(76116006)(33656002)(316002)(966005)(45080400002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3bq9v1y5wZ8Ve6LyyR+1KFzK+l9cIDXR9fTTF6QiVpMAQiARhroTp/3+Mb?=
 =?iso-8859-1?Q?RScL5w3tHVQfhUOizIFFKRwwbboDXXpogaZLuQZ3NRp38jlpML4hzbqWjc?=
 =?iso-8859-1?Q?rwEF4GA+uoG+iO0CO/l+l0BkORcWyz2515eQb4i777rwTSokvci3r+Frfu?=
 =?iso-8859-1?Q?vjSpJqRQXDQtnvM3Hbwv9ocxQCKpzCz7uFzoIWt/2eVi38rHSY0UqOGK4B?=
 =?iso-8859-1?Q?dUPvGHPe1qh0TyVb2RTDR25AufuwIgjsrDjBOXLW7LhncJMtnSkD0/NBaO?=
 =?iso-8859-1?Q?bF9TYZT8w3T0xVVV6Y0v9I7xoCAmWe6fCnCtvuKse9j2c6FwOukWHM2dq3?=
 =?iso-8859-1?Q?+EmMev7mMl8gezbQFIzyLqndVvckErYJkCHU4vmZxsISsdDZknynRxPs1T?=
 =?iso-8859-1?Q?8m+DLDASjSYIWWZgq40YvZ4YN/+CEUKLA15gJj3WhaHwLhFOkV9QzNzJvw?=
 =?iso-8859-1?Q?EWGedN5XZNk1caDHPPYl4yrqbcSTm8I8AeyaLPa8ceAXc1sx0xFUOr+p8K?=
 =?iso-8859-1?Q?/msX3SSR8YWJphmGBjbxPWW/4v/ZHkZTxwc5szgKd3skijatgHa1N4nxet?=
 =?iso-8859-1?Q?aQgAexOlQo6tGkP3GaBJbqqSwXISXEOQZw74kHpIb8IN7xLJavdNkJu1yn?=
 =?iso-8859-1?Q?Tpc0aMOmPmon6UP6ru5W5+9MKnO4OBE1gCC4aHMKmnnJmDE+AcmQC87Pp9?=
 =?iso-8859-1?Q?orFHCG3D8ZAiU73JdDBO3zzb7XeuTfUAIZyw891rS6DDdaQpp3/PR2lazn?=
 =?iso-8859-1?Q?xxsyQRoiDC/r8HeMOUn4IsmUIyjV5FY6hnFqF4y1iYMThhcnP+Yk7lEt9j?=
 =?iso-8859-1?Q?bKft5lAiUHJRKymoVuAbgsENvy5TnzDGAj83ok5dth3XXbYWxfZyYaC5j3?=
 =?iso-8859-1?Q?JB3qNbusbTZEoP3sD6Eq8YcO2yPoVRpbzsJSh87qXg6JGF2+UVsmyCZ8jO?=
 =?iso-8859-1?Q?RSp3stjYC6UF8Ji5V5/xqlQv3KgTFy8Lc7yFg2KmQEFwLcDFkdgteDFai1?=
 =?iso-8859-1?Q?Qt3Ch1UF9W/fR4R1KMDgh6nMDvSHlTGWOOQSVMIsqUayzKZDGO+9YnMvgw?=
 =?iso-8859-1?Q?96xBQpHf7LEVpT7TzYZgAzfIHe1VkzeJghChtvL2v0Y15DGL8vrCzFjIqY?=
 =?iso-8859-1?Q?FFkAw+7j9ssh4Cx0lnVrQE33OGEfePrs6G/T252jvgQZFmXbVYgwrrYFtc?=
 =?iso-8859-1?Q?gYE/q2S5Io2FLxYJj2CFpZ+27xmI0vtH4TFTvsuCgYWiXlQwEbncL8HMVZ?=
 =?iso-8859-1?Q?aRASS94DfgYSn+IG3AEWNWjj8Uero6TXeW4/lFafUYu51/iR5D8W7/VW3r?=
 =?iso-8859-1?Q?JVIoxq1RA9xn0uYj9hdxKU0l0VKqxiCbOJnZoh+tNOVsZgeOk18naJKI5e?=
 =?iso-8859-1?Q?kbcagx5QVG403oVNKd6kLTG6w7RuUQkYO4uKE6F9Ni/8J1+MYK4Q4K4KVx?=
 =?iso-8859-1?Q?qpVQqXpbjvAcvE1hhjl6Pu3bh7cY1v6T4qGMY2GAH3iGnA52XxUEVbD3AF?=
 =?iso-8859-1?Q?pLDkO5FM8lDS3owBe4n8R4AV9TMTA0OaROGHWzPqFYqeNkf5j6gMXy+zna?=
 =?iso-8859-1?Q?xj0Czztq6fLb5hGcKDEdlDquPU/VsrU/hpIX4KJcasyJ/V+3Wo4c/EvxtX?=
 =?iso-8859-1?Q?wyy8MXwATpxzM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9640.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5861cf-7689-4908-fbaf-08db46405470
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 10:23:51.1266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P6Km80RLsdqfk0UmBxQrrbUavxNmUQJV7KASAORvGpXX62jm9v0P8KDyKfggYHWG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8956
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
> From: Johannes Zink <j.zink@pengutronix.de>
> Sent: Tuesday, April 11, 2023 11:23 PM
> To: Jun Li <jun.li@nxp.com>; Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org>; vkoul@kernel.org; kishon@kernel.org;
> shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; Bough Chen <haibo.chen@nxp.com>;
> linux-phy@lists.infradead.org; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [PATCH 1/2] dt-bindings: phy: imx8mq-usb: add phy tuning
> properties
>
> Hi Jun,
>
> On Tue, 2023-04-11 at 14:59 +0000, Jun Li wrote:
> >
> >
> > > -----Original Message-----
> > > From: Johannes Zink <j.zink@pengutronix.de>
> > > Sent: Tuesday, April 11, 2023 10:23 PM
> > > To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>;
> > > vkoul@kernel.org; kishon@kernel.org; shawnguo@kernel.org;
> > > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > > dl-linux-imx <linux-imx@nxp.com>; robh+dt@kernel.org;
> > > krzysztof.kozlowski+dt@linaro.org; Jun Li <jun.li@nxp.com>; Bough
> > > Chen <haibo.chen@nxp.com>; linux-phy@lists.infradead.org;
> > > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > > devicetree@vger.kernel.org
> > > Subject: Re: [PATCH 1/2] dt-bindings: phy: imx8mq-usb: add phy
> > > tuning properties
> > >
> > > Hi Krzystof,
> > >
> > > thank you for your explanations. As I'm still quite new to writing
> > > bindings, I still have some questions:
> > >
> > > On Fri, 2023-04-07 at 11:03 +0200, Krzysztof Kozlowski wrote:
> > > > On 05/04/2023 14:14, Johannes Zink wrote:
> > > > > Hi Krysztof,
> > > > >
> > > > > thanks for your review, please find my questions below.
> > > > >
> > > > > On Wed, 2023-04-05 at 13:51 +0200, Krzysztof Kozlowski wrote:
> > > > > > [snip]
> > > > > > >        A phandle to the regulator for USB VBUS.
> > > > > > >
> > > > > > > +  fsl,phy-tx-vref-tune:
> > > > > > > +    description:
> > > > > > > +      HS DC Voltage level adjustment
> > > > > >
> > > > > > "Level" in what units?
> > > > > >
> > > > >
> > > > > The datasheet just shows percent, ranging from -6 to +24%, in 2%
> > > > > increments. What unit would you suggest?
> > > >
> > > > percent
> > > >
> > > https://gith/
> > > >
> > > ub.com%2Fdevicetree-org%2Fdt-
> > > schema%2Fblob%2Fmain%2Fdtschema%2Fschemas
> > > > %2Fproperty-
> > > > units.yaml&data=3D05%7C01%7Cjun.li%40nxp.com%7Ca2e1e5bb6a78
> > > 4
> > > >
> > > de5941d08db3a9847d0%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63
> > > 816
> > > >
> > > 8197947407580%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV
> > > 2lu
> > > >
> > > MzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DkY4dXkOHRs
> > > 9k%
> > > > 2BeUQ5iixLYsNC8UotIgq6eOPGjbf01o%3D&reserved=3D0
> > >
> > > I am still a bit confused how to use this properly. How can I
> > > restrict the values to multiples of 2 in order to avoid illegal
> > > values?
> > >
> > > At the moment the only thing I could come up with is something like
> > >
> > > fsl,phy-tx-vref-tune-percent:
> > >   description: |
> > >     Adjusts the high-speed DC level voltage
> > >   $ref: /schemas/types.yaml#/definitions/int32
> > >   minimum: -6
> > >   maximum: 24
> > >   default: 0
> > >
> > > Does something like this work? I am not quite sure if I am on the
> > > right track here, especially as this requires a signed int, of which
> > > I have not seen many examples so far.
> > >
> > > Also, as far as the description is concerned: This is almost the
> > > entire information I there is in the datasheet. As I try to upstream
> > > some of the vendor downstream patches, I do not have any additional
> > > information.
> > >
> > > >
> > > > >
> > > > > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > > > > +    enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13,
> > > > > > > 14,
> > > > > > > 15,
> > > > > > > 16]
> > > > > > > +
> > > > > > > +  fsl,phy-tx-rise-tune:
> > > > > > > +    description:
> > > > > > > +      HS Transmitter Rise/Fall Time Adjustment
> > > > > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > > > > +    enum: [0, 1, 2, 3]
> > > > > > > +
> > > > > > > +  fsl,phy-tx-preemp-amp-tune:
> > > > > > > +    description:
> > > > > > > +      HS Transmitter Pre-Emphasis Current Control
> > > > > >
> > > > > > If this is current then use standard unit suffixes.
> > > > >
> > > > > According to the datasheet this is in "unit amonts" of 600uA,
> > > > > basically 0x600uA, 1x600uA etc. Should I just suffix it with uA
> > > > > then?
> > > >
> > > > Yes
> > > >
> > > >
> > > https://gith/
> > > >
> > > ub.com%2Fdevicetree-org%2Fdt-
> > > schema%2Fblob%2Fmain%2Fdtschema%2Fschemas
> > > > %2Fproperty-
> > > > units.yaml&data=3D05%7C01%7Cjun.li%40nxp.com%7Ca2e1e5bb6a78
> > > 4
> > > >
> > > de5941d08db3a9847d0%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63
> > > 816
> > > >
> > > 8197947407580%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV
> > > 2lu
> > > >
> > > MzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DkY4dXkOHRs
> > > 9k%
> > > > 2BeUQ5iixLYsNC8UotIgq6eOPGjbf01o%3D&reserved=3D0
> > > >
> > > > The register values can work sometimes fine but also do not scale
> > > > at all. For any other variant all the meanings will differ. Any
> > > > other
> > > > IMX8
> > > > phy will need new bindings and new description/values for your
> > > > register-like-fields.
> > >
> > > I think this particular property should work, probably its something
> > > like
> > >
> > > fsl,phy-tx-preemp-amp-tune-microamps:
> > >   description: |
> > >     Transmitter Pre-Emphasis Current Control
> > >     Controls the amount of current sourced to DPn and DMn after a
> > > J-to-
> > > K or K-to-J transition.
> > >   $ref: /schemas/types.yaml#/definitions/uint32
> > >   minimum: 0
> > >   maximum: 1800
> > >   default: 0
> > >
> > > What's the right way to communicate that the value is in multiples
> > > of 600uA and that this is only an approximate Value? Add some
> > > free-text to the description?
> > >
> > >
> > > For some other properties, such as fsl,phy-pcs-tx-swing-full or
> > > fsl,phy-pcs-tx-deemph-3p5db the datasheet provides no information at
> > > all, neither on the unit nor on a valid range. What is the proper
> > > way for something like them (I try to get some of the freescale
> > > downstream patches to mainline, but they did not even provide
> > > bindings for their
> > > driver...)
> >
> > I will check with internal design team for those not well documented
> > properties.
> >
>
> That's great, thanks!

Here is the feedback from our design team:

Per the USB specification, the TX de-emphasis value is 3.5dB nominal.
Only pcs_tx_deemph_3p5db is used for USB3.  pcs_tx_deemph_6db[5:0] is not u=
sed.
pcs_tx_deemph_3p5db[5:0] range is between 0dB to -36dB (unit step in decima=
l 1)
pcs_tx_swing_full[6:0] range is from 0 to full scale 127(decimal), with uni=
t step in decimal 1.
TX amplitude is determined by ( voltage corresponding to tx_vboost_lvl) * (=
pcs_tx_swing_full +1 )/128
The actual TX swing value should be decided by characterization with the pa=
ckage and PCB.

Li Jun
>
> Johannes
>
> > Li Jun
> > >
> > >
> > > For fsl,phy-comp-dis-tune-percent, the actual values to not map well
> > > to integer amount of percent, but I have not found a permill in
> > > property- units.
> > > Also, as the steps appear quite arbitrary large, what is the correct
> > > way of restricting the values to valid values that the hardware can
> > > actually support? As reference, I have only seen stuff like the
> > > st,trim-hs- current in
> > > Documentation/devicetree/bindings/phy/phy-stm32-
> > > usbphyc.yaml so far...
> > >
> > > Thanks for helping me and best regards Johannes
> > >
> > >
> > > >
> > > > Best regards,
> > > > Krzysztof
> > > >
> > > >
> > > >
> > >
> > > --
> > > Pengutronix e.K.                | Johannes Zink                  |
> > > Steuerwalder Str. 21            |
> > > https://ww/
> > > w.p%2F&data=3D05%7C01%7Cjun.li%40nxp.com%7C4cfd371e93084ee8c43908db3a=
a
> > > 0a30c%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63816823382425151
> > > 8%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTi
> > > I6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DEsH%2B63B32iGAJEzk9T=
c
> > > BYdcMFqnVLzr1D8t9D%2Bl0J5o%3D&reserved=3D0
> > > engutronix.de%2F&data=3D05%7C01%7Cjun.li%40nxp.com%7Ca2e1e5bb6a784de5
> > > 941d
> > > 08db3a9847d0%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638168197
> > > 9474
> > > 07580%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiL
> > > CJBT
> > > iI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DDq06I6tprUib5nOmp4p
> > > DFdY
> > > MgYULn8MLj5iHwVlQHMY%3D&reserved=3D0    |
> > > 31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
> > > Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |
> >
> >
> >
>
> --
> Pengutronix e.K.                | Johannes Zink                  |
> Steuerwalder Str. 21            |
> https://www.p/
> engutronix.de%2F&data=3D05%7C01%7Cjun.li%40nxp.com%7C4cfd371e93084ee8c439
> 08db3aa0a30c%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6381682338242
> 51518%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBT
> iI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D80YR6G0A347G%2FMI9ksARn
> VSqXVQXORt8pNBQjRoIBVY%3D&reserved=3D0    |
> 31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
> Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

