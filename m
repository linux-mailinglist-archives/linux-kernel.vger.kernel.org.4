Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53CE5FC40F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 12:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiJLK5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 06:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJLK5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 06:57:41 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20067.outbound.protection.outlook.com [40.107.2.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFB5B56F8;
        Wed, 12 Oct 2022 03:57:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jClj1hUVFHZwwZpRwiwzU+9oQecEfoBnBfjInEJqrWjA+HWyV17D4wPa5cnndkB6s/1qOXHrf718DOtodPsQ5WG1t7Y1VU4lT7Nka9/Pgrz/OGA5jYTN5n0GjKFT/uqPbnLzVWzEYmwG8Equ2uBOoHVmW+RopvRBGVRFOMjvMhdolyWR/vlnDbrW7inMAvjvoXwdTkAsUw3m4m/1YyxwhUrVUL/QWLRjk+Hiwoh2imqlLJGrB//8Hw2pN3FLKsrU5RJRW7i2XW/3swgk3B0DP7BPqoYCuSYobfsPCZ5hlBHie3S0rwwEuWElHal0NAdbOkHz3x5jJnFhP5Orwrx4Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBwwp0raNJJUpgx9b3e9uvPPdrhHI8pJRGsx8vN6nHU=;
 b=eza1KzLXbeSEKmbAVRxsdIk4vJE+8NNX5UdNFegiqi5aFameAqWJCKs1czPUVaAQhItUn/Fv9/n8PZhgxRTCTTDpM1QyPb/ZzAbRkJ3AruOauGt/bRfWfavKtZ1A/UV6/FHQpBI+H8ry9XMQSCFuk39USwKSl9j9F0J85sAFdRFKch8a+AhG04X5+haRAzkEr7llzZiJ4hAYZdrMnqjdPbejM+ymHGMKvfkB27vNUHzeneZS3EfZkkOtohfCu0bQK5yLMQC8RPJjwfJYJXAonVK96GPAmn1ivpnz+bl1lrIcxib7VcXDKyZdpmqqUHtZafqgg4w/mWKYO+X/JqT44g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBwwp0raNJJUpgx9b3e9uvPPdrhHI8pJRGsx8vN6nHU=;
 b=qLgCDHHhnj7rzROlY91Qe1D/2nS4n9UGKm+7mQgKnNzme9Kwn7kvawcBrK4dQM58pExY4t9Vs2IsFi26EhpsK8I5qKxXaQ+df4gNRk2lQ/rSJrRhC3GikFB0YGBbf+EvMjV3MdxpLbfgtIUPB1H9xmkYPBxm25Zq/kptEPsZ3m8=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7310.eurprd04.prod.outlook.com (2603:10a6:800:1a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 10:57:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a%4]) with mapi id 15.20.5676.028; Wed, 12 Oct 2022
 10:57:35 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
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
        <linux-arm-kernel@lists.infradead.org>, Jun Li <jun.li@nxp.com>
Subject: RE: [PATCH 1/6] dt-bindings: usb: ci-hdrc-usb2: convert to yaml
Thread-Topic: [PATCH 1/6] dt-bindings: usb: ci-hdrc-usb2: convert to yaml
Thread-Index: AQHY3JFpH3+SFeJjVEaQOeCmvKBDc64HigSAgALMjCA=
Date:   Wed, 12 Oct 2022 10:57:35 +0000
Message-ID: <DU0PR04MB941725BA968BC4D08697A5EC88229@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20221010101816.298334-1-peng.fan@oss.nxp.com>
 <20221010101816.298334-2-peng.fan@oss.nxp.com>
 <20221010121233.GA419967-robh@kernel.org>
In-Reply-To: <20221010121233.GA419967-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|VE1PR04MB7310:EE_
x-ms-office365-filtering-correlation-id: c73477c4-9bc2-45e4-b2eb-08daac4091df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LOgNxJ7Dzu+dsLIzDJhRcPAZ0UGbCflqUwk1t8yYqgv8JYw72bSvToITqfcldDNCSQM6ZoT5+5PnKqHynnP8oZmJQZuxYQJABmukAjopyU0HBX1g3eLEwx52tKRRrRh+x1cOxmGaNieGwAWWMoGiYG7akj9M+qrbD1U774rivtW6kbHZ9pIhZBmQ4RBM7jN6QaQskEBwMAekcYtIStdAgfopSxdIdvE7vzThOC2Th1v7FE5QbYWwpfk47pvq2L0Ww2oZAaumc7B31kiMjrKTaGPpIk1c7IkkhsoJWaP42BLYItkH2jlMyTl4T59/8MnYrmWIcXfgIC2NlnXA8tHkA6ldIZVnPlFHConJU93eqmt1eebG+WMLy2rVKonNlF17LMfyGDkMWjiC8Bml/5w4TauWn13y1/iWbw3CUxO18Sc7C6V4NU3FVbgib7YntHptCOw2ZC790e8vDICcOVkjwoMw24gZHsoFiuAxIC96ds0OsWiP0WMkozm1BfUGk88ex+FM2LlOmAJX1YXvao7dtD0Vq145cE2QsEWdIFyyPkKl/DlENtoOO8lSEY9YBU7ePxG6IeHE62tJ4Zj8DA7lhQ3+S1m813rd2KWyOxB8ULVZKntB5v2Vt1oosq6IMj1Saq7t41+nF8rapkvH7o2uFoSwo6LTLDNyHtgbcFyy4+QcaAQ5FgF27dyS2ycLzHWpnXhw/5q4uR07xCustq4ulRChzYhacgWB36cyk/LKqRExdYmIH9zNdQZHm6cANl+jSs2x4/WLvw8fTzDJliJzJOpYtX8PB9TPGOh4fFvfqc8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(451199015)(44832011)(30864003)(186003)(7416002)(45080400002)(38100700002)(478600001)(5660300002)(54906003)(110136005)(71200400001)(8936002)(83380400001)(316002)(26005)(2906002)(52536014)(9686003)(122000001)(33656002)(86362001)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(7696005)(6506007)(38070700005)(41300700001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uwquxdC7boDil0MKoAZO9QIgQxKofwaxEakLq26EMHUNugH0Pt1qBrAApguH?=
 =?us-ascii?Q?n1UIqWvywFt0FTC492UfHqzmE6kupRKXPSZ7y7iqVEXwp4XhXEX4jnLY0i3H?=
 =?us-ascii?Q?e5TjUSIHFdJeCUQIKUGqKJznzjmv7wlcoqRashGETPRj2VydNH8/Bq1GNu/x?=
 =?us-ascii?Q?2NzHHvdo9Ej5sCbwCjGey70crt+epkQJJcfLmxsWX1S676maa772ektZuknE?=
 =?us-ascii?Q?agS4YkwisCmkQq5amdQWb8HS6OkctApOY8lixOnt4iLxgPDvp4u0unyMwyFu?=
 =?us-ascii?Q?zvVeIka/wtC2aB1kwaMsy0HwdfZ2p/H4Aqxfklc/0S+wT3m9XwGyUCHAFirb?=
 =?us-ascii?Q?WPjN2B+A0s9ulugDpX0QDp9ma/3ZN1rkbRvkuClHI+KcKLrFEPRZOjHKkOVz?=
 =?us-ascii?Q?OiSKXFZvBdz4rtm1/lv3tnYd4HCwOlCn9l+fLBpVZEq3sbOcEYEXcYBVPyRb?=
 =?us-ascii?Q?AUJC++2V/Nps9fuMlPAee6p+BCT+ZkNfdtqrzNtBlC+VcQu1+SVzrPCYgM5A?=
 =?us-ascii?Q?NdFSUqi0YSjtFHfCPJoB+LkMJVPnRR3IFD4vxTSkpZN+lkc8fRGdvTImRhLI?=
 =?us-ascii?Q?UAD/5b4C84ypS3kFeCrc60XkqRJIADTdiOornvXHYFda3t1g2X/+ic/kgYv/?=
 =?us-ascii?Q?K0oXRMfTvSep89l3wLt5PGBeCLEYWrt5nv6QXSx65FzuvRDEYqB36GY72AGp?=
 =?us-ascii?Q?ZHKeGTc4nqGgp0t+kYn5GWNjqef5/P71skDtrjUi7PVp837MEidk0x0BP+2C?=
 =?us-ascii?Q?mGSxP8Ez3T7hd+q9hPUqlUni5RX3mmRt5p4uDJ8RruGNn/iPv162zmItdktY?=
 =?us-ascii?Q?ba+i15hAN4FO/TSD5Li7SXxC8/H1VxVaRhsJ1nyb3f+PU7FWXz2OoB5/ATsv?=
 =?us-ascii?Q?5V+iwR4U+0p3k/lfus8hv5+NaG9t1ScqVLlehOtEMTxUFX8ebDH0t338nh6h?=
 =?us-ascii?Q?BZUrPx6jmGfMRoXSdSoIzGIX+p3yZNwrhcbSqhcdKl+0+jOVu/lXPwoVdZRS?=
 =?us-ascii?Q?vx9SxAcz24Awu66pX1sm8eCthkAk44MsTabCgBOUENbkOYgDph8SeExUOvrn?=
 =?us-ascii?Q?Wl481Tf8VrljagU45iGWR4QwvQoEmxYRLGkoQE58qibsfjdkG7HpTfBxv17B?=
 =?us-ascii?Q?DBRwRHgld2yU5fOJC6YvBbZgGQRKG393dBNDbMHn73ksjuai0+xgh68JldFy?=
 =?us-ascii?Q?mr7662WauDSpYKI7KDmHVWqFUAFZdtWcE0VlfU+8jhs4cMef4EEiEEkG4V7L?=
 =?us-ascii?Q?V1gnzFBu42Uc3oLFB9NgJRwgwlhHHK3tIubJwVcCxJ6Ln4cQtwAGS1Jp4o5+?=
 =?us-ascii?Q?CXopEz8XbU7HM/wh9YQJQPgcvF6dqmQ81FU0jRD/9qimChwtES2nMmgisWbd?=
 =?us-ascii?Q?dzBSDRBmQKAAkucQHaq6zQF5VZQzQXzx1/A28ABWRXRcG4TX/zM4Fk8AblaD?=
 =?us-ascii?Q?K92vMkSv+0e6p8/CWLaUvOK0WzO3KB9FL5cd3rCeEUEOlSlkpTDXHQthE2BC?=
 =?us-ascii?Q?eXjjWV/+AF8CJLbFieGVR7OU3egoUu/NiSq3d3tVbsYkVrcEG3UVVywvBCNP?=
 =?us-ascii?Q?B66ZHqP6Hd9Ln2JB7IEG8ghuQHLEdO8anbEZDpBX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c73477c4-9bc2-45e4-b2eb-08daac4091df
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 10:57:35.1275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BjC//01eo3uPKOJPqvdYE1dAp9ia+C7SYl7uCLSAYdgKoQajA1h3xdb9m2GZvHqGIwUvhOdKXD55VDT3aNzo4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7310
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 1/6] dt-bindings: usb: ci-hdrc-usb2: convert to yaml
>=20
> On Mon, Oct 10, 2022 at 06:18:11PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Convert the binding to yaml format
>=20
> s/yaml/DT schema/
>=20
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../devicetree/bindings/usb/ci-hdrc-usb2.txt  | 158 ---------
> > .../devicetree/bindings/usb/ci-hdrc-usb2.yaml | 306 ++++++++++++++++++
> >  2 files changed, 306 insertions(+), 158 deletions(-)  delete mode
> > 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
>=20
> > diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
> > b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
> > new file mode 100644
> > index 000000000000..1c10691c45f2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
> > @@ -0,0 +1,306 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> >
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> > +cetree.org%2Fschemas%2Fusb%2Fci-hdrc-
> usb2.yaml%23&amp;data=3D05%7C01%7C
> >
> +peng.fan%40nxp.com%7Cfc258d6827034e160b4908daaab8b693%7C686ea
> 1d3bc2b4
> >
> +c6fa92cd99c5c301635%7C0%7C0%7C638010007567431723%7CUnknown%
> 7CTWFpbGZs
> >
> +b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> Mn0%3
> >
> +D%7C3000%7C%7C%7C&amp;sdata=3Dg%2FCjkGDjScTAOc1PQg1BI9GjC%2Fg
> XRK5DuyHcT
> > +NjLCZQ%3D&amp;reserved=3D0
> > +$schema:
> >
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> > +cetree.org%2Fmeta-
> schemas%2Fcore.yaml%23&amp;data=3D05%7C01%7Cpeng.fan%
> >
> +40nxp.com%7Cfc258d6827034e160b4908daaab8b693%7C686ea1d3bc2b4c
> 6fa92cd9
> >
> +9c5c301635%7C0%7C0%7C638010007567431723%7CUnknown%7CTWFpb
> GZsb3d8eyJWI
> >
> +joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> C3000%
> >
> +7C%7C%7C&amp;sdata=3Ds61yrkTxGglHJ7d9oL8WGD7fQYMeDDnZHi21c6Wg
> %2B6k%3D&a
> > +mp;reserved=3D0
> > +
> > +title: USB2 ChipIdea USB controller for ci13xxx Binding
> > +
> > +maintainers:
> > +  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - enum:
> > +          - chipidea,usb2
> > +          - lsi,zevio-usb
> > +          - nvidia,tegra20-udc
> > +          - nvidia,tegra30-udc
> > +          - nvidia,tegra114-udc
> > +          - nvidia,tegra124-udc
> > +          - qcom,ci-hdrc
> > +      - items:
> > +          - enum:
> > +              - fsl,imx23-usb
> > +              - fsl,imx25-usb
> > +              - fsl,imx28-usb
> > +              - fsl,imx6q-usb
> > +              - fsl,imx6sl-usb
> > +              - fsl,imx6sx-usb
> > +              - fsl,imx6ul-usb
> > +              - fsl,imx7d-usb
> > +          - const: fsl,imx27-usb
> > +      - items:
> > +          - const: fsl,imx7ulp-usb
> > +          - const: fsl,imx6ul-usb
> > +      - items:
> > +          - const: lsi,zevio-usb
> > +      - items:
> > +          - const: xlnx,zynq-usb-2.20a
> > +          - const: chipidea,usb2
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 2
> > +
> > +  itc-setting:
> > +    description:
> > +      interrupt threshold control register control, the setting should=
 be
> > +      aligned with ITC bits at register USBCMD.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  ahb-burst-config:
> > +    description:
> > +      it is vendor dependent, the required value should be aligned wit=
h
> > +      AHBBRST at SBUSCFG, the range is from 0x0 to 0x7. This property =
is
> > +      used to change AHB burst configuration, check the chipidea spec =
for
> > +      meaning of each value. If this property is not existed, it will =
use
> > +      the reset value.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0x0
> > +    maximum: 0x7
> > +
> > +  tx-burst-size-dword:
> > +    description:
> > +      it is vendor dependent, the tx burst size in dword (4 bytes), Th=
is
> > +      register represents the maximum length of a the burst in 32-bit
> > +      words while moving data from system memory to the USB bus, the
> value
> > +      of this property will only take effect if property "ahb-burst-co=
nfig"
> > +      is set to 0, if this property is missing the reset default of th=
e
> > +      hardware implementation will be used.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  rx-burst-size-dword:
> > +    description:
> > +      it is vendor dependent, the rx burst size in dword (4 bytes), Th=
is
> > +      register represents the maximum length of a the burst in 32-bit =
words
> > +      while moving data from the USB bus to system memory, the value o=
f
> > +      this property will only take effect if property "ahb-burst-confi=
g"
> > +      is set to 0, if this property is missing the reset default of th=
e
> > +      hardware implementation will be used.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  extcon:
> > +    description: |
> > +      Phandles to external connector devices. First phandle should poi=
nt
> > +      to external connector, which provide "USB" cable events, the sec=
ond
> > +      should point to external connector device, which provide "USB-HO=
ST"
> > +      cable events. If one of the external connector devices is not
> > +      required, empty <0> phandle should be specified.
> > +
> > +  phy-clkgate-delay-us:
> > +    description: |
> > +      The delay time (us) between putting the PHY into low power mode
> and
> > +      gating the PHY clock.
> > +
> > +  non-zero-ttctrl-ttha:
> > +    description: |
> > +      After setting this property, the value of register ttctrl.ttha
> > +      will be 0x7f; if not, the value will be 0x0, this is the default
> > +      value. It needs to be very carefully for setting this property, =
it
> > +      is recommended that consult with your IC engineer before setting
> > +      this value.  On the most of chipidea platforms, the "usage_tt" f=
lag
> > +      at RTL is 0, so this property only affects siTD.
> > +
> > +      If this property is not set, the max packet size is 1023 bytes, =
and
> > +      if the total of packet size for pervious transactions are more t=
han
> > +      256 bytes, it can't accept any transactions within this frame. T=
he
> > +      use case is single transaction, but higher frame rate.
> > +
> > +      If this property is set, the max packet size is 188 bytes, it ca=
n
> > +      handle more transactions than above case, it can accept transact=
ions
> > +      until it considers the left room size within frame is less than =
188
> > +      bytes, software needs to make sure it does not send more than 90=
%
> > +      maximum_periodic_data_per_frame. The use case is multiple
> > +      transactions, but less frame rate.
> > +
> > +  mux-controls:
> > +    description: |
> > +      The mux control for toggling host/device output of this controll=
er.
> > +      It's expected that a mux state of 0 indicates device mode and a =
mux
> > +      state of 1 indicates host mode.
> > +
> > +  mux-control-names:
> > +    description: Shall be "usb_switch" if mux-controls is specified.
> > +
> > +  pinctrl-names:
> > +    description: |
> > +      Names for optional pin modes in "default", "host", "device".
> > +      In case of HSIC-mode, "idle" and "active" pin modes are mandator=
y.
> > +      In this case, the "idle" state needs to pull down the data and
> > +      strobe pin and the "active" state needs to pull up the strobe pi=
n.
> > +
> > +  pinctrl-0:
> > +    maxItems: 1
> > +
> > +  pinctrl-1:
> > +    maxItems: 1
> > +
> > +  phys:
> > +    maxItems: 1
> > +
> > +  phy-names:
> > +    const: usb-phy
> > +
> > +  vbus-supply:
> > +    description: reference to the VBUS regulator.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +
> > +allOf:
> > +  - $ref: usb-drd.yaml#
> > +  - $ref: usb-hcd.yaml#
> > +  - if:
> > +      properties:
> > +        mux-controls:
> > +          true
> > +    then:
> > +      properties:
> > +        mux-control-names:
> > +          const: usb_switch
> > +  - if:
> > +      properties:
> > +        phy_type:
> > +          const: hsic
> > +
> > +      required:
> > +        - phy_type
> > +    then:
> > +      properties:
> > +        pinctrl-names:
> > +          items:
> > +            - const: idle
> > +            - const: active
> > +    else:
> > +      properties:
> > +        pinctrl-names:
> > +          oneOf:
> > +            - items:
> > +                - const: default
> > +                - enum:
> > +                    - host
> > +                    - device
> > +            - items:
> > +                - const: default
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - fsl,imx23-usb
> > +            - fsl,imx25-usb
> > +            - fsl,imx27-usb
> > +            - fsl,imx28-usb
> > +            - fsl,imx6q-usb
> > +            - fsl,imx6sl-usb
> > +            - fsl,imx6sx-usb
> > +            - fsl,imx6ul-usb
> > +            - fsl,imx7d-usb
> > +            - fsl,imx7ulp-usb
> > +    then:
> > +      properties:
> > +        fsl,usbmisc:
> > +          description:
> > +            Phandler of non-core register device, with one argument th=
at
> > +            indicate usb controller index
>=20
> type ref?
>=20
> Don't define properties within if/then/else. Define at top level and then
> restrict presence in the if/then schema.
>=20
> > +
> > +        disable-over-current:
> > +          description: disable over current detect
> > +
> > +        over-current-active-low:
> > +          description: over current signal polarity is active low
> > +
> > +        over-current-active-high:
> > +          description: |
> > +            Over current signal polarity is active high. It's recommen=
ded to
> > +            specify the over current polarity.
> > +
> > +        power-active-high:
> > +          description: power signal polarity is active high
> > +
> > +        external-vbus-divider:
> > +          description: enables off-chip resistor divider for Vbus
> > +
> > +        samsung,picophy-pre-emp-curr-control:
> > +          description: |
> > +            HS Transmitter Pre-Emphasis Current Control. This signal c=
ontrols
> > +            the amount of current sourced to the USB_OTG*_DP and
> USB_OTG*_DN
> > +            pins after a J-to-K or K-to-J transition. The range is fro=
m 0x0 to
> > +            0x3, the default value is 0x1. Details can refer to
> TXPREEMPAMPTUNE0
> > +            bits of USBNC_n_PHY_CFG1.
> > +          $ref: /schemas/types.yaml#/definitions/uint32
> > +          minimum: 0x0
> > +          maximum: 0x3
> > +
> > +        samsung,picophy-dc-vol-level-adjust:
> > +          description: |
> > +            HS DC Voltage Level Adjustment. Adjust the high-speed tran=
smitter
> DC
> > +            level voltage. The range is from 0x0 to 0xf, the default v=
alue is
> > +            0x3. Details can refer to TXVREFTUNE0 bits of USBNC_n_PHY_=
CFG1.
> > +          $ref: /schemas/types.yaml#/definitions/uint32
> > +          minimum: 0x0
> > +          maximum: 0xf
> > +
> > +additionalProperties: true
>=20
> Cannot be true.
>=20
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/clock/berlin2.h>
> > +
> > +    usb@f7ed0000 {
> > +        compatible =3D "chipidea,usb2";
>=20
> Doesn't match documentation. You should know by now to test your
> bindings.

I am not very clear on this. Could you please share more info?

Thanks,
Peng.

>=20
> > +        reg =3D <0xf7ed0000 0x10000>;
> > +        interrupts =3D <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> > +        clocks =3D <&chip CLKID_USB0>;
> > +        phys =3D <&usb_phy0>;
> > +        phy-names =3D "usb-phy";
> > +        vbus-supply =3D <&reg_usb0_vbus>;
> > +        itc-setting =3D <0x4>; /* 4 micro-frames */
> > +         /* Incremental burst of unspecified length */
> > +        ahb-burst-config =3D <0x0>;
> > +        tx-burst-size-dword =3D <0x10>; /* 64 bytes */
> > +        rx-burst-size-dword =3D <0x10>;
> > +        extcon =3D <0>, <&usb_id>;
> > +        phy-clkgate-delay-us =3D <400>;
> > +        mux-controls =3D <&usb_switch>;
> > +        mux-control-names =3D "usb_switch";
> > +    };
> > +
> > +  # Example for HSIC:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/clock/imx6qdl-clock.h>
> > +
> > +    usb@2184400 {
> > +        compatible =3D "fsl,imx6q-usb", "fsl,imx27-usb";
> > +        reg =3D <0x02184400 0x200>;
> > +        interrupts =3D <0 41 IRQ_TYPE_LEVEL_HIGH>;
> > +        clocks =3D <&clks IMX6QDL_CLK_USBOH3>;
> > +        fsl,usbphy =3D <&usbphynop1>;
> > +        fsl,usbmisc =3D <&usbmisc 2>;
> > +        phy_type =3D "hsic";
> > +        dr_mode =3D "host";
> > +        ahb-burst-config =3D <0x0>;
> > +        tx-burst-size-dword =3D <0x10>;
> > +        rx-burst-size-dword =3D <0x10>;
> > +        pinctrl-names =3D "idle", "active";
> > +        pinctrl-0 =3D <&pinctrl_usbh2_idle>;
> > +        pinctrl-1 =3D <&pinctrl_usbh2_active>;
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        usbnet: ethernet@1 {
> > +            compatible =3D "usb424,9730";
> > +            reg =3D <1>;
> > +        };
> > +    };
> > +
> > +...
> > --
> > 2.37.1
> >
> >
