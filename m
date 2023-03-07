Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B277F6AD847
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 08:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjCGHTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 02:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjCGHTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 02:19:01 -0500
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2058.outbound.protection.outlook.com [40.107.103.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0019E460A8;
        Mon,  6 Mar 2023 23:18:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhUS+inhVB+VHI9iW8J/HzYi5C9ipjhZXr+n1bSWTtGE+d0blfyd8kIhePtNTp/gkGSS5yqIhztXeQLd4VCj1zV+ewOitIu+uyx/KKnw2NjWOhB7NWSuj1AplsKylqDE3y8mmyibtrRcJ/BFbUbEYOw3f+k3jt6Qor64snZE1iG2JPz44t/Q89KSXDYplqDe1AGf6mPuDl28rEZb0zCWk2ZGglo1ipXmSTtTuKRrJucquTNF/qRrb4wRoOQGihtateoMX2iprO7LmjRF9J9rn8oFxTYlp2g/qB6A2QAZQTdjFN/GRUmODM+YEoSZM3/3bIHC6m99D/X5oswOX343oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CD/MeskKN+vZW/WGbvPFe/H8j3QbIkUO9+lXfj/vrXY=;
 b=X+TUFtA+6Rjlsj1d+UGZprTiYmTaQzISDRa55l4fpbe6XqSw8Lc/qSBHcOABcltQKcSpHed1G2HO5+qdmV7YOTtBcuO0Ez1D5pmImUFc/Z0nfg00JHeezzmNhBsKj7RK4S7OMRo0zNpi8D321nUYv2/rKRl+D0GjqFfi2FOzLfaq8KvBIEax/N2wZYWX6avK6CKLGzNMmcG9H/bZGyXgTRS62YtXcGbY6WfFihDcgfHS/RBWtt2fFMfIxm65/Ra1eA/+7NUNYQQMPG2FWQZNcDvVlQfI5uAUZCK3F4OlVnM0WtGgLEb/c766hc8V53TuXSji4rb9xoKfBsw+pwvwTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CD/MeskKN+vZW/WGbvPFe/H8j3QbIkUO9+lXfj/vrXY=;
 b=quFyL1OESr+ElnjdO7Z9pAnd/ImS334xCDwJraI7vL+TZLHV+IN3+KPsZgHruFoNDaE861K3QaR9b+hIcULLCkzITsMPs/7n1YHxpvZfil7gBVGXMPSvC3Dimb3+OkQyMPzyp8puDprEFqjCq8oq9bke62/PuGLqTr2tCTUqJP4=
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com (2603:10a6:208:11a::11)
 by AM8PR04MB7249.eurprd04.prod.outlook.com (2603:10a6:20b:1d0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.26; Tue, 7 Mar
 2023 07:18:38 +0000
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::c2c7:5798:7033:5f87]) by AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::c2c7:5798:7033:5f87%7]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 07:18:38 +0000
From:   Gaurav Jain <gaurav.jain@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>
CC:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH] dt-bindings: crypto: fsl,sec-v4.0: Convert to DT
 schema
Thread-Topic: [EXT] [PATCH] dt-bindings: crypto: fsl,sec-v4.0: Convert to DT
 schema
Thread-Index: AQHZRXMPZtymz+PtBUSSaT7WTswe6K7u/Srg
Date:   Tue, 7 Mar 2023 07:18:38 +0000
Message-ID: <AM0PR04MB6004C0F30822B0EA8239FB51E7B79@AM0PR04MB6004.eurprd04.prod.outlook.com>
References: <20230220213334.353779-1-robh@kernel.org>
In-Reply-To: <20230220213334.353779-1-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6004:EE_|AM8PR04MB7249:EE_
x-ms-office365-filtering-correlation-id: abc50d68-b702-4402-c85d-08db1edc2c07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: At72D5Jlsx9uyYocbdCNsusVDiNsqGKZj06nxjq5PiqXfb4IpA9/Vp4iyiTSSFh1TYBcAh7RM6BLrpy9ELjfLD6EkdjhTPMiN/sLPBCO3wQVbAuxdIpaF0QFRtMF4+y2NC3KpaHw09SPXb/SX/RP6YJcBLekOtPyBXV6FiW6Sreuy3sopLzxj8Oe2OD8yvrG4Asns049aH3Wnw5qljnjWeczYk6Emv4FMHH5EZ2lqLKYirFV+3hvvJIOziyxNNNmvT3ZObhyJ9JSoZzOgGj8BbARQ6lbBv011coGftzyYCmFQ8UimIXGxMTxauaCQ8OPvREy+lYaIJZ+dmx41OqVieqJii9VDoPHBK7leVhXOPjDW29NnTJHLqM1/6nLQBl+X0UQNWW8nxNFvhqYKxL44F70I0yQBwqkboGUry0L0QYoxIhFmfVf6SsuHK6wU8ymGTFLl7ih29WGHIDzBF3cKOI+NGRqckBt4v0Nm93X8nlo6Lx/txtqitduJanWY0dcyJ2DVbvNptmDTQjma1AdRehgbOSk4hvkA/y2Q3TZtVGvgAU2AnS7zpFX1BJuYzd+mGpp/tXr4xgxohN+TVNE6cDfXlYClIvQEV6brRAI+n8D41mr+pS2PM7cz2dOx10sQLA6k38ZSKdHwjEVjqd4BZV/9irkzHQANEX2c7CtsA37S2skf6vjyYjFU0Rb/k3u2qDFgGf/oRQjNYqbljKq0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199018)(53546011)(6506007)(55236004)(83380400001)(38100700002)(55016003)(86362001)(122000001)(33656002)(38070700005)(9686003)(186003)(26005)(41300700001)(66556008)(66946007)(4326008)(66476007)(66446008)(64756008)(76116006)(2906002)(8676002)(8936002)(30864003)(44832011)(52536014)(5660300002)(45080400002)(71200400001)(478600001)(7696005)(316002)(6636002)(54906003)(110136005)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?Cvs57T05UZDoohKil92iIkY/YzXehI0XpI9oCknf+yxSpEa1azBem5N8hj?=
 =?iso-8859-2?Q?ezxnXr+oL0MGSvjc8p/zoL2bdtDTUtDqhRFmihUL1etMpQfnxpBEEMKzK2?=
 =?iso-8859-2?Q?QLhF7KKlzxF8KTTBM9DZ119p4r1UmldjrLrEgDftQF0ZZ2JfpYjcbvxoS9?=
 =?iso-8859-2?Q?awilgR3TUTIpe0aFIUucuCM5stb5rt6H1K9iBEGqfGgdLkevhR57kD9/DC?=
 =?iso-8859-2?Q?GgIqONU9Pv5s0jK3XOsQa+bRavx9i/bWr29At1U0faSkxXgqn+jy6UbIV6?=
 =?iso-8859-2?Q?1OUwQtiOCYjG5sgKl8LkiGYApMaizBvZmhUXTVWNFaNr7A+/UIiBBGGabN?=
 =?iso-8859-2?Q?1411H4EtEg7kMXJxPTyKWkEARFjLO0B72rOL92K8eQ135vbO+P1DPoQgNG?=
 =?iso-8859-2?Q?0rsZjDyLJViKgNUVmMp7E2IZjHdOkRrWD9fOWagRPpf3R91S3NEP4AS7EV?=
 =?iso-8859-2?Q?1d1gE/gb1GQ8GG1W3heTLXe4Oh1wxsfKECmIndPAQ2gHy93ujCn8udA8W6?=
 =?iso-8859-2?Q?Lc0MVziHMr/68FkF+S8k7SG3URQPGdbfUnkunlUuTrZ0POctXbutFJxt0H?=
 =?iso-8859-2?Q?SIpEQCJoHd1htRnHR6pt0kpq0LsT2+wBEQOk+exdPhhzLyrGIP5aIZg8J0?=
 =?iso-8859-2?Q?c2hgXtKWhl7TpH583a2/kLU/1esl4Zz7kKFNIshniD/wbdtr2rLaannDUQ?=
 =?iso-8859-2?Q?4WS2KcPryQSQm6gVPHvcZgeXeIDi64D/HuGwhU7wfG4X7XZ9vrv/yqXwr3?=
 =?iso-8859-2?Q?4qHVQtQNcxAcsQUfqMsSAE34/rCd7Zqk7isA8il+E8Rqg4Oy9ucspPm1DF?=
 =?iso-8859-2?Q?u27iLOY/ivb98KQ8+evumPKzCy+W7kuj42WkNaZopF2RrUWs+0hqq1Kx8M?=
 =?iso-8859-2?Q?f9EfhCtCSeUTEgs5jm1B3VBlUwcgX4DmKm0JSw2nRgDU0wt1wPBxjSmNzu?=
 =?iso-8859-2?Q?nTxIpUQHWKqkcNhLu0vbdbUA0LtyBOdUHyckJv/3B6pRD6z+7ACsq2iF1O?=
 =?iso-8859-2?Q?3TxGbpeaMQI7C7w6OdXWLnFAba/WMHKlQvpwN4hYwSnR4t0GEYbq/6ypsP?=
 =?iso-8859-2?Q?7f5shBCoC2YmYKq1gLtFBSZM3p/jZqaXX78GVToQmw82v+rlTX/16hB8nz?=
 =?iso-8859-2?Q?n4R1xemKEEXDiGSAbw1IeLVLmCYhnSVRiW31uhe6nKX6Pk3fYNe670Mgzx?=
 =?iso-8859-2?Q?54aXzE0JfoEw7fIfdJcAO33+bF080q1jj/NYgDXDjSb5YWgKD/kS388mLW?=
 =?iso-8859-2?Q?WEuBk60mcPgiCUkNSwIDTXuHLpWuARWTSQ23J4e1zIYe8cVKySopU9Vto1?=
 =?iso-8859-2?Q?iC42GxqPSGpWxDbkjkJDw9I/pP3sisQ6gZgEN3V9QJaOqft9vaZCNRLrIl?=
 =?iso-8859-2?Q?RPO7VZBT2xeOI2d3K1WrNrXfwhkB3idYA0Ik4ME3wTv/ePQf/DHH2WcbOT?=
 =?iso-8859-2?Q?KA4Mi5CrDMhtGTNeRGdhhFv6oWM8sxydZkrOAyDjRzMCD6zg22CDz3p3+f?=
 =?iso-8859-2?Q?MYmE/wimGcXoKMm7QZzc70p4DD4wtr20+uJcvg1UWEHKnxyUpU5P6RQB8K?=
 =?iso-8859-2?Q?EXBqeLvGAAniAKG5epIpHtvH5pzaAx2lg1wHfHlaJBRgJvrqdfys96kw7q?=
 =?iso-8859-2?Q?PxWn29Ro7mqYkkRlAo8pHJGmkatTlYsilk?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abc50d68-b702-4402-c85d-08db1edc2c07
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 07:18:38.3246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e9r8sX+VmV6/jYDKs+hi3hovHQFinGTWRJr3t/7/MskcwnVPuA6uhHywUxa2uV8WLd+4i4VEptP4lPYbPUsWAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7249
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Gaurav Jain <gaurav.jain@nxp.com>

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Tuesday, February 21, 2023 3:04 AM
> To: Herbert Xu <herbert@gondor.apana.org.au>; David S. Miller
> <davem@davemloft.net>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Horia Geanta <horia.geanta@nxp.com>;
> Pankaj Gupta <pankaj.gupta@nxp.com>; Gaurav Jain <gaurav.jain@nxp.com>
> Cc: linux-crypto@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [EXT] [PATCH] dt-bindings: crypto: fsl,sec-v4.0: Convert to DT s=
chema
>=20
> Caution: EXT Email
>=20
> Convert Freescale CAAM/SEC4 binding to DT schema format. The 'fsl,sec-v4.=
0'
> and 'fsl,sec-v4.0-mon' parts are independent, so split them into separate=
 schema
> files.
>=20
> Add a bunch of missing compatibles for v5.0, v5.4, etc. Drop unused 'rang=
es',
> '#address-cells', and '#size-cells' from fsl,sec-v4.0-mon nodes.
>=20
> There's one DTB warning for LS1012a which has a 2nd 'reg' entry for 'fsl,=
sec-
> v4.0-rtic'. Leaving that as there is no clue as to what it is for.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/crypto/fsl,sec-v4.0-mon.yaml     | 150 +++++
>  .../bindings/crypto/fsl,sec-v4.0.yaml         | 266 +++++++++
>  .../devicetree/bindings/crypto/fsl-sec4.txt   | 553 ------------------
>  3 files changed, 416 insertions(+), 553 deletions(-)  create mode 100644
> Documentation/devicetree/bindings/crypto/fsl,sec-v4.0-mon.yaml
>  create mode 100644 Documentation/devicetree/bindings/crypto/fsl,sec-
> v4.0.yaml
>  delete mode 100644 Documentation/devicetree/bindings/crypto/fsl-sec4.txt
>=20
> diff --git a/Documentation/devicetree/bindings/crypto/fsl,sec-v4.0-mon.ya=
ml
> b/Documentation/devicetree/bindings/crypto/fsl,sec-v4.0-mon.yaml
> new file mode 100644
> index 000000000000..353d9140dcea
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/fsl,sec-v4.0-mon.yaml
> @@ -0,0 +1,150 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2008-2011 Freescale Semiconductor Inc.
> +%YAML 1.2
> +---
> +$id:
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevic=
e
> +tree.org%2Fschemas%2Fcrypto%2Ffsl%2Csec-v4.0-
> mon.yaml%23&data=3D05%7C01%7
> +Cgaurav.jain%40nxp.com%7C2c3978ea487741ba95a108db138a2f5b%7C686ea
> 1d3bc2
> +b4c6fa92cd99c5c301635%7C0%7C0%7C638125256474297643%7CUnknown%
> 7CTWFpbGZs
> +b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%
> +7C3000%7C%7C%7C&sdata=3DO3ZvUXTeDSZkwyi%2Fpy%2FcPKT7ScpE3yOKmZKl
> LKMto%2Fo
> +%3D&reserved=3D0
> +$schema:
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevic=
e
> +tree.org%2Fmeta-
> schemas%2Fcore.yaml%23&data=3D05%7C01%7Cgaurav.jain%40nxp
> +.com%7C2c3978ea487741ba95a108db138a2f5b%7C686ea1d3bc2b4c6fa92cd9
> 9c5c301
> +635%7C0%7C0%7C638125256474297643%7CUnknown%7CTWFpbGZsb3d8eyJ
> WIjoiMC4wLj
> +AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7
> C%7C&sd
> +ata=3DzKV%2FzBKG43TPLsJnF7sjIfCyg4t1D6i1nngwWuDZPS8%3D&reserved=3D0
> +
> +title: Freescale Secure Non-Volatile Storage (SNVS)
> +
> +maintainers:
> +  - '"Horia Geant=E3" <horia.geanta@nxp.com>'
> +  - Pankaj Gupta <pankaj.gupta@nxp.com>
> +  - Gaurav Jain <gaurav.jain@nxp.com>
> +
> +description:
> +  Node defines address range and the associated interrupt for the SNVS
> function.
> +  This function monitors security state information & reports security
> +  violations. This also included rtc, system power off and ON/OFF key.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: fsl,sec-v4.0-mon
> +          - const: syscon
> +          - const: simple-mfd
> +      - items:
> +          - const: fsl,sec-v5.0-mon
> +          - const: fsl,sec-v4.0-mon
> +      - items:
> +          - enum:
> +              - fsl,sec-v5.3-mon
> +              - fsl,sec-v5.4-mon
> +          - const: fsl,sec-v5.0-mon
> +          - const: fsl,sec-v4.0-mon
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 2
> +
> +  snvs-rtc-lp:
> +    type: object
> +    additionalProperties: false
> +    description:
> +      Secure Non-Volatile Storage (SNVS) Low Power (LP) RTC Node
> +
> +    properties:
> +      compatible:
> +        const: fsl,sec-v4.0-mon-rtc-lp
> +
> +      clocks:
> +        maxItems: 1
> +
> +      clock-names:
> +        const: snvs-rtc
> +
> +      interrupts:
> +        # VFxxx has only one. What is the 2nd one?
> +        minItems: 1
> +        maxItems: 2
> +
> +      regmap:
> +        description: Parent node containing registers
> +        $ref: /schemas/types.yaml#/definitions/phandle
> +
> +      offset:
> +        description: LP register offset
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        default: 0x34
> +
> +    required:
> +      - compatible
> +      - interrupts
> +      - regmap
> +
> +  snvs-powerkey:
> +    type: object
> +    additionalProperties: false
> +    description:
> +      The snvs-pwrkey is designed to enable POWER key function which
> controlled
> +      by SNVS ONOFF, the driver can report the status of POWER key and w=
akeup
> +      system if pressed after system suspend.
> +
> +    properties:
> +      compatible:
> +        const: fsl,sec-v4.0-pwrkey
> +
> +      clocks:
> +        maxItems: 1
> +
> +      clock-names:
> +        const: snvs-pwrkey
> +
> +      interrupts:
> +        maxItems: 1
> +
> +      regmap:
> +        description: Parent node containing registers
> +        $ref: /schemas/types.yaml#/definitions/phandle
> +
> +      wakeup-source: true
> +
> +      linux,keycode:
> +        default: 116
> +
> +    required:
> +      - compatible
> +      - interrupts
> +      - regmap
> +
> +  snvs-lpgpr:
> +    $ref: /schemas/nvmem/snvs-lpgpr.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/imx7d-clock.h>
> +
> +    sec_mon: sec-mon@314000 {
> +        compatible =3D "fsl,sec-v4.0-mon", "syscon", "simple-mfd";
> +        reg =3D <0x314000 0x1000>;
> +
> +        snvs-rtc-lp {
> +            compatible =3D "fsl,sec-v4.0-mon-rtc-lp";
> +            regmap =3D <&sec_mon>;
> +            offset =3D <0x34>;
> +            clocks =3D <&clks IMX7D_SNVS_CLK>;
> +            clock-names =3D "snvs-rtc";
> +            interrupts =3D <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +
> +        snvs-powerkey {
> +            compatible =3D "fsl,sec-v4.0-pwrkey";
> +            regmap =3D <&sec_mon>;
> +            clocks =3D <&clks IMX7D_SNVS_CLK>;
> +            clock-names =3D "snvs-pwrkey";
> +            interrupts =3D <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> +            linux,keycode =3D <116>; /* KEY_POWER */
> +            wakeup-source;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/crypto/fsl,sec-v4.0.yaml
> b/Documentation/devicetree/bindings/crypto/fsl,sec-v4.0.yaml
> new file mode 100644
> index 000000000000..0a9ed2848b7c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/fsl,sec-v4.0.yaml
> @@ -0,0 +1,266 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2008-2011 Freescale Semiconductor Inc.
> +%YAML 1.2
> +---
> +$id:
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevic=
e
> +tree.org%2Fschemas%2Fcrypto%2Ffsl%2Csec-
> v4.0.yaml%23&data=3D05%7C01%7Cgau
> +rav.jain%40nxp.com%7C2c3978ea487741ba95a108db138a2f5b%7C686ea1d3b
> c2b4c6
> +fa92cd99c5c301635%7C0%7C0%7C638125256474297643%7CUnknown%7CT
> WFpbGZsb3d8
> +eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
> %7C30
> +00%7C%7C%7C&sdata=3DhQwpaVvIJxJGQDEwWRlo0oO2oSrzw%2FcaFdfYSJmV
> mOA%3D&rese
> +rved=3D0
> +$schema:
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevic=
e
> +tree.org%2Fmeta-
> schemas%2Fcore.yaml%23&data=3D05%7C01%7Cgaurav.jain%40nxp
> +.com%7C2c3978ea487741ba95a108db138a2f5b%7C686ea1d3bc2b4c6fa92cd9
> 9c5c301
> +635%7C0%7C0%7C638125256474297643%7CUnknown%7CTWFpbGZsb3d8eyJ
> WIjoiMC4wLj
> +AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7
> C%7C&sd
> +ata=3DzKV%2FzBKG43TPLsJnF7sjIfCyg4t1D6i1nngwWuDZPS8%3D&reserved=3D0
> +
> +title: Freescale SEC 4
> +
> +maintainers:
> +  - '"Horia Geant=E3" <horia.geanta@nxp.com>'
> +  - Pankaj Gupta <pankaj.gupta@nxp.com>
> +  - Gaurav Jain <gaurav.jain@nxp.com>
> +
> +description: |
> +  NOTE: the SEC 4 is also known as Freescale's Cryptographic
> +Accelerator
> +  Accelerator and Assurance Module (CAAM).
> +
> +  SEC 4 h/w can process requests from 2 types of sources.
> +  1. DPAA Queue Interface (HW interface between Queue Manager & SEC 4).
> +  2. Job Rings (HW interface between cores & SEC 4 registers).
> +
> +  High Speed Data Path Configuration:
> +
> +  HW interface between QM & SEC 4 and also BM & SEC 4, on DPAA-enabled
> + parts  such as the P4080.  The number of simultaneous dequeues the QI
> + can make is  equal to the number of Descriptor Controller (DECO)
> + engines in a particular  SEC version.  E.g., the SEC 4.0 in the P4080
> + has 5 DECOs and can thus  dequeue from 5 subportals simultaneously.
> +
> +  Job Ring Data Path Configuration:
> +
> +  Each JR is located on a separate 4k page, they may (or may not) be
> + made visible  in the memory partition devoted to a particular core.
> + The P4080 has 4 JRs, so  up to 4 JRs can be configured; and all 4 JRs p=
rocess
> requests in parallel.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: fsl,sec-v5.4
> +          - const: fsl,sec-v5.0
> +          - const: fsl,sec-v4.0
> +      - items:
> +          - enum:
> +              - fsl,imx6ul-caam
> +              - fsl,sec-v5.0
> +          - const: fsl,sec-v4.0
> +      - const: fsl,sec-v4.0
> +
> +  reg:
> +    maxItems: 1
> +
> +  ranges:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    enum: [1, 2]
> +
> +  '#size-cells':
> +    enum: [1, 2]
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 4
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 4
> +    items:
> +      enum: [mem, aclk, ipg, emi_slow]
> +
> +  dma-coherent: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  fsl,sec-era:
> +    description: Defines the 'ERA' of the SEC device.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +patternProperties:
> +  '^jr@[0-9a-f]+$':
> +    type: object
> +    additionalProperties: false
> +    description:
> +      Job Ring (JR) Node. Defines data processing interface to SEC 4 acr=
oss the
> +      peripheral bus for purposes of processing cryptographic descriptor=
s. The
> +      specified address range can be made visible to one (or more) cores=
. The
> +      interrupt defined for this node is controlled within the address r=
ange of
> +      this node.
> +
> +    properties:
> +      compatible:
> +        oneOf:
> +          - items:
> +              - const: fsl,sec-v5.4-job-ring
> +              - const: fsl,sec-v5.0-job-ring
> +              - const: fsl,sec-v4.0-job-ring
> +          - items:
> +              - const: fsl,sec-v5.0-job-ring
> +              - const: fsl,sec-v4.0-job-ring
> +          - const: fsl,sec-v4.0-job-ring
> +
> +      reg:
> +        maxItems: 1
> +
> +      interrupts:
> +        maxItems: 1
> +
> +      fsl,liodn:
> +        description:
> +          Specifies the LIODN to be used in conjunction with the ppid-to=
-liodn
> +          table that specifies the PPID to LIODN mapping. Needed if the =
PAMU is
> +          used.  Value is a 12 bit value where value is a LIODN ID for t=
his JR.
> +          This property is normally set by boot firmware.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        maximum: 0xfff
> +
> +  '^rtic@[0-9a-f]+$':
> +    type: object
> +    additionalProperties: false
> +    description:
> +      Run Time Integrity Check (RTIC) Node. Defines a register space tha=
t
> +      contains up to 5 sets of addresses and their lengths (sizes) that =
will be
> +      checked at run time.  After an initial hash result is calculated, =
these
> +      addresses are checked by HW to monitor any change.  If any memory =
is
> +      modified, a Security Violation is triggered (see SNVS definition).
> +
> +    properties:
> +      compatible:
> +        oneOf:
> +          - items:
> +              - const: fsl,sec-v5.4-rtic
> +              - const: fsl,sec-v5.0-rtic
> +              - const: fsl,sec-v4.0-rtic
> +          - const: fsl,sec-v4.0-rtic
> +
> +      reg:
> +        maxItems: 1
> +
> +      ranges:
> +        maxItems: 1
> +
> +      interrupts:
> +        maxItems: 1
> +
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 1
> +
> +    patternProperties:
> +      '^rtic-[a-z]@[0-9a-f]+$':
> +        type: object
> +        additionalProperties: false
> +        description:
> +          Run Time Integrity Check (RTIC) Memory Node defines individual=
 RTIC
> +          memory regions that are used to perform run-time integrity che=
ck of
> +          memory areas that should not modified. The node defines a regi=
ster
> +          that contains the memory address & length (combined) and a sec=
ond
> +          register that contains the hash result in big endian format.
> +
> +        properties:
> +          compatible:
> +            oneOf:
> +              - items:
> +                  - const: fsl,sec-v5.4-rtic-memory
> +                  - const: fsl,sec-v5.0-rtic-memory
> +                  - const: fsl,sec-v4.0-rtic-memory
> +              - const: fsl,sec-v4.0-rtic-memory
> +
> +          reg:
> +            items:
> +              - description: RTIC memory address
> +              - description: RTIC hash result
> +
> +          fsl,liodn:
> +            description:
> +              Specifies the LIODN to be used in conjunction with the
> +              ppid-to-liodn table that specifies the PPID to LIODN mappi=
ng.
> +              Needed if the PAMU is used.  Value is a 12 bit value where=
 value
> +              is a LIODN ID for this JR. This property is normally set b=
y boot
> +              firmware.
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            maximum: 0xfff
> +
> +          fsl,rtic-region:
> +            description:
> +              Specifies the HW address (36 bit address) for this region
> +              followed by the length of the HW partition to be checked;
> +              the address is represented as a 64 bit quantity followed
> +              by a 32 bit length.
> +            $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +required:
> +  - compatible
> +  - reg
> +  - ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    crypto@300000 {
> +        compatible =3D "fsl,sec-v4.0";
> +        #address-cells =3D <1>;
> +        #size-cells =3D <1>;
> +        reg =3D <0x300000 0x10000>;
> +        ranges =3D <0 0x300000 0x10000>;
> +        interrupts =3D <92 2>;
> +
> +        jr@1000 {
> +            compatible =3D "fsl,sec-v4.0-job-ring";
> +            reg =3D <0x1000 0x1000>;
> +            interrupts =3D <88 2>;
> +        };
> +
> +        jr@2000 {
> +            compatible =3D "fsl,sec-v4.0-job-ring";
> +            reg =3D <0x2000 0x1000>;
> +            interrupts =3D <89 2>;
> +        };
> +
> +        jr@3000 {
> +            compatible =3D "fsl,sec-v4.0-job-ring";
> +            reg =3D <0x3000 0x1000>;
> +            interrupts =3D <90 2>;
> +        };
> +
> +        jr@4000 {
> +            compatible =3D "fsl,sec-v4.0-job-ring";
> +            reg =3D <0x4000 0x1000>;
> +            interrupts =3D <91 2>;
> +        };
> +
> +        rtic@6000 {
> +            compatible =3D "fsl,sec-v4.0-rtic";
> +            #address-cells =3D <1>;
> +            #size-cells =3D <1>;
> +            reg =3D <0x6000 0x100>;
> +            ranges =3D <0x0 0x6100 0xe00>;
> +
> +            rtic-a@0 {
> +                compatible =3D "fsl,sec-v4.0-rtic-memory";
> +                reg =3D <0x00 0x20>, <0x100 0x80>;
> +            };
> +
> +            rtic-b@20 {
> +                compatible =3D "fsl,sec-v4.0-rtic-memory";
> +                reg =3D <0x20 0x20>, <0x200 0x80>;
> +            };
> +
> +            rtic-c@40 {
> +                compatible =3D "fsl,sec-v4.0-rtic-memory";
> +                reg =3D <0x40 0x20>, <0x300 0x80>;
> +            };
> +
> +            rtic-d@60 {
> +                compatible =3D "fsl,sec-v4.0-rtic-memory";
> +                reg =3D <0x60 0x20>, <0x500 0x80>;
> +            };
> +        };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> deleted file mode 100644
> index 8f359f473ada..000000000000
> --- a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> +++ /dev/null
> @@ -1,553 +0,0 @@
> -
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D
> -SEC 4 Device Tree Binding
> -Copyright (C) 2008-2011 Freescale Semiconductor Inc.
> -
> - CONTENTS
> -   -Overview
> -   -SEC 4 Node
> -   -Job Ring Node
> -   -Run Time Integrity Check (RTIC) Node
> -   -Run Time Integrity Check (RTIC) Memory Node
> -   -Secure Non-Volatile Storage (SNVS) Node
> -   -Secure Non-Volatile Storage (SNVS) Low Power (LP) RTC Node
> -   -Full Example
> -
> -NOTE: the SEC 4 is also known as Freescale's Cryptographic Accelerator -
> Accelerator and Assurance Module (CAAM).
> -
> -
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D
> -Overview
> -
> -DESCRIPTION
> -
> -SEC 4 h/w can process requests from 2 types of sources.
> -1. DPAA Queue Interface (HW interface between Queue Manager & SEC 4).
> -2. Job Rings (HW interface between cores & SEC 4 registers).
> -
> -High Speed Data Path Configuration:
> -
> -HW interface between QM & SEC 4 and also BM & SEC 4, on DPAA-enabled
> parts -such as the P4080.  The number of simultaneous dequeues the QI can
> make is -equal to the number of Descriptor Controller (DECO) engines in a
> particular -SEC version.  E.g., the SEC 4.0 in the P4080 has 5 DECOs and =
can thus
> -dequeue from 5 subportals simultaneously.
> -
> -Job Ring Data Path Configuration:
> -
> -Each JR is located on a separate 4k page, they may (or may not) be made =
visible
> -in the memory partition devoted to a particular core.  The P4080 has 4 J=
Rs, so -
> up to 4 JRs can be configured; and all 4 JRs process requests in parallel=
.
> -
> -
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D
> -SEC 4 Node
> -
> -Description
> -
> -    Node defines the base address of the SEC 4 block.
> -    This block specifies the address range of all global
> -    configuration registers for the SEC 4 block.  It
> -    also receives interrupts from the Run Time Integrity Check
> -    (RTIC) function within the SEC 4 block.
> -
> -PROPERTIES
> -
> -   - compatible
> -      Usage: required
> -      Value type: <string>
> -      Definition: Must include "fsl,sec-v4.0"
> -
> -   - fsl,sec-era
> -      Usage: optional
> -      Value type: <u32>
> -      Definition: A standard property. Define the 'ERA' of the SEC
> -          device.
> -
> -   - #address-cells
> -       Usage: required
> -       Value type: <u32>
> -       Definition: A standard property.  Defines the number of cells
> -           for representing physical addresses in child nodes.
> -
> -   - #size-cells
> -       Usage: required
> -       Value type: <u32>
> -       Definition: A standard property.  Defines the number of cells
> -           for representing the size of physical addresses in
> -           child nodes.
> -
> -   - reg
> -      Usage: required
> -      Value type: <prop-encoded-array>
> -      Definition: A standard property.  Specifies the physical
> -          address and length of the SEC4 configuration registers.
> -          registers
> -
> -   - ranges
> -       Usage: required
> -       Value type: <prop-encoded-array>
> -       Definition: A standard property.  Specifies the physical address
> -           range of the SEC 4.0 register space (-SNVS not included).  A
> -           triplet that includes the child address, parent address, &
> -           length.
> -
> -   - interrupts
> -      Usage: required
> -      Value type: <prop_encoded-array>
> -      Definition:  Specifies the interrupts generated by this
> -           device.  The value of the interrupts property
> -           consists of one interrupt specifier. The format
> -           of the specifier is defined by the binding document
> -           describing the node's interrupt parent.
> -
> -   - clocks
> -      Usage: required if SEC 4.0 requires explicit enablement of clocks
> -      Value type: <prop_encoded-array>
> -      Definition:  A list of phandle and clock specifier pairs describin=
g
> -          the clocks required for enabling and disabling SEC 4.0.
> -
> -   - clock-names
> -      Usage: required if SEC 4.0 requires explicit enablement of clocks
> -      Value type: <string>
> -      Definition: A list of clock name strings in the same order as the
> -          clocks property.
> -
> -   Note: All other standard properties (see the Devicetree Specification=
)
> -   are allowed but are optional.
> -
> -
> -EXAMPLE
> -
> -iMX6QDL/SX requires four clocks
> -
> -       crypto@300000 {
> -               compatible =3D "fsl,sec-v4.0";
> -               fsl,sec-era =3D <2>;
> -               #address-cells =3D <1>;
> -               #size-cells =3D <1>;
> -               reg =3D <0x300000 0x10000>;
> -               ranges =3D <0 0x300000 0x10000>;
> -               interrupt-parent =3D <&mpic>;
> -               interrupts =3D <92 2>;
> -               clocks =3D <&clks IMX6QDL_CLK_CAAM_MEM>,
> -                        <&clks IMX6QDL_CLK_CAAM_ACLK>,
> -                        <&clks IMX6QDL_CLK_CAAM_IPG>,
> -                        <&clks IMX6QDL_CLK_EIM_SLOW>;
> -               clock-names =3D "mem", "aclk", "ipg", "emi_slow";
> -       };
> -
> -
> -iMX6UL does only require three clocks
> -
> -       crypto: crypto@2140000 {
> -               compatible =3D "fsl,sec-v4.0";
> -               #address-cells =3D <1>;
> -               #size-cells =3D <1>;
> -               reg =3D <0x2140000 0x3c000>;
> -               ranges =3D <0 0x2140000 0x3c000>;
> -               interrupts =3D <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
> -
> -               clocks =3D <&clks IMX6UL_CLK_CAAM_MEM>,
> -                        <&clks IMX6UL_CLK_CAAM_ACLK>,
> -                        <&clks IMX6UL_CLK_CAAM_IPG>;
> -               clock-names =3D "mem", "aclk", "ipg";
> -       };
> -
> -
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D
> -Job Ring (JR) Node
> -
> -    Child of the crypto node defines data processing interface to SEC 4
> -    across the peripheral bus for purposes of processing
> -    cryptographic descriptors. The specified address
> -    range can be made visible to one (or more) cores.
> -    The interrupt defined for this node is controlled within
> -    the address range of this node.
> -
> -  - compatible
> -      Usage: required
> -      Value type: <string>
> -      Definition: Must include "fsl,sec-v4.0-job-ring"
> -
> -  - reg
> -      Usage: required
> -      Value type: <prop-encoded-array>
> -      Definition: Specifies a two JR parameters:  an offset from
> -          the parent physical address and the length the JR registers.
> -
> -   - fsl,liodn
> -       Usage: optional-but-recommended
> -       Value type: <prop-encoded-array>
> -       Definition:
> -           Specifies the LIODN to be used in conjunction with
> -           the ppid-to-liodn table that specifies the PPID to LIODN mapp=
ing.
> -           Needed if the PAMU is used.  Value is a 12 bit value
> -           where value is a LIODN ID for this JR. This property is
> -           normally set by boot firmware.
> -
> -   - interrupts
> -      Usage: required
> -      Value type: <prop_encoded-array>
> -      Definition:  Specifies the interrupts generated by this
> -           device.  The value of the interrupts property
> -           consists of one interrupt specifier. The format
> -           of the specifier is defined by the binding document
> -           describing the node's interrupt parent.
> -
> -EXAMPLE
> -       jr@1000 {
> -               compatible =3D "fsl,sec-v4.0-job-ring";
> -               reg =3D <0x1000 0x1000>;
> -               fsl,liodn =3D <0x081>;
> -               interrupt-parent =3D <&mpic>;
> -               interrupts =3D <88 2>;
> -       };
> -
> -
> -
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D
> -Run Time Integrity Check (RTIC) Node
> -
> -  Child node of the crypto node.  Defines a register space that
> -  contains up to 5 sets of addresses and their lengths (sizes) that
> -  will be checked at run time.  After an initial hash result is
> -  calculated, these addresses are checked by HW to monitor any
> -  change.  If any memory is modified, a Security Violation is
> -  triggered (see SNVS definition).
> -
> -
> -  - compatible
> -      Usage: required
> -      Value type: <string>
> -      Definition: Must include "fsl,sec-v4.0-rtic".
> -
> -   - #address-cells
> -       Usage: required
> -       Value type: <u32>
> -       Definition: A standard property.  Defines the number of cells
> -           for representing physical addresses in child nodes.  Must
> -           have a value of 1.
> -
> -   - #size-cells
> -       Usage: required
> -       Value type: <u32>
> -       Definition: A standard property.  Defines the number of cells
> -           for representing the size of physical addresses in
> -           child nodes.  Must have a value of 1.
> -
> -  - reg
> -      Usage: required
> -      Value type: <prop-encoded-array>
> -      Definition: A standard property.  Specifies a two parameters:
> -          an offset from the parent physical address and the length
> -          the SEC4 registers.
> -
> -   - ranges
> -       Usage: required
> -       Value type: <prop-encoded-array>
> -       Definition: A standard property.  Specifies the physical address
> -           range of the SEC 4 register space (-SNVS not included).  A
> -           triplet that includes the child address, parent address, &
> -           length.
> -
> -EXAMPLE
> -       rtic@6000 {
> -               compatible =3D "fsl,sec-v4.0-rtic";
> -               #address-cells =3D <1>;
> -               #size-cells =3D <1>;
> -               reg =3D <0x6000 0x100>;
> -               ranges =3D <0x0 0x6100 0xe00>;
> -       };
> -
> -
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D
> -Run Time Integrity Check (RTIC) Memory Node
> -  A child node that defines individual RTIC memory regions that are used=
 to
> -  perform run-time integrity check of memory areas that should not modif=
ied.
> -  The node defines a register that contains the memory address &
> -  length (combined) and a second register that contains the hash result
> -  in big endian format.
> -
> -  - compatible
> -      Usage: required
> -      Value type: <string>
> -      Definition: Must include "fsl,sec-v4.0-rtic-memory".
> -
> -  - reg
> -      Usage: required
> -      Value type: <prop-encoded-array>
> -      Definition: A standard property.  Specifies two parameters:
> -          an offset from the parent physical address and the length:
> -
> -          1. The location of the RTIC memory address & length registers.
> -          2. The location RTIC hash result.
> -
> -  - fsl,rtic-region
> -       Usage: optional-but-recommended
> -       Value type: <prop-encoded-array>
> -       Definition:
> -           Specifies the HW address (36 bit address) for this region
> -           followed by the length of the HW partition to be checked;
> -           the address is represented as a 64 bit quantity followed
> -           by a 32 bit length.
> -
> -   - fsl,liodn
> -       Usage: optional-but-recommended
> -       Value type: <prop-encoded-array>
> -       Definition:
> -           Specifies the LIODN to be used in conjunction with
> -           the ppid-to-liodn table that specifies the PPID to LIODN
> -           mapping.  Needed if the PAMU is used.  Value is a 12 bit valu=
e
> -           where value is a LIODN ID for this RTIC memory region. This
> -           property is normally set by boot firmware.
> -
> -EXAMPLE
> -       rtic-a@0 {
> -               compatible =3D "fsl,sec-v4.0-rtic-memory";
> -               reg =3D <0x00 0x20 0x100 0x80>;
> -               fsl,liodn   =3D <0x03c>;
> -               fsl,rtic-region  =3D <0x12345678 0x12345678 0x12345678>;
> -       };
> -
> -
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D
> -Secure Non-Volatile Storage (SNVS) Node
> -
> -    Node defines address range and the associated
> -    interrupt for the SNVS function.  This function
> -    monitors security state information & reports
> -    security violations. This also included rtc,
> -    system power off and ON/OFF key.
> -
> -  - compatible
> -      Usage: required
> -      Value type: <string>
> -      Definition: Must include "fsl,sec-v4.0-mon" and "syscon".
> -
> -  - reg
> -      Usage: required
> -      Value type: <prop-encoded-array>
> -      Definition: A standard property.  Specifies the physical
> -          address and length of the SEC4 configuration
> -          registers.
> -
> -   - #address-cells
> -       Usage: required
> -       Value type: <u32>
> -       Definition: A standard property.  Defines the number of cells
> -           for representing physical addresses in child nodes.  Must
> -           have a value of 1.
> -
> -   - #size-cells
> -       Usage: required
> -       Value type: <u32>
> -       Definition: A standard property.  Defines the number of cells
> -           for representing the size of physical addresses in
> -           child nodes.  Must have a value of 1.
> -
> -   - ranges
> -       Usage: required
> -       Value type: <prop-encoded-array>
> -       Definition: A standard property.  Specifies the physical address
> -           range of the SNVS register space.  A triplet that includes
> -           the child address, parent address, & length.
> -
> -   - interrupts
> -      Usage: optional
> -      Value type: <prop_encoded-array>
> -      Definition:  Specifies the interrupts generated by this
> -           device.  The value of the interrupts property
> -           consists of one interrupt specifier. The format
> -           of the specifier is defined by the binding document
> -           describing the node's interrupt parent.
> -
> -EXAMPLE
> -       sec_mon@314000 {
> -               compatible =3D "fsl,sec-v4.0-mon", "syscon";
> -               reg =3D <0x314000 0x1000>;
> -               ranges =3D <0 0x314000 0x1000>;
> -               interrupt-parent =3D <&mpic>;
> -               interrupts =3D <93 2>;
> -       };
> -
> -
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D
> -Secure Non-Volatile Storage (SNVS) Low Power (LP) RTC Node
> -
> -  A SNVS child node that defines SNVS LP RTC.
> -
> -  - compatible
> -      Usage: required
> -      Value type: <string>
> -      Definition: Must include "fsl,sec-v4.0-mon-rtc-lp".
> -
> -  - interrupts
> -      Usage: required
> -      Value type: <prop_encoded-array>
> -      Definition: Specifies the interrupts generated by this
> -          device.  The value of the interrupts property
> -          consists of one interrupt specifier. The format
> -          of the specifier is defined by the binding document
> -          describing the node's interrupt parent.
> -
> - - regmap
> -       Usage: required
> -       Value type: <phandle>
> -       Definition: this is phandle to the register map node.
> -
> - - offset
> -       Usage: option
> -       value type: <u32>
> -       Definition: LP register offset. default it is 0x34.
> -
> -   - clocks
> -      Usage: optional, required if SNVS LP RTC requires explicit
> -          enablement of clocks
> -      Value type: <prop_encoded-array>
> -      Definition:  a clock specifier describing the clock required for
> -          enabling and disabling SNVS LP RTC.
> -
> -   - clock-names
> -      Usage: optional, required if SNVS LP RTC requires explicit
> -          enablement of clocks
> -      Value type: <string>
> -      Definition: clock name string should be "snvs-rtc".
> -
> -EXAMPLE
> -       sec_mon_rtc_lp@1 {
> -               compatible =3D "fsl,sec-v4.0-mon-rtc-lp";
> -               interrupts =3D <93 2>;
> -               regmap =3D <&snvs>;
> -               offset =3D <0x34>;
> -               clocks =3D <&clks IMX7D_SNVS_CLK>;
> -               clock-names =3D "snvs-rtc";
> -       };
> -
> -
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D
> -System ON/OFF key driver
> -
> -  The snvs-pwrkey is designed to enable POWER key function which control=
led
> -  by SNVS ONOFF, the driver can report the status of POWER key and wakeu=
p
> -  system if pressed after system suspend.
> -
> -  - compatible:
> -      Usage: required
> -      Value type: <string>
> -      Definition: Mush include "fsl,sec-v4.0-pwrkey".
> -
> -  - interrupts:
> -      Usage: required
> -      Value type: <prop_encoded-array>
> -      Definition: The SNVS ON/OFF interrupt number to the CPU(s).
> -
> -  - linux,keycode:
> -      Usage: option
> -      Value type: <int>
> -      Definition: Keycode to emit, KEY_POWER by default.
> -
> -  - wakeup-source:
> -      Usage: option
> -      Value type: <boo>
> -      Definition: Button can wake-up the system.
> -
> - - regmap:
> -      Usage: required:
> -      Value type: <phandle>
> -      Definition: this is phandle to the register map node.
> -
> -EXAMPLE:
> -       snvs-pwrkey@020cc000 {
> -               compatible =3D "fsl,sec-v4.0-pwrkey";
> -               regmap =3D <&snvs>;
> -               interrupts =3D <0 4 0x4>
> -               linux,keycode =3D <116>; /* KEY_POWER */
> -               wakeup-source;
> -       };
> -
> -
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D
> -FULL EXAMPLE
> -
> -       crypto: crypto@300000 {
> -               compatible =3D "fsl,sec-v4.0";
> -               #address-cells =3D <1>;
> -               #size-cells =3D <1>;
> -               reg =3D <0x300000 0x10000>;
> -               ranges =3D <0 0x300000 0x10000>;
> -               interrupt-parent =3D <&mpic>;
> -               interrupts =3D <92 2>;
> -
> -               sec_jr0: jr@1000 {
> -                       compatible =3D "fsl,sec-v4.0-job-ring";
> -                       reg =3D <0x1000 0x1000>;
> -                       interrupt-parent =3D <&mpic>;
> -                       interrupts =3D <88 2>;
> -               };
> -
> -               sec_jr1: jr@2000 {
> -                       compatible =3D "fsl,sec-v4.0-job-ring";
> -                       reg =3D <0x2000 0x1000>;
> -                       interrupt-parent =3D <&mpic>;
> -                       interrupts =3D <89 2>;
> -               };
> -
> -               sec_jr2: jr@3000 {
> -                       compatible =3D "fsl,sec-v4.0-job-ring";
> -                       reg =3D <0x3000 0x1000>;
> -                       interrupt-parent =3D <&mpic>;
> -                       interrupts =3D <90 2>;
> -               };
> -
> -               sec_jr3: jr@4000 {
> -                       compatible =3D "fsl,sec-v4.0-job-ring";
> -                       reg =3D <0x4000 0x1000>;
> -                       interrupt-parent =3D <&mpic>;
> -                       interrupts =3D <91 2>;
> -               };
> -
> -               rtic@6000 {
> -                       compatible =3D "fsl,sec-v4.0-rtic";
> -                       #address-cells =3D <1>;
> -                       #size-cells =3D <1>;
> -                       reg =3D <0x6000 0x100>;
> -                       ranges =3D <0x0 0x6100 0xe00>;
> -
> -                       rtic_a: rtic-a@0 {
> -                               compatible =3D "fsl,sec-v4.0-rtic-memory"=
;
> -                               reg =3D <0x00 0x20 0x100 0x80>;
> -                       };
> -
> -                       rtic_b: rtic-b@20 {
> -                               compatible =3D "fsl,sec-v4.0-rtic-memory"=
;
> -                               reg =3D <0x20 0x20 0x200 0x80>;
> -                       };
> -
> -                       rtic_c: rtic-c@40 {
> -                               compatible =3D "fsl,sec-v4.0-rtic-memory"=
;
> -                               reg =3D <0x40 0x20 0x300 0x80>;
> -                       };
> -
> -                       rtic_d: rtic-d@60 {
> -                               compatible =3D "fsl,sec-v4.0-rtic-memory"=
;
> -                               reg =3D <0x60 0x20 0x500 0x80>;
> -                       };
> -               };
> -       };
> -
> -       sec_mon: sec_mon@314000 {
> -               compatible =3D "fsl,sec-v4.0-mon";
> -               reg =3D <0x314000 0x1000>;
> -               ranges =3D <0 0x314000 0x1000>;
> -
> -               sec_mon_rtc_lp@34 {
> -                       compatible =3D "fsl,sec-v4.0-mon-rtc-lp";
> -                       regmap =3D <&sec_mon>;
> -                       offset =3D <0x34>;
> -                       interrupts =3D <93 2>;
> -                       clocks =3D <&clks IMX7D_SNVS_CLK>;
> -                       clock-names =3D "snvs-rtc";
> -               };
> -
> -               snvs-pwrkey@020cc000 {
> -                       compatible =3D "fsl,sec-v4.0-pwrkey";
> -                       regmap =3D <&sec_mon>;
> -                       interrupts =3D <0 4 0x4>;
> -                       linux,keycode =3D <116>; /* KEY_POWER */
> -                       wakeup-source;
> -               };
> -       };
> -
> -
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D
> --
> 2.39.1

