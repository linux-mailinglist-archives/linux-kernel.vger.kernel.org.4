Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4656A53DC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 08:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjB1Hp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 02:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjB1Hpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 02:45:50 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497372BED5;
        Mon, 27 Feb 2023 23:45:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBRQePTVM104HkssnuwPyQ094LmMaG6Lb/RXwlIw9nhe0i4k9Dmt5JLe2QPsSI3ayvoF68ejNOZDYaZdRMutOXGL9GOd/Demo8iyRpjxkOl6nkWcs6mLyTAr5b208p92Tq5OuNzOKP2ZnkYxqGOWyLnLUmn+GO9U9dqL8z7PUQuMMyDcB1Va48ZOHQskf1fEAMEsSLLNfMXQdE2MPfoign1B1v5zk+uh7Y8jonjg2uQzPdf/MmelLUIEUqjvMefEz7ztwJh+qpnNQdAjHQ5F0PaKLkjobweQAT8j8dJdchH8dHB27G9X7AqI49fAVvjVROZNl7U22tUmwuuJeimn6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8X3c8Gey2XyWosEEGAN2qnHHhW5G9iHjq/ncjQMtL4=;
 b=EG1SFCPRNPNeidSyr6KZdLON6TUTg4QXI9uPtbjRYsV17K7wTNxl9gApMZlzRsggp2qhq8cLAEeSm80modZIzrjPoGjf7zVs2gPB042vV8VDq503E8jdh4iqZXqslrv+MZ7RJkxTsP/zFE/A5RgqjBW4D55qMzGXqXiaIvvfDwPs8/xWjObdhbYQtKJDwXRnj+fUIqttWPhHQgU6LD3i0J2CLPgYQ+bhSXrTtbdnAoWNznRTGGtpuHmkIeH2o0YVRhE6w8qcETL3LQS3IS/BFhUTQehIJDUcgwORRrdI4oQ24o90IdJENn+V6P8gAl6pbpqTOGELzV7dptjxN1eaGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8X3c8Gey2XyWosEEGAN2qnHHhW5G9iHjq/ncjQMtL4=;
 b=L7FI6jAvVAyraZOiMq8ahbWxDJyb5ahgKdgH0zFOB8zrztiSl95CJNptRWsIFqtQn4FAAv855IdpxG2O9N4+mDG8N1eL4mWgxJcDW15aGE9VTrtx8VjqIOvHRp14u87CEkB+C3XzJ+l1b0hq1wgJ/ie2LZR5QMk9ZW9t8yuUcDw=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8660.eurprd04.prod.outlook.com (2603:10a6:20b:42b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 07:45:40 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6134.027; Tue, 28 Feb 2023
 07:45:40 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
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
Subject: RE: [PATCH V3 4/7] dt-bindings: usb: ci-hdrc-usb2: convert to DT
 schema format
Thread-Topic: [PATCH V3 4/7] dt-bindings: usb: ci-hdrc-usb2: convert to DT
 schema format
Thread-Index: AQHZSeJaF15g5ocyU0im9dVpnDQ4ya7jTdmAgACudmA=
Date:   Tue, 28 Feb 2023 07:45:40 +0000
Message-ID: <DU0PR04MB94170D9B04771F4A5D46337F88AC9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230226130539.277336-1-peng.fan@oss.nxp.com>
 <20230226130539.277336-5-peng.fan@oss.nxp.com>
 <20230227211651.GA896532-robh@kernel.org>
In-Reply-To: <20230227211651.GA896532-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB8660:EE_
x-ms-office365-filtering-correlation-id: 19f491e7-8bd6-4331-3593-08db195fc9e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eJ0hJXrtTDUp7Tbk2B9Ae6TnX2Rz2hECujXsjTSN9nvsq0oNmZUnQpd1VViMYAs6PnvZHhIZMWxTda9TM5XbOVSklTmyeYYN/bHXwGCMqhEOEEhtoz2w6wyQc7kl8K1dD5utEDSHGPe8MTBd3pZrklK9A0Zi3TWqxHakTWTRgHWtcy9c4qpRe8eCR9CVMG0Lu9NlDIWh5iDpM5z03/ecH+UnL7TBeJhpTVqMsFebuHZSX7Z6BPTgOpi5v/RczvMVPOTqkO1ViRwkfpnrbTHIYFhQ4+1uikgGDwgK1qYcY3rGnwBgwG1Hn7RRBdM5VUhqSlGdFoJrWdYEuZpPg91rvs2x+ZviIt9ME1I+oQyWTGv8RLKLkwQLZNQ0r4BvEIPqWjlc7aOUCBElpIPhhigpjQfmjsF+q1mwLVo7YkmUa3OTFtATfzVokPeLRXauFxZbajUSS8rf7Jil1N68AN2adPliPlXprPdCrGttHJO2QZkHk03NiH1xoaEWhsegzr9GkK4wV3Yo6N79u0SPVqHm7R/WRf9Oje1xciLhogSOhpbPpE7Uj49QJUfYgF41rsIaR6lPOQSvsfEERDYqlNVwELuKJKjeVl1hjm49jQQLr6SsIi2rAwkCjv0AA+XFtn5GjfoE8d828gnDlyGFL+LWOnyfYvUOT0+HRlddkHOI55VJ/Ft5i8TOrs36XR87/8uNUnTsYpVAveXCSV1bqtVbSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199018)(86362001)(33656002)(38070700005)(122000001)(38100700002)(44832011)(8676002)(2906002)(66476007)(7416002)(30864003)(66946007)(52536014)(76116006)(64756008)(66446008)(66556008)(8936002)(41300700001)(4326008)(5660300002)(55016003)(83380400001)(9686003)(26005)(186003)(6506007)(45080400002)(110136005)(54906003)(316002)(478600001)(7696005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jJ5pC3Y1kvTnxiSRrglYeYF63ixsMLsr8d2+g4Z/EPlffuJqssMR594dbrxc?=
 =?us-ascii?Q?icBxnXMPBSbp2+z4Dljligf3R1nWEHJQ6y1cJkPGi8BhjYc+0KI5XpmqZrIt?=
 =?us-ascii?Q?TK6V4BP4rKjCs/MYm3RLpIxe7kkgRse4rzjxmdXWlKtEszX/msUnUpZKtV1U?=
 =?us-ascii?Q?g2L+8FxC3qLfmo05Pz+v2oRKI3cVvXoyl4X58IWHU7zwMGEhXgwCV+wgvPjJ?=
 =?us-ascii?Q?M0MoLV5zekUZIv0h4LKARYA7x3QcpmWFVsrJO6BcbEtcH27x+FcG5ZLmKJBE?=
 =?us-ascii?Q?Wqhu5ZTsj3LzX2c/aQNC0OyMuFERpjt0dbrxT9O/WtV/ESRpskp7wrVOMxAM?=
 =?us-ascii?Q?8sIpxYpRHwlPlvp+msAkOQD0IVgBV+/g6rrTyoH5w2ClaiPut8rCo3XC9usz?=
 =?us-ascii?Q?jbGZqXXu9eanTt9laVY6lwFR//irqzdNQoQ5PnPI2ZZTwoMY1IalwSv4KzZm?=
 =?us-ascii?Q?iJ/WGNuB6TsfHkO/WfgUFj4+p2wQKaa6pZYlc4yeIdpEUXJJ98EDRXtkGSDQ?=
 =?us-ascii?Q?bRUr6fnpMgnBHlvhCtV5/Z/EOxdg5fXm9Tu7J3TRPqb0laYvao6BPYySShZt?=
 =?us-ascii?Q?2Xb2Y+X8+jxND8IC+m3ZPjA82UdMeGXpGfIsoh5TRTqvMNSA0UuFCuSyuNpF?=
 =?us-ascii?Q?2CxXbgNsWr4zbZEXbP9btcmrk22QcCjCOIhSjo6UO3wq/QM8ZEgnekN3mNAO?=
 =?us-ascii?Q?4mzl4fxSMOg5HK/USQ0IyC7CctIfl+YpBfNcuAaSUDuaTwEbwXkJpKln90pZ?=
 =?us-ascii?Q?4ePJqXkIFuu88//HJFWRDiv9wxaP5o+rCEjAEvDpzbmw8uD6igDgVRPb6Edi?=
 =?us-ascii?Q?vL0+hqh/JnwtjmDkere1AqQkDzceLw7QqYHfk5nKuiCuSVEV4EmwKNAJmIF1?=
 =?us-ascii?Q?cYgoZOmlJ4/F01hK809B0uxL5LLCFY4zOsD/jY2F7lIvZ39+6nLSZ/5uDDpi?=
 =?us-ascii?Q?1F0ZgqWAwgJmVv4SZzE6fCJoezmEsPkX3J0KgLoyZHBoZizQq5rNU1xVRnjX?=
 =?us-ascii?Q?Fddvtkod0b/iW0ZnR0l/HE1uy01oss8lvGm/kc1GrfYTDlciVN61sjLlRU4v?=
 =?us-ascii?Q?ChtBMqgMVg7P3orIasZSoCaqgIMEYRor8uNH2QOoIjRszKmoCKiaWlWP8eAr?=
 =?us-ascii?Q?HkbpWFoGlyTDqn3lA9FSoB3AS994XoNcfX2VgNiZSnxFbONnyhETNu9148//?=
 =?us-ascii?Q?Cmp+v+MRVrHku/wS4v7D4h1ssPQ1sDWIFwzLieQFC1z5OH3Y3aEtGp2XWBGK?=
 =?us-ascii?Q?gUu5DL1KtoTJGdsRf59vwucvRNDD6kXJ4GyiZymHmaN0Y+WD+BUXzwBR4vYN?=
 =?us-ascii?Q?IhO9NtV5bv3Px7wuWqUQwCeWU+II5l052I+5QYdAu7RUhxDJ5c3ZAEIiXsTl?=
 =?us-ascii?Q?19EbRd9rnysn1s/57rDXVYw+hxlIpP2vR/doTFbgb9IDlTIb23WvWkoeG1Kh?=
 =?us-ascii?Q?ZtQ4CltIdf0oZvKQPQbwu6fIZydMAIlS97651ieDmTWbNaLscdeuaNzkZb5J?=
 =?us-ascii?Q?TLCQEeGVsr8UMoD0bFhkxDdsY9coIdifURxbMH2mTnOBNMM77jIBcw1c4QAu?=
 =?us-ascii?Q?nB3/uosjiHhRQXLmh48=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f491e7-8bd6-4331-3593-08db195fc9e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 07:45:40.2523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SY89bYTP8EzqTwxDK/fkzKCn0Iw/NZehhH3LNlL94RWuQHtazB2OAiLqAS05UrfwPWOyUJMuysQY9aggJRf5cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8660
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V3 4/7] dt-bindings: usb: ci-hdrc-usb2: convert to DT
> schema format
>=20
> On Sun, Feb 26, 2023 at 09:05:36PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Convert the binding to DT schema format. To fix the dtbs_check error,
> > some properties were also added, such as nvidia,phy, reset-names ulpi.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../devicetree/bindings/usb/ci-hdrc-usb2.txt  | 159 -------
> > .../devicetree/bindings/usb/ci-hdrc-usb2.yaml | 408 ++++++++++++++++++
> >  2 files changed, 408 insertions(+), 159 deletions(-)  delete mode
> > 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
>=20
> [...]
>=20
> > diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
> > b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
> > new file mode 100644
> > index 000000000000..b30ed11fa22f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
> > @@ -0,0 +1,408 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> >
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> > +cetree.org%2Fschemas%2Fusb%2Fci-hdrc-
> usb2.yaml%23&data=3D05%7C01%7Cpeng
> >
> +.fan%40nxp.com%7Cf46be21afe3e40dce8da08db1907f3ab%7C686ea1d3bc
> 2b4c6fa
> >
> +92cd99c5c301635%7C0%7C0%7C638131294167215776%7CUnknown%7CT
> WFpbGZsb3d8
> >
> +eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
> 3D%7C
> >
> +3000%7C%7C%7C&sdata=3DcKoiZ7ZFPo%2FmIrudifs8NyvMkUhzoHLTWYwTD
> PDuR0I%3D&
> > +reserved=3D0
> > +$schema:
> >
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> > +cetree.org%2Fmeta-
> schemas%2Fcore.yaml%23&data=3D05%7C01%7Cpeng.fan%40nx
> >
> +p.com%7Cf46be21afe3e40dce8da08db1907f3ab%7C686ea1d3bc2b4c6fa92
> cd99c5c
> >
> +301635%7C0%7C0%7C638131294167215776%7CUnknown%7CTWFpbGZsb
> 3d8eyJWIjoiM
> >
> +C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C300
> 0%7C%7
> >
> +C%7C&sdata=3DZpqwgma1XzN0Q5ZxRZCF%2BIzvSL6Qjkgrk581nrzazLQ%3D&r
> eserved=3D
> > +0
> > +
> > +title: USB2 ChipIdea USB controller for ci13xxx Binding
>=20
> Drop ' for ci13xxx Binding'
>=20
> > +
> > +maintainers:
> > +  - Xu Yang <xu.yang_2@nxp.com>
> > +  - Peng Fan <peng.fan@nxp.com>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - enum:
> > +          - chipidea,usb2
> > +          - fsl,imx7ulp-usb
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
> > +          - const: fsl,imx8mm-usb
> > +          - const: fsl,imx7d-usb
>=20
> But not compatible with imx27?

If I add imx27, there will lots dtbs_check failure.

I am not sure what are the rule here.
Saying A is compatible with B, B is compatible with C, C
is compatible with D, D is compatible with E. should we add?
-const: A
-const: B
-const: C
-const: D
-const: E

Or we could split them such as two?
-const A
-const B
-const C
-----------------
-const C
-const D
-const E

Thanks,
Peng.

>=20
> > +      - items:
> > +          - const: fsl,imx7ulp-usb
> > +          - const: fsl,imx6ul-usb
> > +      - items:
> > +          - const: xlnx,zynq-usb-2.20a
> > +          - const: chipidea,usb2
> > +
>=20
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
>=20
> Defined in usb-hcd.yaml, so drop.
>=20
> > +
> > +  reg:
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  interrupts:
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  clocks:
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  clock-names:
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  dr_mode: true
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +  reset-names:
> > +    maxItems: 1
> > +
> > +  "#reset-cells":
> > +    const: 1
> > +
> > +  phy_type: true
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
> > +    minimum: 0x0
> > +    maximum: 0x20
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
> > +    minimum: 0x0
> > +    maximum: 0x20
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
> > +    maxItems: 1
> > +
> > +  mux-control-names:
> > +    const: usb_switch
> > +
> > +  pinctrl-names:
> > +    description: |
> > +      Names for optional pin modes in "default", "host", "device".
> > +      In case of HSIC-mode, "idle" and "active" pin modes are mandator=
y.
> > +      In this case, the "idle" state needs to pull down the data and
> > +      strobe pin and the "active" state needs to pull up the strobe pi=
n.
>=20
> items:
>   enum: [ default, host, device, idle, active ]
>=20
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
> > +  fsl,usbmisc:
> > +    description:
> > +      Phandler of non-core register device, with one argument that
> > +      indicate usb controller index
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    items:
> > +      - items:
> > +          - description: phandle to usbmisc node
> > +          - description: index of usb controller
> > +
> > +  fsl,anatop:
> > +    description: phandle for the anatop node.
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +
> > +  disable-over-current:
> > +    type: boolean
> > +    description: disable over current detect
> > +
> > +  over-current-active-low:
> > +    type: boolean
> > +    description: over current signal polarity is active low
> > +
> > +  over-current-active-high:
> > +    type: boolean
> > +    description: |
> > +      Over current signal polarity is active high. It's recommended to
> > +      specify the over current polarity.
> > +
> > +  power-active-high:
> > +    type: boolean
> > +    description: power signal polarity is active high
> > +
> > +  external-vbus-divider:
> > +    type: boolean
> > +    description: enables off-chip resistor divider for Vbus
> > +
> > +  samsung,picophy-pre-emp-curr-control:
> > +    description: |
> > +      HS Transmitter Pre-Emphasis Current Control. This signal control=
s
> > +      the amount of current sourced to the USB_OTG*_DP and
> USB_OTG*_DN
> > +      pins after a J-to-K or K-to-J transition. The range is from 0x0 =
to
> > +      0x3, the default value is 0x1. Details can refer to
> TXPREEMPAMPTUNE0
> > +      bits of USBNC_n_PHY_CFG1.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0x0
> > +    maximum: 0x3
> > +
> > +  samsung,picophy-dc-vol-level-adjust:
> > +    description: |
> > +      HS DC Voltage Level Adjustment. Adjust the high-speed transmitte=
r
> DC
> > +      level voltage. The range is from 0x0 to 0xf, the default value i=
s
> > +      0x3. Details can refer to TXVREFTUNE0 bits of USBNC_n_PHY_CFG1.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0x0
> > +    maximum: 0xf
> > +
> > +  usb-phy:
> > +    description: phandle for the PHY device. Use "phys" instead.
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    deprecated: true
> > +
> > +  fsl,usbphy:
> > +    description: phandle of usb phy that connects to the port. Use "ph=
ys"
> instead.
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    deprecated: true
> > +
> > +  nvidia,phy:
> > +    description: phandle of usb phy that connects to the port. Use "ph=
ys"
> instead.
> > +    $ref: /schemas/types.yaml#/definitions/phandle
>=20
>        deprecated: true
>=20
> > +
> > +  port:
> > +    description:
> > +      Any connector to the data bus of this controller should be model=
led
> > +      using the OF graph bindings specified, if the "usb-role-switch"
> > +      property is used.
> > +    $ref: /schemas/graph.yaml#/properties/port
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +
> > +  ulpi:
> > +    type: object
> > +    properties:
> > +      phy:
> > +        description: The phy child node for Qcom chips.
> > +        type: object
> > +        $ref: /schemas/phy/qcom,usb-hs-phy.yaml
> > +
>=20
> > +patternProperties:
> > +  "^.*@[0-9a-f]{1,2}$":
> > +    description: The hard wired USB devices
> > +    type: object
> > +    $ref: /schemas/usb/usb-device.yaml
>=20
> Defined in usb-hcd.yaml, so drop.
>=20
> > +
> > +dependencies:
> > +  port: [ usb-role-switch ]
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +
> > +allOf:
> > +  - $ref: usb-hcd.yaml#
> > +  - $ref: usb-drd.yaml#
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
> > +          minItems: 1
> > +          maxItems: 2
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
> > +          contains:
> > +            enum:
> > +              - chipidea,usb2
> > +              - lsi,zevio-usb
> > +              - nvidia,tegra20-udc
> > +              - nvidia,tegra30-udc
> > +              - nvidia,tegra114-udc
> > +              - nvidia,tegra124-udc
> > +              - qcom,ci-hdrc
> > +              - xlnx,zynq-usb-2.20a
> > +    then:
> > +      properties:
> > +        fsl,usbmisc: false
> > +        disable-over-current: false
> > +        over-current-active-low: false
> > +        over-current-active-high: false
> > +        power-active-high: false
> > +        external-vbus-divider: false
> > +        samsung,picophy-pre-emp-curr-control: false
> > +        samsung,picophy-dc-vol-level-adjust: false
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/clock/berlin2.h>
> > +
> > +    usb@f7ed0000 {
> > +        compatible =3D "chipidea,usb2";
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
> > +        ethernet@1 {
> > +            compatible =3D "usb424,9730";
> > +            reg =3D <1>;
> > +        };
> > +    };
> > +
> > +...
> > --
> > 2.37.1
> >
