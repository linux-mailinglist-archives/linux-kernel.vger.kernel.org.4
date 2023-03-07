Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDF66AD7DA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 07:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjCGG6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 01:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjCGG5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 01:57:41 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2055.outbound.protection.outlook.com [40.107.6.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BF286DE8;
        Mon,  6 Mar 2023 22:57:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8Y4ObDE9fyx8njJW7y1TtCe4cEiP0HVTt7L7CsojNlFHBPWOzmAOleIsmTlGF4CteuO4zFDojaDMp+GikCR6OOmdXWZF+iO5m5eSnx+vJYjDIjiK5SSK3thgrG2740xgXGjmutojLKONY8jt5ybkbcT09+PPf+LrncFuegVR4CAcJswOZQ9gW9p7VZaH064tMdqoFIv+hi9zbzP5wtL5+aXSIO6m+q1A9IDTL7q6QErPIgIY/XBJlcTCdTd2x/48gjmwqHNDG07wPpMzh17jEhg8DaoABmXvznFf1cxZEmPfzEHfqlDYSlPzw0b6pysYim+b1lQUfE49QwJe3/Mnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifnEcR0gg6/i6egyW+jFqSLmaBp2jxDM6BfNqDKkXYM=;
 b=l7amRPq/189iZ0a6UDwjdEa2ISOhzliWxBHJDrMaqF9Krg+58dZfmmFuw+3IBTmE0ryg0inqzR9E7bfciBBUWdUX6h58yYwy7ZS3KBw74rBIBQyDxwXt9CxHMFgsy30RNOp+M0AbHmD8qPcDdeEEcLNlWRRaKrMSPhHI5Px5DOS8AmsaEU+WsvRSbhQFOmdm3lOIOa1Mxvo69X6thie5UYpiq+imUK6Jme8exK+7MmQYadH7LW2ObG+dJZOZZ1wHKxlZm6x0J2DnMywPqqbrJSrxhFiWtSNF9uKpXR2q4H78DgGp23/SYCRWusM6kFu2rMDMFtX/a9FGA4c+M4x7Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifnEcR0gg6/i6egyW+jFqSLmaBp2jxDM6BfNqDKkXYM=;
 b=WNuddC95olwfTl05GFhVGowxg5vuoLO9gSifZw9Rmb2cs/LB20JWPjor4BGib84le3bVtSKrRR1wXIw4hHgxGGL0tYVAyuTO25L3nLJmQHjJMdb+8/+lCE3i8LcPVdeRLEidAj1XcbqGDts3UziuWm3yO75iAZtIZyc2ImSefFY=
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com (2603:10a6:208:11a::11)
 by PAXPR04MB8765.eurprd04.prod.outlook.com (2603:10a6:102:20c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 06:56:00 +0000
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::c2c7:5798:7033:5f87]) by AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::c2c7:5798:7033:5f87%7]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 06:56:00 +0000
From:   Gaurav Jain <gaurav.jain@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Peng Fan <peng.fan@nxp.com>
Subject: RE: [PATCH 3/9] dt-bindings: crypto: fsl-sec4: support sec5.4/0 and
 i.MX6UL
Thread-Topic: [PATCH 3/9] dt-bindings: crypto: fsl-sec4: support sec5.4/0 and
 i.MX6UL
Thread-Index: AQHZS+Bx+SvbzTgzy0SagwQvcdZdWa7u618Q
Date:   Tue, 7 Mar 2023 06:56:00 +0000
Message-ID: <AM0PR04MB60045D52CF83EE802F23BD19E7B79@AM0PR04MB6004.eurprd04.prod.outlook.com>
References: <20230301015702.3388458-1-peng.fan@oss.nxp.com>
 <20230301015702.3388458-4-peng.fan@oss.nxp.com>
In-Reply-To: <20230301015702.3388458-4-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6004:EE_|PAXPR04MB8765:EE_
x-ms-office365-filtering-correlation-id: 6056fdd3-6a53-4a41-9fce-08db1ed902e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v4UUo/G9iuLeAgGjVUvz05T1xXvaORUwl9hXCkPgACWgyeEGyuS+1gunKQ8X9UwNr6hK9OZYYY/6/CGn71BrTWygiNkIS54LSLK9tn5fYPKgJ9DzIQ9ik+NwH/Amrn7cvOVMPZgrb/8TZF8rhp8f+Wk1ivqVUSbz9MV+By3jq1feWlQ7Mus9nYQxQl1pqL/D5Emgh0heA3S4KbhoKbK247gxrFJPePFlPWo6aJG0zekJ8YfkO81BBYKoQHN8feGxDC8jl01xJ5K+Ayi1Z1vPV/ThMDmoYr37ZgcBJs3sNlRbRDdnLTZwDkQg0cD4ijQFz5iOqMko5UsxJwoRQntjOU6M2zlLdfYvSG+bFtxZ1ejgO/n/1K6RYTZs+iHLGq8H8ktp+9fYgDWBJXTdqpC/zuKBFFKBZvrbj6yqBrT1avg1V8laXkOT6QwTpwvX2t+1MrGaxzdX3cBQ/CxpUh96Nj8wlFlXAV3CUVBH+SyCIjF5yC8gd/RKXIeK/L1OWdU9iNUsk76KvNEx9EOmC9bNbA8hnWcoxdOQsjigqeLvary9mjI/EepAye1jWslpnpP9ElCa7D1rW/9ACMVps5Ze2sSxx49MNqJHKTNQhuyL7fPrgNkMxAc4VyRio3T3LhO8mgnYb/YcEaap81fU1x0vSHHyFgDTy5znk7O6R0rrm8xmlpXZfikOqx/iN3EqOBx/xO6ElV4t4mAezsREPo3AJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199018)(38100700002)(122000001)(33656002)(86362001)(38070700005)(2906002)(7416002)(44832011)(5660300002)(4326008)(76116006)(66446008)(64756008)(8676002)(66476007)(66556008)(66946007)(41300700001)(8936002)(52536014)(55236004)(53546011)(9686003)(186003)(83380400001)(110136005)(316002)(478600001)(54906003)(55016003)(6506007)(26005)(7696005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lskdi9dUOtxoMFqRJrp1h7Yhv5lPz8Txz5jlIRYO0kQgmZcPMwTh2xMBhMXt?=
 =?us-ascii?Q?8qA4SySG16TYpgK75x/9gu3oANWG1M3DaYvzHdDP5Gtas6jFweTMeZn9NUVj?=
 =?us-ascii?Q?dSG6L2NTwMIi8AWb3osN0PE3ws8RrkHWh1kQr34nhX2LdC9V1tKoh45Xz/sW?=
 =?us-ascii?Q?wHeCofWAXQmt9V9uV3s2ZXLFJMr3AsaW5hngIiXsZiob4RXq3LqcZ1ZNzOhq?=
 =?us-ascii?Q?DPYMqF3iDe1HzkBIQ0k4cjGyL4xJfTUimMBSKRyw7s65ZYEIfhyt1Jx/U8tP?=
 =?us-ascii?Q?3XuHCAaYzuZaknOQ4O4MkBS7TAByrSzgtcp1FXBB02ZVaonIIH0WlrJtmoi/?=
 =?us-ascii?Q?yU0hd/i8OdUFV15by5rNKjIeoCSOcLDnS8v/ve8moS/Szu68+2HV68hi3snf?=
 =?us-ascii?Q?J7H6qu1BM/vnzcifG7i+nRiRmPH7uTfjwO4GYfdd5StzQNOpNHYEgqAeCLIm?=
 =?us-ascii?Q?oSU1ftRprvjYfkk1Lqc9XES57c9LRck0xQNBDabgBJp3Cjg/uvo7i1j0CcFI?=
 =?us-ascii?Q?yIzdyRXjz1j/w8dLB3AtgSpArQb4uKRnDizTls/w+NZfKEC8qgF9JayK11XK?=
 =?us-ascii?Q?Yzf8H2bJq8PjxSG/GWQMvXE4s9KogXNz3Z4E1a4aeqw7PIrtibdUrF1Lb03P?=
 =?us-ascii?Q?X1Bz9fDGXZu71YaQ5LhfsYKABqS6ezzvkO8+M0EsGkWbj0RyJgtgnZ22psid?=
 =?us-ascii?Q?vnmLBp1mMpeT2Ex0P0lhmKENFLE5ubdsaAYnjjp/77FC4fJxwKfjvT+0VymU?=
 =?us-ascii?Q?+spUQ00ZuBCXvF1N3jaehfauzY58KW5uAWCfjmhHgWKBK5hC0jYRqmLyRAK0?=
 =?us-ascii?Q?vd4REeplnSKVHtfJewa7+5YSke4H4vQILZe3hVaf3oTOI30B64bDXqTB6rGB?=
 =?us-ascii?Q?Lx1GsckA0Gj0eITL5tisc0YOHPm8J7J/hhmpMjzwwUeLR0xa60WGkEVTKooK?=
 =?us-ascii?Q?q7ezxDXGYSRHtmkOyJp7xSTgcyBzRvJi5jW8Yy74OJOnl0NsoijjK0ReAeBc?=
 =?us-ascii?Q?OGvGxe6kiOl0uzejdWGkRfH7leW1+SKZHkY8pcA1QAyCQ5o+6+AaUqHIQmXq?=
 =?us-ascii?Q?bMsmZCKHN0QQckCD9MGfRiYx36FMgGyM/PLEoIpRWqS3PIzn0HNKBMSJeSHO?=
 =?us-ascii?Q?YevrB7XRsRns5pdywL7nxLcF8jltmf1VQXS5J0/kWTJYJP2H5bloRjXdpeSG?=
 =?us-ascii?Q?fGsMC27bkYJhpd8sRq932PQYuiOpgio5sTynmUcUyIiPIpVvRC5tCDnKsowg?=
 =?us-ascii?Q?sO1kzz/GagsgYoi2Nwm2Ll1E7k1pSMWBRLW11ICXKxFfQwRANKonZMd5ICnv?=
 =?us-ascii?Q?y7cHW6QSbAX66TC2NUKO0SWy+d29x8Fyml6TuZkto7HC59jJbpMA5R9+6S8L?=
 =?us-ascii?Q?aR4ww03Dvrn0iUxGHVQXANiBSsagq448SX+YhzxGkJ9IK+LXt+16fgW+l2Gr?=
 =?us-ascii?Q?Er9jB7np+6iTkgyvy2/ZYzEUXJqNEhacWXZTAq2+zLbFX4wOFdbi3piVQIbg?=
 =?us-ascii?Q?WMfbzCQfTUwiij1aUtdQbyj3rFxXJEuJ4AEcszsGSxUr97XENivh2nsTdwLR?=
 =?us-ascii?Q?IdujOkBDWNV/fUC43JJLCQfR8YbromJYYRIKRUGg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6056fdd3-6a53-4a41-9fce-08db1ed902e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 06:56:00.7912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4TWw/j1Ff8TtWXhbBlbyg61yxuhQ/a4cDfDgod5/56rATwb/bMMXFCXCKe6VT1xO+VmzEhDIEmU13wEKXGcQ2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8765
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Peng Fan (OSS) <peng.fan@oss.nxp.com>
> Sent: Wednesday, March 1, 2023 7:27 AM
> To: herbert@gondor.apana.org.au; davem@davemloft.net;
> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; Horia Geanta
> <horia.geanta@nxp.com>; Pankaj Gupta <pankaj.gupta@nxp.com>; Gaurav Jain
> <gaurav.jain@nxp.com>; shawnguo@kernel.org; s.hauer@pengutronix.de
> Cc: kernel@pengutronix.de; stefan@agner.ch; linux-crypto@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; Peng Fan <peng.fan@nxp.com>
> Subject: [PATCH 3/9] dt-bindings: crypto: fsl-sec4: support sec5.4/0 and =
i.MX6UL
>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Add i.MX6UL, SEC 5.0 and SEC 5.4 support.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/crypto/fsl-sec4.yaml  | 58 ++++++++++++++++---
>  1 file changed, 50 insertions(+), 8 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec4.yaml
> b/Documentation/devicetree/bindings/crypto/fsl-sec4.yaml
> index 678c8389ef49..1b801ae5ab51 100644
> --- a/Documentation/devicetree/bindings/crypto/fsl-sec4.yaml
> +++ b/Documentation/devicetree/bindings/crypto/fsl-sec4.yaml
> @@ -45,8 +45,18 @@ maintainers:
>=20
>  properties:
>    compatible:
> -    enum:
> -      - fsl,sec-v4.0
> +    oneOf:
> +      - enum:
> +          - fsl,sec-v4.0
> +      - items:
> +          - enum:
> +              - fsl,imx6ul-caam
> +              - fsl,sec-v5.0
> +          - const: fsl,sec-v4.0
> +      - items:
> +          - const: fsl,sec-v5.4
> +          - const: fsl,sec-v5.0
> +          - const: fsl,sec-v4.0

fsl,sec-v5.2, fsl,sec-v5.3, fsl,sec-v6.0 also used in Qoriq

regards
Gaurav=20
>=20
>    "#address-cells":
>      const: 1
> @@ -77,6 +87,8 @@ properties:
>=20
>    clock-names:
>      oneOf:
> +      - items:
> +          - const: ipg
>        - items:
>            - const: mem
>            - const: aclk
> @@ -85,11 +97,17 @@ properties:
>        - items:
>            - const: aclk
>            - const: ipg
> +      - items:
> +          - const: ipg
> +          - const: aclk
>        - items:
>            - const: ipg
>            - const: aclk
>            - const: mem
>=20
> +  dma-coherent:
> +    type: boolean
> +
>    fsl,sec-era:
>      description:
>        Optional. A standard property. Define the 'ERA' of the SEC device.
> @@ -108,8 +126,16 @@ patternProperties:
>=20
>      properties:
>        compatible:
> -        enum:
> -          - fsl,sec-v4.0-job-ring
> +        oneOf:
> +          - enum:
> +              - fsl,sec-v4.0-job-ring
> +          - items:
> +              - const: fsl,sec-v5.0-job-ring
> +              - const: fsl,sec-v4.0-job-ring
> +          - items:
> +              - const: fsl,sec-v5.4-job-ring
> +              - const: fsl,sec-v5.0-job-ring
> +              - const: fsl,sec-v4.0-job-ring
>=20
>        reg:
>          maxItems: 1
> @@ -148,8 +174,16 @@ patternProperties:
>=20
>      properties:
>        compatible:
> -        enum:
> -          - fsl,sec-v4.0-rtic
> +        oneOf:
> +          - enum:
> +              - fsl,sec-v4.0-rtic
> +          - items:
> +              - const: fsl,sec-v5.0-rtic
> +              - const: fsl,sec-v4.0-rtic
> +          - items:
> +              - const: fsl,sec-v5.4-rtic
> +              - const: fsl,sec-v5.0-rtic
> +              - const: fsl,sec-v4.0-rtic
>=20
>        "#address-cells":
>          const: 1
> @@ -187,8 +221,16 @@ patternProperties:
>=20
>          properties:
>            compatible:
> -            enum:
> -              - fsl,sec-v4.0-rtic-memory
> +            oneOf:
> +              - enum:
> +                  - fsl,sec-v4.0-rtic-memory
> +              - items:
> +                  - const: fsl,sec-v5.0-rtic-memory
> +                  - const: fsl,sec-v4.0-rtic-memory
> +              - items:
> +                  - const: fsl,sec-v5.4-rtic-memory
> +                  - const: fsl,sec-v5.0-rtic-memory
> +                  - const: fsl,sec-v4.0-rtic-memory
>=20
>            reg:
>              minItems: 1
> --
> 2.37.1

